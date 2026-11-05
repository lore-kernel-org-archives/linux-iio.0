Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884861;
	b=4FY2hEPSw/Dx0XjJTuK+Otl1c/dwA2Y9jwOc7Ypsom8bMMLNfgSbAeKlBHRSOC7njM8I
	 hAJEmrv/hE/6LrYXB30UzhK6VKfwK4EHEyk4wbxvCA819pVmDAAq5d7zwMqrpRJso1QRs
	 A5KEMWTClhhYRae5DoQbCjLEsNDZGrllyK/ONzBIspqoeABb3Jg0iYrs7eUFAKWxdj6pY
	 AZ/QpBXMGVbx0sos2+z/Ojj0ldcrLYMLTxJ7l1wyR6qK/fQGtioXaYs6DRmxHJnXOaaWg
	 ExdYZRvImNFWzesUazZMmSBofPAx16WA/O0kkkT/g1VXSx5GdOYEOeQ9RshkEW+KC/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=1hWitpRXSGa3f1x2WsNsj66oTlqZG1AdJZX2odfdwlE=;
	b=k4kdV9jdTlQ8z3QaP5c2bNo6EQmfYwl9u2mjii6Thls9WrCbyb4DYr1i1NjoKRzOUnIU
	 4C2Ch6n2B17AR+gztKcPtlbgojqcNxzsDS8k6lJiVBWZ/evnGiv8BdATfXr97LiWkyG7q
	 DrlP0KFkeZZZtrmq7ffJKD/5AhG3A0nVdPXf/VlzSe2KA76WFKtk7Kh8C2zR4+nv/mCVa
	 VBTWTRUeRPU4iOWWuWzbJLFh83yl+gtdv/fzGAZkpbotiwx03vhaZOGtvctzqm07dHiaP
	 YG6rHfr4+pPmDayimBSuAgeule2ocZwATqh2FFhmRGAYTtaV/PTqbIu2IDOm0vdWymw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sgsatyam.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="b/D3EHPA";
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800A606A331
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 13:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2800A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sgsatyam.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b/D3EHPA
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8aa185840bdso1649215b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793884859; x=1794489659; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1hWitpRXSGa3f1x2WsNsj66oTlqZG1AdJZX2odfdwlE=;
        b=b/D3EHPAAjWjhusoL98yh5jWlwzCV43CXQwazJ5Pa52pgCXMWNzAAkNx/5miqaRUZq
         76mDiTCXPQm+aYELtiVYGDyP65PIftPnb4Z1i785N5GK04Txu9/bsgfMakj+eJL+I4fw
         C84K+zt/C9drRRKqgjq/y7paN31Y8DpMCU3LN0NZd8Y8vCMFYAL1cs+F3M58+ZhXqy5M
         uESRtcQAAMoo1exUSa3etS7o8HzuHx3av2vQWK6op4zvYJV7l65tG6zuoQYYQdCIvTw6
         UKYQtCEtJd0LTgZ32N7YBlgvcEi0Dg3GN0EcFafSizj7XKqu67NmWcW5hFtVp4+yQzxA
         Wq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884859; x=1794489659;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hWitpRXSGa3f1x2WsNsj66oTlqZG1AdJZX2odfdwlE=;
        b=i73bHP1kdSVO3n2P0MO0iahthnEzO7A8qEUZ+Ryl5QwM0lQKrhBGsZA6IlcM2sLf3P
         DAgFtnidInTCYWHP2E3jGOTr+wq06vz2VBqL21PWqKt3tpiisle5bsrr5SVGhg5MY8Nb
         tDgqpvwIkzFtqIOx0tY/01LWITmJnB+5V+l9X75E4TOjFz7cubrxDUVt25pn6DBSVUxe
         go3MVZ1wkFaK00fhpVgTbB9jfa1tO6CulOc7HmYX46qVDpXoiXPena+3TVBXRdX4Zwce
         u5cCWLEUYYCW/7uaz/3/I79DY516IJQ+7YvYTg43VBxn2p+ugv8Tl3CLmy76UMdwz4pf
         HC/g==
