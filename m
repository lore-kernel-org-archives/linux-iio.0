Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34460 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbeDMILO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 04:11:14 -0400
Received: by mail-wm0-f45.google.com with SMTP id w2so6041298wmw.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 01:11:13 -0700 (PDT)
Subject: Re: Add support of Wiegand card reader
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
 <CAJCx=gna64NhsMGHu4MGbssvNgeyWXwcoRCFZ4wDLQbu96susg@mail.gmail.com>
 <07edbbde-ac69-82c1-948b-a14f217cd467@gmail.com>
 <CAJCx=gnN2sBUAOPZEfj=z35YVJjENjP=cLCS3JS73suL-pwfBA@mail.gmail.com>
 <1ab90ba2-04c2-a690-7227-5d047ff2140c@gmail.com>
 <CAJCx=gnp752CWpmUTQBth7MEO5oNrcf0era9AL237PszS7fMZA@mail.gmail.com>
 <20180412122458.00001e51@huawei.com>
 <38c0d89a-a868-e369-68d5-4b9983bca5a4@gmail.com>
 <CAJCx=gkVMP+g=2sqxQjr8s_56SPuaYbtnknH0MMnghz8TTWtgQ@mail.gmail.com>
From: =?UTF-8?Q?Ga=c3=abtan_Carlier?= <gcembed@gmail.com>
Message-ID: <d9647a43-1653-ce05-9ac9-6f363154ee47@gmail.com>
Date: Fri, 13 Apr 2018 10:11:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAJCx=gkVMP+g=2sqxQjr8s_56SPuaYbtnknH0MMnghz8TTWtgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/2018 10:59 PM, Matt Ranostay wrote:
> On Thu, Apr 12, 2018 at 5:20 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:
>> Hi,
>> On 04/12/2018 01:24 PM, Jonathan Cameron wrote:
>>> On Wed, 11 Apr 2018 20:41:30 -0700
>>> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>>>
>>>> On Wed, Apr 11, 2018 at 1:36 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:
>>>>> On 04/11/2018 05:37 AM, Matt Ranostay wrote:
>>>>>> On Tue, Apr 10, 2018 at 1:57 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:
>>>>>>> Hello,
>>>>>>> Thank you for your reply.
>>>>>>>
>>>>>>> On 04/10/2018 01:26 AM, Matt Ranostay wrote:
>>>>>>>> On Mon, Apr 9, 2018 at 7:05 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:
>>>>>>>>> Hello,
>>>>>>>>> I would like to add support of Wiegand card reader [1]. Where can I place it : drivers/iio/access/wiegand.c or drivers/iio/security/wiegand.c?
>>>>>>>>
>>>>>>>> Question here is why is this ideal for iio versus using the input subsystem?
>>>>>>> What can I send to userspace from a bitstream using Input subsystem ?
>>>>>>> Datas on Wiegand depend on readers used/setup. The best is to send bitstream directly to userspace and let user split bitstream into facilty/area code, card ID, ...
>>>>>>> My idea is to send a structure with
>>>>>>>     * number of bits read
>>>>>>>     * if two parity bits are valid
>>>>>>>     * the bitstream itself saved in a 64 bit unsigned integer (or a buffer of chars) including or not the parity bits (I still have to decide). I don't see readers with more than 60 bits.
>>>>>>>
>>>>>>> I already start writting driver based on humidity/dht11.c that uses similar timings.
>>>>>>
>>>>>> Another question is what would your struct iio_chan_spec definition
>>>>>> look like? Namely the .type assignments
>>>>>>
>>>>> For now, I did not have define any channels and num_channels in struct iio_dev in probe function.
>>>>> That is what I have to investigate today : study how buffers work for IIO subsystem.
>>>>> The idea is to have a blocking call from the userspace and every time a card is read, the buffer is filled and pushed to userspace. Userspace application will be unblocked and the buffer will be read.
>>>>>
>>>>
>>>> Yeah buffers need to work independent of userspace and can't be blocking at all.
>>>>
>>>>> Couldn't I create a new iio_chan_type IIO_ID (or even IIO_BIOMETRIC) ?
>>>>>
>>>>
>>>> Yeah IIO_BIOMETRIC or even IIO_ID is a bit odd since it isn't an SI
>>>> unit or similar. Maybe Jonathan has some thoughts on this
>>>
>>> I'll confess I'm not sure this is really a good fit for IIO. It's kind
>>> of similar to some of the things like fingerprint readers that generate
>>> a block of data in some cryptic format that needs a userspace library to
>>> interpret it.
>>>
>>> We have talked in the past about optimal storage for binary data (GPI signals
>>> on devices that scan them in groups). This is kind of like that I guess.
>>>
>>> So, Gaetan, what were you thinking the actual data layout in the buffer
>>> would be?
>>>
>> The buffer will contain : a u64 variable, a counter that will tell how much bits in u64 variables a used (wiegand is generally 26 bits or 34 bits but it can rise upto 60 bits but this situation is really rare).
>>
>> Initially, I though that IIO subsystem was done for this kind of interface but after more reading it is only suited for ADC/DAC devices.
>> Unfortunately, I can not use input subsystem because, I need raw data that must not be converted to Key code, ...
>> So I am little lost. Where can I place my code ? Even is Wiegand is a very old/unsecured/... protocol, it is still used a lot.
>> And with pulse of some microseconds, it is difficult to handle them via exported GPIO on sysfs and do all the stuff in userspace.
> 
> Yeah in userspace that would totally wrong way to do it.   One issue
> you probably going to have is you can't really be that deterministic
> with sampling the GPIO input
> esp if you dont' have many cores. Then again I'm not sure how
> sensitive Wiegand is to timing.
> 
A valid frame must follows these specs:
- (negative) pulse width : from 30us to 200us
- pause between two pulses : from 500us to 10ms.

