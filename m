Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60944 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcDWVSl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2016 17:18:41 -0400
Subject: Re: [patch] iio: light: apds9960: silence uninitialized variable
 warning
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20160422100414.GG11398@mwanda>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9772b4fa-8a26-9ddd-7a16-c6f404cccbc1@kernel.org>
Date: Sat, 23 Apr 2016 22:18:38 +0100
MIME-Version: 1.0
In-Reply-To: <20160422100414.GG11398@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/04/16 11:04, Dan Carpenter wrote:
> It causes a static checker warning if we use "buf" on the failure path
> so move that inside the if statement.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied to the togreg branch of iio.git,

Thanks,

Jonathan
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index a6af56a..fbdd172 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -491,9 +491,10 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
>  		case IIO_INTENSITY:
>  			ret = regmap_bulk_read(data->regmap, chan->address,
>  					       &buf, 2);
> -			if (!ret)
> +			if (!ret) {
>  				ret = IIO_VAL_INT;
> -			*val = le16_to_cpu(buf);
> +				*val = le16_to_cpu(buf);
> +			}
>  			break;
>  		default:
>  			ret = -EINVAL;
> 

