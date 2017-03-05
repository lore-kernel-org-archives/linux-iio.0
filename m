Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60035 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdCEMSm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 07:18:42 -0500
Subject: Re: [PATCH v3 4/6] iio: iio-interrupt-trigger: device-tree support
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-5-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        linus.walleij@linaro.org,
        =?UTF-8?Q?Gr=c3=a9gor_Boirie?= <gregor.boirie@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dc57ecb6-79ce-ba24-0b23-5166e30f8162@kernel.org>
Date: Sun, 5 Mar 2017 12:18:38 +0000
MIME-Version: 1.0
In-Reply-To: <1488300679-3259-5-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/02/17 16:51, Fabrice Gasnier wrote:
> From: Grégor Boirie <gregor.boirie@parrot.com>
> 
> Add compatible string that should be used in DT.
> Also cascade of_node to newly allocated trigger device.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
I'd normally not keep Gregor's sign off in a patch that has been
changed like this.  If Gregor is happy it's a different matter,
but I suspect he hasn't replied yet as he is always very busy!

> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Otherwise, all good, subject to convincing the device tree
guys about the binding.

Jonathan
> ---
> Original PATCH from Gregor Boirie:
> https://marc.info/?l=linux-iio&m=145590953607905&w=4
> 
> Updates:
> - compatible string changed to "interrupt-trigger"
> - cascade of_node down to iio trigger device
> ---
>  drivers/iio/trigger/iio-trig-interrupt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index e18f12b..6ee1f7e 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -62,6 +62,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  	}
>  	iio_trigger_set_drvdata(trig, trig_info);
>  	trig_info->irq = irq;
> +	trig->dev.of_node = pdev->dev.of_node;
>  	trig->ops = &iio_interrupt_trigger_ops;
>  	ret = request_irq(irq, iio_interrupt_trigger_poll,
>  			  irqflags, trig->name, trig);
> @@ -104,11 +105,20 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id iio_interrupt_trigger_of_match[] = {
> +	{ .compatible = "interrupt-trigger" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, iio_interrupt_trigger_of_match);
> +#endif
> +
>  static struct platform_driver iio_interrupt_trigger_driver = {
>  	.probe = iio_interrupt_trigger_probe,
>  	.remove = iio_interrupt_trigger_remove,
>  	.driver = {
>  		.name = "iio_interrupt_trigger",
> +		.of_match_table = of_match_ptr(iio_interrupt_trigger_of_match),
>  	},
>  };
>  
> 

