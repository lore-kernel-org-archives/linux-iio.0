Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B033936B;
	Thu,  3 Sep 2026 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426466; cv=none; b=HEry92LrGU+xyU3Qnz1+0tdteLudgaTlemqdhonhZmVLODRK7FhwGbXIHkOlV9QH6ouM09cegbT4u+rLCuZ60HPC+6dZksiY+tLl353jTjffiSSQ0JZ52qvCN6zP9OEmWqD6mIpDpHeFIXqrM6nNRwNgXjMNoD0qC5MR9cvTgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426466; c=relaxed/simple;
	bh=mrjeFOmdcLzPwS2THS0pjZfl7iE9o2DmdqUriekPczE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfwM1GRaeRiTSZOD0CebJJ3xVxQtrDk05FFLJU4eL7+s4x+jQ7EiCTwKN3FIRBJLJTzU92pqNdl0n61DzUU1DoryEEO/j/vvcqwh8+egXrCKGoYUY64YwgWaOdxTbVjZAnZAaxCWGhRyhyGBDH5XJNinXAVmMUjMED+PPbG1/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jGHFsZUM; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jGHFsZUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fY
	ZIxgYdUDO1xWZ9ethAM2iyCgrBC/MquLz7b8t+Ya4=; b=jGHFsZUMnQfbaDZV6S
	9oF9NOyGkF1r0DYX8oZV/fhTFS8ljLB9YwKetuYc/5roi1Vr1hO9sojAqOEnfY7F
	8VmxOXH+RwyK4y2MqKCkSqujwjPBYkVOIEAHEsFQ7/038wIq/wDkzBTfcwzNBjxt
	xNp8oMg7qM3WE4H++ZNvD4Y7c=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCH097JOJlqWQVtAQ--.56878S5;
	Thu, 03 Sep 2026 17:07:25 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v3 3/3] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
Date: Thu,  3 Sep 2026 17:07:19 +0800
Message-Id: <20260903090719.3498955-4-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903090719.3498955-1-dayou5941@163.com>
References: <20260903090719.3498955-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH097JOJlqWQVtAQ--.56878S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1kXry5GF18tF4rAw13Jwb_yoW3CFX_CF
	s8G3yqgr47Ww4kCr4jqw1UXFZYyrsrWrWkZryvyr4Yy3y7J3s8tw4rCrWYkr4DX3yDZF98
	tw4rtr4xZw1UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeYZX5UUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3g5C8GqZOM7prQAA3j

From: Li Youhong <liyouhong@kylinos.cn>

Counter enable takes a runtime PM reference before initialization but
only puts it on disable. Drop the reference if initialization fails.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -537,8 +537,11 @@
 		if (ret < 0)
 			goto exit;
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

