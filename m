Return-Path: <jic23@kernel.org>
Message-ID: <51166A59.6090503@kernel.org>
Date: Sat, 09 Feb 2013 15:25:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, rdunlap@infradead.org,
 denis.ciocca@st.com
Subject: Re: [PATCH 0/2] iio:st_sensors more fixes when !IIO_CONFIG_TRIGGER
References: <1360406967-25026-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1360406967-25026-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/09/2013 10:49 AM, Jonathan Cameron wrote:
> Here is how I would suggest dealing with the issues pointed out by
> Randy when buildling without trigger support.
> 
Applied to togreg branch of iio.git
> Jonathan
> 
> Jonathan Cameron (2):
>   iio:triggers Protect functions in triggers.h from use when not
>     compiled
>   iio:st_sensors fix build when !CONFIG_IIO_TRIGGER
> 
>  drivers/iio/accel/st_accel_core.c       | 9 +++++++--
>  drivers/iio/accel/st_accel_i2c.c        | 1 -
>  drivers/iio/accel/st_accel_spi.c        | 1 -
>  drivers/iio/gyro/st_gyro_core.c         | 9 +++++++--
>  drivers/iio/gyro/st_gyro_i2c.c          | 1 -
>  drivers/iio/gyro/st_gyro_spi.c          | 1 -
>  drivers/iio/magnetometer/st_magn_core.c | 1 -
>  drivers/iio/magnetometer/st_magn_i2c.c  | 1 -
>  drivers/iio/magnetometer/st_magn_spi.c  | 1 -
>  include/linux/iio/trigger.h             | 5 +++++
>  10 files changed, 19 insertions(+), 11 deletions(-)
> 
