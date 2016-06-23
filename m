Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45003 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbcFWWBc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2016 18:01:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1bGCgi-0003Lp-G2
	for linux-iio@vger.kernel.org; Fri, 24 Jun 2016 00:01:28 +0200
Received: from 91.178.120.113 ([91.178.120.113])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2016 00:01:28 +0200
Received: from badshah400 by 91.178.120.113 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2016 00:01:28 +0200
To: linux-iio@vger.kernel.org
From: Atri Bhattacharya <badshah400@aim.com>
Subject: Re: [PATCH v2 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Fri, 24 Jun 2016 00:00:30 +0200
Message-ID: <1466719230.6978.5.camel@aim.com>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2016-06-21 at 22:40 -0700, Srinivas Pandruvada wrote:
> Change log
> v2:
> - Overview in documentation show analogy with usbhid implementation
> - sparse errors for statics. Also pointed by Jiri
> - Clearly marking exported function header file. Clean up all exports
> unused inteface functions
> - Changed to tristate from boolean as pointed by Jiri:
> this required remove/unload functions
> - Prevent crash when ISH enabled on non supported platform
> - Break client.c to smaller part by seprating buffer allocations
> - move bus register/unregister to ishtp module
> - There is only one config symbol INTEL_ISH_HID, removed silent
> config for TRANSPORT and IPC
> 

This updated set of patches seem to be causing failure to wake up from
suspend (sometimes) again. I hit a kernel panic once and had to hard
power-off my laptop another time out of 5 odd times that I closed the
laptop lid. Journal logs don't say much, but if there is some info I
can provide please let me what would help.

Thanks.
-- 

Atri Bhattacharya
Thu 23 Jun 23:57:24 CEST 2016

Sent from openSUSE Tumbleweed (20160621) (x86_64) on my laptop.

