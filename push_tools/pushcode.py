#!/usr/bin/python
#coding=utf-8
import os
import sys
import re
import glob
import commands
import datetime
import tempfile
import time
import codecs
import pexpect
import getpass
#import readline

reload(sys)  
sys.setdefaultencoding('utf8')
import readline

NumSequence = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'

class Config:
	__confdict = {'ask':'0', 'showkey':'yes', 'configfile':''}
	module = None

	def __init__(self, module=None):
		self.module = module

	def addFromArg(self, arglist):
		if len(arglist) % 2 != 0:
			print "Error: arg number should be even"
			sys.exit(1)
		for i in range(len(arglist)/2):
			if arglist[i*2][0] != '-':
				print "Error: arg "+ arglist[i*2]
				sys.exit(1)
			elif arglist[i*2+1][0] == '-':
				print "Error: arg "+ arglist[i*2+1]
				sys.exit(1)
			else:
				if arglist[i*2][1:] != 'nokey':
					Config.__confdict[arglist[i*2][1:]] = arglist[i*2+1]
		if Config.__confdict['configfile']:
			loadConfigFromFile(argDict['configfile'])

	def loadConfigFromFile(self, fileName, override=False):
		fileConfig = open(fileName, 'r')
		for line in fileConfig.readlines():
			line.strip()
			line = re.sub('#.*', '', line)
			itemList = re.split('=', line, 1)
			if len(itemList) == 2:
				key,value = itemList
				key = key.strip()
				value = value.strip()
				if value[-1] == '!':
					value = value[:-1].strip()
					force = True
				else:
					force = False
				if force == True or override == True or key not in Config.__confdict.keys():
					if key != 'nokey':
						Config.__confdict[key] = value
		fileConfig.close()

	def __checkInLineConf(self, value):
		if value != '':
			valList = re.split('\^', value)
			for oneVal in valList[1:]:
				askList = re.split('\s*=\s*', oneVal.strip(), 1)
				if len(askList) > 1:
					key = askList[0].strip()
					if self.module and key != 'ask' and key != 'nokey':
						key = self.module+'.'+key
					if key != 'nokey':
						Config.__confdict[key] = askList[1].strip()
			return valList[0].strip()
		else:
			return value

	def __checkInputValue(self, value, pattern):
		if pattern:
			if re.match(pattern, value):
				return True
			else:
				return False
		else:
			if value != '':
				return True
			else:
				return False

	def __saveItemToFile(self, itemKey, itemValue, fileName):
		tmpConfigDict = {}
		if os.path.isfile(fileName):
			fileConfig = open(fileName, 'r')
			for line in fileConfig.readlines():
				line.strip()
				line = re.sub('#.*', '', line)
				itemList = re.split('=', line, 1)
				if len(itemList) == 2:
					key,value = itemList
					key = key.strip()
					value = value.strip()
					if value[-1] == '!':
						value = value[:-1].strip()
					if key != 'nokey':
						tmpConfigDict[key] = value
			fileConfig.close()
		tmpConfigDict[itemKey] = itemValue
		fileConfig = open(fileName, 'w+')
		for key,value in tmpConfigDict.items():
			fileConfig.write('%s = %s\n' % (key, value))
		fileConfig.close()
		return itemValue

	def getConf(self, key, prompt, default='', ask=None, save=None, echo=True, maxask=3):
		if self.module and key != 'ask' and key != 'nokey':
			key = self.module+'.'+key

		if Config.__confdict['showkey'] == 'yes':
			showKey = '('+key+') '
		else:
			showKey = ''

		match = re.search('<\s*([\w\|]+)\s*>$', prompt)
		if match:
			rangeList = match.group(1).split('|')
		else:
			rangeList = []

		regMatch = re.search('{(.+)}$', prompt)
		if regMatch:
			pattern = regMatch.group(1)
		else:
			pattern = None

		if ask:
			ask = str(ask)
		else:
			ask = Config.__confdict['ask']

		if ask == '0':
			if key in Config.__confdict:
				if save:
					self.__saveItemToFile(key, Config.__confdict[key], save)
				return Config.__confdict[key]
			elif default != '':
				if key != 'nokey':
					Config.__confdict[key] = default
				if save:
					self.__saveItemToFile(key, default, save)
				return default
			else:
				while True:
					if maxask <= 0:
						print "\nArg error. Exit ..."
						sys.exit(1)
					maxask -= 1
					#sys.stdout.write('%s%s : ' % (showKey, prompt))
					value = self.__checkInLineConf(raw_input('%s%s : ' % (showKey, prompt)).strip() if echo else getpass.getpass('').strip())
					if match:
						if value in rangeList:
							break
					else:
						if self.__checkInputValue(value, pattern):
							break
				if key != 'nokey':
					Config.__confdict[key] = value
				if save:
					self.__saveItemToFile(key, value, save)
				return value
		elif ask == '1':
			if key in Config.__confdict:
				return Config.__confdict[key]
			elif default != '':
				while True:
					if maxask <= 0:
						print "Arg err. Exit ..."
						sys.exit(1)
					maxask -= 1
					#sys.stdout.write('%s%s [%s]: ' % (showKey, prompt, default))
					value = self.__checkInLineConf(raw_input('%s%s : ' % (showKey, prompt)).strip() if echo else getpass.getpass('').strip())
					if value == '':
						value = default
					if match:
						if value in rangeList:
							break
					else:
						if self.__checkInputValue(value, pattern):
							break
				if key != 'nokey':
					Config.__confdict[key] = value
				if save:
					self.__saveItemToFile(key, value, save)
				return value
			else:
				while True:
					if maxask <= 0:
						print "Arg err. Exit ..."
						sys.exit(1)
					maxask -= 1
					#sys.stdout.write('%s%s : ' % (showKey, prompt))
					value = self.__checkInLineConf(raw_input('%s%s : ' % (showKey, prompt)).strip() if echo else getpass.getpass('').strip())
					if match:
						if value in rangeList:
							break
					else:
						if self.__checkInputValue(value, pattern):
							break
				if key != 'nokey':
					Config.__confdict[key] = value
				if save:
					self.__saveItemToFile(key, value, save)
				return value
		else:
			if key in Config.__confdict:
				default = Config.__confdict[key]
			if default != '':
				while True:
					if maxask <= 0:
						print "Arg err. Exit ..."
						sys.exit(1)
					maxask -= 1
					#sys.stdout.write('%s%s [%s]: ' % (showKey, prompt, default))
					value = self.__checkInLineConf(raw_input('%s%s : ' % (showKey, prompt)).strip() if echo else getpass.getpass('').strip())
					if value == '':
						value = default
					if match:
						if value in rangeList:
							break
					else:
						if self.__checkInputValue(value, pattern):
							break
				if key != 'nokey':
					Config.__confdict[key] = value
				if save:
					self.__saveItemToFile(key, value, save)
				return value
			else:
				while True:
					if maxask <= 0:
						print "Arg err. Exit ..."
						sys.exit(1)
					maxask -= 1
					#sys.stdout.write('%s%s : ' % (showKey, prompt))
					value = self.__checkInLineConf(raw_input('%s%s : ' % (showKey, prompt)).strip() if echo else getpass.getpass('').strip())
					if match:
						if value in rangeList:
							break
					else:
						if self.__checkInputValue(value, pattern):
							break
				if key != 'nokey':
					Config.__confdict[key] = value
				if save:
					self.__saveItemToFile(key, value, save)
				return value

	def dumpConf(self):
		return Config.__confdict

	def dumpConfPretty(self):
		strDump = 'Config:\n'
		for (key, var) in Config.__confdict.items():
			strDump += '    %s => %s\n' % (key, var)
		strDump += '\nCurrent dir: %s\n' % os.getcwd()
		return strDump

