Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35930 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967358AbcCQRYw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Mar 2016 13:24:52 -0400
Received: by mail-lb0-f178.google.com with SMTP id qe11so18621738lbc.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Mar 2016 10:24:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1458232366-12773-3-git-send-email-daniel.baluta@intel.com>
References: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com> <1458232366-12773-3-git-send-email-daniel.baluta@intel.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 17 Mar 2016 10:24:10 -0700
Message-ID: <CAKzfze_AzVcENw0i59obVw5_ksoKcF0iGheHGB=nF_4y0hS3bw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: Move request IRQ outside of probe trigger
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>, cmo@melexis.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	ggao@invensense.com, srinivas.pandruvada@linux.intel.com,
	adi.reus@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-By: Matt Ranostay <matt.ranostay@intel.com>

On Thu, Mar 17, 2016 at 9:32 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> Besides signalling data ready, IRQ line of Invensense MPU
> can also signal the status of slaves attached on secondary
> I2C bus.
>
> In order to prepare supporting secondary I2C interface we need
> to detach IRQ request from data ready trigger creation.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 8 ++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index d192953..659a4be 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -823,6 +823,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>                 goto out_unreg_ring;
>         }
>
> +       result = devm_request_irq(&indio_dev->dev, st->irq,
> +                                 &iio_trigger_generic_data_rdy_poll,
> +                                 IRQF_TRIGGER_RISING, "inv_mpu", st->trig);
> +       if (result) {
> +               dev_err(dev, "request irq fail %d\n", result);
> +               goto out_remove_trigger;
> +       }
> +
>         INIT_KFIFO(st->timestamps);
>         spin_lock_init(&st->time_stamp_lock);
>         result = iio_device_register(indio_dev);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index e8818d4..acfa513 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -123,14 +123,6 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>         if (!st->trig)
>                 return -ENOMEM;
>
> -       ret = devm_request_irq(&indio_dev->dev, st->irq,
> -                              &iio_trigger_generic_data_rdy_poll,
> -                              IRQF_TRIGGER_RISING,
> -                              "inv_mpu",
> -                              st->trig);
> -       if (ret)
> -               return ret;
> -
>         st->trig->dev.parent = regmap_get_device(st->map);
>         st->trig->ops = &inv_mpu_trigger_ops;
>         iio_trigger_set_drvdata(st->trig, indio_dev);
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
