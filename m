Return-Path: <SRS0=z2XF=HB=metafoo.de=lars@kernel.org>
Subject: Re: Add support of Wiegand card reader
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Matt Ranostay <matt.ranostay@konsulko.com>
Cc: =?UTF-8?Q?Ga=c3=abtan_Carlier?= <gcembed@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
 <CAJCx=gna64NhsMGHu4MGbssvNgeyWXwcoRCFZ4wDLQbu96susg@mail.gmail.com>
 <07edbbde-ac69-82c1-948b-a14f217cd467@gmail.com>
 <CAJCx=gnN2sBUAOPZEfj=z35YVJjENjP=cLCS3JS73suL-pwfBA@mail.gmail.com>
 <1ab90ba2-04c2-a690-7227-5d047ff2140c@gmail.com>
 <CAJCx=gnp752CWpmUTQBth7MEO5oNrcf0era9AL237PszS7fMZA@mail.gmail.com>
 <20180412122458.00001e51@huawei.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0757b9ed-59f6-f52b-90a7-39a82f8b1d63@metafoo.de>
Date: Thu, 12 Apr 2018 13:30:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180412122458.00001e51@huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 04/12/2018 01:24 PM, Jonathan Cameron wrote:
> On Wed, 11 Apr 2018 20:41:30 -0700
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> 
>> On Wed, Apr 11, 2018 at 1:36 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:
>>> On 04/11/2018 05:37 AM, Matt Ranostay wrote:  
>>>> On Tue, Apr 10, 2018 at 1:57 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:  
>>>>> Hello,
>>>>> Thank you for your reply.
>>>>>
>>>>> On 04/10/2018 01:26 AM, Matt Ranostay wrote:  
>>>>>> On Mon, Apr 9, 2018 at 7:05 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:  
>>>>>>> Hello,
>>>>>>> I would like to add support of Wiegand card reader [1]. Where can I place it : drivers/iio/access/wiegand.c or drivers/iio/security/wiegand.c?  
>>>>>>
>>>>>> Question here is why is this ideal for iio versus using the input subsystem?  
>>>>> What can I send to userspace from a bitstream using Input subsystem ?
>>>>> Datas on Wiegand depend on readers used/setup. The best is to send bitstream directly to userspace and let user split bitstream into facilty/area code, card ID, ...
>>>>> My idea is to send a structure with
>>>>>     * number of bits read
>>>>>     * if two parity bits are valid
>>>>>     * the bitstream itself saved in a 64 bit unsigned integer (or a buffer of chars) including or not the parity bits (I still have to decide). I don't see readers with more than 60 bits.
>>>>>
>>>>> I already start writting driver based on humidity/dht11.c that uses similar timings.  
>>>>
>>>> Another question is what would your struct iio_chan_spec definition
>>>> look like? Namely the .type assignments
>>>>  
>>> For now, I did not have define any channels and num_channels in struct iio_dev in probe function.
>>> That is what I have to investigate today : study how buffers work for IIO subsystem.
>>> The idea is to have a blocking call from the userspace and every time a card is read, the buffer is filled and pushed to userspace. Userspace application will be unblocked and the buffer will be read.
>>>  
>>
>> Yeah buffers need to work independent of userspace and can't be blocking at all.
>>
>>> Couldn't I create a new iio_chan_type IIO_ID (or even IIO_BIOMETRIC) ?
>>>  
>>
>> Yeah IIO_BIOMETRIC or even IIO_ID is a bit odd since it isn't an SI
>> unit or similar. Maybe Jonathan has some thoughts on this
> 
> I'll confess I'm not sure this is really a good fit for IIO. It's kind
> of similar to some of the things like fingerprint readers that generate
> a block of data in some cryptic format that needs a userspace library to
> interpret it.

It looks like we are removing the frame from framework ;)
