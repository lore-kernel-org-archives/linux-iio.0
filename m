Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:55140 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbbKLPAv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Nov 2015 10:00:51 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 5E7F020B6D
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2015 16:00:48 +0100 (CET)
Message-ID: <5644A97A.40900@posteo.de>
Date: Thu, 12 Nov 2015 16:00:10 +0100
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 1/3] iio: mma8452: add freefall detection for Freescale's
 accelerometers
References: <1447267094-2248-1-git-send-email-martink@posteo.de> <5643921B.5070707@metafoo.de>
In-Reply-To: <5643921B.5070707@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2015-11-11 um 20:08 schrieb Lars-Peter Clausen:
> On 11/11/2015 07:38 PM, Martin Kepplinger wrote:
>> This adds freefall event detection to the supported devices. It adds the 
>> in_accel_x&y&z_mag_falling_en iio event attribute, which activates 
>> freefall mode.
>>
> 
> Hi,
> 
> Thanks for the patch, looks pretty good. Just a few things.
> 
>> In freefall mode, the current acceleration values of all activated axis 
>> are added and if the *sum* falls *under* the threshold specified
> 
> Are you sure its not the magnitude of the vector rather than the sum of the
> individual components?

It's the acceleration magnitude, logical AND combination of the values.
Will correct this for v2.

> 
>> (in_accel_mag_falling_value), the appropriate IIO event code is 
>> generated.
> [...]
>> +enum { +	axis_x, +	axis_y, +	axis_z, +};
> 
> That should be part of patch two I guess.

Will do.

> 
> [...]
>> +static IIO_DEVICE_ATTR_NAMED(accel_xayaz_mag_falling_en, + 
>> in_accel_x&y&z_mag_falling_en, +			     S_IRUGO | S_IWUSR, + 
>> mma8452_get_freefall_mode, +			     mma8452_set_freefall_mode, + 0);
> 
> This should be created by the core based on the event spec, shouldn't it?
> 

I'll check if this works when I get to it.

thanks for the review!

                                  martin

