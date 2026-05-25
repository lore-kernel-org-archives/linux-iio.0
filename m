Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8C3E1722;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697226; cv=none; b=YrMXZ3c8TDwlRrROb2wsPpDlhAkVTf0pVxvZQON5GVFxFU25CeVEbvbnkF5jbYHLwFFl6YKPOHpEL3Mg9y9jgvUZm1F5T1XQaqZZcruQb5LMh4TgloyleuVaMZru2yGEaSk5bHgY0vDpDMKCz1uEgVCbdXl1NAVMJBirce5vlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697226; c=relaxed/simple;
	bh=xZ4U/N4xzF8KI+baT52FFw2A83cWXDtHkqOe3pBdEIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBmKk1rPiwRoHNPU7BOI/bU9GqLr5Z4z1wyAXTsXiG+8BXBLB/C7loOzrmeUJe2TIMcZVC6kjV6l0MQANBw7anTXR0nKRjPotjO+d9j9TCVv1cmQTSY151/tX1DmTen06z3HElb8BnaHzSys+KTzmNXdQFeAo6yovUsuDT4dQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6JgV/n2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6JgV/n2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02659C2BCF4;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779697226;
	bh=xZ4U/N4xzF8KI+baT52FFw2A83cWXDtHkqOe3pBdEIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j6JgV/n2cmpUxZzHS6IF0+SwpPoUQ3Rq8I16ngrDTDBlNJ5ZsXMJIUGuaY+fx7/Eh
	 LAXXELlOYWrvuewbXZn2OTuH+NF3Dypb5D9SiuqvKsBKCQMtZAgrKgwq2U0RHAlZ5U
	 sUA7A9qODJJrpP2IqWbKdonELWHe7+zDR3367QFKq4U2cS6ADQ9UQxlVDe0Zq0e+Hv
	 eHXrBcTb+3FU6pjWxu8ZrUap8hlWbOZ7GeKR0dwrtDqGvDPwT7F8eJOO3VUzhGRlK1
	 RCGxocXAvbvT7YTCYpw4z9xCbFAsteYbZfjwLL5xTVmOzFoYslgOKOHWn1ry3Bx+/H
	 ACrmK11lSOwFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE254CD5BD1;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 25 May 2026 10:20:19 +0200
Subject: [PATCH v4 5/8] iio: light: opt3001: prefer dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-opt3001-cleanup-v4-5-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779697227; l=3534;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=JChmuY3Cry41DbF2evnRYkUtRADLx3EHBeJilNjXnDo=;
 b=2OA1LqlsRAGwtQYdT5Sa5D2gFOfdnOxFtQlprrms80K7eq46HIbtAbkunq59BCEkhizVY93U6
 gGte1466a/pAwx/HZ9xaIgbvZ7ptivPyG/kZUmEEhGG7qSC/1BDntF6
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Switch driver to use dev_err_probe() to unify error messages generated
in *_probe() and probe path functions.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 56 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 777a54753b0c84dbee40980101019450fcd06af1..fa799edd6a9ce7373400bb654ea4a1b9f17212a3 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -706,21 +706,17 @@ static int opt3001_read_id(struct opt3001 *opt)
 	int ret;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_MANUFACTURER_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_MANUFACTURER_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_MANUFACTURER_ID);
 
 	manufacturer[0] = ret >> 8;
 	manufacturer[1] = ret & 0xff;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_DEVICE_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_DEVICE_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_DEVICE_ID);
 
 	device_id = ret;
 
@@ -738,11 +734,9 @@ static int opt3001_configure(struct opt3001 *opt)
 	u16 reg;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	reg = ret;
 
@@ -766,28 +760,22 @@ static int opt3001_configure(struct opt3001 *opt)
 	reg &= ~OPT3001_CONFIGURATION_FC_MASK;
 
 	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
-		dev_err(dev, "failed to write register %02x\n",
-			OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to write register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_LOW_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_LOW_LIMIT);
 
 	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_HIGH_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_HIGH_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_HIGH_LIMIT);
 
 	opt->high_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->high_thresh_exp = OPT3001_REG_EXPONENT(ret);
@@ -894,10 +882,10 @@ static int opt3001_probe(struct i2c_client *client)
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
 					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   "opt3001", iio);
-		if (ret) {
-			dev_err(dev, "failed to request IRQ #%d\n", irq);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to request IRQ #%d\n",
+					     irq);
 		opt->use_irq = true;
 	} else {
 		dev_dbg(dev, "enabling interrupt-less operation\n");

-- 
2.47.3


