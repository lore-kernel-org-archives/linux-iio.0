Return-Path: <SRS0=pK0i=HB=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <38c0d89a-a868-e369-68d5-4b9983bca5a4@gmail.com>
References: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
 <CAJCx=gna64NhsMGHu4MGbssvNgeyWXwcoRCFZ4wDLQbu96susg@mail.gmail.com>
 <07edbbde-ac69-82c1-948b-a14f217cd467@gmail.com> <CAJCx=gnN2sBUAOPZEfj=z35YVJjENjP=cLCS3JS73suL-pwfBA@mail.gmail.com>
 <1ab90ba2-04c2-a690-7227-5d047ff2140c@gmail.com> <CAJCx=gnp752CWpmUTQBth7MEO5oNrcf0era9AL237PszS7fMZA@mail.gmail.com>
 <20180412122458.00001e51@huawei.com> <38c0d89a-a868-e369-68d5-4b9983bca5a4@gmail.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 12 Apr 2018 13:59:45 -0700
Message-ID: <CAJCx=gkVMP+g=2sqxQjr8s_56SPuaYbtnknH0MMnghz8TTWtgQ@mail.gmail.com>
Subject: Re: Add support of Wiegand card reader
To: =?UTF-8?Q?Ga=C3=ABtan_Carlier?= <gcembed@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 12, 2018 at 5:20 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com> wr=
ote:
> Hi,
> On 04/12/2018 01:24 PM, Jonathan Cameron wrote:
>> On Wed, 11 Apr 2018 20:41:30 -0700
>> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>>
>>> On Wed, Apr 11, 2018 at 1:36 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com=
> wrote:
>>>> On 04/11/2018 05:37 AM, Matt Ranostay wrote:
>>>>> On Tue, Apr 10, 2018 at 1:57 AM, Ga=C3=ABtan Carlier <gcembed@gmail.c=
om> wrote:
>>>>>> Hello,
>>>>>> Thank you for your reply.
>>>>>>
>>>>>> On 04/10/2018 01:26 AM, Matt Ranostay wrote:
>>>>>>> On Mon, Apr 9, 2018 at 7:05 AM, Ga=C3=ABtan Carlier <gcembed@gmail.=
com> wrote:
>>>>>>>> Hello,
>>>>>>>> I would like to add support of Wiegand card reader [1]. Where can =
I place it : drivers/iio/access/wiegand.c or drivers/iio/security/wiegand.c=
?
>>>>>>>
>>>>>>> Question here is why is this ideal for iio versus using the input s=
ubsystem?
>>>>>> What can I send to userspace from a bitstream using Input subsystem =
?
>>>>>> Datas on Wiegand depend on readers used/setup. The best is to send b=
itstream directly to userspace and let user split bitstream into facilty/ar=
ea code, card ID, ...
>>>>>> My idea is to send a structure with
>>>>>>     * number of bits read
>>>>>>     * if two parity bits are valid
>>>>>>     * the bitstream itself saved in a 64 bit unsigned integer (or a =
buffer of chars) including or not the parity bits (I still have to decide).=
 I don't see readers with more than 60 bits.
>>>>>>
>>>>>> I already start writting driver based on humidity/dht11.c that uses =
similar timings.
>>>>>
>>>>> Another question is what would your struct iio_chan_spec definition
>>>>> look like? Namely the .type assignments
>>>>>
>>>> For now, I did not have define any channels and num_channels in struct=
 iio_dev in probe function.
>>>> That is what I have to investigate today : study how buffers work for =
IIO subsystem.
>>>> The idea is to have a blocking call from the userspace and every time =
a card is read, the buffer is filled and pushed to userspace. Userspace app=
lication will be unblocked and the buffer will be read.
>>>>
>>>
>>> Yeah buffers need to work independent of userspace and can't be blockin=
g at all.
>>>
>>>> Couldn't I create a new iio_chan_type IIO_ID (or even IIO_BIOMETRIC) ?
>>>>
>>>
>>> Yeah IIO_BIOMETRIC or even IIO_ID is a bit odd since it isn't an SI
>>> unit or similar. Maybe Jonathan has some thoughts on this
>>
>> I'll confess I'm not sure this is really a good fit for IIO. It's kind
>> of similar to some of the things like fingerprint readers that generate
>> a block of data in some cryptic format that needs a userspace library to
>> interpret it.
>>
>> We have talked in the past about optimal storage for binary data (GPI si=
gnals
>> on devices that scan them in groups). This is kind of like that I guess.
>>
>> So, Gaetan, what were you thinking the actual data layout in the buffer
>> would be?
>>
> The buffer will contain : a u64 variable, a counter that will tell how mu=
ch bits in u64 variables a used (wiegand is generally 26 bits or 34 bits bu=
t it can rise upto 60 bits but this situation is really rare).
>
> Initially, I though that IIO subsystem was done for this kind of interfac=
e but after more reading it is only suited for ADC/DAC devices.
> Unfortunately, I can not use input subsystem because, I need raw data tha=
t must not be converted to Key code, ...
> So I am little lost. Where can I place my code ? Even is Wiegand is a ver=
y old/unsecured/... protocol, it is still used a lot.
> And with pulse of some microseconds, it is difficult to handle them via e=
xported GPIO on sysfs and do all the stuff in userspace.

Yeah in userspace that would totally wrong way to do it.   One issue
you probably going to have is you can't really be that deterministic
with sampling the GPIO input
esp if you dont' have many cores. Then again I'm not sure how
sensitive Wiegand is to timing.

>
> I clearly understand (now) that Wiegand can not stay in IIO but do you ha=
ve any lead for me please ?
>

Which platform are you using for this?

>>
>>>
>>>>>>
>>>>>>>
>>>>>>> Also a few issues/points:
>>>>>>>
>>>>>>> * What is the interface to the Wiegand data? If it is inputting on =
a
>>>>>>> GPIO that is for sure not going to be real time enough to get valid
>>>>>>> data
>>>>>> Wiegand protocol uses two data lines. Both data lines are pulled-up.=
 When a 0 must be send, D0 line is set low, when a 1 must be sent, D1 line =
is set low. D0 and D1 line can never be set low at the same time. Reader wi=
ll convert ID of the card into binary data flow of 26, 34, .... 60 bits.
>>>>>> The length of a data flow is configured in the reader and all reader=
s connected on the same Wiegand bus have generally the same length.
>>>>>>
>>>>>>> * Aren't there multiple Wiegand transport standards?
>>>>>> Yes they are several data length.
>>>>>>
>>>>>>> * Most keyreaders I've seen are emulated as keyboard devices so the=
y
>>>>>>> use the input subsystem.
>>>>>> If they are emulated as keyboard, they don't use Wiegand anymore ! W=
iegand is still often used for hotels, ...
>>>>>>
>>>>>>> * Also if the data being output is ASCII data, then I'm not sure th=
at
>>>>>>> fits anywhere in iioData received from Wiegand bus are bits. They a=
re not packed in 8 bits or any other size.
>>>>>>
>>>>>>>
>>>>>>> - Matt
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Thank you for your help?
>>>>>>>> Best regards,
>>>>>>>> Ga=C3=ABtan.
>>>>>>>>
>>>>>>>> [1] https://en.wikipedia.org/wiki/Wiegand_interface
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-ii=
o" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>> Regards,
>>>>>> Ga=C3=ABtan.
>>>>
>>>> Thank you,
>>>> Regards,
>>>> Ga=C3=ABtan.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Thank you.
> Regards,
> Ga=C3=ABtan.
