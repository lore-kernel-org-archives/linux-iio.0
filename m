Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-201.synserver.de ([212.40.185.201]:1206 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756841AbbLAVj6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2015 16:39:58 -0500
Message-ID: <565E13AB.8050401@metafoo.de>
Date: Tue, 01 Dec 2015 22:39:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PULL] IIO - First set of new drivers, core support and cleanups
 for the 4.5 cycle
References: <5651D09C.6030209@kernel.org> <5651D1DA.9020903@kernel.org> <20151201171356.GC2714@kroah.com> <565E08F3.20706@kernel.org>
In-Reply-To: <565E08F3.20706@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/2015 09:54 PM, Jonathan Cameron wrote:
> On 01/12/15 17:13, Greg KH wrote:
>> On Sun, Nov 22, 2015 at 02:31:54PM +0000, Jonathan Cameron wrote:
>>>
>>> Hi Greg,
>>>
>>> When this one and the fixes set I sent a few minutes ago merge you curiously
>>> get an issue with drivers/staging/iio/Kconfig.  The right resolution is
>>> to dump all the dummy driver stuff.
>>>
>>> All the other changes related to that move and various automerge stuff that
>>> occurs looks fine to me.
>>
>> Thanks for the merge info, that helped.
>>
>> But, I'm now getting these build warnings that I don't think we had
>> before:
>>
>> drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_complete_touch_event’:
>> drivers/staging/iio/adc/mxs-lradc.c:325:5: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>      (((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
>>      ^
>> drivers/staging/iio/adc/mxs-lradc.c:734:7: note: in expansion of macro ‘LRADC_DELAY_TRIGGER’
>>        LRADC_DELAY_TRIGGER(1 << TOUCHSCREEN_VCHANNEL1) |
>>        ^
>>   LD [M]  drivers/staging/iio/accel/adis16201.o
>> drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_buffer_preenable’:
>> drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>  #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
>>                                           ^
>> drivers/staging/iio/adc/mxs-lradc.c:1308:29: note: in expansion of macro ‘LRADC_DELAY_TRIGGER_LRADCS_MASK’
>>   mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
>>                              ^
>> drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_buffer_postdisable’:
>> drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>  #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
>>                                           ^
>> drivers/staging/iio/adc/mxs-lradc.c:1327:29: note: in expansion of macro ‘LRADC_DELAY_TRIGGER_LRADCS_MASK’
>>   mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
>>                              ^
>>
>> Can you fix those up?
>>
>> thanks,
>>
>> greg k-h
> oops. I'd forgotten I got that one a while ago and meant to check what was causing
> it - sorry about that - initially assumed it was just a warning that had gotten
> turned on in the autobuilder.
> 
> After a lot of digging can be boiled down to statements
> that end up as
> 
> (0xff << 24) | (1UL << 20)
> Now I'm not entirely sure why it is unhappy with that. 
> (0xffUL << 24) | (1UL << 20) is and (0xff << 24) | (1 << 20) - the original - is fine
> as well.
> 
> The oddity to my mind is that 0xff is supposed to be fitted to the smallest possible
> unsigned type (as it's in hex) so why is this happening?

The type is int, if the value fits into int, see
http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1570.pdf#page=82

I guess the right thing to do is to use UL, even though it is a bit ugly.
(Or write 0xff000000 instead of 0xff << 24).

- Lars

