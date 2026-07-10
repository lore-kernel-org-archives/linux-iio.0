Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8B4189C0;
	Fri, 10 Jul 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682460; cv=none; b=qwQ3203kU+rKWIE7faTb0sDnZWrBNNNg4Z2TZAYurwswAhip3l/AWOdG+e+EeSJ9aQqp9I7EmW8bcRVC5C6NoR90Z3R+XBzQdhUPikKRweYg+n9v5PX+wTWSGt80N3x8vJ4P9FcS4hA6uN/KdPOT6IUZZhZQPiI4Z9WObIIRNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682460; c=relaxed/simple;
	bh=Z+/c89j32b2vZ9L146b8G0oQcfROD134sssyE4LiTYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2rYvNPo4r4t9iTjHM8GTP80zhYyUfyUEYxw1ze/M+Zfnzl2RvtE1NgljraN4sIeKR5rxuUsvmWybxfpGicHpvgU/HlRKitdg2uO8ko3AJgUr4Y/tSRGeUFRNdK5XkbO/fvUMNrG5t3SRYZk8vcAx85fN8DsGRvT+rjc+hVSXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzJcTo77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzJcTo77"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51A31C2BCC9;
	Fri, 10 Jul 2026 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783682458;
	bh=Z+/c89j32b2vZ9L146b8G0oQcfROD134sssyE4LiTYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TzJcTo77kQErvdg1VQVZpO4p3/3zN7ETQ5/SUkFcTAyObT+pFg+13QcQ2uD921Ti8
	 T2kM05xyxvWF2cQG3r/2Xzpf0Pz4o8MQFvDYKv2rqMGLHSEgcMsVkLf2BozsU5W5s/
	 UltzjRh500CHfhzZ9C3PFhw9kWeORC3o4U1XVaVapDmgea/obr4eePVacb71fSg9/j
	 +QfxE4gqccsk0BIy2Mc37o7wr9N+1+jbKRIsvudUUH8eQ/B0+lSY9sQQ4UlP4x2ci4
	 HwqUrnwZibLVI+FTQaWkK7//ONxh9Pkon2ukUR25oVYNM/BBJeJe0nlDdMabuH8Ejd
	 OtRWm+teXeZFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B79C44507;
	Fri, 10 Jul 2026 11:20:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 10 Jul 2026 12:20:45 +0100
Subject: [PATCH v7 1/7] iio: dac: ad5696: properly check i2c_transfer()
 return value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-ad5686-new-features-v7-1-1bcc8c280e4d@analog.com>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
In-Reply-To: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783682457; l=1018;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=0adqBlbl4dTMRxAIOk7QAvkBMzJDBt+Tq03dU+E4TBY=;
 b=c8W3eMCQ7RttpJqMVNWBVpt6H4evr+Hzn9ii0d40rXKHBOFgc69V5O+4idXLDb9nQZCms6vSD
 XK1ZMyF+YbQD+5nze3fgGxjs19mzL/IVF/w6vgmMQW9d6PVs/EQ/AiD
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Verify that the expected number of i2c messages were transferred when
ad5686_i2c_read() is called. This issue exists since the support for I2C
devices where first introduced.

Fixes: 4177381b4401 ("iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260705114746.1485F1F000E9@smtp.kernel.org/
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5696-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 279309329b64..6f726e6301a6 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -40,8 +40,8 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
 				      0x00);
 
 	ret = i2c_transfer(i2c->adapter, msg, 2);
-	if (ret < 0)
-		return ret;
+	if (ret != 2)
+		return ret < 0 ? ret : -EIO;
 
 	return be16_to_cpu(st->data[0].d16);
 }

-- 
2.43.0


