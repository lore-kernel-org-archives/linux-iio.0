Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:56707 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab1BWLIM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Feb 2011 06:08:12 -0500
Message-ID: <4D64EABA.2030005@cam.ac.uk>
Date: Wed, 23 Feb 2011 11:08:42 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier.adi@gmail.com>
CC: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	drivers@analog.com, device-drivers-devel@blackfin.uclinux.org
Subject: Re: [Device-drivers-devel] [PATCH] IIO: trigger: New Blackfin specific
 trigger driver iio-trig-bfin-timer
References: <1297863769-24022-1-git-send-email-michael.hennerich@analog.com> <4D63D049.7040100@cam.ac.uk> <AANLkTikKRR4JOxS0e_7ezZu-AvN4d9=vtE2BEW=mq4yj@mail.gmail.com>
In-Reply-To: <AANLkTikKRR4JOxS0e_7ezZu-AvN4d9=vtE2BEW=mq4yj@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/22/11 22:35, Mike Frysinger wrote:
> On Tue, Feb 22, 2011 at 10:03, Jonathan Cameron wrote:
>> On 02/16/11 13:42, michael.hennerich@analog.com wrote:
>>> This driver allows any Blackfin system timer to be used as IIO trigger.
>>> It supports trigger rates from 0 to 100kHz in Hz resolution.
>>
>> The reason we ended up with a rtc based trigger in the first place, was that
>> I had a very similar set of timers on the pxa271 that I mainly develop with.
>>
>> At the time some debate opened up on whether there was a use case here for
>> a more general way of providing access to system periodic timers for exactly
>> this sort of device.  The view seemed to be that there was, but I certainly didn't
>> have time to do it at the time and no one else seems to have looked at it since.
>> My dirty solution was an rtc driver that just added a lot of rtcs. It was never
>> going to merge though...
>>
>> Right now I can only track down a previous email from myself saying this has
>> been discussed a number of times, but naturally with no references at all. Oops.
>>
>> Anyhow, such a general subsystem for cpu timers doesn't exist AFAIK so for now
>> lets just go with your approach. Perhaps if we find other possible users we can
>> talk again about how best to support these.
> 
> does this offer functionality that is not available in the new PWM framework ?
> http://thread.gmane.org/gmane.linux.kernel.embedded/3400
It's certainly conceivable that we could treat these as some sort of 'virtual' pwm,
possibly with rather more limited controls than you usual get.
