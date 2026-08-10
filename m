Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9A39CCF9
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345895; cv=none; b=U0g8BWKkyndJMQRO3WNcg0HaAWdeWcrB9McbFfqluj7kxJvdLpTAFxGniDQrFJOrx8TpPZ1//uSn8vWYngoPCl6ficmbF2pJJ3VXCL5fV6hN0h0OIj7jENR8J8aYKFlhYY7bLGflH/kqtq1PAv3CxOhVAfitHXbki4Zs7kMN/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345895; c=relaxed/simple;
	bh=KGc+Z0F5Jfw8ScvcfiFrvk9HhEyYqd66fY0XDHsFkhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjnDwcl03L2GrNNdTF3LBqwN5Cl0Zax/IISpwX2SR9msoxc3yriyO9VW3MTgxGCmhAs3F3CTReiNfzvJIliqKyQxGemICDadGu/IxETQWtd7EFye08biClucDpjZT5gXlFsgsUy8jB51LTfMIIMX3cXZEDr4i/JkIfi1JVd6BuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=g2B/JJqM; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="g2B/JJqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786345889; x=1786605089;
	bh=Mo3LpkcaoyYE6UusSztfOfDPcFiBUeHo7hDZGdqFz2E=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=g2B/JJqM43Aopd7V2UEs8zrFdwpwBYt1KWPdH7xLoxNVViNPhxWi//ferIxcAuBhX
	 9sG4IC1nsGBLiph3j7etF72/PhXFEwXwgsbZDu4bTvyDAVfqEz3FIFvsbZ/OSG5jff
	 I5mx100Czw4KJVMG2F+FNApFRAZoSJFi6W9fyLXTii6/JHmvY2KxkFPv/FJ+IA1wL6
	 z4dptoofs6jCoxvoS9C9kuYsLKnSohxJm8PHjgqDN9AdWT8wOp3XvFVCKcj863gLCw
	 4snrLn2Ua5daGmWazukp8X5f1qmtswHTLeNqY+R2xzrUQAXVmNHGBUXRVCriAGF0iu
	 KJY9fXazhmKkg==
X-Pm-Submission-Id: 4hJQsV3Qssz2Scpf
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:11:11 +0200
Subject: [PATCH v4 1/7] dt-bindings: iio: light: ltr501: Sort compatible
 enum array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-liteon-ltr329-v4-1-8bd3dfd15280@geanix.com>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
In-Reply-To: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, 
 Yangtao Li <frank.li@vivo.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786345884; l=936;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=KGc+Z0F5Jfw8ScvcfiFrvk9HhEyYqd66fY0XDHsFkhw=;
 b=JQvwtI75WYmL2Wbo57fCXV8ZV027xw7PT6RcpGVcs2ROuRHT6+HjGOJKNUdmcYsjDvnyTSRFo
 oy6A3iAsZuVBq1KfgaRaO6g58oeo0nWF/u/IEBqyF+uB9bdec6ESP/B
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Restore alphabetical sorting of the properties.compatible.enum array.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index c8074f180a79..480523ca3750 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -15,9 +15,9 @@ allOf:
 properties:
   compatible:
     enum:
+      - liteon,ltr301
       - liteon,ltr501
       - liteon,ltr559
-      - liteon,ltr301
 
   reg:
     maxItems: 1

-- 
2.55.0

