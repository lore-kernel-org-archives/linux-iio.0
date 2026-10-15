Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC494C9DE3
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061397; cv=none; b=nRI1vENsCovfILax2Ux3O8EzX5b8Wp/IwtdTmbjzPgPePcOh+OEB38RO+lDn+5Yb6omybZ/1FzpxdRYZhhydr0A669KRAa4GzJXiCWFyXyGq3e48n1bpLhQmVV9p/knsJXzSW7Rw+OUbDFZ1TNTe68ZdBnWoSFe87CDIyZURYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061397; c=relaxed/simple;
	bh=MdVnzxM/WL1xMOmZ5fkiZNZC+hOYTLuP3CwOMPlKirY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiT313eC8pdW3MRBMh4yCh3NArKukEPUlCpL9GBK2YsYHjhOBA5x6wRmSuPQd95buegMt59oIL74fYykld+Z3Iq24jpUyb97iajdqUadtUdbCBe3lDMzGxZSHgcsjMxBtP3ypiOb/tOg+4K2czU8eRVnOHZrcA4BLlqeOevabFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgLQmLTq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgLQmLTq"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e5e801487so780235366b.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061393; x=1792666193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKvVNAZIKBPJrUX9wm9cpi3TihxLC/jhSA17k/UyT1Y=;
        b=fgLQmLTq6sTUyV1has2C3SWrhGIOWqbF6lsWnOLqGeFRTzlXPrX/GjQQYADCKYUUQA
         qw5Rtkq5wRXupXG4aZjf1Hh/j+TG1Y/+QJokacx+i3RyIZagXHoIa8yaucp0unvaO1pT
         ImYdmDF1vKAbL8YxkS7xbD3cT9VjdFM2/BHaRWxdNqdX1eQ3JYl8Ix0fEFLb8TsH7CJQ
         Eu6cAX866AVnWDpuzz4gMf7dfK24MMN16/jJgznka/yubEL6EIYXTa/iwnpzLhhBht2y
         FOv38NZhHGdDTopdv65ARfCE6Y1bZGg0tIrE+O2XfgPshwvZcwL4d7kAnp61Z8Zt++hF
         Qdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061393; x=1792666193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKvVNAZIKBPJrUX9wm9cpi3TihxLC/jhSA17k/UyT1Y=;
        b=Qhv9tzgFDeCjKjWowntZxeToiQXHWIR2QzGX9Rc/cF3Wr5V6lisdTR4aDkiAq3GSD+
         75Isr7LYXSBc9YNKawVUA/oru/QxaPHvcFpbTR0eLeKMbn8skpKNo9bKZPv53XDAIn05
         dWORlawc+llYZgNvUnnKRvHq9+cPVdIsO5ij6FK0ICF9SVfC7R2E4DqLINU6iGVsHJ1k
         bow9lXRmLX63ZgB5Rz3n4qGooOongp3+FXVSLRAN8XQ/0Z1pIHYa3jxXNST0NUy+eJOc
         AEEflaW9vYqLmTI4Jw26vQXxlUczwnGKCy1dQjo4BMy5I700PkA0ybbCmZHOk6vFPAPN
         L4Yg==
X-Forwarded-Encrypted: i=1; AKwUvByOfzwBy5Q5ekhkdcASmTvEQ/w+maIcpMgG/LrZoYxhN6OA/SiGX8f5PbgneD4DMk5rdRISII6Krx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYImLcx9JcW8kYMBx1d2peIRPfCOvKDUi60SZVgxMmABq1OQXXDy
	frScguGZDzlurhP5083t+XGth88y4kafA7BJrELQcfMziabYY1R1KOPR
X-Gm-Gg: AYBFou2NfkR9ElciEm4EWJ/zncv9ldbgaNxnJ8BULG5sMucGx4RGyS+R+ftjNZ90/Yx
	YE/4sF/Qgt+NBRZo9wUe6zlbrzwLLMVdrp16UfCmjHfrSaB3VC8rt7hxVaj5HA+I4M0DWwzsFOm
	M9JZNvEF43olqg8hfu7KzqZMMO5LE6s5V9OqdzdyQ59PoaTdPeUhbTDFoHpa/zG09C40NATPK4G
	7zMWk+nXu9ljxbO4SqOCbYaMMlM7f0k9nMj+j37xkYhMeuckeH1mccVq7936lCict9nwTZb1hwA
	jOERaMQEdnRlZizv+WKxZOoJQDvsaW/VkBPRV7TmDcjRCczqvJj7rWVFleedgOSFuL6lMmGo4KY
	vFgos/tjuaJbZH2VEXcE/XWiTL7nDLybVwQ4jN+qsq9mxUwVqkidCvjpSXSXZN9H2xZFKfgvWKI
	fpLdOcxaBLkTeznEtjNAS48twjt2hdVoy4HEGZJ1uK97Gcgo736Zbs2kf13SIJ9RIEcGQtTpwTv
	IoYXnngLeAo1NilHhYdD+00Nd5WXiLjiM+w9hWRLhQggLdnpA3Q4c/qFCDd5MDxAY7JkPSev5hr
	10pKxWOMIlm7FWOp1BF3LsZPNLk=
X-Received: by 2002:a17:907:6d17:b0:c26:1648:a069 with SMTP id a640c23a62f3a-c31aa08e576mr1775161966b.36.1792061392450;
        Thu, 15 Oct 2026 03:49:52 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b3af45sm107890066b.33.2026.10.15.03.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:49:52 -0700 (PDT)
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
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/5] dt-bindings: iio: pressure: infineon,dps310: Add Zilltek ZTS8032
Date: Thu, 15 Oct 2026 13:49:42 +0300
Message-ID: <20261015104945.2687162-3-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zilltek ZTS8032 is register compatible with the DPS310, but has two
more pressure calibration coefficients and takes its temperature from a
different sensor by default, so it cannot use the DPS310 compatible as a
fallback.

Assisted-by: LLM
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 .../devicetree/bindings/iio/pressure/infineon,dps310.yaml     | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
index 1912a1b0b4ba..416117dfd927 100644
--- a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 description:
   The DPS310 is a barometric pressure and temperature sensor with an I2C
-  interface.
+  interface. The Zilltek ZTS8032 is register compatible with it, but has
+  additional calibration coefficients.
 
 properties:
   compatible:
     enum:
       - infineon,dps310
+      - zilltek,zts8032
 
   reg:
     maxItems: 1
-- 
2.55.0

