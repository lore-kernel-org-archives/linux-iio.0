Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD137496D38
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398989; cv=none; b=tipD8LizGGeyiXDE5/01mAIo7RPQZqxbKsiUWsVDe8yHGlqBqKo0lNX0q1kq+6K85Sko8Ry+Jor7/InBAK//Af16cTByvWEp9Q86vg6bDlnKWaoUnfm22nrM5hPDyFfo7/4A6xjehfw1/46DPRqvk9cxqgNAKya8rq3PPUrjM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398989; c=relaxed/simple;
	bh=d+2CDp1jet7eKB3vRWlqv+IkY6TyHU2QZVehe24BODA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m21NB/giYk+ykMOuRiiC6DSZSq11bb3GilKMeeGKrwrrMxVoaKshXxnysKW4tQZXvDc6i6VWhQBLHGYWQZ5/J2WP3ds2m8/VPQYH+o1QmfzqKz7rC3g1W5LVUjQqsAVnGoWdr+JVS4QM0NEl3hvgjWLFKRloib6tSwTfD662PJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaxISxEP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaxISxEP"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c423b145922so144539366b.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792398986; x=1793003786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RwY9VfyV3uydu5UUW7T5oMK7v8+2fcAFPimmhllZwag=;
        b=UaxISxEPIxNXzoTTdWGeAy4YG8wqaWUEHjpgXbSy8ZDzFbZiBNMZGgdkq/+RjoEptg
         0qY5Mm5lfzZIaZdTTDhAlJ0JdNpwMtnPHNrgw0u4pNBcSZqjJle+XyhUZyBDGJuF2oHD
         emNfHGRA5/M3FLs5a69XEdrGqsafp++emNzTFeB23XRcTKNKSA3GcKZYJZSCLKLwviVi
         TCZKTKBivVRRDccQUvs/yuv11KCVZwKazDuJhL9FWV0aTHjO5sh+zWg3Zl9yQ7vQUEhG
         oECvyhd7RWO+SWm1s4axRuEw3Y5Qyl8W0vwlonsaGHqVDpaLcmeqhA42C6IgRtXwe+Fb
         xVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398986; x=1793003786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RwY9VfyV3uydu5UUW7T5oMK7v8+2fcAFPimmhllZwag=;
        b=NXqYp7SGyLo9U3bJlakVaUBNvbWRUd00+N4NXei9erOGB8Gpe+bo1LWMYZ/Dz/Uvh5
         ItDQmpyfr4UJJ99RHGYJ028IwbUp74g36XTtlF/lzwJRjyvmmRcaKPsM7W2OakszY5V4
         26T6JFDgdtLiLFf2nGRDBo2NfUhSowHgbvzOo5PtGjHo3P36f+MqcljKLUoLjfdUK64A
         KPrVKkUkJ5mOUGyOA4UMGH8ve4ydmRi6XAMnGlUYXpGi7y93TAEhx7kttbQRFwcDmFUo
         hKzCGfVON3KHmGUBHwsftxRc9Yj6SKbmJddjRzOp7oB8Vc8yf/042Gd11+s5jrMcJSt4
         mSHg==
X-Forwarded-Encrypted: i=1; AKwUvBxUx7K3P9F0No/NQhWbCH0+sZc4slhiYu0gg2LvHD01A3LMOziTGfURJ2c6AZhU40CpoK4T5TvLRlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf+wKR8q45xq9gu6mq1BWyegFXybw+thoaFW00/tbX0Zm5EgJ1
	MHs9ooDXtxxR3dds55Dd+Ve+aSgoz1hD/LEOY0Hrrtdo/O2xWhHVd9fz
X-Gm-Gg: AYBFou08bkprvUOAt2SxrAVkei0Mpjlv9Zw4gWwI1VsJVSkntaU32YFjoCFd6M8cHGG
	m9fyGGEQ3Hnu99zb3cnVIP/NJSh3DGm4WHjb2DZGd1BrASPZVhehvP4wI/xTV6v9sOpReoh+4aF
	IKBq1qjJVmDfpB4qfKiFaS4Z5fljBvRFB0ct5wXX8Advb8oMluk4eNJ+32ZSAy+DZGs/pF8x0W7
	5/4JC7NGu/HxcfP8ltPiC7yGs045jlpAADrZSGm6sxDEL79wtYfvVD3qE7UsxQnHuTVM/AAO1Y+
	Dvol0SxQN1jCZrtdOZaFuzIRREd+rmMKHoWaDIEahZXblkiczyGC8YGPnj0IgzF3piLpnu8Gx0T
	ItcF6fuWZ45bzC4OgHaJuawVsIlIMDSDKocxkc9E+6OTDDo9TumpLpWXAGV9QU+Ca7YwhbtiqlM
	smkYCTOxXdJOpT9vUDbKhYmf4c2PESgM77tNIypU9vVNJau8Am/qmxGcwyFiWhrYBZwVViz/Zrg
	/iIZwTxTYR+2zQqVIrFyIT2cASlw8hvJTZvxcrc+BMrg+qHwrF0QbSDpWXa67+gfYVexKaCjN1M
	xdr1QQe8SjOs0uwusFWjBqx6jPI=
X-Received: by 2002:a17:907:9494:b0:c35:d50a:1352 with SMTP id a640c23a62f3a-c419d34f678mr466740366b.11.1792398985661;
        Mon, 19 Oct 2026 01:36:25 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dcf98fsm323106966b.13.2026.10.19.01.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:36:25 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/5] dt-bindings: vendor-prefixes: Add ZillTek Technology
Date: Mon, 19 Oct 2026 11:36:16 +0300
Message-ID: <20261019083620.1285782-2-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
References: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ZillTek Technology Corp. (Hsinchu, Taiwan) makes MEMS microphones and
barometric pressure sensors such as the ZTS8032.

Link: https://www.zilltek.com/
Assisted-by: LLM
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0ec4e481c64b..1d0ef2d7826f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1979,6 +1979,8 @@ patternProperties:
     description: Shenzhen Zidoo Technology Co., Ltd.
   "^zii,.*":
     description: Zodiac Inflight Innovations
+  "^zilltek,.*":
+    description: ZillTek Technology Corp.
   "^zinitix,.*":
     description: Zinitix Co., Ltd
   "^zkmagic,.*":
-- 
2.55.0

