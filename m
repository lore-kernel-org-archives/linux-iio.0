Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E76372B50
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 04:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781930420; cv=none; b=B1lirshrjB2Hu4V2kEvFoXb3wZ2oUf4z0EVqQv41Q5OCfO3vGAg97FjToeYC9t+IN+6g49RMIPy2BFDvZecdEBr67YrjPr4eOQ+ICxnhoPQVTd6btFF9MrOmunnW2lHbECLtrt9zNNKyTB0/GTftp7ItSdZX2cxdGgSSXsKD2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781930420; c=relaxed/simple;
	bh=JBNIqf2eTrRXZ9/TbvTv1ucjbReEIe0UVXxGsCJYL8A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=curTAYSd0HwlZd46k4zeTZgWABNvuplMZYb0cpyuvF0wyy4bk6oy4OHZaJX9w3FJl9+0kA1qv71W0waCG6aeEtAPGtJqv67b8r3A464IgeASqMJQGom8Oq4UnI0a/n7fmfedUYcwxRjOD2W3bw7zT3ngYAT8vMQYF9LrsF/UjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+c+VP6p; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+c+VP6p"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-48650c78e09so971399b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 21:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781930417; x=1782535217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p903FzlWhZFqXdoaSbD95bQ1EP9oEVzNqhz/9QS+ytE=;
        b=D+c+VP6pkba9ufzIIcBqbloqJmRyDd+lxhRLa24pcWze362yc+rqddxtQY79q8kWKV
         MHVfd3qfjR2vej9WLCErApEu5WI7VRCKx9t3bJTOiIG2AOzJ9E741sxDpFoc0Yr6Jp5f
         ylxE/uho95dvRi+TbJ59GcIHWcc8KI920iZDhEmexAwkIFzeGvy3dsFSLxsJpvhsNIOn
         lf556cxZz6IOeU6KBFuY4+drRtGI+eWtxGjP5RyVgEIJ547wMtje/It2qDii4/KbSfRM
         Ss0QC4lPcBDQhh7xEOYd8KZLvPMm7xHtd5ol9mMdrMRc+5nVleOGKNlX1MDD052sgnT8
         JqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781930417; x=1782535217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p903FzlWhZFqXdoaSbD95bQ1EP9oEVzNqhz/9QS+ytE=;
        b=iszDRaLGlCbcb8IMfxJNjVMtLVMx2Kl21zmTArP6WmjSfI7uw0dq1iC2rzU2QFLLcg
         Ty1Kax4xaixXjaUUUpY0asA94gVCuj5NbLlTnNkzDMmkBG+LvivW/bctlqHinkOlQ0rC
         bY5CV39igEeinOxKxqhoTCz9Q40z3fkP/57Dmw9zKckdHZ4/XtYX8m65sRCIquTzZA7u
         2d6x/l//aIqkICUp6iJ/IZ66GB16eLISFttZiV+1cluLx3APzoIiVOYZI5rpE2LCOhqG
         +aB6vrkaULDe7Vou6M5dnTmG+6SH2NtJZfB0dReCnwjs+VXQWzIDarpmATAohdKx2seP
         D6wA==
X-Forwarded-Encrypted: i=1; AFNElJ+iI0/9sUnXdky4YH14JXJluuWWOMoD8YKcWZO866+TpZUwSiSigTsg+V2OnYzEO6UkEu5ovbg6Fwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRixBF8/HyW9ds451R1QnmSNZJ8m8odCb2Nl9mxYinH9ejAay
	D+NRyVG8rY66Zdar3+lv/M3ybMINLW0ScU5fXP+fCO1o3zeVTOTaFyjn
X-Gm-Gg: AfdE7cmk2Xsu05AIapTwQCP/nObxikv5p5K1uBHHzKd8B9vM+khNEM9XRLPUDQWdzHo
	xJJn74Gk4FSinR7yXPRhUmfiBCUT1ekYv5xEP6b0geoCGl5dxbWfGHojEWVve5k6PvXieDcpDkQ
	XyBFnXh3/XcCatoZCuxpOj/VD1Gv/B4CR1kzlhR0+TdpI/KnOfciyl/535NvhySHyh+7GqK0lMx
	vcEob0bdXI9hQm3WJaRbTEMzTVZ5Ak6kDS3wDvV9Ggu8zNNNiyWUvYLjvaG52PjK0MH1G+E8w7b
	g4ElhmTv02CAtcXycsUw/Oe4CPPFT9onnhRv8mxIrTMZ+EfoFILNpBuM8qoYOhA1yNLNOfVtKRR
	EM0RW/r0iPjzmtzrDNv9jParongZYd3xW9o615mz8CUxW3OkWh/gV30ufFo79AeN/WQqwQehYy5
	T2LZ16boZWdMcVc453KzW7PwOjeJ483hgHuncAPpEexu/DAig=
X-Received: by 2002:a05:6808:4f08:b0:489:5dc7:dc55 with SMTP id 5614622812f47-4896ac76486mr4978993b6e.40.1781930417349;
        Fri, 19 Jun 2026 21:40:17 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0ddd7bsm679754b6e.7.2026.06.19.21.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 21:40:16 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 3/3] MAINTAINERS: Add entry for Sensirion STS30 driver
Date: Fri, 19 Jun 2026 23:40:07 -0500
Message-ID: <20260620044010.1082621-4-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620044010.1082621-1-m32285159@gmail.com>
References: <20260620044010.1082621-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the entry for the STS30 temperature sensor driver in MAINTAINERS.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d95d3ef77773..6bb361ac213f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24487,6 +24487,12 @@ F:	drivers/iio/chemical/sps30.c
 F:	drivers/iio/chemical/sps30_i2c.c
 F:	drivers/iio/chemical/sps30_serial.c
 
+SENSIRION STS30 TEMPERATURE SENSOR DRIVER
+M:	Maxwell Doose <m32285159@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
+F:	drivers/iio/temperature/sts30.c
+
 SERIAL DEVICE BUS
 M:	Rob Herring <robh@kernel.org>
 L:	linux-serial@vger.kernel.org
-- 
2.54.0

