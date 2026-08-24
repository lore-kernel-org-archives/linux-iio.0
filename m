Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D434FF62
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 04:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787545758; cv=none; b=Plb57g/+RYsULm6RZ8cQQGdwgnU2FeO0u7/aiZRwANx4WzP5AhrIkvw6X4dC3D84Z0IQgunFjzETsV700Iq2jJGzIVEItWpIOkuh6HUK5VCky++ybHizjkCrTrtWVl2RKC0iW2ZxQ8f39uRJDTewoehsdoSrUwpST7FkfzdtJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787545758; c=relaxed/simple;
	bh=/twcXd/0jnN1w7iBOi6bjaZoEfhTahZyVkwOHTmRjlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoKMxSK69+S85aE7Od1HAz1oo7HcDipoTye/4fP+PA9rhgGNhM8e6KWd3Q6JXolNrDdcU2uoIuPmhkXr3NipdFSZly5T4T+JLy4qg/4/rZ4xC6SER4rQsejRNB+pJCzmxztz7ilG+UQLsstrz4EtQ4mzgB+guR9srvu+tM4YUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0QPcaBR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0QPcaBR"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15e592da74so420029966b.1
        for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787545755; x=1788150555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wjW91PO26FkPNJiludhbBOV42kX0uUO5r1dlsyzrGo=;
        b=S0QPcaBRKDiR5ab1fQu2nQnbsxjoBoFZwNoPbbG4GItnuzed6tfAZe23s0NOmBL0Is
         tTElZle0fjFnwggXC7IfU83uplg+ZKrRweQiCj5zHaH99ABHGE7yYUFz/dd5QBIKLaX7
         U/5XUTnrBomsKdsq+IJHTuAw8c4Uxp7WtvcEZ6f9kSdaOpOcF9xDjzf6+6gCesm5/aZ/
         wMHo8swxdyElBOOGjpeURr6/8vOCtaMoIeySn/vbeWXneQmyWNfErKrud2B/moW2ejwA
         2JmeeiJi17rZiHBy+yFePuLEoxS5+8RFIAD2XkLTr5T1srh/FvYNKgUcBYW1H68Oj8p8
         ChSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787545755; x=1788150555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wjW91PO26FkPNJiludhbBOV42kX0uUO5r1dlsyzrGo=;
        b=WECwO1tzVzJW8cZipNHht0/NyU3t5xqz4fa+CtAeaTqirS8ONen9WHrchPiV5j4avM
         TFiVQdqjFsrBxgL02zO1ClK+ItlhBYu1gHDe9GfMO8b5gXvPzuulAD/aUQmhG/MiiR/s
         WK/gdYKTlwqobLtP7zz7hj7fF/kVo17n3on+ApqyKef7Xo2nvy1Xtgdc6maeiMJlYyUR
         SaOcB8doa7CKAF8W8rQG9/jUVOBta9K8yaLs7Yq2GBO8VTy8RYFEX4xOwWq4WI1wBDa6
         q8IfwAGO/wFIhakVi1F2up3eS4V3ETe5ghzodwQc0wOFjNmiZJyGgDaFDbZEGKxVX6xW
         +EwA==
X-Gm-Message-State: AFuF++lUb8a2QWFEpYYO725csM6QpSM5F+egfQYZLx4CDk6Hyqcuq3MC
	mYg6fpHyH5cQU9+sqzedNUUDaQCpuZo+wtDsHA0PmLrxALEqbcm9C5aR
