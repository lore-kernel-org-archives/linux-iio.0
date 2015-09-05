Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41581 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbbIEQ1i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 12:27:38 -0400
Subject: Re: [PATCH] iio: st_accel: fix interrupt handling on LIS3LV02
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1441220578-25647-1-git-send-email-linus.walleij@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55EB17F7.6080204@kernel.org>
Date: Sat, 5 Sep 2015 17:27:35 +0100
MIME-Version: 1.0
In-Reply-To: <1441220578-25647-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/15 20:02, Linus Walleij wrote:
> This accelerometer accidentally either emits a DRDY signal or an
> IRQ signal. Accidentally I activated the IRQ signal as I thought
> it was analogous to the interrupt generator on other ST
> accelerometers. This was wrong. After this patch generic_buffer
> gives a nice stream of accelerometer readings.
> 
> Fixes: 3acddf74f807778f "iio: st-sensors: add support for lis3lv02d accelerometer"
> Cc: Denis CIOCCA <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Can see where that went wrong looking at the datasheets.

Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan


> ---
>  drivers/iio/accel/st_accel_core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 058c87d9f564..6765eebb7c0a 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -149,8 +149,6 @@
>  #define ST_ACCEL_4_BDU_MASK			0x40
>  #define ST_ACCEL_4_DRDY_IRQ_ADDR		0x21
>  #define ST_ACCEL_4_DRDY_IRQ_INT1_MASK		0x04
> -#define ST_ACCEL_4_IG1_EN_ADDR			0x21
> -#define ST_ACCEL_4_IG1_EN_MASK			0x08
>  #define ST_ACCEL_4_MULTIREAD_BIT		true
>  
>  /* CUSTOM VALUES FOR SENSOR 5 */
> @@ -484,10 +482,6 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_ACCEL_4_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_ACCEL_4_DRDY_IRQ_INT1_MASK,
> -			.ig1 = {
> -				.en_addr = ST_ACCEL_4_IG1_EN_ADDR,
> -				.en_mask = ST_ACCEL_4_IG1_EN_MASK,
> -			},
>  		},
>  		.multi_read_bit = ST_ACCEL_4_MULTIREAD_BIT,
>  		.bootime = 2, /* guess */
> 

