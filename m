Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7B3FD945
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859398; cv=none; b=CZHuYtchvKaKNseGOy8TgATA1mh0Vukx3OEbDQddKHbyvbKwdwZX1mbDo9BGl90f9rzs9VaDHW55mSo7FU8MJV5qtF/TddtIrlh8jwfYNpGA/il6V0EFRrigbr78HRiLuERiRYzLrL8o9VK6hYP08JngQSkNegFORcs49aOegmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859398; c=relaxed/simple;
	bh=FtD2Z1xu1lLuUsrnPnIxxBPpzBzNkmTiFU81QCJiUQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrNtqfIkMJrQvtc0tcC7dnAvJz5LtZp1urQaWFa5MI0zid6RhF+qQY4igTS0RgTjRtYZKGb5Ioh9aIDb1QoiICYiZHWAkEQdggdQfILW7TSgQoPZoKNxzL2G2SxSm+g8YzH44oGlKYzkZ3+vkmAxWhW+BpnEwWmgcVy/nxv5IlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7JSjzq8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7JSjzq8"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso10811548a12.2
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778859390; x=1779464190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UF/iVRP69aP8wVCrm2EY96bha6HrIsHGDErfR8s64U=;
        b=a7JSjzq8mNVU5dmauq7JPoxgutxKgsHcYOnkrP0TRSScICtK0CPZqDeRXiuN8hp7UA
         tqmBPqu8sHPRsk2qFM9vmWwun9AzWe4quFi8ojCgJUGxoI20OV8F2Sv4Pt4BQh+ZU8DF
         9/owJ8Ygl5gna+nrSnpLnG3Qrit5BN90/MiS/D7iFStPAx+M9Rz3TgeskzPhxikYNNFZ
         NoL6UE++WZJENMgM1agGx9Ycev161wkC4Xp03Q8CUpcVNmqack9O9zUpuyJv97yCGcPk
         E6OeD9t1XN8sUDS1I0HntETxdkVL/bLtMEtvIrWWXVe50i5qTWByFlsDYt3WuES5JC4T
         vlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859390; x=1779464190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UF/iVRP69aP8wVCrm2EY96bha6HrIsHGDErfR8s64U=;
        b=XCOpbmGBZMCiQJU/28ZUSYmBkOqKgvuubqUegZg2FLWjkNsrGfX+fhxccVQ/pwDMOO
         lyoIrQmta4hpt9QuVGjzm6ZnhS3vcneCTYT3Up3EIiOjS5TWQWK+z2rBztxZUMvHPv5E
         nzVOmSlTWKEmIcqtuUiNxOJz1kxOiBOausV7JFNW8D+vB4TAjKY2dQWMtA42lgWRJ6FT
         6E3Tf2/XpStnRayf9ciahMmXRBi2eRucpgFHa4QzF8y4ysueSI26KwsTdFIaxtwbJjRE
         mrm/irzV2NKxdxDY8+fISUe+nNCIxB8vOSniJ7SdCFqAqtIqTZCzCjabTEwNK4ztZVV6
         BDbA==
X-Gm-Message-State: AOJu0YzGCPnaH0KYrFDmL6A34uvwYM11dm4NXPPip1EojobEylPhJwcV
	HJf9AuzpohYSG4LptHAvRjesIEOPDOOJI7Za62SSW6IeSsVOzy6TEPzM
X-Gm-Gg: Acq92OEedqeW2epYPGlthrzaAWxnyEazb+LRRKZhWg+JdN5Vqp8nOzAZ6OX2bSAUW5C
	O4l0fXPPVm7dOczCMTnIi7qaf0G1f5WFVQPSxkMqXFk0MZxhEtV0o1pNhtO8AOneLgRRukkNGTG
	QPqzEFJd/NVRxdMMkxAetVMusbszPin3uRCiu2ZKAN+u1QCQcbfuUMawBidYDt2DFQGVbVtemcB
	L6PU8qG5aSVzvmNdnsATHtWKQ8ShYIgSn2rVPpgJg4T8AgV1V1HceYPMYnMFAzKlTqTdfk6nblT
	rxEmdobAd8W5Quwi4Qf9RVjRkIQSOIxv0/5OYvc7iBlAUzqO0fgBbulJmM/h7+r3Qx87to471zB
	LoavTSWdG4BSGIfS8xiYngG4SXcGrKIJJLnb/+iGCy3kO5GtN7cWqpFoof/SiPkqW4tPHZT/jaQ
	==
X-Received: by 2002:a17:907:6e86:b0:bd5:2cc7:d845 with SMTP id a640c23a62f3a-bd52cc7de89mr85503066b.30.1778859389931;
        Fri, 15 May 2026 08:36:29 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::6182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm2205089a12.11.2026.05.15.08.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:36:29 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH v4 3/3] MAINTAINERS: add entry for GPIO quadrature encoder counter driver
Date: Fri, 15 May 2026 17:36:16 +0200
Message-ID: <20260515153616.157605-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515153616.157605-1-wafgo01@gmail.com>
References: <20260501200749.20029-1-wafgo01@gmail.com>
 <20260515153616.157605-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for the new gpio-quadrature-encoder counter
driver and its devicetree binding.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06a8c7457..fca62baa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11018,6 +11018,13 @@ F:	Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst
 F:	drivers/gpio/gpio-sloppy-logic-analyzer.c
 F:	tools/gpio/gpio-sloppy-logic-analyzer.sh
 
+GPIO QUADRATURE ENCODER COUNTER DRIVER
+M:	Wadim Mueller <wafgo01@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml
+F:	drivers/counter/gpio-quadrature-encoder.c
+
 GPIO SUBSYSTEM
 M:	Linus Walleij <linusw@kernel.org>
 M:	Bartosz Golaszewski <brgl@kernel.org>
-- 
2.52.0

