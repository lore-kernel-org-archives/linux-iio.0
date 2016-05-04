Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36576 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbcEDSON (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 14:14:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id p185so6629609pfb.3
        for <linux-iio@vger.kernel.org>; Wed, 04 May 2016 11:14:12 -0700 (PDT)
Subject: Re: [PATCH 3/4] iio: st_sensors: verify interrupt event to status
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
 <5728E6C2.1050901@gmail.com>
 <CACRpkdaLc8frud64VZEuQ=dXGpgk+kBj94otoCCC=-Pvoe09tw@mail.gmail.com>
 <4e983a0c-88f9-b5bf-3439-15f006736a7d@kernel.org>
 <CACRpkdas0XhPJWXd-HnYEOM4KALk23v_XnkZhkcsdzBjvHewsw@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <cdleonard@gmail.com>
Message-ID: <5d31460f-8377-50b9-3960-d2204d4a4347@gmail.com>
Date: Wed, 4 May 2016 21:14:15 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkdas0XhPJWXd-HnYEOM4KALk23v_XnkZhkcsdzBjvHewsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/04/2016 05:34 PM, Linus Walleij wrote:
> On Wed, May 4, 2016 at 9:35 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 03/05/16 21:10, Linus Walleij wrote:
> 
>>>> Even with hardware triggers: are you sure this is correct? Shouldn't
>>>> iio_trigger_notify_done still get called even when there is nothing to do?
>>>
>>> No then the (hardware) IRQ can have come in from some other
>>> device sharing the line with the peripheral and we need to return
>>> IRQ_NONE. It's not our interrupt.
>>
>> Gah, I fouled up reviewing this.  We really need to know if it is our
>> trigger 'before' we fire off the trigger logic - any number of other
>> devices can in theory be hanging off a given trigger - none of them will
>> be able to know if it was a real trigger or not.
> 
> Ooops sorry, but the good thing is: we get to properly fix it.
> 
I've been testing with some st_sensors devices I have around and it
seems to me that triggered buffers with hardware interrupts don't
actually work properly at high sampling frequencies. It is possible for
another sample to come in before the buffer handler completes and
further interrupts will be lost.

This happens on at least LIS3DH.

It's not obvious how to handle this. Presumably the fix would be to
check STATUS_REG after reading one sample and if new values are
available schedule a new read?

This is easy to reproduce for me because I use an usb-to-i2c adapter
with high latencies. It helps if you increase the sampling_frequency but
it might still be very hard to reproduce on a direct i2c bus.

-- 
Regards,
Leonard

