Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949548;
	b=E+bsUNEBYHK6gZNdD9p/YTMf0Y1/6bQc5NQ0EDeUviy8jsbqX/mW3ufWB5Dqy7Pv9cJS
	 mLJ9QokA17M8QbizMWXnZwuPPOn8qEwNv2gLCO4Jyys0ixCCm9H+ejDxFzuIRkN64gyxc
	 30TgVjDsJXozlwdwPtfIjJrG05X0XMDL6sHztog/SfV2hXPlEP9N16EKXpJHNbghErswd
	 win8OjEGJDHQ2ppvUpMSq3CKKhgJ3+5mT5rKVzwlCD9t0Jja8Q+bhaMWME62qj4JvCYiR
	 6QwgPnQZzhkFDd75p0VTszOGz49sEbupdxVliuW17203nUv2b/Cny2n+jnCx/rHrXmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pIjZ/Y8hQqw73CpdFq92aAVG0/oq5u/tSDIP7hM67k8=;
	b=imaMket19BzjpFfO/NBfvkpJhNYxdftYHh/pPOPywku9yLetSi70hPbkyOimseY9mjlQ
	 5JdUeit0PCYWNy4b00GZGH8qVUMQmcEkhFmvMV5c9cSi+6XYIVy0H0eSsp7+GBDJKjQuV
	 eOW9YmKuGzlFRIDCt6JooO9xPK8OIC13oO56xdjdfjdxzeFpmcFHcCVrvHA6XYDtU0dZD
	 uD+tXUNItoE3FNCAkPoLYxKZY3pDA4Vis9LdOxbQ7b+JPbuKSOm5YF5ARg21CXty8YulF
	 cqeMqTZB0Qxx7Gjf3RbEz2Xisv5Y834YYMpB/ca9Wdm4AiG1cJyl6FIN1CYaJqy3ZwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sgsatyam.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wgbpr5am;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D8606A329
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 07:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 417D8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sgsatyam.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wgbpr5am
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a05b68f851so1476129b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 23:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793949546; x=1794554346; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIjZ/Y8hQqw73CpdFq92aAVG0/oq5u/tSDIP7hM67k8=;
        b=Wgbpr5amGdq3oBCrEMDJW4Jq82wMjH3VyiVfYL8kqtY5T5dUyegu7PtB1lsVcb/dRa
         ymojuAcJhpJKJa1kyGb0G6QBR1l2mWwChJT7FXfIhxjqSe1piLdZByDaWkGF1mHjbxe4
         p1WcihaapscRM6zytQHN73izR2PCoOrUPrNgN1KiG2nbS5PoshDKIL8x2Ro94ZMFyOj6
         7mSo8jy7R2g1I1J9W0eYUxmH4AkrHUkA9+Avl7BywGOTonqL/kTuJ8ViOmNJd0RS3BLJ
         ds/T4OrBX1Q2fE3qEenxs89NJycvINnOkLLYGJaoELkxaCnAmOUTExOaZtCqlzuqQVqD
         L1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793949546; x=1794554346;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIjZ/Y8hQqw73CpdFq92aAVG0/oq5u/tSDIP7hM67k8=;
        b=w4ri9yOyLRoPYM40VGdrYOzBjstnaB+yNj06o5ebDYDOm1oXPj1pk1ykLfY5Cv8DFB
         Cc8i1+UzkJDcXyhJqvBa5iJZ96msfzETDmh5qSIdYDjoG8GAtHjQv/tGC+BU0YOqwliT
         +ZtcwIbmNzIGRHXFccwL+Jys/Loo4fhk6XxgAonV+8/YdopARdKSfVSDcqZLq4AiD9FZ
         f6gf3vkQ+P6CbuuuOSqDnmRhckUU+tF+jOD5x1bFOOtL1p9Sa8zidreASHy095oc+bJO
         IKRgKoWjoqDPlie7lH3Av2tmr4V4AtAtuI9BNx23OWWEFwAOm++ErUkwAayF1dk9p0vu
         kxFg==
