Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-239.synserver.de ([212.40.185.239]:1106 "EHLO
	smtp-out-239.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbHFLAL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 07:00:11 -0400
Message-ID: <55C33E37.8050707@metafoo.de>
Date: Thu, 06 Aug 2015 13:00:07 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, Crt Mori <cmo@melexis.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Spliting u16, u32 to u8 array
References: <CAKv63uuEs4qVzKyAfRRX6ruxYD65L_UaYTTHnZpfc_rRvaX=tg@mail.gmail.com> <alpine.DEB.2.02.1508061229430.24774@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1508061229430.24774@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/06/2015 12:42 PM, Peter Meerwald wrote:
> Hello,
> 
>> I am sure at least some of you were faced to split a u16 or u32 value
>> in u8 array without being affected by host endianness. My search
>> turned empty for a standardized function for this task, but this seems
>> quite improbable. My task is to send 16 bit LE data through i2c.
>>
>> I am looking for something like:
>> static void u16_to_u8_array(u16 value, u8 *array)
>> {
>>         *array = cpu_to_le16(value) >> 8;
>>         *(++array) = (u8) cpu_to_le16(value);
>> }
> 
> how about
> 
> static void u16_to_le16_array(u16 value, __le16 *array)
> {
> 	*array++ = cpu_to_le16(value);
> }
> 
> and calling it with a cast if need be, such as
> 
> char *u8array;
> u16_to_le16_array(123, (__le16 *) u8array)
> 
> an issue could be alignment of the u8array

There is put_unaligned_le16() and friends for this situation where the
target buffer is just a generic bytestream. This is architecture optimized,
so if the architecture supports unaligned access it will just do a store, if
it doesn't it will split the operation into multiple stores.

> 
> I'd try to avoid u8 altogether and work with le16 as a datatype

That seems to be the best solution in this case.
