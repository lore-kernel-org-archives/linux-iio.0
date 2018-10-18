Return-Path: <SRS0=DeMt=M6=oracle.com=dan.carpenter@kernel.org>
Date: Thu, 18 Oct 2018 15:55:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 1/2] staging: iio: ad7606: Move out of staging
Message-ID: <20181018125502.2hnp3s45lk6dggqt@mwanda>
References: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 18, 2018 at 12:10:32PM +0300, Stefan Popa wrote:
> +static int ad7606_read_samples(struct ad7606_state *st)
> +{
> +	unsigned int num = st->chip_info->num_channels;
> +	u16 *data = st->data;
> +	int ret;
> +
> +	/*
> +	 * The frstdata signal is set to high while and after reading the sample
> +	 * of the first channel and low for all other channels. This can be used
> +	 * to check that the incoming data is correctly aligned. During normal
> +	 * operation the data should never become unaligned, but some glitch or
> +	 * electrostatic discharge might cause an extra read or clock cycle.
> +	 * Monitoring the frstdata signal allows to recover from such failure
> +	 * situations.
> +	 */
> +
> +	if (st->gpio_frstdata) {
> +		ret = st->bops->read_block(st->dev, 1, data);
> +		if (ret)
> +			return ret;
> +
> +		if (!gpiod_get_value(st->gpio_frstdata)) {

This check should maybe be:

		if (gpiod_get_value(st->gpio_frstdata) <= 0) {

(Or possibly not, I don't know the code very well).

> +			ad7606_reset(st);
> +			return -EIO;
> +		}
> +
> +		data++;
> +		num--;
> +	}
> +
> +	return st->bops->read_block(st->dev, num, data);
> +}

regards,
dan carpenter
