Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A32989B5
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934307; cv=none; b=OP+ohHWHzytkqLOjo0GjbRmbCThaNxeRaRW4/CrgSblAcbKSkpRH05Zdk4f6PQxizv/xkI9kJlrnNOeLgqrHiKLiaSe20/0VwkVEFxbI6K4twFWWfgeo5eBW7EwYcYP5b7RjE+95W45crkivAUpgRF0R+OFDq0wknq4EXwIK694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934307; c=relaxed/simple;
	bh=/1MB53WxYwYrJxGtXUsGnlz4muAeJwSJR6MVneiXaRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zvayw6axElOF3QdyOmj1l3yPCpML79HemIAhsmdSwoFIH7zFWtRskRmv7dh823+G6LcT2w8eeWXCAeSViPbNZOW/5OiuKavXg4lWCr/Cq2Ol0yohlggFM+1E25m403SElQyAcziDVPQ1iPTwdlJXQ/sAy1RssjhtxSvGGsHhCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VAtF+K2o; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VAtF+K2o"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45f126d47b8so7119927b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 17:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772934304; x=1773539104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y0Q32Eai6u50Ztr+HUMEtNeNWPFKto/mfq53aBfCfY=;
        b=VAtF+K2oW8XGdA97HfsOHS7wWaatQbWhOGpS6eMMTOOkVM0ROXdpNF5Jq+fDyRjbzg
         eqvj9iApd0KFDe5H2Mi8k90mt8kDtaf1+H5x7c9o7bFdMeCIwGaMivHXGWUR1HrjCxXN
         ZZWh5I8p9/JwzvQ+5+2/9KRqVuDmgHPqtOuFxE/3FMzK1kLGswEjsLFup7Vz3VuX1ctZ
         52YSPvaBJUrpF8RUlDXIVX3LEjLVxSB5IVsIDZknPaHj44QLFPUuETaOSgYveb/9NBrM
         dDchqst/BKWKYrxZjSGI5pbXLQKEtd/b2aQhYzXjDIvb0xxRf81qt+59zKqA8ZPScSpx
         v6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772934304; x=1773539104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Y0Q32Eai6u50Ztr+HUMEtNeNWPFKto/mfq53aBfCfY=;
        b=T5u6pnhHxh9zv6XxVfBUvpIaAErKcepU5z1mbjzHqd7tqR3SN+AvY9h2dZPNWQPNXy
         e9+l4iBYsl2yzfYxaXEm6KlKsvCIkBX6hru1AzIHjewJl1kRtSNMbX0da1oiS+ASRqaj
         O6MOHYsuGLTT7HGsQKCJlbADeUCjeBJkEkzRlezM6eTAOjVJ16Wmx/CXZVd6V75AhPbp
         pQrJcfuCd19He9w9ku2JMy3+qYysJS0TS067cp1ipCv1CnmRmnudE9lc6UOPyYJM7v6F
         zLhtf/ecMm+qbIjgCLNHUs1LVJr1ENrblf8uJtD5ANKdIw/N+Ll+ga/XwWjOcxnVl5n4
         Immw==
X-Forwarded-Encrypted: i=1; AJvYcCXCkJExbuQviCaN7LjaW6y+FPi/cnicVkVFvK3AiiHlKz63/SL7tb9+FdCKdR4tWDXHEgv3WducEU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhcDg4laYOoK+m4W/LQrarD87lCghgGCYWdftvl+XafyxjAE6C
	lNjbb2zw9r+e6aoMC1jGM8v/ndXiV8R+Dw46U1uwkHJfz4EjMQ+nunDWGDFL5n5WXgc=
X-Gm-Gg: ATEYQzw2SSXbcXa4DCY59hN+XjmtM3gTzV0Ht/KWi3FxeOvfRAcTM7onJr9650Fd1b0
	i35m9m6DhPrFaXeE6GKaohWMEryUIL/4vWsltJ3UDK2kO7R7NJ1mTqZde7I52hVxiiEFCQS9kkj
	huM1M2PTSbv6GrwPKw4/61jOfnPiULHh6eOFcODexToIrYPZahaKI42b/mCFVk5yrklKlZXlg+q
	yHd4ymKSGPrd2rn3an8lT0WZzt8IF8177ordnV/8G9PZwKzy2eHYN0jUz5F4uO32dLc20ITl8mM
	aj6PEjbXKvyvMNFjmc5q59Uqc/jkabqqvoB0S+ZenpwB9sCLxNWGCTdUHnj4a55vaXXFjLKERlm
	QKlRswjogGFUrY6dyGIUbvZ1iJJJ6a5CrV6vf8YizzMVvARw4iIcpoDSlUDc6PFHeWQz3CGxtWS
	bfJnBybVr7uFWUXoa3JG3Tfx2+umJm
