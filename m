Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B524B0E41;
	Wed, 16 Sep 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577028; cv=none; b=Z0RIwAjWHt8LYx2J9lhjSCqxE0M8B7L/oLbmEkl2TqjEt7N4fN3LF02RC56XN2yHcWju22neJnlDpX2Zfm08mUuN+Hxj63/YOjp4RoPcpFVy3VyEhX/cLHx4O6xxIEelgyd8aLmQ7p2Q5yU4/q4cNyyC/brrRjd1LM20Qcy31O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577028; c=relaxed/simple;
	bh=Z7qN8dRswdipfy2gTYGsfBgqM4NaKbSv1HAlS9AVRh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p3+xxrxtqz+Qx6TREuEcMqBepBdHJPVaj1W40SHuxZHF2ETawtYM+8tT2cTlzWmARdQSLFYC9fLCOrMd4+sA0G9wVa0NmBe1Vt4AP1br/XIXkJwTECCFJ2tHGDnV+amsm4geulk6zEDpiJ8eG//MsIBw3EL7NdGEFMMNs9Z1HRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXwz0rx6pq7NxtCA--.22663S2;
	Thu, 17 Sep 2026 00:43:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	email@sirat.me,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] iio: proximity: vl53l1x: Fix trigger reference leak in vl53l1x_probe()
Date: Wed, 16 Sep 2026 16:42:55 +0000
Message-Id: <20260916164255.2084644-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXwz0rx6pq7NxtCA--.22663S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKF1UtrW5try7Zw48AF43Jrb_yoW8JF1kpF
	s2k3y2ya4UXry8JF4DZFn8uryFvFZ3trZ5ur4ruasru3y5Z3Wj9F1Yq3yYgF1DuFWxur4U
	XrZ7ta1rCay0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEMA2qqok9ZuwAAsH

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
vl53l1x_configure_irq() or of triggered buffer setup returns before
that mode is set and leaks the reference acquired for
indio_dev->trig. Move the iio_trigger_get() after those setup steps
succeed.

Fixes: 128e5ebec856 ("iio: proximity: add driver for ST VL53L1X ToF sensor")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/proximity/vl53l1x-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
index 4d9cb3983dba..f1b8ff7fac09 100644
--- a/drivers/iio/proximity/vl53l1x-i2c.c
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -713,8 +713,6 @@ static int vl53l1x_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		indio_dev->trig = iio_trigger_get(trig);
-
 		ret = vl53l1x_configure_irq(dev, client->irq, indio_dev);
 		if (ret)
 			return ret;
@@ -724,6 +722,8 @@ static int vl53l1x_probe(struct i2c_client *client)
 						      NULL);
 		if (ret)
 			return ret;
+
+		indio_dev->trig = iio_trigger_get(trig);
 	}
 
 	return devm_iio_device_register(dev, indio_dev);
-- 
2.34.1

