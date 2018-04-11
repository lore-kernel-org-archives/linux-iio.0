Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55974 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeDKIg1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2018 04:36:27 -0400
Received: by mail-wm0-f45.google.com with SMTP id b127so2384192wmf.5
        for <linux-iio@vger.kernel.org>; Wed, 11 Apr 2018 01:36:27 -0700 (PDT)
Subject: Re: Add support of Wiegand card reader
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: linux-iio@vger.kernel.org
References: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
 <CAJCx=gna64NhsMGHu4MGbssvNgeyWXwcoRCFZ4wDLQbu96susg@mail.gmail.com>
 <07edbbde-ac69-82c1-948b-a14f217cd467@gmail.com>
 <CAJCx=gnN2sBUAOPZEfj=z35YVJjENjP=cLCS3JS73suL-pwfBA@mail.gmail.com>
From: =?UTF-8?Q?Ga=c3=abtan_Carlier?= <gcembed@gmail.com>
Message-ID: <1ab90ba2-04c2-a690-7227-5d047ff2140c@gmail.com>
Date: Wed, 11 Apr 2018 10:36:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAJCx=gnN2sBUAOPZEfj=z35YVJjENjP=cLCS3JS73suL-pwfBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/2018 05:37 AM, Matt Ranostay wrote:
> On Tue, Apr 10, 2018 at 1:57 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:
>> Hello,
>> Thank you for your reply.
>>
>> On 04/10/2018 01:26 AM, Matt Ranostay wrote:
>>> On Mon, Apr 9, 2018 at 7:05 AM, Gaëtan Carlier <gcembed@gmail.com> wrote:
>>>> Hello,
>>>> I would like to add support of Wiegand card reader [1]. Where can I place it : drivers/iio/access/wiegand.c or drivers/iio/security/wiegand.c?
>>>
>>> Question here is why is this ideal for iio versus using the input subsystem?
>> What can I send to userspace from a bitstream using Input subsystem ?
>> Datas on Wiegand depend on readers used/setup. The best is to send bitstream directly to userspace and let user split bitstream into facilty/area code, card ID, ...
>> My idea is to send a structure with
>>     * number of bits read
>>     * if two parity bits are valid
>>     * the bitstream itself saved in a 64 bit unsigned integer (or a buffer of chars) including or not the parity bits (I still have to decide). I don't see readers with more than 60 bits.
>>
>> I already start writting driver based on humidity/dht11.c that uses similar timings.
> 
> Another question is what would your struct iio_chan_spec definition
> look like? Namely the .type assignments
> 
For now, I did not have define any channels and num_channels in struct iio_dev in probe function.
That is what I have to investigate today : study how buffers work for IIO subsystem.
The idea is to have a blocking call from the userspace and every time a card is read, the buffer is filled and pushed to userspace. Userspace application will be unblocked and the buffer will be read.

Couldn't I create a new iio_chan_type IIO_ID (or even IIO_BIOMETRIC) ?

>>
>>>
>>> Also a few issues/points:
>>>
>>> * What is the interface to the Wiegand data? If it is inputting on a
>>> GPIO that is for sure not going to be real time enough to get valid
>>> data
>> Wiegand protocol uses two data lines. Both data lines are pulled-up. When a 0 must be send, D0 line is set low, when a 1 must be sent, D1 line is set low. D0 and D1 line can never be set low at the same time. Reader will convert ID of the card into binary data flow of 26, 34, .... 60 bits.
>> The length of a data flow is configured in the reader and all readers connected on the same Wiegand bus have generally the same length.
>>
>>> * Aren't there multiple Wiegand transport standards?
>> Yes they are several data length.
>>
>>> * Most keyreaders I've seen are emulated as keyboard devices so they
>>> use the input subsystem.
>> If they are emulated as keyboard, they don't use Wiegand anymore ! Wiegand is still often used for hotels, ...
>>
>>> * Also if the data being output is ASCII data, then I'm not sure that
>>> fits anywhere in iioData received from Wiegand bus are bits. They are not packed in 8 bits or any other size.
>>
>>>
>>> - Matt
>>>
>>>
>>>>
>>>> Thank you for your help?
>>>> Best regards,
>>>> Gaëtan.
>>>>
>>>> [1] https://en.wikipedia.org/wiki/Wiegand_interface
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Regards,
>> Gaëtan.

Thank you,
Regards,
Gaëtan.
