Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbdHQOsn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 10:48:43 -0400
Date: Thu, 17 Aug 2017 15:48:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH 2/4] iio: magnetometer: st_magn: remove ihl property for
 LSM303AGR
Message-ID: <20170817154527.462dd0d1@archlinux>
In-Reply-To: <20170816170253.8382-3-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
        <20170816170253.8382-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 16 Aug 2017 19:02:51 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Remove IRQ active low support for LSM303AGR since the sensor does not
> support that capability for data-ready line
> 
> Fixes: a9fd053b56c6 (iio: st_sensors: support active-low interrupts)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/st_magn_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 039b0e94420a..cd89962f2de3 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -356,8 +356,6 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = 0x62,
>  			.mask_int1 = 0x01,
> -			.addr_ihl = 0x63,
> -			.mask_ihl = 0x04,
>  			.addr_stat_drdy = 0x67,
>  		},
>  		.multi_read_bit = false,

