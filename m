Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B838D69E;
	Fri, 17 Apr 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776433162; cv=none; b=WN0a5WDI5FwkxE8XsbyTMK+2AfsTDDXzbK0CK4A/H40PO7ekCLjaKScBPrznykRY5KhTLssQKyw9DCfrq4lr1dwLe8LLIdLMgf+nzgTCvi95263OTb8dsb6j1DN3qkr4OQ39hGTdEYGqHyjEuSqnwe/ZFHiGZFKzeQue03Zj96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776433162; c=relaxed/simple;
	bh=X1bpzLR/ZOvX6ydSU2JnR3zUvyTA3rYgZyfqoBObJD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Wv9JHEuPm7er8ilSA0ETAxYqzu+t80HciQnSXpY3TyWV+SrJIBxtysbbWm+wqbF4WnonTcEz4nK+/7IWr9WWtZ5gBfXfhvRCF9MnEyT6Z812zIS06GElaqTNNLkT+1me86rQKLWzcxysZiX/SX2dsUrZdWkwSfiI8gj01/GlKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ip1nQgiz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ip1nQgiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1776433161; x=1807969161;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=X1bpzLR/ZOvX6ydSU2JnR3zUvyTA3rYgZyfqoBObJD0=;
  b=Ip1nQgizT5bJkyPaNdeytBdRicZoNoN4zPywfKjd4TI4bxHTqHopw4x8
   YQBVpKQkTJWkhpRouDnB15iDlLYL0F/wAXDJdep7/AMUazWHvmhGPTES1
   W6ys4oRIiYjUW0AEIwuZYvdAXQ66yiP9in627m0CeWqHrAzTbHQ0ebRkt
   mE+p158elQi6xzLBY9Dq8sMA3WziLQ/OV8XrnZXKnjunViuQG503N/yDy
   jgFlVONkHtCaXWoUDrUCYxf1ZyqQM8v3FjBpYTX00UVKb086Cxd5rINxO
   KolZSmK9fzejWA9FWQxk5AfAD+XVtKf4iN6Uk4yT/WbE/ftdFuLa6sW3h
   g==;
X-CSE-ConnectionGUID: JfG4m+J3Scebrk4q4xN5Tg==
X-CSE-MsgGUID: V7ExrjMGQ3CDuOkUhsAYyQ==
X-IronPort-AV: E=Sophos;i="6.23,184,1770620400"; 
   d="scan'208";a="56264296"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2026 06:39:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 17 Apr 2026 06:38:40 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 17 Apr 2026 06:38:37 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 17 Apr 2026 16:38:29 +0300
Subject: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix maxItems value
 for reg property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com>
X-B4-Tracking: v=1; b=H4sIANQ34mkC/3WNQQ6CMBBFr0JmbU07KVVccQ/DQqZTmUUpaQ3RE
 O5uZe/yveS/v0HhLFzg1myQeZUiaa6ApwZoesxPVuIrA2p02hqnIi32EnjUqIK8W4Wu6yy1o8U
 rQV0tmas/iveh8iTllfLnOFjNz/5vrUYZ1bnWEQb2zmMfhXKiSZYzpQjDvu9fO8BxcrIAAAA=
X-Change-ID: 20260416-mcp47feb02-fix5-26994c5b428c
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776433116; l=1487;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=X1bpzLR/ZOvX6ydSU2JnR3zUvyTA3rYgZyfqoBObJD0=;
 b=qUZFFpG+1s3taaB7St8PVmB5zU0W0aJ3xpJaPUWd82Cc9gN4FJzKjCPqjEToNuU0iLbl27xIQ
 GZGT+nkfZjHBM3ewRM7u8RpfbI+mrm1APapSKLhNClA++3IpANpw1zR
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Change maxItems value from 8 to 1 for the channel number reg property.

Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microchip MCP47FEB02")
Link: https://lore.kernel.org/all/20260403-speed-childless-1360de358229@spud/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v2:
- keep just maxItems value update in this patch
- remove Reported-by from commit message
- Link to v1: https://lore.kernel.org/r/20260416-mcp47feb02-fix5-v1-1-9656c2fed6d2@microchip.com
---
 Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
index d2466aa6bda2106a8b695347a0edf38462294d03..f2efa0ccbaa32482dcdc69d98c1565518538793f 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -161,8 +161,7 @@ patternProperties:
     properties:
       reg:
         description: The channel number.
-        minItems: 1
-        maxItems: 8
+        maxItems: 1
 
       label:
         description: Unique name to identify which channel this is.

---
base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
change-id: 20260416-mcp47feb02-fix5-26994c5b428c

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

