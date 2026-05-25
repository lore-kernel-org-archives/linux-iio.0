Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEF3E1721;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697226; cv=none; b=nEBUTVR3JvIqspVkUeD16vccfyA77P94/rCjAyRc9rbn/8+ytOdGKu98vc8UxaJPf8GOj/Wyxk8UABRlf/8maJ2vQAqkt3Qg0/IIHFZDa6GDTi1E1+mzrhmnUqH2qLbNSRgeAftXQ41RtjKgPOlwJFwWXUGHAYR6Z7JJ3HyYw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697226; c=relaxed/simple;
	bh=no98pCXwLTZEou8kepLVLZlinZiUarSGnSWfn6IYj/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R18roCCgpQ0AMH8JN3cVHtBivooAK3VCtMfSDIcCwYSSEiXDsvXpcLV9dLxokijAE+Px+jbOzQ/OQ/HbUSJgDjEiaYiUmsHYxylhEFA6rYcyCWE9kz/PxuG7FDymitog3lPJrnloqQAkaIllATYbtT/RIFFv/i+CT/ygQ7gssMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKWTxUFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKWTxUFi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17C81C2BD00;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779697226;
	bh=no98pCXwLTZEou8kepLVLZlinZiUarSGnSWfn6IYj/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bKWTxUFiiPiCuCUxvUHa/+EVJiNTMYXIxbdBmuciGo+tp7/FL8sAqn12Plf7PbRPD
	 1q6rjuCaBFdgISdeqpZKAfmcafuqgQL8P097YWZrXR1ov0tWmZo8a4TU5pXKzL4wVi
	 kr3NKRhCGknMWydSxlzYKKwh6X79KdGWjiZWAj/mHu9nNlH8Jy7o3k8c1KcUq92rwW
	 TNMAf7p3CHBQNj2AIPpX2iOcqM5gmPOqxk1hr/F+r+B1so1CNX0lAgniyg65Pela4A
	 TXWAKr1q7/v9eiEW1RoxDcN4gnCLLo8yNx3AHToLss4lEXGgnEp9IkNeI21xi48lr1
	 Lyyf9BZnk9kfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135A9CD5BD2;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 25 May 2026 10:20:21 +0200
Subject: [PATCH v4 7/8] iio: light: opt3001: switch driver to managed
 resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-opt3001-cleanup-v4-7-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779697227; l=4208;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=Ax4yn5eTBCQuhd8dscEiYEPm4u5j8WqMLN8lqGfUPW8=;
 b=ZBVjkHnu5W1oFl+Vi33mgKrEWOkwIyePP/vQB2OTkmhiWbZQPKmIaCt6tCEvmAohqvHyncV8j
 qY3DT1IJ/fHCM288nmziGz8rLC+O/iEsy7sW6T3qZZFTTDK7+kSJhgN
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Move the driver to use devm_* functions to automate resource
management and simplify error handling. This also allows removal
of the opt3001_remove() function.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 88 ++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 14a0915330672209a8de60fc4f3debdd6d6bba76..e35b5cf665e2651e8b6a576aa34fed5082f4ed19 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -705,6 +705,30 @@ static int opt3001_read_id(struct opt3001 *opt)
 	return 0;
 }
 
+static void opt3001_power_off(void *data)
+{
+	struct opt3001 *opt = data;
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
+	u16 reg_val;
+	int ret;
+
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
+		return;
+	}
+
+	reg_val = ret;
+	opt3001_set_mode(opt, &reg_val, OPT3001_CONFIGURATION_M_SHUTDOWN);
+
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg_val);
+	if (ret < 0)
+		dev_err(dev, "failed to write to register %02x\n",
+			OPT3001_CONFIGURATION);
+}
+
 static int opt3001_configure(struct opt3001 *opt)
 {
 	struct i2c_client *client = opt->client;
@@ -743,6 +767,11 @@ static int opt3001_configure(struct opt3001 *opt)
 		return dev_err_probe(dev, ret, "failed to write register %02x\n",
 				     OPT3001_CONFIGURATION);
 
+	ret = devm_add_action_or_reset(dev, opt3001_power_off, opt);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register power off function\n");
+
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to read register %02x\n",
@@ -836,7 +865,10 @@ static int opt3001_probe(struct i2c_client *client)
 	opt->client = client;
 	opt->chip_info = i2c_get_match_data(client);
 
-	mutex_init(&opt->lock);
+	ret = devm_mutex_init(dev, &opt->lock);
+	if (ret)
+		return ret;
+
 	init_waitqueue_head(&opt->result_ready_queue);
 	i2c_set_clientdata(client, iio);
 
@@ -858,59 +890,18 @@ static int opt3001_probe(struct i2c_client *client)
 
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
-		ret = request_threaded_irq(irq, NULL, opt3001_irq,
-					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					   "opt3001", iio);
+		ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"opt3001", iio);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to request IRQ #%d\n",
-					     irq);
+			return ret;
+
 		opt->use_irq = true;
 	} else {
 		dev_dbg(dev, "enabling interrupt-less operation\n");
 	}
 
-	ret = iio_device_register(iio);
-	if (ret)
-		goto free_irq;
-
-	return 0;
-
-free_irq:
-	if (irq > 0)
-		free_irq(irq, iio);
-
-	return ret;
-}
-
-static void opt3001_remove(struct i2c_client *client)
-{
-	struct iio_dev *iio = i2c_get_clientdata(client);
-	struct opt3001 *opt = iio_priv(iio);
-	struct device *dev = &client->dev;
-	int ret;
-	u16 reg;
-
-	iio_device_unregister(iio);
-
-	if (opt->use_irq)
-		free_irq(client->irq, iio);
-
-	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_CONFIGURATION);
-		return;
-	}
-
-	reg = ret;
-	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
-
-	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
-		dev_err(dev, "failed to write register %02x\n",
-			OPT3001_CONFIGURATION);
-	}
+	return devm_iio_device_register(dev, iio);
 }
 
 static const struct opt3001_chip_info opt3001_chip_information = {
@@ -951,7 +942,6 @@ MODULE_DEVICE_TABLE(of, opt3001_of_match);
 
 static struct i2c_driver opt3001_driver = {
 	.probe = opt3001_probe,
-	.remove = opt3001_remove,
 	.id_table = opt3001_id,
 
 	.driver = {

-- 
2.47.3


