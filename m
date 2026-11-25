Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634668;
	b=k/abAadCmjXRevjxsfjX6E7s8zHSZaNuFL6sGC98Pre+e0eNvJPVe4YVRhXxWwmPSdyJ
	 xjbsCePuoP/menJjJ1OgKxlhwefb2HyCGmzJs6xhvJx2MguGgm6ZZ1/XpAJ4sVzBurg75
	 MLDCKdHCVAjvAK7tCPzM6q/NQl7jbXf5oqJlpVYMs7Zhfq0rwFfDZLRM6nVUSpbFkJo07
	 J5fte76B/8XT+FcWqlScjlXHur4oivQzwUoC7HteRhalchRDe32ZVzq9HpokmcW+bwpEH
	 8Jq69t4arZtfgz9nt+dUmVd50TJNKnhow9gdlFCnWzaYDhjHtiJgcOAP7NEtQcnHCrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634668;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2WcJOHEojqwQRGDYt7Tfdnfou1UJX84nv4YBsWuNpJI=;
	b=tCnHP3La7oV5r4uu3w1y8XFvUl9jkyyyFYgDE7Gbzbz/mW02YrSWQP9W5dGEHMQYB2jk
	 NqBdw7AXdy4Aw6bUq7XTIyR5Hsf3kthYiU+McJ3BN16nkMFKP17lXdfK951K+ig3ufQOT
	 XemTmFyTbPdyfmwchjA6lbm2fbZClZzkufWZQLYL/V/oVgqxL66zaYjjf/hNOOP0x4M7J
	 T6yt8mYOj3zhTPgOvNBEaJLiSflScnHcD7Y4le3/50onO/eX912t9+/RxguUtDUg4Vr3s
	 jR56bnaiHF5zs96Uf+/yg20wFZ0N9wowTDfM0qxtvEfdwF9lbpraxkiU8vKoXrfYvmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC5XFdFJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6B606A692;
	Wed, 25 Nov 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC5XFdFJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98831F00A00;
	Wed, 25 Nov 2026 19:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634668;
	bh=2WcJOHEojqwQRGDYt7Tfdnfou1UJX84nv4YBsWuNpJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NC5XFdFJHh315DMYArpGup5OxRhhxSrbdW8sqHMbH0Q1fGEyewJMISr3oNwUN9Iqk
	 bpljfkkaBkZwp6LLnflGWE+QJPVCumttvxuUTE7NKRkUmHLMWMnqaWGiIEs14OXqyG
	 /P6MhFcXLS2eIX+hL7r/pOqOrFtII+0HDMZGQRb/7YVPn8vfysM89syWFM4OXeKBAJ
	 cdRo56ZzR4aQA78T2K5BZf4ba1XYDnOEgGu7HqBv8q2SxOShTeHqoxzJca9mNsFMgB
	 9qTfeIwUCrQC1GtdMmvGHKwmzoknq6yeZF3EcfKu46Sep01+W/GYw46NE5yzec1vII
	 AHQaqsUldRwIA==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:05 +0100
Subject: [PATCH 4/9] iio: gyro: adis16130: apply iwyu principle
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-gyro-kernel-header-removal-v1-4-969b3e668d35@kernel.org>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
In-Reply-To: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nishant Malpani <nish.malpani25@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=970;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=djCcDoOlY4wwtwel+FMC5tvmmyvT8YuiFAyfjEKSE68=;
 b=1tVfSwNMeKGbreiUJmVi4uMnM4f2CeYN8klAd7TDKTcFs+QS9r8vgBBZNnTi2QEMWiSJXWN7y
 jphNMs2CuM0BNyaz3Mb8PF3V5MD0xUxlMzUXZWGhFdY3sBJK/wUiU9Y
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch all kernel.h header and add/remove the remaining
headers in accordance with the IWYU principle.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/adis16130.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index 2535e3c94037..ff406e034676 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -5,14 +5,16 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/kernel.h>
 #include <linux/spi/spi.h>
-#include <linux/module.h>
-
+#include <linux/unaligned.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 
-#include <linux/unaligned.h>
 
 #define ADIS16130_CON         0x0
 #define ADIS16130_CON_RD      (1 << 6)

-- 
2.56.0

