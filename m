Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:19168
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755355AbeFRQoJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Jun 2018 12:44:09 -0400
Subject: Re: [PATCH 4.18 REGRESSION fix] iio: imu: inv_mpu6050: Fix probe()
 failure on older ACPI based machines
To: Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
References: <20180618160936.6471-1-hdegoede@redhat.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <889686c1-d8cb-72bd-75ac-e87c51e8ab55@xevo.com>
Date: Mon, 18 Jun 2018 09:44:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180618160936.6471-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/18/2018 09:09 AM, Hans de Goede wrote:
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
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index f9c0624505a2..42618fe4f83e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -959,6 +959,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>   	}
>   
>   	irq_type = irqd_get_trigger_type(desc);
> +	if (!irq_type)
> +		irq_type = IRQF_TRIGGER_RISING;
>   	if (irq_type == IRQF_TRIGGER_RISING)
>   		st->irq_mask = INV_MPU6050_ACTIVE_HIGH;
>   	else if (irq_type == IRQF_TRIGGER_FALLING)
> 

Reviewed-by: Martin Kelly <mkelly@xevo.com>

Thanks, good catch! I had thought that irqd_get_trigger_type would work 
the same universally, but I see I was mistaken.
