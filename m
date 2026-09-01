Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88B7DA66
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 02:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231057; cv=none; b=GeeSZifJIV8VuLz/MxlT8lPQ4zYrSXt9yicWzVL4lIScIDvFjE8V6KyTj/4OmVtDmKo32LTJSaxLu4KBy0KjaqxH8RLTBrx3i4I+TWx6j+ePuElbdRLteaWgDrg1gydtU3ZX5kvM4uoxj6KNgx5cqOXmlpghCgWdX4wRNDP0iH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231057; c=relaxed/simple;
	bh=Cess8UllWrdlUo1CKLUeynQ+blCXJSUZf9+VdP03mpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Co6Ca9g3rwK/nk0E2I2trb5Mk3UWtYmpY6H6Rnf2Servh6e+x1K9NGudFOz6JttFLuxpBbJ5bkWNupQz12ZBz1+w2SzBZ1YATUxBOddovqzC1SCgjxx/DPrL3IyHMHRwsNP8NoNM55++UUld0p831+O1gTRpNJc1veVqgnQRRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AmorSZYI; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AmorSZYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ec
	7yu8hSU1h9jQ84hCYUinhw3Q+4QhpEynUqM3+9utU=; b=AmorSZYI3w0QSjlHkV
	K6iq8jkTIOjCea+/8d91d0cT86U8XnmvBn521ihDIcE++OlnSoCm7X3qvtTIlK04
	fSKvH3SYw01Zcxs80In3x621zdK5f8yIWWvhMEyLMh5U/zFAfRWEg1R/TvXUguUz
	T8oyL3loANHc653M/nQVXrEb0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCH5exjPZZqIOImSg--.16344S2;
	Tue, 01 Sep 2026 10:50:13 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: wafgo01@gmail.com,
	jic23@kernel.org
Cc: maxwell@maxwelld.cc,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH] iio: flow: slf3s: disable regulator if measurement restart fails
Date: Tue,  1 Sep 2026 10:50:10 +0800
Message-Id: <20260901025010.356735-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH5exjPZZqIOImSg--.16344S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1xCryruFyUWr4kZw4fKrg_yoWDtrX_Gr
	n7XrZ7Jrn2krW5Cr42yr1avry3Ka92qFWxury0qa4fCry7ZFs7Aw4xCr1Dt3yUtrWUW3Zr
	CFn29r1Iyw1rGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8JPE3UUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3QWoV2qWPWV27QAA3Y

From: Li Youhong <liyouhong@kylinos.cn>

slf3s_resume() enables the vdd regulator and then starts continuous
measurement. If slf3s_start_meas() fails, resume returns an error
while leaving the regulator enabled. Disable vdd on that path so a
failed resume does not leave the supply on.

Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/iio/flow/slf3s.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
index dfa7c1409045..9b63ceb3768a 100644
--- a/drivers/iio/flow/slf3s.c
+++ b/drivers/iio/flow/slf3s.c
@@ -487,7 +487,11 @@ static int slf3s_resume(struct device *dev)
 
 	fsleep(SLF3S_POWER_UP_DELAY_US);
 
-	return slf3s_start_meas(sf, sf->medium);
+	ret = slf3s_start_meas(sf, sf->medium);
+	if (ret)
+		regulator_disable(sf->vdd);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(slf3s_pm_ops, slf3s_suspend, slf3s_resume);
-- 
2.25.1

