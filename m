Return-Path: <SRS0=Fqn4=O6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1A8C43387
	for <linux-iio@archiver.kernel.org>; Fri, 21 Dec 2018 09:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C9B21906
	for <linux-iio@archiver.kernel.org>; Fri, 21 Dec 2018 09:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeLUJUn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:20:43 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40033 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbeLUJUm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Dec 2018 04:20:42 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBL9CCwm001083;
        Fri, 21 Dec 2018 10:20:09 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcqy9su5k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Dec 2018 10:20:07 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC2B334;
        Fri, 21 Dec 2018 09:20:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94FDD2769;
        Fri, 21 Dec 2018 09:20:05 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Dec
 2018 10:20:04 +0100
Subject: Re: [PATCH][V2] iio: Move attach/detach of the poll func to the core
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <jic23@kernel.org>
References: <20181219140912.22582-1-alexandru.ardelean@analog.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <13c53b6d-1640-14fc-5cd1-ff153dbde747@st.com>
Date:   Fri, 21 Dec 2018 10:20:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219140912.22582-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-21_04:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/19/18 3:09 PM, Alexandru Ardelean wrote:
> All devices using a triggered buffer need to attach and detach the trigger
> to the device in order to properly work. Instead of doing this in each and
> every driver by hand move this into the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v1 -> v2:
> * changed order of execution for attach poll func: first attach poll_func,
>   then call call post_enable() hook
> * updated drivers with change since first patch sent ; particularly
>   stm32-adc.c has a rather big update with V2

Hi Alexandru,

For the stm32-adc driver,
Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Best regards,
Fabrice

