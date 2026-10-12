Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07B4499AA;
	Mon, 12 Oct 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793737; cv=none; b=A2KxRBoPHZun0u6N3eK7QenMuLfr4xCM5RJYkredjFB2FMUvTpJBMrlyoeewjKV+MhT0f+ZicuK2K5/uMjijoldtvzMjVdlemKOKocwzoZdykoy7RM9U7v2xGtCJQg9LGtDNZeVuoZ8QRd+5/Kn8iVMmAOaELGforEL7QBaQww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793737; c=relaxed/simple;
	bh=a3mlMaIn/vaZc5KFPWcigncV6jDmevyIdLHBHH4w2w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PPh69VGOHqarp5xJroQehAbNbDJYDhlXLi16uvl5zF+G58nNHZwlgleay8q7EjThmxS4EdTT+/fu0vVhpmXJkxfzHz5bSE7JhzKCd4GcKC78ShLS+5MeTVyRDvXmHmXavt8HbjG+BSuqBEleOM0tTycsMrtBKvFz/jvsFlNi1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV5Uwi31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV5Uwi31"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 716F3C2BCC7;
	Mon, 12 Oct 2026 08:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791793736;
	bh=a3mlMaIn/vaZc5KFPWcigncV6jDmevyIdLHBHH4w2w4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eV5Uwi31kPAfrM4W1rPQx4cUjrehyVu7Eul01CpqV+VmfbhQxRLnEGt0Rb7cFgkax
	 beTbxc8W2jo549vZwxEdR4+ctgyTNbG1cflS581+3PLlL3R51X8Fu0mZ+s13Hd3dhS
	 5dt1JXKQPRcfSr2y9qxvUQfjExLwWHRgWfz6C95yVyk5q+XAUig+7aiBg4vz54E2O6
	 yDoP3w8prbOSJf2+rE4u7cH52bTqrO2LQn4w0oB14PabulBALa+YN67XyJKRhrjqI3
	 86Inb50JZdmltLVcwZ1FNEB5K2loqvTlmKcaKw0vsMVJUpCWEpFxwmKqInGQI9+qoh
	 ZTeJzc5gOlHRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD55CA9ED1;
	Mon, 12 Oct 2026 08:28:56 +0000 (UTC)
From: Andrea Amer via B4 Relay <devnull+and.amer.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 10:28:53 +0200
Subject: [PATCH] iio: afe: rescale: always expose offset
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-iio-rescale-offset-v1-1-14ed15979ff2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAESazGoC/x3MQQqAIBBA0avErBtQMxddJVpYjTUQGk5EIN09a
 fkW/xcQykwCQ1Mg083CKVbotoFl93Ej5LUajDJOK22QOWEmWfxBmEIQutBq01vfdbNbHdTwzBT
 4+afj9L4fl3LXJmQAAAA=
X-Change-ID: 20261012-iio-rescale-offset-41254a33b6d6
To: Peter Rosin <peda@lysator.liu.se>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Andrea Amer <and.amer@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791793735; l=1309;
 i=and.amer@gmail.com; s=20261012; h=from:subject:message-id;
 bh=Hk6uj82B4NAvd2+YopIwSqouEWeeLPNEDXXoOxHcLoE=;
 b=9wgJsQ5priSB6KspIp9ezCLjdd+eKJ6yEdl0eFIwO5AtSU2ZmmetfbV6Y3AJhL1D6qV5NR610
 6iWVvx3qAv8CrnogKPRqEWXyCSansGopPr2lvig3sqA4uTG62D6Kgk5
X-Developer-Key: i=and.amer@gmail.com; a=ed25519;
 pk=TiMK202FvcPM+yKGkAI4hsAZA7QkwyEgru97PAFa4pg=
X-Endpoint-Received: by B4 Relay for and.amer@gmail.com/20261012 with
 auth_id=1165
X-Original-From: Andrea Amer <and.amer@gmail.com>
Reply-To: and.amer@gmail.com

From: Andrea Amer <and.amer@gmail.com>

A rescale channel advertises IIO_CHAN_INFO_OFFSET only when its own
offset is non-zero. A child rescale therefore hides a source offset,
and consumers apply raw * scale and drop it. rescale_read_raw() already
folds the source offset in, so expose the attribute in every case.

Fixes: a29c3283653b ("iio: afe: rescale: add offset support")
Signed-off-by: Andrea Amer <and.amer@gmail.com>
---
 drivers/iio/afe/iio-rescale.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 3a6a09ffa5267ddfd5131fbd04a5df928836589d..52be28cdb0c7e7c16a52329fe5d93459480736e0 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -301,10 +301,9 @@ static int rescale_configure_channel(struct device *dev,
 	}
 
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE);
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_OFFSET);
 
-	if (rescale->offset)
-		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
 
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense

---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261012-iio-rescale-offset-41254a33b6d6

Best regards,
-- 
Andrea Amer <and.amer@gmail.com>


