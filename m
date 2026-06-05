Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4684BC02C;
	Fri,  5 Jun 2026 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650110; cv=none; b=jA3Od0fFnbYMX874rr8mer6lYDRIdxbf39Uc1omCZzoHVZGc1XnkOA6D4Bun0/liqwc3COtcIJG32IEux+zC8eWfmIAjyZEWewH47MwKISqMfAmEHx5IHMrtVLB3OsrOSAhUqvqgoujdE8pZwzTYQ5yS5ekxsWlsR6OTZpCFqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650110; c=relaxed/simple;
	bh=GoNuSPuQX8Kg6A443oXWmi/EnA7QK5n+kuzB4KFEMo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iaVSluRiAPnBt0zUDfdAsKVE4AqOKVBSOyaEgk2X57BPpZyCzGfohI7gmXYtOXTTSCKIoARCy3HrVFyQ10xCaGGlHfwrdSGc2LEIhHy0N2uTxHuP9BqtwXuwG3fmAQFPK112gjuri3nHV9/gUG3sakbccyJEcv8KIwGvnQXJkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xIR0WfQb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xIR0WfQb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D7D08C58471;
	Fri,  5 Jun 2026 09:01:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41F485FED1;
	Fri,  5 Jun 2026 09:01:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67777106A2030;
	Fri,  5 Jun 2026 11:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780650106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SFPHV5zqk3B2y4LcmnDnbzwpHGrfnESbOruQVDwdaHQ=;
	b=xIR0WfQbHvv0QfCez1FHz3peZ5U3YmCYfqcogE1wtVqECrhYC2BcR9uMzGYbD7MTWsbBHX
	rLFrXM8du1p7r/VHYHGi8ff3aDbO4T64PcBKu0geEUSxjnM4lEUIGMGlsgrvm/gPOUqPAq
	v/dSSqo/7ezjJCDE0zx5qhbmYm03DYqZDompj+BTiRJgG8doS7YYybAaunPk6Ct5clP8J4
	g6NKEpn5LsmS7nipedVKpXIe4D2sZDul6GOBTii9ufHtQhAF8OROG6Asqe1WyNFIT9G2tu
	+P7v4BwgTtGPTVPqjSozulPSrEGG68WupxxrP0D9iKL4E4lF135FQrM4QvpinQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Fri, 05 Jun 2026 11:01:35 +0200
Subject: [PATCH 1/2] dt-bindings: iio: ti,tmp117: add binding for the
 TMP119
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tmp119-v1-1-349f45f17d12@bootlin.com>
References: <20260605-tmp119-v1-0-349f45f17d12@bootlin.com>
In-Reply-To: <20260605-tmp119-v1-0-349f45f17d12@bootlin.com>
To: Puranjay Mohan <puranjay@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The TMP119 has the same register layout as the TMP117, and a better local
sensor accuracy.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index fbba5e934861c..9f3b74274b16e 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -7,10 +7,11 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TI TMP117 - Digital temperature sensor with integrated NV memory
 
 description: |
-    TI TMP116/117 - Digital temperature sensor with integrated NV memory that
-    supports I2C interface.
+    TI TMP116/117/119 - Digital temperature sensor with integrated NV memory
+    that supports I2C interface.
       https://www.ti.com/lit/gpn/tmp116
       https://www.ti.com/lit/gpn/tmp117
+      https://www.ti.com/lit/gpn/tmp119
 
 maintainers:
   - Puranjay Mohan <puranjay12@gmail.com>
@@ -20,6 +21,7 @@ properties:
     enum:
       - ti,tmp116
       - ti,tmp117
+      - ti,tmp119
 
   reg:
     maxItems: 1

-- 
2.54.0

