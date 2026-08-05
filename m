Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704F3E3C4D;
	Wed,  5 Aug 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914514; cv=none; b=UHSS5PBD9sKWYTHdcs6Sf5W7hWKHULJCpczT9hYA2dbxCNi5z2KDXQrrTr0425jYUqhioWwt96x1c+trNFiF9fhGAHfCjDhEWknJrpWnCkhLaSBWWO/FfAH3pSCBkWO5CRMdLYbgBPdTRZseDxKnBXAhrBiHA65HsLSQL9KbsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914514; c=relaxed/simple;
	bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhHNhMhDOIUCN/KrPjwHyqJeWuy29op+yZ5czv5xFL0+haXQuKYQWkke0yXKzzRNKLmNPx2XQE3kbq9mjJQw3GEQFp/Fx6GQVjoRTcRUDDxI6Gr1OhZ1GWNfvcW/VzCavmOYZxUMONeqyA/Gk5zlxmtsuY+Acp/1EHov3b2z9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Hfe05xOg; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Hfe05xOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785914508; x=1786173708;
	bh=sNcmNScEhpmF/4cOJIi/n2ntDi0iE/3WYicZo1sq86I=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Hfe05xOgaLxrUU4CSWee8VZ0Qco4byjmVXfTgFunwxqSGzr6Esxl8ypvFcF1SZZ2Z
	 FFZBW/Qb/MHNi/DbAfux6r5fJg8dR5iPFHo61TFeHaM+9HYe7/igZkPhteDVcqqk8A
	 60630TIZeDdQiUHZ5ETKWDlOgnrON/7ODHXe9q4+Ml6p/ItIOTahUm8T21kkZoKdJe
	 ENI2bQPtIbvuqGVumY99LE0hvJD2j+jkOZaZ67tGpm9rByxHi78XIhh0aTdZI4QN5c
	 5SbmL0rq6mfVMD3eSwdlsQbUlpM8h0vUjyiTWj1B0tGNm6jyVq4SH3LRTVRLIp8i8z
	 nFPFRmBmgdsoA==
X-Pm-Submission-Id: 4hFMKk3dKbz2ScQF
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 05 Aug 2026 09:21:35 +0200
Subject: [PATCH v3 1/4] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-mma8452-open-drain-v3-1-6149f406a409@geanix.com>
References: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
In-Reply-To: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785914502; l=1037;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
 b=zeuEIpiflvNI5qTAsOwgR6ssTbK/cxdygHvk78HyZiDpvUtJXvDtz7IpBjsHSXdurCtM7WgjL
 RuAChg2Sp6nB/nrSaJEdp2IFBfj0HjOXnt34o7lX3SJf2ej0rMpDuLm
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

