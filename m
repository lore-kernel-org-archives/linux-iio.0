Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8131A072;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752537; cv=none; b=G4kzo/wlWyuiIXo0dHdQPjfZIGj8JU929p/G0l5AO1Butuo+Oj+xXZTxQdNF+H/YmlVDPrwhurI1xpyJKfZ6qLg2BJS8OO50+uvSQTObKWF42mlQL8rZBnDRf3Xxf6NJVmjJS9LWbZk3DNVAiYSLqRhxfkJd/jqjLwjKCqAEl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752537; c=relaxed/simple;
	bh=yoR1fzWyBOkzBi+MwYVZ4VC+/LI5ohoCGPMQMCFSYCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGCg2vLlWwxbP7bR2HCJYhljZX5UvVt11Eqeyo87V8sGrPnfk09M3LSFSS/id9b8eD9LNuW8ck8voqnu4FuNmvq0wPl0hQBoAsS6s8MbzF6sTU5ViJtpLjoT9fQAj8qRrHfO73LvTnl6Lj7gmUWGW+M0tGDJX/de5EfeBGM0ydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyrU1TDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyrU1TDv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83E3DC4AF0F;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770752537;
	bh=yoR1fzWyBOkzBi+MwYVZ4VC+/LI5ohoCGPMQMCFSYCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hyrU1TDv6ZQkRxUvDONN+3ADdtypTIxP2sTGiyHoA9EcdQeQiro3jD08kQUSD2I9w
	 s2/mpjqx5pq9+nJHGJIugLdry78sZWH3g8jywoM45/7m4EN1Xnd+2tyip0fqtmkOz+
	 MABXPEabr/HnSG5YhIkVtucerl2qYLgOtR9esXQbeSYyTVeKa14bL6QJtvOXz1GZc/
	 412WITrqrBl1Fcpt+obEyIkqY0lzdnig4IRX1Yl82tEX7I+gfWtLZLfM3tGzdJxSyT
	 Wgx+XN1s4L41hiMSpNfqVnqGDAz5TbsApAcHrwlOtxsQW/Wang5Dwl6jLbZ7Td9vW1
	 wqzMSPqdfdg2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7057DEB2709;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 10 Feb 2026 19:42:03 +0000
Subject: [PATCH v4 03/11] iio: amplifiers: ad8366: remove unused include
 headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-iio-ad8366-update-v4-3-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
In-Reply-To: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770752535; l=1638;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=CGbPKYHJlOJ9rYJnPGo0vg0Ptr//Gt2yLe6uykPVd2o=;
 b=3mPIYJQagyjOmd+0ojbhmRX/JbMX/TvzF24B3xqT5vy4n4kq+O9L0k/s4WCzVamj7hSc55pdi
 c+h4s2TTZ10BOP99kLBplrLssqY16/wSUdx07v06+ORihfZDGRxuqao
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Apply IWYU principle, removing the following headers:
- linux/device.h: no usage of devm_add_action_or_reset, device_attr...
- linux/kernel.h: no usage of container_of, kasprintf, ...
- linux/slab.h: memory management handled by iio
- linux/sysfs.h: sysfs interaction is managed by iio
- linux/iio/sysfs.h: not using iio device attributes in this driver

Being a small patch, the remaining includes are alphabetically sorted.
In gcc, compiling with -H allows for dependency visualization,
which indicates that except for linux/iio/sysfs.h, all removed
headers are indirectly included by the remaining headers.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d06ac786501c..6382106ee6c7 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -11,19 +11,14 @@
  * Copyright 2012-2019 Analog Devices Inc.
  */
 
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
-#include <linux/gpio/consumer.h>
-#include <linux/err.h>
-#include <linux/module.h>
 #include <linux/bitrev.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 enum ad8366_type {
 	ID_AD8366,

-- 
2.43.0


