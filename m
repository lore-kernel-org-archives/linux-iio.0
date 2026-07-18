Received: from tbjjbihbhdcb.turbo-smtp.net (tbjjbihbhdcb.turbo-smtp.net [199.187.173.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723443DE44C
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.187.173.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784393799; cv=none; b=ICKBkOqNDIZIGX4pRqdz7qr5UcZkqjz7roM+JnjOxu9L0uomlK+3XH4XEkuNAYtc3pcpp4GdSi9vLYfY3cHR6Q2kUKz044fBt50UNZWTA1Gu9bcYviPyvowCabfrC4rBeQHLY8ZS7m1i/TpKUQzC0qh+N+NQQnDUBOxPWiU2wkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784393799; c=relaxed/simple;
	bh=6V1fqRAEzy30EZyCjZ6YuLHtlsEw9egjdn6C5MyJ5Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M876UQ620xomxEeF5z48QIBihMB5zHTpbI5b5JFwWKNoSnX5PwuVE2HkDn2MA/LbzgBO5ojmOkG/f3oY86nyJsuDtLkdQ6f0dtc2kWrBFHKFdNhlVd2cJbYmbGLCDFE+NfsVN5duRS2Clmw4pF/8xqVfIhRhGhG4xFCNYNe9GQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yahyatoubali.me; spf=pass smtp.mailfrom=yahyatoubali.me; dkim=pass (1024-bit key) header.d=yahyatoubali.me header.i=@yahyatoubali.me header.b=dgiVH+LG; arc=none smtp.client-ip=199.187.173.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yahyatoubali.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahyatoubali.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yahyatoubali.me header.i=@yahyatoubali.me header.b="dgiVH+LG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yahyatoubali.me; s=turbo-smtp; x=1784998597; h=Received:
	Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	Content-Transfer-Encoding:Feedback-Id; bh=7cquwDDjN8ug+YxmQA2WEP
	enRG1O4Mxu36LQCVpeF4Y=; b=dgiVH+LGBnplku5i8EfMzONrv/6ywR/IB1IRmR
	ptLjXQ63QKM+bdzfd+sHcI7jQ05OMuXvqhuyqD2BrGO5gi0UyORWLDO1VVBWYqL6
	xLuF2YafkXCdrGlefFCnjQ1e7afOySo6eWbazOYU8IZNX9SVoAHX5tWeUKe9ijRs
	Fc1Nc=
Received: (qmail 2894123 invoked from network); 18 Jul 2026 16:56:36 -0000
Received: from 197.145.178.94  by turbo-smtp.com with SMTP; 18 Jul 2026 16:56:34 -0000
X-TurboSMTP-Tracking: 64-018cfb16-00001e63be83a642e009-009-4288be35
From: Yahya Toubali <yahya@yahyatoubali.me>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS), linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc: Yahya Toubali <yahya@yahyatoubali.me>
Subject: [PATCH v3] dt-bindings: iio: dac: fix spelling of 'reference' in adi,ad5791
Date: Sat, 18 Jul 2026 17:56:14 +0100
Message-ID: <20260718165615.1923592-1-yahya@yahyatoubali.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-Id: 26016534

Fix misspelling of 'reference' (was 'referance') in the
vrefp-supply and vrefn-supply descriptions.

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

base-commit: 1229e2e57a5c2980ccd457b9b53ea0eed5a22ab3
prerequisite-patch-id: c8aee5eb39e3cd6f2b2f28c82163565665288d2a
prerequisite-patch-id: 60ad32e9f0e74902635d7886b97c4225ac8dc5ce
-- 
2.55.0


