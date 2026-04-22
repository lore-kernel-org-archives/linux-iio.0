Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D03BF698;
	Wed, 22 Apr 2026 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776858808; cv=none; b=q43qrndVg9A20HMbeFjK6seiXaqhxIJzdKglsRe6yoIvI3ThZcWCqXhdAQXmmtnvv8R1NXJ4VkyvV0D0HhdwyIK5u5bLq9wJKsAwJkP8sv1RMJm5P2TDba5uGyb3Q9FfKSEUByKiN+UAUd1RRCxcPOir/8EnC7ID6RL69P/uCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776858808; c=relaxed/simple;
	bh=o6zzEpWVusCTrwqkamGPCEy+eg5MZNhPZo78gDid0ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ffwNtchu4NoWr+SwiKd88KnRduTcN7Qp5aGQG/r6HJ+tBwdEfnEgopKU1OxY6tMvVA1emd0HMQCzhloVN1TAB6/ofVRfc/Ea3r2oopR31GuYNSIc+uYJPX5Ei0toYw/ERHn00/ZpjD6arTpBIQ9rHOqkmVmSz+lMoCJ17bf5Nks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=podidT+7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="podidT+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1776858805; x=1808394805;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=o6zzEpWVusCTrwqkamGPCEy+eg5MZNhPZo78gDid0ko=;
  b=podidT+7FFg0eHAoFqvq1ADdozB88EH5TFcY3XUinaGgD612r0jQ+D0s
   aGcgKOLYg+Ze35V1mGO0tPlWIOGgeSmXk8u2zs08m4ZzUmXXOvbwjCmU4
   T0Nx4QvWdMcuEs1kIgGccS9k3vbduPuely/deYlRRjefBm9xqziJCLJoS
   73KuH84qZQFsPmzsEVzU0B1qd02DhXeYoVxJNtggKJQzVHJVswA+1QTIT
   gh5I6cDth+r5byqzzHBAv5v3DIYwMEPc1y3WShYl0EaDz9KTpgpeNhEE5
   dvd5a7+jOPMHUyEiaI1rNJwScmMAQCSxliRsba95W5E8hyCwtwaI3d93O
   A==;
X-CSE-ConnectionGUID: LaFJkMUDR/uLr1spsUO5nQ==
X-CSE-MsgGUID: xdRK6knZTDWLKjjPYU31qQ==
X-IronPort-AV: E=Sophos;i="6.23,192,1770620400"; 
   d="scan'208";a="223710776"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2026 04:53:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Apr 2026 04:53:19 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 22 Apr 2026 04:53:16 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 22 Apr 2026 14:53:14 +0300
Subject: [PATCH v3] dt-bindings: iio: dac: mcp47feb02: fix reg property
 value bounds
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260422-mcp47feb02-fix5-v3-1-e742cbab1dad@microchip.com>
X-B4-Tracking: v=1; b=H4sIAKm26GkC/3XNQQ6CMBCF4auQrq2hY1ssK+9hXMAwyCygpDWNh
 nB3Cyujcfm/ZL5ZRKTAFEVdLCJQ4sh+ynE6FAKHZrqT5C63gBJsqZWVI8666qktQfb8NBKscxp
 Nq+GMIl/NgfK+i9db7oHjw4fX/iCpbf1vJSWVdNZYhJ4628FlZAweB56P6EexeQk+jerXgGxY4
 4Aa7RwifRvrur4BIcAwN/YAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776858795; l=1596;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=o6zzEpWVusCTrwqkamGPCEy+eg5MZNhPZo78gDid0ko=;
 b=vP5thrWnMXtEmIc77TydaSr857G6H6ZLJZc0QgMH1HDg6sYUD7i54aCEUsFjbCqMOMpuJtB1Z
 8P9WaqiiWWNDqxam+AmPdUb2PAzMHidzixzvyKlBsNFWWqgYD/t4iXZ
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Replace minItems/maxItems with minimum/maximum to describe the reg
property as a single channel number with 8 possible values (0-7)

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v3:
- Replace minItems/maxItems with minimum/maximum reg property value bounds
- Link to v2: https://lore.kernel.org/r/20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com

Changes in v2:
- keep just maxItems value update in this patch
- remove Reported-by from commit message
- Link to v1: https://lore.kernel.org/r/20260416-mcp47feb02-fix5-v1-1-9656c2fed6d2@microchip.com
---
 Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
index d2466aa6bda2106a8b695347a0edf38462294d03..da4897a6fd8d2522ea7fa3cb8c4bfd91520487b7 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -161,8 +161,8 @@ patternProperties:
     properties:
       reg:
         description: The channel number.
-        minItems: 1
-        maxItems: 8
+        minimum: 0
+        maximum: 7
 
       label:
         description: Unique name to identify which channel this is.

---
base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
change-id: 20260416-mcp47feb02-fix5-26994c5b428c

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

