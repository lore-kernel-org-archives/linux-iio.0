Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323C1B4F1F;
	Sun, 12 Jul 2026 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783837617; cv=none; b=AVvSwAZ9AjQ+EugAK7oAbUXpM/a2HuablQ0h9qOeAuIz7YS+pWDxNRNSenSQh4roaIfwwBGC2Vidi6baTrwTMJUrpOkqrapQTajj9FqgUDztmTsIa1AzCzxmvq/aHVajnTe2fCauRlCOnhga3AxXYeR1UQL4XBUcSj8jzreuUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783837617; c=relaxed/simple;
	bh=Vr4HVuUefqZoMgR1OZYG2aJ1KU03OvqZFMVAlXZ3S3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MMKsN0aI95lXejYn7nwFz1QbwHpT9pOJ8fkWO+NxS6E0KtJm2ANXLXn2f2eH0V35f9yzYqP1ZJTNj/VJu3SZFzw34Cyr544dkjqfpMCwtgulMmHyLNPSo7u6edqcI2d2K3UQn8tNV0ubsBhoeMEA8nbtpqkmbTa9z/sZ7ktCLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlNP0AXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlNP0AXp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2985EC2BCB7;
	Sun, 12 Jul 2026 06:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783837617;
	bh=Vr4HVuUefqZoMgR1OZYG2aJ1KU03OvqZFMVAlXZ3S3Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UlNP0AXpR0W3oNYqEsa74thYYwjIS8sI7Vq6nfANp7C55AJgAvdDQnYFT/FsL0Rac
	 gmaQ6a0lY7oOy4/54YhSI8Xerj8S4wz/W/NJbOoH3K26iNVGp5P+zUNavJUvMPPlbE
	 x3fYu16933LYIcD8ibxwvSiaN6DodGgLQEs0MbI6uWgJUfQnOskd1GPdIT873JkKmD
	 6QQznvWV5xyK2haicsllKNg1Kf9VqpbnGs66mXeKXiZaZI4xmoMobLbnitWT4H3jC6
	 VGvaonBKeXkVqo7SEd6wq3lq+x/fAf922XfByd18wHiSXnqljMVBClUn+dwd0qSbIh
	 CatX7sL+VI+fQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF5C43458;
	Sun, 12 Jul 2026 06:26:56 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 12 Jul 2026 09:26:36 +0300
Subject: [PATCH] iio: adc: mt6323: remove unused header
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-mt6323-adc-rm-header-v1-1-d96395d1a323@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJTLUYr2JYlPZHxgQ0UzQkh
 Ltbdfkt3tsowxSZLtVGhrdmfcwFzaGiOIb5BtZUTFKLr9tGeFq8E8chRbaJR4QEY39yaAecj5I
 ilfRpGHT9ba/d3/nV3xGX74v2/QMdiVPweAAAAA==
X-Change-ID: 20260712-mt6323-adc-rm-header-653e7fe842dc
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783837615; l=887;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=4AfmdH97pxmA7NGkEcbGJbdXmNTkYLKIx6MU+gfb9S8=;
 b=bb5KN3ABVq20sUCeCrgmAdVq9DUtWjUEDn0Z/GsgayOaPBYwEcqAUNghEqJiXpdx/neq9Zy3B
 gnnMxpawH8IDS8mtOv9ueHAQjFbRTGkbZY597sUts0aFjDyxrO6tuko
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Remove unused mod_devicetable.h header.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
A small cleanup for mt6323 auxadc driver.

This patch is based on top of iio/togreg branch.
---
 drivers/iio/adc/mt6323-auxadc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/mt6323-auxadc.c b/drivers/iio/adc/mt6323-auxadc.c
index c450fb6f09cb..4f73ac42abb7 100644
--- a/drivers/iio/adc/mt6323-auxadc.c
+++ b/drivers/iio/adc/mt6323-auxadc.c
@@ -11,7 +11,6 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>

---
base-commit: 2e2f2de7532cbbc2269de8be20ec709606c6e79b
change-id: 20260712-mt6323-adc-rm-header-653e7fe842dc

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


