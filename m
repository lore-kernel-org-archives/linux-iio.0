Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1608231004100.13780@pmeerw.net>
References: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
 <1471923894-12194-3-git-send-email-mranostay@gmail.com> <alpine.DEB.2.02.1608230735270.12003@pmeerw.net>
 <CAKzfze9ERDejECJj-nrTaxvyEFuhDUKLafRegzpoKtpcqBLT5g@mail.gmail.com> <alpine.DEB.2.02.1608231004100.13780@pmeerw.net>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 23 Aug 2016 01:43:11 -0700
Message-ID: <CAKzfze86ASAM9oKGP+JgCrzEvoQG7AEus13cq5vFY_BYeVUPhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: chemical: vz89x: add support for VZ89TE part
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 23, 2016 at 1:10 AM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>> >>  struct vz89x_data {
>> >> @@ -79,6 +92,40 @@ static const struct iio_chan_spec vz89x_channels[] = {
>> >>               .info_mask_separate =
>> >>                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> >>               .address = VZ89X_VOC_RESISTANCE_IDX,
>> >> +             .scan_index = -1,
>> >> +             .scan_type = {
>> >
>> > scan_type with a scan_index of -1 is unexpected
>>
>> Isn't that the typical usage to signal a non bufffered channel?.
>> But guess the lack of storage, real bits, and buffered trigger
>> register would signal that anyway.
>
> scan_index == -1 signals that scan_type is not used for buffered reads,
> but then scan_type is used to store endianness
>
> one *could* want a check/invariant that either
> scan_index >= 0 and scan_type must be provided, and
> scan_index == -1 and scan_type must NOT be provided
>
> no bit deal, maybe there is an easy way to store the channel endianness
> elsewhere; maybe a chip_info struct?
>
> I haven't checked (yet) what other drivers do in this regards...

No real reason to do it here but since the struct already exists to
store this bit of information... maybe Jonathan has feedback either
way..

>
> p.
>
> --
>
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
