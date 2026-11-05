Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849673;
	b=bc2YYnwdfj3uNIZi8h8owOUD9CnRm/lDgeMJmEFgtXddzFJDzvv9gorIt28VcgR8zAvu
	 9YBdUBRaPLfPB+79UgiZZeTyQnZSq4OP8hyzGWJRaTDevleaCmC6ei+o9DnRIbWhrvWgO
	 D9x3ZXbtxsZHRjgpYW9t289oVslfsbIBL1tdMvl6YgHAFHs1acjIj6uaujmXvKSqDDrBC
	 6w0/HJY6R7G/Z5OfDvhwfkr9Cg32N2Npp/TEX6gjmUWp061hyJL1rBkdwT715zT02CZD6
	 L5aS3tzhaC2twf+VkyXhlPJghxkqGj5S4mOhWWX7nw9tHjGqt9t9Ez5RQzudiI7npog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849673;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=SduXdqOazBa5GxKZ9IOIpheoAA30LJbtlvdLiKi6v3Q=;
	b=S7L3zU/xRkdprcd9SWoGAyKFC8ot4DJWyt/oZREhBxe0D3ZGvRiqS6n8bG2uHypcba5R
	 sK089Fyb8uWMAnz9zzICQCslVGD66FqLrHXO5HswDJqWVr+j8jxvitAPXSEf1lbPZZnhX
	 hoqbNvhmCqBkmcuIZQ+yebMcp4PwCEbb5r/FiHP2qNx35AF10eZ4dKLFS9hGhQeOehicc
	 hwbv/dZ512HXhee4+stIyYuabLK7NlPS9Bdqy2QHmxwGit4wF/JEYTTWsQFHlLmZowSZi
	 /4d4pJbMo6wmvZHNapTKxKj2jx9wpIWQegdIi+1QSHHygiZmo+vNBzSvj2fcBpbeVHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6C606A31B;
	Thu,  5 Nov 2026 03:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75D6C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXsrc3+etqwPxXAA--.15780S2;
	Thu, 05 Nov 2026 11:34:15 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>,
	Joshua Crofts <crofts@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] iio: adc: ad4134: Fix duplicate data_read mux state request
Date: Thu,  5 Nov 2026 11:31:20 +0800
Message-Id: <20261105033120.387616-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXsrc3+etqwPxXAA--.15780S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5GFyDuw17tr4rGFy3Jwb_yoW8Jw1UpF
	4DJFsxuFyxCFs7CrnFya4Uua95W3WxW3429FyUGay2vrs8JFy5Aa4fJa4xta4DGFW5Kasr
	JF42vrWUC3W2qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU11rW7UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

devm_mux_state_get() is called twice in a row. The second call's result
is stored directly into st->mux_st[AD4134_DOUT0_INPUT] without error
checking, and then immediately overwritten by the first call's result.

Remove the duplicate call and check the return value before saving the
state.

Fixes: f12ecb3e147b ("iio: adc: ad4134: Support SPI 4-wire mode")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Joshua Crofts <crofts@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v2:
- Update commit message as suggested by Andy Shevchenko.
- Add Reviewed-by tags from Andy Shevchenko and Joshua Crofts.
---
 drivers/iio/adc/ad4134.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index bc6407ae25e0..35fe387b9ac8 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -1112,7 +1112,6 @@ static int ad4134_probe(struct spi_device *spi)
 		st->mux_st[AD4134_SDO_INPUT] = mux_st;
 
 		mux_st = devm_mux_state_get(dev, "data_read");
-		st->mux_st[AD4134_DOUT0_INPUT] = devm_mux_state_get(dev, "data_read");
 		if (IS_ERR(mux_st))
 			return dev_err_probe(dev, PTR_ERR(mux_st),
 					     "failed to get data_read mux-state\n");
-- 
2.25.1

