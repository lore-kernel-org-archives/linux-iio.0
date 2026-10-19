Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792451863;
	b=q/6uCWj3jnjVs5rFZzZJF1Yj3F+DY0zv4KAbgTNYFxvDfkV0PwqDS004RfJkmf+h2ik5
	 SWxOKEZG3xH77ngp2v8coaGeNra79X22FOlKQxz0P8/sjQTWAyO+cLNZGM0yJFDqDOzdM
	 97m8OnPnSMJ/huYHvR0RZrjHOSFFpPsxBzCmfHUKDfN69yFEIwzCRKx5PVdDiPxLsC2C8
	 1paORhQLCORZwLdOlnmIbyE63HIOGv2WqxPeivCvwr+Bu53XBE6IEVjqtCtfv4kbkx6MS
	 vzqqWC4NnVoB/CWsauSStwCVhI10BymgYjb3bkx6IJCtWQ2ST2rO/g6jbQJ25gFig2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451863;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9Kc73cP2+fsO58DaNbGFzlKuEWhIxmGdpTqysUfvuWA=;
	b=w+u+lGS85/RxOCS7Gi5lQVKmti4NJ7XuHf7kSs+vU/xf2X3360MTkJNYklkU5VjoezfN
	 ksJXj4fUK3dk40rND03tBVr6/UD0CNf6b5xBjTjas46x9MoJV3aXg8gX4JPwSYvIUkH3B
	 V6E5BJEUICHefVwaLdt6J0UUxYly6YY6hnxQT4YX23Sqms6zzlxK4TVHHextjkZYBe8T0
	 e1iHVbDfAon0JDShIhdmAIBnhE/Z/i4vguX2D6bAZZEdB9qZ5mi1n65IhRztKsBlUXY7s
	 YQuuCXwN/jQIJgelyAugQuGNgUrC+410PmEktd9wioLF3ObaHzuDgmM0df9w/8iDC6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvPWb+sM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C8606A321;
	Mon, 19 Oct 2026 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvPWb+sM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792451862;
	b=x7QEQvbKXDbYVOL6ZL3gdVH5ibCSu8ArhAQS0mTIbfeNCfblG/4DoNhwuJnnCL7MNhOC
	 bAS4ifcoRrwuQFbTQB+tvioUvAnyhCXyWh6Zw7u13pRG8GqFafynuX7o6FIbzEvteqYC3
	 H+Ns74xzdgunH8tj8zxUSNdGB5GK5LoIP3YalLtwMSQet106nHn1KVwrJKf1eV++fDm0/
	 Mbu0k7is6VKOJPeNRQe1SnzMLqqDXdK4OLCIbSX5sZcmNee6GbB/c4NtgpNsZ1G4j8cML
	 MnL1uszHQAiuUqnewm09Bbr2xW148s6aUgcL0PxwgQIUedeJ261GZJlikjFsTqwsPmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792451862;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9Kc73cP2+fsO58DaNbGFzlKuEWhIxmGdpTqysUfvuWA=;
	b=ggVAXh6Wvz395lmEXVzUMh7pZDzXyNgskNiYeYwDWw5psIecqlTa/2r4H/DDnwLlrdGA
	 K9b603omJJPuZFMvToB5mHyxDzsIU8k8XtPMlkqOdwnMTc3cVeZGdSe6xKst+P6Iaf3AO
	 UEn68xExhnKhuuxEQyFPd2W3pBwPu/ljsiMaYNbgpsGJYc5koYrhDBL37sMVw1YcGzGkC
	 0QBCCF8zrhjHsJG42vGlwtBS3mSizZxDP7mhZHy44Y3uxWhvOytMArGlKkc5I0w/zDYY7
	 49UBaxR1cdXN6vqT1wQV2TjMxXDZukDXJQ353R+keKDnMRM5Szzw1z3CTZdvSAVyBiw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 26ADA1F000C8;
	Mon, 19 Oct 2026 23:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792451862;
	bh=9Kc73cP2+fsO58DaNbGFzlKuEWhIxmGdpTqysUfvuWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YvPWb+sMxrjsutuNcoF4bDELFAUF4VZrqSRwXFBM82Hq2DSRDuwWdtkpYF5WijbVH
	 e2CU+w7rG9CF/94jpJX+X1ywauy1I63boKjKAROUNlFQMVPdgdaSbHv/J/qCEw3Nzh
	 Xs0aLzBo2kRvKBGA7wxvqpvKcFO08zDjXkhx52/WlzZQ/2CIFU0vVXYP+nOuEuGT+Y
	 FbEotK7SpptHYrQz8KCjEPisgc9f+A41wp0AjVDQ14K3UNrH97I2V6DGHjtJzgsB2x
	 AJFBgmYPRwp6iyEZAPDHEiyo6JSqgBm3TavP7sPQUovI4/BhAYR7D/lnYje75mSPbY
	 t0i7aEnK9VMkw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7F9D1406AB;
	Mon, 19 Oct 2026 23:17:40 +0000 (UTC)
From: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Date: Tue, 20 Oct 2026 00:03:41 +0530
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Benewake
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
Message-Id: <20261020-tf-luna-v1-1-53a88f93db24@gmail.com>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
In-Reply-To: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vidhu Sarwal <vidhu.linux@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792434836; l=907;
 i=vidhu.linux@gmail.com; s=20260713; h=from:subject:message-id;
 bh=3nXcOelYeuYgIZXnvr6k1TA5JZRFGS+HfeRVRLAhW6A=;
 b=iqXLKAyV32p3msPs7yjRhiv5ucr/d49obYUpveOF8vtLHblFap2qWzj+lMUjMgEl/+PbzkBec
 aRLV6gpz3b1DHIiggq5QbPB+BLn3WCYguIJj3iGKFQmOtAax5WGsm5s
X-Developer-Key: i=vidhu.linux@gmail.com; a=ed25519;
 pk=xDu3Cbesz76CQXwY8lteI74n3ELVIV7wCsuYAvcX1Q4=
X-Endpoint-Received: by B4 Relay for vidhu.linux@gmail.com/20260713 with
 auth_id=869
X-Original-From: Vidhu Sarwal <vidhu.linux@gmail.com>
Reply-To: vidhu.linux@gmail.com
Content-Transfer-Encoding: 7bit

From: Vidhu Sarwal <vidhu.linux@gmail.com>

Add vendor prefix for Benewake (Beijing) Co., Ltd., a manufacturer of
LiDAR distance sensors.
https://en.benewake.com/

Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0ec4e481c64b..7bc9c071913b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -245,6 +245,8 @@ patternProperties:
     description: BeagleBoard.org Foundation
   "^belling,.*":
     description: Shanghai Belling Co., Ltd.
+  "^benewake,.*":
+    description: Benewake (Beijing) Co., Ltd.
   "^bestar,.*":
     description: Shenzhen Bestar Electronic Technology Co., Ltd.
   "^bhf,.*":

-- 
2.53.0


