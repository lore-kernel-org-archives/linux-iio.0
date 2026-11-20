Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174172;
	b=nfnUyGlb1cwpP8uyMqEv0u6+9EuX4zBEOa3Z6iq32zZEDOZNbJ4CNz0/4XT0gjzfpRyy
	 xGe3KrPKGaCkP6hYglBEvFa7VECVxi99RQv7rv7rkkDQ8fmXnXTmHUtv2NZcKs81j7rrU
	 i5Dg3LaSePD2aC7TMHTZJJflf62Dmz4RuEVv5Sd6/D+fKyaLdibGVSFcgOS+dROcrbjMM
	 DQb9zdWlTnxV9AQBcKxR1Xka2iC2WROd3RqclefdKVLJFDWVUkKANQh0VcpNLcCEcC+8a
	 MQBee5iNN92hufZsO73Ik3Y1u9648x4h5GDlFUpvkX1v/+DB8QQlJFIVtTtLXEwuAjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174172;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Y37M6X53zj2OoiECpLvG7CtVOaRukAX0K98e9OU1yss=;
	b=kOnGlhWBSdb6vFhcJn0cD/Mg8RBlBStyr5e/pqqrjQf3JD4QpUHk4XUbBP+09AI7BMrr
	 43fJJ4mwlkFrQ1pVzEa86a/zFnwefdX5CtJN22qSR4kGHvLk9owr31HeZC9Iba56Kvxc4
	 O3fVam/oSVHYTqeCo5Cdapz84aU6XR3Rag2fvRRZjikftnjRcUd1Qjxrc/lHxxaIHdYSQ
	 5o0vgf6teJZHjTBrvY2jaIgykJOoz9YlY/oklnwiUFIehqxOLLvwHrjKwSBgFyxWL2F3D
	 cuNdjwolceAaRXWqJw1OFK0VVoEak/4cLylc1d9Htgfv7s04Co5JxOu4sbIflvqDJcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GcpT/TV7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0302606A320;
	Fri, 20 Nov 2026 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcpT/TV7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795174171;
	b=XC7ze7fBE7GrnuTgU49lbuYVX0WF9gqt5RXBaBWCBdkJLE0HXOnkXIYN8kW4oIrY87tc
	 Taz0j+Sb+C5c0H5UOSXnlJgapq2EEEBStk5sy+qh57njp6b6ze3lSJRHUB50M7d4LSCgg
	 3to9Vt7Q025Rxtmul2JvZnvL7KIXEhqouGW2sTNPQxCLDK5KZqX8tTbSr5+JpUNhyKBJ2
	 44fkj8ZCeJp18F1QOttYXYXYgoENEONN7DykFpsvpU6+bgrkG9UzySWQIKk7/aEYqbgCV
	 GtTy0soo7mNAPfwB9k+2VB4Qd+Z87vC1jdb7ScxN+BVAbkStZMaZt+Ykq9JR0UCjQwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795174171;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Y37M6X53zj2OoiECpLvG7CtVOaRukAX0K98e9OU1yss=;
	b=127l+DNtfhherY6xpgtSW4lomeFK0mIP+SJQ37t2NrFWv0xtdmJv4Iv8DFIldYYO9hCL
	 Dk/wwUbnZZzJYv24/4euLvGRUINGoZlFy2lFGZQJILJHaTOLZ/ToFwevJH1Kwz4XvfH0U
	 LTtdvJF16MW1PFiNsshnjMXPesMGxC2wPh5dL74RLhKN0PwQnZ7YFSC79MFQ+UUFwpJCe
	 6JxpXD6cObSoD3dg4VkwE6xHkJaSevr0k1780B+z2gHp5TV+6sdUnXXoZKBje2HZ1NKY3
	 ycpEMge67DrjB2uQjR75plzFJONh9z+U+WsnEhSdXb+ymfnrf/bBy+9GuJn9SzLWg6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A63EC1F000F0;
	Fri, 20 Nov 2026 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174171;
	bh=Y37M6X53zj2OoiECpLvG7CtVOaRukAX0K98e9OU1yss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GcpT/TV7Aup1WLoE9b1+tuQrk53tSeVoA83GG20nnrIQVKouXuUUsJZuey0XbvXnZ
	 LH6uC4jC826Jk9yN2fJIPGoxcUZV1f0guSBZf5QJ+H3bAcKvO0U7pfbbcl99ck+K94
	 5ViKlNM6uBzKyTg6qwDhxxKH7+B7/qiwOEQlsGA7Yh2qk48SavbiFcloV9ZboP/brF
	 HoP7BfGxyo3V9B96s05kfy0b1mbj5hgJEMlSCNO/a+8HK9md0nRIHsuxImPzxTyKUb
	 lxcRemz3oiqfrPCzMQxrGii36xgtFgzJFoD04CSg1EAkET5uyVaTL9AtKhTorezT4f
	 jzKpza8oIE57Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3673249846;
	Fri, 20 Nov 2026 11:29:24 +0000 (UTC)
From: ILYAS NHASSE via B4 Relay <devnull+ilyas.nhasse.skf.com@kernel.org>
Date: Fri, 20 Nov 2026 12:26:47 +0100
Subject: [PATCH 1/2] dt-bindings: iio: adc: adi,ad7124: make interrupts
 optional
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
Message-Id: <20261120-ad7124-no-irq-v1-1-7826c5c3fd25@skf.com>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
In-Reply-To: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ILYAS NHASSE <ilyas.nhasse@skf.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174009; l=1125;
 i=ilyas.nhasse@skf.com; s=20261120; h=from:subject:message-id;
 bh=OBY5HTgouzEhhyqdI03rWKM9m5ChuW0YKJiNCBaU4UY=;
 b=Q2kK1uSKSzFCdszJZr5rQwVp9XvjHFUET83hOJYqdsVcB9Mc6fe3K2mRWxtgmi66591Kz6kkN
 RJ0BarhykH3D72bN5LFAoUl+s/T01ZFYW/E9DIsr9Tpnhff5GJ9Hkm3
X-Developer-Key: i=ilyas.nhasse@skf.com; a=ed25519;
 pk=DeEyhWzUoP0HCAWFV/8oy5EFF+41tZxPpWZhfGyiMS4=
X-Endpoint-Received: by B4 Relay for ilyas.nhasse@skf.com/20261120 with
 auth_id=1581
X-Original-From: ILYAS NHASSE <ilyas.nhasse@skf.com>
Reply-To: ilyas.nhasse@skf.com
Content-Transfer-Encoding: 7bit

From: ILYAS NHASSE <ilyas.nhasse@skf.com>

The AD7124 signals the end of a conversion on its DOUT/RDY pin, which is
also the SPI MISO line. Using it as an interrupt requires the board to
route that pin to an interrupt-capable input as well, which is not always
possible, e.g. when the ADC sits behind a digital isolator that only
carries the SPI signals.

The end of a conversion can also be read from the RDY bit of the status
register, so the interrupt is not needed to operate the device. Drop it
from the required properties.

Signed-off-by: ILYAS NHASSE <ilyas.nhasse@skf.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 2e3f84db6..875f46477 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -76,7 +76,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 # Can't have both clock input and output at the same time.
 not:

-- 
2.43.0


