Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37111 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbdBSLHj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 06:07:39 -0500
Subject: Re: [PATCH] Staging: iio: impedance-analyzer: ad5933.c - style fix
To: Derek Robson <robsonde@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
References: <20170212072240.30147-1-robsonde@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fac4dc81-3d56-9592-f20b-9fcce1f5dffb@kernel.org>
Date: Sun, 19 Feb 2017 11:07:08 +0000
MIME-Version: 1.0
In-Reply-To: <20170212072240.30147-1-robsonde@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/02/17 07:22, Derek Robson wrote:
> Change permissions to octal style.
> Found using checkpatch
> 
> Signed-off-by: Derek Robson <robsonde@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Jonathan
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 5e96352fa4ac..297665d3fe11 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -345,12 +345,12 @@ static ssize_t ad5933_store_frequency(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> -static IIO_DEVICE_ATTR(out_voltage0_freq_start, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(out_voltage0_freq_start, 0644,
>  			ad5933_show_frequency,
>  			ad5933_store_frequency,
>  			AD5933_REG_FREQ_START);
>  
> -static IIO_DEVICE_ATTR(out_voltage0_freq_increment, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(out_voltage0_freq_increment, 0644,
>  			ad5933_show_frequency,
>  			ad5933_store_frequency,
>  			AD5933_REG_FREQ_INC);
> @@ -469,32 +469,32 @@ static ssize_t ad5933_store(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> -static IIO_DEVICE_ATTR(out_voltage0_scale, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(out_voltage0_scale, 0644,
>  			ad5933_show,
>  			ad5933_store,
>  			AD5933_OUT_RANGE);
>  
> -static IIO_DEVICE_ATTR(out_voltage0_scale_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(out_voltage0_scale_available, 0444,
>  			ad5933_show,
>  			NULL,
>  			AD5933_OUT_RANGE_AVAIL);
>  
> -static IIO_DEVICE_ATTR(in_voltage0_scale, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(in_voltage0_scale, 0644,
>  			ad5933_show,
>  			ad5933_store,
>  			AD5933_IN_PGA_GAIN);
>  
> -static IIO_DEVICE_ATTR(in_voltage0_scale_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(in_voltage0_scale_available, 0444,
>  			ad5933_show,
>  			NULL,
>  			AD5933_IN_PGA_GAIN_AVAIL);
>  
> -static IIO_DEVICE_ATTR(out_voltage0_freq_points, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(out_voltage0_freq_points, 0644,
>  			ad5933_show,
>  			ad5933_store,
>  			AD5933_FREQ_POINTS);
>  
> -static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
>  			ad5933_show,
>  			ad5933_store,
>  			AD5933_OUT_SETTLING_CYCLES);
> 

