Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795650517;
	b=JzHf4OLkoOZPrJ80BsBd13UzFvZyv/ayjXtbqBxW5vUQHnN8c0ldfgEMerM5t/Yv2II5
	 jGjd5Qg+E1MSx6CKvJ8gXEr6UnznLSBnHcyQCR0Z0ZQei4n3QcauW+uk4cNpH/pebi5T8
	 TRFVJzstM0Jp/Fs/hBWIucxktbawCQIk1xhesFo+jZ6BoswCyhdIXYdztpg/9NpcUUhoy
	 VVWUxbO56d5SREZk2eJUac3e0wjAqt2e+CqJkE8VqnptgjL9Myzb3UYOV9AkfSzcXqYZE
	 NtuBpcvH44XzISjo0Qngx5yHWAm8UAU+4XZYuYRC5LdAWJkbNXgfa/8YJGl5mQKwFxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650517;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=OroYPfHBrbMzKm95ex6TJjzNUQKP+3yVQZmJ/q8vZIc=;
	b=o37pZOad+aCxRvatJK8xXwQx2n6ibZhVxEzNJwW/uvvx/H7r3RLPYlNMhtE4MnlHR4cB
	 XIN08ofL1u15bQRUqdwxbQAfdZbH2zpS9mZKlAestFoFz1K4BwoY6mZohpwWR7pa6XGBS
	 wlm3n0ceEGkRGt6SlbHJgso0K0OARYCgEBTFy8+hKY6QV/M6KCZcxw1qB19ylG3WYxvcv
	 ILJBnoiTTPpDul5uiuUmywOb++e0Ji6vSzcn0oLF5BXZm1SgWvnD27RhDdaWxQx2FLsUP
	 K8YNUhCZyCDOjGafNImSXpvJSBv/W3L06TY9tnzU4AiydO+TNkG5N0UllwP3ScEvpyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=buOJvzXx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AB5606A32C;
	Wed, 25 Nov 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=buOJvzXx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795650517;
	b=gMdawWBB5K14vDCECtwSIxqB7LqwejqlVgRM92L6ST3+PPrIZvkksXTZVcoXYyFonIve
	 ukhw8/jbn96HahwodNc1nK91pVFYXKDuyKua2biPN/kGNsL6Eercx6Bup6fzxwkF9glzw
	 2AqA6fXGQ8WzOhDB9serjI94vxcaay74Q1L5rbVtsMYeMVObS2kxoKyAOA2UGSeP3TkEH
	 p5EJV05JG5Ibv5434jLzfdpSqvEQ9vZaX80nQqdJFXQd/Wa0Lwhgr5aNRxWM6JSL6wd8p
	 slRTHz/LDXYJ6s/QWsCo9WBNGeIAA9mFb32DGMGUcx/tR11a7HkRbhcJEmErgJ3dG7A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795650517;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=OroYPfHBrbMzKm95ex6TJjzNUQKP+3yVQZmJ/q8vZIc=;
	b=j7gY8QzyMp77cV4vtxHpIxraePHRvOcIjM5jn1wYlWncJtrJ6HhMm5jnh0JkVf+Zqnzj
	 j7VJNZN4HhNcQZQlo3N7V7gtPcajSrny1zDhrHqBeeADO6B9CjTsjTD+9viArhvlB4Fku
	 f7AR8kmH2ln+Kxub7fneTkaJTN59jBhrZcY1wbFQcD5FCl+OVnOqy9JNh2HYKkDbhveF1
	 BCMxaOz+M+o1eTv16+YuHfx+rOtvQn4NrNruu7TgKOpmYQKg6Vfn5amzWLa7SzdUqmdLa
	 pQE5wOyIUkTL1wwYCeORGLErODzJblppj1Gd8sdloctC18+/MM5vQcNbHk7+D7qZPDQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B4B601F0089F;
	Wed, 25 Nov 2026 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795650517;
	bh=OroYPfHBrbMzKm95ex6TJjzNUQKP+3yVQZmJ/q8vZIc=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=buOJvzXxC0XX/Ocn/E3oV1UfMx/vPTIEsMKM/aqriKT3Nc5raFj4pqqnYkGlob9v0
	 lmadV6D8Wf9I9Eh4RGEmCswje7ALl9CE3En+UC0oNQ4MqBIkWkjzFc3tNZOAXYBcmg
	 9Lt7yOxRI8NymuVSKCB8Qx1ZDa8q52YIBcjeW8e4NSJIfC62PVlS4lyT1bltbQ1Y/Y
	 4fy6Vquip9kvuxMvdFbfnWAh8ht+FdUz+FNIipq1OwJ5Ql1bsUupD1yHVlYCjktEbN
	 0XXP+NzId/CvFi54M3999z0cybe6cXi/0VKypEuRXhM/XwrRyVoYF+2BH3JAFpdmTd
	 2mcuXCr9nZywQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9CD064D0C8;
	Wed, 25 Nov 2026 23:48:28 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: inkern: guard fwnode_xlate with info_exist_lock
Date: Wed, 25 Nov 2026 23:48:27 +0000
Message-Id: <20261125234827.94791-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795650508; l=2248;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=UwI8MEOFQMNXYrZCfHn2V0m8wxZqqR1RYDKf/G0SIio=;
 b=rTYVmb1iDg1w9r+pQu3nCr/1QL3iCZWFQzBPwBrnjrGm/KhD0BTxuqrwN9TuMeW/I+OPjWKoW
 Ex0DWM6YHhmBC2RYJ9mZ047mkZG6667zSfQlo5HmEBy7xs1xZArOQRF
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

__fwnode_iio_channel_get() dereferences indio_dev->info->fwnode_xlate
and invokes it without holding info_exist_lock. Concurrent
iio_device_unregister() clears indio_dev->info under info_exist_lock,
allowing a NULL dereference or callback execution during provider
teardown.

Hold iio_dev_opaque->info_exist_lock with scoped_guard(mutex, ...)
matching the rest of inkern.c, return -ENODEV if indio_dev->info is
NULL, and bounds-check the translated index against
indio_dev->num_channels before indexing indio_dev->channels.

Found and drafted with an AI coding assistant.

Fixes: acd8256723f2 ("iio: inkern: Add of_xlate function to struct iio_info")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 drivers/iio/inkern.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1f22275..1a64b71 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -145,6 +145,7 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
 				    struct fwnode_handle *fwnode, int index)
 {
 	struct fwnode_reference_args iiospec;
+	struct iio_dev_opaque *iio_dev_opaque;
 	struct device *idev;
 	struct iio_dev *indio_dev;
 	int err;
@@ -162,15 +163,23 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
 	}
 
 	indio_dev = dev_to_iio_dev(idev);
+	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	channel->indio_dev = indio_dev;
-	if (indio_dev->info->fwnode_xlate)
-		index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
-	else
-		index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
+	scoped_guard(mutex, &iio_dev_opaque->info_exist_lock) {
+		if (!indio_dev->info)
+			index = -ENODEV;
+		else if (indio_dev->info->fwnode_xlate)
+			index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
+		else
+			index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
+		if (index >= indio_dev->num_channels)
+			index = -EINVAL;
+		if (index >= 0)
+			channel->channel = &indio_dev->channels[index];
+	}
 	fwnode_handle_put(iiospec.fwnode);
 	if (index < 0)
 		goto err_put;
-	channel->channel = &indio_dev->channels[index];
 
 	return 0;
 
-- 
2.54.0 (Apple Git-157)



