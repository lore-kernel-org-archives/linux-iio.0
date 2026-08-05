Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B80405C47
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925415; cv=none; b=Wevam3edyyR7npG9nfHUKEJVdrn5PcjS0/sQ8+25vzJswBhNSVoO6+0oF4r0aMlPmo2QNMwEe5lTCtxUegAR2axsB4XgyRCBQ879qOVQbJ0bFl488pbAQlZIETW8C7Na5BRBvLoF+DD2o+aN5vBGtm5gBXo9W5JepRsYpWXO310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925415; c=relaxed/simple;
	bh=MNBCiyRVJBWwyLo46fhbnJxQDnbhqm48d5QW6tS/BvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxJ0ktx47T89gjhaAYQqAA6BsJBBiG8guczWZS67rWcwTrDI9S1jOdnMhcrw5eXGgrw3D3CBrimdGNt9efz9MZ0UUIGO+5YlvZra4GD8k1KNwVlbtfKigTS/lSoeNda0G6rjYdfbk7AFdVNjmSSxWTaC62Q56HjYIIr3bEB8kmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0LiO6Ur; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0LiO6Ur"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38eca9b7114so413282a91.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785925413; x=1786530213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vO1bJHbRfOP8vBxDtH6pPbXfTPk6rLQoUJA1fYN2SbY=;
        b=E0LiO6Ur3IN6aWlIrCG6lLeLC4RWhVUPr9GKkKrj8mtKhCpu6CRoJaV/4aCbCRPcIx
         w9FroKeLwqKT7E3TGg9v26dqR8IpnDBpsj9a92hDKd7bD1WlHXb70LOCFZ3t6XAOg8No
         gv2oQBeQqtCl28EEZPBC7xhws85H1kHR5WcxVV4rGAd97dePbgct1wSioANIOeHjMj71
         LM5xKjKf6Wo4FrkFduwkCcwyEaipdkOd6JP2UoYy041OpDJSyCZV23gzP4resHgJnVUd
         f6VRqTzNAtZdjIL3a5+t5lSMDduFxWoUOB4hoolcdq8WAcI5tnIpSlk5ETb6KcWytp34
         OzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925413; x=1786530213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vO1bJHbRfOP8vBxDtH6pPbXfTPk6rLQoUJA1fYN2SbY=;
        b=Iy016ivcIgXK8F+HHuGj450fU/eLP4Se2+BPasTafH23bcF4E3yIADGpS7dDdmd0kW
         lldfT+c4tyQ2/TraU7waa8h9VwgsayEep14bSVlZsA39ANJ/lXPD2Qc01n5IxREOSwV8
         8ttjWQz1pDc8ybg38lDIc4jx2BLbNGtlYRiZ3Ma7d/D59tRGhurUPXzwO7t2wYSuUZZX
         oWS4HsS6E6krhmj02uUcpDZLRvWbPLzS94Qk55sRjwZZ4H74H7nTTkEKbyxJlE18Br+Z
         s3nxKHF6WbevqrQpurblMvyX/4LjhzW/uy1tciB/8SaZlP7AeUrTbMgREgp8+4ZQhub5
         OqZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsVfc9524vLVsDx55e4nU8nLPEr847fck3C1hwFlQ2AMniLEptdBX5vGdO5xFmrCJHCN6mlSjV+0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kpW+y+c+2XTnLSVZxghMoNdv2s8yl8up8lwckTIEyvCmc5AG
	cQMWIGQhdSZ4Unmdl1UvC4ybmZHsQ7/cCzt+GDCxNSVqx0gL5E9ZqRL9
