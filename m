Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168931;
	b=UfCx5uq6gBFqgd6TwVg5u5ixWFTSouXTb8trlVCgrmpGbluc42J5Mw+U9NGqd3NmLyGc
	 yb9ujlkGFb6DxnqAf6fj0oBIsqEz3wrTO2kEsDhElBQZZ50JORdWFeg7ZS9jBBCVM3w+U
	 6yxMJrSw21b0+twUByaRFd6q7yTzJXsreVpN/svroT7b+kL+r/FcB/SBob53RgSI4izVp
	 yCsOtUJ7aIXAQxqnIKLJfDW61+ohpnaSOGhTP33tHA08tSKGLxow1Bho3ORyH4H24Ynkv
	 eFCb8v1FxsxgDGnIDcn3zy0/MO1ZtTrNHkxoyhva7l5Mq33nHFYkmYBHyIe6lkrHtdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mwMelPe2uptqUBkelQM2Ts74WNYc83eK9MED/jsQkHU=;
	b=0V4LjSPv2qmyzzJB8gp1BRoYVhWRgfgsTGIPLXGgUvvukt6gqRvTHDW7BJNc3WHsCcZt
	 cehwvCCCGDDpQ5RvIHx8BygJEeQ03mlctFc2YtjJ6+bgXXUxUHgbwJ08+WGpxkOVZnKB/
	 zrpJja65drRDw2/h6njEwD4K8gzS3zn+O+j+ellM86bzxP8xHH9gxKXtXqsWesx7pyTc7
	 KFkGEkPNE9tw50QFvDWOhu7/xg16Z5hG3q/5uuo77HbT0Nn4nH7bn2zIAa3s2+nBR1rZY
	 yQyVLsHiPfqYBG3IByzl7+xUeHKqKpBI9BJDjy4PixGD4iaEXX9vypXviK83ox7IJPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T3XYe+DJ;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C137606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C137606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T3XYe+DJ
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e46e449e8so157766f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 12:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794168929; x=1794773729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwMelPe2uptqUBkelQM2Ts74WNYc83eK9MED/jsQkHU=;
        b=T3XYe+DJ0ow+8/m5Nfkgc6YJZbcr6JXmCQE7X8NBAT4JUfoIP935lMDv0qqa13Uh23
         w9N5pfUc4PNrMoYon5Dj/dh2x7ffGjyCw0VwRSKH+s1grA06t/M3Bi4qSqCoqFsGPKxr
         DfIf9fYUzB5cVtktzxzM6WtP4yRi6lZ32B3HkyzFy8sT16YrS+LPXRLqJ/jJg1yf0MP1
         e/Wlh1eDEIKGJ0PxJXc8YnqnDz6tySknzt5XL9K7M34pr2oeMk+YYyNjqIQoOzYwJkO/
         cav0C53OnF8qWIHgShirvJR+X31IeGjzipeIu9n2lGhbUHUi9EHh1vIYnqGTChDP+957
         fTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794168929; x=1794773729;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mwMelPe2uptqUBkelQM2Ts74WNYc83eK9MED/jsQkHU=;
        b=tCykqb7UOaXzki2AZiru4+XL9effJp4d3WeAWYRy7o2E6ZxMfS2RVVNEUDs5nWgzgB
         ekvV/aqHCmlwF0C+9HTxqLS0Ta9xDdndyAJmMR2ZQPX/tcO1MHnvCTSIkmHdrufF/3nN
         Upg6Ufxxk4AcU2+2pZo7Q+pBdSV1r2GYWYz2bMMKg9MVSusefkvOLNVN6nXdUcf0Kmyz
         wCusSli92ViZEs8v/ZzqIYIDP3d59STabL0wqQapJPMwTqF25N50Qw88lQzbPerquauG
         iPiN69rq3s8f5h1VfrNUaIt82qXgKsUpbLACp2QNEzz7Ob1fj75W2Dbva36paF5O27kR
         w1vw==
X-Forwarded-Encrypted: i=1; AL+hErHelv843QVpbFcxz5Sw7+EGsyfcVWrA8WFSzh/c8jA19iCct1gmfhQMSBK0VjkZW8WA6Wd/nM5mJnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2CyrluIGrMEOHW6ZzbPkVozpeaf379mREyk6mhKwmPJU15Lew
	BoALZHM4ofeoVmwC4UxSbXN1mDTizIFT1qCbTJzeHns7hp7YlLl4NgVF
