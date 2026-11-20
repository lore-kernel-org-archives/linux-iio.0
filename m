Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174175;
	b=d2NWhul7ZmrdDQZHHQ5kvz2y9ofMWgtfNq3T5a5E1K4/XKzjzwW/IcvJw8kAewog3FiL
	 +08aSV7gYWss3NVKBlVWl/1AeptYT/1qCnAXkoj2nZsFPhFWgnZAnl1o9uLH/VD4SriZX
	 I6te66rX4ZyxA5idkmO/y0FQ4YAi1cTwAerzIV8eNt34rlhrKYiXWMPMNB8OyH0pCkq7+
	 /2Qx2vR+HzLYZXsdxKwYvxhpq7amvwsoMhLs7HQHbhAsEvUijlvUC/AjAeUkTwVIjBPg/
	 1FeYA5s9v56r8IPe7OOGhkWUJgqIx4ovOyNXM9WTQ3fDBAzof24pVYjHd6GcmwdkzQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174175;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zAaeGVyqVz3bkg6eZ61u/OG4LXpT7rtg0stES936Tjw=;
	b=HM5R2RMyD3bJgCPHD1a61Q1sHKqxcE40fUhmxBTAncNUTB85TnBXiTE0wRlMciqlqnkV
	 aUi2GETIoO8Qk5yS5wiHFNxvzZ9yO9zYydl+idlBL1V5gNezPs4TDq7H0Ep2W3BzaQH8b
	 LOdzSTSl6IlfCL4jp2u0L4pZY3j5l6MF0rhWK+BYt7E7xZvLh/UfP36Fc3mQ/sQvAuKKz
	 GZSye4cyML6+aM2GntCWQSCoL7ltntq2qj9io2Zthuwwg83oQUXOXwPTQrI5RxSw9zsFE
	 GNiKQjhWEs9aVjBD8EObDoRLtZi97JbPla1ha3FRGQwH+uOvaOU/TshLqms6IpnYaTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBqwKvDH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352160A2606;
	Fri, 20 Nov 2026 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBqwKvDH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795174175;
	b=Hfrw0J3h3GtvAPgvgOrbb38egiZoMJIxYqwbiqeuyBZ2V66QngO00C+uqMPZKjMTcz0p
	 SJs+5m6S0+44GMQtmjP7GJqDAGlNQIzzpJei9F5lMK+gnZdz9fkF3IomZumFmUbuMZ1qm
	 Lx3k46ZPzwxwQI+6JufX2D8I5qVc8bwGdx6OHxsdSx0G7A6l+XF4xTWXNUu4WIl9cYo3w
	 7Ncf///Q8C/6LxIm0D8QVBN+DZBbSwEwI/13A4cDYeLpq/pOsJGkRQP3lRekTApXy0T4b
	 RpQM9gq7aSko72EM6kVJorSfQdGp1/rJhEU1cZDGNvXi3ID6LLG60fwsaqFaiX/JSFg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795174175;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zAaeGVyqVz3bkg6eZ61u/OG4LXpT7rtg0stES936Tjw=;
	b=qrFilcybLRll4EB3tMddaE2aQtUH9gI0VziViZbOwGUL9gEfFbfaRpCBgV3zmD5awK5t
	 0f7zaEX2wZCQQBaCZKirqNNPH1NOYfatszZg8+RTnbstebKJA1zND7BPxwxtZjao8cGx2
	 tCCuZkXKJCMOVdFvvE/GAoHO/RW83aEoXFcw0vz3a+yAo20rgL0K04y2u5cTmXzoJKNOR
	 pVMzDhBze0SUvkY81K0UwNj42YBdIwfnQZEMGeOLQXrg7L2Xf3Kb8QlJD7yB+gFtmS/PQ
	 fR/y5D5hF+zTM0P6A+L6gYSn1n/fC9BLkjFLJ9tflM4y1dPSRvJqhuBPY+Cv82M5eEQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C356D1F00AD3;
	Fri, 20 Nov 2026 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174175;
	bh=zAaeGVyqVz3bkg6eZ61u/OG4LXpT7rtg0stES936Tjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mBqwKvDHEDvCmhr1NpijwUIj6E49vTV13k6ss45aHB++9ygqOJdTwTQTJSL0KeBFs
	 Me44vnX94/eQ0JCDURZUp1W9t+lZ7mpoeGJb9QxEF444Ij1/v8o8GJPOysw20wmYah
	 Zl2T4L0J4tzcViG3UoOipoWI9C4IRLIamnLV7ZVX+kcSd7kjbc6uPGKWpHJKZq0iDK
	 ZpPyqinbatkro8uemue1K/JbEDy0sS85USld9m4JlWE9seKGu0KcGtheyH4BVhO2zh
	 rgxioxlbxc+KI3vALRM13DNUXLLqWyVpaNsTd91U8NuTD8qqaRMaZ3vObChg4iCWuL
	 +ulkmX580XvoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5087F4984D;
	Fri, 20 Nov 2026 11:29:24 +0000 (UTC)
From: ILYAS NHASSE via B4 Relay <devnull+ilyas.nhasse.skf.com@kernel.org>
Date: Fri, 20 Nov 2026 12:26:48 +0100
Subject: [PATCH 2/2] iio: adc: ad_sigma_delta: support devices without RDY
 interrupt
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-ad7124-no-irq-v1-2-7826c5c3fd25@skf.com>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
In-Reply-To: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ILYAS NHASSE <ilyas.nhasse@skf.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174009; l=4847;
 i=ilyas.nhasse@skf.com; s=20261120; h=from:subject:message-id;
 bh=HkzT/yb82j6rKe0Wh5OPBoTT821E9QupBRs1skXiPo8=;
 b=1hP85xBznH4d7TuSarorWfpu5RkjyLmNxMEGy/wG2fGuVOF8OGKDMx2pJuvSvMecBgFRcDdHt
 l6yYl1GYOS3CNszA/vey0D5HX3jz7VB36TNdhCDfrkmzi2nGwN9Av7s
