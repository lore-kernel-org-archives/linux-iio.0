Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCF374E74
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607308; cv=none; b=Lj5cvcIylyP/vKVKX6UGsuCH+01SmvMaeMNmVKEdaxH/KBEVBLWimA7tAfNA8V1bgJlO6Xqi7/DBPC7152EFakYz6XM+qHKDqrvcfaTfLa7wqhRXqoHNwOk9odor0sGVhStWfuPhBQ5rSEsWWyG4VmUeh4DCD4GdXzdqPLLLFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607308; c=relaxed/simple;
	bh=d+k9bWJF7pvlGsLUQXb4Rg1E35L1IAdSPliURjFA/nA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X51y/x6G1RSX0smQRJiYsDGfRKlGjgK3J4B7/Fw2GpURm5LVIRBSTddaEZicE2qVrpstm73eehWSBAK4BQFAzkV01WDocgW5J7P7y0yRsR1M3vhonVXoHBlJkUPIv/FcCtEHiD8HlKcihN315yR7H44+MKR4ZFvs1RKdGfLOed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx8xWm62; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx8xWm62"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so566304a91.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 00:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786607307; x=1787212107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BUq274rbkY/de0NQshPMZnhY2Hc/sgHkU9E0uVLM2FA=;
        b=Nx8xWm622GpF4EKAUnV9cbT6yq+esUFKbTP2eY6AxOMBXsfCLJg3F7T0dQRfktFMyi
         2yimu3w8kkPIXkwzvkz55pwRdXTEST1EWpfHL+jUBJgSM1qKq1dY+P/95UKDuPosJvmr
         1IMhIhz4OGS6QCQyL9ZoUlzrHaFIiy9AIpNTxxgeuCF2c3NfveGiwdiRKelEe+MF5ARC
         eg6qpNwi1Q+tjD3QVsKfRyk4SDMe+jx+oxjuhMIoaSVUwVd9Mg6X6HwMR4H4YZGnDxXT
         ck1Xr/a5C8/iC4Ywe7ZKLFjVFuxwaZcp25xEjtJEQ7cpWo4VgE8EhroNKOlrSl1YTZh1
         MN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786607307; x=1787212107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUq274rbkY/de0NQshPMZnhY2Hc/sgHkU9E0uVLM2FA=;
        b=m0QmKfUaY0UGC4j3jmQyqvYCSKM9Q36lyc5Nfr6EHFr0XZeHSlbFJb/9aRotMWD4Zx
         40gkgDzKGpqc6FJGkculm/exIqBnpJ3G+H8F5raG2nioQV59/MWqGnmIOIr9UCazdHKN
         IV3VasP+uXQuXFXdzi5/vsUP6EWUbRdiq1RYN+K7MoVJenUqH34VMOQQ9Z1jz5WMNLdv
         owmUfvTLOEqCsH0KCWckHEEbh6+JOW7zNzzIWDCIDQYBwnDeQZk6MW+5pm5jH5o0wFOo
         sS9G+LnUzZOdah5uTZLpifDZmAxvBght2eW7Jos1IXT5i8eEykSBM8yLMu6HROnBM5tc
         RacA==
X-Forwarded-Encrypted: i=1; AHgh+RrRRhSrLbUrC15IGwBLXqKiFXBAYlMAA8mrbxomnTaRPWxOigNDfDOSOvpOtrxOF87cr9DNwqnjHws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLYzxHYt64/67fOT3y/c8PYVA17XLX7QDo5Gis7WSrED1JR4k
	giIYT6nCHvnPXb0lrR2ZtFOSjjvGaDWwZvBDbomofLH0JqRiqUJvC7Wc
X-Gm-Gg: AR+sD13tjg/05a8yPYPvMnLHGrpiHMEn0Wgn8lSNBI+v12snRLcVPe452aXGRdIy8R3
	Mizil8Y3M0KDPXVs7Yo31VEXnHxoHHqNVJDQbIYlWSahtbv6IUvKW5JwRxe9x54vIJ4Em9ikQ24
	4PJH+76a7XpAvWaLqFpZaEyCyPMnFwH6SaA3gq4S/GMDYapz5JFNNTNqtVTp3JpYcVPCT2qaJB2
	MXWk4/6V1G8D7nrfjnirELRlTWi0CvmfRkUlPLKi370rDm96OdTX0HMLbVVyOe6xI809kkqSan6
	J0GSNKK6lgg9b+y23kzxS2EXwRaUrvoL8QQ6cduw1FqTVgBIk1nAV4+kYwLbjkTgzl3Y7lx4ddd
	qWnPPNvkUVDZIPGHNoFS6SArokP1WOhZ2x6g0nM8QrshXq+r2H9R/ZYRh/Lz/N6cjlUjWNawwoj
	aJDGhNIdwj0BxTgH0qupEm2fcS3tzoHOs3VaeR3eO2kmklM2Gn4ofb8oXyjjoTVEk7KFRGkdyr7
	CF+Xpm/wIkNvi6mygRb0TZru/u1aC2nj7PK8WzuJyp3xvJU4Pn8INaHqO2dv3nhX1hx52pAwNZ0
	FlNG8MNjQ/ijx0Y=
X-Received: by 2002:a17:90b:2790:b0:381:26f:8f05 with SMTP id 98e67ed59e1d1-3931dfe502amr5239141a91.3.1786607306550;
        Thu, 13 Aug 2026 00:48:26 -0700 (PDT)
Received: from phuc-desktop.. ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f41cf6csm1771442a91.9.2026.08.13.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:48:26 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	nuno.sa@analog.com,
	Chen Wang <chen.wang@linux.dev>,
	Inochi Amaoto <inochiama@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	u.kleine-koenig@baylibre.com,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-iio@vger.kernel.org,
	sophgo@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] iio: adc: sophgo-saradc: Handle errors from optional IRQ lookup
Date: Thu, 13 Aug 2026 14:48:10 +0700
Message-ID: <20260813074810.27574-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available. Other errors, such as -EPROBE_DEFER
and -EINVAL, should be propagated so that the caller can handle them
appropriately.

Propagate negative errors other than -ENXIO.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/iio/adc/sophgo-cv1800b-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/sophgo-cv1800b-adc.c b/drivers/iio/adc/sophgo-cv1800b-adc.c
index bdc3e1326a9a..c6eed09acfcd 100644
--- a/drivers/iio/adc/sophgo-cv1800b-adc.c
+++ b/drivers/iio/adc/sophgo-cv1800b-adc.c
@@ -182,6 +182,8 @@ static int cv1800b_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(saradc->regs);
 
 	saradc->irq = platform_get_irq_optional(pdev, 0);
+	if (saradc->irq < 0 && saradc->irq != -ENXIO)
+		return saradc->irq;
 	if (saradc->irq > 0) {
 		init_completion(&saradc->completion);
 		ret = devm_request_irq(dev, saradc->irq,
-- 
2.43.0

