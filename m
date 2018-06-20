Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46915 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeFTATQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jun 2018 20:19:16 -0400
Received: by mail-ua0-f196.google.com with SMTP id d7-v6so1007120uam.13
        for <linux-iio@vger.kernel.org>; Tue, 19 Jun 2018 17:19:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529337552-23726-3-git-send-email-akinobu.mita@gmail.com>
References: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com> <1529337552-23726-3-git-send-email-akinobu.mita@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Jun 2018 03:19:15 +0300
Message-ID: <CAHp75VfwBVpFeknMbeTN4D4ZbfboJkVVxFdWsR1KZhRNo-CEfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: accel: adxl345: use scan_index for accessing
 accel registers
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 18, 2018 at 6:59 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> Currently the address field in iio_chan_spec is filled with an accel
> data register address for the corresponding axis.
>
> In preparation for adding calibration offset support, this makes use of
> scan_index field to access accel data registers instead of using address
> field.  This change makes it easier to access both accel registers and
> calibration offset registers with fewer lines of code as these are
> located in X-axis, Y-axis, Z-axis order.

> +               ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0 +
> +                                      sizeof(regval) * chan->scan_index,
> +                                      &regval, sizeof(regval));

Can't we do something like

#define ADXL345_REG_DATA_AXIS(si)  (0x32 + (si) * sizeof(__le16))

instead and use where applicable?

-- 
With Best Regards,
Andy Shevchenko
