Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3B217723;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455977; cv=none; b=EBSTXwBC56c56kxw/G/vuwB1yyFWr1E/t90KiHxnTPwnGKn2K+YSEdmtk1bQ7dURKg1+YM0Pam155GgpIGgJJboQ+nmCBQ3E85H2cPogZoDArOaq5O87RMPMzAU2u3FbZLoBKe26osjh8fePJ6FfwrSVs8RRJBGpkzI0W8w35lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455977; c=relaxed/simple;
	bh=YRoFlaSObNKoiaRKLIvX+0H6yPlDWAYqMv2+vEKHEew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCX69eVcPDWy3kXNoUtWCW3S9k832FzO7QklPED4TyBDkdhOdo19Wq0eehhEen0g1QJ/wYhsZPnRJQfEupsU9x3NOiw585kHdNLPObdy+Ue8mxfDLGeU8lDzIzfdKpkv1mmQV2hi0VhHuw9x1dLjzT/7hRiNQp8RWilGlA0ssJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9EKH6Yz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9EKH6Yz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10DCDC19422;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455977;
	bh=YRoFlaSObNKoiaRKLIvX+0H6yPlDWAYqMv2+vEKHEew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z9EKH6YzeAIac9FnAltNMwelo0mMyBIObejSjcPRKiWklBS5VR/YC6BAecv61mgg8
	 2nE8XDcShelEXWnp55jH4rtePZq2MkzaagyK+ow9Fo+9ieabRJTX5qNomWh4XTWTyq
	 WjrpP3Swnu7K9z7DenKBhhc/HMsjnMilFT9gTeo/4vGOAMc7Nsh2GYxg7+zqisZV2e
	 K1mgqbcj8hBqvPRCWImlJFP6b43qNKgn9/Muw1k0MSkdnydKlIjKxw+QtEE6qG9FSW
	 doZiICF80LEU9XvnnzyolWKD16ZYf48wpPyHSLhgLZLoPhUI+gW08t8gH6P1/FRRvm
	 ZZVz6N2OezYBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02280D19515;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Tue, 27 Jan 2026 01:02:16 +0530
Subject: [PATCH v7 2/6] iio: proximity: rfd77402: Align polling timeout
 with datasheet
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-b4-rfd77402_v5-v7-2-3e7f2d452da2@gmail.com>
References: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
In-Reply-To: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769455974; l=667;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=TaE9gAMSfYWdrqq17KNOJs0YkY1PEqKmG/gPTNBcwIU=;
 b=CWkUr6w16yGAeDFoPX3hanjbzQ3l9UN8Ao5BJmpx82u+yiJWbcTKshE34IQGcdpwPGlqQ4jyW
 TUN5z49hnVUC5YtZmGMXe5oB/krpUig4e++bTS8DXSo4aHamujqoshZ
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
 drivers/iio/proximity/rfd77402.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 69cc1505b964..3e14660a4bb1 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -132,7 +132,7 @@ static int rfd77402_measure(struct i2c_client *client)
 			goto err;
 		if (ret & RFD77402_ICSR_RESULT)
 			break;
-		msleep(20);
+		msleep(10);
 	}
 
 	if (tries < 0) {

-- 
2.43.0


