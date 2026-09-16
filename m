Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89664C653D;
	Wed, 16 Sep 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574943; cv=none; b=V3fePLqvnzOUh0VP76pSRif/N8B4ZyprNMktHNZK1A/mwLqvZ5r58ej7f5OxlcAM/+rwymCWx+TZ0s+5aXKUzAHVDVGIg29HX5uAZNWa92Ds7qOqCUXyUjx9Sxol8H63BO+JKTAt1uDLgVVssQekIEuoF2Ae8kWoZbtA07pYbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574943; c=relaxed/simple;
	bh=ywb+/pQ0ZJbVB9JkYMfhrFHmCOWkfsPrlGj5RHvnNNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aLp480fGznoKWrxhZTUjaQccOhqowq+MGLLXk3n3BNmV6JAVffc7WFqy+hxR+RFF0uYDrkufPtRIFCRMHW3HZ5IhzokKSpF93YljG3VGVQkDl0QuaJCUMhG5EZkUX2cpZT4Sj0WH2aGcDQJWWTznpdTvuICuFA98Z1KKoMna7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACX_zkTv6pqUWRtCA--.22015S2;
	Thu, 17 Sep 2026 00:08:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	petre.rodan@subdimension.ro,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] iio: accel: bma220: Fix trigger reference leak in bma220_common_probe()
Date: Wed, 16 Sep 2026 16:08:23 +0000
Message-Id: <20260916160823.2082283-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX_zkTv6pqUWRtCA--.22015S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1fWrWktF4ftr1UCrykKrg_yoW8XF1kpw
	s7CayYyrWxXrn7AF4UZr18uryxtF1ft3yfGFW7u3W29398Zw1Yy34Y9ayI9w4xCFW8ZayU
	XFn5Grn5uFW8WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMMA2qqpVhABwABsw

indio_dev->trig holds an extra reference taken by iio_trigger_get(). It is
only dropped by iio_dev_release() when the device has a triggered mode set,
and indio_dev->modes is still INDIO_DIRECT_MODE until
devm_iio_triggered_buffer_setup() runs. Both early error paths return
before that point, so the reference is leaked.

Release the trigger reference on the IRQ request and the deinit action
failure paths.

Fixes: b7e17ca10793 ("iio: accel: bma220: add interrupt trigger")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/accel/bma220_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index f32d875b994e..4820d99e214a 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -544,14 +544,19 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						&bma220_irq_handler, IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
-		if (ret)
+		if (ret) {
+			iio_trigger_put(indio_dev->trig);
 			return dev_err_probe(dev, ret,
 					     "request irq %d failed\n", irq);
+		}
 	}
 
 	ret = devm_add_action_or_reset(dev, bma220_deinit, data);
-	if (ret)
+	if (ret) {
+		if (indio_dev->trig)
+			iio_trigger_put(indio_dev->trig);
 		return ret;
+	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      bma220_trigger_handler, NULL);
-- 
2.34.1