X-Developer-Key: i=ilyas.nhasse@skf.com; a=ed25519;
 pk=DeEyhWzUoP0HCAWFV/8oy5EFF+41tZxPpWZhfGyiMS4=
X-Endpoint-Received: by B4 Relay for ilyas.nhasse@skf.com/20261120 with
 auth_id=1581
X-Original-From: ILYAS NHASSE <ilyas.nhasse@skf.com>
Reply-To: ilyas.nhasse@skf.com
Content-Transfer-Encoding: 8bit

From: ILYAS NHASSE <ilyas.nhasse@skf.com>

The end of a conversion or of a calibration is detected with the DOUT/RDY
interrupt, so a device whose DOUT/RDY pin is only wired to the SPI MISO
line can't be used, although its status register reports the same event
in its RDY bit.

For devices with registers but without interrupt, wait for RDY in
ad_sigma_delta_single_conversion() and ad_sd_calibrate() by polling the
status register, with the same timeouts as the interrupt-driven waits.
As with the interrupt, the bus stays locked and CS asserted during the
wait, and ad_sigma_delta_clear_pending_event() has drained any older
result beforehand, so the RDY bit seen by the poll belongs to the
operation just started. A timeout is reported as -ETIMEDOUT.

The RDY interrupt is the only trigger source of the triggered buffer, so
devm_ad_sd_setup_buffer_and_trigger() sets nothing up for these devices
and they only support direct mode. Registerless devices still require
the interrupt.

Each poll is a SPI transfer, so poll every 20 ms: this delays the
detection of the end of a conversion by at most one period, a fifth of
a conversion at the AD7124 default output data rate of 10 SPS, while
keeping the bus traffic, and the CPU time of PIO SPI transfers, low.

Nothing changes for devices with an interrupt.

Signed-off-by: ILYAS NHASSE <ilyas.nhasse@skf.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 47 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 119ddc5a1..546135995 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -17,6 +17,7 @@
 #include <linux/find.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/slab.h>
@@ -43,6 +44,8 @@
 
 #define AD_SD_REG_STATUS_RDY	0x80
 
+#define AD_SD_POLL_PERIOD_US	(20 * USEC_PER_MSEC)
+
 /**
  * ad_sd_set_comm() - Set communications register
  *
@@ -347,6 +350,22 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 	return ret;
 }
 
+static int ad_sd_poll_rdy(struct ad_sigma_delta *sigma_delta,
+			  unsigned int timeout_us)
+{
+	unsigned int status;
+	int ret, ret_read;
+
+	ret = read_poll_timeout(ad_sd_read_reg, ret_read,
+				ret_read || !(status & AD_SD_REG_STATUS_RDY),
+				AD_SD_POLL_PERIOD_US, timeout_us, false,
+				sigma_delta, AD_SD_REG_STATUS, 1, &status);
+	if (ret)
+		return ret;
+
+	return ret_read;
+}
+
 int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
@@ -370,6 +389,11 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	if (ret < 0)
 		goto out;
 
+	if (!sigma_delta->irq_line) {
+		ret = ad_sd_poll_rdy(sigma_delta, 2 * USEC_PER_SEC);
+		goto out;
+	}
+
 	ad_sd_enable_irq(sigma_delta);
 	time_left = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
 	if (time_left == 0) {
@@ -447,12 +471,16 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
 
-	ad_sd_enable_irq(sigma_delta);
-	ret = wait_for_completion_interruptible_timeout(
-			&sigma_delta->completion, HZ);
+	if (sigma_delta->irq_line) {
+		ad_sd_enable_irq(sigma_delta);
+		ret = wait_for_completion_interruptible_timeout(&sigma_delta->completion,
+								HZ);
 
-	if (ret == 0)
-		ret = -EIO;
+		if (ret == 0)
+			ret = -EIO;
+	} else {
+		ret = ad_sd_poll_rdy(sigma_delta, USEC_PER_SEC);
+	}
 	if (ret < 0)
 		goto out;
 
@@ -466,7 +494,8 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 		&raw_sample);
 
 out:
-	ad_sd_disable_irq(sigma_delta);
+	if (sigma_delta->irq_line)
+		ad_sd_disable_irq(sigma_delta);
 
 out_unlock:
 	sigma_delta->keep_cs_asserted = false;
@@ -816,12 +845,18 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
  * devm_ad_sd_setup_buffer_and_trigger() - Device-managed buffer & trigger setup
  * @dev: Device object to which to bind the life-time of the resources attached
  * @indio_dev: The IIO device
+ *
+ * Nothing is set up for devices with registers but without R̅D̅Y̅ interrupt:
+ * they only support direct mode, with polled conversions.
  */
 int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	int ret;
 
+	if (!sigma_delta->irq_line && sigma_delta->info->has_registers)
+		return 0;
+
 	sigma_delta->slots = devm_kcalloc(dev, sigma_delta->num_slots,
 					  sizeof(*sigma_delta->slots), GFP_KERNEL);
 	if (!sigma_delta->slots)

-- 
2.43.0


