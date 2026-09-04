Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006F23741
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484179; cv=none; b=cjqC0xHjUUyrFT3Rl0DlvGIFyJ04hJCKw3Cn5fxOhJzhrmdlSCMFwSHeluibbAfBiRzBU1+J6igNOvm29TcA13SdjWjTanbnEltrkeTo1OMpXmpI+i6SNTiQQHAAaJQ4tUskNf4W2cnF83RX7B1BSpNKtG9rSyX5ikn4yhkC5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484179; c=relaxed/simple;
	bh=UVQMtavatTAR9ofmf5Iq7m3VPsS1TM3WofejV322noQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usZ6gFCdOUPEn8cAk/HtjDlvu2Bz4EA2y0eqeQbSZ1PAxFcwRDutK4qCQw+KLZ9i2D/JTBYh/1ciqRz/DrSVUUPjlzxZX5loSGQFu3+4LpSlBhMpwIRRXt8tIQ52OlIKVPTe7IED3+Ku3nZjdDQGmO6dRsAkkH9CfnHzVNi6LZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dY8ElRkH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dY8ElRkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mQ
	N/nDm5j98kapze+AYVnSX6NLvuxhyVGJlv+T1XNjs=; b=dY8ElRkHpwEV62Qq8M
	wuD3+drgCgRvz+giQFvBjaDWQts2bG9ZuaWYSg4NupoBax4c8uDsVtKlK/FFQrKm
	3o8OMkjSbUUGbIpsOHHUveNfA7YdXyj8qHAYYsUh0k2u8FMJP1YvlonENqKN8nvZ
	O4hBUUqFWqFzlUVbQ23wpseLo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3fSkvGppqYY2EPw--.5355S2;
	Fri, 04 Sep 2026 09:09:05 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: wafgo01@gmail.com,
	jic23@kernel.org
Cc: maxwell@maxwelld.cc,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v2] iio: flow: slf3s: disable regulator if measurement restart fails
Date: Fri,  4 Sep 2026 09:09:02 +0800
Message-Id: <20260904010902.1481157-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3fSkvGppqYY2EPw--.5355S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyDJF48Xry5Xw4fJw4UCFg_yoW8Xw4kpr
	4jkr9Ykr18ua1FgF48Cw1UZa45ZwsxC3y3uFWrGwnxCF45AF1Iyr1vka1Yv3WkAr95J39F
	vrW2kayUC3WkuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrrc-UUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3RHTgmqaGjHKFgAA3a

From: Li Youhong <liyouhong@kylinos.cn>

slf3s_resume() enables the vdd regulator and then starts continuous
measurement. If slf3s_start_meas() fails, resume returns an error
while leaving the regulator enabled.

After a failed resume the device stays suspended until another resume
attempt. That later resume will call regulator_enable() again. Without
a matching disable on the failed path, the regulator enable count is
skewed and the supply can remain on even after a successful suspend.

Disable vdd when slf3s_start_meas() fails so the enable/disable pairing
stays balanced across resume retries.

Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2:
- Expand the commit message to explain resume-retry regulator refcounting
  v1 Link: https://lore.kernel.org/all/20260901025010.356735-1-dayou5941@163.com/

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

