Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D38346A08
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045408; cv=none; b=FcxOn5JAQZz2zB28utQLYEaMu622sRuehbS5nece8IdyFdy+OFmu57R8QjO0O5EGx4yg2twUs3hzFqoNaYrg9xAkDPeCjx7VCL5Z34PID12EZxvgavFkZLYeSm8D438CbainYooVPEC6UQ+c53QOo+V0PHE9B/xvdRcw2nmt9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045408; c=relaxed/simple;
	bh=KYcr16eofSFf6x58erpwuLX0EWOMxEB1wCksQCQAusE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXjUYGckYFT/lPqeNn5WqsDZQ13uEcM62D/+MfEEwDNY+thuz9t3Fan4/ualtRJUDipZU9QjwdNjcMHFeGBUBLDxX3SmDDF1S3OSfWgnYkiBEIwfR+340qXVz7MOD+3XGe4Ss0NZ+EIqoHsosPqeFMEawPzh18oJ/QteA16KpXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHwBnJPg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHwBnJPg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8485ef63b68so1718938b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 22:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785045406; x=1785650206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FGEMuXv3Doqjt9nKB8bj0itlo5JFYyzFh4tlxYVnT1c=;
        b=HHwBnJPgwxR+K/gWHoL2WZye4ZH3eTPAanSKbLAtPp/2lIHfqdg5SdnSxTG7v/UenV
         061TlXtw55WKGuEVNqDkZmKbS1rXXfxOz2Be5A+8hVqWO2D3uUslzgJuPPyz1jhEvIH+
         vjJjEIlGIvSch7goSMwKnglqOS/51OQFGvLxCwkEV2ZLvaVV9CE6KWDzc22/bNR9l3Mg
         fBxEbFWICmGoSAd/TUl6Y2J6EOpzHTqGXYtP+HNz7qtl4bvUDesnSMzmT/2AmvJ98owE
         R+nSrEaivi3MsF5g8KoEkC1l76J0IsfWWKeKjGX3CE0Wf2yNls4dU89eBan3Tku8+ELE
         u2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045406; x=1785650206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FGEMuXv3Doqjt9nKB8bj0itlo5JFYyzFh4tlxYVnT1c=;
        b=r3q67pmVPU/QxKCV3Bk/YtptIWKcEzRGxunFgIRg0ZQbXKcBVbS1R5sW6gA7K62/3F
         CMX0Yx7xF8Gg8fjv+egSsUkZxGxOflpf1ASI/pJiqJeWLZZ4mZIHf/F/uvf9gJjs6jIg
         ZTDLmDjqyeJc6bJULEMsKvse6rL2N8JUBIB8SbN8M0ueA6y4HZ0xhn7xa8p3n5IcxMZK
         6W4huZgBGF0SpXjoyvjqm6BfoVowEu7cTCMzGyy1QHQNHssr9+AQnLO3/NE06bLNdW05
         yWEwDk+lzt9JROwax4+KIImT2KT38MnVUSxgiSp8G+agDnAgq1fEf6MTuHpsbHQ80+OG
         Owyw==
X-Forwarded-Encrypted: i=1; AHgh+RrGQu9p5dv+uWgQ4hnQkRsirQehXexnyNpOAwcYK+MCjdLaMvcul+ZCBheVm8/xbpqp6wTw1edGT38=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxmn8vJO+xnyFFWAZpBSkCbp08ziFvYT23GKr3J53G44zppHtN
	CXpfH07x9i/EEtn/iG0mQeJC6PIcGrqir9v4lgxgRIHyIaGCt4FZI9Eq
X-Gm-Gg: AR+sD12jxqDECZ6BWAl4Nx+R6PhlRPL+7XTzoQ49ZefDu9mwqB6M3oxE2MHjPdf0jKL
	euv+jPzG11KF4/dlKKj0kbD3eJezy05E/mi23sErAQEmhh4MgHZPL7lhBInWkh61NRX9cJjANs5
	dYaSnLI2YfhSjhZRAU397h12s9hdqDrfw2dohqqi63qZPVwR91XeI0AKK8gkaiwJAXKJ6iHpP+S
	tyEXDeAq5/Nh9eY65PUzzXGmARGIFuBqbMeNH8J7QIoRD497PWef7g2oD+xU0xtKXON0/+3/tHg
	Fzj/8DBktBmtP0yfFPBjZl0btV5AyrEyGLDEKBDeHXfK7KX6gaxPPxmfsN4254o5ifM9IB/1Xu5
	w9tlv0rJPvJXOhGjFOgg+ylcPIuxeG6fGzypzC6/YUGQROxUs4q0p2/9tyDsXNGBkLwFVKMpszk
	tthuP/sL78jDdAC753DbWkmlWNYcTVBMOqh9htwcZcsg==
X-Received: by 2002:a05:6a00:9515:b0:848:48c6:480c with SMTP id d2e1a72fcca58-84e59490c4dmr3376048b3a.24.1785045406269;
        Sat, 25 Jul 2026 22:56:46 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5341e69esm1586481b3a.43.2026.07.25.22.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:56:45 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: dac: adi,ad5791: fix 'referance' spelling
Date: Sun, 26 Jul 2026 11:26:09 +0530
Message-ID: <20260726055609.18326-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling error reported by codespell: referance -> reference.
No functional change.

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index 2bd89e0aa46b..80fb98035c6f 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -36,11 +36,11 @@ properties:
 
   vrefp-supply:
     description:
-      Positive referance input voltage range. From 5v to (vdd - 2.5)
+      Positive reference input voltage range. From 5v to (vdd - 2.5)
 
   vrefn-supply:
     description:
-      Negative referance input voltage range. From (vss + 2.5) to 0.
+      Negative reference input voltage range. From (vss + 2.5) to 0.
 
   adi,rbuf-gain2-en:
     description: Specify to allow an external amplifier to be connected in a
-- 
2.43.0

