Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9807 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751390AbdB0Plf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 10:41:35 -0500
Date: Mon, 27 Feb 2017 16:37:47 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2] staging: iio: ad9832: Moved contents
 of header file to source file
In-Reply-To: <1488209351-351-1-git-send-email-narcisaanamaria12@gmail.com>
Message-ID: <alpine.DEB.2.20.1702271636180.3032@hadrien>
References: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com> <1488209351-351-1-git-send-email-narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Mon, 27 Feb 2017, Narcisa Ana Maria Vasile wrote:

> The contents of the header file are used only by this single source
> file.
>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> ---
> Changes in v2:
>     Removed the platform data struct from the ad9832.c file and added it
>     back to the ad9832.h header file, since this struct is supposed to be
>     used from somewhere else, other than the driver.

Did someone accept your previous patch?  Normally, you should always make
your patches against what is in Greg's tree, and not against your own
previous patch.  So I would expect to see only - lines in the .h file; now
you are removing less, but not adding anything.

julia



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
>  #define AD9832_FREQ0LL		0x0
> @@ -112,31 +114,6 @@ struct ad9832_state {
>  	};
>  };
>
> -/*
> - * TODO: struct ad9832_platform_data needs to go into include/linux/iio
> - */
> -
> -/**
> - * struct ad9832_platform_data - platform specific information
> - * @mclk:		master clock in Hz
> - * @freq0:		power up freq0 tuning word in Hz
> - * @freq1:		power up freq1 tuning word in Hz
> - * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
> - * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
> - * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
> - * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
> - */
> -
> -struct ad9832_platform_data {
> -	unsigned long		mclk;
> -	unsigned long		freq0;
> -	unsigned long		freq1;
> -	unsigned short		phase0;
> -	unsigned short		phase1;
> -	unsigned short		phase2;
> -	unsigned short		phase3;
> -};
> -
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout *
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
> + * @mclk:		master clock in Hz
> + * @freq0:		power up freq0 tuning word in Hz
> + * @freq1:		power up freq1 tuning word in Hz
> + * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
> + * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
> + * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
> + * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
> + */
> +
> +struct ad9832_platform_data {
> +	unsigned long		mclk;
> +	unsigned long		freq0;
> +	unsigned long		freq1;
> +	unsigned short		phase0;
> +	unsigned short		phase1;
> +	unsigned short		phase2;
> +	unsigned short		phase3;
> +};
> +
> +#endif /* IIO_DDS_AD9832_H_ */
> --
> 1.9.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1488209351-351-1-git-send-email-narcisaanamaria12%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
