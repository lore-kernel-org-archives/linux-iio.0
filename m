Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089706;
	b=ZG6EQE0c1bsZ+tMZQ9OMJk5jYq8P3cTknWfl+oDJmtU4bayZ1NOpFgXi3sHNWiBkV9Kj
	 K4zoT1EL9uARFfXoBtTYl++Fiy5UnQnpYcbt0j83yuhAx52/OAetgpLagnn+pLpJEHznd
	 FE9HLvgIzR3dqkg0qHK6sggK4M6F8M7mYhPATrFIakoOR25tue5+vG0W3WbWYCVl3bhQc
	 CGTlmrjNtC24yVYdjiqmzPr2aZ7yABD5J9Qvt3p1EBPzLGrjhiZY0acJEeFh6jDFpzFPI
	 XSWHEUBKlgdJA1mUN/yCKm8C7BEduKlDGiS25j7L1fv2JUgX0Lc5EzSfyknBjdWcCNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089706;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fvMUgr2Pf4aS7fcyRjJgQwG6E+NErdq6wvoU7TgeB60=;
	b=xF5u8T2bv9LsQUzU+mXuZlBA+KuPm9k8sq/U+H4bQIGOXHu42rvmyWQIdafShG52MBvG
	 NDd1bea6rFXM4pn6oDK5OFw8/3COySMAw1evOFxEu1tGMElzFw8qAXZXXOzsp/C7ioU/A
	 fA+7pSxenzxqGa5rzinLiToPGGRsykiW/tDYGiS8FzPtKwWvzJwUoIr6DbdL59dw9qw2C
	 v9zsS0Hf/Vk5JskNbXoLyfL/i7XZJEfFU5iciqSzkqxg8jRlVETQGQBasS8y+yOzyf+za
	 4MIuvLprUBMlemzV+cbp6ywI89NMo9TRpVptAzZ1CSmwkW0k3UfABjhrWhERWZqC/AA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+fzoPcX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB32606A326;
	Sat,  7 Nov 2026 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+fzoPcX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794089705;
	b=UD11IJmNdQCKSCvJOnweNT9pMxJSmh0KafI/MwNwnWoUVR0TnvWQ8s2xDPxfKlahkI71
	 m20tIXim89jHq39hb1bJ11BkKpfbeG3ceomw3fiF7nJYaGf2/qKShMktPHar7cri/p0gH
	 pnX14IVGYUNNeRaj7HN3xoRaV2kVYiCkYB9ha/HIT8FedjB8eX6cSq8Pywgd9MIosUKZ/
	 aX3mXs5abxyYzdFN4u0vWyxvaVXTnOa3H5vAE6y1Q43h6+//PFbBvgnvemjT+tq3Ci6io
	 nAz7otLCRxv+OqN3U/YnVEdUNcTl+CL9ubNvrkCG8gHXq77qLsuJrFWbIYVw/ziSTfg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794089705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fvMUgr2Pf4aS7fcyRjJgQwG6E+NErdq6wvoU7TgeB60=;
	b=qQFvsxTMz8WKdk4XFttq8xch5FY7ANJGtYQNi20JmAJxcJ4NocozXEFIF5XAXJm117ph
	 OepEKfJYDRT4TwBurYbyleAAbzwRJurl5S9iHQkZt10YPHg8WLpLF0Ftql5ugW1aGLxx5
	 SZtPhk5royiIUYlHN0PoovVg1bns3cjcVOgDOS3Tu4XvQFIgZLqTaPl3LEUTpgbmdWsLc
	 F7//h2oyGJxz8XL7JnzH42ruC0GMoMYTS6D2KiknCeHZqrc4+wi6HlIRqtdM4yrGmvEbx
	 oAvpx379aApcVoMlE3NGMVG1EzKexINVeI0aoAkWk4ZKzBwpRIIKKXuk7aYKjVduGfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4F29E1F0089F;
	Sat,  7 Nov 2026 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794089705;
	bh=fvMUgr2Pf4aS7fcyRjJgQwG6E+NErdq6wvoU7TgeB60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=X+fzoPcXlWfZhiJogvtlPfi8eGujPbVljAd+MERpMlnt55ocjLs/7qdyk7fpsACYS
	 0XcNW5Txs6o+3nyVpIwI0y+bYGO+3biLKARP8e3fztXIhC9prohKf5Aepub/WtDXtC
	 gJkSOtiIYH6UjBsMgPVV6AbQkYCp0qo7lB8bC6PlH2DRkWAsHgByjJ0iLEYCHIEQ0d
	 jX+06n3qf/KmahVBjllmJDXB/DclkmIEXVlUExEG/Meg2ysIPiIFOzSFVOyFSDcXUW
	 an74gWiXTjhzQskXVITYsE7fWk+q9jXpEmd9d7WtsjJQXZ6khpT4Sr58wZiNsmzB1b
	 xqiENu9xtN8jw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B97E747D0B;
	Sat,  7 Nov 2026 22:15:04 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 08 Nov 2026 00:15:03 +0200
Subject: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add power supply
 support
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
Message-Id: <20261108-6768-stk3337-v1-1-0340c99b0e33@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794089703; l=793;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=x8nHkuOMCRlGWNtSD5SWWSe5SMQXoEHnJb6O3YMuI98=;
 b=8MshztMUPTnAKqk+5/oukJTp0z07LyWtCipRipIp4D3AJhO22iNu71WtYYG49kyQl3gKuhGFZ
 TPIA5vissZsABhV5d7yMZKWC9LDB2md2zLybWTvUycD6DtEcZUzmwaR
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

On some boards, the chip shares a power rail with other components. If
that rail is turned off, the chip can't function.

Add vdd-supply property to document the chip power supply.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index f655a570aac7..114cf87eb54d 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -37,6 +37,8 @@ properties:
 
   proximity-near-level: true
 
+  vdd-supply: true
+
 required:
   - compatible
   - reg

-- 
2.56.0


