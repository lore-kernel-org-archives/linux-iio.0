Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089707;
	b=JsE7YV5QpC4tGbBaRiUgsYgtS4vTd/D/AMaz6sdjAkbY8lz719lAjMXK0TFjCNP/18gY
	 O3XCHKy8G4TZ1wLdXjxDmoO9XB6FRJ240r7z81sGrI0T8MbKtO10j+KBLXTs2ShPg05qZ
	 mncETBT8DXkf3dSrwJuYR1h747yCvE3N7QK3WVuoPsOfOCvGlvF4iJ9bCfB/rjeo7u3aA
	 Dg7uQFJ32RP7o8XncPaIuIsaZbKJYJrEY7OFnUyHFTsLo/Tdl2u5Whe4lUtbhFD99dp5w
	 v2kVrHMG1x+mXcOOwjV6Vi/guOPG6M904zHbvOMsgl5q3anSixObXVZ+4zIFOKU0hig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089707;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=n01jHr5+VqNvF/Bd81ZAGr3sbTKfGvmwI8Pfr/ZYkLI=;
	b=IBcWA9zxxiMCaRyevhA8YP2OIiWqrWKY2rvihJa355i1Dm2n+GHmZXLZgaeUa8j/DPng
	 5nV+1OhnjvUW71QO9LuxpnkKCw7/lco0CExmaW9gVOnuzIEc+obpW8thlOnuzDT4X4d1I
	 wIE7Zy+UiJVHgFkHmjDgBJiGZun305C1FRGXj9B4XYATV+xt+Cei9HEwK7bxCavCPh7qq
	 z2g8BYAM/QhwLiPzv3x6GRD7TWnUCSXGmDTbWvN8N5c7XzCyIdCVL/dXfIZ9eV7N4FkvJ
	 QB8CkjFUvXmfwkJVWIv6Wl8PJ4PghW6I3W2la34Zf0bnw9uFSyXH2n3oMpJOvQQjDRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLnF7h9r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9926606A32C;
	Sat,  7 Nov 2026 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLnF7h9r
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794089706;
	b=ZmZaxOKFwH8UF2enuiYlSdN/Zr9Xr6wCNP2c9QWJ4GhImVlVjpGLKWin2HkUFx8K1pEi
	 aVybgDndwt2j4GgTgxPVZ3XNRvnhZnaBiPGaoCfz+cWfIo7TcqZNFVKcBTPcYUJMFUoER
	 Irs10HTr+wITGJGPtJ1XcDl68L34fgXBmV/mcumWDohLonADEyeD43cOWj3mZ8LFcQ2kY
	 tt7mojvm/xwp3FjAs2laZeGwVsKLrUX2TMx5vz6dYNELuLQ8ENg+wcDVTkkkOGePn7vEy
	 JJWBqu3F9aHpFJujDCBZCMnV6yHRCttyL8LQBQ7kupOb/b9L0q+njBeBUjLwsKFhtlQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794089706;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=n01jHr5+VqNvF/Bd81ZAGr3sbTKfGvmwI8Pfr/ZYkLI=;
	b=awkX8YBnsf/LtnsiStk8NnlXZBWyKlVtF5ylx+AQ1EkTjse6TQDmr3XP3S7z1qL/syJz
	 DyoFNy59k1olCO5oiYHWJVxhw0kjIqlUWCIcDUmL7BpaBDvzACtb4HMQnTALL9Go5oPcn
	 k0RkASDVFYKRdeHICkbd9xfdjsF5Y/o661SqSMHzIzi9bF3WGu2GuplXBFilN7sEozQAy
	 L98+3Cipi6tW+UekbHetDn86hxCkO/yttQGhdsghnvDyZr61JZ5qWr/sjvlc11soCJznM
	 Is6rE2IH8xlmCfPXzmP/zWZAUtnWXa+Vn6VkJ8dKBOpVB+jXTEVaMVe502lBLe9j6Lw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4F38A1F008A1;
	Sat,  7 Nov 2026 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794089706;
	bh=n01jHr5+VqNvF/Bd81ZAGr3sbTKfGvmwI8Pfr/ZYkLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JLnF7h9rqNnEw+kJ40k3gvn87jIqPovaWhnwy8Cx1ujvc1W2ez689Nv+lRq4eQ8RL
	 0Z4d/GEPpeMyiS09kurBhbUdD2KqvxijGIV14fDEkd5BLnKYvg7ntelEiQq2TD03Mw
	 UhSIPhofB0ZGsOFkgZVOVos7Z4MZJIg5E6l1G7Su6alaQaIEX+i4t4rpjA5nIDkWy6
	 IFoQXAt7ysRgRH1st6oQsBnzhkiI9ImxMZ6l+wuIBVLDVB8DUdGtoR3d26a/34W0gq
	 MZQHFNZBpqReVqup065s6MdOsCzVVlidVoMo2w+bq9T+k26j+QaekAm7NCVN27WeuB
	 HyXcqKUr7VlTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CA90F47D38;
	Sat,  7 Nov 2026 22:15:04 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 08 Nov 2026 00:15:04 +0200
Subject: [PATCH 2/4] dt-bindings: iio: light: stk33xx: add stk3337
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-6768-stk3337-v1-2-0340c99b0e33@protonmail.com>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
In-Reply-To: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794089703; l=1019;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=ulTXlsgUnqMlSx1fcDqcSjlgFN3edmGNunTnTFylHu4=;
 b=NHHDjJaw3clpHIxlMzAhLy8EGQDdoHFpb9U1I66vH75woPji8SlN/5LqVOOKKi04+Az2mIXLl
 3T0wJNLfypvADeSkuW6rIc+xYQpNRL4uvepcWksifqBkvSERI+F/95M
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add compatible string for the stk3337 ALSPS sensor. Its core registers
are backwards compatible with the stk3310, while also providing a clear
light channel like the stk36c61, so document it with sensortek,stk3310
as a fallback.

Datasheet: https://www.bestmodulescorp.com/en/amfile/file/download/file/1699/product/1048/
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index 114cf87eb54d..d5d7059fbc0f 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - sensortek,stk3013
+              - sensortek,stk3337
               - sensortek,stk36c61
           - const: sensortek,stk3310
 

-- 
2.56.0


