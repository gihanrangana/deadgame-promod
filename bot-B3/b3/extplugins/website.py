__version__ = '1.0'
__author__  = 'Spoon'

import b3, re, traceback, sys, threading
import b3.events
import b3.plugin
import re

from b3 import functions
#--------------------------------------------------------------------------------------------------
class WebsitePlugin(b3.plugin.Plugin):
    _adminPlugin = None

    def onStartup(self):
        self._adminPlugin = self.console.getPlugin('admin')
        if not self._adminPlugin:
            return False
        #SET COMMAND LEVEL HERE
        self.registerEvent(b3.events.EVT_CLIENT_SAY)
        self.registerEvent(b3.events.EVT_CLIENT_TEAM_SAY)

    def onLoadConfig(self):
        self.debug('getting config now')
        try:
            self._maxLevel = self.config.getint('settings', 'max_level')
        except:
            self.error('config missing [settings].maxlevel')
        try:
            self._duration = self.config.get('settings', 'duration')
        except:
            self.error('config missing [settings].duration')
        try:
            self._message = self.config.get('settings', 'message')
        except:
            self.error('config missing [settings].message')

    def check_for_website(self, client, text):
        originalword = text
        # ipaddress = re.findall(r"(?:\s|\A)(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})(?=\s|\Z)", text)
        ipaddress = re.findall(r"(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})", text)
        ipaddress = list(filter(lambda x: all([int(y) <= 255 for y in x.split('.')]), ipaddress))
        if (len(ipaddress) > 0):
            self.said_website( client, text)
        text = text.replace('.com', '')
        text = text.replace('.net', '')
        text = text.replace('.info', '')
        text = text.replace('.xyz', '')
        text = text.replace('.tk', '')
        text = text.replace('.ga', '')
        text = text.replace('.cf', '')
        text = text.replace('.lk', '')
        if (text == originalword):
            return False
        else:
            self.said_website( client, text)

    def said_website(self, client, text):
        originalword = text
        text = text.replace('209.58.172.57', '')
        text = text.replace('139.99.88.177', '')
        text = text.replace('51.79.251.43', '')
        text = text.replace('machannoob', '')
        text = text.replace('machanoob', '')
        text = text.replace('machnoob', '')
        text = text.replace('mchannoob', '')
        text = text.replace('machnnoob', '')
        text = text.replace('mchanoob', '')
        text = text.replace('deadgame', '')
        if (text != originalword):
            return False
        else:
            message = self._message
            duration = self._duration
            keyword = 'None'
            textlen = len(text)
            if (textlen > 15):
                keyword = text[0:15]
            else: 
                keyword = text
            client.tempban(message, keyword, duration, client)
            #self._adminPlugin.tempbanClient(client, self._message, None, False, '', self._duration)

    def onEvent(self, event):
        if not event.client or event.client.maxLevel >= self._maxLevel:
            return
        if event.type == b3.events.EVT_CLIENT_SAY or event.type == b3.events.EVT_CLIENT_TEAM_SAY:
            self.check_for_website(event.client,event.data)

