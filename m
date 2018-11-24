Return-Path: <SRS0=qhg/=OD=poczta.fm=sst@kernel.org>
Date: Sat, 24 Nov 2018 09:21:47 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad5933: finalized device-tree support
Message-ID: <20181124082147.GA8213@x220.localdomain>
References: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On lis 23, 2018 21:51, Marcelo Schmitt wrote:
> Added a of_device_id struct variable and subsequent call to
> MODULE_DEVICE_TABLE macro to complete device-tree support for this
> driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index edb8b540bbf1..19e8b6d2865c 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, ad5933_id);
>  
> +static const struct of_device_id ad5933_of_match[] = {
> +	{ .compatible = "analog-devices,ad5933" },
> +	{ .compatible = "analog-devices,ad5934" },

Why "analog-devices", rather than "adi"? My understanding is that analog devices
have "adi" as a manufacture part in compatible.

> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad5933_of_match);
> +
>  static struct i2c_driver ad5933_driver = {
>  	.driver = {
>  		.name = "ad5933",
> +		.of_match_table = ad5933_of_match,
>  	},
>  	.probe = ad5933_probe,
>  	.remove = ad5933_remove,

-- 
Slawomir Stepien
