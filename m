Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673180;
	b=WJE5z+eZ8FdwfsM+rS0+VsXpASdM9n0u3J1tj7M5SE6a9J4FLduC1L/muDKYIBuJv86k
	 HR3FBS789nPCxD1FqT7LGYoaI9nu8UkiXpgkpvjCYANP6GBhTYVFBmSjcGUvTMg14zJx7
	 ipBvsmBzY0kM0iuDZBv/pIdC0B7NeWRlnO6Kj0Ebt6suNdinELFfDH9yoM5XLa8c9e4Xr
	 y5vXT3gLbwe7AhD7LQ+5mSC69eGLCC2xFKqOSy6phOKSPl9vl0wcAPWHlwuUBdsJ/fObp
	 GirkbzJXD+qo9ESJKOPvfnebol5bIqwoAE+AS7gWzoXnynY7uhIZ1opCT1+PvzwkBVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673180;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=s+7In1a1Fz/gHDMpzOQvOTFTNFwXf4skP7F53s28sRY=;
	b=h4RCzUKTcvBEb8yEBPz3Ccb5A8/0VPs9e+wwTamVM5mAsuXRc+pJrv1ag3rxhR883qBQ
	 lgA0rYCdU8qOTOwySzNaoc9aYuKhCcH5Fref31gfpXZCbbmiB3zVTY+RqLFQflE26SEsJ
	 3wQqfOXQiKvUkVxfnH77fJSKIl9xDK0CBXaxsJ0F+jJUOhWEf912TsY++fhf7hgb+9hFM
	 LO08AcGgfvfdksbrMMaVHrblS00CKTpdb2v0nmEXqrBmqTGpGz9deyF5153PDRdipNTWu
	 csUNrJOKXpMcln5jkehby/0pEWl02sB7enEPf0gdpPu7foCtOMQzVAunigTZmTx6fqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMrMxL62;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470A606A31C;
	Thu, 26 Nov 2026 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMrMxL62
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795673180;
	b=Luj/DxIAkMMJZqFW4u9AT+nRUvkzrpg9GFjJczgjJBsTYzttqj0olvPQkdTX72tD7B0J
	 K77fqyIDbC4XcLDqagW9ZP2rAzXNzXIJNXipEFnXM3YbdvsUYcVixfHAzPexojWpav2xZ
	 hVWgoD4A9zndEZZFGubReT2xJ4ncYm7damQBfVCpZ0Qv/SvdMVxFXeMUHhDZKxvZTRI4u
	 QTjbFvkhl3qRNErP1SmqbC2Qp75JbIfXmDwDRWF6mnuLx0GQpXSdLUaJGYynkn5jIeW+s
	 jvVfrRFmIyQVJR9KOYtnbj559p7G6D68YebEVb0cRYen8Nu6a0zlrkz6Gzw/nbx7Kzw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795673180;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=s+7In1a1Fz/gHDMpzOQvOTFTNFwXf4skP7F53s28sRY=;
	b=z2HyUfwQwPXN9ki9N3D3uTu8CmzdpN3N05JO+OHSOpYCCIiS1E77TJrNVjdU4gc8Kgs2
	 pDYnCh4teD+43KiQvIivAB9sde0lqeY16qFrVTCmLtIyG1cUku163VYOXcBjKra0tqKjo
	 dhrH7F421Wd/VJ6ytEha0HV+ZwNyCjI6lvD76Vs7xtEH4bttufNXf3UIKEKbwcM2vmhVP
	 p0xBU0HXbR1u70BdJTZRHqzQ+ZexvdPUeFxo8wzFONl09wBy7xIuJJQ62TiCPsNl2absu
	 ZHbdHHs6aY2rplFLDMWjmOUUZs/O6ffegY5RXCS2g1qDb38uhc/cerU5Xpd9UNLn1cQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3CDA01F000C0;
	Thu, 26 Nov 2026 06:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795673180;
	bh=s+7In1a1Fz/gHDMpzOQvOTFTNFwXf4skP7F53s28sRY=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=IMrMxL62WDcuNsCGulT+8GLxaM4m91YWGz3n3VqnqMZnxOzNEm0uSh5uP/64/e9OM
	 19w2pef/aT1XHXcGnZoBFyKGuqbCz0Fx8quLT1zxDyoSDCPIh1SGaYRMxmKpG6Fjxl
	 buRwuvKLOWDfv0GKjbEkjqTElBh0B/4ZDNUDfo+oiHxu7LuhznDkBYcgkblYoPsCiY
	 DIsr9SjXv5KiXaIvkCMukw5wnbUnW489HtBxxObNcKoHKhKPaj6ilUgGbfSiHTwd8o
	 hRjc3E83s1LRtzCkowt+AkRCl16sfs+aT46a7a9i/YMwsK5q6NcnfFViHuTsZ4DPIX
	 VBd1E2rJqNwhg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E7304D24B;
	Thu, 26 Nov 2026 06:06:16 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: inkern: guard fwnode_xlate with info_exist_lock
Date: Thu, 26 Nov 2026 06:06:15 +0000
Message-Id: <20261126060615.63790-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673175; l=2870;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=LZxT2J+30sK/RMg/s6ys55XZRZuLrJ3zmuWig2KBQD8=;
 b=zBrKnF6eF+8xtdTuXbda98riCLhYhDmBuYAII0irbpbLvslAgG9uvIj7McgP202pcRhp7NZeZ
 OT8YDaXEpIjCIY4qVZmTUj1gzuqVB1lgpJcxAWMIypyTi4Dw5qZehTF
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
matching the rest of inkern.c, and return -EPROBE_DEFER if
indio_dev->info is NULL. Since iio_device_unregister() calls
cdev_device_del() before clearing indio_dev->info, seeing a NULL info
pointer corresponds to racing right before device removal from
iio_bus_type, where !idev already returns -EPROBE_DEFER. Using
-EPROBE_DEFER also avoids colliding with the -ENODEV sentinel used by
callers to continue parent or map-list lookups and avoids the named
lookup -EINVAL fallback in __fwnode_iio_channel_get_by_name().

Fixes: acd8256723f2 ("iio: inkern: Add of_xlate function to struct iio_info")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
Changes in v2:
- Return -EPROBE_DEFER instead of -ENODEV when indio_dev->info is NULL
  so callers do not treat it as the "no channel on this node, keep
  looking" sentinel and named lookups do not overwrite it to -EINVAL
  (Arnav Kapoor).
- Drop the unrelated indio_dev->num_channels bounds check from this
  locking fix (Arnav Kapoor).
- Move the AI coding assistant note below the --- separator.

Link: https://lore.kernel.org/r/20261125234827.94791-1-iasnezhkov@gmail.com
Found and drafted with an AI coding assistant.

 drivers/iio/inkern.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1f22275..5d3c6ab 100644
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
@@ -162,10 +163,15 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
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
+			index = -EPROBE_DEFER;
+		else if (indio_dev->info->fwnode_xlate)
+			index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
+		else
+			index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
+	}
 	fwnode_handle_put(iiospec.fwnode);
 	if (index < 0)
 		goto err_put;
-- 
2.54.0 (Apple Git-157)