class Functions(object):
	def __init__(self):
		self.curDir =  os.getcwd()
		self.conf=Config()
		self.branchL=[]
		self.branchR=[]
		self.username=[]
		self.useremail=[]

	def getmodulepath (self):
		result=commands.getstatusoutput("git remote -v")
		#print result
		modulepath= None
		if result[0] >> 8 != 0:
			print "get remote message error!!\n"
			sys.exit(1);
		for line in result[1].split('\n'):
			url = line.strip().split()[1]
			str=url
			if str.startswith('git@'):
				modulepath = url.split(':')[1]
				break
			if str.startswith('ssh:'):
				modulepath = url.split('29418')[1]
				break
		if modulepath == None:
			print "#	Not a git repository\n"
			print "#	Make sure you are in the right directory\n"
			sys.exit(1)
		else:
			return modulepath
	
	def getusername (self):
		result=commands.getstatusoutput("git config -l")
		username = None
		if result[0] >> 8 != 0:
			print "get remote username message error!!\n"
			sys.exit(1);
		for line in result[1].split('\n'):
			line = line.strip()
			str=line
			if str.startswith('user.name'):
				username = line.split('=')[1]
				break
		if username == None:
			print "#	please set default git config:\n"
			print "#	git config --global user.name  YourName\n"
			print "#	git config --global user.email YourName@example.com\n"
			sys.exit(1)
		else:
			self.username=username
			return username

	def getuseremail (self):
		result=commands.getstatusoutput("git config -l")
		useremail = None
		if result[0] >> 8 != 0:
			print "get config useremail message error!!\n"
			sys.exit(1);
		for line in result[1].split('\n'):
			line = line.strip()
			str=line
			if str.startswith('user.email'):
				useremail = line.split('=')[1]
				break
		if useremail == None:
			print "#	please set default git config:\n"
			print "#	git config --global user.name  YourName\n"
			print "#	git config --global user.email YourName@example.com\n"
			sys.exit(1)
		else:
			self.useremail=useremail
			return useremail

	def getlocalbranch (self):
		result=commands.getstatusoutput("git branch")
		useremail = None
		if result[0] >> 8 != 0:
			print "get local branch error!!\n"
			sys.exit(1);	
		for line in result[1].split('\n'):
			line = line.strip()
			str=line
			if str.startswith('*'):
				self.branchL.append(line.split()[1])
			else:
				self.branchL.append(line)
		#print self.branchL
		index=0
		print "##  Local branch List:"
		for i in self.branchL:
			print NumSequence[index+1]+') '+i
			index=index+1
		if index == 0:
			print "#	No branch can be use,please create a local branch !!\n "
			sys.exit(1)
		else:
			branchnum=self.conf.getConf('LocalBranch', '请选择要提交的本地分支编号')
			if len(branchnum) == 1:
				if  NumSequence.index(branchnum) > index:
					print "input wrong branch number!!\n"
					sys.exit(1)
				if  NumSequence.index(branchnum) == 0:
					print "input wrong branch number!!\n"
					sys.exit(1)
			else:
				print "input wrong branch number!!\n"
				sys.exit(1)
			localbranch=None
			localbranch=self.branchL[NumSequence.index(branchnum)-1]
			if not localbranch ==None:
				return localbranch
			else:
				print "can not get local branch!!\n"
				sys.exit(1)

	def getremotebranch (self):
		result=commands.getstatusoutput("git branch -a")
		useremail = None
		if result[0] >> 8 != 0:
			print "get local branch error!!\n"
			sys.exit(1);	
		for line in result[1].split('\n'):
			line = line.strip()
			str=line
			if str.startswith('remotes/origin/'):
				self.branchR.append(line.split('/')[2])
			#else:
			#	self.branchL.append(line)
		#print self.branchL
		index=0
		print "##  Remote branch List:"
		for i in self.branchR:
			print NumSequence[index+1]+') '+i
			index=index+1
		if index == 0:
			print "#	No branch can be use,please check code server !\n "
			sys.exit(1)
		else:
			branchnum=self.conf.getConf('RemoteBranch', '请选择远程分支编号')
			if len(branchnum) == 1:
				if  NumSequence.index(branchnum) > index:
					print "input wrong branch number!!\n"
					sys.exit(1)
				if  NumSequence.index(branchnum) == 0:
					print "input wrong branch number!!\n"
					sys.exit(1)
			else:
				print "input wrong branch number!!\n"
				sys.exit(1)
			remotebranch=None
			remotebranch=self.branchR[NumSequence.index(branchnum)-1]
			if not remotebranch ==None:
				return remotebranch
			else:
				print "can not get local branch\n"
				sys.exit(1)
