Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58E420484
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131696; cv=none; b=BZgGBjeicZjI/Vv+g2t4r1gqD+Y4mSmFJF3ramhAm/oZzSq4ggX9xGS296Xz/xuDG20m48JKhqG5fRx1wUMNc1SduG291ycGKpaheXn6F+yr7hyPFtd9l3uYpejJHEG77lmq66qyUKE6f1AcqGNHv8jdglW887doj2mVhWBsO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131696; c=relaxed/simple;
	bh=4zOhqkRw2Xk7EzOqspTl31yqrk/l6B7zgTamE4F2gjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAmYgk/4qxvF+SRzyUkBduqWqLL6Q3rfIX6+PgxP7n3Felbk2ADk8xVyL8Ed7AonXgMVoi9kOXOX5IsSJQ+XH1SSdMEYHAVHimuVskZ6NpORo8nDEEoVcJkjmdMci6etrDCLP6jpx6pFsXohG7IPYdFp4EOZyoSmy4IvNXY8A18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=Dm7Q2PY4; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="Dm7Q2PY4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=96H//xyxuCFmaGZRsor+5jhX8NjKgpFWehEvfDnboFg=; b=Dm7Q2PY47NV8SgsuZPIkwi+3fU
	I9QYR1toeST46B08f12K42XE6C79/KyTi0GIy3oEnnkjBL0Msnh5JMIaMT3GSgMf80dWmqyGS4dgi
	1gwWjUz/crUjFV5EbxtllstFZr8NFS+Qcin3FghRgwvXYK09PLA5ZwO3pGezlcEuMfeZYUfCXdp4D
	X/3cc7CzSY2PRXPMrz7wi06aXOgas0ksE+jBh+KTdNXs7gH+PaF8pxuYPp7+fKtBY5BiMDgBIIV2b
	ryl/mKu1mnaFikoVkuO/H6MQClf3rPvwg2robZzuzAH5In+L3BivztzjBzRmrW1bSjMrGlEGvD5q6
	YyTFp/cQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <lars@metafoo.de>)
	id 1wk1lv-0001Q8-2B;
	Wed, 15 Jul 2026 17:43:43 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1wk1lu-000DNF-1w;
	Wed, 15 Jul 2026 17:43:43 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] iio: buffer: Fix potential use-after-free in anonymous buffer release
Date: Wed, 15 Jul 2026 08:42:43 -0700
Message-ID: <20260715154245.3814378-1-lars@metafoo.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28061/Wed Jul 15 08:25:10 2026)

An anonymous buffer handle holds a reference to the underlying IIO device.
The reference is dropped in the buffer handle's release function. If the
device has been removed, either through unbind or hot-unplug, the buffer
handle might hold the last reference.

The release function takes the mutex for the buffer using a guard, which
means the unlock happens after all the code in the function, including
`iio_device_put()`. If the anonymous buffer holds the last reference this
might free both the IIO device and the buffer, which contains the mutex,
leading to use-after-free when the mutex is unlocked.

Fix this by using a scoped guard just around the buffer dmabuf list access,
making sure the mutex is unlocked before releasing the IIO device.

Version 10 of the patch that introduced this issue used this exact scheme
of first unlocking and then dropping the reference [1]. During review it
was suggested to use a guard instead, and version 11 made that change [2].

[1] https://lore.kernel.org/linux-iio/20240605110845.86740-4-paul@crapouillou.net
[2] https://lore.kernel.org/linux-iio/20240618100302.72886-4-paul@crapouillou.net

Reported-by: codex:gpt-5.6
Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 531fc4ccc15de..04b3916f89e2d 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1619,12 +1619,16 @@ static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
 
 	wake_up(&buffer->pollq);
 
-	guard(mutex)(&buffer->dmabufs_mutex);
-
-	/* Close all attached DMABUFs */
-	list_for_each_entry_safe(priv, tmp, &buffer->dmabufs, entry) {
-		list_del_init(&priv->entry);
-		iio_buffer_dmabuf_put(priv->attach);
+	/*
+	 * The mutex must be unlocked before iio_device_put(), which might drop the
+	 * last reference and free the buffer.
+	 */
+	scoped_guard(mutex, &buffer->dmabufs_mutex) {
+		/* Close all attached DMABUFs */
+		list_for_each_entry_safe(priv, tmp, &buffer->dmabufs, entry) {
+			list_del_init(&priv->entry);
+			iio_buffer_dmabuf_put(priv->attach);
+		}
 	}
 
 	kfree(ib);
-- 
2.47.3

