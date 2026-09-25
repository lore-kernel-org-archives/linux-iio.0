Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493334A0EF6;
	Fri, 25 Sep 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345458; cv=none; b=ZW1gzOpUYvilqx9UtYigWybJo7ivqsm0Xiuib96eqMA3oxeHwHCSPRRi0FSaD/Cme4BNmlwPHOpvql0/AxLM5J6NfbZTEUDxvxFeMD2RRDeHk/eNdjrhOhszdo/LdEfF5zbK/QKyFq+H3LwYECJIkEgqqnDr8qFdNJ5+QMc7srw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345458; c=relaxed/simple;
	bh=mPOb5G1Qz/RmNykC0s7p7NQ24Lun83T2cohQt2hDKvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eBo1hFxvGaYERo55+OzC3ete1tNA/R+/xjoOsZlaeAHiAohWzrhqyWvMh/qsH7SGue/QfARclZZ96PoNEC3gAnPx4IaT0ilF8P+nBUuxV3Ax4oYmDEPi5QY2hKhjzl/n3rPz/NTu0301E6RzXQvA0y0vhYb3OXFUHxKCLOmiy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YDKHp4+A; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YDKHp4+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eP
	pXmbo4ejp8460fe8NLuub/ALvk6mEPsOLd+XEHehc=; b=YDKHp4+AwrLSgskTIN
	qJLkong60tuAgtjwTEKKi9xnbLNYMYoj2Mx0KCWxLPkSlRmcCEvEOCuYC35fEVJY
	tj3iNjRaPvwnLI0gSQKLDLXGzYF+xF7dsIKB4wBH3P/MFBApYYbf7WBsWM0eeF1r
	f1LXQd3ESj5d0K+EzE9GwK950=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnL5zAgLZqpBIGAw--.274S2;
	Fri, 25 Sep 2026 22:10:09 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Siratul Islam <email@sirat.me>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] iio: imu: kmx61: reject duplicate event disable
Date: Fri, 25 Sep 2026 22:10:05 +0800
Message-Id: <20260925141006.2255067-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL5zAgLZqpBIGAw--.274S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr47urWrWw1rXw4kXF48Xrb_yoWkGwb_uw
	4rZr97XF4DAr4kJ3W5Zr1fXFy8ta4j9F1vvF1IvFsaka47XFs3Gws5XrZ8AwsrWrWUtayk
	KrsrZr1FvwsxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMJ5rUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQGY0mq2gMHPggAA3W

The IIO core does not filter duplicate writes to the event enable
attribute. kmx61_write_event_config() already ignores repeated enable
requests, but a repeated disable request still calls
kmx61_set_power_state(data, false, KMX61_ACC), dropping a runtime PM
reference that was not acquired for this request. This can underflow the
runtime PM usage count and trigger a "Runtime PM usage count underflow"
warning.

Return early when the requested state already matches ev_enable_state.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/imu/kmx61.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index c288437d53ea..a4962b88ef58 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -939,7 +939,7 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int ret = 0;
 
-	if (state && data->ev_enable_state)
+	if (state == data->ev_enable_state)
 		return 0;
 
 	guard(mutex)(&data->lock);
-- 
2.34.1

