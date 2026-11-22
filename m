Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795367803;
	b=bhbm23k1VhZYY1/fGXDhiKRxvgTjPsg5BGTyjwqFgkv8KY4KJow1R3YFtfNVdrMuVhgi
	 oBJnofNiEMGZAzOM3xBY/lV9m25M2RWDLah+G7nbf2nhIRGRfvZKkOQf1nwMYPUrbYcQj
	 YQDWK93ycYLfMONb2dW2jtXf32kitwpwBKS3goie/cCFvSlyJEFn7JlSp1/HknWhZ932l
	 Bjjy/8HopK63ezUsvCwYBRSHJblxvnDv8xEcT2/YDL0MJgwHmO/zGg5ofZA9k7MM95C5i
	 sOMER/3KGT2MnXEj31jRM39n+SrjqE8JDCwsiPjycADcoK0FMBORuFmkLdW8C7iDbtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367803;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1D1kRDauWrPc9YBI3tZs0C1o8t8nwL9f++cqux7X0Kc=;
	b=z/DmAmlYtXAi8gp+EcxEv2d8Ndfaf+oPmGKZnBCsgimXPqBRTb3XEwSs2ukEs0J3Mh90
	 7KglSNemF5WIhiSJrLTSMV5GQtABg7qDtuwXlg8gL1SYNcANVQzcyZ3SFPXkcuP/MAYch
	 SBzZzPHM/yUHXlBKluX2YCMgwjIGTX1fAcvYDnD0wCqX0VSqzsulQn4DioHNDAu+lpZBj
	 qX3EeeLoCfX3NOPzxCcncXn6p+DHO1ydQgjrw70L+YAP/4ybPgPn4atBw+nr76h02HHnn
	 GxQRs2xNCIFe7oTbtfoIqHaGBYsQdSiudmaIz3+T241nc/XDARNkI2J9KsVm7N1ps8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzyTuYPV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB3606A334;
	Sun, 22 Nov 2026 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzyTuYPV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795367803;
	b=qi6TydVJUsrTtOPhKVi5T4Dli82c97Xy/JkjNvfIF6Yaz5OFJu837dw9O/cpfwzu1KVA
	 PbKwypPBjA7U3aeStbqWMlLf/wugBOmgD8QfWSw+VRBYcDGSXjuJPaimyQsau43bYLH9c
	 NX47TMmsVARzpQX66XSJB+dwcqzaW/wGlxfQDV7/+3U5SymkcxUJeXW+I1QO5flHdapzv
	 IJ1AwAIYWhmFakgctHw0/gKhxbaPBoTkHMbOXmKr4wpCFkyN7ZqtUU6zv/WI7unPBX6uT
	 rE51InuZcR/nxkWPIp8sF7xxXLp3l924sw9UsRIHlgLng8zGcWgP6XmlS36c5tWBeUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367803;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1D1kRDauWrPc9YBI3tZs0C1o8t8nwL9f++cqux7X0Kc=;
	b=zfijXhWYBu5AT2M1DOqEQl6oqlnwKBIacKu0OgNyn3V2+87z+KT2Sj6eGO+Gbuu70Hcr
	 BntOgGE04v9WQbRoPYqT0i5Q6CfwGKwAD0bTa3yJkIGPYsTs4W+OBY5kY/LSVJFLvi41A
	 DNiQD15rzV2p0JcMa6TCIDYFLGKbKrK6u7sW3Ldoz24EhtporqfoWtRYcy+kdEu7MGLLB
	 Vugg7+LhEHHL4lZpk0VqvqVtAAJnj7QVZO23AkGzdZr+R8+Mewz/7YEYvJc267CarCk8o
	 MGlQ2OVHU9Vv0kwNv693HbPMBFqPGsmZtL5cL649YX8hCJIrCrri7dROo7pXCojYo0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 272C41F000D3;
	Sun, 22 Nov 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367803;
	bh=1D1kRDauWrPc9YBI3tZs0C1o8t8nwL9f++cqux7X0Kc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MzyTuYPVJVJC7UnRTdDpMSXucvT2iViR3m/igC5fM72j3NMi/oueF8jBMYSaO4fhs
	 VmitFgbtD8UQCAQVp8rPUJAYZ2krg7ymM7aVWs7LjTuJIqwySHpmhe3x2UVm4hGShb
	 YmAUKbgNrI0nqdCA+C+J3SwgTEd1ul9M883d82ClSiuR/kuZyiS+pIjlkEV1ebc7VQ
	 VFbVN+Q38MEwPimHCE6+wNPAbGZG8E6a6UjPYLcYUS8UKkZBtIVjexZLfZ5zGNi9tI
	 YKh7OfHe1WhvEQevU0kjDuPa1KnGFngIsHCS+AK459U+kMzz0zKvsA5ZabVaKd8HMe
	 J8jypm1sblHBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A3F984C14D;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 22 Nov 2026 19:15:45 +0200
Subject: [PATCH v3 4/7] dt-bindings: iio: light: stk33xx: add stk3337
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-6768-stk3337-v3-4-b0d0a924e843@protonmail.com>
References: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
In-Reply-To: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795367795; l=1072;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=bt5ETDB3Lc22WDD7vf0JJgbped6LOiPrRoW1lAcWv50=;
 b=0WDtuzNZjWnjKK6DmzeqhK+FQHmHKw7Ftlt2Asidw0bOy+XJkrNafQlijdy2dbL/hwMYymrTc
 6E/+MjRZuszArud71xFJGke3sYtzdGNlEXAYoQwQnbuSUUeT8ob8+hF
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add compatible string for the stk3337 ALSPS sensor. Its core registers
are backwards compatible with the stk3310, while also providing a clear
light channel like the stk36c61, so document it with sensortek,stk3310
as a fallback.

Datasheet: https://www.bestmodulescorp.com/en/amfile/file/download/file/1699/product/1048/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index 114cf87eb54d..d5d7059fbc0f 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - sensortek,stk3013
+              - sensortek,stk3337
               - sensortek,stk36c61
           - const: sensortek,stk3310
 

-- 
2.56.1


