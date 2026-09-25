Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE147F2ED;
	Fri, 25 Sep 2026 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345429; cv=none; b=CTOOQkJ44x6BDZLcgOyZ/cF5aA+Nh8SzJKe0xebPcfMSuwYCO0+P3nqU6LxR52IvmCA+fv8IhVsbdGl/jb/y6l2bnYuytllo79QRo8zRRBNitsYpLSXvwD67qLerbpP0scudmk0Mb38anLN5i/G7jtelNKJIjYOI/SK+GjxI54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345429; c=relaxed/simple;
	bh=R6OsoQAgACwDXHCXZ1qOWZpkly8HwuUopgWg55ZCMAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ht1SS6Pd3/Tx8miWKk1tqGrnxx74Nbhp4kzOtav2NJ7Rye3ZRGSpwEvStKWrV8osRVdDqRxArKxlVHGuRXALgwNWrdAZTMzbyIbSiou5U3hrKDfkblLXocbZMo/ADxMmYOUJbY3GGwG+qzUicFz/VsKN8BctcEhhSy+ORFWOzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QrtfAlSD; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QrtfAlSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Oj
	sg9coUeg20a1JfumNQ4V+6/v/2+gOQyztI8wP6O7c=; b=QrtfAlSD0H5Xxg1/sl
	jYlRZeEqGkK9Z6RPN4L/tgA3x/aIZ0NKlwMu/UOeM69XmNx+dhy104m5L+zHX5nk
	N/cKAaldB17R/Yqg5onuxGDH8MxKDqRCHTXgnV/X+bgEutXzivzOHFYdOnzhp0hu
	kj2tvwcJHGIvrCQWUvqE1Fefg=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X0i1gLZqfBMiAw--.479S2;
	Fri, 25 Sep 2026 22:09:58 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] iio: gyro: bmg160: reject duplicate event disable
Date: Fri, 25 Sep 2026 22:09:54 +0800
Message-Id: <20260925140956.2254877-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X0i1gLZqfBMiAw--.479S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr18WF43Ar13KF4fKFyfWFg_yoWkWwbE9w
	18Z397WrZxZr17J3W5Xr4fXrykta4DuF9Yga1xtrsxA3srJF93GwsYqrZrCanrXrW7ta4U
	tr47X3WFq3Z3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtUDGUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhaVz2q2gLbkjAAA3A

The IIO core does not filter duplicate writes to the event enable
attribute. bmg160_write_event_config() already ignores repeated enable
requests, but a repeated disable request still calls
bmg160_set_power_state(data, false), dropping a runtime PM reference
that was not acquired for this request. This can underflow the runtime
PM usage count and trigger a "Runtime PM usage count underflow" warning.

Return early when the requested state already matches ev_enable_state.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/gyro/bmg160_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index d611341a0e2a..0b5621455216 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -761,7 +761,7 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 	struct bmg160_data *data = iio_priv(indio_dev);
 	int ret;
 
-	if (state && data->ev_enable_state)
+	if (state == data->ev_enable_state)
 		return 0;
 
 	mutex_lock(&data->mutex);
-- 
2.34.1

