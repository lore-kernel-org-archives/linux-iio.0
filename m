Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB777381AE5;
	Thu,  8 Oct 2026 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425131; cv=none; b=i83AQnwcX6ZTEIUZpKoDSvdOFaEI20gNR4+4w1qwVQFzL62s6p7zREDTvDuEXaEc11Vuyh0HAcysjChIt6twDfHFcHLdIxyDxAWC3y2MBmOHjT70O91xwD10Gjv1CqE8GH7nAhFPWBZ7dEu6eiyN8Ayfc+OsT9nkxCXSy4WUmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425131; c=relaxed/simple;
	bh=2OCeFcjCzArKyTTaQ1L2fThRCwraVmGqryoUBNsfvCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fJPGUB8+cERweZZEIByU43dpwqebxMVgBzzHv0WxCDNRNFax7idl3R8sajpVxAMQJBEd8B7DIiUst0O3TOBqUaoDNaTD+CLbohsOtfhO6sUutpTFCjDjMgi3PQC85pLPI8FbmsSBAaZqiKGGlRA3gysrHG8O0xWQxYQT8qrU/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DhXU4Hql; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DhXU4Hql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=n3
	W9v5yX7pDDxRSAdJcdUbyPDowvC1UavREd9E0gszE=; b=DhXU4HqlHtbIaTQ/7q
	k1CZM9oYEIHPD+2FA1RCf5WAJQkheTpLj9XenQIs1t6Wk+1SapPDU/gAWSMoaOex
	o/zcdQzpqMFeFaXrfAppDCA2frhQukgvhNYqzBgEJB/WlQhiKHkKUIWFskNZSS6s
	YTqpFHufU+jafyQS4uHRSeBls=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3_95T+sZqz9+nDQ--.12695S2;
	Thu, 08 Oct 2026 10:05:08 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
Date: Thu,  8 Oct 2026 10:05:06 +0800
Message-Id: <20261008020506.211566-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3_95T+sZqz9+nDQ--.12695S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1kXry5GF18tF4rAw13Jwb_yoWkAFX_Cr
	s8W3y7ursrWw4kCF4jqw15XF90krsrWrW8ZrW0yr4ayrW7A390yw4rCry5Aw4DX3yDZFn5
	Jr4Fyr1xZr1UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8T7K7UUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3RQgzmrG+lQaDwAA3w

From: Li Youhong <liyouhong@kylinos.cn>

Counter enable takes a runtime PM reference before initialization but
only puts it on disable. Drop the reference if initialization fails.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/counter/rz-mtu3-cnt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193c..61fbeb122851 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -506,8 +506,11 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 	if (enable) {
 		pm_runtime_get_sync(counter->parent);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
-		if (ret == 0)
-			priv->count_is_enabled[count->id] = true;
+		if (ret < 0) {
+			pm_runtime_put(counter->parent);
+			goto exit;
+		}
+		priv->count_is_enabled[count->id] = true;
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-- 
2.25.1

