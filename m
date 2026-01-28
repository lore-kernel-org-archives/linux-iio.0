Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEE330644;
	Wed, 28 Jan 2026 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574457; cv=none; b=J6MYt6KJjBOaYvAsxhBis748+II3RRUjiOQXctjW38by/N3t/2VUIqVHYjcQeS47dBEcoo3U6vtcGpZz/DglILpZCK5f5eox5P5mT/4QMeJT5Mh3VVghUHBfatqxWLc+kTSHY3Re/wvacjveAYkmjGKJArEK2fd6K7TVHkPJQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574457; c=relaxed/simple;
	bh=ItHw8xE+S9Soem22KPPUVeIKXOBUfGvHKw6fE0uFEFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AarXZMvkLo5I3bN3kmrbyKnPaKrCxyez4bF5GRHU1/CNl2cJ7/duFDQXz3250CSNyUX6UT76c5ifm/T1+buKRVQfK3fJV5PQ9I5oZGKXrazezGQk4Lze7vY1LjItJUm11XNR0h2Xpef1Awzyq/KETQlk1C8IU6IXgddhNMv5wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAntwotkHlpsMvYBg--.31858S2;
	Wed, 28 Jan 2026 12:27:25 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: haibo.chen@nxp.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iio: adc: vf610: Add missing check for device_property_read_u32_array
Date: Wed, 28 Jan 2026 12:27:00 +0800
Message-Id: <20260128042700.2260803-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAntwotkHlpsMvYBg--.31858S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1UWrWxAF1xtr18Ww1fCrg_yoWDCFc_G3
	s7u3WxXr1fAFs2yr17tw13ur9FyFyj9rZ5ua1jv34SkFy3Wa9xZr17Zrs0kr4furnYk3WU
	Ar4kCrWfCr43CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxkIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUhZ2-UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of device_property_read_u32_array() and
return the error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iio/adc/vf610_adc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index d7182ed0d2a7..d53723ccc5b2 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -871,7 +871,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
 
 	info->vref_uv = regulator_get_voltage(info->vref);
 
-	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
+	ret = device_property_read_u32_array(dev, "fsl,adck-max-frequency",
+					     info->max_adck_rate, 3);
+	if (ret)
+		return ret;
 
 	info->adc_feature.default_sample_time = DEFAULT_SAMPLE_TIME;
 	device_property_read_u32(dev, "min-sample-time", &info->adc_feature.default_sample_time);
-- 
2.25.1

