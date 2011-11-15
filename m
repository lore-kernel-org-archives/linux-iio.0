Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:50578 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab1KOUbG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2011 15:31:06 -0500
References: <1321373655-14359-1-git-send-email-lars@metafoo.de> <4EC2C16B.5040400@kernel.org> <4EC2CB45.8030308@metafoo.de>
In-Reply-To: <4EC2CB45.8030308@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging:iio: Add missing MODULE_DEVICE_TABLE and MODULE_ALIAS
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 15 Nov 2011 20:30:43 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Message-ID: <2e4edf01-db4b-450f-a3b1-7cce3226de1a@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 11/15/2011 08:45 PM, Jonathan Cameron wrote:
>> On 11/15/2011 04:14 PM, Lars-Peter Clausen wrote:
>>> Quite a few iio drivers provide no MODULE_DEVICE_TABLE or
>MODULE_ALIAS or only
>>> provide a MODULE_ALIAS while they have support for multiple device
>ids. This
>>> prevents auto module loading from working correctly.
>>>
>> Sensible patch.  I've never chased this down because I'm cynical and
>> tend to specifically load drivers for my devices.  This will have
>> fuzz all over the place, so you may end up rebasing to get it in.
>> I'd like this to happen asap though as things are moderately quiet at
>> the moment!
>
>I'm don't use module auto loading myself that much, but these kind of
>issues
>tend to spread as previous drivers are used as skeletons for new ones.
>
>In regard to the fuzz, I've collected the IIO patches which were sent
>to GregKH
>but haven't been applied yet[1] and based this patch on top of it.
>
>Btw. I see you have a new email address. Which one should we send
>patches too?
Right now they go to same place anyway so does not matter.
>
>>> This patch fixes it by adding the missing MODULE_DEVICE_TABLEs and
>>> MODULE_ALIAS'.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>
>Thanks
>- Lars
>
>
>[1]
>http://git.metafoo.de/?p=linux-2.6;a=shortlog;h=refs/heads/iio-queue

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my brevity.
