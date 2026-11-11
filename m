Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415264;
	b=GOXv8oINeaiiZN7Vi0UkNNY2FJwA5OGl6/Fp5XstrVrHIMjL5kVj2nAUkd9EU+WLkEPF
	 3dv6QbbonfEWepxJephP1AdnjLLifetzTjjBcMHBEX1gGux92MZ29FjzD9R6AeZhrA9ZN
	 CO3uFOnmGslxSgF7lVitOakeUvwAh4Mhc4RGcF/0xAyHsnEYQsAb2fyeRXG0eYeoAhVw+
	 hJUNQL+fmYdCfhEy1DGAlYgUJbdZ56d8lLneiS1gWz9JJWiB0djicD7eTFn1Y8pPs2++o
	 KikX1wNmBQckEyun8OIRHI3mG18oDFGkofxQUpnYIAHYyOJMNPDS67E1RLeI6oAqS7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cx2GJZv0nPlyc2oGZvUNO5nAv52QpPBEMd8qDdNdp+0=;
	b=2rkJY9MMPEwHJ7+SEa0C2WZDkYik4E5N0/xM9WDYM6HSn3pH3mY4QqpA3yqtDYMwOUzv
	 qvo/cwSG57Rxxegm0NcdwAkUqHyG1OQtnuNX0BkZOx0CjAlRAS3KDvP24i4sYSgiI7V9t
	 KAQaxJJJjCpz4v7dRyJ4V9XL6C4wZIPaaXRwMNYbk7I6xqEu42MVJ55PGB6BVmatAwm9z
	 iuHhZfb2pQpkUqRXz5TeBshIWnDLTX7/4X0rDY7U2ah/k9/qKiTysuTHAuKM9LMzEENPz
	 hfSrLYZ+m9W9onp+HcTNNAdgP/Hqfu8q8Zd40MW24HcVUsjuoMDWS+pclFJVE63+7XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bARyq5AF;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493C60A261C
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 16:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4493C60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bARyq5AF
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36f8cdd30beso5922594eec.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 08:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415263; x=1795020063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cx2GJZv0nPlyc2oGZvUNO5nAv52QpPBEMd8qDdNdp+0=;
        b=bARyq5AFbyOGkATwqw5u+y5bIeorjoJb+ZdCWCH4hIkcz72XXq36gjyWbLpPPlp9Aa
         umeY/AqAcpKk8/QUaqx9l02V4Csog8pjAYXBhNPwZhZqGdMbnVsYoGYpo3ulpqrGtyTc
         pcgSxEyI1+d+4w8+cB20bsIETRkPOxLMUSH5vreHxaX5wK8jqlZbWZmRcy2e7Vv84XSn
         nwiU/HxZqfDVLmChEk/8KGM2/LMcLfx9x2GUYkNETKs16mFrKgs0tP+Y+PMri3txMO1y
         jg+W8HyPqbm4Sy4gOSwukRNqot4Mf2ilCOds11vE99KUgIFvTm4QGeHBGvAKpSv5Ii/3
         4Zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415263; x=1795020063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cx2GJZv0nPlyc2oGZvUNO5nAv52QpPBEMd8qDdNdp+0=;
        b=ZQ+7AyKpwSQDrRNHbgDGrRxYe3k3kK9bo3pKlvTjfZxYEikzhI/h4l4hVE2Qzgskug
         6PIlCP6cxqjqNIc1XWYUKC/Dgu8+XVMvZRnCMHof/OV8lgM0BN/u6hmGI3MnPiPbk+w4
         t5X1XpwkZAMYHg7vQSXLEqMGk0LLPwUaksjXiiDkeXWmSVGublDtX5LLeMOInC5mu/Qf
         6wNmt5wBJzpAA1NDPnzaoEsnpC/99gGwkyyh9sVGUXItZAK99mguibOGeAFRihu/nDuH
         XVW/hW//xjoUMF7y48/bAPyt7Ikl4EzQa8GNW/3r9q31R788zO023ptJEpHNz1FTijPv
         yWHw==
