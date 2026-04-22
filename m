Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551432143D;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=AGkvvvU1d56UTTWEVGGqS9nQE2LjOvvEqTapawtWolqTDtS+o0tvbIUu9YXJmnqnH62/rK5VL9cWhsR/IHTBmCuPp/oGAG13uZY9OKx09qXTZ/UVgTR9H/A3ODpIMyWypGJOHTE+Q41eyuRARasbVMUzt1Dnw5pk4WJrzeJvQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=wYMJ0asaxMRDeWv5Nx7Q3Fd4tXlmnv2sQIesKgmiuEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzbf4W6pVDYIyJkKGMpgps8s215aRjc4gp9XM22TMnWibVO764sbkMZfdRvmb4L/9t5QEAquTNZc3uKU/r+WzzXlcHUWC3b4GwiYyHbFV3cgbs6/IZq6eU7bnXclSBaCwpEDNWj+ulUTFM6MjJCV4do1xuhjMwrTbaykmwxRUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoANxEWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoANxEWj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05F89C2BCB8;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=wYMJ0asaxMRDeWv5Nx7Q3Fd4tXlmnv2sQIesKgmiuEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eoANxEWjqfFkPmW2yZ2lyTpaYGwKtMXzIhbjwf6iKaxs3tJtqdl3GJ7B7JOaAfug2
	 E5EnPMMidvs3q4v47cx723fyPzisFd9+qGkw5PXmYDnwt2x3T3Qg0clIj3CmzjUkGX
	 UEur+Ad6eb5pzEyrMbm3btPCaPrheTpmIKCSL2vsSZ7SA5yHugX7xhEdk/OOxnBV4M
	 70dR3hrm6Rpw9emMnPVAUJcHiIC6z3ReIXfZwrLtttfFvG7bvf6LXBQi+ovyc+GRx3
	 oVn9jizaoAxrEmsv9mhFBLouIjh5NDa2vIb8xdEBlZSa8GIHNEN+QHMhXvnQF4fjlM
	 mSXjzaqhSUx1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24CFF9EDC9;
	Wed, 22 Apr 2026 14:46:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:38 +0100
Subject: [PATCH 04/22] dt-bindings: iio: dac: ad5686: extend device support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-4-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=1669;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=HqOQ9v1hLDh+jrtLmYJHNFXNPvRsvM+6yK2HXF19r28=;
 b=cHWHdVPDJIqbj+S6F/eVxycOYC4pyjly5Gl0bzbdm6grFkRPv+GWsRvR7XhXvPovUjPQJb425
 wZlCBBDGyifByfTkcEZSY/J6BLPzkhBCoxOYItNNwAj4iDYjErdaUJU
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add compatible entries for AD5313R, AD5317R, AD5674, AD5679, AD5687,
AD5687R, AD5689, AD5689R. These devices have unique combination of channel
count, bit resolution and supported command set, so that fallback
compatibles are not used. Also, a small copy-and-paste error is fixed to
the title field.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 713f535bb33a..cb035741529f 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD5360 and similar SPI DACs
+title: Analog Devices AD5686 and similar SPI DACs
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
@@ -14,10 +14,14 @@ properties:
   compatible:
     enum:
       - adi,ad5310r
+      - adi,ad5313r
+      - adi,ad5317r
       - adi,ad5672r
+      - adi,ad5674
       - adi,ad5674r
       - adi,ad5676
       - adi,ad5676r
+      - adi,ad5679
       - adi,ad5679r
       - adi,ad5681r
       - adi,ad5682r
@@ -28,6 +32,10 @@ properties:
       - adi,ad5685r
       - adi,ad5686
       - adi,ad5686r
+      - adi,ad5687
+      - adi,ad5687r
+      - adi,ad5689
+      - adi,ad5689r
 
   reg:
     maxItems: 1

-- 
2.43.0


