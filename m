Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJGXCM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 19:02:12 -0400
Date: Sun, 7 Oct 2018 16:54:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <Dragos.Bogdan@analog.com>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/4] staging: iio: ad5933: rename ext_clk_Hz ->
 ext_clk_hz
Message-ID: <20181007165425.3854419a@archlinux>
In-Reply-To: <20181002115800.12399-1-alexandru.ardelean@analog.com>
References: <20181002115800.12399-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2 Oct 2018 14:57:57 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The checkpatch script doesn't like camel-case names.
> Renamed the variable.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I did briefly wonder we had units of pounds for the ctrl value
below it ;)

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index a2370dd1e1a8..8a920f675b83 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -84,13 +84,13 @@
>  
>  /**
>   * struct ad5933_platform_data - platform specific data
> - * @ext_clk_Hz:		the external clock frequency in Hz, if not set
> + * @ext_clk_hz:		the external clock frequency in Hz, if not set
>   *			the driver uses the internal clock (16.776 MHz)
>   * @vref_mv:		the external reference voltage in millivolt
>   */
>  
>  struct ad5933_platform_data {
> -	unsigned long			ext_clk_Hz;
> +	unsigned long			ext_clk_hz;
>  	unsigned short			vref_mv;
>  };
>  
> @@ -726,8 +726,8 @@ static int ad5933_probe(struct i2c_client *client,
>  	else
>  		st->vref_mv = pdata->vref_mv;
>  
> -	if (pdata->ext_clk_Hz) {
> -		st->mclk_hz = pdata->ext_clk_Hz;
> +	if (pdata->ext_clk_hz) {
> +		st->mclk_hz = pdata->ext_clk_hz;
>  		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
>  	} else {
>  		st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
