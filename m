Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B42DEA8F
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164945; cv=none; b=GN4hOwaxNmfmro0veqNfllkZUY5/z0qsyzXKqswyIZPCTcydVqsWBkx2kd/ycmPqKB5KrGh3XdzmsjIyzoTm04wuXbMtMoDtyhKL/gCpncnvXGVYbzgpToMQK38dBYI5l8cdSi+Ij/wk5oIqJDHDTFrKuRFlZ/76M7QktD6QJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164945; c=relaxed/simple;
	bh=WNP9t6TIXZ0Xl+cKQ0K8b690KUl1scppTVbII9h9hh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho/o1rMFrW1TVDajknQDnneJT2DcZXyocx+1o0YaudHOAZufvfx+83YTlc9QoX608QXgBsGVxTIIH5q8hqYUQqMo8FSeL2DDno6R5hRjLQRKPMSnwwjMS48OoQA7uwa6tyfdZ95sG6Gme0A4anL2FpNi6LL1iZYyQUdv8bXnNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ecxs0mxK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecxs0mxK"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e5d08214dso3216666b.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164940; x=1792769740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZCkslrjV5YGHVR25wzRLTh0GGDFeMzjCzaLuY5/q3E=;
        b=Ecxs0mxK5B9M9/COKsNgpCDdPxMR/VLhS6EwF7zmxxoOSwjfj3VLjKrNibSG2vloN3
         0qXzT0RAv+aTNWrqtq21CCv4KeLPotBcYtMErlMQBpathX/nyP6/hVj0KvwEisBD68dG
         lHjbeU045wATCQLANxoNcQ/ATW6mp6ZiDis23qo9p9Gk1y861gWFiXD1B75LlCsGGy48
         J08CMmL50E59tZjZRSTcI4X1H4ikgz+2laVdoezYkT2xNDStN27/Cluqzs/VivjjkpOM
         6dFCTFAVRsqUO9YHtN3hWbHIq08WgiVCxTqidr2FpNQx2T/ESUZLrYjlrkpHgvEZEVR4
         76XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164940; x=1792769740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZCkslrjV5YGHVR25wzRLTh0GGDFeMzjCzaLuY5/q3E=;
        b=Hig1G74pLjtoWE921HZxQVm4l6wMW8XI8jCSaRMYLPK4wDIoMvRgtqi1VHkVw4bJLO
         teCOsJtAWQ0VVt9iEW7oGpB7UgFzpU8csaJLvGHPF5EUTxPMwyO2bvZsE+rzf4cvrd4x
         TYnOKqjlSZ2Nl5J1Zo3VgVh1JNxkSz/uKrgM0vtzV25/z3AG17Nn2inVzxd9o6Zqaz6W
         q7cRGjd/39Eprt26z4P0D7JiFAb5Ps9VbW7eZOt++FAxTAtMnWM3GI7+gYZy9b2xEoR6
         SuT6ubWRSO5zcmy6IKQ30EvnT+dALjsYL9TpETtwvyEQePYNX3JAkvGcgCXd5nfFU8Qs
         l/rw==
X-Forwarded-Encrypted: i=1; AKwUvByqxWGDqnejuzgiRQahILPKga9Ft8kjrSZeCSX4tcK2gbAZjLCTNhg1E1KoGAmqjm6b7URkMxAFkpE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzJ8IUeKSe7H2TpYOWvD05jCqvlhUZyPjV0r4svZqRWzMS8TWJ
	n56LzOrdciIk+68OYq02ulJ6LeEbEIbxUBYR2ch63Dw8gHdMTeZJDYzr
X-Gm-Gg: AYBFou0j7ivmcVrd3mhYSVe7h6HmD4KeLrv+AjAgOnSRcERHX4PIWYLSph0rIo7/yUX
	PEiyq2yEgTzKklFj6+UbjgqGm1up7EFnQEMpVcj/W1BbtJPtxW+FhjpNU4eFJP8/muGKRiw/Pcd
	Fuok+UB8/bSgPpTSjypwN/bRp06syMcuKrTo8tmCL0QVCcS5M355Ngu8bCIQZxJ5t9uiEC+bcmh
	aAayNg2BDPuzdaM3G9CzAtfcg4i3+bRDPQ5FpGhrg5F6UTDTqIjaNl2i/7cedENuF5zBYaJpI1F
	qdTEb8flEb681+FetuYHI9JYz45nVyIoh+erTIqzg6aQoxlOZsvoO0ddDE6C2SNETSiEmq8dzvK
	lvXGvCvH3HwAqLb+QNsLYsGJxyJDjSFC9ed2tlZhEgsQAaJE1FBtia1fmX0YsdD60W2yttcXQYl
	qM9NPKnBKu6ume3/h35/Tw4PSa20CIJa77Y8dbQHQAtEuk0RP+1LDJY5MDpfnZeUr10LvsWKaj+
	eLAlyWkfzPlSHHs0dbKdVLwkEulhuj5/tCxzsLDAA872vlqZj/UMSSCEUJAAvqzOAGy/jcGZgdg
	1vIyJwS6CbFaHHGv0GJsB1UqhKA=
X-Received: by 2002:a17:907:9702:b0:c3f:7e8:235d with SMTP id a640c23a62f3a-c419b13cb81mr17186866b.5.1792164940403;
        Fri, 16 Oct 2026 08:35:40 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm999067a12.10.2026.10.16.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:35:40 -0700 (PDT)
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
Subject: [PATCH v4 2/5] dt-bindings: iio: pressure: infineon,dps310: Add Zilltek ZTS8032
Date: Fri, 16 Oct 2026 18:35:30 +0300
Message-ID: <20261016153533.3701000-3-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
References: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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

