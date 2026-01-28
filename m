Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45136F414;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622745; cv=none; b=ZR7tDSG7iGzCX694CLtRJlQm3g7SE3G7JZD6rK5mJsExK00REHXlpFmkXNpefNaAO1dus0FcmdMz87Jy6U4+jFBaQRHDKpKg3tI5l9mZ175h+6JF+XkwMfO2Tuxk0QJocjjKad1yodOV0bfdgVwYdewS+aQ9q3tDgJjP+HQDk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622745; c=relaxed/simple;
	bh=9zO5JxPpwU9Bq+Dt2g2d2UItDDZIf0gZvWrs+ZUdDhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Apc/NqeEotobmGrUn4gPvwPnZjJ4DObtHMfCe6p7P02XK3b8D0hlT7043P4CcPD6ENiWqyLZhm4koQ9OMLwnhnuKnF12TVr5gg8V9xHf+Y248UQ0KPUK2Nc83NNVtOxRzU5ciuLqtEVv1dR3211JUHn0NLpgj0eVVGEKdze99/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiykvDNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiykvDNx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C412BC116C6;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622744;
	bh=9zO5JxPpwU9Bq+Dt2g2d2UItDDZIf0gZvWrs+ZUdDhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hiykvDNxldM+g5njP6DmSkqdPxWIjzhfumJ+PelHlSQV+qDhVJzG9TX3vEA5nLWLN
	 EXZDCm1GcYXrBo+6Ceu9p7sgG+eXYRkifHdxT0WvtcnyLHsTvUhLWDfwxPjG+pNoLE
	 ylHX1Ub0QRuXGLAyj2er6Yrpkyw3h+nGle2ZnR+OREZSyE25//oh5xeecLxHeTYuki
	 IdAa14y2PgqsW3QO5RgpoAMjkGZBE58R90v9HoD4mraWrWMUFV/5eejAmZo9bbk8r7
	 +z3TeY52Ja8boouSqkp+AfAH0ZKUpH3phVSrldAYndeNmewXqTi7pya7GU2/UHWGcs
	 GTBr+Jk42wKHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF003D46BE7;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 28 Jan 2026 23:21:51 +0530
Subject: [PATCH v8 4/6] iio: proximity: rfd77402: Use devm-managed mutex
 initialization
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-b4-rfd77402_v5-v8-4-36388fe7b95e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769622737; l=895;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=O017TADCPm7We8ptZ3sfVe3HpHsX8WgePZRWSMO2cOY=;
 b=BDB746hsNTKvMaKUHh50R26llf1uiTkn9d3kQXQVISuK+YL/nK+1gaTOcgE7Xioh52bSobqXq
 +/vhtIjm+hXDi5hfLaBA9rVRArNGU8oTE/vrWweYmm5uO08FmYc9pku
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 6b23fb3bfe1d..a374a7389c33 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -283,7 +283,10 @@ static int rfd77402_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	mutex_init(&data->lock);
+
+	ret = devm_mutex_init(&client->dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->info = &rfd77402_info;
 	indio_dev->channels = rfd77402_channels;

-- 
2.43.0


