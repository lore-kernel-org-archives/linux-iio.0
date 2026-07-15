Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0646AEFA
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118470; cv=none; b=lx9teVaABYcb+7+3xglvceDGJ1/NDjOSnON6AD6BkLQuf8VwKgu6he2kEw7sSlAaNLFLm9W6spFgxkemV1z1vB8EtMCRuy/rdeMQ755OZIcIKhyE5veuPIb96uHS5yf5y/x++b9cuDx88wJtlaDrHzInniNAkhUqdkTXAKa2ICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118470; c=relaxed/simple;
	bh=feUXKoU1OigzdRs8cwri1uskaBwwc5Ly4ocsOXChL5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfvjY8D3niy8HrIys5lFXEfCH88D/eqlF9cTqiPfsQR77+FeBL10bfQ5QJGER3tvToNeHSYsa4nwo3joB7fH2tU+LCgVMt2anhkwii0lmBR+2zW89ya03MLB4drHeDmCaEHMbFOtUSARCsmov12e1vI8w9m37SoM9iLlEZXI1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=nrlkSyR3; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="nrlkSyR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118466; x=1784377666;
	bh=5B+E/oOoq7h8vHYA+0lGPxncQ4PnLMN7/YIu4Ypf8mc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nrlkSyR3MmAtiRjE7CsMMFVNP7PqWDOVv4Q7kpsjlWOXcd+syS//G9KXwZ6r8R/dy
	 LeI5RmU04Z3ctcPqjYp5g3zfzL7V79KyqyfpQKOyD/CtIz5AcQmDMwoG8UThNSE0lU
	 Fox+QlwREx/GyczZK3WHi0f1W1aPOKI4qTg+SBZPuQ8NYAoyh7Nhr0uGbG1EF7P4Bl
	 jm2sQVN8jKryI0rW/AO4HxjeQD72PndKSPHvrJm4MvoKWdsml25s1aVmkz8IfIKia9
	 Uz3IF/JU0bvC3DhPK4bM030CIHkUC16zA1+c+Lba2VNNoyvj9EDqkRtsdLi4HhoAxn
	 demaK/+nkVBEQ==
X-Pm-Submission-Id: 4h0b6S2cHDz2ScPt
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 14:27:24 +0200
Subject: [PATCH v2 2/4] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-liteon-ltr329-v2-2-d18af55edab5@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
In-Reply-To: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118460; l=759;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=feUXKoU1OigzdRs8cwri1uskaBwwc5Ly4ocsOXChL5o=;
 b=wedCmlErWr1AkJe8tLTJC9tpIeCI5a4Bd/HFakaOgBgGjaCvbGyjK5iQqr+CzVg3pYkmGSGi7
 nrwskutSM47C0ume0qZXsTxcX/TG8EFeJ5B5FntX8FEpOeeJxEy+z+i
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
without interrupt support.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index ab9bb68dd736..76e81eba7ea4 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -19,6 +19,7 @@ properties:
       - liteon,ltr559
       - liteon,ltr301
       - liteon,ltr303
+      - liteon,ltr329
 
   reg:
     maxItems: 1

-- 
2.55.0

