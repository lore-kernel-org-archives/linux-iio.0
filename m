Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4039FCA9;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549943; cv=none; b=DNeIq7RdDrpDMvSobcY6k6LOx9hGGZ4fn/khTIahQTHOD4J2CaikGuY/VeVCmp4nu+86oBNE3MEMeUbTDtiMTojnQN6zp4w2gbn2z287gBmtHSbQumwUazjzZOOjHFSxFmW14u238U4RaASJjSQjj1Xai2fKcfwK0VDLVa/i5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549943; c=relaxed/simple;
	bh=qyksVSm8CAL/43ndoRZa7FsmRuPhUpa2R+P1vpruzWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgpj+a1fgGIOgCGekBb3cu7zKFuUizPphkNLuvnXPhHOMgZbp9LB+wfz5t2FgpYo2J6Mf+e5oMElidmAlUCOjdN6Y7sWTOBezXJdb3K0iaEbgfllMPnbcF5dNFaUZRembFKV/gEwYq4O88hYRMbegXshcKqSRR+INlsH4qTot9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqI+WM/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqI+WM/W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3400BC2BCB0;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549943;
	bh=qyksVSm8CAL/43ndoRZa7FsmRuPhUpa2R+P1vpruzWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BqI+WM/WXU2MUus0d/33gLMX1TXbiDIWlgPQ56eLvawhLkA9XlITX7pYwXdFPfp1Z
	 uaN6cDOX739WrMa5yOl6FTMixfVBC457E+3h8vf6oYN+5sYu6owVdl+cC9uYdAYvpC
	 PEs0MOQqYis5Qa7YhShtUT5KLgyKj0mXzvBN2AxkVQf7uhbbdksfk3rSNBR2NLSxn2
	 OWybguU4bM7HVnR0uHFzrWDiCZJC8oGTNOk7IsK9dwVa8rDV2lop5e2JJS+Vay7GR2
	 RmHZk3QiP8WGAB8Kpkq/eA+5TxwPtykTugvv2hqgpsQ1H2hJlEuS+ZLwnaG3nlxhBa
	 pjBbed5Or8bdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AE510A88FF;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 26 Mar 2026 18:32:16 +0000
Subject: [PATCH v2 1/2] dt-bindings: iio: amplifiers: ad8366: add
 adrf5702/3 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-adrf570x-iio-support-v2-1-b622a17335d0@analog.com>
References: <20260326-adrf570x-iio-support-v2-0-b622a17335d0@analog.com>
In-Reply-To: <20260326-adrf570x-iio-support-v2-0-b622a17335d0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774549942; l=1370;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=5LWN54RWSnSJw3FPEr0nBjfRW9uleynujsENa8cqtPU=;
 b=3VVc1SYhLS/yD24Qnbw0v1RFJ2vRPdBckEXmz3AEDc56jlfkQ1rexdFelsP7YxsguVlegMbhl
 PGa5C9Pk8N2BXhNsxsVbeTEKFOx5bv1/PZEIwpn6DvngZxJi74tyJV9
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add compatible entries for ADRF5702 and ADRF5703 Digital Attenuators.
ADRF5702 is an 8-bit DSA with a step of 0.125 dB and ADRF5703 is a 7-bit
DSA with a step 0.25 dB. Then, each device ends up with its own gain
range, hence no fallback compatibles are used.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
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


