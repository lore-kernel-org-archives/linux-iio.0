Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C4413799;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535416; cv=none; b=n+pCpgbiT3hHMLu3g1SZY7DX0q6qKf3K3VtJmJZxXvA2jM8GtSsN60ii/++vANYgCJUcdfby0Egdv3cH1IKf3ijY4tJ4FwcML2E9xzqYK1+hzAzULDce+4Jtxf/t68pVSERq3Fu/xRfcuIl3igVGKb2TGngvpLmigcjl/Ue5cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535416; c=relaxed/simple;
	bh=lGxePWZrWnydAzY0lNkWlowClTyB8mdS+fuJ8Rx+eJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/uaHCZL4quPAycQBKH+xirZ/VxBy0aQR8nBHPm/ztr9wqkupgZtU2enEFyPleSBO0HGUt5PPURqLMwt3vq4t3atJv5ohftUNsdISqv4NUsbb7gAFwu6UrtlzWQU/zyu0rZ8ccJ00c+8Q0cnza/0lddz5fIM7QKtR42dr0TPn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3f8LwTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3f8LwTB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65EEDC2BCFB;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791535415;
	bh=lGxePWZrWnydAzY0lNkWlowClTyB8mdS+fuJ8Rx+eJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T3f8LwTBgbklyzzfb9jI/xxDWD3hyXCkzUZiPOtmTQpgWIMlvQ04AYvXnv3LxxHXw
	 Dw4BMNkN7BPw1o1BvPz+96lovajRp5Nrq4PSu+ro9XcSAmIkriLCYGClX5fAA4q4Wf
	 NamwHEB+IT2g7oD7XJuEEsnX9aKd4CWqhp28bSGV42RJTGHiiGLKOFcFoJ9XU9c8kh
	 XIJr9x/4r+eymroy5eVNghnDiL7X/QmT79aqojKcciwZo/iXicpTuLPB5urF3r9PtK
	 oZf/vmJdqKRpdqM3bx3mM6T2+xTreVx7uQtR3s10YzebhvWZKC38JNe3Cga6XoTQra
	 hTNRUsWk/nIQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425E6CA5FED;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Fri, 09 Oct 2026 11:43:34 +0300
Subject: [PATCH 1/6] dt-bindings: iio: adc: lltc,ltc2497: add LTC2493
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-submission-ltc2493-support-v1-v1-1-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791535413; l=1335;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=fP5njPLKeeNkILxLB5TKnpSRBSVEO3zumSVwQ+hdWcE=;
 b=ypbZCODq79zS5UhLlurwo6DsrNFtM7bJKoNiS4n2UZfOHT2BQNMvgCV8nYHwDwlobjruBa6UH
 BEMdWJsdEM0B4CI9ePuwBaSKAHiwKE4jxqBmnxcVsH7URxqtPMwj6wO
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com

From: Andrei Stancovici <andrei.stancovici@analog.com>

The LTC2493 is a 24-bit delta-sigma ADC with 4 single-ended or 2
differential inputs and an I2C interface. Its channel map matches no
part already listed, so it gets its own compatible rather than a
fallback; no new property is needed.

Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
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


