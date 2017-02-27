Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48643 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdB0KCz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 05:02:55 -0500
Subject: Re: [PATCH] staging: iio: ad9832: Moved contents of header file to
 source file
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <453fa622-ffa9-4c62-6ad9-7dcab1e87f18@metafoo.de>
Date: Mon, 27 Feb 2017 10:20:49 +0100
MIME-Version: 1.0
In-Reply-To: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/26/2017 10:43 PM, Narcisa Ana Maria Vasile wrote:
> The contents of the header file are used only by this single source file.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>

Hi,

Moving the registers define and state struct is OK. But the platform data
struct should stay in a separate header as it is supposed to be used from
somewhere else other than the driver. See the TODO comment right above the
struct.

[...]
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
>  
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {

