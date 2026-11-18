Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009576;
	b=PUOgvhuoqoll6S8yjYPMgYiPtdllCT4Ikqh6SeWudlbcmjDlzCcIWIRpfGbCxYYQQQlV
	 w9e2FNzk02HTa/h0wM5bT1iPXWfiVO2wLfPftwAch/fCUCB6GqT3HWo5uH4QszpkXPHSF
	 NqqhdVIXyK29f7XqxVPbe3SpUN6Ujn/uJIBODYhfRSqWMV9kZ6fLJnDRQHohlm5b9pW3M
	 c6yuUa5a3a0KCyGoqZcYLfRzC436Aqe+o/px8aPynBkzA4+2HHQVSm0ZJSZAzlZGXzYsq
	 oh47r4nnf4cBmY7Mb0B+9bxoIVikFpeQFWnkQqETfWaQqoSd5UF7/H8tmdZjjYldJuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009576;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=S8a1BR6UAsrgTzm7zCSgfRGRxFF1nwQpZ0t+v8HR34U=;
	b=2xKYKjB296JN0SyfpmepR+a7Jw6NLz3n6T30S0oZbPyIeEWu9i4DOsS6MhKFFTYh0iFU
	 K+Qwouz9g52107uZRii9+Ct1NXfrqWO24M/kIace2+TfVfxjs7VutbWl4pAqqokEnTDm4
	 OqxW7S976BYKEu76WNcv34i4aNqHNWsEwYz9JCqfprT9H9Jo5IIE4bv8sEmsmGTye4XmR
	 pRiLEG80laByuy90z5C6BYzo7POq33s2xu3ZNfykS/OmEo2LYVfT+44HheY+HTDkxmIjE
	 6J6wq8lifOoXHh3VFZ5w7OKyC9Ds0TlSd4wx36CS3KzJYp4GhS/T0oUxhjoRcfFPUzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzM4ngD0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB7606A325;
	Wed, 18 Nov 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzM4ngD0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A465B1F000C6;
	Wed, 18 Nov 2026 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009575;
	bh=S8a1BR6UAsrgTzm7zCSgfRGRxFF1nwQpZ0t+v8HR34U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WzM4ngD0JDWswpM4qaWkc3QcRY/vkvmRnbDYtuwZKj1ZiBU77mjPwIpm8xFbqaow7
	 Wn3pHA+CeKMqLUA1l0NLfm+8NvliAb91slrFJ3uNYekoskBdfSPKOgPc/PZx6cgGie
	 qWydPPigdNtdCEJ8Cxe+aeOHHjjCO5ahQUjn162da1RSbM8v901X8HC9jNau8SbgoV
	 6CLmSV8R15HJ+h1CdPq7vJkDOtC6MO+vzfaR1DLZurdb1SJhgP2y2Iq4vMtVizjxcR
	 KRpAAk/0ZJdgTn6cZYCekpATNDIndIzVBh9/0y8nBhmcSnxZ/Jdg7MLiaXhC0/h5BM
	 0zLycYTWfB/yQ==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 14:46:08 +0100
Subject: [PATCH v3 1/5] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
 VCC supply
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-gp2ap030-v3-1-c8df93460110@kernel.org>
References: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
In-Reply-To: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0

Describe the sensor core supply as vcc-supply, following the VCC pin
name in the GP2AP030A00F datasheet. VI2C denotes the I2C and interrupt
pull-up voltage, not a separate sensor supply pin.

Keep the property optional to preserve compatibility with existing
device trees that only describe vled-supply.

Document the existing LED supply as the infrared LED anode supply
(LEDA).

Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2ap030a00f_e.pdf
Link: https://global.sharp/corporate/news/110721.html
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
index 3fabf1f576cf..afba0b005b34 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
@@ -22,7 +22,11 @@ properties:
   interrupts:
     maxItems: 1
 
-  vled-supply: true
+  vcc-supply:
+    description: Sensor core power supply (VCC).
+
+  vled-supply:
+    description: Infrared LED anode power supply (LEDA).
 
 additionalProperties: false
 

-- 
2.56.0

