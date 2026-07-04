Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383337AA9A;
	Sat,  4 Jul 2026 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783149328; cv=none; b=Ey3KnFRMJBlcXgk9nFcWH5+9IhA3Ox8nTK7dzGpdaK7xgO2+D77/NmTrTxdERV5t22ZW3JztHrm0hj9LuryC+IdDJfh51bMNDilZu4JDOBloJZSITy76F0KGk0ojHqNRkWbgYde5eSMFwq74qQxi0NuAFElHuB6x7sWTYvrWjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783149328; c=relaxed/simple;
	bh=/ooJoYriGlYv0EazYg6SXCTOu8s/UoBcbdqlqWWuB8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edZpG9n8LVxvV2jc7koEyiFBvtCLLapGNae1NzzQtnFer07hDEQ6vfuPZBed0Acx33Hc7STZElEy4AGGwDE6OfNPyh7mQl9yothOs2E1Rtm50Yaso3mMLddUGbSz2Fl0nnveI4CBDMfhWP+C783YcCIl+EKENycvAuf2XDLaSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowAAHn8cBs0hqe6CgBA--.11532S2;
	Sat, 04 Jul 2026 15:15:13 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] iio: light: rpr0521: Propagate regcache_sync() errors
Date: Sat,  4 Jul 2026 15:15:11 +0800
Message-ID: <20260704071511.23184-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHn8cBs0hqe6CgBA--.11532S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW3Kr1UCFWUAF4kAF43Jrb_yoWDurg_ua
	nrCrZrWr4Ykr4kGw17Jr98ZrWkWFyUXF1fWF9Yqa13tasrAr97JryUArs5ArnxGw10krW7
	Ww4qvryxArna9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ2fUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

rpr0521_runtime_suspend() powers the device down and marks the regmap
cache dirty. rpr0521_runtime_resume() syncs the cache before restoring
enabled ALS/PXS channels, but currently ignores a regcache_sync()
failure and can still return success.

Return the regcache_sync() error so resume does not hide a failed
register restore.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iio/light/rpr0521.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index f961973892f2..07f300bfe8e7 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -1071,7 +1071,9 @@ static int rpr0521_runtime_resume(struct device *dev)
 	struct rpr0521_data *data = iio_priv(indio_dev);
 	int ret;
 
-	regcache_sync(data->regmap);
+	ret = regcache_sync(data->regmap);
+	if (ret < 0)
+		return ret;
 	if (data->als_ps_need_en) {
 		ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
 		if (ret < 0)
-- 
2.43.0

