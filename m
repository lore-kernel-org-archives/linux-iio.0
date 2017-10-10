Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752175AbdJJTnw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Oct 2017 15:43:52 -0400
Date: Tue, 10 Oct 2017 20:43:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH 2/3] iio: magnetometer: st_magn: add SPI-3wire support
 to LIS3MDL
Message-ID: <20171010204348.2cd8c826@archlinux>
In-Reply-To: <20170917152047.12631-3-lorenzo.bianconi@st.com>
References: <20170917152047.12631-1-lorenzo.bianconi@st.com>
        <20170917152047.12631-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 17:20:46 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add SPI Serial Interface Mode (SIM) register information to
> LIS3MDL magn sensor
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied.
> ---
>  drivers/iio/magnetometer/st_magn_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 8745686f233c..72f6d1335a04 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -322,6 +322,10 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  				.mask = 0x07,
>  			},
>  		},
> +		.sim = {
> +			.addr = 0x22,
> +			.value = BIT(2),
> +		},
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},

