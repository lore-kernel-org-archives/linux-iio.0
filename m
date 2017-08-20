Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbdHTLJN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 07:09:13 -0400
Date: Sun, 20 Aug 2017 12:07:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 032/102] iio: dac: stm32-dac-core: explicitly request
 exclusive reset control
Message-ID: <20170820120704.25a35236@archlinux>
In-Reply-To: <20170719152646.25903-33-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
        <20170719152646.25903-33-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 19 Jul 2017 17:25:36 +0200
Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
> 
> No functional changes.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/stm32-dac-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> index 75e48788c7ead..f1eeb1549f689 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -114,7 +114,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  		goto err_vref;
>  	}
>  
> -	priv->rst = devm_reset_control_get(dev, NULL);
> +	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
>  	if (!IS_ERR(priv->rst)) {
>  		reset_control_assert(priv->rst);
>  		udelay(2);

