Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/3] iio: st_sensors: Use level interrupts
Date: Fri, 13 May 2016 21:43:35 +0300
Message-Id: <6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
In-Reply-To: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
In-Reply-To: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

As far as I can tell DRDY for ST sensors behaves as a level rather than
edge interrupt. Registering for IRQF_TRIGGER_RISING instead of
IRQF_TRIGGER_HIGH mostly works except when the sampling frequency is
high enough that new samples come before the new ones are read
completely. In that case the interrupt line remains high, no more rising
edges occur and the iio buffer stalls.

Configuring the interrupt as IRQF_TRIGGER_HIGH makes it work as
expected. This patch makes it so that st_sensors_trigger interrupt
request code doesn't mangle the request flags into IRQF_TRIGGER_RISING.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
This is an alternative fix to this patch:
	https://www.spinics.net/lists/linux-iio/msg24722.html
[PATCH 2/2 v6] iio: st_sensors: read surplus samples in trigger.

It's not clear if all st_sensors behave this way on DRDY. If they do it might
be better to always request HIGH even if the interrupt is initially configured
for RISING.

I tested on MinnowBoard Max which uses pinctrl-baytrail for gpio irqs. I
initially tested hacking the irq_trig to IRQF_TRIGGER_HIGH with an usb adaptor
(gpio-dln2) and it didn't work but I think that's because that driver doesn't
handle persistently high irqs properly.

 drivers/iio/common/st_sensors/st_sensors_trigger.c | 26 ++++++++++++----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 7c2e6ab..ffd6edb 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -99,13 +99,16 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	 * If the IRQ is triggered on falling edge, we need to mark the
 	 * interrupt as active low, if the hardware supports this.
 	 */
-	if (irq_trig == IRQF_TRIGGER_FALLING) {
+	if (irq_trig == IRQF_TRIGGER_FALLING || irq_trig == IRQF_TRIGGER_LOW) {
 		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
 			dev_err(&indio_dev->dev,
-				"falling edge specified for IRQ but hardware "
-				"only support rising edge, will request "
-				"rising edge\n");
-			irq_trig = IRQF_TRIGGER_RISING;
+				"active low specified for IRQ but hardware "
+				"only support active high, will request "
+				"active high\n");
+			if (irq_trig == IRQF_TRIGGER_FALLING)
+				irq_trig = IRQF_TRIGGER_RISING;
+			else if (irq_trig == IRQF_TRIGGER_LOW)
+				irq_trig = IRQF_TRIGGER_HIGH;
 		} else {
 			/* Set up INT active low i.e. falling edge */
 			err = st_sensors_write_data_with_mask(indio_dev,
@@ -114,18 +117,17 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 			if (err < 0)
 				goto iio_trigger_free;
 			dev_info(&indio_dev->dev,
-				 "interrupts on the falling edge\n");
+				 "interrupts are active low\n");
 		}
-	} else if (irq_trig == IRQF_TRIGGER_RISING) {
+	} else if (irq_trig == IRQF_TRIGGER_RISING || irq_trig == IRQF_TRIGGER_HIGH) {
 		dev_info(&indio_dev->dev,
-			 "interrupts on the rising edge\n");
+			 "interrupts are active high\n");
 
 	} else {
 		dev_err(&indio_dev->dev,
-		"unsupported IRQ trigger specified (%lx), only "
-			"rising and falling edges supported, enforce "
-			"rising edge\n", irq_trig);
-		irq_trig = IRQF_TRIGGER_RISING;
+			"unsupported IRQ trigger specified (%lx) "
+			"enforce level high\n", irq_trig);
+		irq_trig = IRQF_TRIGGER_HIGH;
 	}
 
 	/*
-- 
2.5.5
