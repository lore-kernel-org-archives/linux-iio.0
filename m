Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54B45C6EE;
	Wed, 12 Aug 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545060; cv=none; b=vFn55jYxIGDc/1c1ElYXaT2AkB+08MkQ9ga9vokWl5xXZSK9zuGsq9K5JQ9t9R37Hk3ozcrdvNUe2wobrckxoJgOFqYt5a9zn6HDX0Fltx00oF0awZqzSjXwWbRB2Js00Ly7ZDPRcXqATqWxcCmfGcaObMycfjFlecjnFiQ5O6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545060; c=relaxed/simple;
	bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+QvharlXy+1PmA4UqWfeeIXObKMF/XT3+Hp4JvRSh5vZcTzS1v+8KHGszfMuXOtWwx5UVuhXUkRgSEa9SSkpoJGxkHDF5x3ITxRNNgIW9DPDg8cQSPGijJ1oOGe/V4+u2YCzJYwMa4u3Ern/Gj1d9qa58NU/0JghHUmsdHO2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=IxRySKpC; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="IxRySKpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786545048; x=1786804248;
	bh=sNcmNScEhpmF/4cOJIi/n2ntDi0iE/3WYicZo1sq86I=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IxRySKpCbJQ2G+7jOGeEm+8nBRWEcUaYAT1t9EC2hZTnLHBetgZADEhCXs5FavugA
	 QwogtPmiorj6TY4tRyByFQR/URHQgZAYCu5reXoBUEmTmxjcfICpF1QhX8TRBHTIES
	 HLH7A3WleR4hkPGJ8Xdogj7eMbs1+UeKMAqrdIcUIAmtWoAUBCQq/hZDpYW98HUNUb
	 CH5bNr4UN9NlHm7rO2QTAAzoGA+jicu4kSBXY3oNgjXq04bc3Saox5HMgEicC/2JCo
	 EdhvDpUWiBKaIjJYMMQc2XuR4b/w+E48DejUTvUahGDCJr7m9KhQ8LB5xJE2a6zDlX
	 VgOZYqDEvWygg==
X-Pm-Submission-Id: 4hKrWS3nB9z1DDs4
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 12 Aug 2026 16:30:32 +0200
Subject: [PATCH v4 1/6] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-mma8452-open-drain-v4-1-bfca15d02b59@geanix.com>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
In-Reply-To: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786545039; l=1037;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
 b=bOvti1R9EE6QzjIpsHKFDKTfaR5Or9UJi5wEZPsTnQLNvYobzNFiuAP4Lx1xo/CfF6uBQm/a8
 A/wimolQ6PgCa4JmJkD6SJWaX+aT+77tOqYNYn0NFDDpQghTvbgH4AX
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

