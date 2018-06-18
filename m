Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755249AbeFRQJk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Jun 2018 12:09:40 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Martin Kelly <mkelly@xevo.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 4.18 REGRESSION fix] iio: imu: inv_mpu6050: Fix probe() failure on older ACPI based machines
Date: Mon, 18 Jun 2018 18:09:36 +0200
Message-Id: <20180618160936.6471-1-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 5ec6486daa98 ("iio:imu: inv_mpu6050: support more interrupt types")
causes inv_mpu_core_probe() to fail if the IRQ does not have a
trigger-type setup.

This happens on machines where the mpu6050 is enumerated through ACPI and
an older Interrupt type ACPI resource is used for the interrupt, rather
then a GpioInt type type, causing the mpu6050 driver to no longer work
there. This happens on e.g. the Asus T100TA.

This commits makes the mpu6050 fallback to the old IRQF_TRIGGER_RISING
default if the irq-type is not setup, fixing this.

Fixes: 5ec6486daa98 ("iio:imu: inv_mpu6050: support more interrupt types")
Cc: Martin Kelly <mkelly@xevo.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index f9c0624505a2..42618fe4f83e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -959,6 +959,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	irq_type = irqd_get_trigger_type(desc);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_RISING;
 	if (irq_type == IRQF_TRIGGER_RISING)
 		st->irq_mask = INV_MPU6050_ACTIVE_HIGH;
 	else if (irq_type == IRQF_TRIGGER_FALLING)
-- 
2.17.1