##
	def rebasecode (self):
		fetchcmd='git pull'
		#print fetchcmd
		result=commands.getstatusoutput(fetchcmd)
		if result[0] >> 8 != 0:
			print "Rebase code error,please fix the confilcts first\n"
			for line in result[1].split('\n'):
				line = line.strip()
				print "	"+line
			sys.exit(1);
	def getlastcommitid (self):
		logcmd='git log -1'
		commitid=[]
		print logcmd
		result=commands.getstatusoutput(logcmd)
		if result[0] >> 8 != 0:
			print "Get last commit log fail\n"
			for line in result[1].split('\n'):
				line = line.strip()
				print "	"+line
			sys.exit(1);
		for line in result[1].split('\n'):
			match = re.match('^commit\s(.+)', line)
			if match:
				commitid=match.group(1).strip()
		return commitid
					
			
				
	def commitcode (self):
	
		commitmsg=self.conf.getConf('Commit Message', '请输入提交信息')
		committype=self.conf.getConf('Type', '请选择修改类型，平台（0），项目（1），客户（2）')
		if not (committype == '0' or committype == '1' or committype == '2'):
			print "输入错误，请重新选择\n"
			sys.exit(1);
		bugID=self.conf.getConf('BUGID', '请输入对应问题的BUG ID（无输入NO）')
		testPopint=self.conf.getConf('Test', '请输入测试重点（无输入NO）')
		effectmodule=self.conf.getConf('Module', '请输入影响范围（模块）（无输入NO）')


		#lastCommitId =self.getlastcommitid()

		commitMessage=[]

		commitMessage='%s	' % commitmsg

		if committype == '0':
			commitMessage ='%s\nType:	平台' % commitMessage
		elif committype == '1':
			commitMessage ='%s\nType:	项目' % commitMessage
		elif committype == '2':
			commitMessage ='%s\nType:	客户' % commitMessage

		if not bugID.lower() == 'no':
			commitMessage ='%s\nBUG-ID:	%s' % (commitMessage,bugID)
		if not testPopint.lower() == 'no':
			commitMessage ='%s\nTestPoint:	%s' % (commitMessage,testPopint)
		if not effectmodule.lower() == 'no':
			commitMessage ='%s\nEffectModule:	%s' % (commitMessage,effectmodule)		
		##
		commitcmd='git commit -m "%s"' % commitMessage
		result=commands.getstatusoutput(commitcmd)
		if result[0] >> 8 != 0:
			print "git commit error\n"
			for line in result[1].split('\n'):
				line = line.strip()
				print "	"+line
			sys.exit(1);
