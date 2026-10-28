Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793226268;
	b=X2kCyg8BEfgKpJ0VHMzG2KVeMcy0GboNFiO5QLyBqFYTexaaZi6f/owJmS/iLaqm/Krz
	 Gzlgg+n1VvurHBsdcxjC8yT2SQzbEBjP+WHZWVvPmzS/4tDwIK8pUI+G20zo89aec44ex
	 SJcv9B78Av4UQa7S1XTVJe/lzmpDpzb4T9hhpfyDCfNnaw8+jzyYr96QfYzesp7nU5/n9
	 2x+D4ZcRW3kMAABaNKQBfv7rUjn0tWD7eL1hEfygPeLQs9F1ztjppNbYSaVXCHlfSo/vG
	 Bp7CwCyJ5Ixf4h+9yhkFEZFADZGuH94NxGfYKIs58zN7i8Ol4SLoTjs8fGSGn2Ps+SA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226268;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uFSU+aeHsAKVY7YeJx/HOO1DRIbefEnPfAwTDHocE58=;
	b=4CLZdAaijkacCLuTf5+xjvM6kmqBajLgsktdQcf5Q+WWWvFGLMg4bx1oj6uUMrEtUlq6
	 O8A3LRvsCB4STH7PdLvCKM6MuXTvXlYn1E2K9MhH3frrajusDKacVBlWvT1K1KIsV5oQF
	 fAMfZuucrI1VtTDhpjfat8A/qi35sPHlNDmBxH2eAs7fWu2vF5+96Ydi62t/cSKoW/IoM
	 Pvp64NC2t/3CB4zvmbrsv0AZgV+3VN57Fks0GcUczpDuDIgdd3QWiizGGOOLB8SiWhbf0
	 0+r4IEk7Tq203tijxJawOTIHwyj13AFYAMlOsZ8cEJCEJZ9v7n6U5s6bULwY1574dLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fARgCNb8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAC606A31A;
	Wed, 28 Oct 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fARgCNb8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793226267;
	b=uVkvb20GwhJdZX0OFCx4iLp/WeOlbI2cMXJXr9uL1NMO87uLOQLalrSFy+n5MjRKa3gT
	 +j9Ja6Nx3q8rzPl5IfJNpm5GXS9hawceyrQ5hCEa27cSO9wcTzzY/7+A/oddhYME2UNs4
	 NFYZYzVoizf4Ug2J9WcC+9HQmPWezDNUMiOKrB6t8rJPqH54tjkc/BmarWQNylhZ1w30D
	 08vrkFkttQJGPDLHAucDoUkry6g9w0sjzcOiq+64S/2CkcWjkT6/RjImSFX+U5XeSQyku
	 r8qkZEy/wM22ffSBFAw1UFEemtot1qu6RXJSTQ60sJiZN5GbrfILbyTw0AKfeb6uXHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793226267;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uFSU+aeHsAKVY7YeJx/HOO1DRIbefEnPfAwTDHocE58=;
	b=oC0N8gEr22hRrztCMGK/NBvV1rh56W7JSYqPNSxLaD3o1nR5MjBglPQrdCHvR+pUJkKV
	 B98Lhoa67fjDubGCH06Y6PWB+W9RHkerv7GFjC7x09rfOO9378FP1105TJ5tQxen1txGL
	 smtPucG1LikdlHmfYMNk4T6tLqyHrbJ9CqUnthl73O+k9E0CkeUQ/F2IXXk+7/F7iFNOT
	 M2kpDHUvdwhwZJcgxoUPvKuMaFcXgvWG5b+p8RCcBZT7dWm29LczVbPc8QlHh1gKBHKby
	 bgKcc7Yz+0oeM3NN0ALnbVl4vudnkG6zfbBoKQbdJjRr76j3Jw0Z/tSfvvs/Di6nJrw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2039D1F031E1;
	Wed, 28 Oct 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793226267;
	bh=uFSU+aeHsAKVY7YeJx/HOO1DRIbefEnPfAwTDHocE58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fARgCNb8lZ9uVD6GvzGSCaPgm5WEn6cyF/XQAoSU/bHwTwewXP95fVNynU+9MVj6i
	 lIJ8LuEE2NOQcOjcc6HfSXIHrOZoC7+p1AIumXpYsn4ZeyoviJC8ADt03/xcEHzfZ+
	 EiZ/DArqTihkTJIcqEWkEX02NcerbMAT60INsXOsndeIXZvlTlHhghsrErzohAlQRT
	 HC8n2O0nV81Xms62utoo7g0J3ZeeMamnd67V1rU1w/5CZGRb8bj7q6XumAZV+FxqmR
	 6G/Wj1VTmr5P8vw57Zz400HOhgA0cwgA1iEYYFf00psr89SimXgdzGu7ZQoZsc1qIK
	 TvUxyXWDwJlig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 856DE45587;
	Wed, 28 Oct 2026 22:24:26 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Thu, 29 Oct 2026 00:24:26 +0200
Subject: [PATCH v3 1/4] dt-bindings: iio: adc: lltc,ltc2497: add LTC2493
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
Message-Id: <20261029-submission-ltc2493-support-v1-v3-1-c7dd5f877c3b@analog.com>
References: <20261029-submission-ltc2493-support-v1-v3-0-c7dd5f877c3b@analog.com>
In-Reply-To: <20261029-submission-ltc2493-support-v1-v3-0-c7dd5f877c3b@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793226265; l=1524;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=T2VmvK5HgSldCJfHyZJnEpw6mY8RtrAg1+eVehWZAto=;
 b=b5f/ygo1vt0gNCeN73xEznasmrlWMZ7GuK3EYn8aNgJwnMEorJGeG+CwBJg1TYSsq0K3kW0H6
 dSezc/dBHQVDNzYM/gVptoKYgKWDSesllbqJBA4+c0OoKOf+EXtajtZ
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com
Content-Transfer-Encoding: 8bit

From: Andrei Stancovici <andrei.stancovici@analog.com>

The LTC2493 is a 24-bit delta-sigma ADC with 4 single-ended or 2
differential inputs and an I2C interface. Its channel map matches no
part already listed, so it gets its own compatible rather than a
fallback; no new property is needed.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>

---
Changes in v3:
- No change.
---
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 67445ad2bb3b..4df5aadd1e1d 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -23,6 +23,12 @@ description: |
 
     https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
 
+  LTC2493:
+    24bit ADC supporting up to 4 single ended or 2 differential inputs.
+    I2C interface.
+
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
+
   LTC2497:
   LTC2499:
     16bit ADC supporting up to 16 single ended or 8 differential inputs.
@@ -36,6 +42,7 @@ properties:
     enum:
       - lltc,ltc2305
       - lltc,ltc2309
+      - lltc,ltc2493
       - lltc,ltc2497
       - lltc,ltc2499
 

-- 
2.43.0


