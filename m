Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433DE19DF4F
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632534; cv=none; b=iw3nknvmREnI9G7GtvwhdkkVGxyN2EelbAl63X8CDXuute5VrnIp25VnODxfoEwfbWeOTZGlL+V5/jWiQXCVFv38UqmGp2DsqDEJJ+HzGib3hlIqtFuPgFgBoeOvYGRzL+FvAHcdkBKAiuE+RLzmUT6MQMEMDnbQ0P3waugrzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632534; c=relaxed/simple;
	bh=GV5Du5irr67MCF6Y5SivJf7NN5YLZm0xYjcNv8fUz4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgCLYfLTi60uAuj95kuxFNNxWJO9P+5DLqwI35fIoKUQk/CbS6eNnwj7w5qFoCqOHrvckIzGHJa7zbNjl0qNfz/XHx+9eMpTwm47GSb7gR84tgc3PHWjFwVhhSksfLEv1K+eRGwKiE6mCr4HKhuA0m2B61akjwSy8mgIosNq+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=GAVVrHPm; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="GAVVrHPm"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so10670331eec.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778632531; x=1779237331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj8k2pIm7AGjb+3hd5/bWIIgB52x4pA/wcxJmlNMSMU=;
        b=GAVVrHPmS6FVjvcqFYB8vRRISt5o6BhnRDsgZEi3p6+trXNbGBAoa8Bu6RJLdI+pnT
         Emb6UB7OLiLs4lyYkJ5Wiijt5XXpx1raExiULP7Es6k4WwXwTUlOVK8Lgxfy9KTgyGOL
         sc7swAupvaxVoojBYqIeVCLD8puhIV6p39qDE/+nLELmoH5Oh1ajUwMhT1MRiIgTnx0I
         YccGJAGsxHrDFJ3zAH2+cbi6H6LRFdiCBhSZHuu7Krkdx8vz/RbwuGVg+8jK4ZFxshDS
         MqvnoLimx3CNU9F9C23kRIaVx7U02QkFzfpD3pSdcTEUh2PFe+RybLP4CEZ7xcIgvokf
         mJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632531; x=1779237331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rj8k2pIm7AGjb+3hd5/bWIIgB52x4pA/wcxJmlNMSMU=;
        b=AbB+cs1o6eDdSUDiaQvZYSg5+Kiz9V/rLHz5tSC55GJcNSmEKf+xpZ9/kWXCWLXGyo
         AbcU1NDHMlVoNkgCHXqXcEa9yMIEbZE+hY1GITyhtv4PEiDpyWvYRClG3QyDcsPeyOmG
         a+NmTf+c9xR5awmgBe4MDSzmHmclbUItmCi5IVYQ+EEpN8yCIDRFMYXj9JVxHL9/+i8k
         FT8pSvq34Ih+BouDo4HXpH+jIwYGDNS3TGYGvaqXCd4WfRvPXGs0c70kFKWD7wMTccub
         Z6b1YnmkMiigBHyLF+q2jk1JiRb7apTrpEawZydKf1qqm5Kucew+jcZubKuyo4Jyv+J5
         ZuDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CehQheJKwEoRq6Y/r8EvaG7O5q+aSkQ5jzYJq0clnC00UfYQ67civFgE4ayR6IYoMvS5OFEJXOTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRY4me+TeBMtdnmKl3NQVSIgw/dkLMdnJ+ueSSTaKujY2lddAR
	jEBopmgybzHtUxcVDXKfHG1yWQVykFq8lIqVI0ByHdYWYCqzycx0YzwOksU36Xmo8rU76e9Q2As
	OXCCj4WU=
