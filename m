Return-Path: <SRS0=jQ14=3G=lip6.fr=julia.lawall@kernel.org>
Date: Wed, 29 Mar 2017 08:07:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: lars@metafoo.de, Michael Hennerich <Michael.Hennerich@analog.com>,
    Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
    devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
    outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: Use devm functions
In-Reply-To: <20170329050909.GA18738@arushi-HP-Pavilion-Notebook>
Message-ID: <alpine.DEB.2.20.1703290806080.2053@hadrien>
References: <20170329050909.GA18738@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Wed, 29 Mar 2017, Arushi Singhal wrote:

> Use managed resource functions devm_request_irq instead of request_irq.
> Remove corresponding calls to free_irq in the probe.

This transformation is dangerous, because it moves the stopping of
interrupts from where the free_irq is to after the end of the function (ie
in the caller).  You have to be very sure that the interrupt handler will
not use any resources that are freed by the subsequent cleanup code, ie
iio_trigger_unregister and iio_trigger_free.

julia


>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 4e0b4eedb53d..42473d095911 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -211,8 +211,9 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out;
>
> -	ret = request_irq(st->irq, iio_bfin_tmr_trigger_isr,
> -			  0, st->trig->name, st);
> +	ret = devm_request_irq(&pdev->dev,
> +			       st->irq, iio_bfin_tmr_trigger_isr,
> +			       0, st->trig->name, st);
>  	if (ret) {
>  		dev_err(&pdev->dev,
>  			"request IRQ-%d failed", st->irq);
> @@ -256,7 +257,6 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>
>  	return 0;
>  out_free_irq:
> -	free_irq(st->irq, st);
>  out1:
>  	iio_trigger_unregister(st->trig);
>  out:
> @@ -271,7 +271,6 @@ static int iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
>  	disable_gptimers(st->t->bit);
>  	if (st->output_enable)
>  		peripheral_free(st->t->pin);
> -	free_irq(st->irq, st);
>  	iio_trigger_unregister(st->trig);
>  	iio_trigger_free(st->trig);
>
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170329050909.GA18738%40arushi-HP-Pavilion-Notebook.
> For more options, visit https://groups.google.com/d/optout.
>
