Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758F3C0637;
	Mon, 31 Aug 2026 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155079; cv=none; b=gpJDphRHXQycXYCe5zNxvxUi1n+TvsJkgrNy0/BaFd24Sq0W9m5o0zVcKAVEHHIceP8oUagq7UmF0htaFkd8hged+Ed1fV1iaI8/1kfATgkwEfl3UkPnHGpSVA+AJ3/P+70HbwZkIPTTuWgcr6cX+dc3Ndzwkmva/+3V4SH0I7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155079; c=relaxed/simple;
	bh=SqM3Lk4NK7zBsfQ9YuB3BBub0jeH1jvcFWtxhFNdRbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0NANOCMslgMTHbegBoge4BCInZfDFlWq+g+9h9YxUfTbV77gjkzXwqyCp5fcQN2C1s2DS2C8sXMLHCERPBagJXj6AqjsMhpIVcWyR6WvSV9AdhMfv3qrRz4wNkiv6jTfK+LWY9znXXL6RI7OaGqDWzRnJ6AAwjmXdA88T+vcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qA2C2G78; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qA2C2G78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ch
	9stmEFQZTIA+C3QkzMYkASSiUvRydkZV+X/LbIXtU=; b=qA2C2G78lxQQQlbJb+
	AnzGz3bpdz89lcfInNtlhtQzJ+n4T3y5mHA5E0vlNnJSJCeLoudd3w0CIThqmX39
	4Lj+G8kkLpEegvt/5qw/qNji2M9pNAwSBMQkhjBFAJUCwrex59D+nSZd4KtY7tsI
	A0GCS045HGS1SZQmplZk0arSw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3nxWrFJVqhT4sQA--.61087S5;
	Mon, 31 Aug 2026 13:44:16 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v2 3/3] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
Date: Mon, 31 Aug 2026 13:44:07 +0800
Message-Id: <20260831054407.1695146-4-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260831054407.1695146-1-dayou5941@163.com>
References: <20260831054407.1695146-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3nxWrFJVqhT4sQA--.61087S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1kXry5GF18tF4rAw13Jwb_yoWkJwc_CF
	s0g3y2grsrWa18CF4jqw1UXF90kwsrWrW8ZrWvkF4Yy3y7J3s0yw4rCry5Za1DW3yDAF95
	Jr4Fyr1xZr1UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUewa93UUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+REx32qVFLETLgAA3h

From: Li Youhong <liyouhong@kylinos.cn>

Counter enable takes a runtime PM reference before initialization but
only puts it on disable. Drop the reference if initialization fails.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/counter/rz-mtu3-cnt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 17912491e522..d3f66fbb9bef 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -548,8 +548,11 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 			goto exit;
 		}
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

