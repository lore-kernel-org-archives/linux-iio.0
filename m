Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34554 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeGFQIa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jul 2018 12:08:30 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so3083502plo.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Jul 2018 09:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
 <1530376365-23946-5-git-send-email-akinobu.mita@gmail.com> <CAHp75VfADqXh4DUqPT-9Cd2ER5Zk_mFRC3tUFNrk+aCRTL=1cg@mail.gmail.com>
In-Reply-To: <CAHp75VfADqXh4DUqPT-9Cd2ER5Zk_mFRC3tUFNrk+aCRTL=1cg@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 7 Jul 2018 01:08:18 +0900
Message-ID: <CAC5umyjerEZ6pWePwz-N13s+qbuDfXwUVACsu2akrBnnV1FNmQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iio: accel: adxl345: add sampling frequency support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2018=E5=B9=B47=E6=9C=885=E6=97=A5(=E6=9C=A8) 7:06 Andy Shevchenko <andy.she=
vchenko@gmail.com>:
>
> On Sat, Jun 30, 2018 at 7:32 PM, Akinobu Mita <akinobu.mita@gmail.com> wr=
ote:
> > The ADXL345 provides selectable output data rate.  This adds the iio
> > channel information for the sampling frequency with that feature.
>
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               n =3D div_s64(val * NHZ_PER_HZ + val2, ADXL345_BASE_RAT=
E_NANO_HZ);
>
> > +               n =3D ilog2(max_t(s64, n, 1));
>
> (1)
>
> > +
> > +               return regmap_update_bits(data->regmap, ADXL345_REG_BW_=
RATE,
> > +                                         ADXL345_BW_RATE,
>
> > +                                         min_t(int, n, ADXL345_BW_RATE=
));
>
> (2)
>
> Yes, looks pretty much good!
> Though, bit manipulations would be sligtly shorter
>
> Instead of (1) and (2) just do
>
> clamp_t(ilog2(n), 0, ..._RATE)

Sounds good.  I'll use clamp_val() instead of clamp_t().

        n =3D clamp_val(ilog2(n), 0, ADXL345_BW_RATE);
