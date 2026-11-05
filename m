Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863870;
	b=T4NNliAArroOmr8xug1dAeRzrkK12FcxRnVgm28qsd4Cbt5Hp1S3Nf3aPKzhIGtQEB1z
	 fy+0qS7RgfT2vfbZS7HJzEFWhC9ax/K5hBA7RIgWEGDS+wc/XqI+JXVL6oRPOz0OV76Sf
	 tsHgHs8gYvwG3NBuoZC3JGGbQ5ew/QxvHjK3drTaMFpuqA2lbOSdaw56aKmlvDi9e9wyq
	 gNHsAAMvf0WRMU4fJoKN6lkx5M2BW6X+Z+RN6kWQUcVXdAS0DRsaeSY6sttY/xZpiVfrA
	 sJZaqdiXSTBHRmYx36pZtA/T+i1a+eAnnnW2zqC+ox4PYITbLVXvcg/RFR5t7Ykobig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2KTLKxxRm/mTERWifE6NdSkq/id0fx4CDjmOeHHWEQI=;
	b=4iLrY3laPQSsOxrsqbmgYSVcbZ4tFPBkNtsgcNU21va3omRSdfyKtso1go3V0lQeX03b
	 UhJ8AR8F+eTI3xm7Z/OMJvEF0nVSgkle360RJ39DhsCtYl8eMyqNbPleCorkqfjCMfegh
	 2Sc+hV9pw5gM522CEsDyJ39R6UYsUSIz+wMCEs2GVU9+joRgPomjuYpBCRotWnsE1dwQf
	 j2jKxlT8NXjR3pYQ9fYJp1G18+THUyf1amET8jOU+7PiBLh6gfKgYuesxbqUI2kfAY3ve
	 UOXgVxvtow45pPElZUbNTeq2+I4LOdKXY4vpm9c/wNkkNTsDjqeaDkLJFERlxjIDaiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sgsatyam.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zvod0mn1;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B1606A31B
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 07:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA9B1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sgsatyam.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zvod0mn1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so1894177a12.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 23:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793863869; x=1794468669; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2KTLKxxRm/mTERWifE6NdSkq/id0fx4CDjmOeHHWEQI=;
        b=Zvod0mn1IZAlM3wRbo+lioh8nSp6PG7DU8Oy1C15e/nIWL91IVZY4G1ggBOOxOrZYO
         ROrpsb4YgSH+74/eMHI+YrFqa46PYlrPNknPwWjVkxd7pTkkUngGObPrEHzr8JeOIMT2
         v0piVBh8DrXXH94x2ZOlquMyoRW5yYJa5/QofrUlne1K/hExnfKli1862iUYBUgS5jfw
         BBXEInDrsBMDiAK0mUsjw69jf6G2aRPGOqDDdc2oMp0e6L2D5pJcLQz8Bh1J9PuhbtNk
         jlW5Zr9oycBf8x1RhEMeCFnxhswyLdH3d4M0XTgD0leKSpEuezb3YDUFgNBCi8TyrjxN
         /ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793863869; x=1794468669;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2KTLKxxRm/mTERWifE6NdSkq/id0fx4CDjmOeHHWEQI=;
        b=M/2v0+rgXVt0xs4okH2tyhprtEBRxMOI/wISQrScCucwmYgPHCDEs/lLT6jFr68hNd
         FkPA+EySTNxKUyThUj453UXJW0s5t5aKPRxlIJkgUrIu+emruuvdHRLc897F8YzYvZbY
         WJBWd1veEpQGbd5bQnHL/UcZxpdAZABWNJ3wNNwBrslYsDa7kfAxSaLjyQia7wODhB9S
         jmGVS5r8F+JR/r1PZw0phHydLs1ezm4PaXjb0BdWfiuUHmDoMIBwvzOiJ9UFRQzHwUvt
         josVzZubuNqBcOgqGzvfVvCJGLK8u+7oPrFdohrUH/lge0rvtgIgMCKn6RBcXJdpZ/pB
         Nc2A==
X-Forwarded-Encrypted: i=1; AKwUvByBSgkhV3P8JvYgIm9mS5ftu7Sbexcm7TC10jTG7gywGVO/gC1Buv2Ap1kSFc5St+ezEp2MARiuJ5M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rz7sMgn8cj6+MbHEvyIwMY8BUdEpCaUacH7YHDvNHMeEvuzQ+
	ETsT251KwQ1vhEv0V+uosiQ3x3PNT5PrGMF5Yf20/W3xGgF1iYtamcEL+VLINSEiOeD9USvk76p
	nMP9qJyY03I55ww==
X-Received: from pgdo3-n1.prod.google.com ([2002:a05:6a02:6203:10b0:cca:c02e:bfd6])
 (user=sgsatyam job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:8901:b0:3e2:99ef:ae90 with SMTP id adf61e73a8af0-3e928a0b2a1mr12244927637.53.1793863869003;
 Wed, 04 Nov 2026 23:31:09 -0800 (PST)
Date: Thu,  5 Nov 2026 07:31:07 +0000
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
Message-ID: <20261105073107.172121-1-sgsatyam@google.com>
Subject: [PATCH] iio: cros_ec: Use platform sensor_num to unregister FIFO callback
From: Satyam Gupta <sgsatyam@google.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, "=?UTF-8?q?Nuno=20S=C3=A1?=" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org, 
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

Use the platform data in the cleanup action too, so it always
unregisters the slot that cros_ec_sensors_core_register() registered.

Signed-off-by: Satyam Gupta <sgsatyam@google.com>
---
Tested on an Android desktop device (6.18, Intel) with two
accelerometers and a lid angle sensor: each sensor was unbound and
bound 20 times while a reader kept EC commands in flight, then FIFO
samples were streamed. Also tested on a ChromeOS device (6.6) with an
RGB light sensor, together with downstream changes to that driver.

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index d03e40c91582..4d019132cd78 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -216,11 +216,11 @@ static void cros_ec_sensors_core_clean(void *arg)
 	struct platform_device *pdev = (struct platform_device *)arg;
 	struct cros_ec_sensorhub *sensor_hub =
 		dev_get_drvdata(pdev->dev.parent);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-	u8 sensor_num = st->param.info.sensor_num;
+	struct cros_ec_sensor_platform *sensor_platform =
+		dev_get_platdata(&pdev->dev);
 
-	cros_ec_sensorhub_unregister_push_data(sensor_hub, sensor_num);
+	cros_ec_sensorhub_unregister_push_data(sensor_hub,
+					       sensor_platform->sensor_num);
 }
 
 /**
-- 
2.56.0.398.g882cbad275-goog

