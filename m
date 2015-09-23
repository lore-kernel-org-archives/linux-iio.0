Return-Path: <jic23@jic23.retrosnub.co.uk>
Subject: Re: [PATCH iio] Staging: iio: iio_dummy_work_handler() can be static
To: kbuild test robot <fengguang.wu@intel.com>,
 Cristina Opriceana <cristina.opriceana@gmail.com>
References: <201509221137.FOcoYSRf%fengguang.wu@intel.com>
 <20150922030251.GA25672@lkp-sb04>
Cc: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <5602F8C4.9020602@jic23.retrosnub.co.uk>
Date: Wed, 23 Sep 2015 20:08:52 +0100
MIME-Version: 1.0
In-Reply-To: <20150922030251.GA25672@lkp-sb04>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 22/09/15 04:02, kbuild test robot wrote:
> 
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
As this one was very near the top of my tree, squished into the original patch.
> ---
>  iio_dummy_evgen.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
> index 2bb4350..86d8447 100644
> --- a/drivers/staging/iio/iio_dummy_evgen.c
> +++ b/drivers/staging/iio/iio_dummy_evgen.c
> @@ -81,7 +81,7 @@ static void iio_dummy_event_irqunmask(struct irq_data *d)
>  	evgen->enabled[d->irq - evgen->base] = true;
>  }
>  
> -void iio_dummy_work_handler(struct irq_work *work)
> +static void iio_dummy_work_handler(struct irq_work *work)
>  {
>  	struct iio_dummy_handle_irq *irq_handler;
>  
> 
