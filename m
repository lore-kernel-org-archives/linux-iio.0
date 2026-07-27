Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0642FCDD
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171047; cv=none; b=Xk98Fc0VCeeDRTo2gBUdSjeXqhEeIRwaj1CeZ9TmAi5lzQDcTJxxAbEi7g/inpjACIo6bWoIUJnIXKptIY1bzLl+MYwbnOaxut5QdACooJfkDZPSynz2ak8MoZeCWhHDjrd//WQS8g3SwgTpc7/IHfm+0GfKH9CIUGZeLlVmfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171047; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKtwpnQG+yo9ZhKvSdFnspKaStN10+n1irJHUa1mz8wcMdyTd+1SF1HVwwXflx+tx2bSaZBDro992nrIb2eWRlpbvH+MUPofz0BMHiKlig6ouGQBP4TJB9E9TgG2A7VymzLMHgzsDzUMvdz6XcolaWrk/vh3wqpdtahexuDADAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmE5egMg; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmE5egMg"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4ab47c40e7eso1062747b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171043; x=1785775843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=KmE5egMgcVSVlqZnqdAlYTCMcQFIgdIkjs48AdpNlkjiG6l7ZJffA57P9HaO3FjjJc
         cRzL1rPOW1Rj0ArW8qiSO93jo+m3hzESRIogVclQutI/48cMQA0Z0BN0E5E/DvWKhC8H
         DtuYvmyo5NmjORqSAAVkr6DA0+taudOCxqkHuYSO1lnEXxYDuSNosSolIDw/BjjmzcG2
         QTQ3NWrFOYym4cgsCgdG8eYdMJ9k2RDEn3JLhapaLJf1HiZZYIYaMsnRquz0qDS7KEBR
         /R/sh2hK2O30VWMRByA4PHozQY7J00r0kE2e5Wj8j1y0iPVtP4N4pKYmpOIqW9qAbnOP
         4Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171043; x=1785775843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=ObLOFehqbKv2j+vRQKxFFXMX7LUMcSSLHAFaEqpShzNqseTenXTkp3JZIrJMzsDtbe
         aa+fZVtE0yDYbhjs4wKsJQTVVpKN3C5OI/6Uy1niL18vP4/v8J6uI+9ZX1X6o3+UHzeX
         +5yzJ0YC76EE59lKCL/orLqg4ZRH3Ee12tVdxTmn/M1M1tukCw9RhA++xLUOhJJ/rAez
         I/t93P6OPhIOZJigHni9gAzjA5ADS+YQUSHJ2ccpWqB/eZt/EM3D888bVW2EUMQhPmpo
         VQ8kLBCQAeIr/sNDTRE2GGYLgEOtdLCm6MkB5fqPBQmxubz8sYy6sSh/xXjI8CEdTcgG
         BjaQ==
X-Gm-Message-State: AOJu0YyZ2zLwNo+t3DbeZo9YezKbzLB9S5wB8Nf/sDoDIR1iBkXurqY/
	jV4cMfWnw1i9WNYIoOCVCVQ6p18ms1be9YV2iTN5YGNZd45vPcmYi5UGCDwJiA==
X-Gm-Gg: AR+sD13w3kcEKxDrJRo+PfTGtPCpCqlarVfmVcY+elAB02Vsi1LKEzSDaDJHsKoWXle
	45ZUS0/MU+NHPlRtu69k+03HQa/xbRORxmvJm6mMqQRY7PTPlGHVgBGWqr8YZymBu4wIXWfF1mn
	6iBq90eyMuDUrnAywmUSS4SjJZY5ImqNWKbhqPKupf7ZGhmQ0YRJ6Ww3/TsNdyrb/xkNhfT1D00
	FNOhw9u3L41oJZIwbxER/f5I7uCbpfyfwhNjMrwDeH+AhrW2GNmP/2gBI2kMcFM/vcIx+D3TaHK
	EPqUkJqcPF4hN0rtQvYJ3FB96MVniGmPDff4x84H6KSSWSUjzaJVt/7JMI9CIMPdldpf+VZ/Zdb
	6+bLApuz0Tm2aHRF0GdmHcLnKLHN6WFpxSCZm+O0vubAtfOAXUgAv7MTsNGC4lLXnzKjTdWVic3
	b/o5EcH4pJRrAaIRlJHO0D
X-Received: by 2002:a05:6808:6412:b0:496:daf:8709 with SMTP id 5614622812f47-4ad55b74594mr87136b6e.17.1785171043109;
        Mon, 27 Jul 2026 09:50:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:30e7:7cd7:b59:5863])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab0c7a1912sm11395050b6e.2.2026.07.27.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:50:42 -0700 (PDT)
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
Subject: [PATCH V20 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix
Date: Mon, 27 Jul 2026 11:48:05 -0500
Message-ID: <20260727164815.65190-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727164815.65190-1-macroalpha82@gmail.com>
References: <20260727164815.65190-1-macroalpha82@gmail.com>
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

