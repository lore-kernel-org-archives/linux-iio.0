Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347893DA7E2
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398952; cv=none; b=KdD94Cw4Gkk664swhU+z30FckNevClXaWmxPk5uB9zCC8InpAbulAb8Zc09pJAiCvtbo6DbYOco62cUF8lE6IhgnRbXUa9RF9qKHH1swmSsBXZf75Saz5YqJG8xbzH2B3LILbT7fkL7G2HbcBgR1euBseuj5z/appCvM3StiQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398952; c=relaxed/simple;
	bh=ZD4nCU1fSikM66x2BzXQDLAPQ/aKlesSciJTloOavOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdiN4ESQlWAPWpm0CUbX/4cVJ3fOpsizgXZg+vgMrry08VHY1sw8xN6p0jloDXKXlN/P+ZDxBwiAidn1ikiwD/KcWjErnxZCOlwTPtHyu2W9cjEd9yhggk0ju5v4ff/t0y6Eb6WkoJ2uUId6tORZKjlqgA7KpUMvMLHzPdbyOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy7D5/aQ; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy7D5/aQ"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4362507f396so1720237f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398951; x=1771003751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldMiDngjdctc31b6FkPkpahyZfqyaKMT07cTU/t7Dek=;
        b=Cy7D5/aQupv5AV5sGVzbXgiWPDUKQdVEG/s08X0cnPsWi+6PDhgG9zrHBYgl08m1MG
         KOpiuSzIX4jbcsIyDOO8KFbF/5YtzOySAKBtIiHWpWpX4XQx4ZrVjNmBsGT2mZdjcbMo
         Bpve2d29FSTOwpJZS652z/r9RF9N00hsitOwKfJQjQe21yW21Fn4vXUIidYGThSWwycP
         r+RMMiuFKJD8OxFgi4IwcW2CeRlIbftsnEjYOgSE9iJU5g7bFooVBz+qGJe+Hd20iyjR
         5EDcxKLc7ycoyJ/sF8ZInPC74bvbsWLl90UbVQv2ynAvtMxjJYD3ivJ4HCABea5H64dp
         2CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398951; x=1771003751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldMiDngjdctc31b6FkPkpahyZfqyaKMT07cTU/t7Dek=;
        b=Lntf2OAWugUCX7Z/Dy8qpdzOyy5QX/O8INSKTloDlfTdv8ERhKlMRsxC8cViMYgkff
         RQ9Eywbun1WKeefERkKZA1Lk7j09jpVBRmNmbKr0Ia7jog4z3ZR3Ns6JJKocqbbZOwEa
         QVaBiRK60F1fPkbH7SQv2b/5ZXcpzbhrK9rxAqUKpP6HavUPylejp3SBxjjHeaqg866A
         u9cK234E3CdnE8oy8Nk/GiQKCKS6W3Ar49Dm6oxQ0PPabgROns3Ja+RJ7iu7aMlyP4KC
         pwQ6+h9REnpjZwOobho4TLw+XHkV7hgKwOTLceUo2DuPnz6nwCfzp+IHnij6qWzazd10
         o2qA==
X-Gm-Message-State: AOJu0YzLUWbowXmF3L2tsKSsczDyRuN1mH63JmNJdswvEFb22ZYkmgOB
	6/pdwmyymJFiKlJCLT6d+fwEnNEyQfqz2bON7/opmWngqb98JHW20XyJ
X-Gm-Gg: AZuq6aICpw+too3Rz8jm/zGL+jzo0Mf96Ji92RjTpzZ1IdSLTESKzZCSJ6eiYeBryRO
	OxEOj45bLAYwTJWf8kuOAAOJuyS1r9A58MJhQi1ZoszQbsdR49lKHZB0x0Cr6kmA3pHOKkjYBfD
	hcVmKIQ4xoMqPLF14dRqM28pdLIQ6xD6UzvKOxnDre5oPU6nI0YoayLywqCsTCUTanjj5fO1k4N
	05IQRgWBbp3f9NoJ/hxmeDKw4mzyVM2omsPEp5IpXOkRjjy4GlnHWCgszh+xQh3MbyHGLSI/5hj
	kLz6SYNdXlujP7cA3Um6YprSVSzy9gRxB9HHuS+LUAECTz77qEtyy43cDc5GPLRLB1zR5UFNXgS
	vkfPgcydIbKkc0Pg1Ysz8zRtmgerHWaS0VHMPcjX3arB3p9KUPCWw4UTTwlCKelGCtPQ2KbVc5s
	8U
X-Received: by 2002:a05:6000:2307:b0:435:a9c9:159 with SMTP id ffacd0b85a97d-436293411e4mr5376216f8f.18.1770398950486;
        Fri, 06 Feb 2026 09:29:10 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 02/11] dt-bindings: regulator: cpcap-regulator: document Mot regulator
Date: Fri,  6 Feb 2026 19:28:36 +0200
Message-ID: <20260206172845.145407-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document regulator composition used by the CPCAP of Tegra20 Mot board,
that is a base for Atrix 4G and Droid X2.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/regulator/motorola,cpcap-regulator.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
index 50bc57f06b51..b73d32a86904 100644
--- a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - motorola,cpcap-regulator
       - motorola,mapphone-cpcap-regulator
+      - motorola,mot-cpcap-regulator
       - motorola,xoom-cpcap-regulator
 
   regulators:
-- 
2.51.0

