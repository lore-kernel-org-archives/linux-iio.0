Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16984 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbcF0HnE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jun 2016 03:43:04 -0400
Date: Mon, 27 Jun 2016 10:42:58 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 9/9 v2] iio: pressure: bmp280: read calibration data once
Message-ID: <20160627074258.GA3142@vdogaru>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-10-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466628819-29784-10-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 22, 2016 at 10:53:39PM +0200, Linus Walleij wrote:
> The calibration data is described as coming from an E2PROM and that
> means it does not change. Just read it once at probe time and store
> it in the device state container. Also toss the calibration data
> into the entropy pool since it is device unique.

I think my initial thought when writing this was that regmap will take
care of the caching and not hit the i2c bus each time.  But I don't have
an issue with this change.  Other than that, series looks good to me.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>

> ---
> ChangeLog v1->v2:
> - Remove unused dangling "ret" variable.
> ---
>  drivers/iio/pressure/bmp280-core.c | 95 +++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 7b2a03d6fd1d..6559455f0335 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -29,9 +29,30 @@
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
> @@ -39,6 +60,7 @@ struct bmp280_data {
>  	struct completion done;
>  	bool use_eoc;
>  	const struct bmp280_chip_info *chip_info;
> +	struct bmp180_calib calib;
>  	struct regulator *vddd;
>  	struct regulator *vdda;
>  
> @@ -654,26 +676,6 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
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
> @@ -683,7 +685,6 @@ static int bmp180_read_calib(struct bmp280_data *data,
>  
>  	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
>  			       sizeof(buf));
> -
>  	if (ret < 0)
>  		return ret;
>  
> @@ -693,6 +694,9 @@ static int bmp180_read_calib(struct bmp280_data *data,
>  			return -EIO;
>  	}
>  
> +	/* Toss the calibration data into the entropy pool */
> +	add_device_randomness(buf, sizeof(buf));
> +
>  	calib->AC1 = be16_to_cpu(buf[AC1]);
>  	calib->AC2 = be16_to_cpu(buf[AC2]);
>  	calib->AC3 = be16_to_cpu(buf[AC3]);
> @@ -716,19 +720,11 @@ static int bmp180_read_calib(struct bmp280_data *data,
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
> @@ -783,29 +779,21 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
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
> @@ -970,6 +958,19 @@ int bmp280_common_probe(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * The BMP058 and BMP180 has calibration in an E2PROM, read it out
> +	 * at probe time. It will not change.
> +	 */
> +	if (chip_id  == BMP180_CHIP_ID) {
> +		ret = bmp180_read_calib(data, &data->calib);
> +		if (ret < 0) {
> +			dev_err(data->dev,
> +				"failed to read calibration coefficients\n");
> +			return ret;
> +		}
> +	}
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
>  		dev_err(dev, "unable to register IIO device\n");
> -- 
> 2.4.11
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
