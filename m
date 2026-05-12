Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603138E8C2;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=OTGsyUFtTPsp6NJuE8272SRkk7DzpixKxfpnkVNNDmtqeey0iNerRoQfOzVLK4coVdolkdykHU0WK2zxhvClTx8JyV3S4EgmPn755T1lLHqndaot11IdaDyQjmLRXzIJuk/2xG8a0ahp4CwfN+rc7sdCW5B+bzKN4aI4/l2j9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=gmfY3KaBUVgnolCkvIMhJ+1i5NvZCAapVQ2SS78eIds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLgZHU24Gqx8iGt378EMlE5+pDqCCvq1gKiZVyNFe0qtsD99LtRnKK6VA8KZ6SM91iPnK5t92NH99OOJIpZg1qFtB4PuFB78bUu7B17s5Ocyq9qKHCue+XGa6O4QO/UBjBRttZfEAWCDt4I9rqiaNAIjJrNDaT3rOLZTa9K75Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njMR6zOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njMR6zOv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82169C2BCFB;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583473;
	bh=gmfY3KaBUVgnolCkvIMhJ+1i5NvZCAapVQ2SS78eIds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=njMR6zOvgLW15zHJi0naXf1R0vv8jrKkNaRlYGe9RLTxx5omSkmymdf4oJyLrIi3f
	 emXY+n++jb5t1pFPDsNHZGDKh1ZHy5bFbrKhbXnMmtzAkD0ixsxdCYCkmsUv26NRa0
	 2U6iex5g7YmvTM/WrTb2hDfW+D3cN8q7yaMgbY5b0QKwCU57v4bXl+KqLbN8Fx65vB
	 zhfi01/WPh6V9X2/ZgiaFjpp7KA/afJ3zIKUjaKYkOFdnsZh1r8IHnSHeLp6svMWs0
	 XvO5nV9anlo1Wyn6DW6H1FApNaEOQ5K6cSNmMb+Ek3Hq9mzqlzVSUHuSR3wCvLPafL
	 XygzwnBGjCprQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E7CD4855;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 12 May 2026 12:57:29 +0200
Subject: [PATCH v2 09/10] iio: light: opt3001: switch driver to managed
 resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-opt3001-cleanup-v2-9-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=4086;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=4ANghW89O8ZSpqGz7kIpA1BQnkewSIVLpoxIZNOp8yY=;
 b=4HRc9GwvUYI7ODsQzNSL6+ce3CLIubOU7ws0Unyhwph3i9wfBEtMzWu3iDqWhXFVEPYpcLPPf
 YxJGsJ1ytAzBesZZ3b26QLwuJM6hEK4+ZKbFnYgUZoiEyLckLP4umon
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
 drivers/iio/light/opt3001.c | 75 +++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 39ea60c0af2c1ec7473d49b73778cac1f9bb6086..1319e5941b66bd82e4dc2badf5ea27cacbcfd54a 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -702,6 +702,31 @@ static int opt3001_read_id(struct opt3001 *opt)
 	return 0;
 }
 
+static void opt3001_power_off(void *data)
+{
+	struct opt3001 *opt = data;
+	struct i2c_client *client = opt->client;
+	struct device *dev = opt->dev;
+
+	int ret;
+	u16 reg;
+
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
+		return;
+	}
+
+	reg = ret;
+	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
+
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
+	if (ret < 0)
+		dev_err(dev, "failed to write to register %02x\n",
+			OPT3001_CONFIGURATION);
+}
+
 static int opt3001_configure(struct opt3001 *opt)
 {
 	struct i2c_client *client = opt->client;
@@ -740,6 +765,11 @@ static int opt3001_configure(struct opt3001 *opt)
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
@@ -834,7 +864,10 @@ static int opt3001_probe(struct i2c_client *client)
 	opt->dev = dev;
 	opt->chip_info = i2c_get_match_data(client);
 
-	mutex_init(&opt->lock);
+	ret = devm_mutex_init(dev, &opt->lock);
+	if (ret)
+		return ret;
+
 	init_waitqueue_head(&opt->result_ready_queue);
 	i2c_set_clientdata(client, iio);
 
@@ -856,13 +889,12 @@ static int opt3001_probe(struct i2c_client *client)
 
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
@@ -876,34 +908,6 @@ static int opt3001_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void opt3001_remove(struct i2c_client *client)
-{
-	struct iio_dev *iio = i2c_get_clientdata(client);
-	struct opt3001 *opt = iio_priv(iio);
-	struct device *dev = opt->dev;
-	int ret;
-	u16 reg;
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
-}
-
 static const struct opt3001_chip_info opt3001_chip_information = {
 	.channels = &opt3001_channels,
 	.chan_type = IIO_LIGHT,
@@ -942,7 +946,6 @@ MODULE_DEVICE_TABLE(of, opt3001_of_match);
 
 static struct i2c_driver opt3001_driver = {
 	.probe = opt3001_probe,
-	.remove = opt3001_remove,
 	.id_table = opt3001_id,
 
 	.driver = {

-- 
2.47.3


