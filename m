Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43321 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeFTAhL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jun 2018 20:37:11 -0400
Received: by mail-vk0-f66.google.com with SMTP id d74-v6so932994vke.10
        for <linux-iio@vger.kernel.org>; Tue, 19 Jun 2018 17:37:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529337552-23726-5-git-send-email-akinobu.mita@gmail.com>
References: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com> <1529337552-23726-5-git-send-email-akinobu.mita@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Jun 2018 03:37:09 +0300
Message-ID: <CAHp75VfM=WAe_UVqD7qQQHOZDekpVYUSueyqi++TXamsJ5xO9A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: accel: adxl345: add sampling frequency support
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 18, 2018 at 6:59 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> The ADXL345 provides selectable output data rate.  This adds the iio
> channel information for the sampling frequency with that feature.

> +static const struct {
> +       int val;
> +       int val2;
> +} adxl345_samp_freq_table[] = {
> +       { 0, 97656 },
> +       { 0, 195313 },
> +       { 0, 390625 },
> +       { 0, 781250 },
> +       { 1, 562500 },
> +       { 3, 125000 },
> +       { 6, 250000 },
> +       { 12, 500000 },
> +       { 25, 0 },
> +       { 50, 0 },
> +       { 100, 0 },
> +       { 200, 0 },
> +       { 400, 0 },
> +       { 800, 0 },
> +       { 1600, 0 },
> +       { 3200, 0 },
> +};

So, this is effectively a just formula with a bit shifts (index is an
exponent) and point of origin.
Why to keep ugly table?

-- 
With Best Regards,
Andy Shevchenko
