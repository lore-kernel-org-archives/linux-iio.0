Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:46533 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbcF0RB0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jun 2016 13:01:26 -0400
Date: Mon, 27 Jun 2016 19:01:19 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/10 v3] iio: pressure: bmp280: read calibration data
 once
In-Reply-To: <1467045020-2665-10-git-send-email-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.02.1606271859370.5271@pmeerw.net>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org> <1467045020-2665-10-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 27 Jun 2016, Linus Walleij wrote:

> The calibration data is described as coming from an E2PROM and that
> means it does not change. Just read it once at probe time and store
> it in the device state container. Also toss the calibration data
> into the entropy pool since it is device unique.

comments below
 
> Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Rebase on other changes
> - Drop unrelated whitespace fix
> ChangeLog v1->v2:
> - Remove unused dangling "ret" variable.
> ---
>  drivers/iio/pressure/bmp280-core.c | 94 +++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 615def02164a..f7233641c643 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -30,9 +30,30 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h> /* For irq_get_irq_data() */
>  #include <linux/completion.h>
> +#include <linux/random.h>
>  
>  #include "bmp280.h"
>  
> +/*
> + * These enums are used for indexing into the array of calibration
> + * coefficients for BMP180.
> + */
> +enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> +
> +struct bmp180_calib {
> +	s16 AC1;
> +	s16 AC2;
> +	s16 AC3;
> +	u16 AC4;
> +	u16 AC5;
> +	u16 AC6;
> +	s16 B1;
> +	s16 B2;
> +	s16 MB;
> +	s16 MC;
> +	s16 MD;
> +};
> +
>  struct bmp280_data {
>  	struct device *dev;
>  	struct mutex lock;
> @@ -40,6 +61,7 @@ struct bmp280_data {
>  	struct completion done;
>  	bool use_eoc;
>  	const struct bmp280_chip_info *chip_info;
> +	struct bmp180_calib calib;
>  	struct regulator *vddd;
>  	struct regulator *vdda;
>  	unsigned int start_up_time; /* in milliseconds */
> @@ -656,26 +678,6 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
>  	return 0;
>  }
>  
> -/*
> - * These enums are used for indexing into the array of calibration
> - * coefficients for BMP180.
> - */
> -enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> -
> -struct bmp180_calib {
> -	s16 AC1;
> -	s16 AC2;
> -	s16 AC3;
> -	u16 AC4;
> -	u16 AC5;
> -	u16 AC6;
> -	s16 B1;
> -	s16 B2;
> -	s16 MB;
> -	s16 MC;
> -	s16 MD;
> -};
> -
>  static int bmp180_read_calib(struct bmp280_data *data,
>  			     struct bmp180_calib *calib)
>  {
> @@ -695,6 +697,9 @@ static int bmp180_read_calib(struct bmp280_data *data,
>  			return -EIO;
>  	}
>  
> +	/* Toss the calibration data into the entropy pool */
> +	add_device_randomness(buf, sizeof(buf));
> +
>  	calib->AC1 = be16_to_cpu(buf[AC1]);
>  	calib->AC2 = be16_to_cpu(buf[AC2]);
>  	calib->AC3 = be16_to_cpu(buf[AC3]);
> @@ -718,19 +723,11 @@ static int bmp180_read_calib(struct bmp280_data *data,
>   */
>  static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
>  {
> -	int ret;
>  	s32 x1, x2;
> -	struct bmp180_calib calib;
> +	struct bmp180_calib *calib = &data->calib;
>  
> -	ret = bmp180_read_calib(data, &calib);
> -	if (ret < 0) {
> -		dev_err(data->dev,
> -			"failed to read calibration coefficients\n");
> -		return ret;
> -	}
> -
> -	x1 = ((adc_temp - calib.AC6) * calib.AC5) >> 15;
> -	x2 = (calib.MC << 11) / (x1 + calib.MD);
> +	x1 = ((adc_temp - calib->AC6) * calib->AC5) >> 15;
> +	x2 = (calib->MC << 11) / (x1 + calib->MD);
>  	data->t_fine = x1 + x2;
>  
>  	return (data->t_fine + 8) >> 4;
> @@ -785,29 +782,21 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
>   */
>  static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
>  {
> -	int ret;
>  	s32 x1, x2, x3, p;
>  	s32 b3, b6;
>  	u32 b4, b7;
>  	s32 oss = data->oversampling_press;
> -	struct bmp180_calib calib;
> -
> -	ret = bmp180_read_calib(data, &calib);
> -	if (ret < 0) {
> -		dev_err(data->dev,
> -			"failed to read calibration coefficients\n");
> -		return ret;
> -	}
> +	struct bmp180_calib *calib = &data->calib;
>  
>  	b6 = data->t_fine - 4000;
> -	x1 = (calib.B2 * (b6 * b6 >> 12)) >> 11;
> -	x2 = calib.AC2 * b6 >> 11;
> +	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
> +	x2 = calib->AC2 * b6 >> 11;
>  	x3 = x1 + x2;
> -	b3 = ((((s32)calib.AC1 * 4 + x3) << oss) + 2) / 4;
> -	x1 = calib.AC3 * b6 >> 13;
> -	x2 = (calib.B1 * ((b6 * b6) >> 12)) >> 16;
> +	b3 = ((((s32)calib->AC1 * 4 + x3) << oss) + 2) / 4;
> +	x1 = calib->AC3 * b6 >> 13;
> +	x2 = (calib->B1 * ((b6 * b6) >> 12)) >> 16;
>  	x3 = (x1 + x2 + 2) >> 2;
> -	b4 = calib.AC4 * (u32)(x3 + 32768) >> 15;
> +	b4 = calib->AC4 * (u32)(x3 + 32768) >> 15;
>  	b7 = ((u32)adc_press - b3) * (50000 >> oss);
>  	if (b7 < 0x80000000)
>  		p = (b7 * 2) / b4;
> @@ -1011,6 +1000,19 @@ int bmp280_common_probe(struct device *dev,
>  	dev_set_drvdata(dev, data);
>  
>  	/*
> +	 * The BMP058 and BMP180 has calibration in an E2PROM, read it out

BMP085

> +	 * at probe time. It will not change.
> +	 */
> +	if (chip_id  == BMP180_CHIP_ID) {

delete one space after chip_id

> +		ret = bmp180_read_calib(data, &data->calib);
> +		if (ret < 0) {
> +			dev_err(data->dev,
> +				"failed to read calibration coefficients\n");
> +			goto out_disable_vdda;
> +		}
> +	}
> +
> +	/*
>  	 * Attempt to grab an optional EOC IRQ - only the BMP058 has this

BMP085 twice

>  	 * however as it happens, the BMP058 shares the chip ID of BMP180
>  	 * so we look for an IRQ if we have that.
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
