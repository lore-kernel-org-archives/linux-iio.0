Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33944 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbdB0PgH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 10:36:07 -0500
Received: by mail-it0-f66.google.com with SMTP id r141so1196142ita.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2017 07:36:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488209351-351-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com> <1488209351-351-1-git-send-email-narcisaanamaria12@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 27 Feb 2017 17:36:00 +0200
Message-ID: <CAEnQRZDr5xF3QNYgEFeyvXwZ4Vh5wHJFmRhvYbAjDn3ZGYtTig@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: iio: ad9832: Moved
 contents of header file to source file
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 27, 2017 at 5:29 PM, Narcisa Ana Maria Vasile
<narcisaanamaria12@gmail.com> wrote:
> The contents of the header file are used only by this single source
> file.
>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> ---
> Changes in v2:
>     Removed the platform data struct from the ad9832.c file and added it
>     back to the ad9832.h header file, since this struct is supposed to be
>     used from somewhere else, other than the driver.
> ---
>  drivers/staging/iio/frequency/ad9832.c | 27 ++-----------------------
>  drivers/staging/iio/frequency/ad9832.h | 36 ++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/staging/iio/frequency/ad9832.h
>
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 1b26843..8d40c8e 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -20,6 +20,8 @@
>  #include <linux/iio/sysfs.h>
>  #include "dds.h"
>
> +#include "ad9832.h"
> +
>  /* Registers */
>
>  #define AD9832_FREQ0LL         0x0
> @@ -112,31 +114,6 @@ struct ad9832_state {
>         };
>  };
>
> -/*
> - * TODO: struct ad9832_platform_data needs to go into include/linux/iio
> - */
> -
> -/**
> - * struct ad9832_platform_data - platform specific information
> - * @mclk:              master clock in Hz
> - * @freq0:             power up freq0 tuning word in Hz
> - * @freq1:             power up freq1 tuning word in Hz
> - * @phase0:            power up phase0 value [0..4095] correlates with 0..2PI
> - * @phase1:            power up phase1 value [0..4095] correlates with 0..2PI
> - * @phase2:            power up phase2 value [0..4095] correlates with 0..2PI
> - * @phase3:            power up phase3 value [0..4095] correlates with 0..2PI
> - */
> -
> -struct ad9832_platform_data {
> -       unsigned long           mclk;
> -       unsigned long           freq0;
> -       unsigned long           freq1;
> -       unsigned short          phase0;
> -       unsigned short          phase1;
> -       unsigned short          phase2;
> -       unsigned short          phase3;
> -};
> -
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>         unsigned long long freqreg = (u64)fout *
> diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
> new file mode 100644
> index 0000000..39d326c
> --- /dev/null
> +++ b/drivers/staging/iio/frequency/ad9832.h
> @@ -0,0 +1,36 @@
> +/*
> + * AD9832 SPI DDS driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +#ifndef IIO_DDS_AD9832_H_
> +#define IIO_DDS_AD9832_H_
> +
> +/*
> + * TODO: struct ad9832_platform_data needs to go into include/linux/iio
> + */
> +
> +/**
> + * struct ad9832_platform_data - platform specific information
> + * @mclk:              master clock in Hz
> + * @freq0:             power up freq0 tuning word in Hz
> + * @freq1:             power up freq1 tuning word in Hz
> + * @phase0:            power up phase0 value [0..4095] correlates with 0..2PI
> + * @phase1:            power up phase1 value [0..4095] correlates with 0..2PI
> + * @phase2:            power up phase2 value [0..4095] correlates with 0..2PI
> + * @phase3:            power up phase3 value [0..4095] correlates with 0..2PI
> + */
> +
> +struct ad9832_platform_data {
> +       unsigned long           mclk;
> +       unsigned long           freq0;
> +       unsigned long           freq1;
> +       unsigned short          phase0;
> +       unsigned short          phase1;
> +       unsigned short          phase2;
> +       unsigned short          phase3;
> +};
> +
> +#endif /* IIO_DDS_AD9832_H_ */

Hi,

It seems that you have sent a diff relative to v1. This isn't OK,
because v1 isn't already applied
to maintainers tree.

Please send a patch against the original code.

thanks,
Daniel.
