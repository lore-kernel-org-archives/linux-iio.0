Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497C390230
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206614; cv=none; b=qEcW8I17ttX6GCY9ytl6YwJ208F3EVgkO39b4YbPwXGmIo4WvFzlFXcE+/RvCo6rZeKLS2hHlNPm5GFaHi358kfboWqVJlSAA1APwvazCeSM8jaxyZjGlHuihcZskvOCreV61RKEJavnlHyXTO/QwIt/ENnrelnVp/CjgUz106U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206614; c=relaxed/simple;
	bh=GV5Du5irr67MCF6Y5SivJf7NN5YLZm0xYjcNv8fUz4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBsENs95yonITgxc+aUWMPXdcnpwd+spao7WYAN/YAVGtCJYv9rJIJaI3qVOfFfAm8+KjNbp5atyoaZ0c8t83GEDl+HcRgEw2s3dD6tRi6NMYIER9Ta/keQT0ZWB0b0oxhATLPb4Bb1pD73e6aXRu1/vH9aLoXMwmb0+HaNKWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=hjMSAFeo; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="hjMSAFeo"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so5455546eec.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 15:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776206608; x=1776811408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj8k2pIm7AGjb+3hd5/bWIIgB52x4pA/wcxJmlNMSMU=;
        b=hjMSAFeolBJGTl8Obsb0Lbfgm0ymIPRBJN0DWOXweKtqaNfgqPiwarOJFuzT1aQJir
         95Zf2WWqiFjsLOShpjtk2ZXMh71rxlUPkH6qe4og+IUA3F00mz4j6+HTk00fpTtMtYEn
         3DYhr6xn3mbwEjPcLsj8SoDohrNP0ZpD6lrvAJQWlPe3Zry0za7CsND9G8jwvTLabMHz
         bHo8wqu9qL0X1NmG7yUUwzEaPAft49F224IO6gCZUTRlrji5PGAZKSWaZjVVh+Qta6Ca
         K0G1ZWiyzPG9aX3GSEQaSxJDLqlCLgOn+esnoFhFB87qVB0L+Rw05VnUa25EIyFkb0E9
         qwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776206608; x=1776811408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rj8k2pIm7AGjb+3hd5/bWIIgB52x4pA/wcxJmlNMSMU=;
        b=A+ClABVheH/5+5lHcd+h5YIGAIWcK6XUI8vLJOXt5SRof1Skcl1JO+C7SWAP0BE1cN
         kPVqPOxPDEvB8sJmsD7NVCHWb1pHPrItv8Nf8nfJTJTcna/k1CPEwgjazU6ItRM5kzI6
         h+1TwJmOR/xojT3c+hCzhjo9xUkgPDhS2TAsahrWwKk81SqMvPL93Vhmz6AhfKq3DN/L
         x6NO0by7iaaodDiVeyaonVibT0IADQ8OPcLqSdNRkKPE1VZDj/5zbem6jkPsKadsvgUA
         5A4aZjw8TY2SvcHpb3bBjUQpfXvzWz1O+RydgOwPcRcnYrEj4W7GYpHUL1x+/tXIp78+
         r1cQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YR6gFP2tbvEsDviB9pA+qcFxd3WTXgexw2KoK2JlV6ZbN86sMrHU+WPCcJAMRzcMyjSA6WTi5fKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cBeGshXz3qwwutZxkqmGraHOy6J//4nmoDnTnJi+nP12IVf7
	Y18qSOrCwcNGG2cllc8+p8Q2sAxftDzJUD34ysvI4ZAJE2tULTaWn0AhOvEDevPDhCI=
X-Gm-Gg: AeBDiesdhC2LhahriTsIBW/snlnm5tQvUtMvgL/1dvKuS4mLnqyldPusxJMrl2hWxFD
	cAOXUYrEXjPgvc8l2iX4IwS7xDh39CN0iyc3aq3bqihIIP/nbUmnW9Vni1mtLJz4JGWYl93Tr8g
	HkFSIHSqMPcOoQRr5U8KWEzMIt/frXTFAxhwq3qjCBManECpbU86v+EoaTW05tmXrA0t7cHPwiM
	DNHd0YhOMiw+uwePWQAE1zOWRtawIa69dXSzsSUZpJQwnP8W2cUzQtXr1oBN7hAMLaAQqA91W4x
	aitBMEXDK4gfhqgpuPE9JeMkNkK5W7zvvz5xqLWFvyIOO6MhJEutmPZk1qdYFwfjaDZx/Fivm77
	ePdRWruBh/avUCY/FNzGGOabtRVi1PlWMowd9+8rY4uAtXt0AppZFMYbAaWkKzxSesY2njFHhKA
	mxjaLR3winmd4cbsj5nP0hvUhQVNt42OdoHciryTIKNDxD4D3DL6qP6HHIJvXaN2zpxOjHKRcDE
	2R5G44rH/9NK+rP0oQf5NlInE74alwcDZ7tykPgCy5kolSMdA==
X-Received: by 2002:a05:693c:80c1:b0:2d9:6f2f:9f6f with SMTP id 5a478bee46e88-2d96f2fd124mr3002666eec.24.1776206608051;
        Tue, 14 Apr 2026 15:43:28 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2dd32dc2827sm4650361eec.23.2026.04.14.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:43:27 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 2/3] iio: adc: xilinx-ams: use guard(mutex) for automatic locking
Date: Tue, 14 Apr 2026 19:40:34 -0300
Message-ID: <20260414224245.8493-3-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414224245.8493-1-guilherme.bozi@usp.br>
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
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

