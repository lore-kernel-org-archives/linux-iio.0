Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50311 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbbADRzW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 12:55:22 -0500
Message-ID: <54A97E89.30109@kernel.org>
Date: Sun, 04 Jan 2015 17:55:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging:iio:ad5933: Remove platform data from
 state struct
References: <1411655235-7635-1-git-send-email-lars@metafoo.de> <1411655235-7635-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1411655235-7635-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/14 15:27, Lars-Peter Clausen wrote:
> The platform data is only used in the probe function. No need to keep it
> around.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
> No changes since v1
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 95b17c5..3c5d917 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -89,7 +89,6 @@
>  struct ad5933_state {
>  	struct i2c_client		*client;
>  	struct regulator		*reg;
> -	struct ad5933_platform_data	*pdata;
>  	struct delayed_work		work;
>  	unsigned long			mclk_hz;
>  	unsigned char			ctrl_hb;
> @@ -712,9 +711,7 @@ static int ad5933_probe(struct i2c_client *client,
>  	st->client = client;
>  
>  	if (!pdata)
> -		st->pdata = &ad5933_default_pdata;
> -	else
> -		st->pdata = pdata;
> +		pdata = &ad5933_default_pdata;
>  
>  	st->reg = devm_regulator_get(&client->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
> @@ -727,10 +724,10 @@ static int ad5933_probe(struct i2c_client *client,
>  	if (voltage_uv)
>  		st->vref_mv = voltage_uv / 1000;
>  	else
> -		st->vref_mv = st->pdata->vref_mv;
> +		st->vref_mv = pdata->vref_mv;
>  
> -	if (st->pdata->ext_clk_Hz) {
> -		st->mclk_hz = st->pdata->ext_clk_Hz;
> +	if (pdata->ext_clk_Hz) {
> +		st->mclk_hz = pdata->ext_clk_Hz;
>  		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
>  	} else {
>  		st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
> 

