Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755999AbdJJTmZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Oct 2017 15:42:25 -0400
Date: Tue, 10 Oct 2017 20:34:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH 1/3] iio: gyro: st_gyro: add SPI-3wire support to
 st_gyro framework
Message-ID: <20171010203402.27bd0666@archlinux>
In-Reply-To: <20170917152047.12631-2-lorenzo.bianconi@st.com>
References: <20170917152047.12631-1-lorenzo.bianconi@st.com>
        <20170917152047.12631-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 17:20:45 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add SPI Serial Interface Mode (SIM) register information
> to STM gyroscope framework
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/gyro/st_gyro_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 46991f7131d1..b31064ba37b9 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -125,6 +125,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  				.mask = 0x07,
>  			},
>  		},
> +		.sim = {
> +			.addr = 0x23,
> +			.value = BIT(0),
> +		},
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> @@ -200,6 +204,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  				.mask = 0x07,
>  			},
>  		},
> +		.sim = {
> +			.addr = 0x23,
> +			.value = BIT(0),
> +		},
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> @@ -270,6 +278,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  				.mask = 0x07,
>  			},
>  		},
> +		.sim = {
> +			.addr = 0x23,
> +			.value = BIT(0),
> +		},
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},

