Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E724728F;
	Wed, 28 Jan 2026 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574716; cv=none; b=E97D6D3gLysgPrDItnt7mRWxMApNXcdnDkPcliiVS7Jl6Yuekjgsmx5ZNigiCj6vvHn1kcjkqVtqs6R72jFnqiC3OZTk4gw3BqKNM0vQqblXuG/3YxUBF439aS810QsiCMlDIdb80jatIEr9Xqci1sp6Qdy++Sv5i7o42DVbbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574716; c=relaxed/simple;
	bh=Vur2rStXAf82QT2flZpvHUvVNlOil2zDUtGR6BkqyUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SR1lxbojMw1vJ1+lzbQnZu6AQGm8wBlon9KbdjU3Fhl1QW4h8QVnbuGfIq7g8DyvN/U7EWmDFtBGUKAFu3JeVMvKlipKOFCBWUVeMF8KjLy+xzHnlsjHMP+VJvTQi9WTRuT31YUYpSbHeMuQeGCVAr8l8NtAtMoVovhhI12yfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABn9gkzkXlpqN_YBg--.28766S2;
	Wed, 28 Jan 2026 12:31:47 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	cosmin.tanislav@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iio: addac: ad74115: Add missing check for device_property_read_u32_array
Date: Wed, 28 Jan 2026 12:30:40 +0800
Message-Id: <20260128043040.2260887-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn9gkzkXlpqN_YBg--.28766S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1UJw45GF1xWw4rWF1kGrg_yoWftFb_Cw
	n7uwn7ZFW8Aa1qkr1UtrnFvFyjvFyUXF4kZ3Z0vaySqry5J393Zr18Zr4DKFyxCryIy3W2
	vr4UurWfCF1UCjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUelksDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of device_property_read_u32_array() and
return the error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iio/addac/ad74115.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index f8b04d86b01f..d0d6c0575ff1 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -1515,8 +1515,12 @@ static int ad74115_setup_adc_conv2_range(struct ad74115_state *st)
 	};
 	struct device *dev = &st->spi->dev;
 	unsigned int i;
+	int ret;
 
-	device_property_read_u32_array(dev, prop_name, vals, 2);
+	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read %s prop\n",
+				     prop_name);
 
 	for (i = 0; i < tbl_len; i++)
 		if (vals[0] == ad74115_adc_range_tbl[i][0] &&
-- 
2.25.1