X-Gm-Gg: Acq92OG9tkwBA8zMG2ct5rAIeOwEV4uOMIWZ2Kgk1mq+57VIJKys2RpvgF0Y8nRpF4m
	NYt0r+QMqydYj0+nLoaV7dChS1x5BnnZa3j/+GD6bxgd/m7wiK15yNv62fhc4Gfm4QbzY16bN/l
	q74/NaxlO+PaFfT8yC1eBqDH5IqrzadOtwDhBq6rXQSqaKSsp6uIQXVDA5/5gDTsszUrchR/zTT
	ZJU5cAuji9iK95ADyFvlNspsr+PgPGmomnjRGvNJYbvUEt/pz4jwmQpiZng1ZCQ9zj1goQgrkP3
	LLOipgEK6VJ92KVI3SWVWXRpqFiLgHSfEy+h1nd+vM8J8QcHySYkUUXSlW1j5OJysbBLRtd6rtc
	ngyN8WiXClPURNnXHnWb/umT67v9RpW/llG0MvbBdIf1Gy5s9BOo7DpiEBm3CGdgoW/SLTxsmO5
	mP7nEvh1CTd6u9W1a2BccF129uH3qFJ5LnR1NoSpQgFQwvU9QRnSr+FZ2YT+WNJO9FCF5DPGmHi
	94IXZtm+qkyxNIZtGuFB+q8nvVBhNgVksxOrBdSskgoFH3R
X-Received: by 2002:a05:7301:600c:b0:2d8:df01:d9f6 with SMTP id 5a478bee46e88-30156511808mr260791eec.23.1778632531367;
        Tue, 12 May 2026 17:35:31 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm18471381eec.0.2026.05.12.17.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 17:35:30 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: anand.ashok.dumbre@xilinx.com,
	andy@kernel.org,
	conall.ogriofa@amd.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	manish.narani@xilinx.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	salih.erim@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan.Cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 2/3] iio: adc: xilinx-ams: use guard(mutex) for automatic locking
Date: Tue, 12 May 2026 21:31:51 -0300
Message-ID: <20260513003503.339418-3-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513003503.339418-1-guilherme.bozi@usp.br>
References: <20260513003503.339418-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded mutex_lock()/mutex_unlock() pairs with
guard(mutex) to simplify locking and ensure proper unlock on
all control flow paths.

This removes explicit unlock handling, reduces boilerplate,
and avoids potential mistakes in error paths while keeping
the behavior unchanged.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/xilinx-ams.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 6191cd1b29a5..70a1f97f6dad 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -720,22 +720,20 @@ static int ams_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&ams->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&ams->lock);
 		if (chan->scan_index >= AMS_CTRL_SEQ_BASE) {
 			ret = ams_read_vcc_reg(ams, chan->address, val);
 			if (ret)
-				goto unlock_mutex;
+				return ret;
 			ams_enable_channel_sequence(indio_dev);
 		} else if (chan->scan_index >= AMS_PS_SEQ_MAX)
 			*val = readl(ams->pl_base + chan->address);
 		else
 			*val = readl(ams->ps_base + chan->address);
 
-		ret = IIO_VAL_INT;
-unlock_mutex:
-		mutex_unlock(&ams->lock);
-		return ret;
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -939,7 +937,7 @@ static int ams_write_event_config(struct iio_dev *indio_dev,
 
 	alarm = ams_get_alarm_mask(chan->scan_index);
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	if (state)
 		ams->alarm_mask |= alarm;
@@ -948,8 +946,6 @@ static int ams_write_event_config(struct iio_dev *indio_dev,
 
 	ams_update_alarm(ams, ams->alarm_mask);
 
-	mutex_unlock(&ams->lock);
-
 	return 0;
 }
 
@@ -962,15 +958,13 @@ static int ams_read_event_value(struct iio_dev *indio_dev,
 	struct ams *ams = iio_priv(indio_dev);
 	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	if (chan->scan_index >= AMS_PS_SEQ_MAX)
 		*val = readl(ams->pl_base + offset);
 	else
 		*val = readl(ams->ps_base + offset);
 
-	mutex_unlock(&ams->lock);
-
 	return IIO_VAL_INT;
 }
 
@@ -983,7 +977,7 @@ static int ams_write_event_value(struct iio_dev *indio_dev,
 	struct ams *ams = iio_priv(indio_dev);
 	unsigned int offset;
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	/* Set temperature channel threshold to direct threshold */
 	if (chan->type == IIO_TEMP) {
@@ -1005,8 +999,6 @@ static int ams_write_event_value(struct iio_dev *indio_dev,
 	else
 		writel(val, ams->ps_base + offset);
 
-	mutex_unlock(&ams->lock);
-
 	return 0;
 }
 
-- 
2.47.3

