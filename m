Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60246 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcBUTz3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 14:55:29 -0500
Subject: Re: [PATCH v1 1/2] iio:iio-interrupt-trigger: device-tree support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1455908065.git.gregor.boirie@parrot.com>
 <d8f7902dbfe6e911e6ac0d1117502a02b1212022.1455908065.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA162C.5010406@kernel.org>
Date: Sun, 21 Feb 2016 19:55:24 +0000
MIME-Version: 1.0
In-Reply-To: <d8f7902dbfe6e911e6ac0d1117502a02b1212022.1455908065.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/02/16 19:18, Gregor Boirie wrote:
> From: Grégor Boirie <gregor.boirie@parrot.com>
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Snag here is that iio_interrupt_trigger is a very linux specific
name and device tree bindings should be just about the hardware.

Not entirely sure how we avoid this though as the use is rather
hard to describe generically.

cc'd device tree list and bindings maintainers.

As a brief summary - this IIO trigger driver takes a generic
interrupt (from whatever) and uses it to drive sampling of IIO devices.
The interrupt might be associated with particularly simple sensors directly
but is more commonly a gpio interrupt line used cause samples to be captured
from unrelated devices.  Sometimes the source of that interrupt can be a convoluted
external mux setup over which linux has no control for example.

Any suggestions on appropriate naming?

We aren't really describing hardware here, rather a policy decision on what
a given interrupt is to be used for.

I suppose ultimately we could take the view this should be handled via another
route (from userspace via an appropriate configfs interface for example).

Jonathan
> ---
>  drivers/iio/trigger/iio-trig-interrupt.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index 572bc6f..3c4e18f 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -104,11 +104,20 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id iio_interrupt_trigger_of_match[] = {
> +	{ .compatible = "iio-interrupt-trigger" },
> +	{}
> +};
> +#endif
> +
>  static struct platform_driver iio_interrupt_trigger_driver = {
>  	.probe = iio_interrupt_trigger_probe,
>  	.remove = iio_interrupt_trigger_remove,
>  	.driver = {
> -		.name = "iio_interrupt_trigger",
> +		.name           = "iio_interrupt_trigger",
> +		.owner          = THIS_MODULE,
> +		.of_match_table = of_match_ptr(iio_interrupt_trigger_of_match)
>  	},
>  };
>  
> 

