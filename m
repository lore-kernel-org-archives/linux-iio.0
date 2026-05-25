Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691E125AA
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673630; cv=none; b=lH1hWWex6Bn7WRyyym1DL8K2fQfNJjIel5a4zS+ZLBE/AcW7oDMjKqFFXqOQi64pcFyvOvusP0YfntLkP0ROmq3kCOASqz85kd6wexD0vfcZg8qYrMZ2Xk4M0LPVxIrdlwAJhiKnbIbMmb8QwwdzsKf3RdDwVx9Xd+SaqpT5R0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673630; c=relaxed/simple;
	bh=1GvdRYTbe4ysj0bbOqJt39+jueckOj4wJjySGOcUdLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIv8c24wKeACEZR9INdmOEdpKAHC94V5lwLv3T3BeannN02MQH4PybGu/Pc1rW8AYt2YcSoT/tzfKJMSQ2XTe3ztAI1pVS6unkvA8WpTwaTQiUgWfXPy7/Q8I3TQm4bPbo+45p7yc5KDGb4EtciotvjcbLyvKakMkexv75fXu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kWI0WA1q; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kWI0WA1q"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4855e69a5a4so1204599b6e.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673628; x=1780278428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl/suvXhKsrJ4+KHwf1f2NduFgl57g1mFMb6s3BomEY=;
        b=kWI0WA1qsD6jiz4KVAVs96OS3ELMI3ciTkRrPgfc9Npia2puvJjytMWxDtgZl5HXDl
         CtkvMFe2bC/kl4hUmk9BMZC+enlCl6c2jBiqY0jIQvcHFe8vCy2sH90ODX9OutOo7Cwp
         zP7sZFuYTJTrCjPj0GbuMLLiec5vYuFupG11smI4cdkkdDfKMLr7iGgr/NqeLLBWFl9u
         SbjnGKlmrYut0tfgXKLW6nlvLkfEH48JgjJaOtjqbjBo2ztqGydlOhdWV0Cuvo1memUw
         g29qTGmfwfC3Mpt13WT/mKfiYmI0DynQelEPKmwHsOPZAHEbRbGWzxW5nSc0leYMhU0W
         7ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673628; x=1780278428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dl/suvXhKsrJ4+KHwf1f2NduFgl57g1mFMb6s3BomEY=;
        b=tTK1yilnawW+WgqahndPv3N68tLwmG9XKdiiXa0FsZ78f10BRoVOrrJsL9fJb78ixx
         Ilp8lSCvrGBVSTKzxNLQwQKV5rfZRl6DAXLYhQAEjzF/JTmtzreT9fSTxechzwCfm29e
         iwTxJ4KDpKQZweSLst1a7OtGTRXPs+kJCjIF8hFZ30o3nBs/1oEbamw0tlzk+26ik18H
         rjmC9pcchh/eQFNEr9J2PVGSCWvWpdTasPmeN7oH7f976d0tFe+Nj3Y6S1tB7IKuFp1b
         X/o0YST0iip8Uwh2gDOOMRqul98Ys0ts+wyEJ8DiM0gzqeCvlNaNN7fw4WFjmfn0/P6V
         TF6w==
X-Forwarded-Encrypted: i=1; AFNElJ85UhLuGSQlpWQxAo3PaUEfYzVTp2P+H+dWCbn8YQlyJxby3CKeDfQZuWHR/WKT2zV9YOPBJejj79Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fIHyGt8JtL2HeqilR/ayPIhM6Riz0tauM3VCfNx8Z/aBvPlv
	IpJlXeXhi4XirQdONnSxs0x3Wdm98L80tdgHaBSPQl9ZZzgvBCouI9xzxl8dLZVb+14=
X-Gm-Gg: Acq92OFFPNs75XvU7oD/kvMuw9blEGnSW+TjqFkkXssC2cp/vA3KyYenLV392553Dce
	p2+6AdjjMSkYd3Uenhr9ennu7sN0MaAgAE/UGrMCo+V2Qtk5lsAhqvUwsmxLtFGi8eGbJ1Abz2q
	s05T160KDk5UTs67STrVd4az7tMXwyeFhF9lQcksVWBVV0LTYrsJCxUc92q0VWmAQ+5uXrPt8cW
	U+aBayqflUReqUYe6IxwPCMtU+5ewmulpr6xy5cWx6AbqVyfLmbToUzjOISlVOUZTvj3dw1B+ag
	HqSXji5Lum+/4g+MkE0cdFscMLrDZ8kjhPqcphteDDlmBYvUzxl6URnIbrgXdFd3exGIjpqNrLm
	ZpA6/7pNQQX7zRAtkIPYhSVroZxaU5Vy185ZilPMWiCimB8CcB0eoUR+PyE6LDIOx0kQh3j2yaQ
	Y6L8TfUve0Ms8HaHbJtge7s3ZV6CzCz6H+1+0n
X-Received: by 2002:a05:6808:4fe7:b0:455:f0e4:4f89 with SMTP id 5614622812f47-48549cfca75mr7320262b6e.3.1779673628014;
        Sun, 24 May 2026 18:47:08 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6350ad38sm9263431fac.1.2026.05.24.18.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:47:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	chrome-platform@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] iio: pressure: cros_ec_baro: simplify timestamp channel definition
Date: Sun, 24 May 2026 20:46:52 -0500
Message-ID: <20260525014654.2399354-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Also drop obvious comment while we're at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/cros_ec_baro.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index c6b950c596c1..6cbde48d5be3 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -170,14 +170,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Timestamp */
 	channel++;
-	channel->type = IIO_TIMESTAMP;
-	channel->channel = -1;
-	channel->scan_index = 1;
-	channel->scan_type.sign = 's';
-	channel->scan_type.realbits = 64;
-	channel->scan_type.storagebits = 64;
+	*channel = IIO_CHAN_SOFT_TIMESTAMP(1);
 
 	indio_dev->channels = state->channels;
 	indio_dev->num_channels = CROS_EC_BARO_MAX_CHANNELS;
-- 
2.43.0

