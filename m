Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37397 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeGDWMU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2018 18:12:20 -0400
Received: by mail-ua0-f193.google.com with SMTP id u8-v6so4236335uao.4
        for <linux-iio@vger.kernel.org>; Wed, 04 Jul 2018 15:12:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
References: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Jul 2018 01:12:19 +0300
Message-ID: <CAHp75VcShwz3i5YvipN-1dGCw4buRGPDSZVi28=E_uNgp=Dp9A@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] iio: accel: adxl345: add calibration offset and
 sampling frequency support
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jun 30, 2018 at 7:32 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> This patchset adds calibration offset and sampling frequency support for
> adxl345 driver with some preparatory changes.
>

One small comment to patch 5, otherwise FWIW,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> * v5 (Suggested by Andy Shevchenko)
> - Introduce constant for nHZ per HZ
> - Find an register setting without looping over all available frequencies
> - Allow all user supplied values and round to an available frequency
>
> * v4 (Suggested by Jonathan Cameron)
> - Stop abusing scan_index and keep using address field in iio_chan_spec
>
> * v3 (Suggested by Andy Shevchenko)
> - Define ADXL345_REG_DATA_AXIS(si) for cleaner register access
> - Define ADXL345_REG_OSF_AXIS(si) for cleaner register access
> - Calculate sampling frequency at runtime instead of having constant table
>
> * v2
> - Adjust the value for the calibbias to make the same scale as the _raw
>   measurement, and remove misused calibscale.
>
> Akinobu Mita (4):
>   iio: accel: adxl345: add link to datasheet
>   iio: accel: adxl345: convert address field usage in iio_chan_spec
>   iio: accel: adxl345: add calibration offset support
>   iio: accel: adxl345: add sampling frequency support
>
>  drivers/iio/accel/adxl345_core.c | 121 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 110 insertions(+), 11 deletions(-)
>
> Cc: Eva Rachel Retuya <eraretuya@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
