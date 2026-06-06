Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BB313E2B
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721928; cv=none; b=JPOHon4zyZWEHeTJJT4DtNyarbUzmy1Hq8UUcho1aBVlGGzMZWx99WC6C75jnLeo3QSN8KZeogPduPct5unLBOFlxVTnhFHNBiIJxYaA/0xXAuF2rGG1MO8IlO3VwYnKFKp/vu2a3SF2PQbluxEpFhdLyNEb8F2Pof5jyznUDNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721928; c=relaxed/simple;
	bh=8ihLzDpqisj7RCWIgvP+oI6UBuVHBgOFSoKuiunQyxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l32Wr02FfUS2Tet3iEvmQtWwHcTfdFESrj7YDlYRTD1phTkMOMVfnLgncEIpQtLzuhg+Uw4ah34PXh0Fe0VJfUTIYnvIe5dip/rW9YTVVmDSOyHQnBP3jfo5k8WAtgCtRr/NdReafM57mVLI/gj/8Me/s8HAV+SvKbuLi72wbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck2telJ+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck2telJ+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec450b950dso372855766b.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721925; x=1781326725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMkYm2wLFurUx2dgxyb2h52E5PnRVf0UR593PbHgI/g=;
        b=Ck2telJ+fs74MtpcAOJeTy4O7AEBa7S8SvbI7OpYYhirYyA6IQTINVWse9cGmNGteB
         m9Pz+khqBVoefNt3pWHCLM/JJO/MYzuvVQ4ysjk+6IGfrMDUgGOTZ5zVRUfEUL7WFBAh
         OPTkXEejpD9sJ4B+SqdswG8ZzOD9DC0WzdG9FN7CSrGSiSPUnrIN2n7ahP9exY6YFOhF
         6//N9euZ1h1OTBVXq6h5UER+PRmnJmWYKSmIav2nGH/3w9QNGomZH4urpmqYdCye6znu
         L0rY5XFuVf69oYK9AmpsqfQru9MiW8v45eXo9kEX8QV1M1kp1K6hivKfWZ50b8Yt55J7
         hbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721925; x=1781326725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aMkYm2wLFurUx2dgxyb2h52E5PnRVf0UR593PbHgI/g=;
        b=WvHA5fIe9sIiM3eVqNFCoMxv4a4sz8rnVNYLBk8IH2EH/cvestMs0ENgVrBtt/aaGF
         RqEXGGUqwjowsqA9YEzP5H+4C42Kfvp5H85HUYA9T6Oq2XksddjzLglmoptGAgEc2juQ
         1Qp9eZbv9F6SE0p4SNc5uqDaYdVLHbOwyI0gRFOIqxyGKO+2BcuKIkFheFyTW2A7Xtuk
         jk4YFkSB4pXCboUPfwPG8HGIA3FCsknGOb+BFwaYtDSejRjDeZGSlouKHFXTAwW/8GM1
         kuAEMEW1Nnd+WIEojfEeEo7KGJiPz0mFwh6s81yMHKde5+LT8halUefOoxsv8uJOsPDn
         K0gg==
X-Forwarded-Encrypted: i=1; AFNElJ9+7oKDXTsU1IrDLni7+5tjNxLjKHwY7gWWOYZYJW+Co8wq/V/gJR6NI4pSWI7W5N7E0P9HSWq/xIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCuSAKgluRXQXI93Vcyt/jD0dnBk4eL1eGpoViU+t8UACGyjfs
	FQoTIGTqEghMxD2EOp2M/XIs+N1DqXKwSOqPf9jgeYEf6kCWNwZ8p9hN
X-Gm-Gg: Acq92OGxM+YLuihqscnkDIp93iLq+wTUaHvSjDo6Z7PoYHeSh28OAzTSUke5eHf5pEm
	nP4LFazd0IPH2hYY0/o0WxE7tbfhceNPMBsnnqRa/8YQUOOmRlJKFLcCOe+NWM3bDa+qmIYl0KS
	K/8lV16JdnV3qGHjYoR0DjR+wg9h7kpyIRzuvqweHjOvFezeGZcvat66GGMK//lsaVE4I2/g8Gd
	biyazgZ1MOG3R9V+u4zq/aPK/KI2WSP3hOQDYmFPBBum9x4EGOh0QLLH1k5tq768ah9csdhoyXI
	x9SmMMrg5Z1oJMrIE72wZtxoxTrtsCX7Qy5EsXo3EWCTHLHeflP59qyObPkC+/yU7pDUiIJzW0A
	IZREk/QRsxTc4kchQ61C+MMdt1YPF6hX/ZtKNmhIjK71dOBD918zhhVzf03nnJyYYI0+s4jlIGv
	EAHw6cOxlZAncx1WppQqcyJzc=
X-Received: by 2002:a17:906:f5aa:b0:bec:157:a630 with SMTP id a640c23a62f3a-bf3721598f7mr362897366b.23.1780721925345;
        Fri, 05 Jun 2026 21:58:45 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v4 13/14] video: backlight: lm3533_bl: Implement backlight_scale property
Date: Sat,  6 Jun 2026 07:57:37 +0300
Message-ID: <20260606045738.21050-14-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 4f8cde9f290d..2aa4b86042ff 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -142,6 +142,7 @@ static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
+	struct backlight_device *bd = bl->bd;
 	unsigned long linear;
 	int ret;
 
@@ -153,6 +154,9 @@ static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	bd->props.scale = linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
+
 	return len;
 }
 
@@ -290,6 +294,8 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
+	props.scale = bl->linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
 
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
-- 
2.53.0

