Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78F38BF61
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314264; cv=none; b=CsXSBAAg36M+UzT/S/zrZ7bBg/7tAybkeTJveaOmZC3bmI7/sQmiI/0gxUSGTimkDTEQDYKPSr53njDoDBTTV57x0LR7ppfG+ulwBDmrSLZiXujrqYp3l8e1U2zkxUrvfTgHzc4pkQdD7qx+asMsygfR8mud2PmYYZ/a62CbL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314264; c=relaxed/simple;
	bh=U2YoNQx/hGloZRC8McPJss1WdTnU2vgI7Fy7zmdhFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrXWUmZ0gzJC2T6/SFON307oyCrlTJaQYbBUMGgBXnioz23rq4FF2OFd8yy4IdjiVr/V+f36JUMVCna5YgoxpQzzT3FShQMM5E7BMbkxc13upnoeSuxWyVDqnOYb9QGptW53Xn8+Yy1Towd0gHB7ipihYUInzXE8FSkMC+OTSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObrwbsEr; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObrwbsEr"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c9452244aso75126441fa.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784314260; x=1784919060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=ObrwbsErDknc49bmpM7HXqhKed+3vrcqjE/PBjrXABIhBAtqvyRbdyzfp2pVf1TZOv
         FKUINj+tqViJglHjinaLOi9mEwSlXG3mJ8m52jLpTp9gMySUz0tIhF8rr2Jb20LBfuFL
         8nwaxVVfTYdIVSK8OmJltcFCUzSV9J4/q6h/b7YjlTMaASzJ+WQceSq/19CBhksOtqs2
         t26h+ZkjWEh6LyN35garmwDOHzBteiLMVM0yfDF1drPXEapNvLjJDxSmmRjk/aiH7cSr
         OfRXxsts5HWCJUbdTvmQYZeDZH5m5vsbuH5fhEUBEnVNBmI8cDLOHMXT/uWqZrCBKl+Y
         MCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784314260; x=1784919060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=ITIbSp4egdcaDOucIIX0AANTwH0uI+A+ky+iyBvuIY/rmxLsU84+D8AP/5YZDvtrnD
         HhseFGTAKtyVILoAsQiQPvGvdBqKrlokPLEFp7XLYxMkE25Gu0zVmfmatCi3KNFttPpd
         m3N0Bk396ZHz2XchuJ5I1fCfz/+Nertzes9DT7mjvpsUMnMf6gX63na6MeBhbiKu8F1R
         /tBg7Li3jcZQIou6bn0k0m+svmJDJhB/sn6SDizm0jy0rwTHlEqMA+9f9KDf4byqWekU
         CrZh76BaaeANsFT34fMKzPTRl2w3MAvvPC2HiLsNBzSdW7dli1wxvVPACfOdKDQklisy
         53dQ==
X-Gm-Message-State: AOJu0Yz+CXbjexABpjteoRrzXR7kVsFCp0hlVm/bbjQeOl+8dFStq4m0
	PsI/vFPzX9CSp1RBwysNasULOQOv73fUd5+govdHDs+yOqqJACtfrNek6MR5RzPL
X-Gm-Gg: AfdE7ckyTJx1AdmN/4lfEvdnMQbfs4JEUzdpGO8GAAhILyYAFQ7bs+HBjrP0CkN/aur
	sH3fa5iCWoeQPirJNZw/xhZg0L2K5gQTDWKcjKI0+IZPcBzWex3Fc1xsPauRGYeBvL4QXlC7Iy0
	j583K30D2DbxQiJWD36ITl3qOfCP85UyOXiV/S7mP++bO5kITaRqBdEGPAcudd41pnRvQtZkPiO
	7mWdjCxg4a3VpzgE/u9sI9mbry/itagoK1gskgDi4LAH+/4/T+OVELYKgQHDbiJ8aStfK75usN1
	/+wOyYgZkz6vgVh/oKeInQUSw1SHyZZbrU4EPZkIjdkAfPnPtFjamYoIRmaRiRT1lMkE2/4DLYF
	iDkCTiJCyamNKITc+TpEPIm0qYm8ctPQ6EbCqaYi8yR3OdxKaWaRWZdaxL594khAqckOTJ95fAj
	bWhbGPv2/1OZcytPRjvJnhu1DvZu8AUM6lAHfZ
X-Received: by 2002:a05:651c:4343:10b0:39a:cfe9:2481 with SMTP id 38308e7fff4ca-39eb2909e03mr6631871fa.30.1784314260298;
        Fri, 17 Jul 2026 11:51:00 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:9d0c:8f55:3d10:318d])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39eb4fd4ba2sm3431721fa.24.2026.07.17.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:50:58 -0700 (PDT)
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
Subject: [PATCH v8 2/3] dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
Date: Fri, 17 Jul 2026 20:50:32 +0200
Message-ID: <20260717185033.246580-3-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717185033.246580-1-jakubszczudlo40@gmail.com>
References: <20260717185033.246580-1-jakubszczudlo40@gmail.com>
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

