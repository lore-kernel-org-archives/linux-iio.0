Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1783C108E;
	Sun, 16 Aug 2026 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786880252; cv=none; b=R9hBV3MIk3ChLAiSAVGV0C5uEVeuDsH73TAp6F8HHzw67cs3Po3T95O0qTBv1f8CN1G51V88h2RXcZhR8aWKMsruVnp5njHrThnQkxFIR0wpEHS4pCbOA8kJLMa3K0iL28CPq64lZnuodGoKiOQaIzez7hzvfO4gewwQjrq2fOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786880252; c=relaxed/simple;
	bh=rGlRdbT7z8dWK8H9MIyqWiFkuoNGZm2vaJU4/dJA8Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdGYOWzr1PEeS4+jhfvmSNHNZgsrJ5NwLJD8hMNHAyRZtT86ZTlaYT5YeWaiXn2+kUj3aNULIssiP6gFJKh4YQBnNslLSx2rhjkzUAmJA7Dni7NKWfqCXd2daFdeel/FYYOH5J69t9LKQ8uOsYxe+n+SbkkNaGYZhHvF8CGUUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=qIp0cxSI; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="qIp0cxSI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A458DBFF2B;
	Sun, 16 Aug 2026 14:37:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1786880238; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qp+Df4z+2pjjWixA5hPnYlkZ/MmiE6mxJUeWxdVpxVw=;
	b=qIp0cxSImv3qd5PHPM877Gq6jtaJOUH7zkrr7XJdh8yJCLTZ5gja1QB71K7V+1TAiRKnHi
	iAKnN+wFGAmGBVER04iYyeaDVEAVzswokIWSYgRM/sNLDw6z/ny6XiePQMPFlDI9fXW1lr
	hCkVvUB9NpXDn343M2h+qYURcbSlR9y10t2m1Tw4/ymko2N6hI++px8+v4j46xy0R+wxd2
	ye+IRzI7jnu4RcOiolUePxt5IriyApPsbVeoDA+6qlVLppL7jKzChtw1JPFXvFRmdBPdOB
	qpI8uoR0YZqsIbk3KL5fS+iMDIgxmQ/66R6LvlMgxzcC5cH+wilIJ0tVpM+tlQ==
From: Vladislav Leonov <vlad@zlab.su>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Simon Glass <sjg@chromium.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vladislav Leonov <vlad@zlab.su>
Subject: [PATCH] dt-bindings: iio: adc: rockchip-saradc: Fix RV1106 compatible
Date: Sun, 16 Aug 2026 14:36:36 +0300
Message-ID: <20260816113636.33635-1-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

rockchip,rv1106-saradc was folded into the fallback enum together
with rockchip,rk3576-saradc, falling back to rockchip,rk3588-saradc.
The two IP blocks are not equivalent, though: per the RV1106 TRM v0.3,
chapter 20 (SAR-ADC), RV1106 only has 2 channels at 10-bit resolution,
versus 8 channels at 12-bit on RK3588. Documenting it as falling back
to rk3588-saradc allows device trees that would bind against the wrong
channel table and report an incorrect voltage scale.

Remove rockchip,rv1106-saradc from the RK3588 fallback enum and give
it its own standalone compatible entry, matching the dedicated match
table entry added by the driver patch.

Fixes: bdba14f6122c ("dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible")
Link: https://lore.kernel.org/all/20260810090826.146758-1-vlad@zlab.su
Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---
 .../devicetree/bindings/iio/adc/rockchip-saradc.yaml         | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index f0551d665916..dc56855527b8 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -22,9 +22,7 @@ properties:
       - const: rockchip,rk3562-saradc
       - const: rockchip,rk3588-saradc
       - items:
-          - enum:
-              - rockchip,rk3576-saradc
-              - rockchip,rv1106-saradc
+          - const: rockchip,rk3576-saradc
           - const: rockchip,rk3588-saradc
       - items:
           - enum:
@@ -35,6 +33,7 @@ properties:
               - rockchip,rv1108-saradc
               - rockchip,rv1126-saradc
           - const: rockchip,rk3399-saradc
+      - const: rockchip,rv1106-saradc
 
   reg:
     maxItems: 1
-- 
2.47.3

