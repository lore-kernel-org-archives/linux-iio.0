Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:43617 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab0FDK7E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2010 06:59:04 -0400
Message-ID: <4C08DC93.7080005@cam.ac.uk>
Date: Fri, 04 Jun 2010 11:59:31 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: gregkh@suse.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] adis16209/220/240/350: tuning spi delay to make hardware
 more stable
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com> <1275643194-25328-2-git-send-email-21cnbao@gmail.com> <1275643194-25328-3-git-send-email-21cnbao@gmail.com> <1275643194-25328-4-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1275643194-25328-4-git-send-email-21cnbao@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This clearly also fixes an incorrect message.   Obviously that is trivial
but it isn't apparent in commit message or comments.
> Signed-off-by: Barry Song <21cnbao@gmail.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/accel/adis16209_core.c |    6 ++++--
>  drivers/staging/iio/accel/adis16220_core.c |   12 ++++++------
>  drivers/staging/iio/accel/adis16240_core.c |    8 ++++----
>  drivers/staging/iio/imu/adis16350_core.c   |    8 ++++----
>  4 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index ac375c5..94491a1 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -76,11 +76,13 @@ static int adis16209_spi_write_reg_16(struct device *dev,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> +			.delay_usecs = 30,
>  		}, {
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> +			.delay_usecs = 30,
>  		},
>  	};
>  
> @@ -120,13 +122,13 @@ static int adis16209_spi_read_reg_16(struct device *dev,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 20,
> +			.delay_usecs = 30,
>  		}, {
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 20,
> +			.delay_usecs = 30,
>  		},
>  	};
>  
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
> index 6de439f..fffa49c 100644
> --- a/drivers/staging/iio/accel/adis16220_core.c
> +++ b/drivers/staging/iio/accel/adis16220_core.c
> @@ -72,13 +72,13 @@ static int adis16220_spi_write_reg_16(struct device *dev,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		}, {
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		},
>  	};
>  
> @@ -118,13 +118,13 @@ static int adis16220_spi_read_reg_16(struct device *dev,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		}, {
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		},
>  	};
>  
> @@ -291,9 +291,9 @@ static int adis16220_check_status(struct device *dev)
>  	if (status & ADIS16220_DIAG_STAT_FLASH_UPT)
>  		dev_err(dev, "Flash update failed\n");
>  	if (status & ADIS16220_DIAG_STAT_POWER_HIGH)
> -		dev_err(dev, "Power supply above 5.25V\n");
> +		dev_err(dev, "Power supply above 3.625V\n");
>  	if (status & ADIS16220_DIAG_STAT_POWER_LOW)
> -		dev_err(dev, "Power supply below 4.75V\n");
> +		dev_err(dev, "Power supply below 3.15V\n");
>  
>  error_ret:
>  	return ret;
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
> index 54fd6d7..731bca6 100644
> --- a/drivers/staging/iio/accel/adis16240_core.c
> +++ b/drivers/staging/iio/accel/adis16240_core.c
> @@ -74,13 +74,13 @@ static int adis16240_spi_write_reg_16(struct device *dev,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		}, {
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		},
>  	};
>  
> @@ -120,13 +120,13 @@ static int adis16240_spi_read_reg_16(struct device *dev,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		}, {
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		},
>  	};
>  
> diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
> index 0edde73..0bb19a9 100644
> --- a/drivers/staging/iio/imu/adis16350_core.c
> +++ b/drivers/staging/iio/imu/adis16350_core.c
> @@ -75,13 +75,13 @@ static int adis16350_spi_write_reg_16(struct device *dev,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		}, {
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		},
>  	};
>  
> @@ -121,13 +121,13 @@ static int adis16350_spi_read_reg_16(struct device *dev,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		}, {
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = 25,
> +			.delay_usecs = 35,
>  		},
>  	};
>  

