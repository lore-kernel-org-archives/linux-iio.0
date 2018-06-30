Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751286AbeF3Rkx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 13:40:53 -0400
Date: Sat, 30 Jun 2018 18:40:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org,
        Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH] iio: adc: ina2xx: avoid kthread_stop() with stale
 task_struct
Message-ID: <20180630184049.47d10937@archlinux>
In-Reply-To: <1529852721-17828-1-git-send-email-akinobu.mita@gmail.com>
References: <1529852721-17828-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Jun 2018 00:05:21 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> When the buffer is enabled for ina2xx driver, a dedicated kthread is
> invoked to capture mesurement data.  When the buffer is disabled, the
> kthread is stopped.
>=20
> However if the kthread gets register access errors, it immediately exits
> and when the malfunctional buffer is disabled, the stale task_struct
> pointer is accessed as there is no kthread to be stopped.
>=20
> A similar issue in the usbip driver is prevented by kthread_get_run and
> kthread_stop_put helpers by increasing usage count of the task_struct.
> This change applies the same solution.
>=20
> Cc: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Seems fine, but this is a fix so should have an appropriate fixes
tag.  Feel free to send one in reply to this thread rather than a v2.

Without a fixes tag it can be very hard to know exactly where
a patch 'should' apply.  I also have little visibility on
how important backporting htis issue is.  What would actually trigger
the issue and is it likely to be seen in the wild?

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ina2xx-adc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 0635a79..d123962 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> +#include <linux/sched/task.h>
>  #include <linux/util_macros.h>
> =20
>  #include <linux/platform_data/ina2xx.h>
> @@ -826,6 +827,7 @@ static int ina2xx_buffer_enable(struct iio_dev *indio=
_dev)
>  {
>  	struct ina2xx_chip_info *chip =3D iio_priv(indio_dev);
>  	unsigned int sampling_us =3D SAMPLING_PERIOD(chip);
> +	struct task_struct *task;
> =20
>  	dev_dbg(&indio_dev->dev, "Enabling buffer w/ scan_mask %02x, freq =3D %=
d, avg =3D%u\n",
>  		(unsigned int)(*indio_dev->active_scan_mask),
> @@ -835,11 +837,17 @@ static int ina2xx_buffer_enable(struct iio_dev *ind=
io_dev)
>  	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
>  		chip->allow_async_readout);
> =20
> -	chip->task =3D kthread_run(ina2xx_capture_thread, (void *)indio_dev,
> -				 "%s:%d-%uus", indio_dev->name, indio_dev->id,
> -				 sampling_us);
> +	task =3D kthread_create(ina2xx_capture_thread, (void *)indio_dev,
> +			      "%s:%d-%uus", indio_dev->name, indio_dev->id,
> +			      sampling_us);
> +	if (IS_ERR(task))
> +		return PTR_ERR(task);
> +
> +	get_task_struct(task);
> +	wake_up_process(task);
> +	chip->task =3D task;
> =20
> -	return PTR_ERR_OR_ZERO(chip->task);
> +	return 0;
>  }
> =20
>  static int ina2xx_buffer_disable(struct iio_dev *indio_dev)
> @@ -848,6 +856,7 @@ static int ina2xx_buffer_disable(struct iio_dev *indi=
o_dev)
> =20
>  	if (chip->task) {
>  		kthread_stop(chip->task);
> +		put_task_struct(chip->task);
>  		chip->task =3D NULL;
>  	}
> =20

