Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43762 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbbFUNMT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:12:19 -0400
Message-ID: <5586B831.3030702@kernel.org>
Date: Sun, 21 Jun 2015 14:12:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: simon@mungewell.org
CC: linux-input@vger.kernel.org,
	Frank Praznik <frank.praznik@oh.rr.com>,
	linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC] HID: hid-sony: Add basic iio-subsystem reading of SixAxis
 Accelerometers
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>    <1434034458-1968-1-git-send-email-simon@mungewell.org>    <557D9564.9090800@kernel.org>    <d6702f5d19d2baea80132666fcf7654a.squirrel@mungewell.org>    <557DC084.6090205@kernel.org> <a740eca098128c7a830db825d7c0288c.squirrel@mungewell.org>
In-Reply-To: <a740eca098128c7a830db825d7c0288c.squirrel@mungewell.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/06/15 07:15, simon@mungewell.org wrote:
> 
>>> I have further advanced the patch to include reading via buffer, but I'm
>>> having trigger 'conceptual' problems getting my head around the HID
>>> device
>>> issuing an interrupt when a input report is received. Looking at
>>> iio_dummy_event and iios_sysfs for inspiration....
>> You can skip the triggers.  It's not obligatory, you can push directly
>> into a buffer.
>> Triggers are nice for 'data ready' type signals (which is closest to what
>> we
>> have here) if you might want to hang other sensors off the timing (so read
>> on demand ADCs etc.  They aren't actually 'required' as such.
> 
> After a bit of poking around I got the triggers working as well, I can
> self trigger and even trigger another (iio-dummy) device.
> 
> However I couldn't trigger two devices at the same time from a single
> trigger, is this normal for IIO?
You should be able to.   Defaults limit it to 2 per trigger, 
in Kconfig it is "Maximum number of consumers per trigger".
Any chance that has the value 1 for your build?

Otherwise, if you can do a bit of debugging to find out where things
get stuck, that would be great.  Can you bring up the buffers with the
trigger attached or is it failing before that?

After that it would just be a case of chasing in your trigger driver to
see if it gets reenabled correctly after the first trigger.

> 
> 
> Next is a little code clean-up and I'll post what I have for some more
> comments,
Cool.

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
