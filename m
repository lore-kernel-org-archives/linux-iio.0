Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdGIScM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 14:32:12 -0400
Date: Sun, 9 Jul 2017 19:32:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH 4/9] iio: humidity: hts221: avoid useless ODR
 reconfiguration
Message-ID: <20170709193208.6864b158@kernel.org>
In-Reply-To: <20170709165704.26311-5-lorenzo.bianconi@st.com>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
        <20170709165704.26311-5-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  9 Jul 2017 18:56:59 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Configure sensor ODR just in hts221_write_raw() in order to avoid
> to set device sample rate multiple times.
> Squash hts221_power_off()/hts221_power_on() in hts221_set_enable()
Two changes = two patches please.

Actual contents for each looks fine.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  drivers/iio/humidity/hts221.h        |  3 +--
>  drivers/iio/humidity/hts221_buffer.c |  4 ++--
>  drivers/iio/humidity/hts221_core.c   | 37 +++++++++++-------------------------
>  3 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index 94510266e0a5..7b5691a6df53 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -68,8 +68,7 @@ extern const struct dev_pm_ops hts221_pm_ops;
>  
>  int hts221_config_drdy(struct hts221_hw *hw, bool enable);
>  int hts221_probe(struct iio_dev *iio_dev);
> -int hts221_power_on(struct hts221_hw *hw);
> -int hts221_power_off(struct hts221_hw *hw);
> +int hts221_set_enable(struct hts221_hw *hw, bool enable);
>  int hts221_allocate_buffers(struct hts221_hw *hw);
>  int hts221_allocate_trigger(struct hts221_hw *hw);
>  
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 7d19a3da7ab7..c4ed153ad397 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -109,12 +109,12 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  
>  static int hts221_buffer_preenable(struct iio_dev *iio_dev)
>  {
> -	return hts221_power_on(iio_priv(iio_dev));
> +	return hts221_set_enable(iio_priv(iio_dev), true);
>  }
>  
>  static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
>  {
> -	return hts221_power_off(iio_priv(iio_dev));
> +	return hts221_set_enable(iio_priv(iio_dev), false);
>  }
>  
>  static const struct iio_buffer_setup_ops hts221_buffer_ops = {
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index b36734b8070e..7d30e2594a58 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -207,11 +207,6 @@ static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>  	if (err < 0)
>  		return err;
>  
> -	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_ENABLE_MASK, 1);
> -	if (err < 0)
> -		return err;
> -
>  	hw->odr = odr;
>  
>  	return 0;
> @@ -290,29 +285,16 @@ hts221_sysfs_temp_oversampling_avail(struct device *dev,
>  	return len;
>  }
>  
> -int hts221_power_on(struct hts221_hw *hw)
> -{
> -	int err;
> -
> -	err = hts221_update_odr(hw, hw->odr);
> -	if (err < 0)
> -		return err;
> -
> -	hw->enabled = true;
> -
> -	return 0;
> -}
> -
> -int hts221_power_off(struct hts221_hw *hw)
> +int hts221_set_enable(struct hts221_hw *hw, bool enable)
>  {
>  	int err;
>  
>  	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_ENABLE_MASK, false);
> +				     HTS221_ENABLE_MASK, enable);
>  	if (err < 0)
>  		return err;
>  
> -	hw->enabled = false;
> +	hw->enabled = enable;
>  
>  	return 0;
>  }
> @@ -467,7 +449,7 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>  	u8 data[HTS221_DATA_SIZE];
>  	int err;
>  
> -	err = hts221_power_on(hw);
> +	err = hts221_set_enable(hw, true);
>  	if (err < 0)
>  		return err;
>  
> @@ -477,7 +459,7 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>  	if (err < 0)
>  		return err;
>  
> -	hts221_power_off(hw);
> +	hts221_set_enable(hw, false);
>  
>  	*val = (s16)get_unaligned_le16(data);
>  
> @@ -627,8 +609,6 @@ int hts221_probe(struct iio_dev *iio_dev)
>  	if (err < 0)
>  		return err;
>  
> -	hw->odr = hts221_odr_table[0].hz;
> -
>  	iio_dev->modes = INDIO_DIRECT_MODE;
>  	iio_dev->dev.parent = hw->dev;
>  	iio_dev->available_scan_masks = hts221_scan_masks;
> @@ -643,6 +623,10 @@ int hts221_probe(struct iio_dev *iio_dev)
>  	if (err < 0)
>  		return err;
>  
> +	err = hts221_update_odr(hw, hts221_odr_table[0].hz);
> +	if (err < 0)
> +		return err;
> +
>  	/* configure humidity sensor */
>  	err = hts221_parse_rh_caldata(hw);
>  	if (err < 0) {
> @@ -706,7 +690,8 @@ static int __maybe_unused hts221_resume(struct device *dev)
>  	int err = 0;
>  
>  	if (hw->enabled)
> -		err = hts221_update_odr(hw, hw->odr);
> +		err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> +					     HTS221_ENABLE_MASK, true);
>  
>  	return err;
>  }

