Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeF3RWY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 13:22:24 -0400
Date: Sat, 30 Jun 2018 18:22:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging:iio:impedance-analyzer:ad5933: Macro
 replacement Cleanups.
Message-ID: <20180630182219.31c668d0@archlinux>
In-Reply-To: <20180625191123.3685-1-karim.eshapa@gmail.com>
References: <20180625191123.3685-1-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Jun 2018 21:11:23 +0200
Karim Eshapa <karim.eshapa@gmail.com> wrote:

> Doing some macro replacement to start an array of structures
> so it can be reused by manipulating it with different values.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
There are all sorts of issues with the ABI this driver is providing to
userspace, but this isn't a bad bit of cleanup none the less.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 57 +++++++------------
>  1 file changed, 19 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 3bcf49466361..14df89510396 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -116,45 +116,26 @@ static struct ad5933_platform_data ad5933_default_pdata  = {
>  	.vref_mv = 3300,
>  };
>  
> +#define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _address, \
> +		_scan_index, _realbits) { \
> +	.type = (_type), \
> +	.extend_name = (_extend_name), \
> +	.info_mask_separate = (_info_mask_separate), \
> +	.address = (_address), \
> +	.scan_index = (_scan_index), \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = (_realbits), \
> +		.storagebits = 16, \
> +	}, \
> +}
> +
>  static const struct iio_chan_spec ad5933_channels[] = {
> -	{
> -		.type = IIO_TEMP,
> -		.indexed = 1,
> -		.channel = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -		.address = AD5933_REG_TEMP_DATA,
> -		.scan_index = -1,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> -	}, { /* Ring Channels */
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 0,
> -		.extend_name = "real",
> -		.address = AD5933_REG_REAL_DATA,
> -		.scan_index = 0,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 16,
> -			.storagebits = 16,
> -		},
> -	}, {
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 0,
> -		.extend_name = "imag",
> -		.address = AD5933_REG_IMAG_DATA,
> -		.scan_index = 1,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 16,
> -			.storagebits = 16,
> -		},
> -	},
> +	AD5933_CHANNEL(IIO_TEMP, NULL, BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE), AD5933_REG_TEMP_DATA, -1, 14),
> +	/* Ring Channels */
> +	AD5933_CHANNEL(IIO_VOLTAGE, "real", 0, AD5933_REG_REAL_DATA, 0, 16),
> +	AD5933_CHANNEL(IIO_VOLTAGE, "imag", 0, AD5933_REG_IMAG_DATA, 1, 16),
>  };
>  
>  static int ad5933_i2c_write(struct i2c_client *client, u8 reg, u8 len, u8 *data)

