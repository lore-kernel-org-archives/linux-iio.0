Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056A4657DB
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521474; cv=none; b=h1Nj7KBWw0FY3pgfaUUVhkBv55j5m23JjFLmB8sQb6wtuq026bU6oZFN4PIIO1XFHv7vfHcDjXhgVZ4R570nkeG0O1d/ruCCZSRHGRF9LZCaHHuag8phoaY9FbaNCxn4P4Dtvfv6yEIjyNDZSktRTwyui5V0dzROAU8B8J1EsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521474; c=relaxed/simple;
	bh=IVD+qBGZZ/GjO6g2hTpEXXLZnv5N5xqfsYWehpQZHzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbkGxwCU24OlIEfLVSKP3E4U62It6vvcagVmYJPcmqs4YBfK6xWPYlP9uFcoNDY2JKvoyJ9wVGW7i8NRwBcwb6kOO4uew/yEeUX0OsYn20mLX4BTRU2G2+nwIeqENbRyrHHLVUKVlT78t9ZtXS0cgHZqAWLgEFjY6F4+PaeqYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/PrB2Q6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/PrB2Q6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1992915a12.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521472; x=1779126272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/3wTFv2d2fAYJFYqZwFfZcPNj/IS/kHh6I2keoXaaw=;
        b=J/PrB2Q66jKKeMpvA5OO5OctCURTFS9gcCjig1iMjVjVk/ZT3fc+0RPgrdPhMpI3XT
         kUlaH1MEuhhttPkNL3C9hU7ACxm7mk17LkRcYsSng1fcjjBB97POFBx08Lq/IIXLbKsE
         pw+U5w6onZS5r7/GtXFYg7voMxVCcVxfIBztZ9Cy+n3wLfgtWfH24GENQdXp+8nmuJ3K
         /5f9HPNbRa5lyrcA8BVaafRKMjL3Y2RPys3LIQpA4MfXH5lEsSd4ogmMToD5YRRiitVP
         XeY9G2CJxj5ENpadt8eMU/gE3PfBsD9kynA23JG0eaQB3M2Y8EBVw30qBVbiGvehGqrL
         KiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521472; x=1779126272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/3wTFv2d2fAYJFYqZwFfZcPNj/IS/kHh6I2keoXaaw=;
        b=Y2fJPqclMU+HYMtAo0zacxmDDS2I9nN+XaRd+aAqugPR7tpDGubK2j8yH6ZhVDK0Np
         78SJDcKuYTtqumkDkmEsTAItcWWU1B9vKIBROOquQtt3Tdu/jMA4ZFmPAlcGLXFIjn/S
         KF54rX9SK1IR2PHAg0p45yxx6iyOmM9OfrenROENzLnmzU28UWcLWs1uRFzp3Rl0CeRd
         D0g7k6G9ZNPhjgF0y6CwHktNE2SSNNBYX+IUA9ZnUcJryfZbpvu4E/hsD4YE5BEgaiUB
         tANI9rNMboDLEx263k8+cVk5bmxX79FkF4qES3wWkECxGDxd570h6ZIick0WsZHkMrng
         +wTA==
X-Forwarded-Encrypted: i=1; AFNElJ9jOYtT6A5lSh3JbXtMFaimT1k1ytbE74Bx4L3DzbJTgEP/LtRV+9ixC+qFGM4XlIGLZAR8oXpcE5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/VCLvxDDTvKAUXu+jBPGGfyfDo7XCQRkcVCMH+2L+u+ivj6t
	W9asIPXfkZmWQ26kHYolLM00lXQhlRxHkuO8K3fFdApDHQ/qY1MtFH2G
X-Gm-Gg: Acq92OFEp9aO4P3X84fQrgBns2EnFHAITfRwDq0Rn7WI2lKCeJVnJb+y1HZ/t8b2gr4
	BBSliGc0FdorGObIZCcYvmf+wgF4z9XZJvxhx0HX3l7NzGsK5XiEKmug+EwqhXqex0MOl6wkS7J
	orohpxRJH7qWx13KdAC1WjlXbryBRFVmShNM0qy+ha2iK0ef6UvAtbEWSHNkvLx6VfqGc4yonOQ
	MYFmZHzKJgqH5xeZ94vfJL3uvoIUhzF6cEbGo9d6+lfIRuWZZm2JoTCmWFy+NGwa+DW2dD4pyeO
	Vc/xHAGUE369bW0XivyPfziQpAqMnD4tldas+E11SCgNviAGkhKuaCGy3rqvltffCL8gTfCGo4o
	w67QylZNo8BkJM2RtYts0sF877Uks7w2lAeS/2SkPkSKvVMLeVFMMIgR0/+6flMA1Os5bVnfPFY
	Om+3gWAu6w03xDH0SdYkpxnkqecvdVUJcIzlOpzG1fHGafsbl7RARYkvQncxboci/YNC6wsm8Gu
	PgiN6EvHPyXbyXMmUUm/M5/eqK6yUsXg6sF+OyH2TNGHi+5rHWY86N6QkBy
X-Received: by 2002:a17:902:f78a:b0:2b2:4cd2:e16c with SMTP id d9443c01a7336-2ba798c165fmr245635655ad.20.1778521471926;
        Mon, 11 May 2026 10:44:31 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm106838425ad.44.2026.05.11.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:44:31 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org
Cc: ak@it-klinger.de,
	andriy.shevchenko@linux.intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 v8 02/11] dt-bindings: iio: adc: hx711: add VSUP supply property
Date: Mon, 11 May 2026 23:13:27 +0530
Message-ID: <20260511174342.123820-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511174342.123820-1-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional VSUP supply used by the HX711 on-chip regulator.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 1ea60dff98d5..a8eaa1f18de5 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -33,6 +33,10 @@ properties:
     description:
       Analog supply voltage (AVDD).
 
+  vsup-supply:
+    description:
+      Supply voltage for the on-chip regulator (VSUP).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
-- 
2.43.0

