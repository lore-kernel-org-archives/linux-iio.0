Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from omr-a002e.mx.aol.com ([204.29.186.56]:61612 "EHLO
	omr-a002e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbcFBW5s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 18:57:48 -0400
Message-ID: <1464908239.2722.7.camel@aim.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Atri Bhattacharya <badshah400@aim.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 03 Jun 2016 00:57:19 +0200
In-Reply-To: <1464907711.3970.70.camel@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	  <1464788204.3917.9.camel@aim.com>
	 <loom.20160602T052411-711@post.gmane.org>
	  <1464853729.2640.8.camel@aim.com>
	  <1464886187.3970.55.camel@linux.intel.com>
	  <1464896535.3470.4.camel@aim.com>
	  <1464897626.3970.60.camel@linux.intel.com>
	 <1464903962.3970.64.camel@intel.com> <1464906577.3007.2.camel@aim.com>
	 <1464907711.3970.70.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2016-06-02 at 15:48 -0700, Srinivas Pandruvada wrote:
> On Fri, 2016-06-03 at 00:29 +0200, Atri Bhattacharya wrote:
> > Hi Srinivas,
> > 
> > On Thu, 2016-06-02 at 21:44 +0000, Pandruvada, Srinivas wrote:
> > > 
> > > On Thu, 2016-06-02 at 13:00 -0700, Srinivas Pandruvada wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > Thanks for your help in evaluation.
> > > > 
> > > > 
> > > > [...]
> > > > 
> > > > The iio sensor proxy starts too soon. So I recommended to wait
> > > > for
> > > > mult-user target before start. I think developer is
> > > > considering.
> > > > 
> > > Add after "Description" in the section [Unit] in systemd unit
> > > file
> > > /usr/lib/systemd/system/iio-sensor-proxy.service
> > > 
> > > After=multi-user.target
> > > 
> > > Your rotation should work on Yoga 260. I tried on Fedora 23.
> > > 
> > It does! Thank you so much for this tip. Well, it doesn't work
> > again
> > after suspend/wakeup but I will let you know if that issue gets
> > fixed
> > after the patched kernel finishes building.
> The problem is iio_proxy keeps open the IIO file handles, but ISH FW
> is
> will powerup again after suspend, which causes issue. So may be by
> systemd magic stop the service and start again on resume.
> 
> I am working on this. So probably in RFC v2, I will have some fix.
> 

Great. Thank you very much. Just wanted to update you on what is
happening now after I applied your last patch to the kernel.
Suspend/wakeup is still very slow and journalctl still has messages
like these upon wakeup:

Jun 03 00:46:01 tp-yoga260 kernel: [drm] RC6 on
Jun 03 00:46:01 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001: timeout waiting for response from ISHTP device
Jun 03 00:46:01 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001: timeout waiting for response from ISHTP device
Jun 03 00:46:01 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001: timeout waiting for response from ISHTP device
Jun 03 00:46:01 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001: timeout waiting for response from ISHTP device
Jun 03 00:46:01 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0002: timeout waiting for response from ISHTP device
Jun 03 00:46:01 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0002: timeout waiting for response from ISHTP device
Jun 03 00:46:01 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0002: timeout waiting for response from ISHTP device
Jun 03 00:46:01 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0002: timeout waiting for response from ISHTP device
Jun 03 00:46:01 tp-yoga260 kernel: PM: resume of devices complete after 24416.062 msecs
Jun 03 00:46:01 tp-yoga260 kernel: PM: Finishing wakeup.


But, the values even after wakeup
~> cat /sys/bus/iio/devices/iio\:device3/in_accel_?_raw
53028
-785546
-800683

now make sense (previously they were all 0 and taking a long time to
respond). Despite this, iio-sensor-proxy doesn't work after waking up
and I see messages like this on the journal when rotating my laptop:

Jun 03 00:48:38 tp-yoga260 kernel: thinkpad_acpi: unknown possible thermal alarm or keyboard event received
Jun 03 00:48:38 tp-yoga260 kernel: thinkpad_acpi: unhandled HKEY event 0x60f0
Jun 03 00:48:38 tp-yoga260 kernel: thinkpad_acpi: please report the conditions when this event happened to ibm-acpi-devel@lists.sourceforge.net
Jun 03 00:48:40 tp-yoga260 kernel: SFW2-INext-DROP-DEFLT IN=wlp4s0 OUT= MAC=33:33:00:00:00:fb:a8:bb:cf:1d:c3:da:86:dd SRC=fe80:0000:0000:0000:aabb:cfff:fe1d:c3da DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=208 TC=0 HOPLIMIT=255 FLOWLBL=311501 PROTO=UDP SPT=5353 DPT=5353 LEN=168 

Hopefully, there is come clue there. Rotation, brightness auto
adjustment works just fine now after booting and before a first
suspend/wakeup cycle.

Thanks a lot for your follow-up. Best wishes.
-- 
Atri Bhattacharya
Fri  3 Jun 00:49:42 CEST 2016

Sent from openSUSE Tumbleweed (20160531) (x86_64) on my laptop.