In my case, Each time I receive a (falling) interrupt on one of two GPIOs
(D1 or D0), I reload a timer of 20ms (mod_timer). If the timer overflows,
this means that all bits have been receeived, I check the parity and data
is ready to be forwarded to userspace : the number of bit received (depends
on the reader), the bitstream stored in a 64-bit variable, a "valid" flag
sets if parity bits are OK. Normally Wiegand data is between 26 and 60 bits.

>>
>> I clearly understand (now) that Wiegand can not stay in IIO but do you have any lead for me please ?
>>
> 
> Which platform are you using for this?
> 
I am working with an ARM Freescale i.MX286

>>>
>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Also a few issues/points:
>>>>>>>>
>>>>>>>> * What is the interface to the Wiegand data? If it is inputting on a
>>>>>>>> GPIO that is for sure not going to be real time enough to get valid
>>>>>>>> data
>>>>>>> Wiegand protocol uses two data lines. Both data lines are pulled-up. When a 0 must be send, D0 line is set low, when a 1 must be sent, D1 line is set low. D0 and D1 line can never be set low at the same time. Reader will convert ID of the card into binary data flow of 26, 34, .... 60 bits.
>>>>>>> The length of a data flow is configured in the reader and all readers connected on the same Wiegand bus have generally the same length.
>>>>>>>
>>>>>>>> * Aren't there multiple Wiegand transport standards?
>>>>>>> Yes they are several data length.
>>>>>>>
>>>>>>>> * Most keyreaders I've seen are emulated as keyboard devices so they
>>>>>>>> use the input subsystem.
>>>>>>> If they are emulated as keyboard, they don't use Wiegand anymore ! Wiegand is still often used for hotels, ...
>>>>>>>
>>>>>>>> * Also if the data being output is ASCII data, then I'm not sure that
>>>>>>>> fits anywhere in iioData received from Wiegand bus are bits. They are not packed in 8 bits or any other size.
>>>>>>>
>>>>>>>>
>>>>>>>> - Matt
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thank you for your help?
>>>>>>>>> Best regards,
>>>>>>>>> Gaëtan.
>>>>>>>>>
>>>>>>>>> [1] https://en.wikipedia.org/wiki/Wiegand_interface
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>>> Regards,
>>>>>>> Gaëtan.
>>>>>
>>>>> Thank you,
>>>>> Regards,
>>>>> Gaëtan.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> Thank you.
>> Regards,
>> Gaëtan.