X-Forwarded-Encrypted: i=1; AKwUvBw2mjzp6GT/feUwg9I7vMs8uxGudV0hgdFmN1joZxeJr0R0pvPjMs2gU627D0hZzkQ9bFJQrF0/Gzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nRFOoca0/iwpHCHEQlI6bi90M9hvtpRcbVUNPmmepbwaUQsJp
	KBxATR7u/qIOMCnoYu8uUgxsgxIPb1Ht3E44jsxWMO2iOrk8GolgEdaAEy5vuz03VuV6CKW8NcT
	yk1t9SErUtfVsYw==
X-Received: from pgme25-n2.prod.google.com ([2002:a05:6a02:6c99:20b0:cd8:c5f8:e73d])
 (user=sgsatyam job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:68cb:20b0:3eb:818f:619a with SMTP id adf61e73a8af0-3eb818f7477mr3915541637.33.1793884859215;
 Thu, 05 Nov 2026 05:20:59 -0800 (PST)
Date: Thu,  5 Nov 2026 13:20:57 +0000
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261105132057.2429385-1-sgsatyam@google.com>
Subject: [PATCH v2] iio: cros_ec: Use platform sensor_num to unregister FIFO callback
From: Satyam Gupta <sgsatyam@google.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, "=?UTF-8?q?Nuno=20S=C3=A1?=" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Enric Balletbo i Serra <eballetbo@kernel.org>, linux-iio@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

cros_ec_sensors_core_register() registers the FIFO callback for the
sensor number found in the platform data. The matching cleanup action,
cros_ec_sensors_core_clean(), reads the number back from
st->param.info.sensor_num instead.

st->param is the EC host command buffer. Drivers fill it in under
cmd_lock before each command, while the cleanup action reads it without
that lock. It is also set only for physical sensors. If the field holds
another value when the device is unbound, the cleanup clears the wrong
slot and leaves the callback in place, still pointing to the iio_dev
that is about to be freed.

No in-tree driver changes the field after probe, so mainline is not
known to hit this. The ChromeOS RGB light sensor support does: it
changes the field while a command is in flight, and unbinding the
device then leaves a stale callback. Found by an AI code review agent.

Use the platform data in the cleanup action too, so it always
unregisters the slot that cros_ec_sensors_core_register() registered.

Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
Signed-off-by: Satyam Gupta <sgsatyam@google.com>
---
Changes in v2:
- Add a Fixes tag (Andy).
- Use a local struct device pointer and name the platform data pdata,
  so the unregister call fits on one line (Andy).
- Say what triggers the problem and how it was found.

v1: https://lore.kernel.org/r/20261105073107.172121-1-sgsatyam@google.com

The patch was drafted with an LLM-based coding assistant (Gemini); I
reviewed and tested it.

Tested on downstream kernels, together with fixes to the out-of-tree
RGB light sensor support: ChromeOS 6.6 (Intel) and Android desktop 6.12
(MediaTek) and 6.18 (Intel). Unbinding and binding the light sensor
while its RGB channel is read in a loop failed within 1 to 46 cycles
without the fixes (the stale callback slot makes the next probe fail
with -EINVAL) and passed 200 cycles with them on all three. On the 6.12
device the accelerometer and gyroscope were also unbound and bound
repeatedly and still streamed FIFO samples. Mainline itself was only
build-tested (W=1 and sparse, x86_64 and arm64).

 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c  | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index d03e40c91582..632036eea4f3 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -214,13 +214,11 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
 static void cros_ec_sensors_core_clean(void *arg)
 {
 	struct platform_device *pdev = (struct platform_device *)arg;
-	struct cros_ec_sensorhub *sensor_hub =
-		dev_get_drvdata(pdev->dev.parent);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-	u8 sensor_num = st->param.info.sensor_num;
+	struct device *dev = &pdev->dev;
+	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
+	struct cros_ec_sensor_platform *pdata = dev_get_platdata(dev);
 
-	cros_ec_sensorhub_unregister_push_data(sensor_hub, sensor_num);
+	cros_ec_sensorhub_unregister_push_data(sensor_hub, pdata->sensor_num);
 }
 
 /**

base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
-- 
2.56.0.398.g882cbad275-goog

