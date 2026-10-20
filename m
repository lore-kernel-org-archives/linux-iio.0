Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496162;
	b=X1hjd19SrJ3uTlUF8cn0GoUFsdx+P2IUYTjHvKUUiRZnq6nWz7Qdqb+JRzvp8yGyIDo5
	 FpRqfjzuGi6SCzqCOHod1srlRrIMhzB+YtzcUYS4rIbKikIhbuMuvNZ/ZueuyI5YwTVp3
	 x7GOeUZP4OBeWqmTSB3u35PTr98ZyT/0rlrhirLxcZ9tbad3yBXJCnles0ptg0UeNgCZl
	 iDx9aLXi1pI/w4ECqBIga2vuhJhaRkE0fk/jf7h5vohXvKkGD+fcpqmgk3gMHbiD4UDXy
	 fE5vEkpzD2EfBkfq8T44XRbVAZR9mZsRUuPDM0os+6+vbyXw8wx7pwdlpQZe7kqBMnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496162;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=eBbEXayy5lftgqtht4BJ0tSOfoUTDJaIS9Sd2zaJABw=;
	b=0Az1j15CtYxR3apJu5h8VLQOnmGR6aIFZCJu9yLCvVE941xD/B8QVafa73+3/t1t/QSj
	 9g/JxIcWeOXCf4xPctrZSqWwo0Z76lMkdkDE6egcn4v3SWkthM3+dgoUvtQ6cDfkKjPOc
	 gRknE31fuE3ZTLxpb2VZNQAkXOJJt4mH0HMWrv6GMv9br7RhY1cLGmr5zceIRWO0j97hx
	 Uug1njr0ZK2vpfU9QJfJ9OOkyKKBdo6WXUq6B39XCB4QHl3uTY3DOtwp+yIWgRZ/K8nIF
	 O0M3ZHN2mIZkL4OUrqQZPdnRbo/T6mFUsWXN+1t72PyiFKYdYAynT4hlKFftt4AB3SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3E606A31C;
	Tue, 20 Oct 2026 11:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 9F3FB40498;
	Tue, 20 Oct 2026 13:35:52 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Date: Tue, 20 Oct 2026 13:35:38 +0200
Subject: [PATCH v3 1/3] dt-bindings: iio: light: gp2ap002: add leda power
 supply
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-iio-light-gp2ap002-v3-1-b7e0946c9e79@rudorff.com>
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
In-Reply-To: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.16.0

According to datasheet page 8 "Recommended external circuit",
it has tree pins that need power: vio, vdd and leda ("vled" !)

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
 Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
index 99bddf31cbed..643021f1d820 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
@@ -33,6 +33,9 @@ properties:
   vio-supply:
     description: VIO power supply a phandle to a regulator
 
+  leda-supply:
+    description: LED anode power supply a phandle to a regulator
+
   io-channels:
     maxItems: 1
     description: ALSOUT ADC channel to read the ambient light

-- 
2.39.5

