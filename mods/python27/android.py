__author__ = 'Vasiliy Solovey <miltador@yandex.ua>'

import collections
import os
import sys

from psutil import virtual_memory

PORT = os.environ.get('AP_PORT')
HOST = os.environ.get('AP_HOST')
HANDSHAKE = os.environ.get('AP_HANDSHAKE')
Result = collections.namedtuple('Result', 'id,result,error')

# Set of methods that emulate RPC responses from Android process
class Android(object):
  def __init__(self,addr=None):
    pass

  @staticmethod
  # authentication check? true - authed?
  def _authenticate(args):
    return True

  @staticmethod
  # path to store logs and .ACEStream ?
  def getAceStreamHome():
    return os.path.abspath(os.path.dirname(sys.argv[0]))

  @staticmethod
  def getDisplayLanguage():
    return 'українська'

  @staticmethod
  # this seems to be used memory by Android process
  def getTotalMemory():
    return virtual_memory().free

  @staticmethod
  # and this seems to be available memory for process
  def getMaxMemory():
    return virtual_memory().available

  @staticmethod
  # don't have an idea what is it
  def getMemoryClass():
    return 256

  @staticmethod
  # TODO: randomize?
  def getDeviceId():
    return 'd3efefe5-4ce4-345b-adb6-adfa3ba92eab'

  @staticmethod
  # TODO: figure out what is it
  def getAvailableBlocks(args):
    return 2390083

  @staticmethod
  # TODO: block size of what? looks like partition block size?
  def getBlockSize(args):
    return 4096

  @staticmethod
  # TODO: figure out what is it
  def getBlockCount(args):
    return 6692101

  @staticmethod
  def makeToast(msg):
    print msg

  @staticmethod
  # deprecated?
  def getDeviceName():
    return "Linux Generic Device"

  @staticmethod
  # deprecated?
  def getDeviceModel():
    return str(os.uname())

  @staticmethod
  # deprecated?
  def getDeviceProductName():
    return "Linux Generic"

  @staticmethod
  # stub
  def onEPGUpdated():
    pass
