Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35564 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbcENQyN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 12:54:13 -0400
Subject: Re: [PATCH 1/3] iio: st_sensors: Init trigger before irq request
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a1da1291-0f7a-f608-6a09-82bcfc94a071@kernel.org>
Date: Sat, 14 May 2016 17:54:11 +0100
MIME-Version: 1.0
In-Reply-To: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/16 19:43, Crestez Dan Leonard wrote:
> This fixes a possible race where an interrupt arrives before complete
> initialization and crashes because iio_trigger_get_drvdata returns NULL.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Looks 'obviously' correct to me, but I'd like Denis to confirm on this one.

Jonathan
> ---
> I ran into this while breaking the driver. But since the interrupt line can be
> shared the handler should always be able to accept and ignore a call.
> 
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 98bd5b3..7c2e6ab 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -89,6 +89,10 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  		return -ENOMEM;
>  	}
>  
> +	iio_trigger_set_drvdata(sdata->trig, indio_dev);
> +	sdata->trig->ops = trigger_ops;
> +	sdata->trig->dev.parent = sdata->dev;
> +
>  	irq = sdata->get_irq_data_ready(indio_dev);
>  	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
>  	/*
> @@ -150,10 +154,6 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  		goto iio_trigger_free;
>  	}
>  
> -	iio_trigger_set_drvdata(sdata->trig, indio_dev);
> -	sdata->trig->ops = trigger_ops;
> -	sdata->trig->dev.parent = sdata->dev;
> -
>  	err = iio_trigger_register(sdata->trig);
>  	if (err < 0) {
>  		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
> 

