Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35152 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeDMSox (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 14:44:53 -0400
Received: by mail-it0-f49.google.com with SMTP id q85-v6so4406620itc.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 11:44:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d9647a43-1653-ce05-9ac9-6f363154ee47@gmail.com>
References: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
 <CAJCx=gna64NhsMGHu4MGbssvNgeyWXwcoRCFZ4wDLQbu96susg@mail.gmail.com>
 <07edbbde-ac69-82c1-948b-a14f217cd467@gmail.com> <CAJCx=gnN2sBUAOPZEfj=z35YVJjENjP=cLCS3JS73suL-pwfBA@mail.gmail.com>
 <1ab90ba2-04c2-a690-7227-5d047ff2140c@gmail.com> <CAJCx=gnp752CWpmUTQBth7MEO5oNrcf0era9AL237PszS7fMZA@mail.gmail.com>
 <20180412122458.00001e51@huawei.com> <38c0d89a-a868-e369-68d5-4b9983bca5a4@gmail.com>
 <CAJCx=gkVMP+g=2sqxQjr8s_56SPuaYbtnknH0MMnghz8TTWtgQ@mail.gmail.com> <d9647a43-1653-ce05-9ac9-6f363154ee47@gmail.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Fri, 13 Apr 2018 11:44:52 -0700
Message-ID: <CAJCx=gnZeZWN=qJa3t3dBwDik=Y-9e59q+YFiHra1uNp-JQVDA@mail.gmail.com>
Subject: Re: Add support of Wiegand card reader
To: =?UTF-8?Q?Ga=C3=ABtan_Carlier?= <gcembed@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Apr 13, 2018 at 1:11 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com> wr=
ote:
> On 04/12/2018 10:59 PM, Matt Ranostay wrote:
>> On Thu, Apr 12, 2018 at 5:20 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com>=
 wrote:
>>> Hi,
>>> On 04/12/2018 01:24 PM, Jonathan Cameron wrote:
>>>> On Wed, 11 Apr 2018 20:41:30 -0700
>>>> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>>>>
>>>>> On Wed, Apr 11, 2018 at 1:36 AM, Ga=C3=ABtan Carlier <gcembed@gmail.c=
om> wrote:
>>>>>> On 04/11/2018 05:37 AM, Matt Ranostay wrote:
>>>>>>> On Tue, Apr 10, 2018 at 1:57 AM, Ga=C3=ABtan Carlier <gcembed@gmail=
.com> wrote:
>>>>>>>> Hello,
>>>>>>>> Thank you for your reply.
>>>>>>>>
>>>>>>>> On 04/10/2018 01:26 AM, Matt Ranostay wrote:
>>>>>>>>> On Mon, Apr 9, 2018 at 7:05 AM, Ga=C3=ABtan Carlier <gcembed@gmai=
l.com> wrote:
>>>>>>>>>> Hello,
>>>>>>>>>> I would like to add support of Wiegand card reader [1]. Where ca=
n I place it : drivers/iio/access/wiegand.c or drivers/iio/security/wiegand=
.c?
>>>>>>>>>
>>>>>>>>> Question here is why is this ideal for iio versus using the input=
 subsystem?
>>>>>>>> What can I send to userspace from a bitstream using Input subsyste=
m ?
>>>>>>>> Datas on Wiegand depend on readers used/setup. The best is to send=
 bitstream directly to userspace and let user split bitstream into facilty/=
area code, card ID, ...
>>>>>>>> My idea is to send a structure with
>>>>>>>>     * number of bits read
>>>>>>>>     * if two parity bits are valid
>>>>>>>>     * the bitstream itself saved in a 64 bit unsigned integer (or =
a buffer of chars) including or not the parity bits (I still have to decide=
). I don't see readers with more than 60 bits.
>>>>>>>>
>>>>>>>> I already start writting driver based on humidity/dht11.c that use=
s similar timings.
>>>>>>>
>>>>>>> Another question is what would your struct iio_chan_spec definition
>>>>>>> look like? Namely the .type assignments
>>>>>>>
>>>>>> For now, I did not have define any channels and num_channels in stru=
ct iio_dev in probe function.
>>>>>> That is what I have to investigate today : study how buffers work fo=
r IIO subsystem.
>>>>>> The idea is to have a blocking call from the userspace and every tim=
e a card is read, the buffer is filled and pushed to userspace. Userspace a=
pplication will be unblocked and the buffer will be read.
>>>>>>
>>>>>
>>>>> Yeah buffers need to work independent of userspace and can't be block=
ing at all.
>>>>>
>>>>>> Couldn't I create a new iio_chan_type IIO_ID (or even IIO_BIOMETRIC)=
 ?
>>>>>>
>>>>>
>>>>> Yeah IIO_BIOMETRIC or even IIO_ID is a bit odd since it isn't an SI
>>>>> unit or similar. Maybe Jonathan has some thoughts on this
>>>>
>>>> I'll confess I'm not sure this is really a good fit for IIO. It's kind
>>>> of similar to some of the things like fingerprint readers that generat=
e
>>>> a block of data in some cryptic format that needs a userspace library =
to
>>>> interpret it.
>>>>
>>>> We have talked in the past about optimal storage for binary data (GPI =
signals
>>>> on devices that scan them in groups). This is kind of like that I gues=
s.
>>>>
>>>> So, Gaetan, what were you thinking the actual data layout in the buffe=
r
>>>> would be?
>>>>
>>> The buffer will contain : a u64 variable, a counter that will tell how =
much bits in u64 variables a used (wiegand is generally 26 bits or 34 bits =
but it can rise upto 60 bits but this situation is really rare).
>>>
>>> Initially, I though that IIO subsystem was done for this kind of interf=
ace but after more reading it is only suited for ADC/DAC devices.
>>> Unfortunately, I can not use input subsystem because, I need raw data t=
hat must not be converted to Key code, ...
>>> So I am little lost. Where can I place my code ? Even is Wiegand is a v=
ery old/unsecured/... protocol, it is still used a lot.
>>> And with pulse of some microseconds, it is difficult to handle them via=
 exported GPIO on sysfs and do all the stuff in userspace.
>>
>> Yeah in userspace that would totally wrong way to do it.   One issue
>> you probably going to have is you can't really be that deterministic
>> with sampling the GPIO input
>> esp if you dont' have many cores. Then again I'm not sure how
>> sensitive Wiegand is to timing.
>>
> A valid frame must follows these specs:
> - (negative) pulse width : from 30us to 200us
> - pause between two pulses : from 500us to 10ms.
>
> In my case, Each time I receive a (falling) interrupt on one of two GPIOs
> (D1 or D0), I reload a timer of 20ms (mod_timer). If the timer overflows,
> this means that all bits have been receeived, I check the parity and data
> is ready to be forwarded to userspace : the number of bit received (depen=
ds
> on the reader), the bitstream stored in a 64-bit variable, a "valid" flag
> sets if parity bits are OK. Normally Wiegand data is between 26 and 60 bi=
ts.
>

Personally I think you overly optimistic that this would work with
100% of card swipes (propagation delay of the interrupt and scheduler
would be an issue), and it wouldn't be fully in spec.

Any reason not to use a Wiegand to RS232 converter?

>>>
>>> I clearly understand (now) that Wiegand can not stay in IIO but do you =
have any lead for me please ?
>>>
>>
>> Which platform are you using for this?
>>
> I am working with an ARM Freescale i.MX286
>
>>>>
>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Also a few issues/points:
>>>>>>>>>
>>>>>>>>> * What is the interface to the Wiegand data? If it is inputting o=
n a
>>>>>>>>> GPIO that is for sure not going to be real time enough to get val=
id
>>>>>>>>> data
>>>>>>>> Wiegand protocol uses two data lines. Both data lines are pulled-u=
p. When a 0 must be send, D0 line is set low, when a 1 must be sent, D1 lin=
e is set low. D0 and D1 line can never be set low at the same time. Reader =
will convert ID of the card into binary data flow of 26, 34, .... 60 bits.
>>>>>>>> The length of a data flow is configured in the reader and all read=
ers connected on the same Wiegand bus have generally the same length.
>>>>>>>>
>>>>>>>>> * Aren't there multiple Wiegand transport standards?
>>>>>>>> Yes they are several data length.
>>>>>>>>
>>>>>>>>> * Most keyreaders I've seen are emulated as keyboard devices so t=
hey
>>>>>>>>> use the input subsystem.
>>>>>>>> If they are emulated as keyboard, they don't use Wiegand anymore !=
 Wiegand is still often used for hotels, ...
>>>>>>>>
>>>>>>>>> * Also if the data being output is ASCII data, then I'm not sure =
that
>>>>>>>>> fits anywhere in iioData received from Wiegand bus are bits. They=
 are not packed in 8 bits or any other size.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> - Matt
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thank you for your help?
>>>>>>>>>> Best regards,
>>>>>>>>>> Ga=C3=ABtan.
>>>>>>>>>>
>>>>>>>>>> [1] https://en.wikipedia.org/wiki/Wiegand_interface
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
iio" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Ga=C3=ABtan.
>>>>>>
>>>>>> Thank you,
>>>>>> Regards,
>>>>>> Ga=C3=ABtan.
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> Thank you.
>>> Regards,
>>> Ga=C3=ABtan.
>
