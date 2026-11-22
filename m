Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795367807;
	b=Nj54G6kf7h23sNjV/0pp/PCyTMaXPNHTYMwg9G68f/uD/D9wXq2ziBRaN5N/LgvtFfFJ
	 ZrPL3cY5WL0TOF/qk9S0b6VOMsF/1FpGD9yAN69TIMD53y2NjHUGf6eavIhpyjCu1eumG
	 AN8K7Zjin0FHJOYO7KSL53ClIFgZa7ysZvmdIZS/2NRvwAQe5W7zxfF/KicRhp3wdYhob
	 FfAV9slb/RRwoO5SC/SmtB+yyYx37s2BmlWYjAFtn01aLUb2Cqv4MZcgsx+CaQoYOzkFj
	 folD6BVpbxsEPG06HUNkKaFbZHew3J7tB2DzThdzDDFTLhdvx0OSbRrurIw9KOV6+Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367807;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=feFIOJt+mi7BFd210jCRbb4u2WOE65Rnp8ijts5YVMc=;
	b=q6vFVbh37dYo2QFc0Achpf0HWe09CoQLVwapnvujJGjfvFx1MvQd2HhjH8rcC/dzlkU2
	 9cR98Q7mRzUVAiVYlhxOJiW+y/EgKbYomePL8teT5VAst9mdkXSjl5jwduINLl30U/nFj
	 SocC86kcie9qkdT3L2zXYHrIbvpIGBWVW/WDydO012ouQr9j2+6+4vyYx4E7rfB9EtCEY
	 wmgyDoAQILJysxkizPqFUTQgA/0HleNQ+CiFGLWnUWpSFuS4kJVASenVSEuGYADyTon/d
	 NTwZS/EC6cvn4H55k5kIWuWngO0jUBxik5o4mMCchzimLrUuoaEgaIB0bpZuwQ6zTgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ew51agoR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC428606A33D;
	Sun, 22 Nov 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ew51agoR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795367807;
	b=bLxP3IDX+3yWJEd3gWijrgPvQIbM17rtIzYUEJxyTgHlXZJOaK3peWC6tvVMOMgZIOLh
	 wFGgB2Mgac6kgk6xBiMU52fGDgIPQj88ugrVHM4nOhN4TVFt+KGbXBxWvPiDziqrP64OI
	 UnY1PLaKAXYT4UhFb+kU6/PLzAJysrUpbri0j6JWsvuQrA8AfiIzWfQUKuyYr9ZcCMq3j
	 T36D8enbG3NzZhjFAj2iDYi0DxGPwO5xlnDpg30Gi0mtSB7ffWIHAkUZt25vxT75rwU9/
	 5+kjGhnSaxW58BjwufUrr1PuNQ5KNY9fDHFlea1MhbcTOh+KWvOrsBRwwleBUvJ0/pg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367807;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=feFIOJt+mi7BFd210jCRbb4u2WOE65Rnp8ijts5YVMc=;
	b=cv2wqYeMQkhk5czoc1XMZc9964FDp6WDbdIDpDLXdgyJyRqAtO76WlmHXV0KFjTKup+Y
	 m3scxigRV64+xG8c1Gu2BTWEVJUB+pSeHKukciHZKxltRK30pXp9nMrO+gt3i4TaPlwxj
	 oX4zIbPC0+7DQC2f3xLCsQ7k806yfRIenzFdavvFnYecE+J1+h1/2vyu33HI3E8KWnDAB
	 MqQq4NsGouNAv3Tt3mxQ8nZuF3MseaMQdfjRzTE6MwGELLg22qd05xq9w1dXnFmje/nhA
	 fyXrcWfvATFYO8caFWiN0dvx97Mbe580Lx9XoGnKda+/iy/e3HPySN7XCmTp2JAGIlA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4ED01F000CF;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367807;
	bh=feFIOJt+mi7BFd210jCRbb4u2WOE65Rnp8ijts5YVMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ew51agoR93rcnIzbl81IrQj/qYmebWL9gN9ZRwVF3QXNBbcHK3Vv/mqNlaNFgv0xl
	 bKCo8xmE7VpLU64LcRaQOjsiLcpC91Zxa1c2rKzXVtmW0uLApdmX8BH1yDZbbf+O9a
	 KUdl7mEwx/j1iiEqsD9utAKFu+AFzsOdXWphg2iEnaUEQD4Nij6qr8adRD6SFNeQzh
	 HBRqjnhcwPp7WDe2lDaWGPamAUJZTIG/lSyd4v8mevOh69+GGFtrdsuSi3yeAxlDSq
	 jXU6ek70txeu6c4Aa8DUnVTMdQ9RgYP2XcEJ697xLXIKb9qrZRTUy7JuoTyy3nog6m
	 ae2krXtCw9/2Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6BD4C4C145;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 22 Nov 2026 19:15:43 +0200
Subject: [PATCH v3 2/7] dt-bindings: iio: light: stk33xx: add power supply
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
Message-Id: <20261122-6768-stk3337-v3-2-b0d0a924e843@protonmail.com>
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
 Roman Vivchar <rva333@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795367795; l=846;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=K0lfaeUytaZbsr4Z3o33oWUq4CFIQqPDfqRUSL1do7o=;
 b=Xm/hoSA5UA5L/+PHxPDRvoNXnFt8IuGClnAh23OSc0rqsynn1lM3IAgCcH/DxlyV2zJmrCkgp
 ZhnBkcIrm+2DXI/F4asc4Yl2l5V7pnW+bn66ek/oAz/Qy6sEcFMQ190
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.56.1


