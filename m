Return-Path: <malas@tcoe.iitm.ac.in>
From: "malas" <malas@tcoe.iitm.ac.in>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: ad7793 iio-ring test read issue - Reg
Date: Tue, 23 Aug 2011 18:54:21 +0530
Message-Id: <20110823131000.M76209@tcoe.iitm.ac.in>
In-Reply-To: <4E53A3FA.7020700@cam.ac.uk>
References: <20110823080829.M36921@tcoe.iitm.ac.in> <4E538D35.7090508@cam.ac.uk> <20110823112234.M44553@tcoe.iitm.ac.in> <544AC56F16B56944AEC3BD4E3D59177146E6D069A2@LIMKCMBX1.ad.analog.com> <20110823121352.M43006@tcoe.iitm.ac.in> <4E539F70.3060209@cam.ac.uk> <20110823123747.M17135@tcoe.iitm.ac.in> <4E53A3FA.7020700@cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=OPENWEBMAIL_ATT_0.457829457798169"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.

------=OPENWEBMAIL_ATT_0.457829457798169
Content-Type: text/plain;
	charset=iso-8859-1

On Tue, 23 Aug 2011 13:58:34 +0100, Jonathan Cameron wrote
> On 08/23/11 13:43, malas wrote:
> > YES : Gregs updated kernel taken from link below:
> > 
> > http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6.git
> Right now that's pretty much mainline.
> 
> See comments below and please reply inline as it makes this sort
> of discussion much easier to follow.
> > 
> > 
> > On Tue, 23 Aug 2011 13:39:12 +0100, Jonathan Cameron wrote
> >> On 08/23/11 13:17, malas wrote:
> >>>
> >>>
> >>> Sorry, I did not explicitly mention that. I did use the new staging kernel referred by
> >>> Michael Hennerich and integrated with 2010RC5 uclinux dist .
> >>
> >> Hmm. As in current contents of Greg KH's staging/staging-next?
> >>
> >> I'll assume so... See below.
> >>
> >>>
> >>> On Tue, 23 Aug 2011 12:39:53 +0100, Hennerich, Michael wrote
> >>>> malas wrote on 2011-08-23:
> >>>>>
> >>>>>
> >>>>> Dear Jonathan Cameron,
> >>>>>
> >>>>> The kernel version I am using is :
> >>>>
> >>>> Didn't you say that you use the staging kernel?
> >>>>
> >>>>
> >>>
> >
http://blackfin.uclinux.org/gf/project/uclinux-dist/forum/?_forum_action=MessageReply&message_id=102839&action=ForumBrowse
> >>>>
> >>>> Or copied drivers/staging/iio over to your Blackfin kernel tree?
> >>>>
> >>>>>
> >>>>> ---------------------------------------------------------------------
> >>>>> midas@ubuntu:~/Mala/Telemedicine/uclinux_source/uc2010_source/uclinux/2
> >>>>> 010R1$ svn info Path: . URL:
> >>>>> svn://blackfin.uclinux.org/uclinux-dist/branches/2010R1 Repository Root:
> >>>>> svn://blackfin.uclinux.org/uclinux-dist Repository UUID:
> >>>>> 3e2a5524-39e8-4cb9-84a9-c49da69cba3a Revision: 10161 Node Kind:
> >>>>> directory Schedule: normal Last Changed Author: vapier Last Changed Rev:
> >>>>> 10136 Last Changed Date: 2011-04-02 22:36:15 +0530 (Sat, 02 Apr 2011)
> >>>>> ---------------------------------------------------------------------
> >>>>>
> >>>>> Regards
> >>>>> Mala
> >>>>>
> >>>>> On Tue, 23 Aug 2011 12:21:25 +0100, Jonathan Cameron wrote
> >>>>>> On 08/23/11 09:18, malas wrote:
> >>>>>>>
> >>>>>>> Dear Michael Hennerich,
> >>>>>>>
> >>>>>>>
> >>>>>>> I shall post iio quesris in this mail list as per your suggestions.
> >>>>>>>
> >>>>>>> AD7793 driver is built into kernel. The chip gets configured and am
> >>>>>>> able to read data on continuous mode via spi interface using ad7793
> >>>>>>> driver at kernel level.
> >>>>>>>
> >>>>>>> While testing userspace test iio-ring to read data from ring buffer,
> >>>>>>> generic_buffer code was executed, it  proceeds till opening
> >>>>>>> /sys/bus/iio/devices/device0:buffer0 and Read call fails.
> >>>>>> Question 1: What's the kernel and where did you get it from?
> >>>>>> (Interfaces are moving fast so it's plausible you've fallen in a hole
> >>>>>> where userspace wasn't matching kernelspace).
> >>>>>>>
> >>>>>>> In fs I can list the iio device ad7793 with following properties
> >>>>>>> get/set.
> >>>>>>>
> >>>>>>> root:/> ls /sys/bus/iio/devices/device0\:buffer0/
> >>>>>>> bytes_per_datum  enable           power            subsystem
> >>>>>>> dev              length           scan_elements    uevent
> >>>>>>> root:/>
> >>>>>>>
> >>>>>>> I find access0 and event0 missing in this list. Is that the reason
> >>>>> for read() fails.
> >>>>>> Yes.  Question is why and without kernel version I don't know where to
> >>>>>> look I'm afraid.
> >> Ah, this does look like a missmatch in interfaces between userspace and kernel.
> >>
> >> At this point in time we have scrapped the event0 chrdev (done via polling on
> >> the access one) and the access one has be flattened into device0\:buffer0/
> >> (read dev).
> >>
> >> Looks like the generic_buffer.c example does line up though. Where did the
> >> 'test iio-ring' come from? Is that one yours Michael? 


iio-ring.c under uclinux2010/user/blkfin-test/iio-ring-test. The file is in the
attached. I did not use that since i didn't find access0 or event0 files under
/sys/bus/iio/devices/device0:buffer0.

I have tested with the generic_buffer.c example (under iio/documentaion folder) to get
Ad7793 received samples to user space from ring buffer.
The app opens: /dev/device0:buffer0 for poll and reading samples.
Is the device name for the open() correct.


> >>>>>>
> >>>>>>>
> >>>>>>> Please help.
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>> Mala
> >>>>>>> --
> >>>>>>> Open WebMail Project (http://openwebmail.org)
> >>>
> > 
> > 
> > --
> > Open WebMail Project (http://openwebmail.org)
> > 
> > 
> > 
> >


--
Open WebMail Project (http://openwebmail.org)




------=OPENWEBMAIL_ATT_0.457829457798169
Content-Type: text/x-csrc;
	name="iio-ring.c"
Content-Disposition: attachment; filename="iio-ring.c"
Content-Transfer-Encoding: base64

LyoKICogQW5hbG9nIERldmljZXMgSUlPIGRldmljZXMgcmluZyB0ZXN0IHBy
b2dyYW0KICoKICogQXV0aG9yOiAgICAgICBCYXJyeSBTb25nCiAqIGJhc2Vk
IG9uOgogKiAJSm9uYXRoYW4gQ2FtZXJvbidzIEluZHVzdHJpYWxpbyByaW5n
IGJ1ZmZlciB3aXRoIGEgbGlzM2wwMmRxIGFjY2VsZXJvbWV0ZXIKICoKICog
VGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQKICogdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIg
YXMgcHVibGlzaGVkIGJ5CiAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24uCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBwcmltYXJpbHkgaW50ZW5kZWQg
YXMgYW4gZXhhbXBsZSBhcHBsaWNhdGlvbi4KICovCgojaW5jbHVkZSA8ZGly
ZW50Lmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3RkaW8uaD4K
I2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5j
bHVkZSA8c3lzL2Rpci5oPgojaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KI2lu
Y2x1ZGUgPHVuaXN0ZC5oPgoKI2luY2x1ZGUgImlpb191dGlscy5oIgoKI2Rl
ZmluZSBJSU9fVFNUX0RCRwoKY2hhciBkZXZpY2VfbmFtZVtJSU9fTUFYX05B
TUVfTEVOR1RIXTsKY2hhciB0cmlnZ2VyX25hbWVfYmFzZVtJSU9fTUFYX05B
TUVfTEVOR1RIXTsKaW50IG51bV92YWxzOwppbnQgbnVtX2xvb3BzOwpjb25z
dCBpbnQgc2Nhbl90cyA9IDE7CmNvbnN0IGludCBidWZfbGVuID0gMTI4OwoK
Y2hhciogYXJndjA7Ci8qCiAqIENvdWxkIGdldCB0aGlzIGZyb20gcmluZyBi
cHMsIGJ1dCBvbmx5IGFmdGVyIHN0YXJ0aW5nIHRoZSByaW5nCiAqIHdoaWNo
IGlzIGEgYml0IGxhdGUgZm9yIGl0IHRvIGJlIHVzZWZ1bC4KICoKICogVG9k
bzogcmVwbGFjZSB3aXRoIG11Y2ggbW9yZSBnZW5lcmljIHZlcnNpb24gYmFz
ZWQgb24gc2Nhbl9lbGVtZW50cwogKiBkaXJlY3RvcnkuCiAqLwppbnQgc2l6
ZV9mcm9tX3NjYW5tb2RlKGludCBudW1fdmFscywgaW50IHRpbWVzdGFtcCkK
ewoJaWYgKG51bV92YWxzICYmIHRpbWVzdGFtcCkKCQlyZXR1cm4gKCgobnVt
X3ZhbHMqc2l6ZW9mKF9fczE2KSkrc2l6ZW9mKF9fczY0KS0xKSAmIH4oc2l6
ZW9mKF9fczY0KS0xKSkrc2l6ZW9mKF9fczY0KTsKCWVsc2UgaWYgKHRpbWVz
dGFtcCkKCQlyZXR1cm4gODsKCWVsc2UKCQlyZXR1cm4gbnVtX3ZhbHMqc2l6
ZW9mKF9fczE2KTsKfQoKdm9pZCB1c2FnZSh2b2lkKXsKCWZwcmludGYoc3Rk
ZXJyLCAidXNhZ2U6JXMgLW4gZGV2aWNlbmFtZSAtYyB2YWx1ZW51bWJlciAt
bCBsb29wdGltZXNcbiIsIGFyZ3YwKTsKCWV4aXQoMSk7Cn0KCmludCBtYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndikKewoJaW50IHJldDsKCWludCBpLCBq
LCBrLCB0b3JlYWQ7CglGSUxFICpmcF9ldjsKCWludCBmcDsKCgljaGFyICp0
cmlnZ2VyX25hbWUsICpkZXZfZGlyX25hbWUsICpidWZfZGlyX25hbWU7Cglj
aGFyICpkYXRhOwoJc2l6ZV90IHJlYWRfc2l6ZTsKCXN0cnVjdCBpaW9fZXZl
bnRfZGF0YSBkYXQ7CglpbnQgZGV2X251bSwgdHJpZ19udW07CglpbnQgYzsK
CgljaGFyICpidWZmZXJfYWNjZXNzLCAqYnVmZmVyX2V2ZW50OwoJY29uc3Qg
Y2hhciAqaWlvX2RpciA9ICIvc3lzL2J1cy9paW8vZGV2aWNlcy8iOwoJaW50
IHNjYW5fc2l6ZTsKCglhcmd2MD0gYXJndlswXTsKCgl3aGlsZSggKGMgPSBn
ZXRvcHQoYXJnYywgYXJndiwgIm46YzpsOiIpKSAhPSAtMSApIHsKCQlzd2l0
Y2ggKGMpIHsKCQljYXNlICduJzoKCQkJc3RyY3B5KGRldmljZV9uYW1lLCBv
cHRhcmcpOwoJCQlzcHJpbnRmKHRyaWdnZXJfbmFtZV9iYXNlLCIlcy1kZXYi
LCBkZXZpY2VfbmFtZSk7CgkJCWJyZWFrOwoJCWNhc2UgJ2MnOiBudW1fdmFs
cyA9IGF0b2kob3B0YXJnKTsgYnJlYWs7CgkJY2FzZSAnbCc6IG51bV9sb29w
cyA9IGF0b2kob3B0YXJnKTsgYnJlYWs7CgkJZGVmYXVsdDogdXNhZ2UoKTsK
CQl9Cgl9CglpZiAoIXNpemVvZihkZXZpY2VfbmFtZSkgfHwgIW51bV92YWxz
IHx8ICFudW1fbG9vcHMpCgkJdXNhZ2UoKTsKCgkvKiBGaW5kIG91dCB3aGlj
aCBpaW8gZGV2aWNlIGlzIHRoZSBhY2NlbGVyb21ldGVyLiAqLwoJZGV2X251
bSA9IGZpbmRfdHlwZV9ieV9uYW1lKGRldmljZV9uYW1lLCAiZGV2aWNlIik7
CglpZiAoZGV2X251bSA8IDApIHsKCQlwcmludGYoIkZhaWxlZCB0byBmaW5k
IHRoZSAlc1xuIiwgZGV2aWNlX25hbWUpOwoJCXJldCA9IC1FTk9ERVY7CgkJ
Z290byBlcnJvcl9yZXQ7Cgl9CglwcmludGYoImlpbyBkZXZpY2UgbnVtYmVy
IGJlaW5nIHVzZWQgaXMgJWRcbiIsIGRldl9udW0pOwoJYXNwcmludGYoJmRl
dl9kaXJfbmFtZSwgIiVzZGV2aWNlJWQiLCBpaW9fZGlyLCBkZXZfbnVtKTsK
CgkvKgoJICogQnVpbGQgdGhlIHRyaWdnZXIgbmFtZS4KCSAqIEluIHRoaXMg
Y2FzZSB3ZSB3YW50IHRoZSBsaXMzbDAyZHEncyBkYXRhIHJlYWR5IHRyaWdn
ZXIKCSAqIGZvciB0aGlzIGxpczNsMDJkcS4gVGhlIG5hbWluZyBpcyBsaXMz
bDAyZHFfZGV2W25dLCB3aGVyZQoJICogbiBtYXRjaGVzIHRoZSBkZXZpY2Ug
bnVtYmVyIGZvdW5kIGFib3ZlLgoJICovCglyZXQgPSBhc3ByaW50ZigmdHJp
Z2dlcl9uYW1lLCAiJXMlZCIsIHRyaWdnZXJfbmFtZV9iYXNlLCBkZXZfbnVt
KTsKCWlmIChyZXQgPCAwKSB7CgkJcmV0ID0gLUVOT01FTTsKCQlnb3RvIGVy
cm9yX2ZyZWVfZGV2X2Rpcl9uYW1lOwoJfQoKCS8qCgkgKiBGaW5kIHRoZSB0
cmlnZ2VyIGJ5IG5hbWUuCgkgKiBUaGlzIGlzIHRlY2hpY2FsbHkgdW5lY2Vz
c2FyeSBoZXJlIGFzIHdlIG9ubHkgbmVlZCB0bwoJICogcmVmZXIgdG8gdGhl
IHRyaWdnZXIgYnkgbmFtZSBhbmQgdGhhdCBuYW1lIGlzIGFscmVhZHkKCSAq
IGtub3duLgoJICovCgl0cmlnX251bSA9IGZpbmRfdHlwZV9ieV9uYW1lKHRy
aWdnZXJfbmFtZSwgInRyaWdnZXIiKTsKCWlmICh0cmlnX251bSA8IDApIHsK
CQlwcmludGYoIkZhaWxlZCB0byBmaW5kIHRoZSAlc1xuIiwgdHJpZ2dlcl9u
YW1lKTsKCQlyZXQgPSAtRU5PREVWOwoJCWdvdG8gZXJyb3JfZnJlZV90cmln
Z2VybmFtZTsKCX0KCXByaW50ZigiaWlvIHRyaWdnZXIgbnVtYmVyIGJlaW5n
IHVzZWQgaXMgJWRcbiIsIHRyaWdfbnVtKTsKCgkvKgoJICogQ29uc3RydWN0
IHRoZSBkaXJlY3RvcnkgbmFtZSBmb3IgdGhlIGFzc29jaWF0ZWQgYnVmZmVy
LgoJICogQXMgd2Uga25vdyB0aGF0IHRoZSBsaXMzbDAyZHEgaGFzIG9ubHkg
b25lIGJ1ZmZlciB0aGlzIG1heQoJICogYmUgYnVpbHQgcmF0aGVyIHRoYW4g
Zm91bmQuCgkgKi8KCXJldCA9IGFzcHJpbnRmKCZidWZfZGlyX25hbWUsICIl
c2RldmljZSVkOmJ1ZmZlcjAiLCBpaW9fZGlyLCBkZXZfbnVtKTsKCWlmIChy
ZXQgPCAwKSB7CgkJcmV0ID0gLUVOT01FTTsKCQlnb3RvIGVycm9yX2ZyZWVf
dHJpZ2dlcm5hbWU7Cgl9CgkvKiBTZXQgdGhlIGRldmljZSB0cmlnZ2VyIHRv
IGJlIHRoZSBkYXRhIHJkeSB0cmlnZ2VyIGZvdW5kIGFib3ZlICovCglyZXQg
PSB3cml0ZV9zeXNmc19zdHJpbmdfYW5kX3ZlcmlmeSgidHJpZ2dlci9jdXJy
ZW50X3RyaWdnZXIiLAoJCQkJCWRldl9kaXJfbmFtZSwKCQkJCQl0cmlnZ2Vy
X25hbWUpOwoJaWYgKHJldCA8IDApIHsKCQlwcmludGYoIkZhaWxlZCB0byB3
cml0ZSBjdXJyZW50X3RyaWdnZXIgZmlsZVxuIik7CgkJZ290byBlcnJvcl9m
cmVlX2J1Zl9kaXJfbmFtZTsKCX0KI2lmZGVmIElJT19UU1RfREJHCglwcmlu
dGYoIkdvaW5nIHRvIHNldHVwIHJpbmcgcGFyYW1ldGVycywgbGVuZ3RoXG4i
KTsKI2VuZGlmCQoKCS8qIFNldHVwIHJpbmcgYnVmZmVyIHBhcmFtZXRlcnMg
Ki8KCXJldCA9IHdyaXRlX3N5c2ZzX2ludCgibGVuZ3RoIiwgYnVmX2Rpcl9u
YW1lLCBidWZfbGVuKTsKCWlmIChyZXQgPCAwKQoJCWdvdG8gZXJyb3JfZnJl
ZV9idWZfZGlyX25hbWU7CgoKI2lmZGVmIElJT19UU1RfREJHCglwcmludGYo
IkdvaW5nIHRvIHNldHVwIHJpbmcgcGFyYW1ldGVycywgcmluZ19lbmFibGVc
biIpOwojZW5kaWYJCgoKCS8qIEVuYWJsZSB0aGUgYnVmZmVyICovCi8vCXJl
dCA9IHdyaXRlX3N5c2ZzX2ludCgicmluZ19lbmFibGUiLCBidWZfZGlyX25h
bWUsIDEpOyAvLyBSZTogTWFsYSBjaGFuZ2luZyB0byBlbmFibGUKCXJldCA9
IHdyaXRlX3N5c2ZzX2ludCgiZW5hYmxlIiwgYnVmX2Rpcl9uYW1lLCAxKTsK
CWlmIChyZXQgPCAwKQoJCWdvdG8gZXJyb3JfZnJlZV9idWZfZGlyX25hbWU7
CgoJZGF0YSA9IG1hbGxvYyhzaXplX2Zyb21fc2Nhbm1vZGUobnVtX3ZhbHMs
IHNjYW5fdHMpKmJ1Zl9sZW4pOwoJaWYgKCFkYXRhKSB7CgkJcmV0ID0gLUVO
T01FTTsKCQlnb3RvIGVycm9yX2ZyZWVfYnVmX2Rpcl9uYW1lOwoJfQoKCXJl
dCA9IGFzcHJpbnRmKCZidWZmZXJfYWNjZXNzLAoJCSAgICAgICAiL2Rldi9k
ZXZpY2UlZDpidWZmZXIwOmFjY2VzczAiLAoJCSAgICAgICBkZXZfbnVtKTsK
CWlmIChyZXQgPCAwKSB7CgkJcmV0ID0gLUVOT01FTTsKCQlnb3RvIGVycm9y
X2ZyZWVfZGF0YTsKCX0KCglyZXQgPSBhc3ByaW50ZigmYnVmZmVyX2V2ZW50
LCAiL2Rldi9kZXZpY2UlZDpidWZmZXIwOmV2ZW50MCIsIGRldl9udW0pOwoJ
aWYgKHJldCA8IDApIHsKCQlyZXQgPSAtRU5PTUVNOwoJCWdvdG8gZXJyb3Jf
ZnJlZV9kYXRhOwoJfQojaWZkZWYgSUlPX1RTVF9EQkcKCXByaW50ZigiR29p
bmcgdG8gb3BlbiBidWZmZXJfYWNjZXNzIGluIG5ibGsgXG4iKTsKI2VuZGlm
CQoKCQoJLyogQXR0ZW1wdCB0byBvcGVuIG5vbiBibG9ja2luZyB0aGUgYWNj
ZXNzIGRldiAqLwoJZnAgPSBvcGVuKGJ1ZmZlcl9hY2Nlc3MsIE9fUkRPTkxZ
IHwgT19OT05CTE9DSyk7CglpZiAoZnAgPT0gLTEpIHsgLypJZiBpdCBpc24n
dCB0aGVyZSBtYWtlIHRoZSBub2RlICovCgkJcHJpbnRmKCJGYWlsZWQgdG8g
b3BlbiAlc1xuIiwgYnVmZmVyX2FjY2Vzcyk7CgkJcmV0ID0gLWVycm5vOwoJ
CWdvdG8gZXJyb3JfZnJlZV9idWZmZXJfZXZlbnQ7Cgl9CgojaWZkZWYgSUlP
X1RTVF9EQkcKCXByaW50ZigiR29pbmcgdG8gc2V0dXAgb3BlbmluZyBidWZm
ZXItZXZlbnQgaW4gYmxvY2tpbmcgbW9kZVxuIik7CiNlbmRpZgkKCgkvKiBB
dHRlbXB0IHRvIG9wZW4gdGhlIGV2ZW50IGFjY2VzcyBkZXYgKGJsb2NraW5n
IHRoaXMgdGltZSkgKi8KCWZwX2V2ID0gZm9wZW4oYnVmZmVyX2V2ZW50LCAi
cmIiKTsKCWlmIChmcF9ldiA9PSBOVUxMKSB7CgkJcHJpbnRmKCJGYWlsZWQg
dG8gb3BlbiAlc1xuIiwgYnVmZmVyX2V2ZW50KTsKCQlyZXQgPSAtZXJybm87
CgkJZ290byBlcnJvcl9jbG9zZV9idWZmZXJfYWNjZXNzOwoJfQoKI2lmZGVm
IElJT19UU1RfREJHCglwcmludGYoIlN0YXJ0aW5nIHRvIHdhaXQgZm9yIGV2
ZW50c1xuIik7CiNlbmRpZgkKCgkvKiBXYWl0IGZvciBldmVudHMgMTAgdGlt
ZXMgKi8KCWZvciAoaiA9IDA7IGogPCBudW1fbG9vcHM7IGorKykgewoJCXJl
YWRfc2l6ZSA9IGZyZWFkKCZkYXQsIDEsIHNpemVvZihzdHJ1Y3QgaWlvX2V2
ZW50X2RhdGEpLAoJCQkJICBmcF9ldik7CgkJc3dpdGNoIChkYXQuaWQpIHsK
CQljYXNlIElJT19FVkVOVF9DT0RFX1JJTkdfMTAwX0ZVTEw6CgkJCXRvcmVh
ZCA9IGJ1Zl9sZW47CgkJCWJyZWFrOwoJCWNhc2UgSUlPX0VWRU5UX0NPREVf
UklOR183NV9GVUxMOgoJCQl0b3JlYWQgPSBidWZfbGVuKjMvNDsKCQkJYnJl
YWs7CgkJY2FzZSBJSU9fRVZFTlRfQ09ERV9SSU5HXzUwX0ZVTEw6CgkJCXRv
cmVhZCA9IGJ1Zl9sZW4vMjsKCQkJYnJlYWs7CgkJZGVmYXVsdDoKCQkJcHJp
bnRmKCJVbmV4cGVjdGVkZWQgZXZlbnQgY29kZVxuIik7CgkJCWNvbnRpbnVl
OwoJCX0KI2lmZGVmIElJT19UU1RfREJHCglwcmludGYoIkVudGVyaW5nIGJs
b2NrZWQgcmVhZFxuIik7CiNlbmRpZgkKCgkJcmVhZF9zaXplID0gcmVhZChm
cCwKCQkJCSBkYXRhLAoJCQkJIHRvcmVhZCpzaXplX2Zyb21fc2Nhbm1vZGUo
bnVtX3ZhbHMsIHNjYW5fdHMpKTsKCQlpZiAocmVhZF9zaXplID09IC1FQUdB
SU4pIHsKCQkJcHJpbnRmKCJub3RoaW5nIGF2YWlsYWJsZVxuIik7CgkJCWNv
bnRpbnVlOwoJCX0KCiNpZmRlZiBJSU9fVFNUX0RCRwoJcHJpbnRmKCJSZWFk
ICVkIHNhbXBsZXNcbiIscmVhZF9zaXplKTsKI2VuZGlmCQoKCQlzY2FuX3Np
emUgPSBzaXplX2Zyb21fc2Nhbm1vZGUobnVtX3ZhbHMsIHNjYW5fdHMpOwoJ
CWZvciAoaSA9IDA7IGkgPCByZWFkX3NpemUvc2Nhbl9zaXplOyBpKyspIHsK
CQkJZm9yIChrID0gMDsgayA8IG51bV92YWxzOyBrKyspIHsKCQkJCV9fczE2
IHZhbCA9ICooX19zMTYgKikoJmRhdGFbaSpzY2FuX3NpemUKCQkJCQkJCSAg
ICAgKyAoaykqMl0pOwoJCQkJcHJpbnRmKCIlMDR4ICIsICh1bnNpZ25lZCBz
aG9ydCl2YWwpOwoJCQl9CgkJCXByaW50ZigiICVsbGRcbiIsCgkJCSAgICAg
ICAqKF9fczY0ICopKCZkYXRhWyhpICsgMSkKCQkJCQkJKnNpemVfZnJvbV9z
Y2FubW9kZShudW1fdmFscywKCQkJCQkJCQkgICAgc2Nhbl90cykKCQkJCQkJ
LSBzaXplb2YoX19zNjQpXSkpOwoJCX0KCX0KCiNpZmRlZiBJSU9fVFNUX0RC
RwoJcHJpbnRmKCJGaW5pc2hlZCBkYXRhIGFjcXVpc2l0aW9uLCBzdG9wcGlu
ZyByaW5nIGJ1ZmZlclxuIik7CiNlbmRpZgkKCgoJLyogU3RvcCB0aGUgcmlu
ZyBidWZmZXIgKi8KCXJldCA9IHdyaXRlX3N5c2ZzX2ludCgicmluZ19lbmFi
bGUiLCBidWZfZGlyX25hbWUsIDApOwoJaWYgKHJldCA8IDApCgkJZ290byBl
cnJvcl9jbG9zZV9idWZmZXJfZXZlbnQ7CgoJLyogRGlzY29ubmVjdCBmcm9t
IHRoZSB0cmlnZ2VyIC0ganVzdCB3cml0ZSBhIGR1bW15IG5hbWUuKi8KCXdy
aXRlX3N5c2ZzX3N0cmluZygidHJpZ2dlci9jdXJyZW50X3RyaWdnZXIiLAoJ
CQlkZXZfZGlyX25hbWUsICJOVUxMIik7CgplcnJvcl9jbG9zZV9idWZmZXJf
ZXZlbnQ6CglmY2xvc2UoZnBfZXYpOwplcnJvcl9jbG9zZV9idWZmZXJfYWNj
ZXNzOgoJY2xvc2UoZnApOwplcnJvcl9mcmVlX2RhdGE6CglmcmVlKGRhdGEp
OwplcnJvcl9mcmVlX2J1ZmZlcl9hY2Nlc3M6CglmcmVlKGJ1ZmZlcl9hY2Nl
c3MpOwplcnJvcl9mcmVlX2J1ZmZlcl9ldmVudDoKCWZyZWUoYnVmZmVyX2V2
ZW50KTsKZXJyb3JfZnJlZV9idWZfZGlyX25hbWU6CglmcmVlKGJ1Zl9kaXJf
bmFtZSk7CmVycm9yX2ZyZWVfdHJpZ2dlcm5hbWU6CglmcmVlKHRyaWdnZXJf
bmFtZSk7CmVycm9yX2ZyZWVfZGV2X2Rpcl9uYW1lOgoJZnJlZShkZXZfZGly
X25hbWUpOwplcnJvcl9yZXQ6CglyZXR1cm4gcmV0Owp9Cg==

------=OPENWEBMAIL_ATT_0.457829457798169--
