Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753F3A35AC;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941365; cv=none; b=BrOkg3mmkKxs/Z1PNlVKfDwR6wUDFT4laMnJN1qcM8g5Mg0a3KUZRq/b8ncUNdjyh1wVUpVlOD18+aX6FfdvZdX74LTjF96kmJbnE9S25P+k3ARqdEY7KB+e53X/M0HfmI6I8sae4NnRwI6gG0bcTkLcc9LCdpaLEDN3AFf2G18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941365; c=relaxed/simple;
	bh=5ZmR2GfzffFLBtHed5hb5/Xe8Pkk/TMf/pAQ/QvfE2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWoueM3xirSMTH73Ym9M7aLB65+GVgU2slLXyyK2kAOzeMPYth5z3BLQr4bk4ucqu63twbxeXhwpnlB+JGQvedgPXuml1pRhiiK1fehJfIgskPxb8q23JNTeHHlKXiwqMHWTeWbQPGlPVyhqSeAzDMeB7H/GF7ydMq9X+Sa5Om0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWtXmlR/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWtXmlR/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FF1AC19422;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941365;
	bh=5ZmR2GfzffFLBtHed5hb5/Xe8Pkk/TMf/pAQ/QvfE2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KWtXmlR/Gj/Svw18Tt3grSD5lqWf4kQItXQWIt9s9Z9M8JAsnJu71LWZXO+hvICZe
	 svjlaxYVf+dCROQrkYysgNM1lTk0YZ85ZUzQUiRR8lLHrnKfZtoIT8G0qKujJPy8IQ
	 dlPQ8YLRRr07NKbqwN6NLvmWTlN6EX1zWQ3bvbwOOkkd9gMnCbFw6ykIbwWd12hU+H
	 hKPlh9RNbsZ8IGIsCQ4STn+RHAgYXq+6MHT/txZjRUaTSjao8YdqgcKwegSn6HiX9S
	 hAZJjZYzEjbQDDUu9bLqDeNbQIg6mFtN8gIObiqjUPMN0H2mKGKXgGIelBhKZJn0UJ
	 hDWcWcXt2Q2Fw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F776D2629F;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 21 Jan 2026 02:05:41 +0530
Subject: [PATCH v6 1/5] iio: proximity: rfd77402: Reorder header includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-rfd77402_v5-v6-1-5b944d0605dd@gmail.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
In-Reply-To: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768941363; l=731;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=+lDkn76SMhA3dkH1gC8XiqHtbB8QLypbDZIHSMwSfMo=;
 b=/2dpmXYCt5Ks+vFNDZQ/RlkvexSClD5ouFTK3Pz9c0ML2KH62JnlJM/HNB4UvZwUMtiH0OF/Z
 +yZYo09NikmB7+T4LvIvQvmFgjyyVQJp+QrogNVRMP+Rf9W1de7LBGW
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Reorder header includes to follow kernel include
ordering conventions.

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


