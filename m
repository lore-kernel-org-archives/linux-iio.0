Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9121 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752027AbeFVOS5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Jun 2018 10:18:57 -0400
Date: Fri, 22 Jun 2018 15:18:27 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, Martin Kelly <mkelly@xevo.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 4.18 REGRESSION fix] iio: imu: inv_mpu6050: Fix probe()
 failure on older ACPI based machines
Message-ID: <20180622151827.00006396@huawei.com>
In-Reply-To: <20180618160936.6471-1-hdegoede@redhat.com>
References: <20180618160936.6471-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Jun 2018 18:09:36 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Commit 5ec6486daa98 ("iio:imu: inv_mpu6050: support more interrupt types")
> causes inv_mpu_core_probe() to fail if the IRQ does not have a
> trigger-type setup.
> 
> This happens on machines where the mpu6050 is enumerated through ACPI and
> an older Interrupt type ACPI resource is used for the interrupt, rather
> then a GpioInt type type, causing the mpu6050 driver to no longer work
> there. This happens on e.g. the Asus T100TA.
> 
> This commits makes the mpu6050 fallback to the old IRQF_TRIGGER_RISING
> default if the irq-type is not setup, fixing this.
> 
> Fixes: 5ec6486daa98 ("iio:imu: inv_mpu6050: support more interrupt types")
> Cc: Martin Kelly <mkelly@xevo.com>
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Sorry for the delay - traveling this week.  Will pick this up over the weekend
once I'm back home.

J

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index f9c0624505a2..42618fe4f83e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -959,6 +959,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	}
>  
>  	irq_type = irqd_get_trigger_type(desc);
> +	if (!irq_type)
> +		irq_type = IRQF_TRIGGER_RISING;
>  	if (irq_type == IRQF_TRIGGER_RISING)
>  		st->irq_mask = INV_MPU6050_ACTIVE_HIGH;
>  	else if (irq_type == IRQF_TRIGGER_FALLING)


