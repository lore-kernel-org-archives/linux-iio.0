Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdE2QAX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 May 2017 12:00:23 -0400
Date: Mon, 29 May 2017 17:00:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] iio: adc: stm32: use devm_of_platform_populate()
Message-ID: <20170529170018.3fb2e8aa@kernel.org>
In-Reply-To: <1496072763-31209-2-git-send-email-benjamin.gaignard@linaro.org>
References: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
        <1496072763-31209-2-git-send-email-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 May 2017 17:45:49 +0200
Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:

> Use devm_of_platform_populate() instead of of_platform_populate and
> of_platform_depopulate to simplify driver code
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
My gut feeling is to dislike this particular instance.

It's changing the order of removal of elements to not
be a reverse of the order of them being set up.  That
takes it from obviously correct to something where some thought
is required.  For the trivial saving in lines of code I'm
unconvinced it is a worthwhile change..

Mind you, this particular driver isn't balancing the
probe and remove order anyway (the regulator stuff)
so I guess it's not making it much worse...

Jonathan
> 
> CC: Jonathan Cameron <jic23@kernel.org>
> CC: Hartmut Knaack <knaack.h@gmx.de>
> CC: Lars-Peter Clausen <lars@metafoo.de>
> CC: Alexandre Torgue <alexandre.torgue@st.com>
> CC: Fabrice Gasnier <fabrice.gasnier@st.com>
> CC: linux-iio@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/iio/adc/stm32-adc-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 22b7c93..46e41dc5 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -186,7 +186,6 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
>  static int stm32_adc_probe(struct platform_device *pdev)
>  {
>  	struct stm32_adc_priv *priv;
> -	struct device_node *np = pdev->dev.of_node;
>  	struct resource *res;
>  	int ret;
>  
> @@ -249,7 +248,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, &priv->common);
>  
> -	ret = of_platform_populate(np, NULL, NULL, &pdev->dev);
> +	ret = devm_of_platform_populate(&pdev->dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to populate DT children\n");
>  		goto err_irq_remove;
> @@ -274,7 +273,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  	struct stm32_adc_common *common = platform_get_drvdata(pdev);
>  	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
>  
> -	of_platform_depopulate(&pdev->dev);
>  	stm32_adc_irq_remove(pdev, priv);
>  	clk_disable_unprepare(priv->aclk);
>  	regulator_disable(priv->vref);

