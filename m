Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42714 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbdDII00 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Apr 2017 04:26:26 -0400
Subject: Re: [PATCH v3 2/2] iio:meter:ade7759: realign the rest with opening
 bracket
To: Chen Guanqiao <chen.chenchacha@foxmail.com>, pmeerw@pmeerw.net
References: <260495ce-b068-a5ce-6ec3-a90fdd7e2510@foxmail.com>
 <20170409043027.13930-1-chen.chenchacha@foxmail.com>
 <20170409043027.13930-3-chen.chenchacha@foxmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
Message-ID: <a6af82bd-6dc0-cbe0-dab9-248645c0e3ff@kernel.org>
Date: Sun, 9 Apr 2017 09:26:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170409043027.13930-3-chen.chenchacha@foxmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/04/17 05:30, Chen Guanqiao wrote:
> This fixes the coding style issue of using (S_IWUSR | S_IRUGO) in place of
> 4-digit octal numbers with realign the rest with opening bracket.
> 
> Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
Sorry, nope.  That wasn't what I meant.  The parameters should stay on the
first line, but the later parameters should then be aligned with the first
ones.

e.g.
static IIO_DEV_ATTR_CH_OFF(1, 0644,
			   ade7759_read_8bit,
			   ade7759_write_8bit,
			   ADE7759_CH10S);

or given the multiple line format doesn't really help with readability...
static IIO_DEV_ATTR_CH_OFF(1, 0644, ade7759_read_8bit, ade7759_write_8bit,
			   ADE7759_CH10S);

Key bit is aligning with the opening bracket.

First patch is now applied, so just post the update of this one if you
want to tidy this up.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/meter/ade7759.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 68405046dae3..9ddfa4ec7da9 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -317,11 +317,15 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>  		ade7759_read_16bit,
>  		ade7759_write_16bit,
>  		ADE7759_APGAIN);
> -static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CH_OFF(
> +		1,
> +		0644,
>  		ade7759_read_8bit,
>  		ade7759_write_8bit,
>  		ADE7759_CH1OS);
> -static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CH_OFF(
> +		2,
> +		0644,
>  		ade7759_read_8bit,
>  		ade7759_write_8bit,
>  		ADE7759_CH2OS);
> 

