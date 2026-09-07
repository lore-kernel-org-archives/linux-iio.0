Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77B4D2EE1
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792699; cv=none; b=p5VsRDR+DVYeqJE57X6be5yCXxjOLvXCn5+H9xEv88cD38j9yIDNOc5jbkwn5dsjRMndQL7brxZoystSN3E9zKswPWfhH9pkl100t5oJ/ps711LiL5xr1/ElbSaIQE02SjhMzPS6SLoxDtyTujRscgpRHpTQtXa4hZO31EAX6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792699; c=relaxed/simple;
	bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdCns8Y0kroS4y+FQQxDLkg6fM/9TOiE1yo96iN1C8vz9QzKXc8tSgFdr/ckZkDz5ppTe/luLF/X00O5R8n+LxwzIXh3CAwK1sECWLBZTAz8ed9Fe9O6IarT23aUsmI0YJ3ft1dc8z/MklXIRm6sANX6BTDH+TGqLbVO51s8/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BcU48kST; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BcU48kST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788792672; x=1789051872;
	bh=sNcmNScEhpmF/4cOJIi/n2ntDi0iE/3WYicZo1sq86I=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BcU48kSTDX9Yiqi3coxWDMX7dJF4tFCEj83oN0Kt/66J0zD5HBrx7wj1TtjKOZail
	 cAtMR0UcgTCfKL36QSVd8VLK2b2CnfkqfJLqldw6agk9l2nyzPuV3Qr857x+ATgCML
	 xaf9oIXQsvVo2zPKLTeBYz0mnNrNL4gAA8CiZyNK1TfN7Kr/l06/60yqoG1dXfStsQ
	 P63zvW3AxFEtUsi4/trW8jIQlx3lkgvDq/lN1aKJt/KoMYqZ5AOuSwttnzg4Jnl1NY
	 bJ5ANNBp/3wPvFcwGCn4paJNHnJx9Fzrd1uzT2x0B68injoE8nCH7jfY6F8/DHUMEK
	 3Bk/akxXFSH4g==
X-Pm-Submission-Id: 4hdql22ZZXz2ScNn
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 07 Sep 2026 16:50:56 +0200
Subject: [PATCH v8 1/9] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mma8452-open-drain-v8-1-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792664; l=1037;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
 b=COdXucptIvyz6knRu3ltK+3KoEYxg7biJdMGuZX42DNH9cemGNDiZpSg7jj4GerfrGmGrBTrB
 E0ZO8zNH2tBCGT3Uvk/I/XOEWJ6bNoqs9epYQ+ysBU8PxPzg89TiACk
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

