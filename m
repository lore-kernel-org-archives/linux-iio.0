Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FB51812F
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571302; cv=none; b=GZlYrX6vp9hcoqRrj9jmNadX58gvl1oAIVz8G55RmhcYtBxMqv+PnYYge04+TuWsYJZDbvBqbFHdcRuEEn6Rf0h+RGeYowHJA+gS+9P0+uKLvGuNc8fA2LueAKvjkHmB4Pb+ODeakdUAslUPjnoK28uq85t7EKZs6rSRGR3KDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571302; c=relaxed/simple;
	bh=m2hW86t73Z61y1E4Qe5OIGQnu8oxYi3FHfoxX/depZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZFQF3ZsE3wWd4D2OpW0vwi/hNix6P2SNpuRsH+/XmIV63WAQvfZ1IRiSsahVwRtr7P8qSzycA3tSeAwdbNH3l2I6Ejmruqh0dAt2beFnbbEchWI1Y33e6XU3YaPP2ZuVcLQBwa85fiEBUI9al2PoTCGY6eFdM26Xyk9y6ooifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9gVdX9r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9gVdX9r"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a168355946so2046995e9.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571294; x=1792176094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tW9nxfGnLz8J5bzFvumGC/5zr3/WbJDa5A5l/9bJW1c=;
        b=V9gVdX9rbLwfx31mTRZ3kya0qU7XR098v7EAGl8PsSteqrN8lbJTlTTRtr+cWgWJwQ
         wnyz+Tzhb5M/AL++Uxfhb8srY9MXOlIQaAr9jNcus6qIkGHM14+F6t3ICT1jN6pkhYNz
         HYuMrH8lspCMrCV8zzilfDSwGtss74Qr3jG3m/SJ8edsNp9feBIoh3jOgyIsTBIXOQNl
         IN6keZGTEBrdqM9WCLeM5W2OZRM84nIsezDWG2icXlDiUvEoKTRsF5gnW04hS1MenWE7
         KhHdFCcA4jCa19k3B9NG+u4pygxecfTJljjop+O6Y3Jw9n14oPoYVTfzthv96NeVQv3K
         awBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571294; x=1792176094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tW9nxfGnLz8J5bzFvumGC/5zr3/WbJDa5A5l/9bJW1c=;
        b=c6AKl3mIg3gpunBUAa0lSlL7/IZWNnt919mIoOnvESbibQ2FXy3DvSjMQ6V7w9gEnQ
         3L9UBPD/MlOkqaKteZtMrffgU+710icthdqffmotThEb4sQ45ygzENwnFyQsXevOh5aZ
         P6SWcMyjVLrv4NnPTHcE7JrB2szmlB+tNX8D6v660qsLqpC5yhCTQHFPJ2piMlr+WkUG
         JdQQyKZ8BKY4QcxDFNAoG1he4DuVq/j5d1EJkmLfUpyBswO8r6JuUdx4neQkcgAa/PQy
         jw7VhiPxUrz0idcLltl3fo1eDhaHXAA19MRu8oBXTOCYEDLMdPPS7JuDyPC5gqdrHQBN
         iqnA==
X-Gm-Message-State: AFuF++ke4Djay2q5voI9beaGhNoLQzu5D6ZY/rgXUTMap6DZ5zDE++h7
	r6W8zStsNJy3efow7cxuV5uXMPWc77M9AxYky84L6WXJpFP6evTNAweY
X-Gm-Gg: AYBFou1qFpSh+dxq2ptge3+M6HzaYl8h3i/1t+p8tMdMoJjGk5PbO39PL/9bzoQj+Ln
	AoHKgO6JR/JBEp9imHIURh2BX469TC/JXP3LVYslBpxr9DvTAlIuVKH0AhdlmAYlpKgYL+6rRKn
	bYS/DmxBBYvsFYTE2O62rhV0GHWzXxd1VVtcilm5hNA4/lwxq76hE4Xp5xVVYZE525iDLcueamU
	3BEsnpT1yPWv2cy0TwlDO6PvEi+Guhh/M2U2QM5P8/gXg6RUQjt6004hypLBb+kvvK7IEBPddxd
	SGiKIIcHuTav1NXSVUv73H+kHHDcZdjvOa28osIAPgnbW6qoY/qozJR21WAZ6/re0ZGTO04DAf8
	npomv1QRudKruPPNYGIqaDxuToydmcwV3fSntRscKZ8Jea+a3W6BPrjYp6dVRYZIRhji2CHi8PP
	0Uecw9mMwYL1Zv9uwC1w7v7bdoORsZOUXqC+tTscooKics+fkpcpseNChzcyM7VPlIVyPaC1/tz
	Yp/R1kMZBjnitu4Cq+cRxSCvdEC+cavD/TGIVaykGsWHrMGPgzqhz1aMV/kPfLayGgIZJDfH0yd
	1y+ZSeE/MZQYiBxKMA==
X-Received: by 2002:a05:600c:8b74:b0:4a0:2847:b6ee with SMTP id 5b1f17b1804b1-4a18e4fb8c1mr51194335e9.35.1791571294101;
        Fri, 09 Oct 2026 11:41:34 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4225f4sm91761705e9.0.2026.10.09.11.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:33 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 6/8] iio: adc: rzt2h: Prepare for SoCs with different ADC info
Date: Fri,  9 Oct 2026 19:41:20 +0100
Message-ID: <20261009184122.1378797-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Prepare the driver for RZ/V2H(P) support, where the ADC supports 8-bit and
12-bit conversion modes with channel configurations that differ from
RZ/T2H.

Allow each SoC to provide its own IIO info structure and use the
chip-specific configuration when registering the IIO device.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No change
---
 drivers/iio/adc/rzt2h_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 9f027d524997..041566f3059d 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -68,6 +68,7 @@ struct rzt2h_adc;
 struct rzt2h_adc_chip_info {
 	const struct iio_chan_spec *chan_template;
 	int (*sst_to_freq)(struct rzt2h_adc *adc, u8 sst);
+	const struct iio_info *info;
 	unsigned int num_channels;
 	u8 features;
 };
@@ -764,7 +765,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 		return ret;
 
 	indio_dev->name = "rzt2h-adc";
-	indio_dev->info = &rzt2h_adc_iio_info;
+	indio_dev->info = chip_info->info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adc->channels;
 	indio_dev->num_channels = adc->num_channels;
@@ -779,6 +780,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
 	.chan_template = &rzt2h_adc_chan_template,
 	.sst_to_freq = rzt2h_adc_sst_to_freq,
+	.info = &rzt2h_adc_iio_info,
 	.num_channels = 16,
 	.features = RZT2H_ADC_FEATURE_CALIBRATION | RZT2H_ADC_FEATURE_SAMPLE_STATE,
 };
-- 
2.55.0

