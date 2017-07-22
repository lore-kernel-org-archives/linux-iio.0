Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdGVUT2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jul 2017 16:19:28 -0400
Date: Sat, 22 Jul 2017 21:19:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 04/10] iio: humidity: hts221: avoid useless ODR
 reconfiguration
Message-ID: <20170722211923.031cb54b@kernel.org>
In-Reply-To: <20170717173905.8209-5-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-5-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 19:38:59 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Configure sensor ODR just in hts221_write_raw() in order to avoid
> to set device sample rate multiple times.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/hts221_core.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 6e5847386a45..f99adc44139e 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -208,11 +208,6 @@ static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
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
> @@ -294,7 +289,8 @@ int hts221_power_on(struct hts221_hw *hw)
>  {
>  	int err;
>  
> -	err = hts221_update_odr(hw, hw->odr);
> +	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> +				     HTS221_ENABLE_MASK, true);
>  	if (err < 0)
>  		return err;
>  
> @@ -627,8 +623,6 @@ int hts221_probe(struct iio_dev *iio_dev)
>  	if (err < 0)
>  		return err;
>  
> -	hw->odr = hts221_odr_table[0].hz;
> -
>  	iio_dev->modes = INDIO_DIRECT_MODE;
>  	iio_dev->dev.parent = hw->dev;
>  	iio_dev->available_scan_masks = hts221_scan_masks;
> @@ -643,6 +637,10 @@ int hts221_probe(struct iio_dev *iio_dev)
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
> @@ -706,7 +704,8 @@ static int __maybe_unused hts221_resume(struct device *dev)
>  	int err = 0;
>  
>  	if (hw->enabled)
> -		err = hts221_update_odr(hw, hw->odr);
> +		err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> +					     HTS221_ENABLE_MASK, true);
>  
>  	return err;
>  }

