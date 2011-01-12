Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:55253 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab1ALLYZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jan 2011 06:24:25 -0500
Message-ID: <4D2D911F.3000203@cam.ac.uk>
Date: Wed, 12 Jan 2011 11:31:43 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] staging: iio: fix spi cs_change behaviour
References: <1294826147-30329-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1294826147-30329-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/12/11 09:55, Manuel Stahl wrote:
> The normal behaviour is:
>  * After all transfers except the last: CS stays active
>  * After the last transfer: CS goes inactive

Hi Manuel,

Thanks for doing this.

This ideally wants an ack from someone at Analog (Michael perhaps?)
given it touches so many of their drivers.

I'm not keen on the level of change in the lis3l02dq going in within
this set. The change looks worthwhile, but it isn't just fixing
the cs_change problem so it really shouldn't be in this patch.
We can put that one in place at a later date.
Same is true for the sca3000 driver.  Please just do the cs_change
fixes in this patch.

A few cases here remove cases where cs_change is set to 0 anyway.
Worthy cleanups, but not fixes.  Still those are at least within
the spirit of the fixes and don't really matter.

Feel free to add my ack to a version with the lis3l02dq and sca3000
cleanups removed (and appropriate cs_change patches for those two).
> 
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

> ---
>  drivers/staging/iio/accel/adis16201_core.c |    4 +-
>  drivers/staging/iio/accel/adis16201_ring.c |    2 +-
>  drivers/staging/iio/accel/adis16203_core.c |    4 +-
>  drivers/staging/iio/accel/adis16203_ring.c |    2 +-
>  drivers/staging/iio/accel/adis16204_core.c |    4 +-
>  drivers/staging/iio/accel/adis16204_ring.c |    2 +-
>  drivers/staging/iio/accel/adis16209_core.c |    4 +-
>  drivers/staging/iio/accel/adis16209_ring.c |    2 +-
>  drivers/staging/iio/accel/adis16220_core.c |    6 ++--
>  drivers/staging/iio/accel/adis16240_core.c |    4 +-
>  drivers/staging/iio/accel/adis16240_ring.c |    2 +-
>  drivers/staging/iio/accel/lis3l02dq_core.c |   34 +++++-----------------------
>  drivers/staging/iio/accel/lis3l02dq_ring.c |    5 +++-
>  drivers/staging/iio/accel/sca3000_core.c   |   15 +----------
>  drivers/staging/iio/gyro/adis16251_core.c  |    8 +++---
>  drivers/staging/iio/gyro/adis16260_core.c  |    4 +-
>  drivers/staging/iio/gyro/adis16260_ring.c  |    2 +-
>  drivers/staging/iio/imu/adis16300_core.c   |    4 +-
>  drivers/staging/iio/imu/adis16300_ring.c   |    2 -
>  drivers/staging/iio/imu/adis16350_core.c   |    4 +-
>  drivers/staging/iio/imu/adis16350_ring.c   |    2 -
>  drivers/staging/iio/imu/adis16400_core.c   |    4 +-
>  drivers/staging/iio/imu/adis16400_ring.c   |    2 -
>  23 files changed, 43 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
> index 79b785a..45fc2c7 100644
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ b/drivers/staging/iio/accel/adis16201_core.c
> @@ -80,7 +80,7 @@ static int adis16201_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> @@ -125,7 +125,7 @@ static int adis16201_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 20,
>  		},
>  	};
> diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
> index e6870a2..9f35663 100644
> --- a/drivers/staging/iio/accel/adis16201_ring.c
> +++ b/drivers/staging/iio/accel/adis16201_ring.c
> @@ -97,7 +97,7 @@ static int adis16201_read_ring_data(struct device *dev, u8 *rx)
>  	memset(xfers, 0, sizeof(xfers));
>  	for (i = 0; i <= ADIS16201_OUTPUTS; i++) {
>  		xfers[i].bits_per_word = 8;
> -		xfers[i].cs_change = 1;
> +		xfers[i].cs_change = (i < ADIS16201_OUTPUTS);
>  		xfers[i].len = 2;
>  		xfers[i].delay_usecs = 20;
>  		xfers[i].tx_buf = st->tx + 2 * i;
> diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
> index b57f190..adf7f16 100644
> --- a/drivers/staging/iio/accel/adis16203_core.c
> +++ b/drivers/staging/iio/accel/adis16203_core.c
> @@ -80,7 +80,7 @@ static int adis16203_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> @@ -125,7 +125,7 @@ static int adis16203_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 20,
>  		},
>  	};
> diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
> index 3d774f7..dc71406 100644
> --- a/drivers/staging/iio/accel/adis16203_ring.c
> +++ b/drivers/staging/iio/accel/adis16203_ring.c
> @@ -89,7 +89,7 @@ static int adis16203_read_ring_data(struct device *dev, u8 *rx)
>  	memset(xfers, 0, sizeof(xfers));
>  	for (i = 0; i <= ADIS16203_OUTPUTS; i++) {
>  		xfers[i].bits_per_word = 8;
> -		xfers[i].cs_change = 1;
> +		xfers[i].cs_change = (i < ADIS16203_OUTPUTS);
>  		xfers[i].len = 2;
>  		xfers[i].delay_usecs = 20;
>  		xfers[i].tx_buf = st->tx + 2 * i;
> diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
> index cc15e40..8c40cc3 100644
> --- a/drivers/staging/iio/accel/adis16204_core.c
> +++ b/drivers/staging/iio/accel/adis16204_core.c
> @@ -79,7 +79,7 @@ static int adis16204_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> @@ -124,7 +124,7 @@ static int adis16204_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 20,
>  		},
>  	};
> diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
> index 420b160..fa716b5 100644
> --- a/drivers/staging/iio/accel/adis16204_ring.c
> +++ b/drivers/staging/iio/accel/adis16204_ring.c
> @@ -87,7 +87,7 @@ static int adis16204_read_ring_data(struct device *dev, u8 *rx)
>  	memset(xfers, 0, sizeof(xfers));
>  	for (i = 0; i <= ADIS16204_OUTPUTS; i++) {
>  		xfers[i].bits_per_word = 8;
> -		xfers[i].cs_change = 1;
> +		xfers[i].cs_change = (i < ADIS16204_OUTPUTS);
>  		xfers[i].len = 2;
>  		xfers[i].delay_usecs = 20;
>  		xfers[i].tx_buf = st->tx + 2 * i;
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index e4ac956..d209df1 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -82,7 +82,7 @@ static int adis16209_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 30,
>  		},
>  	};
> @@ -128,7 +128,7 @@ static int adis16209_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 30,
>  		},
>  	};
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
> index 8eba0af..caac15e 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -103,7 +103,7 @@ static int adis16209_read_ring_data(struct device *dev, u8 *rx)
>  	memset(xfers, 0, sizeof(xfers));
>  	for (i = 0; i <= ADIS16209_OUTPUTS; i++) {
>  		xfers[i].bits_per_word = 8;
> -		xfers[i].cs_change = 1;
> +		xfers[i].cs_change = (i < ADIS16209_OUTPUTS);
>  		xfers[i].len = 2;
>  		xfers[i].delay_usecs = 30;
>  		xfers[i].tx_buf = st->tx + 2 * i;
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
> index 1c1e98a..f6b4977 100644
> --- a/drivers/staging/iio/accel/adis16220_core.c
> +++ b/drivers/staging/iio/accel/adis16220_core.c
> @@ -77,7 +77,7 @@ static int adis16220_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 35,
>  		},
>  	};
> @@ -123,7 +123,7 @@ static int adis16220_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 35,
>  		},
>  	};
> @@ -366,7 +366,7 @@ static ssize_t adis16220_capture_buffer_read(struct adis16220_state *st,
>  			.tx_buf = st->tx,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 25,
>  		},
>  	};
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
> index d11d164..dcd8cb8 100644
> --- a/drivers/staging/iio/accel/adis16240_core.c
> +++ b/drivers/staging/iio/accel/adis16240_core.c
> @@ -80,7 +80,7 @@ static int adis16240_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 35,
>  		},
>  	};
> @@ -126,7 +126,7 @@ static int adis16240_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 35,
>  		},
>  	};
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
> index f882e9c..5cf2fbf 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -91,7 +91,7 @@ static int adis16240_read_ring_data(struct device *dev, u8 *rx)
>  	memset(xfers, 0, sizeof(xfers));
>  	for (i = 0; i <= ADIS16240_OUTPUTS; i++) {
>  		xfers[i].bits_per_word = 8;
> -		xfers[i].cs_change = 1;
> +		xfers[i].cs_change = (i < ADIS16240_OUTPUTS);
>  		xfers[i].len = 2;
>  		xfers[i].delay_usecs = 30;
>  		xfers[i].tx_buf = st->tx + 2 * i;
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index c4b4ab7..9a93771 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -53,23 +53,9 @@ int lis3l02dq_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
>  	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
>  
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.rx_buf = st->rx,
> -		.bits_per_word = 8,
> -		.len = 2,
> -		.cs_change = 1,
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = LIS3L02DQ_READ_REG(reg_address);
> -	st->tx[1] = 0;
> -
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->us, &msg);
> -	*val = st->rx[1];
> -	mutex_unlock(&st->buf_lock);
> +	ret = spi_w8r8(st->us, LIS3L02DQ_READ_REG(reg_address));
> +	if (ret >= 0)
> +		*val = ret;
>  
>  	return ret;
>  }
> @@ -90,20 +76,12 @@ int lis3l02dq_spi_write_reg_8(struct device *dev,
>  	struct iio_sw_ring_helper_state *h
>  		= iio_dev_get_devdata(indio_dev);
>  	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.bits_per_word = 8,
> -		.len = 2,
> -		.cs_change = 1,
> -	};
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = LIS3L02DQ_WRITE_REG(reg_address);
>  	st->tx[1] = *val;
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->us, &msg);
> +	ret = spi_write(st->us, st->tx, 2);
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
> @@ -135,7 +113,7 @@ static int lis3l02dq_spi_write_reg_s16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> @@ -182,7 +160,7 @@ static int lis3l02dq_spi_read_reg_s16(struct device *dev,
>  			.rx_buf = st->rx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  
>  		},
>  	};
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index 1fd088a..c33f492 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -262,8 +262,11 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
>  	 * values in alternate bytes
>  	 */
>  	spi_message_init(&msg);
> -	for (j = 0; j < ring->scan_count * 2; j++)
> +	for (j = 0; j < ring->scan_count * 2; j++) {
> +		if (j == ring->scan_count * 2 - 1)
> +			xfers[j].cs_change = 0;
>  		spi_message_add_tail(&xfers[j], &msg);
> +	}
>  
>  	ret = spi_sync(st->us, &msg);
>  	mutex_unlock(&st->buf_lock);
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index 5b06dea..5ff8a8a 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -75,20 +75,10 @@ static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
>  
>  int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
>  {
> -	struct spi_transfer xfer = {
> -		.bits_per_word = 8,
> -		.len = 2,
> -		.cs_change = 1,
> -		.tx_buf = st->tx,
> -	};
> -	struct spi_message msg;
> -
>  	st->tx[0] = SCA3000_WRITE_REG(address);
>  	st->tx[1] = val;
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
>  
> -	return spi_sync(st->us, &msg);
> +	return spi_write(st->us, st->tx, 2);
>  }
>  
>  int sca3000_read_data(struct sca3000_state *st,
> @@ -101,7 +91,6 @@ int sca3000_read_data(struct sca3000_state *st,
>  	struct spi_transfer xfer = {
>  		.bits_per_word = 8,
>  		.len = len + 1,
> -		.cs_change = 1,
>  		.tx_buf = st->tx,
>  	};
>  
> @@ -173,7 +162,7 @@ static int __sca3000_unlock_reg_lock(struct sca3000_state *st)
>  		}, {
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.tx_buf = st->tx + 4,
>  		},
>  	};
> diff --git a/drivers/staging/iio/gyro/adis16251_core.c b/drivers/staging/iio/gyro/adis16251_core.c
> index a0d400f..9a2ef36 100644
> --- a/drivers/staging/iio/gyro/adis16251_core.c
> +++ b/drivers/staging/iio/gyro/adis16251_core.c
> @@ -81,7 +81,7 @@ static int adis16251_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> @@ -125,7 +125,7 @@ static int adis16251_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> @@ -174,7 +174,7 @@ int adis16251_spi_read_burst(struct device *dev, u8 *rx)
>  			.rx_buf = rx,
>  			.bits_per_word = 8,
>  			.len = 24,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> @@ -231,7 +231,7 @@ int adis16251_spi_read_sequence(struct device *dev,
>  			xfers[i].tx_buf = st->tx + 2*i;
>  		xfers[i].bits_per_word = 8;
>  		xfers[i].len = 2;
> -		xfers[i].cs_change = 1;
> +		xfers[i].cs_change = (i < num);
>  		spi_message_add_tail(&xfers[i], &msg);
>  	}
>  
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 045e27d..cd1fbf6 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -80,7 +80,7 @@ static int adis16260_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 20,
>  		},
>  	};
> @@ -126,7 +126,7 @@ static int adis16260_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 30,
>  		},
>  	};
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
> index 2342889..79e50c7 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -90,7 +90,7 @@ static int adis16260_read_ring_data(struct device *dev, u8 *rx)
>  	memset(xfers, 0, sizeof(xfers));
>  	for (i = 0; i <= ADIS16260_OUTPUTS; i++) {
>  		xfers[i].bits_per_word = 8;
> -		xfers[i].cs_change = 1;
> +		xfers[i].cs_change = (i < ADIS16260_OUTPUTS);
>  		xfers[i].len = 2;
>  		xfers[i].delay_usecs = 30;
>  		xfers[i].tx_buf = st->tx + 2 * i;
> diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
> index 7ad13f4..5c651ca 100644
> --- a/drivers/staging/iio/imu/adis16300_core.c
> +++ b/drivers/staging/iio/imu/adis16300_core.c
> @@ -82,7 +82,7 @@ static int adis16300_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 75,
>  		},
>  	};
> @@ -128,7 +128,7 @@ static int adis16300_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 75,
>  		},
>  	};
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
> index 114fdf4..1627354 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -114,12 +114,10 @@ static int adis16300_spi_read_burst(struct device *dev, u8 *rx)
>  			.tx_buf = st->tx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 0,
>  		}, {
>  			.rx_buf = rx,
>  			.bits_per_word = 8,
>  			.len = 18,
> -			.cs_change = 0,
>  		},
>  	};
>  
> diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
> index cf7176b..09f0691 100644
> --- a/drivers/staging/iio/imu/adis16350_core.c
> +++ b/drivers/staging/iio/imu/adis16350_core.c
> @@ -81,7 +81,7 @@ static int adis16350_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 35,
>  		},
>  	};
> @@ -127,7 +127,7 @@ static int adis16350_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  			.delay_usecs = 35,
>  		},
>  	};
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
> index 56b70cf..3653d8c 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -110,12 +110,10 @@ static int adis16350_spi_read_burst(struct device *dev, u8 *rx)
>  			.tx_buf = st->tx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 0,
>  		}, {
>  			.rx_buf = rx,
>  			.bits_per_word = 8,
>  			.len = 22,
> -			.cs_change = 0,
>  		},
>  	};
Technically this one doesn't change anything..
>  
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
> index cfb108a..1a60a5e 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -93,7 +93,7 @@ static int adis16400_spi_write_reg_16(struct device *dev,
>  			.tx_buf = st->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> @@ -137,7 +137,7 @@ static int adis16400_spi_read_reg_16(struct device *dev,
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 1,
> +			.cs_change = 0,
>  		},
>  	};
>  
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
> index 33293fb..ac381ca 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -122,12 +122,10 @@ static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
>  			.tx_buf = st->tx,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.cs_change = 0,
>  		}, {
>  			.rx_buf = rx,
>  			.bits_per_word = 8,
>  			.len = 24,
> -			.cs_change = 1,
>  		},
>  	};
>  

