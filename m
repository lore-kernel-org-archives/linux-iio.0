Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407F2472A2;
	Sun, 23 Aug 2026 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787487719; cv=none; b=T9Nx0+KLYPT/aV3NkC+cpg8QOIVOveq4SBJwmA31B9YksxrPVcaifxDsPGp81TKd7wwmtY9lp0kwAR3c0wWRfRSb5HbRoRvlJwRXwH+i/BCKjfnAAhtY/wKW480UdIxne2Cwmk7ik0ePu6b59k9b3EfmhyT2zvuVW2GMo9X04I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787487719; c=relaxed/simple;
	bh=CGVjFSZjECENaRMH8vjXWbfjgckvQdvYCCyXd/jRunE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mq4ndLurog62HC4j0zycU5HX71VPfYz9ygLf/6NJnyKkeCkZOEUbVTmKKbRdSA+bfDnu/InW5i9R9WHFK9hwduesD9l0kARKezXHjt66i32itQY9bxywSRJCGrwRFCMChUG5TETWHDkWWL8PoOJN5KCLnrIfRZZZacUI67XjAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=HzVv47cg; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="HzVv47cg"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC426BFD8E;
	Sun, 23 Aug 2026 15:21:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1787487703; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=BGaX7DZeXOQA0/nBLDUvFWM17WVGbg1iQdf4XKAR9lI=;
	b=HzVv47cgeugUidKyCTu5cleDaVdH5DNGhT0d/6KuKoYsyLq+yb24QZbCvm2lX5wWVpGNic
	BIWSrFvMC1iIuUj+cIWrsXvAZkM7YwDMOEsyhR0gekuk629/kNg/YaSEBb83YblvasoNjO
	pi9bCU0EhqxXXfbvxzUP37kRD82Q2kQm3lVV2d+sSLiRUch3nKvMNjWAHYcNU1GQcz7Am6
	kisLY0sSWUf9Pi4IODyjw4RDemKH4RFWbIxneURpLBFcbTZyg7VuDtREpyVfLY0vT0pUmy
	6xg6WqV5LIg80lG8cZv8qNrLt+eGA0HDPySIhS3jfd8rQVRVQP+lee6jk670AQ==
From: Vladislav Leonov <vlad@zlab.su>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vladislav Leonov <vlad@zlab.su>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: iio: adc: rockchip-saradc: Fix RV1106 compatible
Date: Sun, 23 Aug 2026 15:20:34 +0300
Message-ID: <20260823122039.20831-4-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260823122039.20831-1-vlad@zlab.su>
References: <20260823122039.20831-1-vlad@zlab.su>
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
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---

Changes in v2:
- Added missing Suggested-by tag.
- rockchip,rv1106-saradc compatible moved from the single-entry to enum list.

v1 https://lore.kernel.org/all/20260816113636.33635-1-vlad@zlab.su

 .../devicetree/bindings/iio/adc/rockchip-saradc.yaml         | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 78ec9a33da24..0cce357cb01d 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -19,13 +19,12 @@ properties:
           - rockchip,rk3528-saradc
           - rockchip,rk3562-saradc
           - rockchip,rk3588-saradc
+          - rockchip,rv1106-saradc
       - items:
           - const: rockchip,rk3506-saradc
           - const: rockchip,rk3528-saradc
       - items:
-          - enum:
-              - rockchip,rk3576-saradc
-              - rockchip,rv1106-saradc
+          - const: rockchip,rk3576-saradc
           - const: rockchip,rk3588-saradc
       - items:
           - enum:
-- 
2.47.3

