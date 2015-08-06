Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34472 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbbHFLfx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 07:35:53 -0400
Received: by ykax123 with SMTP id x123so59836395yka.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2015 04:35:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55C33E37.8050707@metafoo.de>
References: <CAKv63uuEs4qVzKyAfRRX6ruxYD65L_UaYTTHnZpfc_rRvaX=tg@mail.gmail.com>
 <alpine.DEB.2.02.1508061229430.24774@pmeerw.net> <55C33E37.8050707@metafoo.de>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 6 Aug 2015 13:35:12 +0200
Message-ID: <CAKv63usq7iwTaOV_knLQUQuAq=mHG-_5eJ2hdrCOR9V0eSc6Wg@mail.gmail.com>
Subject: Re: Spliting u16, u32 to u8 array
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6 August 2015 at 13:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/06/2015 12:42 PM, Peter Meerwald wrote:
>> Hello,
>>
>>> I am sure at least some of you were faced to split a u16 or u32 value
>>> in u8 array without being affected by host endianness. My search
>>> turned empty for a standardized function for this task, but this seems
>>> quite improbable. My task is to send 16 bit LE data through i2c.
>>>
>>> I am looking for something like:
>>> static void u16_to_u8_array(u16 value, u8 *array)
>>> {
>>>         *array = cpu_to_le16(value) >> 8;
>>>         *(++array) = (u8) cpu_to_le16(value);
>>> }
>>
>> how about
>>
>> static void u16_to_le16_array(u16 value, __le16 *array)
>> {
>>       *array++ = cpu_to_le16(value);
>> }
>>
>> and calling it with a cast if need be, such as
>>
>> char *u8array;
>> u16_to_le16_array(123, (__le16 *) u8array)
>>
>> an issue could be alignment of the u8array
>
> There is put_unaligned_le16() and friends for this situation where the
> target buffer is just a generic bytestream. This is architecture optimized,
> so if the architecture supports unaligned access it will just do a store, if
> it doesn't it will split the operation into multiple stores.
>
>>
>> I'd try to avoid u8 altogether and work with le16 as a datatype
>
> That seems to be the best solution in this case.
So i2c_master_send takes a char buf as input, and if I would send a le16
array[2] then the cast would nicely fit values it into that.

Thanks for the put_unaligned_le16() hint - exactly what I wanted, but
will investigate the best solution in this case as it seems to require a lot
less lines.
