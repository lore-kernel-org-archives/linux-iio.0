Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50327281E;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455977; cv=none; b=ixhTrOb8bIqRxPI8qDszp3EVSGuQdoG1g5KhmxQ28ins1w/9/hgbI03Ir2ruL9fruHs8FFRhUdN3TNmWybMp74VI1HYnPzECSuSIc+QM20FlaLYpCOQbZxY7N2bk2x4xNZlmBuu6gl2+EiZ8E8zcBilXYf0Qil8stylg7CcrEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455977; c=relaxed/simple;
	bh=KIW8/dKTa1YNKlK58MwInmmKjgMUS2SczSqpAXZtH4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdnSZFH3dK2/5g60Hr5QinqUWAUznuOsT9KEl6RYe6WbyQvflYtUZt32O7fSH8VXdJ/4hmX9lEGMoO1ajJj3hZBwO+kbAeNUwGJ8K3GW7dzGVY/cEZP1rv6GDAItognqLaqUhm9l9qW9SjYgBQ6i1llyx7wTDgrlSUHEdvC4KaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnOu60tL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnOu60tL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DE5DC2BC86;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455977;
	bh=KIW8/dKTa1YNKlK58MwInmmKjgMUS2SczSqpAXZtH4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DnOu60tLBuDDNaxPi3r20WL38rLAJkPcvw15iWAKjKH+vGO/JMqa8GiLJAfRtsxeS
	 ovtBYgKA8C9yVaBJMjzlNamzZ6qjH5GsHm6DR6L4afNHGaL3NB3ViMmY4Bb2hhE/OY
	 wj2OQc5oNP1+ezEcWecjLvg58b4E+n6OrtsvVETwGIafHlUYx6vqim6+3KRGYbfib9
	 7zhZKiE2+R+LWBAkNFmBmiVh3dI5n/l3NUzk2xkzMw2a0IgYUFiRB2uI+53WkygDE4
	 lgSG3zr5LkRXOFue5x9zekA3pO8LU3C7HXOs8JTm95JZxszLNJY8H8lgFBsmdFVS6Q
	 D7jNZJZAxdwbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E92D19518;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Tue, 27 Jan 2026 01:02:20 +0530
Subject: [PATCH v7 6/6] iio: proximity: rfd77402: Add interrupt handling
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-b4-rfd77402_v5-v7-6-3e7f2d452da2@gmail.com>
References: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
In-Reply-To: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769455974; l=6529;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=PXRuCHQwhL0RvoseV0P0rP1fSG0LvtG292soIV5X2ZE=;
 b=HFphvdYoSUNInrvf9j6d4SOGmCHBKv6z0JvGECmHnUj5x1jFFfKXIAkbcVhHMv3qJWqj/hWNn
 yIToHCuJFAeCBSjJpWl+N1tF11fC0+8/qeX1WtYexXMUPKRKvBdHBmf
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Add interrupt handling support to enable event-driven data acquisition
instead of continuous polling. This improves responsiveness, reduces
CPU overhead, and supports low-power operation by allowing the system
to remain idle until an interrupt occurs.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 121 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index c29ae9af4a90..53dff934d66d 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -6,20 +6,28 @@
  *
  * 7-bit I2C slave address 0x4c
  *
- * TODO: interrupt
  * https://media.digikey.com/pdf/Data%20Sheets/RF%20Digital%20PDFs/RFD77402.pdf
  */
 
+#include <linux/bits.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 
 #define RFD77402_DRV_NAME "rfd77402"
 
 #define RFD77402_ICSR		0x00 /* Interrupt Control Status Register */
+#define RFD77402_ICSR_CLR_CFG   BIT(0)
+#define RFD77402_ICSR_CLR_TYPE  BIT(1)
 #define RFD77402_ICSR_INT_MODE	BIT(2)
 #define RFD77402_ICSR_INT_POL	BIT(3)
 #define RFD77402_ICSR_RESULT	BIT(4)
@@ -27,6 +35,12 @@
 #define RFD77402_ICSR_H2M_MSG	BIT(6)
 #define RFD77402_ICSR_RESET	BIT(7)
 
+#define RFD77402_IER		0x02
+#define RFD77402_IER_RESULT	BIT(0)
+#define RFD77402_IER_M2H_MSG	BIT(1)
+#define RFD77402_IER_H2M_MSG	BIT(2)
+#define RFD77402_IER_RESET	BIT(3)
+
 #define RFD77402_CMD_R		0x04
 #define RFD77402_CMD_SINGLE	0x01
 #define RFD77402_CMD_STANDBY	0x10
