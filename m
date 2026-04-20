Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570427F01E
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683355; cv=none; b=kQJLYSGDRhuu8JRCgt8aAV3gFJAfVITwvHP8kbOY288qofm7wfc7+lnGFcBzv2fRuv1ESj760aQbWP4Dgn8XIKis0haDOppA2jzREhhqRB4UuAM5wlkRAvaPR4e+SQbuk66g7pBxTH8IJ7J0/BhTC9oRTKlm0FWr9b763dHQvr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683355; c=relaxed/simple;
	bh=Gj9u0n6M04mVAFyvRZaeIEMfKTHjfAR9dbZpYgpDyfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh6LJIalEAewcBqiVwzjN3+/kuOFSIzq0VuVo+7ek5tohgDPyeEB4PDbP7HfyPVdR/CuG9D3cSFaurFwqll3nBdJlfS1jpDqPEPeL/pwTw4zXLSUE69OLhsgzq0pHLcFvR8psG3W4kufZT9SlcmCPOrQQHF/oBzPXHQ7/KojUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moGZ1TqC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moGZ1TqC"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6714fa8b955so5280200a12.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776683348; x=1777288148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N2bcOzuNhie0n79Zbzqw5jabBLf8p/cWOSMWKiL5F8=;
        b=moGZ1TqCEcKYiLqBpWdbvSvBqn/Wmw1i6vxdYa8fT42T2BgDg0zk7B0sdFa6Q5I1q2
         cs0fzhuLtMHgDg9DO/HPuGnamlO9sxRpi9bx/I9+vBVrhSeRRR2DQm943nl6ndfu2/2z
         L6jAot06avgMoXHtX9geawuWLOTNyfOzi4p6Re92JH6iVZYF4UcwlZJe4KGJNkyy2rBc
         lJXT5OQsj0gJKODa9ZKfyHJj8XkTzf/g7KCHtuZ6faRjZJG2C16vzgoJxyvo18S1TpPC
         mw5l/LX+7715g6cSEChYrucB4i+tgsb7z1245HbL5X80ZO4LEOZb0A0xjG89t4rrzG9F
         3vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683348; x=1777288148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6N2bcOzuNhie0n79Zbzqw5jabBLf8p/cWOSMWKiL5F8=;
        b=McdKiFUCxzoazL1kr5J3V2kpf7sHcNVnvl0tYoAKMIupNfya2nGXRseY3u5YyqLob1
         0c19Vh/zJ7k1gH84RA5OkTjVuUrm3V8tbq+M+Khp5E89fzBysrTSy+pZQHMIBm9jUomv
         vUKy47AhB4+/KCWXst5oKnK+Hv7M+n1A9U7Vh/cM8mXBXGyBvQE28x8kTCZgla7vTonM
         NKzskB/4qn3IRD6W4Df5rRNZVU2DQ3jQXmdcaEuQbrRwN7jXafX71st8Aw1UGaWmKGKZ
         HISCUgB47/+WQriqi4lMT1mubErv80duv8XMhwPAq7oixMBvT9N5H9gbsuZAQvI5v/fk
         CMHw==
X-Forwarded-Encrypted: i=1; AFNElJ+6xN1p1Gv+PXGYVZcuHlngvLkHSQPAQERC6liCtYUT8G8mJcoXwXwyjfU0hISp0+QTIeHD6NeTdP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7MfXTVY1mbgtQr7dMs4A1tuX5u4Hy1LPK4nE2YO/AwWzBNk+
	Mpk6VE2N+E7kISPwaGhly9izkANrDRJSVt+G7rrXeVAxc33+s9Nx5eLU
