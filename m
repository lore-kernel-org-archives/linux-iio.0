Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D76344DAC;
	Wed, 15 Apr 2026 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267847; cv=none; b=diNp91LzpTdauGfKBCcGSr0UZTu0aP5Cr1bnC8yTRfuDh3flLov8X6i/TEvEQbBvwarKdMH4X2jy/1NaWEFP7/Wn26Xrz5joPsXvCpvJ4eZZCxdydhriR9bd4ZcJe3RAEyU67A+Q9JDI1gv5TTe9oa3+UmHzHcZ4oKcxVYX6C98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267847; c=relaxed/simple;
	bh=1Rml2uZbF3K3y7EMMrJGe51K78HqnYsNwGvhIUt/8f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p54Rf33aYydQXHZ3WiPUYE+HTWDWphmHx6S2Rkt1PEG/EwXEIY1ZiZRIOMn52+4d7F2k6rETZ1B5txkq01KdoBGUwPSe21DHZXsd4LhUgTFJskZxowWtfAm6hrmTV09y4TQqo2fIMUupA8sE6+T9L0M2D38zxmTKq99KLFR8VMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8drgf46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8drgf46"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA838C19424;
	Wed, 15 Apr 2026 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776267846;
	bh=1Rml2uZbF3K3y7EMMrJGe51K78HqnYsNwGvhIUt/8f8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Q8drgf46MQrH2j2TukG5zqtGlb8+Ld4Ja76gN3pdNPaPvadTOivI0RnCZeSaHVFqp
	 cuCGp61ZQO/LXbYcX5IBa+USRO0N0meg2MvZPFBIpU0d6kh/1t6GKT9UE+L8QSVWLJ
	 2UmQdRG2cCX5RtCuyaKLOkbMkqCRa4YcfFTwz86q2R+Lsmj8Xeo7N21o3z+juvfgDo
	 M/2dd0cpHIHsT4EO6Lxf2MU9Oz/yF/NKxF+SQKyM6lZJct5qVWguGzK2ZALm0auvD7
	 RzTs3DZvQScV6KcVO1tbtOOJ4zAO1Zd/NJo6UUl9BsDfLB3BzkDM3LHZdhBX2eatZR
	 eSQvSJyYIPaXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B612EF4384D;
	Wed, 15 Apr 2026 15:44:06 +0000 (UTC)
From: Vishwas Rajashekar via B4 Relay <devnull+vishwas.dev.vrajashkr.com@kernel.org>
Date: Wed, 15 Apr 2026 21:13:40 +0530
Subject: [PATCH] dt-bindings: iio: gyroscope: add mount-matrix for bmg160
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-bmg160-mount-matrix-dt-binding-v1-1-0e2c85964ee6@vrajashkr.com>
X-B4-Tracking: v=1; b=H4sIACuy32kC/yXNTQqDMBBA4avIrDuQSEh/rlK6MM6YTiFjSWIRx
 Ls3tctv894GhbNwgVu3QeaPFJm1wZ46GJ+DRkahZuhN742zDkOK1htM86IV01CzrEgVgyiJRuS
 zJyK+uov30CLvzJOsx+D++Lss4cVj/VVh37+XPsTsggAAAA==
X-Change-ID: 20260414-bmg160-mount-matrix-dt-binding-e76ddde94866
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, luca@lucaweiss.eu, 
 Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776267845; l=1356;
 i=vishwas.dev@vrajashkr.com; s=20260414; h=from:subject:message-id;
 bh=pcuRd/qLKaTlnrY5W5w/EZ94X8GzaogVmcptT8JzSSA=;
 b=uQx0SBFlnI+dg9jmGonNeL4eQ04Ym5InA6iB5YcWxwwhTuTMW8gSv+WrnBJbd7/TmVL0K9hZt
 9XlHHMTbG3dBXOZ3w1Z7qBCYe2NFkOuziTT7kXTkNz+b18VC+wwryLj
X-Developer-Key: i=vishwas.dev@vrajashkr.com; a=ed25519;
 pk=OvZgoGVJ7ofrIn3w/YijdoJ0IexAy1kREY51mGZPm9M=
X-Endpoint-Received: by B4 Relay for vishwas.dev@vrajashkr.com/20260414
 with auth_id=734
X-Original-From: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
Reply-To: vishwas.dev@vrajashkr.com

From: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>

Adds mount-matrix as an optional property to dt-bindings
for the bmg160 gyroscope as the driver reads this optional
property during probe.

Signed-off-by: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
---
The bmg160 driver reads an optional mount-matrix using
"iio_read_mount_matrix" in "bmg160_core_probe" and stores
this orientation data in "struct bmg160_data". As the "mount-matrix"
property is used by the driver, this change proposes to add it to
the corresponding dt-bindings.
---
 Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index 3c6fe74af0b8..ea8689660adf 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -22,6 +22,9 @@ properties:
   vdd-supply: true
   vddio-supply: true
 
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
   spi-max-frequency:
     maximum: 10000000
 

---
base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
change-id: 20260414-bmg160-mount-matrix-dt-binding-e76ddde94866

Best regards,
--  
Vishwas Rajashekar <vishwas.dev@vrajashkr.com>


