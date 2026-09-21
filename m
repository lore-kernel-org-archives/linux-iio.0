Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CABD1A681C;
	Mon, 21 Sep 2026 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789952809; cv=none; b=CgZZ37M/O+Xb2D1o98Mb/zUS2ky+XOcdx0OCOpNdAMyEBDysJJhw1vr04O59ltDs1gJirwOWoEzKFrhWfWMe5ppn4TH/cdWtxWYTitu//Qn71WULKiCliLEpjivqTeZI24ZUrYSoJ8vLwWpRoddmJInsZQQFzESWl+D4NXCQtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789952809; c=relaxed/simple;
	bh=kSeIPaZnSdLwk48BLT3A2cLYFdAdm89k0wI0JXNhWu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PEEVHhFwyMDNg+FTmNjUbHAsnzMT62BtOc1RhYYfEu8v/WzMYI4/Za+W11ZNCX5JzoM/3M+zSU9HetXy5Z0muuOyaAW7RCMZ5sMRzpdTkhHwBaq30LcwBDoExQWLgMnlDu7/weJDP/QqLsYDJbnX18oMGXrUSXmKow9pqADsqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwGARmwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwGARmwq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85F53C2BCC7;
	Mon, 21 Sep 2026 01:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789952808;
	bh=kSeIPaZnSdLwk48BLT3A2cLYFdAdm89k0wI0JXNhWu4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TwGARmwqxjmLsL226LmUhuaPpRBhVqTBAcxJCyYeLV0e7+I3uAOAMxoYtLmSgsTq3
	 +vYKhHxsjFYtcY9a90PixfHalVrkorszbcqZDUsFT40ZuQQLSqbT8xashJduqdnvjG
	 HF+d2m4ZSBja11hQHt+5Sh8ZIqLcL9BLEkY3QMTqRgVr11SeP6w+V30fjYQ0SvIlck
	 IBvGiMMIwwZNQzJSYLea3FVOrlzG+cJaO9QwypzEfcIjBwOn9w644jOTQHVfXKTQTr
	 RnJijviM4N4N9KYugLF3nT+yTYC32cGqUNZV/VUG54h8k6ionfP93IcPUFp89dhPTw
	 cQGbn9VwkHsSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7A9C982ED;
	Mon, 21 Sep 2026 01:06:48 +0000 (UTC)
From: Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org>
Date: Sun, 20 Sep 2026 20:06:45 -0500
Subject: [PATCH] iio: accel: kx022a: fix typo in comment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-iio-kx022a-fix-comment-typo-v1-1-9fc233272712@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IBqm0Vyku7DjqtJhIEosi3
 r2xLh98/g5RgkqER7FDkK9G9S7DlgXw2LpBULtsIEM3cyeDqh4/qyFqsdcV2U+TuIRpmz2y7Sw
 L1VVNPeTDHCQ3//uzuRyX11s4nUs4jh/VuvWYfwAAAA==
X-Change-ID: 20260920-iio-kx022a-fix-comment-typo-c1d1ce27472f
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Carlos Casadiego <cdcp206@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789952807; l=1081;
 i=cdcp206@gmail.com; s=20260921; h=from:subject:message-id;
 bh=mvcHymTttESoKzke8JCk3w2u0GZpHklCZh7R9jCyH3U=;
 b=EEMBuBP1D6LozTGVw47+ODRdmdkOqJiA328/LP37/Gq1hWFkEorZkg5w8eQm+qF3azdvJ/xsg
 EEJUTQGiqJ6A/XNlc7/a++YeeQh+pZEUQ7OpoSz9oM8NT2ieZtjjnIO
X-Developer-Key: i=cdcp206@gmail.com; a=ed25519;
 pk=Vr3c2AUi1oYbgVkQtRSsWin33frZn0vGGq5g04VWmH8=
X-Endpoint-Received: by B4 Relay for cdcp206@gmail.com/20260921 with
 auth_id=1041
X-Original-From: Carlos Casadiego <cdcp206@gmail.com>
Reply-To: cdcp206@gmail.com

From: Carlos Casadiego <cdcp206@gmail.com>

Fix "usng" to "using" in a comment.

Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 8f2810c8ffeb..a3d80e4e7f1e 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -809,7 +809,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 		 * the timestamps. If we are ran from IRQ, then the
 		 * IRQF_ONESHOT has us covered - but if we are ran by the
 		 * user-space read we need to disable the IRQ to be on a safe
-		 * side. We do this usng synchronous disable so that if the
+		 * side. We do this using synchronous disable so that if the
 		 * IRQ thread is being ran on other CPU we wait for it to be
 		 * finished.
 		 */

---
base-commit: 61718ed183599e5162496b5306c3377a925d21cd
change-id: 20260920-iio-kx022a-fix-comment-typo-c1d1ce27472f

Best regards,
--  
Carlos Casadiego <cdcp206@gmail.com>


