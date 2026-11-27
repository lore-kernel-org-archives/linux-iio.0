Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749050;
	b=SvJCUVoJjHcwqnsEpLB7c5Noirsd+Xw+5cqS7Pj81enAohKbhNvUEsdZOL6/BtixLx7d
	 QTz3+JS1R5SOF1pZRGCwQeEWFPeFogVBfmBWiUPZjpXExXc+5xSlCdLx4sZN3UE6hQRDb
	 tE09E9k2K2hRaTkFSs5BhGSgzVcVXBYKi2oLZE3WlAuvhJ9VOchl5xhG8xIS7qdL6CyEj
	 WnPufX1N3GZaiOrW7z+Vlpi73hNm03swnAAt3JKNEXGv2CKqI9J43nK83UhFWksq7f1DM
	 Hpfibpa4PbiyvAfkX2920KssjLHFwUMXcS5OtbufxDOqDVpodDW19nOE8ZR+NhnXi8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749050;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=/ktUTtzQmYBrtZo1pYnB1CT3xfoL1+9t2GulvHSsGek=;
	b=xqleLZbz0cNaDKBR44ScITCROaxWx6WWbmvIh82nXtL9RIAWpYecySVLmhXc9sdw+ncR
	 eQ55xOWPvoq9mxEkrnm2zKSQ7ZlvZDEeytPfir6pPmPdXztzTcQJTHDIweE7GirnEclfZ
	 V+CsB7tLIvj/MKydhoWW/xqDiG7/nrZxpQ6wGW9fFOd+u8xgwoPWznA+QULXHv6WtvosY
	 y6Pmja4mw+Z96TWWTMhH64sKYFwRFhUeumrrhjglR86lVgmb2GMrW3csaD4Hj466S5SEN
	 e0Jt/mjzcQApi4K+922Kw9FX90HiuCfiKDBXqQCWV7E7CjshTeUDkf2L+bvlQE3CNZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxSG3dCv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59B606A32F;
	Fri, 27 Nov 2026 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxSG3dCv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795749050;
	b=uGuw0o5KQanNYrltlKScOxm0zJSYvMeUJWra0Zb05Q0GbxIIA1Ob44ArfT4WnBN6sa6C
	 IHqSbhoPZummrFohUVweToc96bnLDDKbGyPMHMMmEradgh56urpSnDWXAppXcaExvNIA3
	 xi/VR9uJLRB+Ru4iLa7Pr4LNrcvWWtuIGQVFmiKFX8CPLwEbto/wZ+4apSAJfuweef711
	 8U3vqrDrDBQfx8I2vs3Eof/jVJ/zeYamn9OKkwSVvskAoyh/EbZMyTx5jxzrYY/uT6sIk
	 z9dDCdl6cCIdZfHDAncW7P7z9J5w666Yuba+YIAsMWzY+8Nww913YoplSAhJZoeJ1/Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795749050;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=/ktUTtzQmYBrtZo1pYnB1CT3xfoL1+9t2GulvHSsGek=;
	b=jmoHjNfvP1zhm4JuaXf2VEJF8kYXzH6eS6xkYzo1ahf1njPc6xf5YUBEZ8OOlepnksvS
	 A/OGbR53lCTQGNFNhX0d7DxMkjvF/qCHuFKo6Lx4nbNYsxeEqRKyz59+hSsWhugKkY+gm
	 YmEAHchASOHxSHJ+aQfMNlLqEaEwPnaGt6P4aoFMAUu83gHsq3mh83N4hrI0cf4w8/MUP
	 JhyN4+cl1qbvwntpkTbncArNVMOrksBdt94aoICxIKy6DuZO6KCwAMLBrh7G0vZtDM/5G
	 ZhpSpJfkxkR6k/xqFNcVnYJE720OxBbaZWIM0WVlnf3UCSvP7nSbzGVctlJiJW3lhKg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 22D7A1F00A16;
	Fri, 27 Nov 2026 03:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795749050;
	bh=/ktUTtzQmYBrtZo1pYnB1CT3xfoL1+9t2GulvHSsGek=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=JxSG3dCvSg+wrB1AZTKIdwufOJYGV7mbf3FLu535nwy7klkXlpKoL4L5YWrGwSpgJ
	 ZO7FP/q7kHrWRRMmsmPmsUuFVgVZMSLijhHKFl/k+CBFSS+L0s4KSxr5fh+gvuBT1t
	 n23CP8Z30hpMUBUxmHQp/6EYH/KxS8845e8rHQacQvVY0xj8gixfTlxGqzW4xQBiDc
	 iEMd4R1Bl+7se+QodDGDANt61w6+VDkBfJOrYNAi9EiT/WwXXysXmBEW9x3UQSeZLA
	 /hpJJ1cMA+817AiU0EGJz6qGwfPcrV/HwMKnbDfTYe1K9hgJFCwvVe587bFSg0UFQy
	 3t5Xie9e4Ik9g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 968EA4B514;
	Fri, 27 Nov 2026 03:10:39 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Arnav Kapoor <kapoorarnav43@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: inkern: guard fwnode_xlate with info_exist_lock
Date: Fri, 27 Nov 2026 03:10:38 +0000
Message-Id: <20261127031038.12685-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795749038; l=3242;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=3eR7QjvwrqKPzzmBewRCZmPt+qJp/3aj6a2z0YLz8uc=;
 b=1HWWq8KlVlZ1BykCJj/4xM1SJQYVdLIt4MNmvvuSMq6O9dSdgGZM1KFsDfsPGEPFNWmwfMi3L
 7lylh1tHT4uC+kXXuUEdYYb2zWDUKX3eZ7ZdclH91OFp3nlRf0jldzb
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
Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
Changes in v3:
- Place `struct iio_dev_opaque *iio_dev_opaque;` in reverse xmas tree
  order (Andy Shevchenko).
- Move `iio_dev_opaque = to_iio_dev_opaque(indio_dev);` right after
  `channel->indio_dev = indio_dev;` immediately before scoped_guard()
  (Andy Shevchenko).
- Carry Reviewed-by from Arnav Kapoor.

Changes in v2:
- Return -EPROBE_DEFER instead of -ENODEV when indio_dev->info is NULL
  so callers do not treat it as the "no channel on this node, keep
  looking" sentinel and named lookups do not overwrite it to -EINVAL
  (Arnav Kapoor).
- Drop the unrelated indio_dev->num_channels bounds check from this
  locking fix (Arnav Kapoor).
- Move the AI coding assistant note below the --- separator.

Link: https://lore.kernel.org/r/20261126060615.63790-1-iasnezhkov@gmail.com
Found and drafted with an AI coding assistant.

 drivers/iio/inkern.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1f22275..92b6679 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -145,6 +145,7 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
 				    struct fwnode_handle *fwnode, int index)
 {
+	struct iio_dev_opaque *iio_dev_opaque;
 	struct fwnode_reference_args iiospec;
 	struct device *idev;
 	struct iio_dev *indio_dev;
 	int err;
@@ -162,10 +163,15 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
 	}
 
 	indio_dev = dev_to_iio_dev(idev);
 	channel->indio_dev = indio_dev;
-	if (indio_dev->info->fwnode_xlate)
-		index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
-	else
-		index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
+	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
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


