Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795367816;
	b=5V7yfwJ16sJRPuJwAwPtBaEaXTg1O457Ke8PKubKvAu1IDnlhUglyRp8flSvG8jF6C8N
	 cEySgetu8vzEZ6VfqgsBYCBfwrgxGudDiO7nw54EOsVoOr8AIiZiErP3xcgR/XAdb6WlS
	 c2pnzaB0/r4hxH5CXV+DKsgFM/5KD4oFKF1Yn/PPvfuy/j3kWftVBFhKSBhdWIqXmzHoI
	 1+DYGPQa4faaSeDpOWbsf/kZAYQkm93ZgxsAM7IxAYTjc0k2kkswblvbk76WGVsz27AwX
	 iGfkZvJgOP91w/2ssqmrlwDuw2knbV1RPVenFy9o4UO1gk45SVeuzhbMwzDLmguugeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367816;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H2RIHE6u7nsE5/OvgvPsvLPg56yhBwSI+zMljVwUwaU=;
	b=kQ0GwMxffkp3ODaee8DzN+cQyyzPY6TQYBTW9hGtFw03ar8fWDg7HIy3mW6emQOQBVyR
	 eBF+/8c0Rb4R3Dm9L5ZGGAN0XYgAcnZlsSTUX6fBaGmto1bSYEmt8PA16ufOHwsFSDsBt
	 0tMycWjfNNwNz7KTD9z+FmIB4uUC0Rua4wdOSI3vyIsU07AGesqaftlKYfYweoJANQBq0
	 K3FdL8njzBORUbZClrTUjCOMtszkRVN5SZkibb60fg5NOm/U+fUr6Hke4TFW9//4hFa+Y
	 DKX4mIeCEvL82eexO51ysTqqQtAnj6IFvxGF7WaS7rY+1tecEo737HPxiwLfcYq1z+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxKZTQik;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EA606A6A3;
	Sun, 22 Nov 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxKZTQik
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795367815;
	b=Blz5Xa9zFQbzwHpO1Gm3NbnhDGUzmuvGHAd85lUdUrEoRC5F0ZEAg8/YO6L4XqktBYax
	 2XbHRIOPjIlBifZY+vCJykqW0YFvqzK2RAXDz862XN5vUrd8D7OlygILoDv2JO0vQPHkk
	 IOKCTiE7scXLNYW3URRM3P8Jvq23e21jeT9ZwDinga5wKYOjN5bV9gY5sE/TMcyVIFxBE
	 3g5OFJiWcWuxi9/l9SLLpc6apltWjigwHIqxdFgcFpgO6USQbdn75BJvG/scgoplH9+nk
	 Ll/1w5OoBbgu51D9m4jEWsC9QmAmfnvnaSyI1bdbhw3V/QG2eHYRDdxrJz99xyfwoFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367815;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H2RIHE6u7nsE5/OvgvPsvLPg56yhBwSI+zMljVwUwaU=;
	b=rBBGkquDqZunuacw9hNZoNhHI4Mz6wPoXc26E2z1WX9oTtwEc2mBj39fbwlLa2zk6LWy
	 HDp/P8nfqzR95OZ7qp9TRL+chWKCcBC6Ht8Dy0AMxyyJUnFxL54M6Avdlpi+ne+mX8v2R
	 WxYVtGJDmMqk9nL4rfNzIutl+7wmAgMjs4iya5Qt7Zp6XC4xAw6CSjggPc8Nbh4BfnRHz
	 G5U67mizNnjRcGmOq1Unj5Z/l9iZzMqx5OKucMxsJkjXjnJaiRSK8Kc6WiH/tGf1BQ3kB
	 kTLhDdj3NAefg/GEsLYB2ZRPYJT+SJVbPSxTXRW/+0GfdVnIyd635RyyK0hZYIAs8Uw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B87AB1F000EC;
	Sun, 22 Nov 2026 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367815;
	bh=H2RIHE6u7nsE5/OvgvPsvLPg56yhBwSI+zMljVwUwaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bxKZTQikJnqTm/K2hOUQLf9TvyqlxUl5MXisashBWyDRuk+aMQ6FjmR6Gu3yuQ82h
	 d2w8ntkhcIOr9iSpVOsoTf6uMRebSM5yr/mnTWncCdTdvum+dVhG+hrrsW5y10xBhT
	 09VitTxFzrJxUlQg+5qrrxz7HHn3UoVgIIwz2Es8kIxRz8CfyV7l6xlhpTliFgZmiA
	 84+3y9IxQcidC4DoSJ4Svd/CvourRV5h4YxRl4sff5IsYBvhK7xRU5OyDcQ+zYjoLD
	 v1YZNWD6CFcrdtqNK3yfpAIWMLJYijxC8ictE17KOfavr4MpThBPOZVF0PZyUzioEc
	 p+hVVtrGxO+JA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DA0014C155;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 22 Nov 2026 19:15:47 +0200
Subject: [PATCH v3 6/7] dt-bindings: iio: light: stk33xx: add stk3331
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
Message-Id: <20261122-6768-stk3337-v3-6-b0d0a924e843@protonmail.com>
References: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
In-Reply-To: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795367795; l=928;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=FMWn6gsTNNWE09tFLvynX9SKYEXNZEcUpJAhLcr17Uo=;
 b=L0SRJNe1gG5tYGcqm/e7P0+nk5AeKlgbaBDTToAADrt5dGBPTUrL+SjzsRP5rN2shLSjj2xFl
 zjxVk3X4egtCr0K/hW372mpgAauuIsgLnusOG3kfgkGbzlvLOaZAqCP
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

STK3331 is a STK3337 variant with slightly bigger package. It has the
same Clear channel and register map. Add a compatible string for it.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index d5d7059fbc0f..2e91158921fe 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -29,6 +29,10 @@ properties:
               - sensortek,stk3337
               - sensortek,stk36c61
           - const: sensortek,stk3310
+      - items:
+          - const: sensortek,stk3331
+          - const: sensortek,stk3337
+          - const: sensortek,stk3310
 
   reg:
     maxItems: 1

-- 
2.56.1


