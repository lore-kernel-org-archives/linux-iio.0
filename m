Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35338 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbcGDFiH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 01:38:07 -0400
Received: by mail-wm0-f51.google.com with SMTP id z126so27567697wme.0
        for <linux-iio@vger.kernel.org>; Sun, 03 Jul 2016 22:38:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57764C0A.20607@denx.de>
References: <1467341579-31471-1-git-send-email-mranostay@gmail.com> <57764C0A.20607@denx.de>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sun, 3 Jul 2016 22:37:26 -0700
Message-ID: <CAKzfze_2KZaxciSOkLXG09Xqze_N+-RYZWTD3OdwZRjXkcCTzA@mail.gmail.com>
Subject: Re: [PATCH v5] iio: temperature: add support for Maxim thermocouple chips
To: Marek Vasut <marex@denx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Matt Porter <mporter@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jul 1, 2016 at 3:55 AM, Marek Vasut <marex@denx.de> wrote:
> On 07/01/2016 04:52 AM, Matt Ranostay wrote:
>> Add initial driver support for MAX6675, and MAX31855 thermocouple chips.
>>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Matt Porter <mporter@konsulko.com>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>
>> Changes from v1:
>> * switch to iio_device_*_direct_mode wrappers
>> * add const to structs
>> * removed useless cast
>>
>> Changes from v2:
>> * mark buffer data invalid on disconnected thermocouple
>> * add .address = 0 to be consistent
>> * add missing scan_mask for the max31855 part
>>
>> Changes from v3:
>> * fixed several typos of max31855 part number
>>
>> Changes from v4:
>> * drop maxim_thermocouple_validate_buffer() due to peer review saying
>>   this is an incorrect way to signal an invalid reading
>
> [...]
>
>> +const struct iio_chan_spec max31855_channels[] = {
>> +     {       /* thermocouple temperature */
>> +             .type = IIO_TEMP,
>> +             .address = 2,
>> +             .info_mask_separate =
>> +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 0,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 14,
>> +                     .storagebits = 16,
>> +                     .shift = 2,
>> +                     .endianness = IIO_BE,
>> +             },
>> +     },
>> +     {       /* cold junction temperature */
>> +             .type = IIO_TEMP,
>> +             .address = 0,
>> +             .channel2 = IIO_MOD_TEMP_AMBIENT,
>> +             .modified = 1,
>> +             .info_mask_separate =
>> +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 1,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 12,
>> +                     .storagebits = 16,
>> +                     .shift = 4,
>> +                     .endianness = IIO_BE,
>> +             },
>> +     },
>> +     IIO_CHAN_SOFT_TIMESTAMP(2),
>> +};
>> +
>> +static const unsigned long max31855_scan_masks[] = {0x3, 0};
>> +
>> +struct maxim_thermocouple_chip {
>> +     const struct iio_chan_spec *channels;
>> +     const unsigned long *scan_masks;
>> +     int num_channels;
>
> const u8 or u32 ?
>
>> +     int read_size;
>
> const u8

Ok not sure saving 2 or 4 bytes of memory really matters that much :).

>
>> +     /* bit-check for valid input */
>> +     int status_bit;
>
> const bool ?

It is a bitmask of a single bit for the validation. I guess it could
be const u32
>
> You can save some slop in here, see also:
> http://www.catb.org/esr/structure-packing/
>
>> +};
>> +
>> +const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
>> +     [MAX6675] = {
>> +                     .channels = max6675_channels,
>> +                     .num_channels = ARRAY_SIZE(max6675_channels),
>> +                     .read_size = 2,
>> +                     .status_bit = BIT(2),
>> +             },
>> +     [MAX31855] = {
>> +                     .channels = max31855_channels,
>> +                     .num_channels = ARRAY_SIZE(max31855_channels),
>> +                     .read_size = 4,
>> +                     .scan_masks = max31855_scan_masks,
>> +                     .status_bit = BIT(16),
>> +             },
>> +};
> [...]
>
> --
> Best regards,
> Marek Vasut
