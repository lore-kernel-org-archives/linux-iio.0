Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:2699
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937215AbeFSHpE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Jun 2018 03:45:04 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Martin Kelly <mkelly@xevo.com>
Subject: Re: [PATCH 4.18 REGRESSION fix] iio: imu: inv_mpu6050: Fix probe()
 failure on older ACPI based machines
Date: Tue, 19 Jun 2018 07:44:58 +0000
Message-ID: <SN1PR12MB2525A7EBE42E70E91CF4EFF2C4700@SN1PR12MB2525.namprd12.prod.outlook.com>
References: <20180618160936.6471-1-hdegoede@redhat.com>
In-Reply-To: <20180618160936.6471-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


From: Hans de Goede <hdegoede@redhat.com>
Sent: Monday, June 18, 2018 18:09
To: Jonathan Cameron
Cc: Hans de Goede; Hartmut Knaack; Lars-Peter Clausen; Peter Meerwald-Stadl=
er; linux-iio@vger.kernel.org; Martin Kelly; Jean-Baptiste Maneyrol
Subject: [PATCH 4.18 REGRESSION fix] iio: imu: inv_mpu6050: Fix probe() fai=
lure on older ACPI based machines
=A0=20

CAUTION: This email originated from outside of the organization. Please mak=
e sure the sender is who they say they are and do not click links or open a=
ttachments unless you recognize the sender and know the content is safe.


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
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
=A01 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index f9c0624505a2..42618fe4f83e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -959,6 +959,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, =
const char *name,
=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0 irq_type =3D irqd_get_trigger_type(desc);
+=A0=A0=A0=A0=A0=A0 if (!irq_type)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 irq_type =3D IRQF_TRIGGER_RISIN=
G;
=A0=A0=A0=A0=A0=A0=A0 if (irq_type =3D=3D IRQF_TRIGGER_RISING)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->irq_mask =3D INV_MPU6050_=
ACTIVE_HIGH;
=A0=A0=A0=A0=A0=A0=A0 else if (irq_type =3D=3D IRQF_TRIGGER_FALLING)
--
2.17.1


Good catch indeed, thanks for testing and verifying.

Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=
