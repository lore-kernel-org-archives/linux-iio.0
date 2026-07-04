Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38C1DDC35;
	Sat,  4 Jul 2026 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783149270; cv=none; b=kFwLGWPluP2Yp+uk3Snb43xvONxsuNfw65/jbV5sAMOzdP3AdvMc+hwfkEXoudSy5SIjLbxtDkocJt318dGMmF77c77DSoFs/HlD3dtSyoeiz2hjuA3TMeOMTLXXoQCxoeIYIhSPvdt1BResgKZy00/cq+Dq2pJgyD/btYJsxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783149270; c=relaxed/simple;
	bh=34Ii7CN4383TTZ8rUWdECd4BexsTOWSzpeItLBRIcE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxpIc9P8uo5px7wv4sQkK5LT25oaJS5gz5qrc8rZnPpP5u4aTgui6CUv9ywwEO5fEbviuvr2KuKv0s65fqVFFSFgn6wjG0Mb5Zvcev/XP4p1fIMovneA3v1TQkj0yo7pDymZ0aeTSRIeoJJsNNTpMZGRG7qJYdcgJSx3gLqBtu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowAD3k8zEskhqfpugBA--.11592S2;
	Sat, 04 Jul 2026 15:14:12 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] iio: light: vcnl4035: Propagate regcache_sync() errors
Date: Sat,  4 Jul 2026 15:14:10 +0800
Message-ID: <20260704071410.18757-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3k8zEskhqfpugBA--.11592S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW8Cr45Xrykuw1kCw1DAwb_yoWDZFb_Ww
	17Cr9rWa1Fkr4ku347A3WrZrZaqFZrWF1SgFn0ya1fGr9agr93Jry3JrZxZ3s5Xr10kw4U
	Ww4qvrySvwn3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

vcnl4035_runtime_suspend() marks the regmap cache dirty before runtime
suspend. vcnl4035_runtime_resume() then syncs the cache before re-
enabling ALS, but currently ignores a regcache_sync() failure and can
still report resume success.

Return the regcache_sync() error so the PM core sees the failed register
restore.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iio/light/vcnl4035.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index bf3a49b4351d..3ca7ccdb7f15 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -647,7 +647,9 @@ static int vcnl4035_runtime_resume(struct device *dev)
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	int ret;
 
-	regcache_sync(data->regmap);
+	ret = regcache_sync(data->regmap);
+	if (ret < 0)
+		return ret;
 	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
 	if (ret < 0)
 		return ret;
-- 
2.43.0

