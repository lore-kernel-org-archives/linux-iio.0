Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CD43A7F9
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058949; cv=none; b=MxYiNEtDnmJacAmCnK87I46EQUCetaqn6s0hqtYoLDUAUOEBoQfBmJBs3FwlNdF3jnU95E86C/N35wpWqf3PENiMpHraVJsYsbfANOnTEsrvhhyAOSCDRlh5+0OgBA9a61/guTWAe0J/rL7Fe95Wig+xYGUlS/wbv8zuZ2ZSDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058949; c=relaxed/simple;
	bh=U2YoNQx/hGloZRC8McPJss1WdTnU2vgI7Fy7zmdhFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCM40oYSCdnjEyBfBJBdj5xogIPFEgmDKKA+mJfjz8JoMIkyMS3ArFDfSkIyBidywROvURXmTwuxKBNW3U0NZmS/eN2NdoP9v/iIYJCr3Se0gPMKICTb7Ul1rWWP25UlYgV/FWDZti9ni689/nE8nx2nzcyLJSjVfm7QwZ8fCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty514sjy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty514sjy"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b0148201fbso1090231e87.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784058945; x=1784663745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=Ty514sjyAxemmdnG/rAqA9VgP6J/sgMb0NPHTUKzv6q10aqdjZRpJEfu4qSWhJqPvt
         3Rkf+x5ZUMOv4VeVgQJwVi3ZDVoWS1WT7yNajMGTbyrZ0FOEoFQxHQ0oET3Ytccg55iD
         ZOyIbBPN2fZiPRLxVXaTzO3WFVE+mIPQqH56BHsF8hAtIx7HDbNWuLrXR5mGuVuQMNJf
         8SFVX8LHA8e5mvZOHvsCQ0IKhdifWqgBaa29bEeSIhn1fcYCwRguu4yE2qESG8PJ5wvd
         7IQ7H6E93DuYyY23MeBqyYkClWV1cDKmYxvxWHAse5fPPK2tmsgsDHC8qaLTet80PL7Z
         bUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784058945; x=1784663745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=Sy3Ffani8ML4s8pFqS0X995dwTW92gkl0AtY2/sqo0nnjOScrs2R7A/hZWu+LulfcF
         DKi1zl3nfe2RBF+fbPVufs35km2pBjV36yQFEUSXGc1bquAyTnQvVoEsHE09l92aZv1n
         GkDd3Ru2qlQ+EQw8uGWYrBhW5bR5W4+cEH2qpBNM+GJqIktVqkf0LpG/TeOGGsJtRBrM
         f7wtEjwqCBskVKd34dqndiy3Z58WqIm6YFSw+9Sx0raTl2aB1f8FPJ2nIdoMTdAtEJd/
         2UBjwMBH7UAxgtkHoPnrFTCVpZ4nmYF62Ezoc6aaJaXdwFGXp0Ezz8Tz6QBOcsPAodTm
         i6WQ==
X-Gm-Message-State: AOJu0Yx3y07N5gauOa/hu0gWNnQ97sIn7KSpfVHjBaDGck8qS40Nk2qO
	Wpy/Tqccsi6ZHR6QKUrO9eNH6krfIVYUiB1A1T4ywGySb57gPbnbMO8jWB7e74xM
X-Gm-Gg: AfdE7ckLogwFky3WSy5nLR9yqrQSypa2DLIcVzaOh7abrW4eWt7Fuf0ahooDhHF8z9q
	JBjCeq/Llz6T4Z+faSHRQiQbw0HoySz8XmI/f3eFjp988Fn4nRKccQXCyGiCjZNEuAoaMgEC7so
	DuWnUWJ9DBb2GidwfapStmcTNy8GudO4a4UULctOXPkz2c+FZDVa17c+fO8QBuEFVf5tY/HFcq2
	V62Zp8YfL6yBKGoFpRH0RebEnFMI8DmvdQincoS765HqKYERiykcTdBHgCy5gwd+l6xJL4GghV9
	5M8FgyFN9oIMY7a6ovSGoJkcjJjtLjQvdXAKs0He4rGl6fUiZLpUSJRGD7zSVM18cEHkep3bSra
	xhfmcAJcacrkc7S71C2o9UmcPTbxPr9EKbWVW4xHdr49XNBspagntynpNH06Sx7u1Fh8SkQf2MB
	rjggdoXGslTfhWCAaIwXL+eQr0E5/+/GxbT/1SdrBqnwO2FD0B81B2dMuxUg==
X-Received: by 2002:ac2:457a:0:b0:5b0:1c19:2cf8 with SMTP id 2adb3069b0e04-5b023566565mr2278061e87.11.1784058945333;
        Tue, 14 Jul 2026 12:55:45 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:822e:374d:22e8:16cf])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca501bfsm3693490e87.26.2026.07.14.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:55:44 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mike.looijmans@topic.nl,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jorge.marques@analog.com,
	antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz,
	wens@kernel.org,
	sakari.ailus@linux.intel.com,
	linusw@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 2/3] dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
Date: Tue, 14 Jul 2026 21:55:27 +0200
Message-ID: <20260714195528.597753-3-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
References: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register layouts are the same as for ADS1100 but ADS1110 have different
data rates and have internal voltage reference that is always 2.048V.
Also correct order of ads so they will be sorted alphabetically.

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1100.yaml        | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
index 970ccab15e1e..28c5e2dd0ad6 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
+title: TI ADS1100 and similar single channel I2C Analog to Digital Converters
 
 maintainers:
   - Mike Looijmans <mike.looijmans@topic.nl>
 
 description: |
-  Datasheet at: https://www.ti.com/lit/gpn/ads1100
+  Datasheets:
+    - https://www.ti.com/lit/gpn/ads1000
+    - https://www.ti.com/lit/gpn/ads1100
+    - https://www.ti.com/lit/gpn/ads1110
 
 properties:
   compatible:
     enum:
-      - ti,ads1100
       - ti,ads1000
+      - ti,ads1100
+      - ti,ads1110
 
   reg:
     maxItems: 1
-- 
2.47.3

