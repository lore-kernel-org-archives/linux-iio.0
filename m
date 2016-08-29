Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41880 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754648AbcH2Qh2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 12:37:28 -0400
Subject: Re: [PATCH 2/3] iio: chemical: vz89x: add support for VZ89TE part
To: Matt Ranostay <mranostay@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
 <1471923894-12194-3-git-send-email-mranostay@gmail.com>
 <alpine.DEB.2.02.1608230735270.12003@pmeerw.net>
 <CAKzfze9ERDejECJj-nrTaxvyEFuhDUKLafRegzpoKtpcqBLT5g@mail.gmail.com>
 <alpine.DEB.2.02.1608231004100.13780@pmeerw.net>
 <CAKzfze86ASAM9oKGP+JgCrzEvoQG7AEus13cq5vFY_BYeVUPhg@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <623a0019-56b5-4787-92c7-213e1e751915@kernel.org>
Date: Mon, 29 Aug 2016 17:37:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze86ASAM9oKGP+JgCrzEvoQG7AEus13cq5vFY_BYeVUPhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/08/16 09:43, Matt Ranostay wrote:
> On Tue, Aug 23, 2016 at 1:10 AM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
>>
>>>>>  struct vz89x_data {
>>>>> @@ -79,6 +92,40 @@ static const struct iio_chan_spec vz89x_channels[] = {
>>>>>               .info_mask_separate =
>>>>>                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>>>>>               .address = VZ89X_VOC_RESISTANCE_IDX,
>>>>> +             .scan_index = -1,
>>>>> +             .scan_type = {
>>>>
>>>> scan_type with a scan_index of -1 is unexpected
>>>
>>> Isn't that the typical usage to signal a non bufffered channel?.
>>> But guess the lack of storage, real bits, and buffered trigger
>>> register would signal that anyway.
>>
>> scan_index == -1 signals that scan_type is not used for buffered reads,
>> but then scan_type is used to store endianness
>>
>> one *could* want a check/invariant that either
>> scan_index >= 0 and scan_type must be provided, and
This first one could indeed be done if anyone wanted to.
It not being present and getting to a submission would rather signal
a lack of testing with standard tools, but I guess this could happen
by 'accident' if someone adds something like a temperature channel
and only ever checks the sysfs interface.
>> scan_index == -1 and scan_type must NOT be provided
Not so keen on this one.
>>
>> no bit deal, maybe there is an easy way to store the channel endianness
>> elsewhere; maybe a chip_info struct?
>>
>> I haven't checked (yet) what other drivers do in this regards...
> 
> No real reason to do it here but since the struct already exists to
> store this bit of information... maybe Jonathan has feedback either
> way..
It's fine to use it for this. Quite a few drivers IIRC have
done this in the past.


> 
>>
>> p.
>>
>> --
>>
>> Peter Meerwald-Stadler
>> +43-664-2444418 (mobile)

