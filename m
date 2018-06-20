Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45347 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbeFTA0f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jun 2018 20:26:35 -0400
Received: by mail-ua0-f194.google.com with SMTP id k14-v6so1019796uao.12
        for <linux-iio@vger.kernel.org>; Tue, 19 Jun 2018 17:26:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529337552-23726-4-git-send-email-akinobu.mita@gmail.com>
References: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com> <1529337552-23726-4-git-send-email-akinobu.mita@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Jun 2018 03:26:34 +0300
Message-ID: <CAHp75VcnOrMSw6Ywby=UfYVwrMD4Wo_nw=nWhhrkYWP6RQaCtw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: accel: adxl345: add calibration offset support
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 18, 2018 at 6:59 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> The ADXL345 provides the offset adjustment registers for each axis.
> This adds the iio channel information for the calibraion offsets with
> that feature.

>  #define ADXL345_REG_DEVID              0x00
> +#define ADXL345_REG_OFSX               0x1e
> +#define ADXL345_REG_OFSY               0x1f
> +#define ADXL345_REG_OFSZ               0x20

+ #define ADXL345_REG_OSF_AXIS(si) (0x1e + (si))

> -       __le16 regval;
> +       __le16 accel;

I would rather split renamint to a separate change.

>                 ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0 +
> -                                      sizeof(regval) * chan->scan_index,
> -                                      &regval, sizeof(regval));
> +                                      sizeof(accel) * chan->scan_index, &accel,
> +                                      sizeof(accel));

This hunk would be cleaner after addressing my proposal for patch 2.

> +       case IIO_CHAN_INFO_CALIBBIAS:
> +               ret = regmap_read(data->regmap,
> +                                 ADXL345_REG_OFSX + chan->scan_index, &regval);

So, for my opinion an axis agnostic macro would suit better above and here.

> +               return regmap_write(data->regmap,
> +                                   ADXL345_REG_OFSX + chan->scan_index,
> +                                   val / 4);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
