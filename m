Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAD225A38
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778378884; cv=none; b=qa1GKN/jiSofAWP2y1eeDTc+MMVPtQlpd+z3sn6NB6Yr0uYf8lbmUf6nL/6DG6ps4ETTQS1GEX9S/+Om1O8ompU1CFFyHWzKHpfRnWQ/Trk0ti6qfyeYDlODF9iegcq7/FjpXtm4j3aFGpWaF+GqyQHOo+U9R3WQJerZ7W6Kt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778378884; c=relaxed/simple;
	bh=zCpbwlmIqmZGB0+kqwmM62oyayDZtPdhR0F6QnZnqk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaUu6NIO4VM+76Y1kO/hOVxInUMz5FTNsQmd3u6BWSx2lkVC1rLuD/QfnIvupnM4zZhGoI+8gGz1WMOCa8d6ZCPXJz4aNc86YWLgbCBcxpxNWebGAWt8gXYzMTZnCrSTTYkki7oHpAg7GO+ZKXvj70Yesv9nsePpQUyVAsgUzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG8mOmiB; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG8mOmiB"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so2626885fac.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 19:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778378880; x=1778983680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ybuLlNYqvgak/WTNJ8Ov6Y8CyS5RSZI/sMvj/2jKFHQ=;
        b=CG8mOmiBAwqvj7UX+YkJ+Gsv08vU/63z+hkXRlI6fL+fqt1iZsPxwMYo0g5r3Xcv8d
         2AtPJaX9AecTdrbFAoSGhqQcGnbCtQyKSfg1n5n0AzK/bmHzH3AT1yHHluchkrdgci8c
         sqhYpNgZxb3lDsdZiqNDpQ4Nvgnr7E22+OmFh/cEV7SAFhpoaucUyz3X2MuaAZRz1LcI
         AluN7jt9bIb4v8LlvlIq3cju/6sM82IYURIyaiWNrUyOjLONTxvNJn3b7z4PosXjhML/
         HMvhyShEW74/aGW0WE6RhPnn1g2QWcAWjlwooG8eUC2zDUp47PVYRm8Rbs30aCXC7uRS
         9B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778378880; x=1778983680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybuLlNYqvgak/WTNJ8Ov6Y8CyS5RSZI/sMvj/2jKFHQ=;
        b=R8FGexx7x5wjivuUij78pZ9M9HCcD1rg30qZbul7nVfVs2ARKRQC7n8gnoJgZe/F4T
         3+t8LKt1gZUoL5yhaqTXlH5JC9Z6W3Jhr0YPT6tEEt4KagrlK+b9PxONtSmGuJO88hoy
         eonW/rgnR5fshorr5cqODNLLVUno8S9wJi5AXLigNnhzEXD5KqAREKB0Ghe7LPCM/vv9
         muXEa5J+pyEb3D4+3depwH+joo4TGmywq1Mnye+bofdGElWivl0WV1IM52ymkFoi/DNv
         JcBOHV/RWmGqc1s7g1p5rqs5b6Ylkrz0JhlWMe2cGT4C1sSZ7CfdHPD5udMLWjnVhM2o
         IOdg==
X-Forwarded-Encrypted: i=1; AFNElJ8zHGxw2KtJEeNT5jZBm+YpVINWcpij7yYRR/HEedGPpZmnMpmX3kr9Pk6CWNAYjQD1+CwlkkAcLX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroNsl7kKa7WFY4OyhELyRA46B0pO9jbZluBFb0pz8PD8eIQsq
	4g4fmJ+LnuY7eNFbi0J5yvK0fcp4j7J2cbR3qBlHfko6obnk0yWKIkP1QPGpGYx7O5U=
X-Gm-Gg: Acq92OHr0pC65IhrcPBrUwzmt8pkKM2WsZfvTehIoJEMx4gEo/WD27AIFcPO5FfEH02
	oMk4Nkmh9Ci1Gzh4dtTXnn64AZCQyJ1D3/nz4ANlhzsegepWBxw97anLb0XQOvg7I/d1WvjxX8g
	ZxRxHAzW4Ksi+C18lo0BBr4ZlWX1SICyoJhk7oxZROrVCChZihX0F3bevpixkXi8yzpPZY1QLOM
	pjnJj485r33+MemvbHrmrsAypbY3OTdqaGHU4F/Dejq0bSylXA8zYEwX0gD07k0/jZ843caiQl7
	2aP096UpaWXoWQsAgAzeiLjvSy4YM8ZemXlJn+K6MyyWnyW2EcFjICNEXx5vsBDTjiUNcEF+dWK
	eSjmoKzgSikezs0GmuJru3WesSkFM4Uib9T6aeYuqcNgdb2W2IKJ09AaQl6YiVkJjv28YbmWGT/
	5CvBSpPA4EKZDNS3Vw9KTMZCz6OfrtQTNIKxGMa9hEPAQb/3fbViphL2ypng==
X-Received: by 2002:a05:6870:170b:b0:409:54ac:12ae with SMTP id 586e51a60fabf-43556b2852dmr5533227fac.8.1778378880346;
        Sat, 09 May 2026 19:08:00 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355744b05dsm6208648fac.18.2026.05.09.19.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:08:00 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: tomasz.duszynski@octakon.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dt-bindings: iio: chemical: sensiron,scd30: Update maintainers field
Date: Sat,  9 May 2026 21:07:58 -0500
Message-ID: <20260510020758.233721-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tomasz Duszynski is no longer the maintainer of the SCD30 driver.
Replace his entry with mine.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
index 40d87346ff4c..a5b0debe85b1 100644
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Sensirion SCD30 carbon dioxide sensor
 
 maintainers:
-  - Tomasz Duszynski <tomasz.duszynski@octakon.com>
+  - Maxwell Doose <m32285159@gmail.com>
 
 description: |
   Air quality sensor capable of measuring co2 concentration, temperature
-- 
2.54.0