##
	def pushtoserver(self,modulepath,lbranch,rbranch,name,email):
		print "## Please check your commit Message:\n"
		print "	  Your Name:      %s" % name
		print "	  Your Email:     %s" % email
		print "	  Local Branch:   %s" % lbranch
		print "	  Remote Branch:  %s" % rbranch
		print "	  Module Path:    %s" % modulepath
		str=modulepath.strip()
		if str.startswith('/'):
			modulepath=modulepath[1:] 
		submit=self.conf.getConf('Submit', 'Are you sure to commit to Git Server?  (yes|no)')
		if submit == "yes":		
			#result=commands.getstatusoutput("git push ssh://192.168.8.201:29418%s %s:refs/for/%s") % (modulepath,lbranch,rbranch)
			pushcmd = 'git push ssh://%s@192.168.8.201:29418/%s %s:refs/for/%s --tags' % (name,modulepath,lbranch,rbranch)
			print pushcmd
			result=commands.getstatusoutput(pushcmd)
			if result[0] >> 8 != 0:
				print "	Push to Gerrit error\n"
				for line in result[1].split('\n'):
					line = line.strip()
					print "	"+line
				sys.exit(1);
			##push Success
			for line in result[1].split('\n'):
				line = line.strip()
				print "	"+line
			print "Push to Gerrit success ,Please contact your leader to review your code."
				
		else :
			print '#\n	You choose not to Submit this time !\n'
		
		
		

def main():
	fu=Functions()
	modulepath=fu.getmodulepath()
	username=fu.getusername()
	useremail=fu.getuseremail()
	#print modulepath
	#print username
	#print useremail
	localbranch=fu.getlocalbranch()
	remotebranch=fu.getremotebranch()
	#print localbranch
	#print remotebranch
	#fu.rebasecode()
	fu.commitcode()
	fu.pushtoserver(modulepath,localbranch,remotebranch,username,useremail)
	

if __name__ == '__main__':
	main()
