Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9B340298
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915074; cv=none; b=e/dwzLnlIs0g+daqxDE4XvGOCIZtvUeElQtuW3LkX7R+O0I3bFXkAgWbH7AsqKzw+3bSmzC5lE8cwBMQRwgRtArlVfcKx9QrTBuTVCnh+HWj9thz2slunGjyeL/X45uCw7sw3sOYrURWmyzkDvM9++UNYXUuTnFoN1sqabJr4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915074; c=relaxed/simple;
	bh=z+U8oayBtbyDjiqzkSugPHEzyalDbZXOfve5HtCvp4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H54Erq2mMDCaQhKJ+Q+98CLZovVqT8UaWrI06KrWYGOfYJ+YpE8v6VS8sDnl5Qg+qVJ3R+arXrJftGxkHMcayiDjY4XaT+IVMNF8KmN8fBJzas7cP0Vu4CWvzlIAJp/NdQZagsb+IAveiEyOow21ItdRQ0mJJQxCbAgSc0TH99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxBQltby; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxBQltby"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so27866535ad.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783915071; x=1784519871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxnQGcuHLKcf9MzGH2TOhY5/hCrMKAUAuuzoIzFw4Gs=;
        b=YxBQltbyyfo8kSN2MC8465WvRj9Vn25AXVcXoF+lG1WFxYlGzI31e83YUqWkSdWLHM
         MIXLlOcSMvlk7VDaHXF2E16KMGug2tCrVmlN55wnU1Y2jZdv13NHZrLwNQGnyGSDxu7k
         cmR7+1YIKOmIjZtz/ptkYEWocTv2MYFur+tMhQ6ZHC1KTIU54MMceZekGiERDRxiW4hl
         FUZWtPsc9kMKNb2n8PV2GE9d4zAjNFzFJ8MLOly7Mbp3y6/smWA2U55XPTUVwhXc33Zl
         FCvb9ilsH7+zbei5bunYKZxrssxTNoOoiPEhGE/3rBUEBBfRRAdKlWHOKTFwygl89i+6
         pMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783915071; x=1784519871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxnQGcuHLKcf9MzGH2TOhY5/hCrMKAUAuuzoIzFw4Gs=;
        b=dq4r/fBNVxGXrjmO8awECybq4SbtGD8YjT7U6u9qNOBS+KoWmk/ZIzjvrqRirni7j1
         AMc4aDFkzw1bsum4ozPUkrY7lJp46MeKC8/PgEd6cbr5fviE4hmlH7TU9V6nN4+zLtmy
         1wVSwS2AcR2HF02eZCHo0eilcB+eoymH618LyjFNXr7V2L4Nh1fWZg6IQs6N3T8vhL+G
         juDHyT0bG8qAZ3y8Yk0Y0IRAmCZrkw9AWeHwPOZYasZ8UnPTMXDmN/+7RZN8J2DFsMpf
         6aWS/ynQHx1Iwsm8vMJNtZrTzyXPvgHAQ4vWoxi4JEcWSert0K93oZoHYPexmxxqkU99
         upww==
X-Forwarded-Encrypted: i=1; AHgh+Ro+4yjt2Lk++WXVBDsBlIj+4VKxPgQe1JOX8ed1x1YL243RtrVJGpsGPEQ/8osdkWTR8sDp9BBEpE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwklK+Z1ek0GK9k5gzls9LotZAbRENRicu1xJyXGUI0rAWU80dg
	EdWbEqc1am7DjSJHyQ8JrsKyZxwi5vmr1uS9OGmInUjIc1O3MeQ9K58=
X-Gm-Gg: AfdE7clf6OOMk4C8xQe60WquVrxg40OVSusLSly2n43lyRaDL2lkrJsSy7H9V4uGDP2
	efWm9cBRtTq+LbWQdcED+uArpXznOycCC8HrE+S9Y0osUMPYlckmsmZLp4dbvTx7zi9bq2ZZBF9
	fZPMIWNaU+uLhkmOfq/NlDdsNvklI0g0vQVku0JBIngpCMXFpavAEiNVw1IFFkDcEmcyZfPOqG4
	F4OTkskPnQngU+9uuD6Kq7nFiG9dzte5ffwFdubGUqsuNLRrDg5Q4awUTd00a1zm8+Msf1a0oOf
	vdSbOL1OpPlZJWaBG5M0Bt5K2Vqceb0BD6FlhXaLW/eZEVTfbtgHMveMHw+pr6TxnosEVkid5fe
	vBcoSAh6ZXG/jo/hdyrlkPr/N71sDgsDKiB6A4ej2uL/UqYd0DUPTfHm/vb8tuE8F3psvugzFkq
	k/hIBTl1sqehcsxs/OfseAKF8BSlIB9O78+O7DLA6kgpCqjWSy/kqS
X-Received: by 2002:a05:6a21:386:b0:3c0:9c19:659f with SMTP id adf61e73a8af0-3c110b7b9d2mr8245371637.71.1783915071565;
        Sun, 12 Jul 2026 20:57:51 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm60862704eec.4.2026.07.12.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:57:51 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 2/4] iio: light: opt4001: Reject integration times with a non-zero seconds part
Date: Mon, 13 Jul 2026 09:27:34 +0530
Message-Id: <20260713035736.11346-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260713035736.11346-1-nikhilgtr@gmail.com>
References: <20260713035736.11346-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opt4001_write_raw() only looks at val2 when setting the integration
time, so a write such as 1.000600 is silently accepted as 600 us.
Return -EINVAL if val is non-zero.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 0a2d2273355f..9ff99c19b6ae 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -287,6 +287,9 @@ static int opt4001_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val)
+			return -EINVAL;
+
 		int_time = opt4001_als_time_to_index(val2);
 		if (int_time < 0)
 			return int_time;
-- 
2.39.5

