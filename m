Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from serv108.segi.ulg.ac.be ([139.165.32.111]:46760 "EHLO
	serv108.segi.ulg.ac.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbcFBXVP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 19:21:15 -0400
Message-ID: <1464909180.2065.1.camel@ulg.ac.be>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Atri Bhattacharya <A.Bhattacharya@ulg.ac.be>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 03 Jun 2016 01:13:00 +0200
In-Reply-To: <1464908239.2722.7.camel@aim.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	  <1464788204.3917.9.camel@aim.com>
	 <loom.20160602T052411-711@post.gmane.org>
	  <1464853729.2640.8.camel@aim.com>
	  <1464886187.3970.55.camel@linux.intel.com>
	  <1464896535.3470.4.camel@aim.com>
	  <1464897626.3970.60.camel@linux.intel.com>
	 <1464903962.3970.64.camel@intel.com> <1464906577.3007.2.camel@aim.com>
	 <1464907711.3970.70.camel@linux.intel.com>
	 <1464908239.2722.7.camel@aim.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-06-03 at 00:57 +0200, Atri Bhattacharya wrote:
> I see messages like this on the journal when rotating my laptop:
> 
> Jun 03 00:48:38 tp-yoga260 kernel: thinkpad_acpi: unknown possible
> thermal alarm or keyboard event received
> Jun 03 00:48:38 tp-yoga260 kernel: thinkpad_acpi: unhandled HKEY
> event 0x60f0
> Jun 03 00:48:38 tp-yoga260 kernel: thinkpad_acpi: please report the
> conditions when this event happened to ibm-acpi-devel@lists.sourcefor
> ge.net
> Jun 03 00:48:40 tp-yoga260 kernel: SFW2-INext-DROP-DEFLT IN=wlp4s0
> OUT= MAC=33:33:00:00:00:fb:a8:bb:cf:1d:c3:da:86:dd
> SRC=fe80:0000:0000:0000:aabb:cfff:fe1d:c3da
> DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=208 TC=0 HOPLIMIT=255
> FLOWLBL=311501 PROTO=UDP SPT=5353 DPT=5353 LEN=168 
> 
> 

Actually, these show up even when rotation is working, i.e. before a
suspend/wakeup cycle. So probably just a red herring...

-- 
Atri Bhattacharya
IFPA, Institut de Physique Bât B5a, AGO Department
Université de Liège, Sart Tilman, 4000 Liège, Belgium
Phone: +32 4 366 36 38

Fri  3 Jun 01:11:27 CEST 2016

Sent from openSUSE Tumbleweed (20160531)
