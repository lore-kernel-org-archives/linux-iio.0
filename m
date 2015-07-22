Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35498 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbbGVFP2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2015 01:15:28 -0400
Received: by wibxm9 with SMTP id xm9so146250895wib.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2015 22:15:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55AB9922.2020104@kernel.org>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com>
	<55A6A295.9020102@gmx.de>
	<55AB9922.2020104@kernel.org>
Date: Wed, 22 Jul 2015 07:15:27 +0200
Message-ID: <CAC+thW2WwzDf8ehoAf_dW1fwhS162No4Z2Czfqs9X2Db=SsJ2g@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: adc: mcp320x: add masking of unknown bits
From: Andrea Galbusera <gizero@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 19, 2015 at 2:33 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 15/07/15 19:12, Hartmut Knaack wrote:
>> Andrea Galbusera schrieb am 14.07.2015 um 15:36:
>>> According to the datasheet, the 2 MSBs for parts 3001 and 3201 are
>>> unspecified and should be masked out
>>>
>>
>> Hi,
>> since resolution is already set, better make it more generic by applying
>> the mask in _read_raw like this:
>>
>> *val = ret & GENMASK(adc->chip_info->resolution - 1, 0);
>>
>> Thanks,
>> Hartmut
> Agreed, that would be cleaner.

Fine for me! I will respin the patch and resend. My only concern is on
how this will get applied. If I understand correctly my other three
patches in the series will probably get applied before this one. The
2,3,4/4 will add the new part with masking applied in
mcp320x_adc_conversion. Then the new version of this one should move
masking in _read_raw. So, is it fine to rebase the new version of this
on top of the other three and resend as a standalone patch? Otherwise
I can respin the entire series, but this one will still affect other
parts... Please forgive my newbie questions, and let me know the best
approach to follow.

>>
>>> Signed-off-by: Andrea Galbusera <gizero@gmail.com>
>>> ---
>>>
>>> This was already suggested but for some reason got lost during review of a
>>> previous patch. See http://marc.info/?l=linux-iio&m=140748835509583&w=2
>>> and following discussion
>>>
>>>  drivers/iio/adc/mcp320x.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
>>> index 8d9c9b9..0673ee7 100644
>>> --- a/drivers/iio/adc/mcp320x.c
>>> +++ b/drivers/iio/adc/mcp320x.c
>>> @@ -114,13 +114,13 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>>>
>>>      switch (device_index) {
>>>      case mcp3001:
>>> -            return (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
>>> +            return ((adc->rx_buf[0] & 0x1f) << 5 | adc->rx_buf[1] >> 3);
>>>      case mcp3002:
>>>      case mcp3004:
>>>      case mcp3008:
>>>              return (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
>>>      case mcp3201:
>>> -            return (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
>>> +            return ((adc->rx_buf[0] & 0x1f) << 7 | adc->rx_buf[1] >> 1);
>>>      case mcp3202:
>>>      case mcp3204:
>>>      case mcp3208:
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
