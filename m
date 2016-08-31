Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33787 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759664AbcHaI6g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2016 04:58:36 -0400
Received: by mail-oi0-f42.google.com with SMTP id c15so61631455oig.0
        for <linux-iio@vger.kernel.org>; Wed, 31 Aug 2016 01:58:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1608261007030.3645@pmeerw.net>
References: <1472198348-31201-1-git-send-email-linus.walleij@linaro.org>
 <1472198348-31201-2-git-send-email-linus.walleij@linaro.org> <alpine.DEB.2.02.1608261007030.3645@pmeerw.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Aug 2016 10:58:33 +0200
Message-ID: <CACRpkdYMNGijuCYGuQGJXX09cv3VxnjGMtohw-r_zEyyUh8Zog@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Nick Vaccaro <nvaccaro@google.com>,
        Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 26, 2016 at 10:37 AM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:

> comments from a quick read below

Thanks, very good comments!

>> +#define MPU3050_X_OFFS_USRH  0x0C
>
> should probably end in _H to match the comment above

Fixed.

>> +/*
>> + * Fullscale precision is (for finest precision) +/- 250 deg/s, so the full
>> + * scale is actually 500 deg/s. All 16 bits are then used to cover this scale,
>> + * so 2^15 positive numbers and 2^15 negative numbers.
>
> I don't get comment regarding 16 bits; does it mean -32768 is not used?

My confusion. Albeit it is not even documented, values are of course in
two's complement, so -32768 to 32767 with one zero. 2^15 values,
not 2^15+1. Fixing this everywhere.

>> +     msleep(50 + 1000/mpu3050_get_freq(mpu3050));
>
> maybe space around /

OK

>> +     struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>> +     int ret = -EINVAL;
>
> I'd rather not init ret and directly
> return -EINVAL instead of break

OK fixed this, and found a bug.

>> +             case IIO_ANGL_VEL:
>> +                     /*
>> +                      * Convert to the corresponding full scale in
>> +                      * radians. All 16 bits are used with sign to
>> +                      * span the available scale.
>> +                      */
>> +                     *val = mpu3050_fs_precision[mpu3050->fullscale];
>> +                     *val2 = S16_MAX + 1; /* 2^15 + 1 (also the zero) */
>
> really 2^15 + 1

No I guess what I should be doing is a fraction like 2/(2^16) so we
cover the range properly.

Like so:

*val = mpu3050_fs_precision[mpu3050->fullscale] * 2;
*val2 = U16_MAX;

>> +             /*
>> +              * We support +/-250, +/-500, +/-1000 and +/2000 deg/s
>> +              * which means we need to round to the closest radians
>> +              * which will be roughly +/-4.3, +/-8.7, +/-17.5, +/-35
>> +              * rad/s. The scale is then for the 16 bits used to cover
>> +              * it 1/(2^15+1) of that.
>
> 2^15 + 1?

Fixing this too.

>> +                     ret = regmap_bulk_read(mpu3050->map,
>> +                                            MPU3050_FIFO_R,
>> +                                            &fifo_values[offset],
>> +                                            toread);
>> +
>> +                     dev_dbg(mpu3050->dev,
>> +                             "%04x %04x %04x %04x %04x\n",
>> +                             fifo_values[0],
>
> should probably use be16_to_cpu() on the values read for debug output

No here I really want to see the raw values from the FIFO in their
native endianness.

>> +             dev_err(mpu3050->dev, "Cannot enable regulators\n");
>
> most messages start lowercase in this driver

OK

>> +             dev_err(mpu3050->dev, "error putting MPU-3050 to sleep\n");
>
> necessary to mention the part name (MPU-3050) in the message?

No.

>> +             dev_err(mpu3050->dev, "error disable MPU-3050 regulators\n");
>
> disabling

OK

>> +             ret = -ENXIO;
>
> ENODEV seems to be more popular in IIO

OK fixed everywhere.

Yours,
Linus Walleij
