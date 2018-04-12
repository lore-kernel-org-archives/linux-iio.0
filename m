Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:44079 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeDLDlb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2018 23:41:31 -0400
Received: by mail-io0-f180.google.com with SMTP id d7so4765251ioc.11
        for <linux-iio@vger.kernel.org>; Wed, 11 Apr 2018 20:41:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ab90ba2-04c2-a690-7227-5d047ff2140c@gmail.com>
References: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
 <CAJCx=gna64NhsMGHu4MGbssvNgeyWXwcoRCFZ4wDLQbu96susg@mail.gmail.com>
 <07edbbde-ac69-82c1-948b-a14f217cd467@gmail.com> <CAJCx=gnN2sBUAOPZEfj=z35YVJjENjP=cLCS3JS73suL-pwfBA@mail.gmail.com>
 <1ab90ba2-04c2-a690-7227-5d047ff2140c@gmail.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Wed, 11 Apr 2018 20:41:30 -0700
Message-ID: <CAJCx=gnp752CWpmUTQBth7MEO5oNrcf0era9AL237PszS7fMZA@mail.gmail.com>
Subject: Re: Add support of Wiegand card reader
To: =?UTF-8?Q?Ga=C3=ABtan_Carlier?= <gcembed@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 11, 2018 at 1:36 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com> wr=
ote:
> On 04/11/2018 05:37 AM, Matt Ranostay wrote:
>> On Tue, Apr 10, 2018 at 1:57 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com>=
 wrote:
>>> Hello,
>>> Thank you for your reply.
>>>
>>> On 04/10/2018 01:26 AM, Matt Ranostay wrote:
>>>> On Mon, Apr 9, 2018 at 7:05 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com=
> wrote:
>>>>> Hello,
>>>>> I would like to add support of Wiegand card reader [1]. Where can I p=
lace it : drivers/iio/access/wiegand.c or drivers/iio/security/wiegand.c?
>>>>
>>>> Question here is why is this ideal for iio versus using the input subs=
ystem?
>>> What can I send to userspace from a bitstream using Input subsystem ?
>>> Datas on Wiegand depend on readers used/setup. The best is to send bits=
tream directly to userspace and let user split bitstream into facilty/area =
code, card ID, ...
>>> My idea is to send a structure with
>>>     * number of bits read
>>>     * if two parity bits are valid
>>>     * the bitstream itself saved in a 64 bit unsigned integer (or a buf=
fer of chars) including or not the parity bits (I still have to decide). I =
don't see readers with more than 60 bits.
>>>
>>> I already start writting driver based on humidity/dht11.c that uses sim=
ilar timings.
>>
>> Another question is what would your struct iio_chan_spec definition
>> look like? Namely the .type assignments
>>
> For now, I did not have define any channels and num_channels in struct ii=
o_dev in probe function.
> That is what I have to investigate today : study how buffers work for IIO=
 subsystem.
> The idea is to have a blocking call from the userspace and every time a c=
ard is read, the buffer is filled and pushed to userspace. Userspace applic=
ation will be unblocked and the buffer will be read.
>

Yeah buffers need to work independent of userspace and can't be blocking at=
 all.

> Couldn't I create a new iio_chan_type IIO_ID (or even IIO_BIOMETRIC) ?
>

Yeah IIO_BIOMETRIC or even IIO_ID is a bit odd since it isn't an SI
unit or similar. Maybe Jonathan has some thoughts on this

>>>
>>>>
>>>> Also a few issues/points:
>>>>
>>>> * What is the interface to the Wiegand data? If it is inputting on a
>>>> GPIO that is for sure not going to be real time enough to get valid
>>>> data
>>> Wiegand protocol uses two data lines. Both data lines are pulled-up. Wh=
en a 0 must be send, D0 line is set low, when a 1 must be sent, D1 line is =
set low. D0 and D1 line can never be set low at the same time. Reader will =
convert ID of the card into binary data flow of 26, 34, .... 60 bits.
>>> The length of a data flow is configured in the reader and all readers c=
onnected on the same Wiegand bus have generally the same length.
>>>
>>>> * Aren't there multiple Wiegand transport standards?
>>> Yes they are several data length.
>>>
>>>> * Most keyreaders I've seen are emulated as keyboard devices so they
>>>> use the input subsystem.
>>> If they are emulated as keyboard, they don't use Wiegand anymore ! Wieg=
and is still often used for hotels, ...
>>>
>>>> * Also if the data being output is ASCII data, then I'm not sure that
>>>> fits anywhere in iioData received from Wiegand bus are bits. They are =
not packed in 8 bits or any other size.
>>>
>>>>
>>>> - Matt
>>>>
>>>>
>>>>>
>>>>> Thank you for your help?
>>>>> Best regards,
>>>>> Ga=C3=ABtan.
>>>>>
>>>>> [1] https://en.wikipedia.org/wiki/Wiegand_interface
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> Regards,
>>> Ga=C3=ABtan.
>
> Thank you,
> Regards,
> Ga=C3=ABtan.