X-Received: by 2002:a05:6808:6f92:b0:45a:a7fd:cc9f with SMTP id 5614622812f47-466dca55caemr4030618b6e.18.1772934304258;
        Sat, 07 Mar 2026 17:45:04 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm3244357b6e.13.2026.03.07.17.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 17:45:02 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 07 Mar 2026 19:44:11 -0600
Subject: [PATCH v2 3/5] iio: buffer: cache timestamp offset in scan buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iio-fix-timestamp-alignment-v2-3-d1d48fbadbbf@baylibre.com>
References: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
In-Reply-To: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, Francesco Lavra <flavra@baylibre.com>, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3645; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=/1MB53WxYwYrJxGtXUsGnlz4muAeJwSJR6MVneiXaRc=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDLXXGnqyeKWLQh2Fjt7evvBFn83yUbuv38ll7Fu8ncQr
 DC97s3dyWjMwsDIxSArpsjyRuLmvCS+5mtzbmTMgBnEygQyhYGLUwAmov6c/X/dzBA2wXOVW2OU
 Y/azp/yNmRhg17V9hkqC4SbXEmZR3zWuv6aHLu16KRrMdopb7ZBOac6G+YExGy4KCQZ2x2gYu16
 0YFWPc2JuetA90zB0l83CYgdL0f3trHd8GzSuhE+ULMwLnbpcl3XF9/Wl4QI3i83+rZ3Oe1xKqq
 S/6nfCR/HXjIXxE/cHpTXbpS2yqftZvNFU2P6yzQal5m0FjfFyoobPzHnZOFeuM26aKDhb09dq1
 0XfTUEl3EF1e2MF7qnFSPTpblkWeedCpr3iaeOZ5fUVv58m5HGon/lm5T7/5S2NnzauYSV+/+32
 /H/esEbGzyH0zN0at+npy9bwXE4Kqln6xSzPhi/2QRYA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Cache the offset (in bytes) for the timestamp element in a scan buffer.
This will be used later to ensure proper alignment of the timestamp
element in the scan buffer.

The new field could not be placed in struct iio_dev_opaque because we
will need to access it in a static inline function later, so we make it
__private instead. It is only intended to be used by core IIO code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Cache the timestamp offset instead of the largest scan element size.
---
 drivers/iio/industrialio-buffer.c | 14 +++++++++++---
 include/linux/iio/iio.h           |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4e413b4bb073..ecfe0c9740e2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -763,7 +763,8 @@ static int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 
 static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 				  const unsigned long *mask, bool timestamp,
-				  unsigned int *scan_bytes)
+				  unsigned int *scan_bytes,
+				  unsigned int *timestamp_offset)
 {
 	unsigned int bytes = 0;
 	int length, i, largest = 0;
@@ -785,6 +786,10 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 			return length;
 
 		bytes = ALIGN(bytes, length);
+
+		if (timestamp_offset)
+			*timestamp_offset = bytes;
+
 		bytes += length;
 		largest = max(largest, length);
 	}
@@ -846,7 +851,7 @@ static int iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
 		return 0;
 
 	ret = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
-				     buffer->scan_timestamp, &bytes);
+				     buffer->scan_timestamp, &bytes, NULL);
 	if (ret)
 		return ret;
 
@@ -890,6 +895,7 @@ struct iio_device_config {
 	unsigned int watermark;
 	const unsigned long *scan_mask;
 	unsigned int scan_bytes;
+	unsigned int scan_timestamp_offset;
 	bool scan_timestamp;
 };
 
@@ -995,7 +1001,8 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	}
 
 	ret = iio_compute_scan_bytes(indio_dev, scan_mask, scan_timestamp,
-				     &config->scan_bytes);
+				     &config->scan_bytes,
+				     &config->scan_timestamp_offset);
 	if (ret)
 		return ret;
 
@@ -1153,6 +1160,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	indio_dev->active_scan_mask = config->scan_mask;
 	ACCESS_PRIVATE(indio_dev, scan_timestamp) = config->scan_timestamp;
 	indio_dev->scan_bytes = config->scan_bytes;
+	ACCESS_PRIVATE(indio_dev, scan_timestamp_offset) = config->scan_timestamp_offset;
 	iio_dev_opaque->currentmode = config->mode;
 
 	iio_update_demux(indio_dev);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 2c91b7659ce9..ecbaeecbe0ac 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -584,6 +584,8 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @buffer:		[DRIVER] any buffer present
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
+ * @scan_timestamp_offset: [INTERN] cache of the offset (in bytes) for the
+ *			   timestamp in the scan buffer
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks. Sort the
  *			   array in order of preference, the most preferred
  *			   masks first.
@@ -610,6 +612,7 @@ struct iio_dev {
 
 	struct iio_buffer		*buffer;
 	int				scan_bytes;
+	unsigned int			__private scan_timestamp_offset;
 
 	const unsigned long		*available_scan_masks;
 	unsigned int			__private masklength;

-- 
2.43.0

