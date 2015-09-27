Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34544 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbI0TkF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 15:40:05 -0400
Received: by padhy16 with SMTP id hy16so153073135pad.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2015 12:40:04 -0700 (PDT)
Date: Mon, 28 Sep 2015 01:09:35 +0530 (IST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>,
	Shraddha Barke <shraddha.6596@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH 1/2] Staging: iio: cdc: Prefer using the BIT macro
In-Reply-To: <5607F322.8040504@kernel.org>
Message-ID: <alpine.DEB.2.11.1509280107360.12248@shraddha-370R4E-370R4V-370R5E-3570RE-370R5V>
References: <1443201782-25863-1-git-send-email-shraddha.6596@gmail.com> <1443201782-25863-2-git-send-email-shraddha.6596@gmail.com> <5606D264.6080503@metafoo.de> <5607F322.8040504@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Sun, 27 Sep 2015, Jonathan Cameron wrote:

> On 26/09/15 18:14, Lars-Peter Clausen wrote:
>> On 09/25/2015 07:23 PM, Shraddha Barke wrote:
>>> Replace bit shifting on 1 with the BIT(x) macro
>>>
>>> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>>
> This is a good little patch, so applied to the togreg branch
> of iio.git.  This will get initially pushed out as testing
> and the branch will get rebased onto Greg KH's staging-next
> branch sometime soon.
>
> However, I think there are some other places the BIT macro
> can be correctly used in this driver if you are willing to take
> it further.
>
> Note that you can only do these by checking the datasheet to be
> sure we aren't writing part of a large field in the register!
>
> In the status register the bottom for bits are single bit fields.
>
>
> #define AD7746_STATUS_EXCERR		(1 << 3)
> #define AD7746_STATUS_RDY		(1 << 2)
> #define AD7746_STATUS_RDYVT		(1 << 1)
> #define AD7746_STATUS_RDYCAP		(1 << 0)
>
> As are the cap setup register bits
>
> #define AD7746_CAPSETUP_CAPEN		(1 << 7)
> #define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
> #define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
> #define AD7746_CAPSETUP_CACHOP		(1 << 0)
>
> Some of the vt setup register are also single bits but as that register
> is a more complex mess and some other bits are hard to define macros
> for perhaps leave it alone.  It's another one arguing in favour of
> a ZERO(bit) macro but I fear persuading people of that will be an uphill
> struggle :(
>
> Anyhow the two registers mentioned above are a clear cut as the one you've
> done so perhaps tidy those up as well?
>
Yes sure. But after checking I found out that AD7746_STATUS_EXCERR macro 
is not used at all. I'm sure there are other such macros in this driver. 
Wouldn't it be better to get rid of them?

Thanks,

Shraddha

> Thanks,
>
> Jonathan
>
>
