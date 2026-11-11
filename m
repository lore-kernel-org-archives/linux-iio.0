Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381973;
	b=VM5fixrlrfr60bQ+ETcKFjYKVE8hS9O7O8K56pZmHnES97ANEZ2aoN1N0v1F0xV0Iset
	 Mo64xv8wS3lAiaRYh65Ye20vQDF4NndPwupkw2m1xRa9y61aXzz0CI9D+z8tg/TJiXJOi
	 crbPNSf7mKJwG8TywkXOKu/fYwKutOzaoDu6eyKCTRQAzNlVmIO/9nO06iMtvgO659R/U
	 SQvsaHcLvNvOVbg5UDQ8uvB35b0AgQ6bEKxvJh6hhBF7r6bSwZZTvHOeurd8uxkGVzoZd
	 xmMBZOE94V+9/c8RzlqFVnkbXoSPp4ksZs+iQliygifEfGPkxrkIlE1lEzvZt8OafHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=qyaSt7rfLd9UWAEQmgIczF6QNCmMTt6/VnKgUqvfogg=;
	b=Bap4rDdWDPjtFseNpRK1br4krssp/cWMaVIEO5hlUJIimyBWWPxViX+DwuTBWAVn2m8h
	 4SBEP5Op5GVS6CwQoTTiCVuxk5UbCarkC5AeWVF+/l4bvTkf1fBZx9FHzFjjUG5DWTjdD
	 SsXayX3dNq1mwFcXKQo1h1s4LUxvUntI16P8bP1j5kyxzguzlxJjECvzayqGOS5gFqII0
	 RG4eP1iBxtZ7BOTfODwAHb9Dd1KxWzzq9Fqp/Mbmvwe0gmG8hKNXLlB9Mn/cYgGUyGy9o
	 LmzWcOaHc/Hl9cZJ02fFRdWr+ACbih1Cfn8EM9gcUZn+Ss4AzkScRyvHblCYUzZ4PoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--diwux.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g3eQ1Cny;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38E606A33D
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 07:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF38E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--diwux.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g3eQ1Cny
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed05900df7so27450395ad.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 23:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794381972; x=1794986772; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyaSt7rfLd9UWAEQmgIczF6QNCmMTt6/VnKgUqvfogg=;
        b=g3eQ1CnyLlQsKsZymv0bDk8q4DGsjqeZHEjvGdX2RYTSTmPWoN3RdVQSpAGFn4vzaT
         s3459hiWtWC1j0N023EK/eF0deSwiC6J4u/PXy4O+GfR/qWDZm2P/rVX3M9SBKppwa6C
         1iEvj2jToxB7qnjgM4YDhzfMkdkeluH+c9yiBopin6UJI18uS41SUk86ZbeiHxNFd/Qw
         3gXmM98VhAGNxd1g8Pqk152u9XVt1PUmOqB3Yiq7jBk5GBhecn8WsBw/Hpp0E/6McOtX
         Wmz9lDJwuMxDlJjYAKAZuAeo+JCqrsCIIr9hHutG5DCQLfI9AufRKar284FAJPh2Md44
         RreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794381972; x=1794986772;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qyaSt7rfLd9UWAEQmgIczF6QNCmMTt6/VnKgUqvfogg=;
        b=q4mrPo+ze09nKKN+4IofM0OBoFjc8udql0//MGGRYpluoYFx3fOaV5RwUPK7mu1Z11
         TsMBL2qqJpKvoss7+01lCpeCxO7A+Lwrs237rt9ny15VgJEolgKaDZL6y4ocxm6x/JQy
         5rrd/LlbPqm0bZtC24q+WaPocSQVunxSDzdtv2DxdZr/IXBC/BrhJBmJOFt+jlD/937K
         iiHMb3ekHZ2AXkWND9pVj67Yr/pZ+CjCOqUy5PpWtqNPXz6QLdNCxBRQNCqESTX87ySj
         5mvJwHpqKx5LxBnT73iSKPZqsQn/z9YrJ5jnX9vbGho2+KYWlmB3gCRkEfaotM+KH5d9
         r9tg==
X-Forwarded-Encrypted: i=1; AL+hErFlZ1YrgI6qSrKsFnCtDTsQVsnvisgbkHTUnAoUUvAwDc2JgLCZHdYtkflFIO4OK5UZjYaKDigfHmA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hZlpc5ZzLQYEoAb4mBawKqc0GmCWJX3bpyYZIgcV0m/PPGwsH
	Ph/PkwWhqc13esnYXTfR1er2ZaTpWedFIDmf+WEpsQ53tMRXM8BqpC1UFhXwMQbxzeUPLqbkpYT
	5/w==
X-Received: from pla14.prod.google.com ([2002:a17:902:ffce:b0:2ea:7f9c:2ce])
 (user=diwux job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78d:b0:2ed:e22b:779f
 with SMTP id d9443c01a7336-2ede22b8363mr6850925ad.58.1794381971881; Tue, 10
 Nov 2026 23:26:11 -0800 (PST)
Date: Wed, 11 Nov 2026 07:26:08 +0000
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111072608.3490763-1-diwux@google.com>
Subject: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
From: Di Wu <diwux@google.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org, 
	linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Di Wu <diwux@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
PAGE_SIZE limit and is the preferred helper for show callbacks.

Signed-off-by: Di Wu <diwux@google.com>
---
 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index d03e40c91582..624d4b32b034 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -149,9 +149,9 @@ static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d.%06u\n",
-		       latency / 1000,
-		       (latency % 1000) * 1000);
+	return sysfs_emit(buf, "%d.%06u\n",
+			  latency / 1000,
+			  (latency % 1000) * 1000);
 }
 
 static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
@@ -165,7 +165,7 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", st->fifo_max_event_count);
+	return sysfs_emit(buf, "%d\n", st->fifo_max_event_count);
 }
 
 static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
@@ -465,7 +465,7 @@ static ssize_t cros_ec_sensors_id(struct iio_dev *indio_dev,
 {
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", st->param.info.sensor_num);
+	return sysfs_emit(buf, "%d\n", st->param.info.sensor_num);
 }
 
 const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {

base-commit: b70566610b48ba49dec636019da4d696db64b085
-- 
2.56.0.455.g6c5a503b38-goog