X-Gm-Gg: AYBFou1sKdhKrZPrA4vrgIpe6mwK9T+/COI6RuEHZlHEV2lSKzCYlDTAWjOP3WB4E5Y
	oEEMaOf1IiUEpDEuqMtEXmeQcM+hkszYRLtGSdOJCi8aMpCp0DtjWcIJElL3hmepsQQw0Tc/wCB
	BJn3HQqv3wREW+/mfM333lfVGXa4ieUWn1GIKUVRHMDXeev7N/VD21APypAkWmTrA98u8ck2EBJ
	Bfq4luH2V3/cY5U4ATmUGynJ2P8LCokQP2cte50QEDirNq/w/3z4L4A8wG+SfJjXPz12WE3f4N1
	kZSCDFwcwr8VT9RvjmYtCRjtYrgZ14xxvQD7CV5lFura1eFhRs4sSysvNELYAfva8EuMstqqhr8
	kVYcqYO6p4uJgyb49y9UFY/VzOY/jp+LXaJyB+7tjZsT1fiGULXOpyyJDLwUwt9LcYVkzBP/GFG
	MWpVI2XOjCsX2sHQ6R2N9Fj6ciCeMlG7cE81OfD2EREsJ6T0OdiWeyO9DMHvBdtoSf49fPhdEA5
	OP83hOBIKE7vnu4jjMa0/s9NbtG2RX1WBjGc/wihj/xntHlWk6Kgvnj0fVBcwQ/n1K+TAa39g2D
	QigebhZQy4AX/MQMO/y6zA+Rj//aIkZY53d52+p1xgANCGAdFoDhVvg=
X-Received: by 2002:a5d:588f:0:b0:48b:e50:714e with SMTP id ffacd0b85a97d-4958c3a134bmr4334789f8f.36.1794168929453;
        Sun, 08 Nov 2026 12:15:29 -0800 (PST)
Received: from legion.. ([5.43.81.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597652ca7sm6047077f8f.39.2026.11.08.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:15:29 -0800 (PST)
From: =?UTF-8?q?Adi=20Kadu=C5=A1i=C4=87?= <kadusicadi1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adi=20Kadu=C5=A1i=C4=87?= <kadusicadi1@gmail.com>
Subject: [PATCH v2] iio: adc: ad_sigma_delta: use __free(kfree) for temporary buffers
Date: Sun,  8 Nov 2026 21:15:22 +0100
Message-ID: <20261108201522.249539-1-kadusicadi1@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace manual kfree() calls with the __free(kfree) cleanup attribute.
No functional change.

Signed-off-by: Adi Kadušić <kadusicadi1@gmail.com>
---
Changes in v2:
- Keep reset_length/size declarations in ad_sd_reset() as they were,
  only declare buf with __free(kfree) at its allocation (Andy)

v1: https://lore.kernel.org/linux-iio/20261108013328.125069-1-kadusicadi1@gmail.com/T/#u

 drivers/iio/adc/ad_sigma_delta.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 119ddc5a13e2..934c9965c69b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -205,19 +205,15 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 {
 	unsigned int reset_length = sigma_delta->info->num_resetclks;
 	unsigned int size;
-	u8 *buf;
-	int ret;
 
 	size = BITS_TO_BYTES(reset_length);
-	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
+	u8 *buf __free(kfree) = kcalloc(size, sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	memset(buf, 0xff, size);
-	ret = spi_write(sigma_delta->spi, buf, size);
-	kfree(buf);
 
-	return ret;
+	return spi_write(sigma_delta->spi, buf, size);
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_reset, "IIO_AD_SIGMA_DELTA");
 
@@ -249,7 +245,6 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 {
 	bool pending_event;
 	unsigned int data_read_len = BITS_TO_BYTES(sigma_delta->info->num_resetclks);
-	u8 *data;
 	struct spi_transfer t[] = {
 		{
 			.len = 1,
@@ -317,7 +312,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 	 * shorter than the reset procedure.
 	 */
 
-	data = kzalloc(data_read_len + 1, GFP_KERNEL);
+	u8 *data __free(kfree) = kzalloc(data_read_len + 1, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -340,11 +335,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 	memset(data + 2, 0xff, data_read_len - 1);
 	spi_message_add_tail(&t[1], &m);
 
-	ret = spi_sync_locked(sigma_delta->spi, &m);
-
-	kfree(data);
-
-	return ret;
+	return spi_sync_locked(sigma_delta->spi, &m);
 }
 
 int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
-- 
2.43.0

