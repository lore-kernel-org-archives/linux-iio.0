Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2A4611C4;
	Wed, 15 Jul 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118820; cv=none; b=rbpnCsMkzPAjSHWJViO03q1ZKOhZPENMiMLwul+i3uEF+jrPd2CbSIeUrChXEagZfaDR9Qn7DV+X2xMLcuQT1KgY/G3zAUV2wpBblmH/OCX7N+iifNF5de2JQMeMZy9I0lQPkSqeDeEnykzE6xC24OvLYmn6pSmTelbWuxSO8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118820; c=relaxed/simple;
	bh=3wQ39MVMhwv+sIan9nmt82Njg/lpuBoBHDNh3zcHydQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rm7A9G4YtEOMbSXytEp1HwAsPNfYEfK+v2HjbCS2MwKpn7w9TgO5iMyb+yoA73akGfTCijP0hemw8T6Vgwe7+98xAvJ13of75GdkP5QyC+61HLVgpw/WbfnGzUFLKIwIO9BPvXeqIPptVY11uKiTkuXsFyfRdDIuBIeatbjb7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=p1XwE8/o; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="p1XwE8/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118817; x=1784378017;
	bh=BS1MUbZtDgZZJKhSMPDLCd+i5OY758wRtoFm/U7AmUg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=p1XwE8/oDm51Gh/Fr0xW637XGDsAD1Pfmjbc8XNHqc/o9aUbZvi5TqJhpD1oJbTV3
	 CN2rHRIs3eRSlCz9qBOFYUvQaMttdWpMT30fk5hsOsdWcrjGhpjerLYChkIQ/EeRpk
	 wroIu7xcSzZPleEWXNHW7AI+oY+YrS5anRbjSAGAbjKfBuZJBh2/RM1mZr/K9Xed0X
	 mpAIHsG9qPszQPxn+rulcOm5qPtnTP/pZ9VjI4dxS/wUxxb3W4RQIliHXv6fZ0/1rv
	 rhtc0UL87z7zB10Dk9K22yOGERtivojz/GZkYty0WGVkNV9jBDKMA6tQAmFuzjuKb9
	 j9TFFSGBNIGLA==
X-Pm-Submission-Id: 4h0bFB68gQz1DDp8
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 14:33:27 +0200
Subject: [PATCH v2 1/3] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-mma8452-open-drain-v2-1-95be9f5f4795@geanix.com>
References: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
In-Reply-To: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118811; l=990;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=3wQ39MVMhwv+sIan9nmt82Njg/lpuBoBHDNh3zcHydQ=;
 b=g+y3mH98C8BnYzi6CsGOZHbgM0kVLxO5LzRVBt8jW+bxvfAXGeGm/ZtA54C8qYFRX1jS3o90S
 YcKo5gvTmhWCNvd12IsOqVv1534aqU4x0/VgtXGGOIh9SrE5EVvnRUe
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Add new boolean to configure selected interrupt pin to open drain instead
of the default push-pull mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
index b0dd2b4e116a..20701aa725d0 100644
--- a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
@@ -39,6 +39,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  drive-open-drain:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: the interrupt line will be configured as open drain, which is
+      useful if several sensors share the same interrupt line. (This binding is
+      taken from pinctrl.)
+
   vdd-supply: true
   vddio-supply: true
 

-- 
2.55.0

