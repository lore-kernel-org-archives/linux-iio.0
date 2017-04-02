Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47217 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdDBIrf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:47:35 -0400
Subject: Re: [PATCH] iio: adc: Remove unnecessary cast on void pointer
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401140613.GA20941@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martine Canillas <javier@osg.samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fc8b71c3-bdd4-834e-70bb-439ea4228401@kernel.org>
Date: Sun, 2 Apr 2017 09:47:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170401140613.GA20941@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 15:06, simran singhal wrote:
> The following Coccinelle script was used to detect this:
> @r@
> expression x;
> void* e;
> type T;
> identifier f;
> @@
> (
>   *((T *)e)
> |
>   ((T *)x)[...]
> |
>   ((T*)x)->f
> |
> - (T*)
>   e
> )
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Given the set of void pointer casting cleanups you have posted
are all doing the same thing to lots of drivers, I would have
liked to have seen them as a series.  Keeps them nicely
grouped in peoples email clients once replies start coming in!

Anyhow, patch is good so applied.

Jonathan
> ---
>  drivers/iio/adc/exynos_adc.c      | 2 +-
>  drivers/iio/adc/imx7d_adc.c       | 2 +-
>  drivers/iio/adc/max1027.c         | 2 +-
>  drivers/iio/adc/rockchip_saradc.c | 2 +-
>  drivers/iio/adc/sun4i-gpadc-iio.c | 2 +-
>  drivers/iio/adc/vf610_adc.c       | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index ad1775b..6c5a7be 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -579,7 +579,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
>  
>  static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
>  {
> -	struct exynos_adc *info = (struct exynos_adc *)dev_id;
> +	struct exynos_adc *info = dev_id;
>  	u32 mask = info->data->mask;
>  
>  	/* Read value */
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index e2241ee..254b29a 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -365,7 +365,7 @@ static int imx7d_adc_read_data(struct imx7d_adc *info)
>  
>  static irqreturn_t imx7d_adc_isr(int irq, void *dev_id)
>  {
> -	struct imx7d_adc *info = (struct imx7d_adc *)dev_id;
> +	struct imx7d_adc *info = dev_id;
>  	int status;
>  
>  	status = readl(info->regs + IMX7D_REG_ADC_INT_STATUS);
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 3b7c4f7..ebc7159 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -364,7 +364,7 @@ static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
>  
>  static irqreturn_t max1027_trigger_handler(int irq, void *private)
>  {
> -	struct iio_poll_func *pf = (struct iio_poll_func *)private;
> +	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct max1027_state *st = iio_priv(indio_dev);
>  
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 85d7012..ae6d332 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -109,7 +109,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>  
>  static irqreturn_t rockchip_saradc_isr(int irq, void *dev_id)
>  {
> -	struct rockchip_saradc *info = (struct rockchip_saradc *)dev_id;
> +	struct rockchip_saradc *info = dev_id;
>  
>  	/* Read value */
>  	info->last_val = readl_relaxed(info->regs + SARADC_DATA);
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index a8e134f..e531825 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -382,7 +382,7 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
>  
>  static int sun4i_gpadc_get_temp(void *data, int *temp)
>  {
> -	struct sun4i_gpadc_iio *info = (struct sun4i_gpadc_iio *)data;
> +	struct sun4i_gpadc_iio *info = data;
>  	int val, scale, offset;
>  
>  	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 228a003..01fc76f 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -584,7 +584,7 @@ static int vf610_adc_read_data(struct vf610_adc *info)
>  
>  static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
>  {
> -	struct iio_dev *indio_dev = (struct iio_dev *)dev_id;
> +	struct iio_dev *indio_dev = dev_id;
>  	struct vf610_adc *info = iio_priv(indio_dev);
>  	int coco;
>  
> 