X-Gm-Gg: AR+sD12Ocz/2WHLbo2RiVIHpxceTp5dnbAwAs1o3+CKy6QtH+2hrH8+IKVhq1IIWu8A
	TEUy2h2dMzgtJHgyJRKNBgrn1GpHYJ9JM/RPUkO0AJIdkCkb0gwbjdc3HhgJZT3Gs53Zf1oJ/7a
	MTvXon+WkUikpD05YL0fW6bZNVPZ5HAJ/ImsYSusfOdkN782+PK4r2UmgfXjfDe2doGqWY+k7KI
	QDUwNwNZnY9xG8FXPTO5YCdFWSsN3M165GOR/zSGg06Ofoh2peggL8qYriwDT/gRinqxQTGOK3y
	vSkhgQo33NKxpbkaat+IuXpCyQjFagu/x5mRl+G8Gwm54Ut1GdKEu/DucMLP/E9oF/ymwg4hJzC
	ZCfQPc6SnXtDThlk4lleiYH4zeFIF8YItUgwQckXJdDGm8eAPliZh5YaRfaiB0e5ODFji0J3VL2
	UgSiCySGZZUf/gN8cimO782La1pBHu2Y5GQV26ZblLwO2fyC5GswM8Qmc3XOkBPzjsGBmHp/jIS
	g==
X-Received: by 2002:a17:907:8908:b0:c21:35d0:f435 with SMTP id a640c23a62f3a-c24924db408mr1804770966b.10.1787545754823;
        Sun, 23 Aug 2026 21:29:14 -0700 (PDT)
Received: from localhost.localdomain ([196.235.128.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296b8bsm973011466b.16.2026.08.23.21.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 21:29:14 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: proximity: vcnl3020: fix ISR bitmask check in IRQ handler
Date: Mon, 24 Aug 2026 05:29:07 +0100
Message-ID: <20260824042908.8887-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The threaded IRQ handler contained multiple issues in handling interrupt
events and clearing status flags:

1. ISR bit check: The handler incorrectly checked the Interrupt Status
   Register (VCNL_ISR) against VCNL_ICR_THRES_EN (BIT(1)), which is a
   bitmask meant for the Control Register (VCNL_PS_ICR). In VCNL_ISR,
   BIT(1) corresponds only to low-threshold interrupts. A high-threshold
   interrupt (VCNL_INT_TH_HI, BIT(0)) on its own was completely ignored and
   returned IRQ_NONE.

2. Event direction & channel index: The handler unconditionally pushed a
   RISING event code on channel index 1. The driver only registers a single
   proximity channel (index 0), and low-threshold interrupts should be
   reported with IIO_EV_DIR_FALLING.

3. ISR clearing: The write-back to acknowledge the interrupt only preserved
   BIT(1) instead of masking against both valid status bits.

Fix this by checking both VCNL_INT_TH_HI and VCNL_INT_TH_LOW bits in
VCNL_ISR, pushing separate IIO events with the correct direction and
channel index (0), and properly clearing handled status bits.

Fixes: 3363fbbe19e5 ("iio: proximity: vcnl3020: add periodic mode")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes since v1:
  - Extended the patch to fix additional bugs found in vcnl3020_handle_irq_thread():
    - Corrected event directions (RISING for high threshold, FALLING for low threshold).
    - Fixed channel index from 1 to 0 (matching single proximity channel).
    - Corrected ISR W1C clear logic for both HI and LOW bits.
  - Updated commit message to detail all IRQ handler fixes.

 drivers/iio/proximity/vcnl3020.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 7f417372566a..d0b8f429999f 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -584,16 +584,26 @@ static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
 		return IRQ_HANDLED;
 	}
 
-	if (!(isr & VCNL_ICR_THRES_EN))
+	if (!(isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW)))
 		return IRQ_NONE;
 
-	iio_push_event(indio_dev,
-		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1,
-				            IIO_EV_TYPE_THRESH,
-				            IIO_EV_DIR_RISING),
-		       iio_get_time_ns(indio_dev));
+	if (isr & VCNL_INT_TH_HI) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+	}
+
+	if (isr & VCNL_INT_TH_LOW) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+	}
 
-	rc = regmap_write(data->regmap, VCNL_ISR, isr & VCNL_ICR_THRES_EN);
+	rc = regmap_write(data->regmap, VCNL_ISR, isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW));
 	if (rc)
 		dev_err(data->dev, "Error (%d) writing in reg (0x%x)\n",
 			rc, VCNL_ISR);
-- 
2.43.0