X-Gm-Gg: AR+sD12RX9YDjtRi+ZGzAhL+blguf8COlMLqQQNdZH4V91N9vIvMEzdbzWXYAGvN+MD
	O0iauc9c0UtNl9GVJEUCxELlrCHaLSUd9W3Sr9D3yqzIGoo/HvoHO6GY8EMWRrH+nDlm+lgguGZ
	FHpO7FfzWBcUjwGjRQeiTWYKCFlth4Jti6kX85wvrruV1bJB2QlNRh5bp4CIViPkcNF8t/tvLTR
	fipxk6fyYfb8taqe7ZLK4CihQ4W92j7774tZg2hEjCFlWlYN+fRA9ZTW1RLAIzETb/92pFAyFCz
	hpqYRuK2XDUYjcjFkGlHzZmWqQyqu2yuPwIOWWvQmrWbwmmLx2vXaGw+f/3riJNvOkMIkUVSCaV
	9mIj1Bdwp2eKMvfQfNJv0u0WuMREbxNEI2TyC1qgtazbtA3u9FrSY9vWJmJqAwq1ubuRHxjClp9
	gFoLuvRMTpmV4yO33qAv40dArnsARG6DzjcNyhITNSBW5slmHJiYHAENkv04eNUiEg3Dk=
X-Received: by 2002:a05:6a21:697:b0:3c3:c3fb:2473 with SMTP id adf61e73a8af0-3cb85e736ecmr7337088637.20.1785925413235;
        Wed, 05 Aug 2026 03:23:33 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586401627sm17560983eec.10.2026.08.05.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:23:32 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH] dt-bindings: iio: accel: adi,adis16201: add adis16203 compatible
Date: Wed,  5 Aug 2026 15:22:24 +0500
Message-ID: <20260805102224.3547-1-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADIS16203 has the same external interface as the already
documented ADIS16201/ADIS16209, for the properties covered by this
binding (compatible/reg, the DIO-based interrupt pin, and VDD
supply), verified by datasheets Table 5, Pin Function Descriptions,
in the respective Analog Devices datasheets. Some Auxiliary pins
differ (e.g. adis16209 marks a few pins DNC where adis16201/adis16203
use them as AUX COM), but these are not represented in this binding.
Add adis16203 to the existing enum rather than creating a separate
file.

Tested with checkpatch.pl --strict and dt_binding_check; both pass
with no warnings.

Three prior attempts to document this part are visible on the
mailing list, all as separate files, each redirected toward this
existing binding approach instead: Saalim Quadri, March 2025 [2],
and Sheng Kun Chang, April 2026 [3]. See below for Jonathan
Cameron's earlier, related attempt [1].

A richer version adding reset-gpios and a second interrupt
(interrupt-names: dio0/dio1) was proposed by Jonathan Cameron in
2023 [1]. I tested the same additions locally for all three
parts; checkpatch and dt_binding_check both pass. It is not
included here, as it hasn't been verified against any real board
dts file, and none in-tree currently reference adis16201,
adis16203, or adis16209. Can send that as a follow-up if
wanted.

Link: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230129155602.740743-13-jic23@kernel.org/
Link: https://lore.kernel.org/all/5390c973-6a92-4de8-b00a-cd62af347ccb@kernel.org/
Link: https://lore.kernel.org/all/20260402-fair-wakeful-okapi-3c6dba@quoll/

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 .../devicetree/bindings/iio/accel/adi,adis16201.yaml        | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
index b6ba7ad1..3ce5fb1b 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
@@ -4,21 +4,23 @@
 $id: http://devicetree.org/schemas/iio/accel/adi,adis16201.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ADIS16201 Dual Axis Inclinometer and similar
+title: ADIS16201 Inclinometer and similar
 
 maintainers:
   - Jonathan Cameron <Jonathan.Cameron@huawei.com>
 
 description: |
-  Two similar parts from external interface point of view.
+  Three similar parts from external interface point of view.
   SPI interface.
     https://www.analog.com/en/products/adis16201.html
+    https://www.analog.com/en/products/adis16203.html
     https://www.analog.com/en/products/adis16209.html
 
 properties:
   compatible:
     enum:
       - adi,adis16201
+      - adi,adis16203
       - adi,adis16209
 
   reg:
-- 
2.43.0

