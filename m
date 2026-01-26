Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D1332904;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436113; cv=none; b=E6fvmpm76j/+r8snu/Pv1BnOOZVQmKFbJmhULRA1wzbHipU6FigfFGqdpsW0gaKxPZ7TYCeTKaTMLSvdr0ib6EZh6PTcm+v4OGVTcQeigGM4x+34mBLL8PNZX+vv1912gAJY5MgN5bvmGHHGueGaIeb+ndTp18JifH5AhtHCttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436113; c=relaxed/simple;
	bh=a5QjQ3PG7ITD2hiQFfp+OrtAgisDTZc/xGs1de1sIPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NEK5XJMgajGokDQd8RKdMTFNfK+3B6V7iw+afSY74kWVQWUWhnrQAPAou6uppfS8N4U6jGu71ylTLoKTfdNvDDZJOuLWGCwsfkR/2YvjUPgVIGrDfzZl8BGRCTl6gH0tuoNFgyqYcbm5qaydZVYmLxa9WBxqlSSnXvJuEdRKEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh3rwkku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh3rwkku"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CDFFC2BC86;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769436113;
	bh=a5QjQ3PG7ITD2hiQFfp+OrtAgisDTZc/xGs1de1sIPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hh3rwkkusjv65vYfvTJwSFsBr3QOki7esd2YuyOyRcnGbOgh/Gfg4mHA6abBytebY
	 0FBtJS5zYXGaoksSyRcPMyMftmGN+OYhI0CfZyAwhK5R6xFBGZRXhCYAH1qolNvl6W
	 BcIApTesJritei5L0wWY3BX2qZjUqb7qQcPg1uSaateGSolOKNqAJoU2heAql66ril
	 GIu1MRQgtZta9Fp9Uy1zOf2Vh9a7oMh9wu1HAxCQbYV3d0LaEONLWIN5mqEFBMAmxW
	 uu5+g/b94GYVXObM97uyorcxuv7N/+WEksPHSZ93C0QGVx0FC3sbYIOjSWvC8O8Qsb
	 45XlbpqhCDk7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC4D13C19;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 26 Jan 2026 13:51:02 +0000
Subject: [PATCH v2 1/6] MAINTAINERS: Add missing maintainer entry for
 AD8366 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-iio-ad8366-update-v2-1-c9a4d31aeb01@analog.com>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
In-Reply-To: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769436111; l=890;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ET7QWwvR/DLNtNfKbs9BRAfqEi8TYdOGcMvnzqQgSnQ=;
 b=jSsUuX9xPZJUQNsfsp5b10Uwe6oMsNtjLIyTGEVPdB2Zg0RKllfJbGOeu/0YOTsbwv8oPllRZ
 v7x7IWd+knPADwXYXe89Oau+HYilM+UXGHsUlYCLdW+FPp8tc040DIt
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add maintainers entry for drivers/iio/amplifiers/ad8366.c

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70163f939602..8b5bb7030fa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1583,6 +1583,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD8366 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	drivers/iio/amplifiers/ad8366.c
+
 ANALOG DEVICES INC AD9467 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Nuno Sa <nuno.sa@analog.com>

-- 
2.43.0