X-Gm-Gg: AeBDievGZ8Sg1hdK00s20TyMQd+5HxrVvE/tYCv81fzr7ly8/O6T65jU4Ptxcn1nnXd
	NfkC2+mYI+OtaxesA2p8ldg+3qplyFeVvQFA5Z3TxOY5A/JE17BaXVSIcii1nI3NeQgx0UE/mpN
	9fus7oOd9YrTL5FEATiV2KvHm/dFU7R0c2mFeoUBOZ5ENVBWtrkOHx8xHBqL6Lb7P/eSxN3pCNC
	qV85qKovTXN7rVYa8PuCfpwn0zrlaz1WC3tB1Wsdwzn9CqmYQpOClJffaApy/zxD14lRtDwpTBJ
	gWfMrd3KA2YSZKful86Js4hst4gUerJwXXBLycbVIKT2+zhtjc+Vf9OpOBZJlJlbrxyJLQ2fR7g
	owZtpH1QUT8dgBTYuz6WdBRexD3wCnjVzlAHJLaP1L+fU6Ea+uKYE4+zNY2HZtCSdaGduofmuOa
	qGKemmSGA20k3cQBnZI6LwzzUpoAn8FlBf3qYWFWcCKKA8M+nX1SVtA0qwqqXPFEy0XmwwGEhHo
	EbzR53W3cQQJ/lbqd3pEOPB4TsqnVGPPxPXYV6/3maJWYEeeiXtgzARYq18HYLjDjlFcyTEW4rM
	/Y5XLAnjXlZAqg+hdl4tpbgiFoQ1OHanO4dPitRBndJtRApvvj1nJfJAQTAZiD/1D5S34I+Knzd
	8rz4wMrXgLuenYJsO+pYTVGpBCwDA//8aPaAzSNgM2mcZE5zoKwnquR/pv7iOEx0wXSy0XtMz4a
	z3QgehB+a5ufxgvALArg==
X-Received: by 2002:a05:6402:2b98:b0:672:a20b:3781 with SMTP id 4fb4d7f45d1cf-672bfc12952mr5457229a12.0.1776683347651;
        Mon, 20 Apr 2026 04:09:07 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (254.196.90.34.bc.googleusercontent.com. [34.90.196.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe8a0sm1947664a12.5.2026.04.20.04.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:09:06 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 4/4] iio: magnetometer: ak8975: modernize polling loops with iopoll() macros
Date: Mon, 20 Apr 2026 11:08:04 +0000
Message-ID: <20260420110804.1353-5-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420110804.1353-1-joshua.crofts1@gmail.com>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently uses while loops and msleep() for polling during
conversion waits.

Replace the custom polling loops with readx_poll_timeout() and
read_poll_timeout() macros from <linux/iopoll.h>. This reduces
boilerplate, standardizes timeout handling and improves overall code
readability, keeping the original timing and error behaviour.

Assisted-by: Gemini:3.1-Pro
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 44 ++++++++++++++-----------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index c57ff6d99f3..86b4149e77b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irqreturn.h>
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
@@ -651,17 +652,15 @@ static int ak8975_setup(struct i2c_client *client)
 static int wait_conversion_complete_gpio(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
 	int ret;
+	int val;
 
 	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
-		if (gpiod_get_value(data->eoc_gpiod))
-			break;
-		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
-	}
-	if (!timeout_ms) {
+	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
+							 AK8975_CONVERSION_DONE_POLL_TIME * 1000,
+							 AK8975_MAX_CONVERSION_TIMEOUT * 1000);
+
+	if (ret) {
 		dev_err(&client->dev, "Conversion timeout happened\n");
 		return -EINVAL;
 	}
@@ -676,30 +675,27 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 static int wait_conversion_complete_polled(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	u8 read_status;
-	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
 	int ret;
+	int val;
 
 	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST1]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST1\n");
-			return ret;
-		}
-		read_status = ret;
-		if (read_status)
-			break;
-		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
+	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
+							AK8975_CONVERSION_DONE_POLL_TIME * 1000,
+							AK8975_MAX_CONVERSION_TIMEOUT * 1000,
+							true,
+							client, data->def->ctrl_regs[ST1]);
+
+	if (val < 0) {
+		dev_err(&client->dev, "Error in reading ST1\n");
+		return val;
 	}
-	if (!timeout_ms) {
+
+	if (ret == -ETIMEDOUT) {
 		dev_err(&client->dev, "Conversion timeout happened\n");
 		return -EINVAL;
 	}
 
-	return read_status;
+	return val;
 }
 
 /* Returns 0 if the end of conversion interrupt occurred or -ETIME otherwise */
-- 
2.47.3

