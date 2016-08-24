Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32840 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbcHXE6c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 00:58:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so943443wme.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2016 21:56:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1608240621280.24751@pmeerw.net>
References: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
 <1471923894-12194-3-git-send-email-mranostay@gmail.com> <alpine.DEB.2.02.1608230735270.12003@pmeerw.net>
 <CAKzfze_Yc7EPekKcSybWBO-Noq_wuYaLx8qKeBSni_8+QSBEsg@mail.gmail.com> <alpine.DEB.2.02.1608240621280.24751@pmeerw.net>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 23 Aug 2016 21:39:22 -0700
Message-ID: <CAKzfze_=9Yb-BijwU_5ChB2sLts+vU=t+fnfO7V6hOjuT2MiqQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: chemical: vz89x: add support for VZ89TE part
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 23, 2016 at 9:23 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>> >> -static int vz89x_get_resistance_reading(struct vz89x_data *data)
>> >> +static int vz89x_get_resistance_reading(struct vz89x_data *data,
>> >> +                                     struct iio_chan_spec const *chan,
>> >> +                                     int *val)
>> >>  {
>> >> -     u8 *buf = &data->buffer[VZ89X_VOC_RESISTANCE_IDX];
>> >> +     u32 tmp = *((u32 *) ((u8 *) &data->buffer[chan->address]));
>> >> +
>> >> +     switch (chan->scan_type.endianness) {
>> >> +     case IIO_LE:
>> >> +             *val = le32_to_cpu(tmp) & GENMASK(23, 0);
>> >
>> > could use le32_to_cpup() probably
>>
>> Except we need to apply the mask anyway...
>
> but you may save the ugly casting
>

Ah right but wouldn't for big endian case still require it?.....

> p.
>
> --
>
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
