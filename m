Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792663100;
	b=udzWmOfDy8P2WdvmedCq3SxvxdNR0F6yYC81McocI8UU7hDiR47vLTcsi1e1JZ1hsdRl
	 32xnKbIoWqWiNRimCJjJKMt9sqOV4bL3r88DztnQgCMwPWNZDI2fjkeQzUWCeE3mirB9a
	 w759ZPVgU12etYYJvIS/uumW/rtZhgUHWthWDqQHfkWPGqHqiH/i1aXs8YIe+VInUBbHv
	 ghSygjW2kI11QlqXS3GhwXbMW33bDgWnFHpbW98+KZmLOF3/n5pAcMon/k+E7fd9Q4isX
	 pDiZIvZ2fgCjRDIJWsI1lSJysUuvdWogcekALQpVVwNSe9ejJxAh7DtIBrDZZbj4VYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663100;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WJG15LKr3prslbzYFPHalf3cAbttkFZarYQKovNXhKk=;
	b=Lo4gxIzEmSI2DB7NVgMRpv14lc08dnnA4QB0kyN9UaJbZSWO/I0NnpuES5J3cS/6NnpG
	 025zcysry89wqICm1XpYsGB9gx+Hb1455h63PAxNXrn5DVnlp1LUzPsHxL+NeSNBzWbou
	 uCMG5Tj0LDiOsUw1TgA+3XiAkSw3kGJ+xKwlQDtokuksxIuyT/lcnXzvKEiWgGv6p62oT
	 DnOymweDE2ka7sGFAbPi4iurhjM4UFvhWueAjWgtNw5lZyMjB8j7eFaYpfXJFWiyFo6S3
	 KvfH49W29nzi4eG2aeY/aeUc4hIWXZCXeqUOu84Q6ynBOL56Puw5rNp6i+tDZhQC91g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJ2HDH8i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E70606A319;
	Thu, 22 Oct 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJ2HDH8i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792663099;
	b=vowteRGwv42iZmsy+VIcS072Sgd0fzK+Ol2wjDsZKFmpaoFhh7K+2YlEwTu+9ZrJPkoi
	 MUes5WWJKZjZLyE4aeDzEXFi9MOQlm1T9ecKTHib6iJt0i+uiRlsAacveyR0b9VMQy8zo
	 BR9yLhV83HEdBqffUUi9fRt+537gNO+yFq0tCflYHHl+Wu+LGDMVwQKPmUz/TV9yu1u9o
	 Kjk/AwuXnd9kaRAiTVbVJ3LPjWnWrIXO+A8oFO8tLYPqt+PkGTS0Y+shiMBQ5TqWeyJsK
	 +V724BbXCZ+ynKaQw7qtIHNkVemZpzz5iqmiMW5ZlEdugQs97j6EJMIsMCI7xH779ZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792663099;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WJG15LKr3prslbzYFPHalf3cAbttkFZarYQKovNXhKk=;
	b=hOaX22aIaBkUDQ8Ddeom1cQXTZuOW/Y4UwnWlRPZhaqv1g1CUnfWmOnXgRkzgYM9nKDQ
	 hBM+MzuwStM7jthbyiv4dXHH5JhP+YYC8IrbqCQlwUIwKY9lHuUChy2HxOj1DS3B+rfxY
	 xL4xg/bHj6KBZ3SiBRSJhGUaPtfqrpv9kVJyRD9kOj1WRIGGoSZ4vw/w2y6tgWNrUEyMg
	 dj98zMITljTy3zyciNPaVD6MoOL7oipPOaMlqui1DlaXnHr6xmaabneSi1+zr9y296JFw
	 3e7tnHFGfC72qBVfve4M6806j/CwV94DLSMzZ7ogVfscWWgkcmEy+xzSpunI4u95eLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D3C61F000C1;
	Thu, 22 Oct 2026 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663099;
	bh=WJG15LKr3prslbzYFPHalf3cAbttkFZarYQKovNXhKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IJ2HDH8i7DSJJvDDySjcOvASo0xCqy6RTulcNOevPNOzEAZYN1yRFUTTVnyDiXaHh
	 nOfoMT8wEnlZAhnDLF+4DPND3hls34Giti94o6rtWMVZxc9yxwsCJfSyQcnri6iXgf
	 NGjLp4BteAO+bwq9DUrKe7z7ZTzrd/LKlblLJ6FaK09X/25CfFrB0nKpsxKUorNYbC
	 9Jy7DmE/j1viAMQfbOd4jTBenV0eFWpwMoiGrNZa34rzWydNwsPBWuzciTt3GUXazX
	 yqZCa+oTrhkgqE7BwHTojeahT+6bERlYvSX1Pi1Tjmuao12OtTEwMXsepHTe6c0tvC
	 cWbVE/PCS2qKA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9D32843552;
	Thu, 22 Oct 2026 09:58:18 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:58:18 +0300
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2493
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
Message-Id: <20261022-submission-ltc2493-support-v1-v2-1-391d908d2877@analog.com>
References: <20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com>
In-Reply-To: <20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792663098; l=1524;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=DMf9XMs3htUAAQq8IyO+/UEJJM3kua2TQ4h3+A2AroQ=;
 b=Vsd9BDQ8n0yIfJCuWAp8Ly9bo+CZHov1xtf678kRmTjSYmgnMxGNQpXTtP3vjd+Ksvke4q3qm
 VaLQOMpPgANCgJOHHi2o1TIrUiF/dXb0t2OrmB1p/VY1ZGDIPDHKQiK
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
Changes in v2:
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