> 
> 
>  drivers/iio/accel/adxl372.c                   |  6 +-
>  drivers/iio/accel/bmc150-accel-core.c         |  4 +-
>  drivers/iio/accel/kxcjk-1013.c                |  2 -
>  drivers/iio/accel/kxsd9.c                     |  2 -
>  drivers/iio/accel/st_accel_buffer.c           |  8 ---
>  drivers/iio/accel/stk8312.c                   |  2 -
>  drivers/iio/accel/stk8ba50.c                  |  2 -
>  drivers/iio/adc/ad7266.c                      |  2 -
>  drivers/iio/adc/ad7766.c                      |  2 -
>  drivers/iio/adc/ad7887.c                      |  2 -
>  drivers/iio/adc/ad_sigma_delta.c              |  5 --
>  drivers/iio/adc/at91-sama5d2_adc.c            |  7 +--
>  drivers/iio/adc/dln2-adc.c                    |  4 +-
>  drivers/iio/adc/mxs-lradc-adc.c               |  2 -
>  drivers/iio/adc/stm32-adc.c                   | 36 ++----------
>  drivers/iio/adc/ti-adc084s021.c               |  2 -
>  drivers/iio/adc/ti-ads1015.c                  |  2 -
>  drivers/iio/adc/vf610_adc.c                   |  6 +-
>  drivers/iio/adc/xilinx-xadc-core.c            |  2 -
>  .../buffer/industrialio-triggered-buffer.c    | 10 +---
>  drivers/iio/chemical/atlas-ph-sensor.c        |  8 ---
>  drivers/iio/dummy/iio_simple_dummy_buffer.c   | 14 -----
>  drivers/iio/gyro/bmg160_core.c                |  2 -
>  drivers/iio/gyro/mpu3050-core.c               |  2 -
>  drivers/iio/gyro/st_gyro_buffer.c             |  8 ---
>  drivers/iio/humidity/hdc100x.c                |  7 +--
>  drivers/iio/humidity/hts221_buffer.c          |  2 -
>  drivers/iio/iio_core_trigger.h                | 20 ++++++-
>  drivers/iio/industrialio-buffer.c             | 16 ++++--
>  drivers/iio/industrialio-trigger.c            | 55 +++++++++----------
>  drivers/iio/light/gp2ap020a00f.c              | 11 +---
>  drivers/iio/light/isl29125.c                  |  5 --
>  drivers/iio/light/rpr0521.c                   |  2 -
>  drivers/iio/light/si1145.c                    |  2 -
>  drivers/iio/light/st_uvis25_core.c            |  2 -
>  drivers/iio/light/tcs3414.c                   |  5 --
>  drivers/iio/magnetometer/bmc150_magn.c        |  2 -
>  drivers/iio/magnetometer/rm3100-core.c        |  2 -
>  drivers/iio/magnetometer/st_magn_buffer.c     | 21 +------
>  drivers/iio/potentiostat/lmp91000.c           |  1 -
>  drivers/iio/pressure/st_pressure_buffer.c     | 23 +-------
>  drivers/iio/pressure/zpa2326.c                |  6 --
>  drivers/iio/proximity/sx9500.c                |  3 -
>  include/linux/iio/trigger_consumer.h          |  7 ---
>  44 files changed, 75 insertions(+), 259 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 3b84cb243a87..e3efdc0f23df 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -817,7 +817,7 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	return 0;
>  }
>  
>  static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
> @@ -825,10 +825,6 @@ static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
>  	struct adxl372_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	adxl372_set_interrupts(st, 0, 0);
>  	st->fifo_mode = ADXL372_FIFO_BYPASSED;
>  	adxl372_configure_fifo(st);
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 383c802eb5b8..dcce3e178f10 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1403,7 +1403,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
>  	int ret = 0;
>  
>  	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> -		return iio_triggered_buffer_postenable(indio_dev);
> +		return 0;
>  
>  	mutex_lock(&data->mutex);
>  
> @@ -1435,7 +1435,7 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  
>  	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> -		return iio_triggered_buffer_predisable(indio_dev);
> +		return 0;
>  
>  	mutex_lock(&data->mutex);
>  
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 7096e577b23f..f9aa81e8c180 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1019,9 +1019,7 @@ static const struct iio_chan_spec kxcjk1013_channels[] = {
>  
>  static const struct iio_buffer_setup_ops kxcjk1013_buffer_setup_ops = {
>  	.preenable		= kxcjk1013_buffer_preenable,
> -	.postenable		= iio_triggered_buffer_postenable,
>  	.postdisable		= kxcjk1013_buffer_postdisable,
> -	.predisable		= iio_triggered_buffer_predisable,
>  };
>  
>  static const struct iio_info kxcjk1013_info = {
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 0c0df4fce420..9da366bedaa0 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -255,8 +255,6 @@ static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops kxsd9_buffer_setup_ops = {
>  	.preenable = kxsd9_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = kxsd9_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> index 7fddc137e91e..cfa189774a1a 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -51,10 +51,6 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_accel_buffer_postenable_error;
>  
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0)
> -		goto st_accel_buffer_postenable_error;
> -
>  	return err;
>  
>  st_accel_buffer_postenable_error:
> @@ -68,10 +64,6 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
>  	int err;
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  
> -	err = iio_triggered_buffer_predisable(indio_dev);
> -	if (err < 0)
> -		goto st_accel_buffer_predisable_error;
> -
>  	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
>  	if (err < 0)
>  		goto st_accel_buffer_predisable_error;
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index cacc0da2f874..7c05f8b91f1f 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -495,8 +495,6 @@ static int stk8312_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops stk8312_buffer_setup_ops = {
>  	.preenable   = stk8312_buffer_preenable,
> -	.postenable  = iio_triggered_buffer_postenable,
> -	.predisable  = iio_triggered_buffer_predisable,
>  	.postdisable = stk8312_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 576b6b140f08..4e15da997d96 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -379,8 +379,6 @@ static int stk8ba50_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops stk8ba50_buffer_setup_ops = {
>  	.preenable   = stk8ba50_buffer_preenable,
> -	.postenable  = iio_triggered_buffer_postenable,
> -	.predisable  = iio_triggered_buffer_predisable,
>  	.postdisable = stk8ba50_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 605eb5e7e829..93b02b28e377 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -75,8 +75,6 @@ static int ad7266_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
>  	.preenable = &ad7266_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
>  	.postdisable = &ad7266_postdisable,
>  };
>  
> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 3ae14fc8c649..39e7e4004706 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -179,8 +179,6 @@ static const struct ad7766_chip_info ad7766_chip_info[] = {
>  
>  static const struct iio_buffer_setup_ops ad7766_buffer_setup_ops = {
>  	.preenable = &ad7766_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
>  	.postdisable = &ad7766_postdisable,
>  };
>  
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 9d4c2467d362..4d78167f2d8a 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -131,8 +131,6 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
>  
>  static const struct iio_buffer_setup_ops ad7887_ring_setup_ops = {
>  	.preenable = &ad7887_ring_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
>  	.postdisable = &ad7887_ring_postdisable,
>  };
>  
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index ff5f2da2e1b1..815344387541 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -345,10 +345,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  	unsigned int channel;
>  	int ret;
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	channel = find_first_bit(indio_dev->active_scan_mask,
>  				 indio_dev->masklength);
>  	ret = ad_sigma_delta_set_channel(sigma_delta,
> @@ -439,7 +435,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  
>  static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
>  	.postenable = &ad_sd_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
>  	.postdisable = &ad_sd_buffer_postdisable,
>  	.validate_scan_mask = &iio_validate_scan_mask_onehot,
>  };
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index d5ea84cf6460..90121aed2210 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -904,7 +904,7 @@ static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	return 0;
>  }
>  
>  static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> @@ -924,11 +924,6 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
>  		return -EINVAL;
>  
> -	/* continue with the triggered buffer */
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		dev_err(&indio_dev->dev, "buffer predisable failed\n");
> -
>  	if (!st->dma_st.dma_chan)
>  		return ret;
>  
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index c64c6675cae6..51135e7c0d4f 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -560,7 +560,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
>  		mutex_unlock(&dln2->mutex);
>  	}
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	return 0;
>  }
>  
>  static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
> @@ -585,7 +585,7 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	return iio_triggered_buffer_predisable(indio_dev);
> +	return 0;
>  }
>  
>  static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index c627513d9f0f..4a44d4c787be 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -575,8 +575,6 @@ static bool mxs_lradc_adc_validate_scan_mask(struct iio_dev *iio,
>  
>  static const struct iio_buffer_setup_ops mxs_lradc_adc_buffer_ops = {
>  	.preenable = &mxs_lradc_adc_buffer_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
>  	.postdisable = &mxs_lradc_adc_buffer_postdisable,
>  	.validate_scan_mask = &mxs_lradc_adc_validate_scan_mask,
>  };
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 205e1699f954..54dab0542014 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1518,7 +1518,7 @@ static int stm32_adc_dma_start(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
> +static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
> @@ -1561,22 +1561,7 @@ static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
> -{
> -	int ret;
> -
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = __stm32_adc_buffer_postenable(indio_dev);
> -	if (ret < 0)
> -		iio_triggered_buffer_predisable(indio_dev);
> -
> -	return ret;
> -}
> -
> -static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
> +static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
> @@ -1593,19 +1578,8 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
> -}
> -
> -static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
> -{
> -	int ret;
> -
> -	__stm32_adc_buffer_predisable(indio_dev);
> -
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		dev_err(&indio_dev->dev, "predisable failed\n");
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static const struct iio_buffer_setup_ops stm32_adc_buffer_setup_ops = {
> @@ -2034,7 +2008,7 @@ static int stm32_adc_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
>  
>  	if (iio_buffer_enabled(indio_dev))
> -		__stm32_adc_buffer_predisable(indio_dev);
> +		stm32_adc_buffer_predisable(indio_dev);
>  
>  	return pm_runtime_force_suspend(dev);
>  }
> @@ -2057,7 +2031,7 @@ static int stm32_adc_resume(struct device *dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	return __stm32_adc_buffer_postenable(indio_dev);
> +	return stm32_adc_buffer_postenable(indio_dev);
>  }
>  #endif
>  
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> index 25504640e126..b5557ecb667e 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -190,8 +190,6 @@ static const struct iio_info adc084s021_info = {
>  
>  static const struct iio_buffer_setup_ops adc084s021_buffer_setup_ops = {
>  	.preenable = adc084s021_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = adc084s021_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 6a114dcb4a3a..2a4725ec68ce 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -784,8 +784,6 @@ static int ads1015_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
>  	.preenable	= ads1015_buffer_preenable,
> -	.postenable	= iio_triggered_buffer_postenable,
> -	.predisable	= iio_triggered_buffer_predisable,
>  	.postdisable	= ads1015_buffer_postdisable,
>  	.validate_scan_mask = &iio_validate_scan_mask_onehot,
>  };
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index bbcb7a4d7edf..3a15b98cfd39 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -740,10 +740,6 @@ static int vf610_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	int ret;
>  	int val;
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	val = readl(info->regs + VF610_REG_ADC_GC);
>  	val |= VF610_ADC_ADCON;
>  	writel(val, info->regs + VF610_REG_ADC_GC);
> @@ -774,7 +770,7 @@ static int vf610_adc_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
>  
> -	return iio_triggered_buffer_predisable(indio_dev);
> +	return 0;
>  }
>  
>  static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 3f6be5ac049a..70bac5e8ec9e 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -819,8 +819,6 @@ static int xadc_preenable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops xadc_buffer_ops = {
>  	.preenable = &xadc_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
>  	.postdisable = &xadc_postdisable,
>  };
>  
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index d3db1fce54d2..6d2d7e953904 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -16,11 +16,6 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> -static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
> -};
> -
>  /**
>   * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
>   * @indio_dev:		IIO device structure
> @@ -70,10 +65,7 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
>  	}
>  
>  	/* Ring buffer functions - here trigger setup related */
> -	if (setup_ops)
> -		indio_dev->setup_ops = setup_ops;
> -	else
> -		indio_dev->setup_ops = &iio_triggered_buffer_setup_ops;
> +	indio_dev->setup_ops = setup_ops;
>  
>  	/* Flag that polled ring buffering is possible */
>  	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index a406ad31b096..8fed75f9e95d 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -305,10 +305,6 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
>  	struct atlas_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	ret = pm_runtime_get_sync(&data->client->dev);
>  	if (ret < 0) {
>  		pm_runtime_put_noidle(&data->client->dev);
> @@ -323,10 +319,6 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
>  	struct atlas_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	ret = atlas_set_interrupt(data, false);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index 744ca92c3c99..72b0a874d0c6 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -102,20 +102,6 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  }
>  
>  static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
> -	/*
> -	 * iio_triggered_buffer_postenable:
> -	 * Generic function that simply attaches the pollfunc to the trigger.
> -	 * Replace this to mess with hardware state before we attach the
> -	 * trigger.
> -	 */
> -	.postenable = &iio_triggered_buffer_postenable,
> -	/*
> -	 * iio_triggered_buffer_predisable:
> -	 * Generic function that simple detaches the pollfunc from the trigger.
> -	 * Replace this to put hardware state back again after the trigger is
> -	 * detached but before userspace knows we have disabled the ring.
> -	 */
> -	.predisable = &iio_triggered_buffer_predisable,
>  };
>  
>  int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 63ca31628a93..018d5aef9cdf 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -1043,8 +1043,6 @@ static int bmg160_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops bmg160_buffer_setup_ops = {
>  	.preenable = bmg160_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = bmg160_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 77fac81a3adc..159fb7cd6e2e 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -660,8 +660,6 @@ static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops mpu3050_buffer_setup_ops = {
>  	.preenable = mpu3050_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = mpu3050_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
> index a5377044e42f..21501ffd879e 100644
> --- a/drivers/iio/gyro/st_gyro_buffer.c
> +++ b/drivers/iio/gyro/st_gyro_buffer.c
> @@ -51,10 +51,6 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_gyro_buffer_postenable_error;
>  
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0)
> -		goto st_gyro_buffer_postenable_error;
> -
>  	return err;
>  
>  st_gyro_buffer_postenable_error:
> @@ -68,10 +64,6 @@ static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
>  	int err;
>  	struct st_sensor_data *gdata = iio_priv(indio_dev);
>  
> -	err = iio_triggered_buffer_predisable(indio_dev);
> -	if (err < 0)
> -		goto st_gyro_buffer_predisable_error;
> -
>  	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
>  	if (err < 0)
>  		goto st_gyro_buffer_predisable_error;
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 066e05f92081..959d7e17d471 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -286,7 +286,7 @@ static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	return 0;
>  }
>  
>  static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
> @@ -294,11 +294,6 @@ static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
>  	struct hdc100x_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	/* First detach poll func, then reset ACQ mode. OK to disable buffer */
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	mutex_lock(&data->lock);
>  	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
>  	mutex_unlock(&data->lock);
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 1a94b0b91721..dc45667b0364 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -156,8 +156,6 @@ static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
>  
>  static const struct iio_buffer_setup_ops hts221_buffer_ops = {
>  	.preenable = hts221_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = hts221_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
> index 1fdb1e4ea4a5..b31d68d56fd4 100644
> --- a/drivers/iio/iio_core_trigger.h
> +++ b/drivers/iio/iio_core_trigger.h
> @@ -21,13 +21,18 @@ void iio_device_register_trigger_consumer(struct iio_dev *indio_dev);
>   **/
>  void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
>  
> +
> +int iio_trigger_attach_poll_func(struct iio_dev *indio_dev);
> +int iio_trigger_detach_poll_func(struct iio_dev *indio_dev);
> +
>  #else
>  
>  /**
>   * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
>   * @indio_dev: iio_dev associated with the device that will consume the trigger
>   **/
> -static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
> +static inline int iio_device_register_trigger_consumer(
> +	struct iio_dev *indio_dev)
>  {
>  	return 0;
>  }
> @@ -36,8 +41,19 @@ static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
>   * iio_device_unregister_trigger_consumer() - reverse the registration process
>   * @indio_dev: iio_dev associated with the device that consumed the trigger
>   **/
> -static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
> +static inline void iio_device_unregister_trigger_consumer(
> +	struct iio_dev *indio_dev)
> +{
> +}
> +
> +static inline int iio_trigger_attach_poll_func(struct iio_dev *indio_dev)
>  {
> +	return 0;
> +}
> +
> +static inline int iio_trigger_detach_poll_func(struct iio_dev *indio_dev)
> +{
> +	return 0;
>  }
>  
>  #endif /* CONFIG_TRIGGER_CONSUMER */
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index cd5bfe39591b..d09a9223a5b0 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -24,8 +24,10 @@
>  
>  #include <linux/iio/iio.h>
>  #include "iio_core.h"
> +#include "iio_core_trigger.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/buffer_impl.h>
>  
>  static const char * const iio_endian_prefix[] = {
> @@ -915,6 +917,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  	indio_dev->active_scan_mask = config->scan_mask;
>  	indio_dev->scan_timestamp = config->scan_timestamp;
>  	indio_dev->scan_bytes = config->scan_bytes;
> +	indio_dev->currentmode = config->mode;
>  
>  	iio_update_demux(indio_dev);
>  
> @@ -950,28 +953,32 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  			goto err_disable_buffers;
>  	}
>  
> -	indio_dev->currentmode = config->mode;
> +	ret = iio_trigger_attach_poll_func(indio_dev);
> +	if (ret)
> +		goto err_disable_buffers;
>  
>  	if (indio_dev->setup_ops->postenable) {
>  		ret = indio_dev->setup_ops->postenable(indio_dev);
>  		if (ret) {
>  			dev_dbg(&indio_dev->dev,
>  			       "Buffer not started: postenable failed (%d)\n", ret);
> -			goto err_disable_buffers;
> +			goto err_detach_pollfunc;
>  		}
>  	}
>  
>  	return 0;
>  
> +err_detach_pollfunc:
> +	iio_trigger_detach_poll_func(indio_dev);
>  err_disable_buffers:
>  	list_for_each_entry_continue_reverse(buffer, &indio_dev->buffer_list,
>  					     buffer_list)
>  		iio_buffer_disable(buffer, indio_dev);
>  err_run_postdisable:
> -	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  	if (indio_dev->setup_ops->postdisable)
>  		indio_dev->setup_ops->postdisable(indio_dev);
>  err_undo_config:
> +	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  	indio_dev->active_scan_mask = NULL;
>  
>  	return ret;
> @@ -1006,7 +1013,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  			ret = ret2;
>  	}
>  
> -	indio_dev->currentmode = INDIO_DIRECT_MODE;
> +	iio_trigger_detach_poll_func(indio_dev);
>  
>  	if (indio_dev->setup_ops->postdisable) {
>  		ret2 = indio_dev->setup_ops->postdisable(indio_dev);
> @@ -1016,6 +1023,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  
>  	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
>  	indio_dev->active_scan_mask = NULL;
> +	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  
>  	return ret;
>  }
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ce66699c7fcc..d50761717dbe 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
>  #include "iio_core.h"
>  #include "iio_core_trigger.h"
> @@ -242,12 +243,17 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
>   * the relevant function is in there may be the best option.
>   */
>  /* Worth protecting against double additions? */
> -static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> -					struct iio_poll_func *pf)
> +int iio_trigger_attach_poll_func(struct iio_dev *indio_dev)
>  {
> +	struct iio_trigger *trig = indio_dev->trig;
> +	struct iio_poll_func *pf = indio_dev->pollfunc;
> +	bool notinuse;
>  	int ret = 0;
> -	bool notinuse
> -		= bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> +
> +	if (indio_dev->currentmode != INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	notinuse = bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  
>  	/* Prevent the module from being removed whilst attached to a trigger */
>  	__module_get(pf->indio_dev->driver_module);
> @@ -290,14 +296,19 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  	return ret;
>  }
>  
> -static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> -					 struct iio_poll_func *pf)
> +int iio_trigger_detach_poll_func(struct iio_dev *indio_dev)
>  {
> +	struct iio_trigger *trig = indio_dev->trig;
> +	struct iio_poll_func *pf = indio_dev->pollfunc;
> +	bool no_other_users = false;
>  	int ret = 0;
> -	bool no_other_users
> -		= (bitmap_weight(trig->pool,
> -				 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
> -		   == 1);
> +
> +	if (indio_dev->currentmode != INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	if (bitmap_weight(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER) == 1)
> +		no_other_users = true;
> +
>  	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
>  		ret = trig->ops->set_trigger_state(trig, false);
>  		if (ret)
> @@ -434,18 +445,16 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  			goto out_trigger_put;
>  	}
>  
> -	indio_dev->trig = trig;
>  
> -	if (oldtrig) {
> +	if (indio_dev->trig) {
>  		if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
> -			iio_trigger_detach_poll_func(oldtrig,
> -						     indio_dev->pollfunc_event);
> +			iio_trigger_detach_poll_func(indio_dev);
>  		iio_trigger_put(oldtrig);
>  	}
> +	indio_dev->trig = trig;
>  	if (indio_dev->trig) {
>  		if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
> -			iio_trigger_attach_poll_func(indio_dev->trig,
> -						     indio_dev->pollfunc_event);
> +			iio_trigger_attach_poll_func(indio_dev);
>  	}
>  
>  	return len;
> @@ -758,17 +767,3 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
>  	if (indio_dev->trig)
>  		iio_trigger_put(indio_dev->trig);
>  }
> -
> -int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
> -{
> -	return iio_trigger_attach_poll_func(indio_dev->trig,
> -					    indio_dev->pollfunc);
> -}
> -EXPORT_SYMBOL(iio_triggered_buffer_postenable);
> -
> -int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
> -{
> -	return iio_trigger_detach_poll_func(indio_dev->trig,
> -					     indio_dev->pollfunc);
> -}
> -EXPORT_SYMBOL(iio_triggered_buffer_predisable);
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 44b13fbcd093..24d4a57b41be 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1423,12 +1423,8 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  		goto error_unlock;
>  
>  	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (!data->buffer) {
> +	if (!data->buffer)
>  		err = -ENOMEM;
> -		goto error_unlock;
> -	}
> -
> -	err = iio_triggered_buffer_postenable(indio_dev);
>  
>  error_unlock:
>  	mutex_unlock(&data->lock);
> @@ -1443,10 +1439,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	mutex_lock(&data->lock);
>  
> -	err = iio_triggered_buffer_predisable(indio_dev);
> -	if (err < 0)
> -		goto error_unlock;
> -
>  	for_each_set_bit(i, indio_dev->active_scan_mask,
>  		indio_dev->masklength) {
>  		switch (i) {
> @@ -1468,7 +1460,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
>  	if (err == 0)
>  		kfree(data->buffer);
>  
> -error_unlock:
>  	mutex_unlock(&data->lock);
>  
>  	return err;
> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> index ed38edcd5efe..5fdfce92019b 100644
> --- a/drivers/iio/light/isl29125.c
> +++ b/drivers/iio/light/isl29125.c
> @@ -230,10 +230,6 @@ static int isl29125_buffer_predisable(struct iio_dev *indio_dev)
>  	struct isl29125_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	data->conf1 &= ~ISL29125_MODE_MASK;
>  	data->conf1 |= ISL29125_MODE_PD;
>  	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
> @@ -242,7 +238,6 @@ static int isl29125_buffer_predisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops isl29125_buffer_setup_ops = {
>  	.preenable = isl29125_buffer_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
>  	.predisable = isl29125_buffer_predisable,
>  };
>  
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index ffe9ce798ea2..a700f5fed0d8 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -573,8 +573,6 @@ static int rpr0521_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops rpr0521_buffer_setup_ops = {
>  	.preenable = rpr0521_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = rpr0521_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 76f16f9c7616..8019cc93251e 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -1175,8 +1175,6 @@ static bool si1145_validate_scan_mask(struct iio_dev *indio_dev,
>  
>  static const struct iio_buffer_setup_ops si1145_buffer_setup_ops = {
>  	.preenable = si1145_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.validate_scan_mask = si1145_validate_scan_mask,
>  };
>  
> diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> index 302635836e6b..7ef9c8890522 100644
> --- a/drivers/iio/light/st_uvis25_core.c
> +++ b/drivers/iio/light/st_uvis25_core.c
> @@ -228,8 +228,6 @@ static int st_uvis25_buffer_postdisable(struct iio_dev *iio_dev)
>  
>  static const struct iio_buffer_setup_ops st_uvis25_buffer_ops = {
>  	.preenable = st_uvis25_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = st_uvis25_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index 205e5659ce6b..c31ed0c640e9 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -257,10 +257,6 @@ static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
>  	struct tcs3414_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	data->control &= ~TCS3414_CONTROL_ADC_EN;
>  	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
>  		data->control);
> @@ -268,7 +264,6 @@ static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
>  	.preenable = tcs3414_buffer_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
>  	.predisable = tcs3414_buffer_predisable,
>  };
>  
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index d91cb845e3d6..18f5e5013be4 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -828,8 +828,6 @@ static int bmc150_magn_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops = {
>  	.preenable = bmc150_magn_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = bmc150_magn_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> index 7c20918d8108..59aa9a4965b8 100644
> --- a/drivers/iio/magnetometer/rm3100-core.c
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -462,8 +462,6 @@ static int rm3100_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops rm3100_buffer_ops = {
>  	.preenable = rm3100_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> -	.predisable = iio_triggered_buffer_predisable,
>  	.postdisable = rm3100_buffer_postdisable,
>  };
>  
> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
> index 37ab30566464..570975200955 100644
> --- a/drivers/iio/magnetometer/st_magn_buffer.c
> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> @@ -32,25 +32,13 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
>  
>  static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>  {
> -	int err;
>  	struct st_sensor_data *mdata = iio_priv(indio_dev);
>  
>  	mdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (mdata->buffer_data == NULL) {
> -		err = -ENOMEM;
> -		goto allocate_memory_error;
> -	}
> -
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0)
> -		goto st_magn_buffer_postenable_error;
> +	if (mdata->buffer_data == NULL)
> +		return -ENOMEM;
>  
>  	return st_sensors_set_enable(indio_dev, true);
> -
> -st_magn_buffer_postenable_error:
> -	kfree(mdata->buffer_data);
> -allocate_memory_error:
> -	return err;
>  }
>  
>  static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
> @@ -59,12 +47,7 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>  	struct st_sensor_data *mdata = iio_priv(indio_dev);
>  
>  	err = st_sensors_set_enable(indio_dev, false);
> -	if (err < 0)
> -		goto st_magn_buffer_predisable_error;
> -
> -	err = iio_triggered_buffer_predisable(indio_dev);
>  
> -st_magn_buffer_predisable_error:
>  	kfree(mdata->buffer_data);
>  	return err;
>  }
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 90e895adf997..268da7992ff5 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -295,7 +295,6 @@ static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
>  	.preenable = lmp91000_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
>  	.predisable = lmp91000_buffer_predisable,
>  };
>  
> diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
> index 99468d0a64e7..4cb8239f2599 100644
> --- a/drivers/iio/pressure/st_pressure_buffer.c
> +++ b/drivers/iio/pressure/st_pressure_buffer.c
> @@ -37,25 +37,13 @@ static int st_press_buffer_preenable(struct iio_dev *indio_dev)
>  
>  static int st_press_buffer_postenable(struct iio_dev *indio_dev)
>  {
> -	int err;
>  	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  
>  	press_data->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (press_data->buffer_data == NULL) {
> -		err = -ENOMEM;
> -		goto allocate_memory_error;
> -	}
> -
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0)
> -		goto st_press_buffer_postenable_error;
> -
> -	return err;
> +	if (press_data->buffer_data == NULL)
> +		return -ENOMEM;
>  
> -st_press_buffer_postenable_error:
> -	kfree(press_data->buffer_data);
> -allocate_memory_error:
> -	return err;
> +	return 0;
>  }
>  
>  static int st_press_buffer_predisable(struct iio_dev *indio_dev)
> @@ -63,13 +51,8 @@ static int st_press_buffer_predisable(struct iio_dev *indio_dev)
>  	int err;
>  	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  
> -	err = iio_triggered_buffer_predisable(indio_dev);
> -	if (err < 0)
> -		goto st_press_buffer_predisable_error;
> -
>  	err = st_sensors_set_enable(indio_dev, false);
>  
> -st_press_buffer_predisable_error:
>  	kfree(press_data->buffer_data);
>  	return err;
>  }
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 81d8f24eaeb4..2c4295087a36 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -1271,11 +1271,6 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
>  			goto err;
>  	}
>  
> -	/* Plug our own trigger event handler. */
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err)
> -		goto err;
> -
>  	return 0;
>  
>  err:
> @@ -1294,7 +1289,6 @@ static int zpa2326_postdisable_buffer(struct iio_dev *indio_dev)
>  static const struct iio_buffer_setup_ops zpa2326_buffer_setup_ops = {
>  	.preenable   = zpa2326_preenable_buffer,
>  	.postenable  = zpa2326_postenable_buffer,
> -	.predisable  = iio_triggered_buffer_predisable,
>  	.postdisable = zpa2326_postdisable_buffer
>  };
>  
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index ff80409e0c44..73335e61b350 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -707,8 +707,6 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
>  	struct sx9500_data *data = iio_priv(indio_dev);
>  	int ret = 0, i;
>  
> -	iio_triggered_buffer_predisable(indio_dev);
> -
>  	mutex_lock(&data->mutex);
>  
>  	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> @@ -730,7 +728,6 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops = {
>  	.preenable = sx9500_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
>  	.predisable = sx9500_buffer_predisable,
>  };
>  
> diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> index c4f8c7409666..1d3be3a19e76 100644
> --- a/include/linux/iio/trigger_consumer.h
> +++ b/include/linux/iio/trigger_consumer.h
> @@ -53,11 +53,4 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p);
>  
>  void iio_trigger_notify_done(struct iio_trigger *trig);
>  
> -/*
> - * Two functions for common case where all that happens is a pollfunc
> - * is attached and detached from a trigger
> - */
> -int iio_triggered_buffer_postenable(struct iio_dev *indio_dev);
> -int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
> -
>  #endif
> 
