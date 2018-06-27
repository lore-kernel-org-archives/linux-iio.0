Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44544 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeF0Wlw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jun 2018 18:41:52 -0400
Received: by mail-vk0-f66.google.com with SMTP id x4-v6so2141888vkx.11
        for <linux-iio@vger.kernel.org>; Wed, 27 Jun 2018 15:41:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529940163-5149-5-git-send-email-akinobu.mita@gmail.com>
References: <1529940163-5149-1-git-send-email-akinobu.mita@gmail.com> <1529940163-5149-5-git-send-email-akinobu.mita@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Jun 2018 01:41:50 +0300
Message-ID: <CAHp75Vf5EvfeC4mDrM+vHQpitD=0yiQX2aOD=Y0oP3MxYBBqFQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: accel: adxl345: add sampling frequency support
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 25, 2018 at 6:22 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> The ADXL345 provides selectable output data rate.  This adds the iio
> channel information for the sampling frequency with that feature.

> +#define ADXL345_BW_RATE                        GENMASK(3, 0)
> +#define ADXL345_BASE_RATE_NANO_HZ      97656250LL

> +               samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
> +                               (regval & ADXL345_BW_RATE);
> +               *val = div_s64_rem(samp_freq_nhz, 1000000000, val2);

Yep, looks cool!

> +               for (i = 0; i <= ADXL345_BW_RATE; i++) {
> +                       int nhz;
> +                       int hz;
> +
> +                       hz = div_s64_rem(ADXL345_BASE_RATE_NANO_HZ << i,
> +                                        1000000000, &nhz);
> +                       if (hz == val && nhz == val2) {
> +                               return regmap_update_bits(data->regmap,
> +                                                       ADXL345_REG_BW_RATE,
> +                                                       ADXL345_BW_RATE, i);
> +                       }
> +               }

But this one can be just loop-less.

Something like

res = div_s64_rem(val * 1000000000 + val2, ADXL345_BASE_RATE_NANO_HZ, &rem);
if (rem ...) // here to decide what margin is allowed, or choose
closest, or choose lower / higher.
 return regmap...(..., res);

And I guess you might want to use NSEC_PER_SEC. (Is it really period
or frequency? If latter, perhaps add HZ_PER_GHZ macro, we have in one
driver HZ_PER_MHZ, maybe in the future they would be consolidated
somewhere).

-- 
With Best Regards,
Andy Shevchenko
