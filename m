Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753000AbdICP4j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 11:56:39 -0400
Date: Sun, 3 Sep 2017 16:56:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1015: write config register only on
 change
Message-ID: <20170903165635.153aa4e7@archlinux>
In-Reply-To: <20170824082551.ciqar4kw2oexnnvn@lenoch>
References: <20170824082551.ciqar4kw2oexnnvn@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 24 Aug 2017 10:25:51 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> There is no point writing ADS1015_CFG_REG when configuration
> didn't change. Avoid that.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Fair enough.  Applied to the togreg branch of iio.git which will be
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads1015.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 7838e39c790c..034e48566ab5 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -240,7 +240,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  static
>  int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>  {
> -	int ret, pga, dr, conv_time;
> +	int ret, pga, dr, dr_old, conv_time;
>  	unsigned int old, mask, cfg;
>  
>  	if (chan < 0 || chan >= ADS1015_CHANNELS)
> @@ -256,17 +256,16 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>  		ADS1015_CFG_DR_MASK;
>  	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
>  		dr << ADS1015_CFG_DR_SHIFT;
> -
>  	cfg = (old & ~mask) | (cfg & mask);
>  
> -	ret = regmap_write(data->regmap, ADS1015_CFG_REG, cfg);
> -	if (ret)
> -		return ret;
> -
> -	if (old != cfg || data->conv_invalid) {
> -		int dr_old = (old & ADS1015_CFG_DR_MASK) >>
> -				ADS1015_CFG_DR_SHIFT;
> -
> +	if (old != cfg) {
> +		ret = regmap_write(data->regmap, ADS1015_CFG_REG, cfg);
> +		if (ret)
> +			return ret;
> +		data->conv_invalid = true;
> +	}
> +	if (data->conv_invalid) {
> +		dr_old = (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_SHIFT;
>  		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr_old]);
>  		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
>  		usleep_range(conv_time, conv_time + 1);

