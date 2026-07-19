Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD637CD48;
	Sun, 19 Jul 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784454723; cv=none; b=lRMBYG958aHCLckA26h67VyXAioGzTme4BjJBOACd23kJGBtF43fyScXz20GQl2qfQ8ld4KsyQXhKwI9NQS+U3E5oi7WAzA5ZewxRRM1FJPwbTCfppQAhqjNvwr2oW3ievUiJFBqp9TlMYf/XtgjZGnIJKvmc8uhSV6yxl7EeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784454723; c=relaxed/simple;
	bh=Z5zLwOZ0zA27cy4m0/x/oxRV97NFDeXGwKmtvD9NbsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dyHlBKyPGKNkQaRR8NPVm/2Yt0JofFjYIhP59aOaCtdXeJ6qThiTEjQwo1VaaU9Il9HVHxcvUxUeRXq54gfaRodvMFom8V4YFeTNyXmU0rP87tHDvuOkfAJS5prGyR2skdpCz3u08iMxr/9y5GKQzL8rnp0A2avBBmdDgIXjjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVRxYzw9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVRxYzw9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA9AC2BCC9;
	Sun, 19 Jul 2026 09:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784454723;
	bh=Z5zLwOZ0zA27cy4m0/x/oxRV97NFDeXGwKmtvD9NbsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UVRxYzw9T6ZyfFw0a9hU3Gf3DE+8Nn/Vf07+nn4K6wpnRY+pZEvibOYT6MHzo/0Bc
	 RIRQywrSaG3xzigOIg1bNPSg1KE7RtkauiMCwzOMZI/guDTYx1+lXFswkIvHqdqQ/N
	 j7Ji2FhPfRxrZo1IqCOND5jCWr5Yvi4E6zzzluiv/lf8bqrHcJQRqsldAqdl7Pu5PR
	 Mlq0M6pJMFe7582eqy3588NCut4djhpn5s/JcDBhy4X4FbvS2h/ZiX4Rc1gQcNYT9e
	 k/qpyv2zgLX36DWFiFl6j03Sr8BNWw4X1eFHGfqHNsTXNZlKMjQaW+gXJbt+dDmKjc
	 koUrC1pxz0t5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ECBC4450A;
	Sun, 19 Jul 2026 09:52:02 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 19 Jul 2026 10:51:57 +0100
Subject: [PATCH 1/4] dt-bindings: iio: dac: ad5696: extend device support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-ad5686-extend-dev-support-v1-1-841ec75cf5d8@analog.com>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
In-Reply-To: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784454721; l=1452;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=C17Ef8/aBMvZgOB/6VhtM6LaRYek9umi2SylTJmyiAE=;
 b=IeZpLLd9yhIC5rXRxr+bxAsCcJ9DRMaOHgB/nXc40ICt4x1IrouFwCLw/HtbIeCeiFvUDQOGC
 fnMsusMb/EyCYqf8zcMRYyrUah2W4WUgg2eBygNGV1wTCe2OAUTbTWk
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Support for AD5316R, AD5673R, AD5675, AD5677R and AD5697R missing from the
device-tree bindings documentation. These devices have different bit
resolutions or different number of channels so no fallback compatibles
are used.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index e10f8596f9d3..835fa21c474e 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -16,10 +16,14 @@ properties:
   compatible:
     enum:
       - adi,ad5311r
+      - adi,ad5316r
       - adi,ad5337r
       - adi,ad5338r
       - adi,ad5671r
+      - adi,ad5673r
+      - adi,ad5675
       - adi,ad5675r
+      - adi,ad5677r
       - adi,ad5691r
       - adi,ad5692r
       - adi,ad5693
@@ -29,6 +33,7 @@ properties:
       - adi,ad5695r
       - adi,ad5696
       - adi,ad5696r
+      - adi,ad5697r
 
   reg:
     maxItems: 1
@@ -84,6 +89,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - adi,ad5675
               - adi,ad5693
               - adi,ad5694
               - adi,ad5696

-- 
2.43.0


