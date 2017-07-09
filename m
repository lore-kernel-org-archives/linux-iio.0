Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdGIS3r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 14:29:47 -0400
Date: Sun, 9 Jul 2017 19:29:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH 2/9] iio: humidity: hts221: move BDU configuration in
 probe routine
Message-ID: <20170709192943.1bbe5e23@kernel.org>
In-Reply-To: <20170709165704.26311-3-lorenzo.bianconi@st.com>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
        <20170709165704.26311-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  9 Jul 2017 18:56:57 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Enable Block Data Update in hts221_probe() in order to avoid to reconfigure
> it every time the sensor is enabled
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Well there goes part of my concern about extra writes.

Patch looks good

Jonathan
> ---
>  drivers/iio/humidity/hts221_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index f5181e4e1eff..9546b0ea6283 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -202,12 +202,6 @@ static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>  	if (i == ARRAY_SIZE(hts221_odr_table))
>  		return -EINVAL;
>  
> -	/* enable Block Data Update */
> -	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_BDU_MASK, 1);
> -	if (err < 0)
> -		return err;
> -
>  	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
>  				     HTS221_ODR_MASK, hts221_odr_table[i].val);
>  	if (err < 0)
> @@ -644,6 +638,12 @@ int hts221_probe(struct iio_dev *iio_dev)
>  	iio_dev->name = HTS221_DEV_NAME;
>  	iio_dev->info = &hts221_info;
>  
> +	/* enable Block Data Update */
> +	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> +				     HTS221_BDU_MASK, 1);
> +	if (err < 0)
> +		return err;
> +
>  	/* configure humidity sensor */
>  	err = hts221_parse_rh_caldata(hw);
>  	if (err < 0) {

