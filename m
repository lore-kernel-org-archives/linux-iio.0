Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44083 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbCIPCd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 11:02:33 -0400
Message-ID: <54FDB606.8000206@kernel.org>
Date: Mon, 09 Mar 2015 15:02:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH 1/7] iio: mlx90614: Refactor register symbols
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com> <1424879712-28304-2-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1424879712-28304-2-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
> The defined registers only make sense when used for accessing RAM. Make
> MLX90614_OP_RAM part of the symbol definition to avoid accidental access
> to the wrong register.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
Seems an entirely sensible change.

Applied to the togreg branch of iio.git.  Initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/temperature/mlx90614.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index c8b6ac8..e2c6f1a 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -23,8 +23,8 @@
>  #define MLX90614_OP_RAM 0x00
>  
>  /* RAM offsets with 16-bit data, MSB first */
> -#define MLX90614_TA 0x06 /* ambient temperature */
> -#define MLX90614_TOBJ1 0x07 /* object temperature */
> +#define MLX90614_TA	(MLX90614_OP_RAM | 0x06) /* ambient temperature */
> +#define MLX90614_TOBJ1	(MLX90614_OP_RAM | 0x07) /* object 1 temperature */
>  
>  struct mlx90614_data {
>  	struct i2c_client *client;
> @@ -42,13 +42,13 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  		switch (channel->channel2) {
>  		case IIO_MOD_TEMP_AMBIENT:
>  			ret = i2c_smbus_read_word_data(data->client,
> -			    MLX90614_OP_RAM | MLX90614_TA);
> +			    MLX90614_TA);
>  			if (ret < 0)
>  				return ret;
>  			break;
>  		case IIO_MOD_TEMP_OBJECT:
>  			ret = i2c_smbus_read_word_data(data->client,
> -			    MLX90614_OP_RAM | MLX90614_TOBJ1);
> +			    MLX90614_TOBJ1);
>  			if (ret < 0)
>  				return ret;
>  			break;
> 