@@ -81,10 +95,14 @@ static const struct {
  * struct rfd77402_data - device-specific data for the RFD77402 sensor
  * @client: I2C client handle
  * @lock: mutex to serialize sensor reads
+ * @completion: completion used for interrupt-driven measurements
+ * @irq_en: indicates whether interrupt mode is enabled
  */
 struct rfd77402_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	struct completion completion;
+	bool irq_en;
 };
 
 static const struct iio_chan_spec rfd77402_channels[] = {
@@ -95,6 +113,41 @@ static const struct iio_chan_spec rfd77402_channels[] = {
 	},
 };
 
+static irqreturn_t rfd77402_interrupt_handler(int irq, void *pdata)
+{
+	struct rfd77402_data *data = pdata;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
+	if (ret < 0)
+		return IRQ_NONE;
+
+	/* Check if the interrupt is from our device */
+	if (!(ret & RFD77402_ICSR_RESULT))
+		return IRQ_NONE;
+
+	/* Signal completion of measurement */
+	complete(&data->completion);
+	return IRQ_HANDLED;
+}
+
+static int rfd77402_wait_for_irq(struct rfd77402_data *data)
+{
+	int ret;
+
+	/*
+	 * According to RFD77402 Datasheet v1.8,
+	 * Section 3.1.1 "Single Measure" (Figure: Single Measure Flow Chart),
+	 * the suggested timeout for single measure is 100 ms.
+	 */
+	ret = wait_for_completion_timeout(&data->completion,
+					  msecs_to_jiffies(100));
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 {
 	int ret;
@@ -120,6 +173,11 @@ static int rfd77402_wait_for_result(struct rfd77402_data *data)
 	struct i2c_client *client = data->client;
 	int val, ret;
 
+	if (data->irq_en) {
+		reinit_completion(&data->completion);
+		return rfd77402_wait_for_irq(data);
+	}
+
 	ret = read_poll_timeout(i2c_smbus_read_byte_data, val,
 				 (val < 0) || (val & RFD77402_ICSR_RESULT),
 				 10 * USEC_PER_MSEC,
@@ -200,8 +258,20 @@ static const struct iio_info rfd77402_info = {
 	.read_raw = rfd77402_read_raw,
 };
 
-static int rfd77402_init(struct i2c_client *client)
+static int rfd77402_config_irq(struct i2c_client *client, u8 csr, u8 ier)
 {
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR, csr);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_write_byte_data(client, RFD77402_IER, ier);
+}
+
+static int rfd77402_init(struct rfd77402_data *data)
+{
+	struct i2c_client *client = data->client;
 	int ret, i;
 
 	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
@@ -209,10 +279,26 @@ static int rfd77402_init(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	/* configure INT pad as push-pull, active low */
-	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
-					RFD77402_ICSR_INT_MODE);
-	if (ret < 0)
+	if (data->irq_en) {
+		/*
+		 * Enable interrupt mode:
+		 * - Configure ICSR for auto-clear on read and
+		 *   push-pull output
+		 * - Enable "result ready" interrupt in IER
+		 */
+		ret = rfd77402_config_irq(client,
+					  RFD77402_ICSR_CLR_CFG |
+					  RFD77402_ICSR_INT_MODE,
+					  RFD77402_IER_RESULT);
+	} else {
+		/*
+		 * Disable all interrupts:
+		 * - Clear ICSR configuration
+		 * - Disable all interrupts in IER
+		 */
+		ret = rfd77402_config_irq(client, 0, 0);
+	}
+	if (ret)
 		return ret;
 
 	/* I2C configuration */
@@ -292,13 +378,29 @@ static int rfd77402_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	init_completion(&data->completion);
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, rfd77402_interrupt_handler,
+						IRQF_ONESHOT,
+						"rfd77402", data);
+		if (ret)
+			return ret;
+
+		data->irq_en = true;
+		dev_dbg(&client->dev, "Using interrupt mode\n");
+	} else {
+		dev_dbg(&client->dev, "Using polling mode\n");
+	}
+
 	indio_dev->info = &rfd77402_info;
 	indio_dev->channels = rfd77402_channels;
 	indio_dev->num_channels = ARRAY_SIZE(rfd77402_channels);
 	indio_dev->name = RFD77402_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = rfd77402_init(client);
+	ret = rfd77402_init(data);
 	if (ret < 0)
 		return ret;
 
@@ -316,7 +418,10 @@ static int rfd77402_suspend(struct device *dev)
 
 static int rfd77402_resume(struct device *dev)
 {
-	return rfd77402_init(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rfd77402_data *data = iio_priv(indio_dev);
+
+	return rfd77402_init(data);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend,

-- 
2.43.0


