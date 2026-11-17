Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938919;
	b=xEopDI5rNnSRImfvqWic07UsonxNJDj3LtKnlI22+/29iWpgTsXeqLFTVcEg3wLY4O4h
	 N/rE76TxgO5FdYvffxP440wVNXlKuS9gtQ1nPBenYTWrsceUaHdQAwBuoBeN5o+cTJBVd
	 xkHKexCoEIkhmd4B12lBhca64u49qoAiOKSdDfZt1FQ03ZXL9aoobyl0Yk19A15w9lmTs
	 tJue/BeSLCn/KOjC+9NG2OtSN/+W5fzNkdx43J7Kq1CN1g51+4RUGwrm2G2rfNcEtuyha
	 uEUZssj0SXgxjCLc3ybkD9ttMe9bwESpxgWSBVXOmE6ZYULEaa4H8DQMRzcT+qn8qxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938919;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V5iAFEDbF2jWyvKPMMYVn7N6kKweR919dSSiYTkNrvw=;
	b=qkjPfHNS1xYa2X+4ese7bM/vYn62MxolJi2TI2VHpjiBlk/OQTafjGfRe5aASH1T0vKX
	 wLQfesupZBterjaHU32YpaLs7hNTfptMIRrVvtbPrluABRVZxkwtELEgANpvCDsdrAzw3
	 fCeeJ3e0epIVKJZdohjeBL8QMJWPy5Fh+hHyC+MM4IAn2pcg0oNKSKbhYU1aeW7C163+/
	 2MVnEUCyFaeSvujfYievQZT0A4MbPQOMEke1/B9DZeRE1BsDg8wTqRd4S8lNC4Otw2axb
	 +5GQ40fwcZVcLdRHRRiy8ZG2ntUdRJ/aDPru/hZ1yD90GO6YjGL8B6Ivpw9BULBFgTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/GgtluE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F139606A89A;
	Tue, 17 Nov 2026 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/GgtluE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938919;
	b=XUGxsty7I85KA5PjGuMlTmYGZVsPG4qhexANd/SKnlaFnrCnV7vo4KWPoMQ+nfCgsskx
	 77f9eGOpq6F/RkoissiGMKvXy2RKe1w3mZgrnbEaADDZlXjmmNnOnBPsAkRzeqzjENWzL
	 EgVOHtqRJpKpHN7i6+vpqyzg2dO5MlrzGBn9gKUGe5SmDuFnYVm5yPit5mPZih2RT7qrg
	 0c5rUlEuFerFO8hUPoaQ/VLXum3IXjs0ZyeCJOswZMEj1kAKpsX+vDsmGJgK9ghiyyTFk
	 nex6mUeHyTgFliq8En47OwoDfM7b8NIlmwRvpbqchRonsxi2VGptHOAH2FKisx/7FKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938919;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V5iAFEDbF2jWyvKPMMYVn7N6kKweR919dSSiYTkNrvw=;
	b=jGh8t/wE/AMfxjS5SRpiU4RTNg+HU6Bjq6p92O3duOAG8IDTuJTi1aaHBDX6CPXJSzzU
	 ZpUk/OQkSp+GqEcF3M0QHPBG4TNNxfpIq59jUgq4YAaSfGo6j1LRlSyk6bZaIyYOt3EKy
	 aAgVkqTSXShLqT5Xf34KzHq3mXYRSdbEhozteXCFyRrkqjfdCkR2LRXguAAC+M+3Mrogn
	 w/vs/ksKbzVDfcwJChK29lrkcXmhUJJ6oO7qxV0HkReJjE/bjGYwujysezCKEKsVM9kAd
	 lvN1vbsnNgh5/iucQtt/gs0PuBMTggEbbIg2VwjYxODQCwQGKzSWkGPdNPmpqFbmCIA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A10F91F000C6;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938919;
	bh=V5iAFEDbF2jWyvKPMMYVn7N6kKweR919dSSiYTkNrvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=f/GgtluE4o6MdjTuj8H156QJeqydNZUz8kYpvxiQI3bHG34RrKRj8hMmobbSr070E
	 TsT3Y1u+jJ4JSPbprYTgIWkrIZpn+Kc5NpKg4qPw4HMU7I0H/+M/2FiUXl6DW0e6c2
	 Pjx+7bhXcvdeW3Gn9mm0hZW1TziXWS6fHey1291DEmk57f6hXYNywcacmLh7i2TTJ4
	 DqbaWRTdUT9N7FddvCDAbVm/Z1HGgWuC/4XC5+Uhl6fRIApg4PVPvg9I9TTT/sK+CK
	 MQ9I67Y3wEWteyzWUHBbB9VqWPQ+oXv946dnOcG+FCDWmWGddjakT86Bzwc2tfaXNw
	 rGhwZ4hApLzaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2D53B4AA43;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 17 Nov 2026 20:08:36 +0200
Subject: [PATCH v2 2/4] dt-bindings: iio: light: stk33xx: add stk3337
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
Message-Id: <20261117-6768-stk3337-v2-2-92f4c7be3bc6@protonmail.com>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
In-Reply-To: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938915; l=1019;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=O3uGlodd7iCJUv/YJFb9RCUzZq+E4zq3ZhXRuzPVJq4=;
 b=BiPGH8qqbBndIAHLJrIq+aHJ+uoIGkAoAeUfXn9x692+Qr987BSy+DSJecGXljUr4aGGEptzs
 feNESfPmMgfDAhC0eAqDIr/5VNpYMzDKOVr2steCEu5Lr6RBPKRL64e
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
2.56.1


