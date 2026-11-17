Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938918;
	b=J7w0t8OSELNLRnIb0P0C9BnDTOQH7EdVE2/4OcJGzXhLOFnSdpYr+Oj+s26VY44Rqc4j
	 1rPaytbmbG28DDQAD5O4E5GXYwvrF5B1EDTRCu7EMaBMMJaihspV4gIDXQtLk9VkiCZCW
	 Pk8Aqr3+VTWR22wdYaj6oVeHgdVi4JqQxsa7CjMSR6gVtmPtCLuRJo4AVHd7sfg+/mXqV
	 5AgR1Pq6qd1Ky5oCZdqZNCVfMSupsC0N4SFiBZvODOaKr3fCBkmVKFvufkPeubaQMeCO6
	 o/498VPBAduVKSesmq3QINF25xyc91LbU7cHgFiOYvX7wIgxmZQ5JYKANDI/JJX25cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938918;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7fw9cVy9LFL06Zj91dl/O+J3VpEWDTcyoju6t27W5f8=;
	b=ftuE8jrFURxCLID3Z6aprWa4Dp1YvNAOZI4T3olv/rGpU9tWpRsexXxsHGCLxy1LN70p
	 LP+sq7R+Np+ERm9tv83CXqRHIefeWkNJ71IReHAr7FlOcQxEDCpOS5MbSElkN25xIE3Nn
	 YIsnNmQ3z9qTWnJGw/iX0jkXC8qzyOOddKCK6cM44qjwwP0lYYuEiwBKCjcF0wCvyHAJz
	 wjamQHhC1uP+pnMGPHf6DgkMTUMa+1W6FzqVM+QpSCIu/foxr9U47oXRwDSy7eAdc2aPS
	 zwqxk8TgwCJNjE6hL3G6TYjfzVVP7+9akm5VC2LJZSZw1Vq8QMGRsndeIwNhz0NkRIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrunS8C9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDFB606A334;
	Tue, 17 Nov 2026 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrunS8C9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938918;
	b=ovR29KwuZWuB+4qb64pqEb3N9Hxkz2j3JcvrVCyfm/AoqUpiL0z6twadCtvg6gomCfhE
	 ywlbvTIA68mo7gYEoHux7DM7Ei50AgmROaI+FP35ENg4yx+BvC2F1pSJd4icUqRPdM1hD
	 OFCFbUolS7EMFeeT8bxkzY8W4JLsdN1UxcSrsN12YnK5UtaGH/nTXnH7CiL8gPpHuKZmD
	 EHsV7EtVXvSAdvKXto8LVNOmeXnjH8GPfUMmT8jdegmrSgCeLWaid9v5/CMF+1oClUNc2
	 X79CMJFT0Px1mY/cDhCCc6wwZaYiGcYe70E+k5LOmF31paUI6gZE2ciVeSs1CGrT39A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938918;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7fw9cVy9LFL06Zj91dl/O+J3VpEWDTcyoju6t27W5f8=;
	b=XBrnFJbAVHzdumaf0QLA9q/jYnumXiAMAczeGYYJN9YS+ZIAc7rtKJSkQdRaQ1IvzghM
	 bweLTVcTkjPCcjaAIx05+xvYARz4V7sEkW8h1DcdA5HmK3Ouo4GTKgfwlXKEq1Zh9vXn8
	 C8RTpdo+tt5wdP+tM1mjRSGwCsTYmu9U1adlhKebwMxEK6ONAB2wbozp9H6hyq1uaPc6E
	 DG/Nu3+lCgBElbb6XBJrosjgdgY2ucCg6U6d23tfePsFZNeaZLBs7DTSKKeKt1rdytWHF
	 58mMegQL0R/9MfUJwHQxCkAvBXBH7ocMuzZyFo6EFkgkqWyIhv09akOmcrBlt+MeAmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9B4D81F000C5;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938918;
	bh=7fw9cVy9LFL06Zj91dl/O+J3VpEWDTcyoju6t27W5f8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JrunS8C9664iaN+lD4E9jZrIHyatdtSNYGij/W1gWQOOqoeOnkdzeb0FN1iPoDRUz
	 njnIA3z5FhfaoFIpoOkEMu/rocjHff9NDK0Ub/DKuR0wXzEeQGbqr5TXB/YnbvbTxQ
	 vrAhEbpsBXZVoFx5NZztu3BOr26B0ySfGdNPw+bcDJIECtjNgK+vZhO771om3bjby0
	 st55FNJDpX1ZSLfnrKZYmq7xEeAKTIzgiKGEk0bB29aXTmGLxJvVkkhTRIzg++FxWO
	 rMZgGtMah3pe0r7tOVNtdCRcSw6jRaPbSy3fl63tQtRFhabSk5EC7XowXa3tlGF/mg
	 eOocJiIx6iRhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 177A94AA3F;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 17 Nov 2026 20:08:35 +0200
Subject: [PATCH v2 1/4] dt-bindings: iio: light: stk33xx: add power supply
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
Message-Id: <20261117-6768-stk3337-v2-1-92f4c7be3bc6@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938915; l=793;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=diwcCURmKRJT1PWJdnMByDcutmnsbaDcpEkfCbV6CHw=;
 b=gMygiIVHrbmRjl+dx9CR4BESixsupRVRXvlKv6XXxt6feRRYQ5EMNd8bzXwvciT3kEqLx8C9C
 FSVJaduL9yTATnpy4+AyaXxZ/Kl76Ho8qRJ7+xN7d6iH89bJkaj3Tly
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
2.56.1


