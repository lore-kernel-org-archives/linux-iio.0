Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <1462616744-9671-2-git-send-email-linus.walleij@linaro.org>
References: <1462616744-9671-1-git-send-email-linus.walleij@linaro.org> <1462616744-9671-2-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/2 v4] iio: st_sensors: read surplus samples in trigger
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 07 May 2016 12:15:16 +0100
To: Linus Walleij <linus.walleij@linaro.org>,Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org
CC: Giuseppe Barba <giuseppe.barba@st.com>,Denis Ciocca <denis.ciocca@st.com>,Crestez Dan Leonard <cdleonard@gmail.com>
Message-ID: <17FC1367-F51B-4B0C-94C7-9984C838ECEC@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 7 May 2016 11:25:44 BST, Linus Walleij <linus.walleij@linaro.org> wrote:
>Leonard Crestez observed the following phenomenon: when using
>hard interrupt triggers (the DRDY line coming out of an ST
>sensor) sometimes a new value would arrive while reading the
>previous value, due to latencies in the system.
>
>As the interrupts from the ST sensors are a pulse, intended
>to be read by an edge-triggered interrupt line (such as a
>GPIO) one edge (transition from low-to-high or high-to-low)
>will be missed while processing the current values.
>
>If this happens, the state machine that triggers interrupts on
>the DRDY line will lock waiting for the current value to be
>read out and not fire any more interrupts. That means that
>when we exit the interrupt handler, even though new values are
>available from the sensor, no new interrupt will be triggered.
>
>To counter this, introduce a loop that polls the data ready
>registers repeatedly until no new samples are available,
>then exits the interrupt handler. This way we know no new
>values are available when the interrupt handler exits and new
>interrupts will be triggered when data arrives.
>
>Take some extra care to update the timestamp for the poll
>function if this happens. The timestamp will not be 100%
>perfect, but it will at least be closer to the actual events.
>
>Tested successfully on the LIS331DL by setting sampling
>frequency to 400Hz and stressing the system: extra reads in
>the threaded interrupt handler occurs.
>
>Cc: Giuseppe Barba <giuseppe.barba@st.com>
>Cc: Denis Ciocca <denis.ciocca@st.com>
>Cc: Crestez Dan Leonard <cdleonard@gmail.com>
>Reported-by: Crestez Dan Leonard <cdleonard@gmail.com>
>Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Shortens the race but doesn't prevent it that I can see..


In the old lis3l02dq driver in staging we ended up having to use gpio reads on
the interrupt line to clear this exact stall.

That can be done after we unmask the interrupt. Thus doesn't suffer the race.
Ugly though!

Also I think we broke the logic at somepoint  It calls trigger poll 
from threaded context.

Needs a rethink..
>---
>ChangeLog v3->v4:
>- Include this patch with the threaded interrupt fix patch.
>  Adapte the same patch numbering system.
>
>If this works I suggest it be applied to mainline as a fix on
>top of the threading patch version 3, so we handle this annoying
>lockup bug.
>---
>drivers/iio/common/st_sensors/st_sensors_trigger.c | 65
>++++++++++++++++------
> 1 file changed, 47 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c
>b/drivers/iio/common/st_sensors/st_sensors_trigger.c
>index c18e8221b6fa..68d65f60fd25 100644
>--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
>+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
>@@ -18,6 +18,42 @@
> #include "st_sensors_core.h"
> 
> /**
>+ * st_sensors_new_samples_available() - check if more samples came in
>+ * returns:
>+ * 0 - no new samples available
>+ * 1 - new samples available
>+ * negative - error
>+ */
>+static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
>+					    struct st_sensor_data *sdata)
>+{
>+	u8 status;
>+	int ret;
>+
>+	/* How would I know if I can't check it? */
>+	if (!sdata->sensor_settings->drdy_irq.addr_stat_drdy)
>+		return -EINVAL;
>+
>+	/* No scan mask, no interrupt */
>+	if (!indio_dev->active_scan_mask)
>+		return 0;
>+
>+	ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
>+			sdata->sensor_settings->drdy_irq.addr_stat_drdy,
>+			&status);
>+	if (ret < 0) {
>+		dev_err(sdata->dev,
>+			"error checking samples available\n");
>+		return ret;
>+	}
>+
>+	if (status & (u8)indio_dev->active_scan_mask[0])
>+		return 1;
>+
>+	return 0;
>+}
>+
>+/**
>  * st_sensors_irq_handler() - top half of the IRQ-based triggers
>  * @irq: irq number
>  * @p: private handler data
>@@ -43,36 +79,29 @@ irqreturn_t st_sensors_irq_thread(int irq, void *p)
> 	struct iio_trigger *trig = p;
> 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> 	struct st_sensor_data *sdata = iio_priv(indio_dev);
>-	int ret;
> 
> 	/*
> 	 * If this trigger is backed by a hardware interrupt and we have a
> 	 * status register, check if this IRQ came from us
> 	 */
>-	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
>-		u8 status;
>-
>-		ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
>-			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
>-			   &status);
>-		if (ret < 0) {
>-			dev_err(sdata->dev, "could not read channel status\n");
>-			goto out_poll;
>-		}
>-
>+	if (!st_sensors_new_samples_available(indio_dev, sdata))
> 		/*
> 		 * If this was not caused by any channels on this sensor,
> 		 * return IRQ_NONE
> 		 */
>-		if (!indio_dev->active_scan_mask)
>-			return IRQ_NONE;
>-		if (!(status & (u8)indio_dev->active_scan_mask[0]))
>-			return IRQ_NONE;
>-	}
>+		return IRQ_NONE;
> 
>-out_poll:
> 	/* It's our IRQ: proceed to handle the register polling */
> 	iio_trigger_poll_chained(p);
>+
>+	/* If new samples arrived while processing the IRQ, poll again */
>+	while (st_sensors_new_samples_available(indio_dev, sdata) > 0) {
>+		/* Timestamp and poll again */
>+		sdata->hw_timestamp = iio_get_time_ns();
>+		dev_dbg(sdata->dev, "more samples came in during polling\n");
>+		iio_trigger_poll_chained(p);
>+	}
>+
> 	return IRQ_HANDLED;
> }
> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
