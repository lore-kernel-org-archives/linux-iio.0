Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469002E1EE0;
	Mon, 17 Aug 2026 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934521; cv=none; b=eACeLknOu0uY0wgpc35wYSnUmOEuswa0ryn5dIClUKbTCi3HJTLd4gNgrYr00SSgXbDsedOEr/YF6gVLY4it90ebSKVqCb+U6RDmFGMy1GKXZI38mxHnvAGb59Z9bejxAEZCEh3Mhxeh9RaZsu42KJ3/9BAIdEIz/meHM8WnBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934521; c=relaxed/simple;
	bh=NsVSWwafyeGkC6z1Py9hqBOCWImzAHYbcct5HChTYN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLDxxEFEwWRJJGT2q66WwYAfHGYs0siM3CKrL1M8DrmU/2t8+Mcv1AdKGSoupxGBqm1BGIXGfuHS5d9FXyoua/Qgy9lrLQZzPn+38pIgRmRP3ISzKTHsTpDO9JnCusI/JLuSTqUGF/tehT+OL26IOZW8j1CRUqAXZeS0nozk+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDnhDXQdIJq3T+cAA--.13870S3;
	Mon, 17 Aug 2026 10:41:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgDXlJzPdIJqfIzvAw--.15700S2;
	Mon, 17 Aug 2026 10:41:19 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] iio: light: gp2ap020a00f: use iio_trigger_poll_nested()
Date: Mon, 17 Aug 2026 02:40:23 +0000
Message-Id: <20260817024023.291319-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260816184602.2dd023f6@jic23-huawei>
References: <20260816184602.2dd023f6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgDXlJzPdIJqfIzvAw--.15700S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?JL6e+QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBFMKUG5D5ag5alJmk3PD4oKXbNCiIpCTu38kW10lm0zF9pX
	GShcbNzZIlUscyTzEo2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxKFy5Jw4UAFy5try3tw43Arc_yoW7Xr1Dpa
	9I9FsF9FWkJF4xWr47uF1qkFyftry7Jw4UAr4Uu3ya93s8Cr1Svr1rtr1Fq3Z5ZrW8Zry7
	AFZYkFs2krs5ZFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

The threaded IRQ handler queues an irq_work only so that
iio_trigger_poll() can run from a hardirq-like context.  The driver's
own buffer consumer does not need that context: the only thing a
standard IIO pollfunc top half does is store a timestamp in
pf->timestamp, and deferring through the per-CPU irq_work queue moves
that timestamp further away from the actual event.

The device IRQ handler is already threaded, so call
iio_trigger_poll_nested() directly from
gp2ap020a00f_thresh_event_handler() and drop the irq_work, its
callback, its init and the irq_work_sync() drains added by the
preceding use-after-free fix.

As the trigger is now dispatched via handle_nested_irq(), a consumer's
top half no longer runs and its threaded handler executes
synchronously in this device's IRQ thread.  For consumers still using
iio_pollfunc_store_time() this means pf->timestamp is no longer
populated; a consumer that needs a timestamp should take it locally,
as this driver now does in gp2ap020a00f_trigger_handler().

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
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

