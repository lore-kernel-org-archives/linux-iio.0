Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDE4854F4;
	Fri, 25 Sep 2026 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345429; cv=none; b=VuyuAZHB93sLy/zsfDZHF3rF2owd2B54GhpK5dasdOpO+9Ot6zBCB0fwhSv20nI8MzMHTj9Rixafpk6nwSlinYiCy0yXFlGTD99DJ6I1+8+AEPDxlGTDJwbGqo1dNUhMgpUwjjvJ1pz0OzCKiGNi15JU55duXnDs2uvBrqpVzIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345429; c=relaxed/simple;
	bh=IAek5QNNG48VEIRnYPgZiQ9h5BIXUIkQlgLx1MXYb9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGYmnu5MxZr2/wksPQx2b9SADhKJwk3mZtbgE4l25q2xjayI2S1dvHjir00rl+Y3K3U49V5h9t9BLBk77+S2rbjUfNM4R7Ns+HiZFJuwYbRLwmRnlIKzADI83tXj6fR1A5O1pYgwybfk3jU0G5leh3O8+e/EM+gHwLjSeV04ffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a3Wzkj7N; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a3Wzkj7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KX
	uDrmnU1MCQSKZ5fs/tsSrPstiX4bm0nvq6uTSPhu0=; b=a3Wzkj7NC7vd2oOmhE
	9wd9GseZqlm+SpTBi2jZ97Qk8qwE3igJj62uSRX99fEi2t7kil3qTq4S76D8Mk1c
	PrRdDMQgFPCTCdmLNi6d7Qly1t+QM+SzbG4H4bF5GxusLsr299IEuAUeKgNLDtbp
	xZo1EYUJ5RtMXO9VhegPQ4Af4=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBHeMKqgLZq8bfxBA--.29463S2;
	Fri, 25 Sep 2026 22:09:48 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] iio: accel: kxcjk-1013: reject duplicate event disable
Date: Fri, 25 Sep 2026 22:09:43 +0800
Message-Id: <20260925140945.2254656-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBHeMKqgLZq8bfxBA--.29463S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1DKF4ftry7uF13GF15urg_yoWkCrg_uw
	18Zr9rWF9xCr48Ww45urs3Xry8Ka4kXFn09Fs2yr4akrW7Jas3Kw4kArZ8AwsrWw47t3Wk
	JF48Xw1fXF13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM7KsUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AyTzWq2gKxYwQAA3L

The IIO core does not filter duplicate writes to the event enable
attribute. kxcjk1013_write_event_config() already ignores repeated
enable requests, but a repeated disable request still calls
kxcjk1013_set_power_state(data, false), dropping a runtime PM reference
that was not acquired for this request. This can underflow the runtime
PM usage count and trigger a "Runtime PM usage count underflow" warning.

Return early when the requested state already matches ev_enable_state.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/accel/kxcjk-1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 166fb786425f..8994c9e8e048 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1030,7 +1030,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	int ret;
 
-	if (state && data->ev_enable_state)
+	if (state == data->ev_enable_state)
 		return 0;
 
 	mutex_lock(&data->mutex);
-- 
2.34.1