X-Forwarded-Encrypted: i=1; AKwUvBy8NMYwouQDOCpV9+DzTsZyG8Ez37cJSpFWS30h8he++nV7uCf7LulmKwky2D/ZlB31oolWlj7SEu4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sLW1qyQBvW7gUMWvSxE2IVuwqpw5MHX9Dptuq+CGglkSSfZnD
	DPSqzomfqSH8vhvUGk0bIPZhDRcjxyHX6wZVPb3ROI7bjWrsllqWoEZfbOX2oNX7iSTDkr8s6lq
	gePJh/i0v4x+9dw==
X-Received: from pfem17.prod.google.com ([2002:a05:6a00:c091:b0:89b:34dc:b094])
 (user=sgsatyam job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:188e:b0:89f:2b65:2ad with SMTP id d2e1a72fcca58-8b1e5967803mr3971036b3a.27.1793949546203;
 Thu, 05 Nov 2026 23:19:06 -0800 (PST)
Date: Fri,  6 Nov 2026 07:19:04 +0000
In-Reply-To: <au1FF5K9EALuqnNR@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <au1FF5K9EALuqnNR@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106071904.142937-1-sgsatyam@google.com>
Subject: [PATCH v3] iio: cros_ec: Use platform sensor_num to unregister FIFO callback
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

Use the platform data in the cleanup action too, and pass the struct
device pointer directly to devm_add_action_or_reset(), so it always
unregisters the slot that cros_ec_sensors_core_register() registered.

Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
Signed-off-by: Satyam Gupta <sgsatyam@google.com>
---
Changes in v3:
- Pass dev instead of pdev to devm_add_action_or_reset() and drop the
  unused pdev local variable (Tzung-Bi).
- Move the note about out-of-tree triggers and how the issue was found
  below '---' (Tzung-Bi).

Changes in v2:
- Add a Fixes tag (Andy).
- Use a local struct device pointer and name the platform data pdata,
  so the unregister call fits on one line (Andy).
- Say what triggers the problem and how it was found.

v2: https://lore.kernel.org/r/20261105132057.2429385-1-sgsatyam@google.com
v1: https://lore.kernel.org/r/20261105073107.172121-1-sgsatyam@google.com

No in-tree driver changes st->param.info.sensor_num after probe, so
mainline is not known to hit this. The ChromeOS out-of-tree RGB light
sensor support does: it changes the field while a command is in flight,
and unbinding the device then leaves a stale callback. Found by an AI
code review agent.

The patch was drafted with an LLM-based coding assistant (Gemini); I
reviewed and tested it.

Tested on downstream kernels, together with fixes to the out-of-tree
RGB light sensor support: ChromeOS 6.6 (Intel) and 5.10 (MediaTek), and
Android desktop 6.12 (MediaTek) and 6.18 (Intel). Unbinding and binding
the light sensor while its RGB channel is read in a loop failed within
1 to 46 cycles without the fixes (the stale callback slot makes the
next probe fail with -EINVAL) and passed 200 cycles with them on all
four. On the 6.12 device the accelerometer and gyroscope were also
unbound and bound repeatedly and still streamed FIFO samples. Mainline
itself was only build-tested (W=1 and sparse, x86_64 and arm64).

 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index d03e40c91582..67fb53071684 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -213,14 +213,11 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
 
 static void cros_ec_sensors_core_clean(void *arg)
 {
-	struct platform_device *pdev = (struct platform_device *)arg;
-	struct cros_ec_sensorhub *sensor_hub =
-		dev_get_drvdata(pdev->dev.parent);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-	u8 sensor_num = st->param.info.sensor_num;
+	struct device *dev = arg;
+	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
+	struct cros_ec_sensor_platform *pdata = dev_get_platdata(dev);
 
-	cros_ec_sensorhub_unregister_push_data(sensor_hub, sensor_num);
+	cros_ec_sensorhub_unregister_push_data(sensor_hub, pdata->sensor_num);
 }
 
 /**
@@ -372,7 +369,6 @@ int cros_ec_sensors_core_register(struct device *dev,
 {
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
-	struct platform_device *pdev = to_platform_device(dev);
 	struct cros_ec_dev *ec = sensor_hub->ec;
 	int ret;
 
@@ -391,7 +387,7 @@ int cros_ec_sensors_core_register(struct device *dev,
 		return ret;
 
 	return devm_add_action_or_reset(
-			dev, cros_ec_sensors_core_clean, pdev);
+			dev, cros_ec_sensors_core_clean, dev);
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_register);
 

base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
-- 
2.56.0.455.g6c5a503b38-goog

