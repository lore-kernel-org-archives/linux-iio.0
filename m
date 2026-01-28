Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65C36F41D;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622745; cv=none; b=BS/aJ5Cd2S83BIKlZ5cRQOw/xaXW8+6CqgZAxwjKkKfaHvzRg9nTTcpfpoJareoFlHt5la97nMBq4t8KfF9aFibM5DcC16DSMjhhACed6ry2Wpq/7WIaJELGooYwo1594YW3SFwDMmCg6niP7hN+MqM49kYtyheOJZe4VVqiwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622745; c=relaxed/simple;
	bh=xEfhX36soxEfZtpMB211ApIw/r9ApketMd38E9CFb4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRus+JLOV4ygKOQIsIev+oqFzXJsTiRLEO4URmlxKPfSK2KjdQHR6WMK69hLBvmTQs1IfdXjR1TCOS1g7Vo5x7JzpoDOe0rcdupvjo6nQ29wY6eNi7J1SQc5XVaHV0tnyf+ODuUkfkBM0c/aCzUYz/FG3wKrW8f3zxJUD4KsPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef9f7fjs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef9f7fjs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFB7BC16AAE;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622744;
	bh=xEfhX36soxEfZtpMB211ApIw/r9ApketMd38E9CFb4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ef9f7fjsk7nbsc7G0Wan5IPGOyp1fLT4pf2C2GF98J6S20x5HqoRl66YIpAMecMTE
	 ASPWDO71F7WdCgg7FRU7/QFKCklF900ZYC2nDtu18z1VSCRYP/2SxVx17rhrzZKp12
	 QyvucNUm9qTz95rPOMu6Ooh+gzQxPENwcNymsCzgf/PnKMND5QoSFuT6+TeP+T35iB
	 nFDfh29sBpoIwVlNj9fP4+X1CWrAqvc63o4GSM6o3YKIv3l2TD8ri66vJW41EVgQ4R
	 ndtI953GV0CDwcNdeabodHQSNZTfmiH6WLkPaCTKXi9QDHRv3swUBX7O4Sl9lbp9ts
	 VAZ8fTfNQmfkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE7D46BE9;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 28 Jan 2026 23:21:49 +0530
Subject: [PATCH v8 2/6] iio: proximity: rfd77402: Align polling timeout
 with datasheet
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-b4-rfd77402_v5-v8-2-36388fe7b95e@gmail.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
In-Reply-To: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769622737; l=817;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=EszL1g394dGoeHz3qJUHUL8JHDZu8HglWxCDO1QGkP4=;
 b=23HwLZpgAD8vtUAJKSQUEmxbI658qK90g0buVS+GDtugSwX4KRnUAj5g4iipyedgY0wORgj82
 IVIg6bnkjdQBSzZiC6jApSKfVewm3iEKWkBD2DSt7Abu2vgmr5D3s1/
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Update the polling delay to use a 100 ms timeout, as specified
in the RFD77402 datasheet.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 69cc1505b964..8f7debf0e61f 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -132,7 +132,11 @@ static int rfd77402_measure(struct i2c_client *client)
 			goto err;
 		if (ret & RFD77402_ICSR_RESULT)
 			break;
-		msleep(20);
+		/*
+		 * As per RFD77402 datasheet section '3.1.1 Single Measure',
+		 * the suggested timeout value for single measure is 100ms.
+		 */
+		msleep(10);
 	}
 
 	if (tries < 0) {

-- 
2.43.0


