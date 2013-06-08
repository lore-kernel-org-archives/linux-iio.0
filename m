Return-Path: <jic23@kernel.org>
Message-ID: <51B2F2D8.7070503@kernel.org>
Date: Sat, 08 Jun 2013 10:01:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, kbuild-all@01.org,
 Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH V2] iio:trigger:interrupt fix formatting of rsize variable
 in name
References: <1370543242-10405-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1370543242-10405-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/06/2013 07:27 PM, Jonathan Cameron wrote:
> The name includes irq_res->start which of type resource_size_t not integer.
> We could in theory use %pa for this but then it would be in hex and also
> that causes a warning about incorrect types anyway.  Hence just
> use the irq local variable we assigned the line above.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Applied to togreg branch of iio.git

> ---
>  drivers/iio/trigger/iio-trig-interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index 84bf397..02577ec 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -50,7 +50,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  
>  	irq = irq_res->start;
>  
> -	trig = iio_trigger_alloc("irqtrig%d", irq_res->start);
> +	trig = iio_trigger_alloc("irqtrig%d", irq);
>  	if (!trig) {
>  		ret = -ENOMEM;
>  		goto error_ret;
> 
