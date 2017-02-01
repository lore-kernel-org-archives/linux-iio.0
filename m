Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0098.outbound.protection.outlook.com ([104.47.0.98]:52224
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751420AbdBAJnR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Feb 2017 04:43:17 -0500
Subject: Re: [PATCH 1/2] iio: pressure: mpl3115: do not rely on structure
 field ordering
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1485936567-3367-1-git-send-email-peda@axentia.se>
 <1485936567-3367-2-git-send-email-peda@axentia.se>
 <alpine.DEB.2.02.1702010956370.3042@pmeerw.net>
 <ef02efd6-d0da-9310-ba1b-ab3133637f6b@axentia.se>
 <alpine.DEB.2.02.1702011021580.3042@pmeerw.net>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Ken Lin <ken.lin@advantech.com>, <linux-iio@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <8eba97cc-69e5-3698-ddf3-d6eca0bcd3f8@axentia.se>
Date: Wed, 1 Feb 2017 10:43:10 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1702011021580.3042@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-02-01 10:31, Peter Meerwald-Stadler wrote:
> 
>>>> Fixes a regression triggered by a change in the layout of
>>>> struct iio_chan_spec, but the real bug is in the driver which assumed
>>>> a specific structure layout in the first place.
> 
>>> what do you mean by 'driver which assumed a specific structure'?
>>
>> Look again, the two bits are not OR:ed together as implied by the
>> indentation. There is a comma between them, which put the ..._SCALE
>> bit in the next field. That next field was .info_mask_shared_by_type
>> before the patch adding the available attribute that triggered the
>> regression and .info_mask_separate_available after it.
> 
> wow, now that you say it :)
> 
> since I wrote these drivers I can assure you that this is just a typo, use
> of the 'specific structure' is a coincident
> 
> maybe adding your explanation regarding not ORing to the patch description
> would be a good idea
> 
> I was confused by the change from 
> .info_mask_separate to .info_mask_shared_by_type
> a fix could have just changed
> -  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> 			BIT(IIO_CHAN_INFO_SCALE),
> +  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> 			BIT(IIO_CHAN_INFO_SCALE),
> as originally intended

I considered that option, but the code in mpl3115_read_raw (and
mpl115_read_raw for that matter) return constants fro these values which
to me indicated that they were not "separate" and as that would also be
the change which replicated the exact behavior from before the regression
I went with that. But I don't care either way, so I can re-spin if you
want me to? (But don't blame me if that regresses in some other
interesting way).

Cheers,
peda

>> Cheers,
>> peda
>>
>>> thanks, p.
>>>
>>>> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
>>>> index cc3f84139157..525644a7442d 100644
>>>> --- a/drivers/iio/pressure/mpl3115.c
>>>> +++ b/drivers/iio/pressure/mpl3115.c
>>>> @@ -190,7 +190,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>>>>  	{
>>>>  		.type = IIO_PRESSURE,
>>>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>> -			BIT(IIO_CHAN_INFO_SCALE),
>>>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>>>>  		.scan_index = 0,
>>>>  		.scan_type = {
>>>>  			.sign = 'u',
>>>> @@ -203,7 +203,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>>>>  	{
>>>>  		.type = IIO_TEMP,
>>>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>> -			BIT(IIO_CHAN_INFO_SCALE),
>>>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>>>>  		.scan_index = 1,
>>>>  		.scan_type = {
>>>>  			.sign = 's',
>>>>
>>>
>>
> 

