Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D84722A4E1;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455977; cv=none; b=h1gL8tW+S6ucxhf8GnfZAoZM2ZbwPTlEztdETDKAP6iCDZh/pko0UPzj+YzWU6y1QQhDo7r8hQqqQPMa5RG2qPIAk+y4wt8WEnAn1ajuJbUBE1XSGn/CO2+ndE1zfDqxnTPnhEQNMfX96dCjx5T336ct+90y9cKHsqYN1XXIEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455977; c=relaxed/simple;
	bh=9zO5JxPpwU9Bq+Dt2g2d2UItDDZIf0gZvWrs+ZUdDhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+wxAHBV0Jy1nFdSXW7Y8FfhyPrjSub+sep4bbYDyPN9lEnH0cuttKNC2ryKqbeM9MLy3E8SDO6kWOwS2SQ4H9avDTNDFeakqxIcxbF/kKwxpxNxMw5zut/8G+I3lleqZ5ZimhwcFTVR1fBnqbXUn5PvQ/zLrzpgMAMBBQDgGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSa5HiAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSa5HiAF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37E96C2BC9E;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455977;
	bh=9zO5JxPpwU9Bq+Dt2g2d2UItDDZIf0gZvWrs+ZUdDhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rSa5HiAFYctZBqwafZ3aaPAOIYPTK9b7H5UCcKWM7Eu0ornSqkBHo+OPdwHqZxweO
	 EmP0bXY6v2WoB/boULIR6aNvRCQGcP9seCYuLnun7NNJjj2bJ9KTxciRRSayAhLgfX
	 JNJqE09E2T3FsdmKF07OgLvo0XKAL92rgCOEfKXb/lwvRQqvbpREMlH3gEjB/VeDny
	 hperuCU9ud2Xvz9fK2OxH+eS1fnGUHyiQawM++zFzqDGMXXO6vhxzlrWHCvLJlKsvs
	 CeDRRsEL46Tve+TSDNZajtREw1vejtqypuuZCONhuQc41yYYWO2BemOn33eMm5zklK
	 NBIsqk06tILzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD33D19510;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Tue, 27 Jan 2026 01:02:18 +0530
Subject: [PATCH v7 4/6] iio: proximity: rfd77402: Use devm-managed mutex
 initialization
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-b4-rfd77402_v5-v7-4-3e7f2d452da2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769455974; l=895;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=O017TADCPm7We8ptZ3sfVe3HpHsX8WgePZRWSMO2cOY=;
 b=9q2fvQNYPt8+mTL/6LaSpidrj6knnXaEw49OvM6Eb+pllpWrpj7k4fws6wTdVUaJpuZD+T43D
 JDuQRHZJw+CBlIgilfuL87P5bQ65JSrfW7fD4F8FaG8M4A/3nqlxJgH
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


