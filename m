Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433892;
	b=r1GYZGi26/Nk9yRcpMlNceUvEMhlfYLtaD/F3TtQI5+xsfmKlMXoCsa8vufi8UnV5BtY
	 ZKTurYjrAQWApgbkrxnFDn7Pc9IFNtSVZKUJWGM64561YYEIn+kcAiGKricOZl2NaQqsY
	 4xvdIu4n+JeHqI4nRMWul+E4t6yKNosIY8cGBqSzTEl3BK1T27ZZ0MgJLVOak028YrN7y
	 YNWaP05eaog2zYSMehjCBz2sD68R95kXYBXqwYh7nt3b5qIs2SndDOkO73QVys/h2Ls8E
	 4rPXTCNudFKJJfOzO6tnb4bX8ouL78QMQR4mZpxlcG/PD3xhsNinWe06a1ryFnDXG3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/uf72jF94qcU3idbI2020NJhdWUqwDd/ONaRN+2ot6c=;
	b=1tU68qixsiBJKGFHtdnQrrqXJNB8KscHxWRmnJYYONqiAUZ/zYlO6uCPq7hgbFuFvRN1
	 qrO1u6AQpByHyOkjtPBLiokkT2T43ePG4pvNlq10wpTSIsM8oxa+RyxggaDYDpzt21/G9
	 ykVI88R1BicAlTWC0P9fEdGFJy/KTAuzSJt8mfFgTZn/3XpVtzwHkupKIw04Gxsos9PSQ
	 9BLRytsKK8t4Ignd8HN69urSodM6lPA/UBkV/q/1M+1lAujbw63aRhtSzYxEHWcCbfWv0
	 30Blegs+/TZzIIvPxVUr6lT1X+pp3iguwc7lncu3whRLMec8+6Xsu6VrlEG0E6duXOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ti3mIkkI;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20F606A32A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D20F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ti3mIkkI
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc751eddf25so2196069a12.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795433891; x=1796038691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uf72jF94qcU3idbI2020NJhdWUqwDd/ONaRN+2ot6c=;
        b=Ti3mIkkItoB1uzyh3L5WUUEz+MtHiX4+XGUoA2+v/RpWcSXi7L1Ty6bHeK6o3xuPxY
         F0Vj8jV9huA+/e/GdDSaQ0QFMvfDLlD5sLa9ctfzj4JZhFXCaI8qjWqF3ZbPtWmEjB+o
         ayR82fZrSNujQsZw7/zhxzwakgyVVhzzQVmc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433891; x=1796038691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/uf72jF94qcU3idbI2020NJhdWUqwDd/ONaRN+2ot6c=;
        b=uCntKi8Fi1QVa2yXaxf9mcM5n875ZgVdqu02Nsyc0+M6tbTA9MWFLFyQpq0fHY7nM3
         8AkWecTmb0x3omiEVZpbfKQ5Gxu2GxXpUUhQu0TfnuTO+FoY/7FG0Y2qhUhcfNxdjNx3
         26a9+BQakfyRd6f8ZcxT2z+/wbzrHBpQCsTIRlVOpJ6dDo9w67CQKK1Tp6ZlaCHwEqyn
         ED38WrJ0oDzsZyY39VV2wQtGBrZ0/etSzbKgMHH4ATXSNonVatEXentKWYzftVfoWNpM
         1i0b1a3PEfE+NNthshbxvAorjhc8CE5zVdQTpUc3QJroO00dy4qVHWnbYfvwVJomlUMd
         /lqg==
X-Forwarded-Encrypted: i=1; AL+hErFaW6KMGfwvlriXIqxpY1bakePjR7uu7tQXio40FgroUNUFypmLgl+19+7z7GQjcgciKR25xzhvnsw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Eu/B4KnVomOf45p8SlabbsyAxa1MxkNacD5r2trrtD3L0YSdg
	kXd3w8RdDtGcfCRN8RpM+3KuGOoeZ/jMpGEVW52pK0jNI6z/IkBlcBASr45FK2KPPA==
X-Gm-Gg: AZFdTZePC6GzMbTNpCmOzaY1jTZWJDmUJJeAxW1sW7V7baAGybyOxmGSGS7PEje4Vgh
	z2U33453WsV3H4JMGeMYUCq6l6Wevlrez1SCtW5NrPgHDDXB7ASkj8mtQVXd2yYcHNtdLOfkqKo
	YPe17Vy54jItY8ZgYuzc4FuxPMGOqGs+0+YlrvIyCebxuO5CYolkCqCmRJ6eJjpBjaqPNCV3l/1
	HXC0uS7p8Pir+xxnBT8yNiAP3Q1Pq98t6QsPGhn2hGaesE63FCx3EoxtW8tpjwNTXPbXCJYOaAa
	+69TWZ/PrlSBXGxOE7wpT2KCqDzC2mf+fTJy4wJsZw2greiyiJ+ZOE0TW3QtPUn2eH70x8EW0m5
	mUyBfLZwvUNLHuIgWEBZmU6QjguyQFQTkrw78h/IgYA+o8TPqu/ScnJ3NHTQiJw1ni8UCHd125/
	zPJrQAildkE3F7sLTulvNy5YxKqj/lUsXe0PQr/ZQkc2C5sEHL8SU+l+LyDBQWr4/g6IfERQx4A
	SLYVN1GPaLCeRTmlrqjDpsDj1K1ibTl2UwufcdXVD9k1/jDCAsrxcZuOmG1FqHE5YW82JKKB63N
	kI6YyziSWpzmu+DJwhNx08vCz5304+mai4lzA2GmrRsFt2wBAwi7z1/TEIUb
X-Received: by 2002:a17:90b:5109:b0:3b4:aed:d423 with SMTP id 98e67ed59e1d1-3b41c95ce8amr10439138a91.57.1795433891643;
        Mon, 23 Nov 2026 03:38:11 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:ceb5:5e59:832f:d16b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b41ad8ef99sm18165446a91.12.2026.11.23.03.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:38:11 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable stub functions
Date: Mon, 23 Nov 2026 19:37:53 +0800
Message-ID: <20261123113755.3033436-2-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123113755.3033436-1-wenst@chromium.org>
References: <20261123113755.3033436-1-wenst@chromium.org>
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

The non-stub versions of pwrseq_{enable,disable}() are no-ops when
the descriptor is NULL; however the stub versions always return -ENOSYS.

This would require more code to deal with on the consumer side if the
power sequencer is only needed for a subset of the supported devices.
One such example is the rzt2h_adc driver. Only one of its two supported
hardware blocks requires a power sequencer. The driver could be built
without power sequencing support and the other supported hardware block
would still work (provided the Kconfig dependencies are changed).

Align the pwrseq_{enable,disable}() stub functions so that they also
return success on NULL descriptors, acting as no-ops like their non-stub
counterparts.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 include/linux/pwrseq/consumer.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index d24b5af3e49b..5b3c61e963eb 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -54,11 +54,15 @@ devm_pwrseq_get(struct device *dev, const char *target)
 
 static inline int pwrseq_enable(struct pwrseq_desc *desc)
 {
+	if (!desc)
+		return 0;
 	return -ENOSYS;
 }
 
 static inline int pwrseq_disable(struct pwrseq_desc *desc)
 {
+	if (!desc)
+		return 0;
 	return -ENOSYS;
 }
 
-- 
2.56.1.831.g720f3f5937-goog

