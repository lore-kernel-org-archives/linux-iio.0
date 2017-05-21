Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36629 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbdEUKzE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 06:55:04 -0400
Subject: Re: [PATCH v3] staging: iio: light: Replace symbolic permissions as
 per coding style
To: Brian Masney <masneyb@onstation.org>
Cc: surenderpolsani@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        gregor.boirie@parrot.com, singhalsimran0@gmail.com,
        maitysanchayan@gmail.com, eraretuya@gmail.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jon Brenner <Jon.Brenner@ams.com>
References: <20170519082041.GA18353@kroah.com>
 <1495186632-31114-1-git-send-email-surenderpolsani@gmail.com>
 <e374d59a-c216-a19b-a3a1-a26a862f0ae5@kernel.org>
 <20170520183635.GA4124@200591939db7>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1c5d4c25-292a-e744-79a0-f73f6259579b@kernel.org>
Date: Sun, 21 May 2017 11:55:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170520183635.GA4124@200591939db7>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/17 19:36, Brian Masney wrote:
> On Sat, May 20, 2017 at 06:55:02PM +0100, Jonathan Cameron wrote:
>> On 19/05/17 10:37, surenderpolsani@gmail.com wrote:
>>> From: Surender Polsani <surenderpolsani@gmail.com>
>>>
>>> Fixed the following checkpatch.pl warnings:
>>> octal permissions are more preferable than symbolic permissions
>>>
>>> Replaced DEVICE_ATTR family macros with DEVICE_ATTR_RW family
>>> as suggested by Greg K-H. Changed attributes and function
>>> names where ever required to satisfy internal macro definitions
>>> like __ATTR__RW().
>>>
>>> Signed-off-by: Surender Polsani <surenderpolsani@gmail.com>
>> Nicely presented patch, but it runs into the fact that some of these
>> shouldn't exist as hand rolled attrs in the first place.
>>
>> Some of theses should be handled through the various info_mask and
>> event_info_mask bitmaps + read_raw etc.
>>
>> This would be a much less mechanical change however...
>>
>> See inline and I'll try and pick out which ones.
>>
>> Brian is working on this driver as well at the moment so there may
>> well be some clashes.
>>
>> Perhaps you two could confer on who will target what?  Saves
>> everyone time to work together!
> 
> You can apply this if you'd like. I just got 7 different hardware
> samples from Jon this week that are supported by this driver. I haven't
> gotten far yet with coding since I'm currently working on getting
> them all setup so that it will be easy for me to test my upcoming
> driver changes.
> 
> For my first patch series, I'm planning to migrate the driver to use
> IIO channels, cleaning up the I2C calls, and runtime power management
> support. Hopefully I'll have this to you for next weekend.
> 
I've applied this patch (with a lot of fuzz as the driver had changed
under it).

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see what we messed up.

Jonathan
> Brian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

