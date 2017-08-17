Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752263AbdHQOng (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 10:43:36 -0400
Date: Thu, 17 Aug 2017 15:43:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH 1/4] iio: magnetometer: st_magn: fix status register
 address for LSM303AGR
Message-ID: <20170817154329.21f6c953@archlinux>
In-Reply-To: <20170816170253.8382-2-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
        <20170816170253.8382-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 16 Aug 2017 19:02:50 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Fixes: 97865fe41322 (iio: st_sensors: verify interrupt event to status)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan
> ---
>  drivers/iio/magnetometer/st_magn_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 3573636bad8e..039b0e94420a 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -358,7 +358,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  			.mask_int1 = 0x01,
>  			.addr_ihl = 0x63,
>  			.mask_ihl = 0x04,
> -			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
> +			.addr_stat_drdy = 0x67,
>  		},
>  		.multi_read_bit = false,
>  		.bootime = 2,

