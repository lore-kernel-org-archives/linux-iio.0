Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B64EC67F
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890511; cv=none; b=tAI801YaiHRT9KclI+RdAO+xOgPbZcSmXBegUluj+aXPMbYhrQ6xfm5U1WU+9ziZzRp2yDMu24wsDp2pmZ/fqShqlJv/TGgQexab5p3FWBcfDpQ9nzhj4ybl59GZpja8bCmKUR+nJ9zA0kMeh0u4QpogZ9OYjTEo95Ob6B6s4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890511; c=relaxed/simple;
	bh=MdVnzxM/WL1xMOmZ5fkiZNZC+hOYTLuP3CwOMPlKirY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGC6FqziaCD1yNPALS6ZRELdzK54uU8dZrkhJvl5hTQA0tXYExMN2yBpG8WP5HQJMwucKUZRql1SUU037BqtVJk7Jcr6IlCE+J8pyEoB/v5ok2ibrytjt+q3rAXxDhl0K1C9+uDMNmQmBJHbp8DzcisYyky7Wz52+XMUkGO8syM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6922hBF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6922hBF"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso1218073e87.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791890508; x=1792495308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKvVNAZIKBPJrUX9wm9cpi3TihxLC/jhSA17k/UyT1Y=;
        b=A6922hBF9R0rdvq4517CBv/6E8XSkml729Pt6EtbPziI/yhXCPzSVz3TWvA+re27KJ
         vBsfRrqTwTZJTUJqJaUTbU4dNoziPOLcc+DX703jqCVmOUi1ZkLX2oGxcHeQQAnXK92B
         Uq4EPsnYd8wnxDbRrQGHJ8wUZv5V7S1Lv4k2U9DgmUUhl4fLYmmNE93Ii+5Dc7WizBIg
         IYxYsY9uz0W/48XzCELKXzi2k5VXQiWUKXygix2B5JGushmcWTms3qNBRnN+V8hYdabi
         Eb1/5yNhZQPEwMz6gF3b6goDxgno27/25wy9mJZ3o0AGfbq7eex719CGxvw1KRvzMvkL
         QrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890508; x=1792495308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKvVNAZIKBPJrUX9wm9cpi3TihxLC/jhSA17k/UyT1Y=;
        b=bvQDMWutNPFSdhFsoYr8ZObd6sGf3mNsasQofZK2NRX/FUYYwOIz8UfsqCGNnfgHli
         Hzi13IGjoD4a6xQBWKEcN1n7tuM9rT8u+MKLbSvsrgwp46pFzDVj6IaarAdaO9WhW0+9
         J6RZ4zw/KEQgiNKSHIyLf02z4Vh17wAEPKEtCHd4fWn+Q4+tPcLcIBdTVT5d9hWoAl0e
         Ai0BvV9BfD4oLercyhBY7RJ8mCD+hM/qRfXyKlEvEVWlX4b6N9H2CXo+ZpHkBUKWpU9O
         VuxUHitJb9RcDJ68BS0+QpOqtj8Wc38rDudwmjIKHSWYhIV5QCWLUa7XaUURPItG+lqg
         5nrA==
X-Forwarded-Encrypted: i=1; AKwUvBxh1VoaXUdfdc6UHhE7NH56J6vfa5iyzSuzlT5C5y3XKiKY35ezTdo6DU/Jp+O+DoXT4LMG1HuVLeU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVDIjAKEHIRWVxkqrwSE0XGo3F6NJBR23LaPr7k8wNBoYHSXlj
	OIzes5PVzm+jMK8BN6k1ruClDbqUacGQ250dvdN/t+38elxHI6oFEcdP
X-Gm-Gg: AYBFou2Wd3JtnYBZuSrs9kM0satfQhU9arwDx0wMud5sCPU4fSxnEgG+SXkWdla1yew
	bMALA8KNpcZde8vEoPsovpWiTOwSQKw52y8gFU2EQvf1nvyJZlOPjdoPh12eApjPhTodwUpbVqe
	GqjlCOTyKBJS0+1x1Z7xr9bRAenDFQjaRghT8ZfWnfI4Sakg2JpssTSbbSqMc8OFIRTGOcanAUV
	xBpnHJsHDkmSn9iTUKcShr5Y5ueIqmEeEEqKyUBCc/PoiyjOOB50wpelgtmELFy1t8oEpdsq2Ii
	Gejdo2Gyamud5IWI19kLMP4zeS3ootX1ZtwcJimikmIGxHxZjjvfKVSmQn+LpEvXUrgcma+lzdN
	/fU7ZOoyYlR80G5PhLJhiTBG0UC9bdjMkl79Rn/wS4yMtoGqLrFB9qR/Cgov7rnNhuyJ2AT3/Jl
	NcnT1BqChcCPNS4Gie2IzZMQ9XtZUT9p2G8n6uw5kbn9wR44VH2b0kHrhRIwKK5WsOLI2GuPIsA
	VHXgh38mnA7Obmexe27VSOqta6eIc9WEmLfRg6XGjJbtO4rAnjRfXVcotyP2Bn2xe4Uorrji82B
	jZ9a/ZNag8aXPPB/CUIglApelYeFdpx3KBGG3g==
X-Received: by 2002:a05:6512:3d24:b0:5b6:1a7c:59cb with SMTP id 2adb3069b0e04-5bcde6d3d68mr4216008e87.37.1791890507765;
        Tue, 13 Oct 2026 04:21:47 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcf8a3970asm1116148e87.79.2026.10.13.04.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:21:47 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/6] dt-bindings: iio: pressure: infineon,dps310: Add Zilltek ZTS8032
Date: Tue, 13 Oct 2026 14:21:21 +0300
Message-ID: <20261013112124.1878296-4-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
References: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
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

