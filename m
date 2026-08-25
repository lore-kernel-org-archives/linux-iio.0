Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113153E9C08
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647956; cv=none; b=JQdzFLsUPpfnoJ93KOhPGTkY4FV5hI+g1tN86XzbFauiHk195Ex1I1k1IHfY2h0ncHgHXPAytep4he4lNVC0KD2Xkk/1uEvLXnq3Gccu/URFTD37ixRcfmdo6iQRWnRyyCDaxdliipHN/0PSHuSvaAytBL+hJO+Is71gpB9+xC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647956; c=relaxed/simple;
	bh=BOTNlYapMiABhZgQe0I0QMEYl4Xnxo0DQZXWMi8S8l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxYTkaEuqsihG+vm77dOF1+3ekqtraJ5mcVJ6AHrk6gu+Wac6TvfPoFwSYh5c9pmCus/1Yb2BoX4W8MOi8e103/x6EoeeM+59mblhhHcsRScfZncBmfFQs7NWeaaNny56SW+x2yKHVNZ9BiFCyr+eKvZxgXGlQ2pCcsEabVLrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPMVpLLA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPMVpLLA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so181695a91.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647954; x=1788252754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrZUTcKkClqO90iogm2znVhlvjPPwZ7DuB3jYH85axk=;
        b=jPMVpLLAgUWHKCItLQkLvXox+SI0H6xvDN4ZfCV3OwimmRciOwAyAyxrEdtlJ7PM2I
         LB2I1JlPRxmKPHzPgjF5Y0am9XwzUDHAKCvrONP/oivzTQPrQHVxblMcaw0xrZP6LSPs
         hx9l/8MkkRfualm59BVOBzfgt1FLlR70FXwr1UyTRQV79zqIhIz6DcAO7PsxWXDD20Nv
         R4VsR6p177OaUg8TBjngR7EO2Dqi//OM7mGHKL06th5PfNqZ8vgBqAKj4OKyyKMfJgi/
         RqgATy8GMGTTTPbiIzJOLBYY0g1AHnTT1+q2XCcuacDhciKcner6cWTLkX5SbRsY/y7y
         P3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647954; x=1788252754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrZUTcKkClqO90iogm2znVhlvjPPwZ7DuB3jYH85axk=;
        b=BV3rmdexWfqzL5zAu5HHZT4jpBK++IsZR+QEnXNVzlUrUFSte3TRkuAMNjoNGc7PLQ
         5vniuwL6dT+P1c4ZlDJNKd+B1C/F3Jp659KCz3hr2HcNbu2fizGpJYWcRqdP2WPhTNIx
         dk9Dw3KZjtXb+wL1PcJ1qfekwrnW/FWav+f/ouyFE6FKyC7N9w4ZcemUo5Jlvqjk3ecR
         88aD+BeWDC0rIJkyzub4lf7+uta40V8jSpi2O8Mn/LVXvPpbSLAlGSDjtGLm930pntmC
         x7ySa0cXo5JZdwRj9B3odOw7gjVLd9KF+TkuCyuXGg/wUgG1ZIQI56C10d3HSrrM9pFM
         bT3A==
X-Forwarded-Encrypted: i=1; AHgh+RpgOI/L9t21I7CGFy8XyR2F0jN9UjZHyKAstAKO9Cp0ODLJJQgVTBP0w543SWBlZBQLNaAPUCxbtjY=@vger.kernel.org
X-Gm-Message-State: AFuF++mxRD0EZpzlHgXk8rexJRGuvaJpY99Y3NgBl09iqQzoI9HNalz9
	upX76ltJ7fnuHyEpLbnWx75fdWQ0Qv1d8FIY4dZuoGyYO9r3vvDdKu86
X-Gm-Gg: AR+sD119/6TSQI7kIXs0+9fUAgiU+8Gj4P4TCTUR7BF+QVTQcSHml/wYGA68uhgY8C0
	CE+gOSzpOBtnpY7bflerMtPsKyycerZo5fiWmFai4vKFUDK31eZkpyoxNZy635zBujz7NC4ye4E
	6Q/HOMsocAk+kNxDX28D4O9nP5EeAJgOjRgHxpc9TeMU49HG1b3DrH0EO1Urt8woF65KBPj/LLX
	41eTydCsZlnw5BFi+OuTmdocdz8tJba3oNCgsd46Bgwwzfdc+CAjg2ql2l+Bx7mYU/2uT3JUcCQ
	JXGAEObssjUmq1a3Y3KNqCrpLXWg6Wiv9Fb7WHs3c7JJ67NjSZlGRrQOr0idsOZZ94ctb3AVhVS
	HNSenhueDqNwngMKzN1Ac67mEzwSnP7mIR0qBzMcWdZaGZsNljCEWCBg60ixYDImoG8+Odb/EBr
	FJm2FhIyWwKoP0CLIYXOryqwok+uBT7YCuNqZQsFII+GWlyiVSHB8zAcT3VUsv7vbT2L4A
X-Received: by 2002:a17:90a:c50:b0:396:4729:43fa with SMTP id 98e67ed59e1d1-3964729461amr6906207a91.0.1787647954324;
        Tue, 25 Aug 2026 01:52:34 -0700 (PDT)
Received: from shrey-Mi.local ([106.51.251.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0a59sm42032202eec.9.2026.08.25.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:52:33 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH v3 3/3] iio: accel: bmc150: use iio_push_to_buffers_with_ts()
Date: Tue, 25 Aug 2026 14:21:56 +0530
Message-ID: <20260825085156.212042-4-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825085156.212042-1-yashsuthar983@gmail.com>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() to allow source size runtime checks.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 4c98f840e626..e487e1b9239b 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1008,8 +1008,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 			       &data->fifo_buff[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   tstamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1193,8 +1193,8 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+				    sizeof(data->scan), pf->timestamp);
 err_read:
 	mutex_unlock(&data->mutex);
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.43.0

