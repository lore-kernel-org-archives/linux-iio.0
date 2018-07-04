Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42891 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeGDWGs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2018 18:06:48 -0400
Received: by mail-ua0-f193.google.com with SMTP id x18-v6so4219706uaj.9
        for <linux-iio@vger.kernel.org>; Wed, 04 Jul 2018 15:06:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530376365-23946-5-git-send-email-akinobu.mita@gmail.com>
References: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com> <1530376365-23946-5-git-send-email-akinobu.mita@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Jul 2018 01:06:46 +0300
Message-ID: <CAHp75VfADqXh4DUqPT-9Cd2ER5Zk_mFRC3tUFNrk+aCRTL=1cg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iio: accel: adxl345: add sampling frequency support
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jun 30, 2018 at 7:32 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> The ADXL345 provides selectable output data rate.  This adds the iio
> channel information for the sampling frequency with that feature.

> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               n = div_s64(val * NHZ_PER_HZ + val2, ADXL345_BASE_RATE_NANO_HZ);

> +               n = ilog2(max_t(s64, n, 1));

(1)

> +
> +               return regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,
> +                                         ADXL345_BW_RATE,

> +                                         min_t(int, n, ADXL345_BW_RATE));

(2)

Yes, looks pretty much good!
Though, bit manipulations would be sligtly shorter

Instead of (1) and (2) just do

clamp_t(ilog2(n), 0, ..._RATE)

-- 
With Best Regards,
Andy Shevchenko
