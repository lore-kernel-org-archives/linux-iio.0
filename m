Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755999AbdJJTm0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Oct 2017 15:42:26 -0400
Date: Tue, 10 Oct 2017 20:38:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH 3/3] iio: pressure: st_pressure: add SPI-3wire support
 to st_pressure framework
Message-ID: <20171010203815.751cc2e2@archlinux>
In-Reply-To: <20170917152047.12631-4-lorenzo.bianconi@st.com>
References: <20170917152047.12631-1-lorenzo.bianconi@st.com>
        <20170917152047.12631-4-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 17:20:47 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add SPI Serial Interface Mode (SIM) register information
> to STM pressure framework
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/st_pressure_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index b8890e37a2d2..15ad6054d9f6 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -297,6 +297,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  				.mask = 0x03,
>  			},
>  		},
> +		.sim = {
> +			.addr = 0x20,
> +			.value = BIT(0),
> +		},
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> @@ -343,6 +347,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.addr = 0x20,
>  			.mask = 0x04,
>  		},
> +		.sim = {
> +			.addr = 0x20,
> +			.value = BIT(0),
> +		},
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> @@ -406,6 +414,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  				.mask = 0x03,
>  			},
>  		},
> +		.sim = {
> +			.addr = 0x20,
> +			.value = BIT(0),
> +		},
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> @@ -471,6 +483,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  				.mask = 0x03,
>  			},
>  		},
> +		.sim = {
> +			.addr = 0x10,
> +			.value = BIT(0),
> +		},
>  		.multi_read_bit = false,
>  		.bootime = 2,
>  	},

