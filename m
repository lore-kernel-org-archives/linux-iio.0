Received: from tbjjbihbhdcb.turbo-smtp.net (tbjjbihbhdcb.turbo-smtp.net [199.187.173.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5938BF7A
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.187.173.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387985; cv=none; b=kF+Ppik72Rnw7ZCsN/X48NETo6waurH+c9Zjj/BhbcwxhFkgET6pmwkStAV1O0/aOL20qt2s8g7qvdUbEbXUkxMtjTr1VFXn+P06EvOoNlmLR9cGFSLOCLI2zylLe4sTRsGLJaQn9bIW1dqt6/fgbYMa6XZSDg+K6pYfBSBqzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387985; c=relaxed/simple;
	bh=hk1GJFIMWK5YL14L4+3+km0Zui3buzF/mlgejysUvlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t76aHGJJujokLPkncTdJHeah8giNod75rODxAiGPxcuxI3NuylbFaWIoojaBTyt2uodwP2hddehIkpZYHTBx2v6/0/Wd6VoKVYGfgPyOnGObSP6vacqhF8o/+YrRcrTa4FVSg9zBz65zjNIFPDZnPmQdxHU+pZUU0honPBMPPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahyatoubali.me; spf=pass smtp.mailfrom=yahyatoubali.me; dkim=pass (1024-bit key) header.d=yahyatoubali.me header.i=@yahyatoubali.me header.b=lurdkBNZ; arc=none smtp.client-ip=199.187.173.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahyatoubali.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahyatoubali.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yahyatoubali.me header.i=@yahyatoubali.me header.b="lurdkBNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yahyatoubali.me; s=turbo-smtp; x=1784992783; h=Received:
	Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	References:MIME-Version:Content-Transfer-Encoding:Feedback-Id;
	bh=Yed/X/N7M3IWVMe0RTdfjAuaEE3nt+dlgN2axRKYYHI=; b=lurdkBNZFSJtx
	UsTl9G+8RrHsSIypz5ElZtQl5DEp+PmYwCjRtVuNZ3Yh9l+8MiuIwfGROseBv13R
	tduZuWcZBl6pI4UFfUenMzKtAyiq1+aXAFGYoouOXwXiT7FOU4DbbGIYpYZjsoza
	y32V4dRVomr0+S+sgS76W+Evy7a1hY=
Received: (qmail 2204230 invoked from network); 18 Jul 2026 15:19:42 -0000
Received: from 105.76.9.106  by turbo-smtp.com with SMTP; 18 Jul 2026 15:19:41 -0000
X-TurboSMTP-Tracking: 64-018cfb16-00001e63a8561742c009-009-4288be35
From: Yahya Toubali <yahya@yahyatoubali.me>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS), linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc: Yahya Toubali <yahya@yahyatoubali.me>
Subject: [PATCH 3/5] dt-bindings: iio: dac: fix spelling of 'reference' in adi,ad5791
Date: Sat, 18 Jul 2026 16:19:09 +0100
Message-ID: <20260718151913.1892547-3-yahya@yahyatoubali.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718151913.1892547-1-yahya@yahyatoubali.me>
References: <20260718151913.1892547-1-yahya@yahyatoubali.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-Id: 26016534

Fix misspelling of 'reference' (was 'referance') in vrefp-supply and vrefn-supply descriptions.

Signed-off-by: Yahya Toubali <yahya@yahyatoubali.me>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index 2bd89e0aa46b..80fb98035c6f 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -36,11 +36,11 @@ properties:
 
   vrefp-supply:
     description:
-      Positive referance input voltage range. From 5v to (vdd - 2.5)
+      Positive reference input voltage range. From 5v to (vdd - 2.5)
 
   vrefn-supply:
     description:
-      Negative referance input voltage range. From (vss + 2.5) to 0.
+      Negative reference input voltage range. From (vss + 2.5) to 0.
 
   adi,rbuf-gain2-en:
     description: Specify to allow an external amplifier to be connected in a
-- 
2.55.0


