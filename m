Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFE224AF2;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455977; cv=none; b=Wmhsuz4DmGubZTzLZACBb8ZURUh4eCl+x1A7rUzvfqfMQaTHZ0YJJB6xvxxTd2FSmkla5hWA5X7NKGz9QR90o+abGLlgTPlXRFK3CUdcn/JlNjoLOKtY/1tDGXQAkv6hELWFwTS61DCU3IqYgg5exULmmL86ki9L3K9LVOBJJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455977; c=relaxed/simple;
	bh=3KqnVWEI82PftnocqjwUUeyuXpn7Shz/eThc3+dzqD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9qk4Sh1yrAL4QLDfbZnz/sCW9xRKs8jbVFaRwNm+xX25IWUQBg6OtIeEU6f68kd1Hk7XQZqxoW9ypKHgRDxSV7pqyIpcFz4VfY5RFfmywDHH1p1BamdxBB49njsANEbwmIm5m6Mf23dYuH4wCqnw+5eONFCWjJhsSv/dNyz5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWUFRD46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWUFRD46"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3C83C19425;
	Mon, 26 Jan 2026 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455977;
	bh=3KqnVWEI82PftnocqjwUUeyuXpn7Shz/eThc3+dzqD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kWUFRD46hBWiLdRPzkEi6aMyW9MtuKk0+3FA9PTVKhf2CBeJOd4n1D5Ijbvjjk5/B
	 xkbuq6/FDB7O0yPYy45ScCEVJ4NOKRFnu8X3XGD0hioVOAhwvU32bBUn0KBu+z1o8m
	 jxXKmYwVhyI5IIVsxNqIQyPQlj9blxfFXVw5ltGbOzYds/IDr79lSbfYyZswfcYCCf
	 ZDu88INb8cx/3zMOYoPK0HGqBqz/aNFD0j5Splfb33eSHRmoV0hhpIEYOczil8FzIw
	 bAkOinASlfPTSGqBP7yQiseN2hB6sW+6FpgKxzVq6I5ahKIhfIR9qXEmEFdPs0DwHu
	 SP5KhNzPrhU2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19E3D19510;
	Mon, 26 Jan 2026 19:32:56 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Tue, 27 Jan 2026 01:02:15 +0530
Subject: [PATCH v7 1/6] iio: proximity: rfd77402: Reorder header includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-b4-rfd77402_v5-v7-1-3e7f2d452da2@gmail.com>
References: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
In-Reply-To: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769455974; l=791;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=S7gtwc1iB+CgJhiOpqTwX/EfJ8gcFTrqsLvOeW1favY=;
 b=bM6G3jW8/2Dp4soyoClWEZX1X1+Rm54+TAc/MdoEkTPJ620fJe45L/T52SXx0CjGcmLaz9nPR
 jV8Gy+y0p3BA0tfv/ZMbSrracAS0Hzzm4RtSgI/TXpqLonziAKgOI4w
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Reorder header includes to follow kernel include
ordering conventions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index aff60a3c1a6f..69cc1505b964 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -10,9 +10,9 @@
  * https://media.digikey.com/pdf/Data%20Sheets/RF%20Digital%20PDFs/RFD77402.pdf
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.43.0


