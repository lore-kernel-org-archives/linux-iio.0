Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D34C226E;
	Wed, 16 Sep 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576406; cv=none; b=KblgPDihG2NJharf3ima1BlvfZRCamH88DZtzF8sZwjnrUhxab1/UKg1OSmAUSc7mmNoaXDh9pwSHvbhEslBM8RTAMeRSxnyaP3jt68tYzDYr+b5sb2xEQ7FTY5f7JYY8s5TvoYFOwZbvTemf2zBsigcO7q/RiJLWT6URx1VLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576406; c=relaxed/simple;
	bh=TzxubCveY/iPV2Bqueph1beiyzv4gLj/Xc6tc0gYS5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crWTCtP1m3/9bY7TwB1lnI0Q61EZHT4SDpfcbFOeAGLYk0WPRjn3ikrDV0a0LXrfEfnjEu7fvlK9kEL/0yInaQULv6Qvl3g++6LSTPjhL3gjEco4NfeBOdftf9TJ6R8M9gXDtyYLl3+++MWryV5iCw/013n8GpXiuMjnisNvMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHsTvNxKpqhrhtCA--.21634S2;
	Thu, 17 Sep 2026 00:33:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jianping.Shen@de.bosch.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] iio: imu: smi330: Fix trigger reference leak in smi330_core_probe()
Date: Wed, 16 Sep 2026 16:32:50 +0000
Message-Id: <20260916163250.2083963-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHsTvNxKpqhrhtCA--.21634S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47GryDArWDAFyUXr1rCrg_yoW8XFW3pF
	4kKF4rKFy7Wr4kXrs8ZrnrCryUta4Iqayruws7Z3Z2g398Aw18Kr109FWaywn7AFW0g3y7
	trWrJryrCFZ2vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	ZNVPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIMA2qqpO9NAAAAsH

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
devm_iio_triggered_buffer_setup() fails before setting that mode, the
reference acquired for indio_dev->trig leaks. Move the
iio_trigger_get() after the buffer setup succeeds.

Fixes: 6f3d8de8886d ("iio: imu: smi330: Add driver")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/imu/smi330/smi330_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
index 7ec5ae7f521a..6bd735c6b61a 100644
--- a/drivers/iio/imu/smi330/smi330_core.c
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -886,9 +886,6 @@ int smi330_core_probe(struct device *dev, struct regmap *regmap)
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "IIO register trigger failed\n");
-
-		/* Set default operation mode to data ready. */
-		indio_dev->trig = iio_trigger_get(data->trig);
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
@@ -897,6 +894,11 @@ int smi330_core_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return dev_err_probe(dev, ret, "IIO buffer setup failed\n");
 
+	if (data->trig) {
+		/* Set default operation mode to data ready. */
+		indio_dev->trig = iio_trigger_get(data->trig);
+	}
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Register IIO device failed\n");
-- 
2.34.1

