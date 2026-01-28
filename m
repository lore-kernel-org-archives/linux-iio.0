Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54936F417;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622745; cv=none; b=e7fhccNLZV/tdkjGHtWaT4O1SuhYyDb4CuVLMi3+aryuMrEE2XFCniUxlttxuScmK6jI2eXihcLqeJ7EwxHhqZ798xrrVU881pVWUbIO5h/v3XRBcB5bg8YTT6frnANSYLrhaHnQ3DoSdmCBmeP7byElvSCY+zuOXTiyxycLHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622745; c=relaxed/simple;
	bh=3KqnVWEI82PftnocqjwUUeyuXpn7Shz/eThc3+dzqD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6cpHOmrVdPJnPSsT3hmDbNEO/g1CijxsWUPpSkf1oEV2S9tG6inYyNQ4DcAYhKXahMufA0zYqVi0v2S/NDY1BCHUsJDTHcFPp2eQix15TkSizQZFWyOuvvc2ZPjUmyQxEwVoZFP9ZsdxvGUENQKkYjaBNo4pHg+arl9I/4DXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rESTrm2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rESTrm2D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3916C4CEF7;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622744;
	bh=3KqnVWEI82PftnocqjwUUeyuXpn7Shz/eThc3+dzqD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rESTrm2DV+fAKvxi4NNmdZVIgEo4FkZLYyAxEhYgOovTCuSChTGAtkwTAKaGJmtBi
	 xRBPPL5cnXBrplBHbE3/H0gPnHpCz0dxcr9iCwlUAJeLyPEZ3mURurEoMMYS4v4ID9
	 +rlyEDxQTVDZSNbwnDgZqZ7l4wzzhlT5Fh7mlsLRcK4sE5q3OV72PB5x7iquIbJwKn
	 9+Alsh6+YVVxvx64CQy76PEPJ0gHPSbsCXD3OPz1vh0SK6YDYBqVB7n1x/vH1DJjhE
	 5EYhjJNxosW+95i/CQkVhKRFREl28o9ctcq/w9wMbnTIadb2wtheJczSAwQWbLiwcu
	 nrDnlZdLbCkhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95197D46BE5;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 28 Jan 2026 23:21:48 +0530
Subject: [PATCH v8 1/6] iio: proximity: rfd77402: Reorder header includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-b4-rfd77402_v5-v8-1-36388fe7b95e@gmail.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
In-Reply-To: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769622737; l=791;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=S7gtwc1iB+CgJhiOpqTwX/EfJ8gcFTrqsLvOeW1favY=;
 b=5+9oM1HKUPIWWQ+c8bW2+UaRY9Rium91H5ClqM3y9LXaggjnZeedEeeeGMkr7owMGHfWvtDUQ
 WgxHipgqSYJBjnyY9IhderAkmgNQfgxYNACIFL8Yj6ToyzQTxQ8xlEY
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


