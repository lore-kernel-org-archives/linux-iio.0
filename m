Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6E3A7F75
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209717; cv=none; b=pBOyMrIWxu+iZ8QYLNSZSv/s/F1yytkDZ193kPmnBHLVZshh5Dwf5jbDxgyZywgcuramlS+jt3p6RON3TDjOgxBHOHYRLp5McYyDR2c10TYka7+rTLASKfhvVolhCdbFomDo+9hgMUv1V4GZNRef+KfX9QBRKwqFhhPPjP6/HHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209717; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu9hU7K1CAvl0D7OZwGaCgTzSNH+ii9YQ1jz6njYZJSu8kiQNj2YbbQVgcGptZsETJNQGKotTj9BxupTeKWRPbLRA1EGyNFFwYee0brdbW5A+FkonI1PN0frAKoGfY9d4w+NhqoZfGp8qlkl40oJWy13z1twrBbs0vApJ2RdrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+I0TCVR; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+I0TCVR"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43d3a0dabb0so223435fac.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209715; x=1781814515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=W+I0TCVRDA11kccuECYsfkJQ9k+Vb+Gu/III/3veZvp4Qvmpo+Daw6qFKWSphfcmOG
         z7uPBPyWwfkaupak27fCK4TzdSgRBYhMn6dYxpka+Ym29MCDgzZy0zr/J2yLUb9uoepV
         eQCgSzeylw2jvGqhWNpmAHXUswg/w7by+b/X59BWFJyALiqA2GC5Cns7tAZvYd3j7/5c
         dE5LNjS0xc2I3pvmfGVxXedBwR8HGePKUtkqnmeAMOhqoULMZfBkR1OGk8kELKVnO5F+
         HAIWUSvsU/fEi6LD9XOja507fmNHCR0VWculGsMQ/pL4vsNlP+xAG+GStmhIqJFLO9pz
         KGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209715; x=1781814515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=BJy2kAdI+qzVRh1l9hVHJczHJGRmyxe1jpeMDEPazjU7luODKs5qTgcFTu0q/EtTXN
         cFNClD4+MNsxTbFoeHNV698LtlAbgnsjzFyrMoRmaKmbZHULj5z0Y0Fk14jtDTgnuyG+
         86eGBneGQ5Dxo7hu+VO2I5YuUpTrjpfStuV3LSf5KO7eyfB+tjK66aXpo5DC+F09EkPK
         VWxfz/NE6vJOTeZPLpqS6gpxvAPnu+CvGTxOmFqr5TABbxODVhUAmL1xmMP8WaQOc4jZ
         tdbps6YgzgxuHyn9hUonlFtu10nI6zYxhPVw0IWf7PJX+zUMyToZAocaEmAIG6dGHq21
         eHZg==
X-Gm-Message-State: AOJu0YwV3xKuB1UnKpastbv3wok1x0wqLLyOp9TmNl/mA69WDn9hs24Z
	Pcue+eXze228OggfHxE6aadacmgoVWS2pVQcaBlwsXeAqSQqz2du0tatuFkj9hPg
X-Gm-Gg: Acq92OGww9UAS4cfV/mtbMMFMhyZI8HdVIkoGMvI9a/IHUvuo0+ahMoEatetEBuCGlj
	+14zUxfFfxyMPsQC5hE983xXjWjXwOnaTgjVbf1nHmqHywl0ThvnfK0qTfaBJbtjbW6smongyKe
	2++IiuW9wkKD/owFXMBn6Hr0ye8HEIxXdXlapnt4oX+wytbcFDTplyuaYoYhRsUBaLVqskwpEkP
	V3R1/34om9iXtatsfvGuUToQrId4Iz696kZKgfx+jWPyJMkHhtikIwUB+CCb9G5t6vXEB31nfnw
	UPLI8YnF3yma9IF13CXHHF142hPAvF3ijOQDFHoN+yeQjAq2PN+MPOVeKhSG24UbLM/6qfuJ1gz
	WktBP4BTtLAlDZgpJezPOEY58zi+sSFq+NMypJWVqhnhholPuAT6sn81LAofPhoZ1VNWritM9OE
	agfqWzp/6u/7rvCKwbICJA3df3PKyzQqGL
X-Received: by 2002:a05:6820:16a2:b0:69e:2cc3:16c4 with SMTP id 006d021491bc7-69ecadbf2ccmr3008961eaf.8.1781209715020;
        Thu, 11 Jun 2026 13:28:35 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44244cd05c9sm1796134fac.18.2026.06.11.13.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:28:34 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V12 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
Date: Thu, 11 Jun 2026 15:25:58 -0500
Message-ID: <20260611202607.85376-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611202607.85376-1-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add mount-matrix attribute to schema. This attribute has been supported
since the first revision of this driver, but was not documented.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..9b2af104f186 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -53,6 +53,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

