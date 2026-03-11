Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2C3CEB8C
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222013; cv=none; b=BfN3OH74S2AGqrdrQC2RmbP4VuaIiOJkrl6Rq+IO0iyS1HFcfprfIJE+uSLQFGtfH2cPJ5syVVjYwmZe5C/NHcMAIHzTtCZ6UakFzwem44Z9HNjyCWg1heJ+bxrl96TuGwfMfnAkHnixpp5pIaImuw72z9sKs1F6cd4uYnU3bks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222013; c=relaxed/simple;
	bh=SRRFplEsKFbAFRqGdyHUgm7X6NsuA3Tx9Bq77gPQQjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaQh7MQ4X6c4vkgKE9HOar//bkAYOIqnU8Hae1dB/pqe/OQRXuhXQhqfcqE3ahbW6r2HRTEj9RsrYBCbRDsGQqYGLfWe0CPdd8HumNt41Yr1zByvSkbDR2SYpfZQA2NKd5V6QNiAHo4I23E90tw+CG5bmaJLmrsseDLluMmLlCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itNpAYd/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itNpAYd/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3599019ae92so5820219a91.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222011; x=1773826811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc+r8VsC0EfRtxbvrnGHnbvOlrJEDiMUk9lTqrhiJ8c=;
        b=itNpAYd/EyqZPV56oZbubjiERtrOhKmDB4lscXZNwt6JWarfBFdRgMEhquvyCzoT77
         pwOLGcedI/RcTpRUuQRspCSeYiSUXZObvdPser85VuwMJ5r3XAtusscPMlvUYFdBw+3P
         Ps+HraokGjFyqDiHy9aQB0pTxz981pF/lXnWSQz5aOz01MpdgKQ6uHRj3pTc25GP4kV+
         TbtSKAbbdmDixOyWCUYGfZs2vaw33iFR+QIwMDMXQfHCl58XtipU+QrlV+EJukC3xVZN
         0vF+EhOBDVBUTHk8WBJ56pLiBGnV0IM7YHOfRBiAHVKoN1KVGwPFQbiWp/8KRkXr7Qtf
         +sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222011; x=1773826811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qc+r8VsC0EfRtxbvrnGHnbvOlrJEDiMUk9lTqrhiJ8c=;
        b=pzgyrei98o8eHN8Jn7gA+19V3PWnpNo3M/4fKl0YXpBRvdAtdxUneH3/5SDd/h6XZv
         5fHNJpQiDjHu/Y1l6KZFZjkSGbYnPZWu33AroOX8VIZQXqhF6+3/WFic2ahaFROIL18N
         XPn2Ki1170JtNlsxGsjK9nQc/xFCrzuf+qndeKFFn2awcQvzryGm7KG+37HacX0vyA8O
         kxv/mMMd/8iY3cj83q+bZ/Ob5YBPlUX0q7eoEwnVhY5XzRyW1XdAn5CcwSHWvuKyVp8k
         m4aYDXvSx58gU7cuYe14wQ4CLsDfH/k5tdPOXeVwnAk4Bjhb+f3hDIoIlDNscUYP4Bgo
         O02w==
X-Forwarded-Encrypted: i=1; AJvYcCU1E7RDTUV+jXG3ANbdEFq72DxZfwzn1lgeAwhfNZ/rrZfW27M7KCGT6o60UQivVibCAqHX0aRM8b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9uyGo7S6hExLAIyG0lYGHu7HZkgsA67n2ErlTBHRHy/si0wr
	ktww9K/qXxZX+2XLbGusTvgYNUs0Mk++osb1qgD/m1ytIvyKHAn12+z7tOTqzw==
X-Gm-Gg: ATEYQzyi2DJx0MiBJNyzdTrWo+vss4Yb/WQk0AeikN5r8WUiuV3VoPpxZOLCuKGKTFo
	VPgYg29rAB8yOIR3GjAwdTqiEkSV21APzJbJWvlkDDhsdWDhrvhU2tl/kW/s1WJxT/y2E1byN+l
	1pLY81PC5jXfC2M1hjZBsw5wPilTDUgMIrDg7t18vgN7ZOZyBeXrD5V0Emt5MXbbgO2NTpv+vPQ
	sgiBVk3j9YCPUxrp/S7iNDWuItFnmyMHwEr8LwCN99b5k6KZWxl06ydc9BZHLyPjUnbPJAC9PyE
	nzSgk5p0csd88LxapFEeOODmR3/Bu3Rok40tjlwQ/3Dk/bpk0nNHVFxE51xQweCmkQkOxy7rmSN
	dl0s382ZzzfAqSz57eEIiixMMMotPqUW8/xTMhD/vFLpVWlK8fiFmNCh8AeWFWDvOeI06Eo31/k
	FKLkpz5qbSd1WHVxRPRAukV9khvCTlP8B4LV4=
X-Received: by 2002:a17:90b:1dc9:b0:341:134:a962 with SMTP id 98e67ed59e1d1-35a019e7e8bmr1764556a91.28.1773222011331;
        Wed, 11 Mar 2026 02:40:11 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:27e8:1c1d:af76:30f5:4937])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a022710edsm852623a91.5.2026.03.11.02.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:40:11 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com,
	mazziesaccount@gmail.com,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com
Subject: [PATCH v4 3/6] iio: amplifiers: fix typo Curren to Current
Date: Wed, 11 Mar 2026 15:09:30 +0530
Message-ID: <20260311093933.21333-4-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311093933.21333-1-i.shihao.999@gmail.com>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling in comment

- Curren -> Current

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/amplifiers/ada4250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index 40f396ea9069..71e361af2074 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -109,7 +109,7 @@ static int ada4250_set_offset_uv(struct iio_dev *indio_dev,

	/*
	 * Compute Range and Voltage per LSB for the Sensor Offset Calibration
-	 * Example of computation for Range 1 and Range 2 (Curren Bias Set = AVDD):
+	 * Example of computation for Range 1 and Range 2 (Current Bias Set = AVDD):
	 *                     Range 1                            Range 2
	 *   Gain   | Max Vos(mV) |   LSB(mV)        |  Max Vos(mV)  | LSB(mV) |
	 *    2     |    X1*127   | X1=0.126(AVDD-1) |   X1*3*127    |  X1*3   |
--
2.53.0
