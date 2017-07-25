Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbdGYTDh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Jul 2017 15:03:37 -0400
Date: Tue, 25 Jul 2017 20:03:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 10/10] iio: humidity: hts221: move drdy enable logic
 in hts221_trig_set_state()
Message-ID: <20170725200335.224f0c35@kernel.org>
In-Reply-To: <20170717173905.8209-11-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-11-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 19:39:05 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Move data-ready configuration in hts221_buffer.c since it is only related
> to trigger logic
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks

Jonathan
> ---
>  drivers/iio/humidity/hts221.h        |  1 -
>  drivers/iio/humidity/hts221_buffer.c |  8 +++++++-
>  drivers/iio/humidity/hts221_core.c   | 14 --------------
>  3 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index c3de6e494f8c..51d021966222 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -60,7 +60,6 @@ struct hts221_hw {
>  
>  extern const struct dev_pm_ops hts221_pm_ops;
>  
> -int hts221_config_drdy(struct hts221_hw *hw, bool enable);
>  int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val);
>  int hts221_probe(struct iio_dev *iio_dev);
>  int hts221_set_enable(struct hts221_hw *hw, bool enable);
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index f29f01a22375..9690dfe9a844 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -28,6 +28,8 @@
>  #define HTS221_REG_DRDY_HL_MASK		BIT(7)
>  #define HTS221_REG_DRDY_PP_OD_ADDR	0x22
>  #define HTS221_REG_DRDY_PP_OD_MASK	BIT(6)
> +#define HTS221_REG_DRDY_EN_ADDR		0x22
> +#define HTS221_REG_DRDY_EN_MASK		BIT(2)
>  #define HTS221_REG_STATUS_ADDR		0x27
>  #define HTS221_RH_DRDY_MASK		BIT(1)
>  #define HTS221_TEMP_DRDY_MASK		BIT(0)
> @@ -36,8 +38,12 @@ static int hts221_trig_set_state(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
>  	struct hts221_hw *hw = iio_priv(iio_dev);
> +	int err;
> +
> +	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_EN_ADDR,
> +				     HTS221_REG_DRDY_EN_MASK, state);
>  
> -	return hts221_config_drdy(hw, state);
> +	return err < 0 ? err : 0;
>  }
>  
>  static const struct iio_trigger_ops hts221_trigger_ops = {
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 25fcb9993998..32524a8dc66f 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -23,7 +23,6 @@
>  
>  #define HTS221_REG_CNTRL1_ADDR		0x20
>  #define HTS221_REG_CNTRL2_ADDR		0x21
> -#define HTS221_REG_CNTRL3_ADDR		0x22
>  
>  #define HTS221_REG_AVG_ADDR		0x10
>  #define HTS221_REG_H_OUT_L		0x28
> @@ -36,9 +35,6 @@
>  #define HTS221_BDU_MASK			BIT(2)
>  #define HTS221_ENABLE_MASK		BIT(7)
>  
> -#define HTS221_DRDY_MASK		BIT(2)
> -
> -
>  /* calibration registers */
>  #define HTS221_REG_0RH_CAL_X_H		0x36
>  #define HTS221_REG_1RH_CAL_X_H		0x3a
> @@ -181,16 +177,6 @@ static int hts221_check_whoami(struct hts221_hw *hw)
>  	return 0;
>  }
>  
> -int hts221_config_drdy(struct hts221_hw *hw, bool enable)
> -{
> -	int err;
> -
> -	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL3_ADDR,
> -				     HTS221_DRDY_MASK, enable);
> -
> -	return err < 0 ? err : 0;
> -}
> -
>  static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>  {
>  	int i, err;

