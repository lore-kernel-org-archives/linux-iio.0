Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0939B95F;
	Wed, 25 Mar 2026 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437145; cv=none; b=oPzSEWLMshg8KT+fCBT6kllK6ccbhr0ZmSEHwgp9FK3i2BR/1frCEGt0xNlQn0j47MpGl8X9/xZt2TUw821XpiK9JzdJcb8+AKgVdCdyJOoh1hwk/G2FSGoYgf7HAVrcEyGCW7Cl07r+b17AU/Gn1mA9EmlMRJf0joaZkp9wtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437145; c=relaxed/simple;
	bh=bSDHsaGHbv8xbyoSQI54Vr+iBqKfp/cPWIMW4Qej6Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0BmpCqCmX+/DCT5GTH7noZVkpNQvdZeMqzkQQVLXvYl8F5j5NPwx1H6uyKcHYVT3YP32mqj2X7v4vS8MgqOYbWvcZXZ8aMv/jsO9YOSGY+JobboGc6gJSx6QEjApCOEYZN4I+L+35SUauDaVX5gwj+eb1goNEKHBhhGwmrIZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3SLZzc/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3SLZzc/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAAEDC2BC9E;
	Wed, 25 Mar 2026 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774437145;
	bh=bSDHsaGHbv8xbyoSQI54Vr+iBqKfp/cPWIMW4Qej6Sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V3SLZzc/b47Wui2OhVkjumis0K+QLdgFzYPfeSBQhpq1fOfCXKY517SfOXe4n1KYk
	 oOLkAQ/CaGyzAQ7Rh511n6gCOBQfG9vwi+lrvK7WyKFdTwoqJxpk7yKiTHq3h3VTvK
	 XCvaaq2LGtU/LzxvC66xmWYqiAqwtaVoMhbvhSMX2RwhbLI+urHcFDNYrrC8/NrYuQ
	 5mtWBgcLUuIbtS/92k0JaBpKQLBOSGmjNMpovpkS0lyGE7zFS+iqrf89siJhfJXscz
	 ANXzyLuOLMZoYjHHnO8Gwi9o9aoqqDg2XzYxQiDqgQiJhLn4sCK70dplP0PMwsxqZG
	 XgmCStF9X9zeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D0103A9AA;
	Wed, 25 Mar 2026 11:12:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 25 Mar 2026 11:12:02 +0000
Subject: [PATCH 1/2] dt-bindings: iio: amplifiers: ad8366: add adrf5702/3
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-adrf570x-iio-support-v1-1-9a2685eb2e55@analog.com>
References: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
In-Reply-To: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774437143; l=1134;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=yeOzs3WYQQtQrqWYQpKl8DQScANIz91jhYI5r9rZsLc=;
 b=A6KDXoVGnlGQLC6ZMFVDPsyPzUOrUgWkiFt6we4vL3Q9CI4frXqcEjluTP8LySqFCv85IBv8u
 oCJcBr4+BImB9lwkZ9TqabmMPp/v/SbZzJ5uomHpbT4BJelQKCyRbOe
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add compatible entries for ADRF5702 and ADRF5703 Digital Attenuators.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
index 2719de1166a1..065637ce33a5 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
@@ -20,6 +20,8 @@ properties:
       - adi,ad8366
       - adi,ada4961
       - adi,adl5240
+      - adi,adrf5702
+      - adi,adrf5703
       - adi,adrf5720
       - adi,adrf5730
       - adi,adrf5731
@@ -66,6 +68,8 @@ allOf:
               anyOf:
                 - const: adi,ad8366
                 - const: adi,ada4961
+                - const: adi,adrf5702
+                - const: adi,adrf5703
                 - const: adi,adrf5720
                 - const: adi,adrf5730
                 - const: adi,adrf5731

-- 
2.43.0


