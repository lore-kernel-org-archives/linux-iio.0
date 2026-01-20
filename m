Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED053B52EA;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941366; cv=none; b=meLXpUi0ZCzlLOTIDlcrI5w5NR8l377iGnWW2OzyIxO2aP6wPYQTemNz4r4u5YQGjMbxKMn0edordRDTK8k4CO7hQF+50XgqUfaHzFJ3BB1wkfjJE6MrNKemWWiUGacFpY4VvK/rTihQHuWBJQjpqX6C0QzvLY5ocQ/z0T3PsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941366; c=relaxed/simple;
	bh=UbUmzcvsKu9V0KRgT6cWJVKpkyxRu8aIhwGqdX6yOF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCyZVS4GEl729CL99UREgS/b176EAeEdD6EcL1sW9Wt0Vh/GwQWrLymn6v09d5sB/SazIF6fv5TXZODJ5t5qVuIeGs4vx3E+mmyrsrhqnQLJYLHhZyhbGAoeRmLvBtAxUMan2B2zODPVWEpR6UfYzKpYgp/3Pq6CaNBwkeV5dGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG4hujG+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG4hujG+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96032C2BC86;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941365;
	bh=UbUmzcvsKu9V0KRgT6cWJVKpkyxRu8aIhwGqdX6yOF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jG4hujG+sbw3MHzhkk81xNTFZKIjPdEEEsVhrXdC5OCMFb+31eLItxa97HmVyQzkL
	 4nO+UsbpQxV5Z+uxHCnMx8xzFUXb6Uv2GDVGW/XEww9JjaAQ1lLeJZU2CfrmBlLUW4
	 EDCSPR4v9NGrFG6LrN9aYN+EpzuHYIUgjiMMqXRGYjqmU/T0lQKoxQgGlWyFsMop6d
	 MgiL9BtIPmTLBg8b9IOOsbFQxNBjtax/rjnxLbiqmH+qwEPYCDKjE1xQ+OsOb7zJbb
	 1ohcoz8GiqCvrcn1TbkEee5l6JuGJPvF3BrIxQ+DKBQfJNLr9vhIwY6mcoZoRmetnh
	 GF8BGu3pfh0vQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA34D2629E;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 21 Jan 2026 02:05:43 +0530
Subject: [PATCH v6 3/5] iio: proximity: rfd77402: Use devm-managed mutex
 initialization
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-rfd77402_v5-v6-3-5b944d0605dd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768941363; l=818;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=Jbw2jRYhJCQKsDCCTnrLgTMuFbvpolChjoZDjy+nAZg=;
 b=1+1jcJY9BWvd4UKejZ3wtDiiEG0TDJdi0FUlMjglDA8UXCNZFS0KxMOqOFZc6zB/ekmi0/MjU
 vAYl1sSW+40D7GI3x1I1txBfGNzmOHdmo052pgimQtGBUp/H6IV1nTu
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
simplify resource lifetime management.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 716c9330b14e..fce85f783ab4 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -279,7 +279,10 @@ static int rfd77402_probe(struct i2c_client *client)
 
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


