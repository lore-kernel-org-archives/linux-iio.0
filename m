Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273863DD525
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367980; cv=none; b=Oiquj/4nDiH4UJQ4QPzmQOEFbfcjDSNDF5vwYRV4hY4jOyEaAHReXk3R7VQlGVBbLx+arRMPj9b83iTR+4W34H3b03t4QzremWdF7CFNNCfBg8GsSM/ea1gt+WbEeWKFLLze+DF1yk4iJg+E8Aq8pKiXn8PJdNQfqjJ556Hmldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367980; c=relaxed/simple;
	bh=VirjA61iZOQwLAxKnDe3FfGkvvDUzTvJontq24LgAoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjVcr1auzgL7WFyrxIv4XaEzYyRHH2DzQlMiCOrLaCwfpQzyXq6zCh5tedXID6ZfQNe43WY12/AWpHY24LxCmPzW3+u+W19zgB7GNK2/8RE5V8uTUsXYTZJpj8SfY7Kfj1bloKT3HeXErs1ZYFia0/SmFNlarAfSmF4z9oEqUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KYfdoiSe; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KYfdoiSe"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9ed64d490so1046456a34.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783367972; x=1783972772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTEktTiHYW7+Tdn5y54ehrrNgsnN/rsQeRiANrKwqEE=;
        b=KYfdoiSehR2kUJUggtks83O+EkWbETLtZhAklZ3yDyvJ98+g+BYl4x7KtUN44PT21l
         HwEhMu8xQbWfkNj66W8QHCde4JsViXGUYVBxzKNYyn9cYBg6RoHLAnL4U3kETZE/9cAW
         WLY0/vxa4AKUrsyw0HCGgh4nOnxabuJV7wKyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367972; x=1783972772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HTEktTiHYW7+Tdn5y54ehrrNgsnN/rsQeRiANrKwqEE=;
        b=SssnAm3NLHcV+hiNkiuSqvqbaIOnLJDftvnKo8PI5IQAsJr6R7JWVYNfbnEifZs1aV
         22bQI5YTPFghuAIpPh8POfovOZ06Ci1GIRD8zUbrVOzG+D6tnGgb/rgHBzlqyN3paF4A
         DUL5pDyWLz7GT5op4X23P7LSHwyfvCdNu/NNGrp4+1gW/SjaWVHbVVpO+Gj+XMYLUF0l
         IBtgKGtEwVpNmZ2x6i93NHPwq65rea9ss8C0MluNH1AxarImYdMduCAPzxzQRfpEuZRR
         NobHqA2ouRrIFdlMuF4bueSB8l8yBp2QJLCfJYD8XDFD8TRaU/+8c0hSgeB/ztqoRtRD
         PVzg==
X-Forwarded-Encrypted: i=1; AFNElJ8m0a18cM0vnS73HenQNmyx8QGlZd4x3QDCelNeWOPNoSmatnvsc7zmfLcXflzhCiBI0PyshfijuXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlRxn0GUFTXm9dJIhTEBEhgbivP4tpujGTxCR27t0cJz9o5YO
	XzA8NvBPOr7LaMt7U+k+NZxK0OQZ8sHqckmOEb399UbAiq3F5sfBIo0xUrGMOcNxcTrZBpLKKGB
	BaloetQ==
X-Gm-Gg: AfdE7cnzkZNS0uOFenHrAZkg6BQVCJCTarXwkc1cs8a5McsAAyppd9fxS4U9YacA2+A
	rbCMdFU+OBgWX01tr+9ERnqLTNn+Mjn8noqiGSFY0CtHbTMXk5qjM5pFvRGSn3lJesksw8ra5VR
	sCcWgmRkU2/2utxQ/93OHSa6XEqWHeLzYoOsGN441R/FXSHJcDZUtrfXfFTckzlYEt8IouC8lbX
	fCq9AFKKJb8BzFI8pLJEtiEJ8/1aXD5PU1d/CdQuR7Xni3DLcf9aZkgyezqjBKRvC4HbZDpRetl
	/xTamrhxiyENBBPOSTnhQDPW/riWwNvUplcbXIguPjlknuxaJbGN8kxgMyXfSkhashrXgWtWKCG
	zq2L9TFzYl2udC9NhmQbXeG7UEYDmo8rrNhWR2KhN+dq1rKjpKnh/vz+KdCVWFSyk6m321SrIJm
	qE+gmrVo1dXp+QRrdBgA==
X-Received: by 2002:a05:6830:2588:b0:7e9:2d33:87eb with SMTP id 46e09a7af769-7ebb22625bfmr1361922a34.12.1783367972711;
        Mon, 06 Jul 2026 12:59:32 -0700 (PDT)
Received: from chromium.org ([174.51.25.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542d017csm12161834a34.8.2026.07.06.12.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:59:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>,
	linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible
Date: Mon,  6 Jul 2026 13:58:05 -0600
Message-ID: <20260706195818.3906949-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706195818.3906949-1-sjg@chromium.org>
References: <20260706195818.3906949-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the SARADC of the Rockchip RV1106, which is
compatible with the RK3588 variant.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 6769d679c907..c3bb03dc4853 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -24,6 +24,9 @@ properties:
       - items:
           - const: rockchip,rk3576-saradc
           - const: rockchip,rk3588-saradc
+      - items:
+          - const: rockchip,rv1106-saradc
+          - const: rockchip,rk3588-saradc
       - items:
           - enum:
               - rockchip,px30-saradc
-- 
2.43.0