X-Forwarded-Encrypted: i=1; AL+hErG6tZ44H1zogmClKMiY19CW1eA38oo6dSPxgyF/3luODTloT0TIbhMpz+1oY/hC40Gxw4PmUr++4/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9whJZeO0kiXiUoKzal5Ut6bN+ZQTRdIc3R83LiYtUfACUXcSF4
	+tz6mzukl0KIVZIz0nA5YlHh3Y1+NQgAp9tj8zOz1fpkKUujSO6gF5Ss
X-Gm-Gg: AYBFou11Loy/v1iq6gIejl2FYEhaufmxK3/tHsmyQapFEhmUN7ifR9xg7Hb5bC+vPpY
	tyzW+1hnTUF/BLtzu6E6QT73xMRWEwsPcPfn6kd7sgIOWbBDAh5hLTrqR6fskg2eceqnZRu6mIb
	i7NGdygMkiIqhsG/A9HCVZTLJWLlB+qZknbxNYI+RMTQJH2msLf5Z4OVyr2dYRqoQLo8M7ZnQ+8
	BYN3OfKyEbuXPXbzsT5xB0EJOdqmZF+BlmM8xysvblreUwJLVppXvIkaZxAl6XEyNFoHsquvXnN
	kNfn5+yXLH8fpYnsNtzFoS1rXNHKH4pqHzeFwIxZ8k1M82ufXpidZqgNVUtJi3GMrG/FD5KFUzE
	Rg+qE73sbDE2VWADn4piVpS/gXh5vzUn7v/ERINttI6Nm4Jwb6UReuCG47brIhNl9352C4eoLmm
	/nGwzP35E1Jd6P6MrswoRwFZCVKrhJXdItoXnc56RVn3O3Yu4Mt28Bj4Zhz415W1dYrcKxxA4Tg
	vBr8N07arsSEj345FXkFmVV6VaxmRgg0/1VCRQXpJyPcxd3cOm7zF6vZKSpUJrfhJSXxLmj34c8
	Q1kbW4RiTODrHL3cLxphytgzTDv/7CYSOu5p8dTTDeNWZ2sxrf2orlKJJTwx9+Bh15mKwYb2kOA
	cAqd5IsQUOa45dkjEo3SU/zg9MeWyO5UWB851lNMLGcous0B+0wcIs3Auq5twOaT0D9ylqpHyQR
	ABSY7IDkhYGHpMeR/mIh6eJD+zqS/dUownQRxBn0H58w==
X-Received: by 2002:a05:7301:1604:b0:376:a6d7:8f6f with SMTP id 5a478bee46e88-376a6d7908bmr2936467eec.17.1794415263376;
        Wed, 11 Nov 2026 08:41:03 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm19158013eec.24.2026.11.11.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:41:02 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v3 2/2] iio: proximity: sx9360: reject out-of-range hardware gain values
Date: Wed, 11 Nov 2026 22:10:37 +0530
Message-ID: <20261111164041.341776-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164041.341776-1-kapoorarnav43@gmail.com>
References: <20261111164041.341776-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx9360_write_gain() passes the value from userspace to ilog2() and then
FIELD_PREP() into the 3-bit PROX_CTRL0 gain field without checking it,
so some values silently program a gain unrelated to the one requested,
and the write still reports success:

  - 16 to 255 write gain codes 4 to 7, which the driver does not
    advertise, and the next read reports gains of 16 to 128;
  - 256 and larger wrap around in the field, e.g. 256 sets a gain of 1;
  - 0 and negative values write code 7 (read back as 128), because
    ilog2(0) is -1 and a negative int becomes a large unsigned value.

Return -ERANGE for values <= 0 and for values above the gain of 8 code.
FIELD_FIT() is not enough here, as the field also holds codes 4 to 7,
which the driver doesn't support. Values between the supported gains
of 1, 2, 4 and 8 are still rounded down, as before.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2a9b37df8f62..22b6b751c0a3 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -68,6 +68,7 @@
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
 #define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9360_REG_PROX_CTRL0_GAIN_8		0x3
 #define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
@@ -625,7 +626,13 @@ static int sx9360_write_gain(struct sx_common_data *data,
 {
 	unsigned int gain, reg;
 
+	if (val <= 0)
+		return -ERANGE;
+
 	gain = ilog2(val);
+	if (gain > SX9360_REG_PROX_CTRL0_GAIN_8)
+		return -ERANGE;
+
 	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
 	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
 
-- 
2.53.0

