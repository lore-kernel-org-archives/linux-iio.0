Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4202E62AC;
	Sat, 22 Aug 2026 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366885; cv=none; b=WELGna+bw5uggzHFh9U703gDqHeXJCZcI3rV2F5EHCcSA+ge07nh63CulAVMuEwjN/SvYgjcjjxi3D5r84Uu6y1gSwBGD2iASfd7wxnautWb6Rk1qREkS6N5wr1ECKHlp6ZmYWlQV9ztCKku2bW+uk21RUCig2larpzUMXxyuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366885; c=relaxed/simple;
	bh=RKmepLfpMfAkp9s2Y2KdlPY5DTRFlAOO8Y0mx5ctVa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WodcvKC32593ryO7VAPJKb/INbQSG9dhkhdytmrG1e3zmeC3ih5hfkV+XZhGwk5GWwHE1NKwDP/4///KxBBSpx+ARtcDYsthEwsPUmjA49vnfZ5qPp6XXAu0R2J6kiI5egXRY+3rkPIufkPKIZVxCNOFJYDTBcz+VCu2y9xxJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3SAjbDYlqrCa0AA--.10323S3;
	Sat, 22 Aug 2026 10:47:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCnknfVDYlqTm6UBA--.11390S2;
	Sat, 22 Aug 2026 10:47:49 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] iio: light: gp2ap020a00f: use iio_trigger_poll_nested()
Date: Sat, 22 Aug 2026 02:46:54 +0000
Message-Id: <20260822024654.315309-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCnknfVDYlqTm6UBA--.11390S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?T95bEQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNN8MWHamL27R7QIcXEsGu84Lrp7F4gOSjY0eKP5lbgsfS1
	9M6nhqvhsOX51wexjmap9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxKFy7AF1fAr48Kw4rJr4kKrX_yoW7XFyUpF
	ZI9FsF9FWkXF4xWrsruF1qkFyftry7Jw4UAw4Uu3y29398Cr1Svr18Kr1Fv3Z5ZrWkZrW7
	AF9YkFZ2krs5AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9mb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
	YxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=

The threaded IRQ handler queues an irq_work only so that
iio_trigger_poll() can run from a hardirq-like context. The driver's
own buffer consumer does not need that context: the only thing the
pollfunc top half, iio_pollfunc_store_time(), does is store a timestamp
in pf->timestamp, and deferring through the per-CPU irq_work queue
moves that timestamp further away from the actual event. Whilst in
theory there can be other consumers of this trigger relying on the
pollfunc top half running, given this is a light sensor those are
considered unlikely to exist in practice.

Switch from irq_work to direct call of iio_trigger_poll_nested().
Remove now unnecessary irq_work related infrastructure and ensure a
local time stamp is acquired.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Applies on top of "iio: light: gp2ap020a00f: drain irq_work after
free_irq" in the fixes-togreg branch of iio.git; this drops the
irq_work_sync() drains that patch added.

v2:
  - commit message rework only, per maintainer review; code unchanged.
v1: https://lore.kernel.org/linux-iio/20260817024023.291319-1-fanwu01@zju.edu.cn/

---
 drivers/iio/light/gp2ap020a00f.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 330d597..00164fd 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -37,7 +37,6 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/irq_work.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -245,7 +244,6 @@ struct gp2ap020a00f_data {
 	struct iio_trigger *trig;
 	struct regmap *regmap;
 	unsigned int thresh_val[4];
-	struct irq_work work;
 	wait_queue_head_t data_ready_queue;
 };
 
@@ -802,14 +800,6 @@ static void gp2ap020a00f_output_to_lux(struct gp2ap020a00f_data *data,
 		*output_val *= 16;
 }
 
-static void gp2ap020a00f_iio_trigger_work(struct irq_work *work)
-{
-	struct gp2ap020a00f_data *data =
-		container_of(work, struct gp2ap020a00f_data, work);
-
-	iio_trigger_poll(data->trig);
-}
-
 static irqreturn_t gp2ap020a00f_prox_sensing_handler(int irq, void *data)
 {
 	struct iio_dev *indio_dev = data;
@@ -932,8 +922,7 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
 	if (test_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &priv->flags) ||
 	    test_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &priv->flags) ||
 	    test_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &priv->flags))
-		/* This fires off the trigger. */
-		irq_work_queue(&priv->work);
+		iio_trigger_poll_nested(priv->trig);
 
 done:
 	return IRQ_HANDLED;
@@ -944,9 +933,12 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	struct iio_poll_func *pf = data;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct gp2ap020a00f_data *priv = iio_priv(indio_dev);
+	s64 timestamp;
 	size_t d_size = 0;
 	int i, out_val, ret;
 
+	timestamp = iio_get_time_ns(indio_dev);
+
 	iio_for_each_active_channel(indio_dev, i) {
 		ret = regmap_bulk_read(priv->regmap, GP2AP020A00F_DATA_REG(i),
 				       &priv->buffer[d_size], 2);
@@ -964,7 +956,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer, timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -1455,8 +1447,9 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Allocate buffer */
-	err = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-		&gp2ap020a00f_trigger_handler, &gp2ap020a00f_buffer_setup_ops);
+	err = iio_triggered_buffer_setup(indio_dev, NULL,
+					 &gp2ap020a00f_trigger_handler,
+					 &gp2ap020a00f_buffer_setup_ops);
 	if (err < 0)
 		goto error_regulator_disable;
 
@@ -1480,8 +1473,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 		goto error_uninit_buffer;
 	}
 
-	init_irq_work(&data->work, gp2ap020a00f_iio_trigger_work);
-
 	err = iio_trigger_register(data->trig);
 	if (err < 0) {
 		dev_err(dev, "Failed to register iio trigger.\n");
@@ -1498,7 +1489,6 @@ error_trigger_unregister:
 	iio_trigger_unregister(data->trig);
 error_free_irq:
 	free_irq(client->irq, indio_dev);
-	irq_work_sync(&data->work);
 error_uninit_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_regulator_disable:
@@ -1521,7 +1511,6 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_trigger_unregister(data->trig);
 	free_irq(client->irq, indio_dev);
-	irq_work_sync(&data->work);
 	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(data->vled_reg);
 }

