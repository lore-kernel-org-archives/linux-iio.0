Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0984483AF;
	Wed, 16 Sep 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546189; cv=none; b=Sd4uofQXky8vrdqRgrQgBt351S5VNMGn/gDuMxS3hP+SF0dqP3TJeaxIBxcHgp3XEUQ+dhwytqwQXQ7q+bauaLD16LhyjVDQNuphZHTgNyUIR4Y+f8sZqD78PGHfEs8zNRZHATRpLz76G8Anr+p2llsq+2hmIEMqClwkdIcd2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546189; c=relaxed/simple;
	bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+objT0xXsDxBeudq2VVoNDDgHKN9BphEG0zXVAzmyJI2T8djDTqmkEYSiS2GtBBM1/hgQDEH71x80/If8irvOgXiIce6P8nFfDaEqX2UNabVjbfyDzIwbShHl3LUbZ5P3jG3Qycisw+ZJLMTSYX1Pu3X4wvmDskWu/hZoRT0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jgvbVR1C; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jgvbVR1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546162; x=1789805362;
	bh=sNcmNScEhpmF/4cOJIi/n2ntDi0iE/3WYicZo1sq86I=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jgvbVR1C2miDAi8+mWdOxhQ2VIBjqj7+WGoaYWQva0zQV3ZhySWAvo2rRIX0dX+wa
	 xmGT8XEgXuNCfjQumFc3LxW0gVVXd/kbgz0B85ZvFIHbPx49CGbZIN2b85ftYUlGQd
	 4XD2zzCBc9VAzuRREEpviR1N60fOaswHvU9ZFuEOI0qeaKStdtc8n56SklJiXQE/Uf
	 o+plmjr3iIvfWVQgdLh7vzTx4Usr23qJ+pPMoXbMjiCDpoCLDKd6+ecDnH8Y3v73/5
	 XSaApKUpc3auokq3IQJBWTZklzESDFHC6foP28e6SonnPyQdGgnxlKjap95en5pj8N
	 hCsKlEuPuBMhA==
X-Pm-Submission-Id: 4hlBPD2cLfz1DDKv
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:07:57 +0200
Subject: [PATCH v9 01/10] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-1-0dd24fa2f3d7@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
In-Reply-To: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=1037;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
 b=Xylm022efn23CkDn2cmNcTM9uttisqYkTx3O6Bgd6V5Sp9P71o/xLgVH9Zgfz9Xmp2y2CLNH6
 1OuA7/VRvGyCPmcQz2QKxwRr9mZ4OXfe5N8ht2mv7VFfWxP+T9Isowa
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Add new boolean to configure selected interrupt pin to open drain instead
of the default push-pull mode.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

