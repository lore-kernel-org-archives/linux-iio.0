Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764B46C4BC;
	Thu,  3 Sep 2026 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426474; cv=none; b=aRAjaoEVT9mCKWD8F0bgJPo7Rlk0OCyGEYBQcSsbGXX60TmKBV/Dx4NOElWs+NDj+oEoNi+NGMYxyZrThm5AXBnRzwJ3BkLhFfVRtxzvjd+D2QhlU9ZtvDuCwzqlb1ullAOTo5HReK/Ph5M8bYOvr1t7c5h9qyV3OPrHKHUz/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426474; c=relaxed/simple;
	bh=GLaDM+VJfQfwgiKpJJsFrelSgOFiazkjlrRGAWuQK6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEztwcgBQNDKjB7cHbhgj2SD4e8HrYiHw2QylurNigfY68U7ecilOLmm+IAdzf0VEZXcGxnwNf3wpbeg6MjGNriGJQo0XQnGunivSSC/IcjXDwA9eRsnd+kLlwGhP0Qfr1PTv022ZvTqImVWQDGlMYzJmzwuAxkF0WjlWD2WNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h7Popa4h; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h7Popa4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/x
	3LZutVf8rsfPBIeWPOT9s57JUCZgmU+cSnQzWgaXI=; b=h7Popa4h+rzCGVkNLY
	VpIpc+urKDLMApZqjIO85MR76JD+XJxoZYFsIuIFV7n55PYSh4DkR6WmL2vJYSLJ
	rxh0nyCPBfFdbXMqLgcWQjJBNLe6Lri2Y16gFORHjqR8SC/GUwzpgKv2FtU2zVcU
	HHbgPQ3PxALgGwl5vZCPn40po=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCH097JOJlqWQVtAQ--.56878S4;
	Thu, 03 Sep 2026 17:07:24 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v3 2/3] counter: rz-mtu3-cnt: check pm_runtime_resume_and_get() return values
Date: Thu,  3 Sep 2026 17:07:18 +0800
Message-Id: <20260903090719.3498955-3-dayou5941@163.com>
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
X-CM-TRANSID:_____wCH097JOJlqWQVtAQ--.56878S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3AryUuFWUGw4fGF1fKrW7urg_yoW7CFy3pF
	13KFW7tFW8Xr4kCrZ7twnrXr9Y93ySyFy3GFyrt3Z7AF1IkF1Yqw1DWFWjgFn5Cr95AFyj
	qw4Ygay3CF1Yqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j70edUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3QxC8GqZOMzyVQAA3D

From: Li Youhong <liyouhong@kylinos.cn>

The driver ignored runtime PM get failures and continued with register
accesses after a failed resume. Switch all call sites to
pm_runtime_resume_and_get() and propagate errors to the caller. That
API already drops the usage count on failure, so the explicit
pm_runtime_put_noidle() pairing used with pm_runtime_get_sync() is
unnecessary.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -102,22 +102,25 @@
 	return &priv->ch[ch_id];
 }
 
-static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, int id)
+static int rz_mtu3_validate_counter(struct counter_device *counter, int id)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	unsigned long tmdr;
+	int ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0)
+		return ret;
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
 	pm_runtime_put(counter->parent);
 
 	if (id == RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
-		return false;
+		return 0;
 
 	if (id != RZ_MTU3_32_BIT_CH && !test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
-		return false;
+		return 0;
 
-	return true;
+	return -EBUSY;
 }
 
 static int rz_mtu3_lock_if_counter_is_valid(struct counter_device *counter,
@@ -125,6 +128,8 @@
 					    struct rz_mtu3_cnt *const priv,
 					    int id)
 {
+	int ret;
+
 	mutex_lock(&priv->lock);
 
 	if (ch->is_busy && !priv->count_is_enabled[id]) {
@@ -132,9 +137,10 @@
 		return -EINVAL;
 	}
 
-	if (rz_mtu3_is_counter_invalid(counter, id)) {
+	ret = rz_mtu3_validate_counter(counter, id);
+	if (ret) {
 		mutex_unlock(&priv->lock);
-		return -EBUSY;
+		return ret;
 	}
 
 	return 0;
@@ -165,7 +171,11 @@
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		*val = rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
 	else
@@ -187,7 +197,11 @@
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
 	else
@@ -203,8 +217,11 @@
 					      enum counter_function *function)
 {
 	u8 timer_mode;
+	int ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0)
+		return ret;
 	timer_mode = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
 	pm_runtime_put(counter->parent);
 
@@ -279,7 +296,11 @@
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
 	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
@@ -300,7 +321,11 @@
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
 	pm_runtime_put(counter->parent);
 
@@ -377,7 +402,11 @@
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
 	else
@@ -504,7 +533,9 @@
 		goto exit;
 
 	if (enable) {
-		pm_runtime_get_sync(counter->parent);
+		ret = pm_runtime_resume_and_get(counter->parent);
+		if (ret < 0)
+			goto exit;
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
@@ -543,7 +574,11 @@
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
 	pm_runtime_put(counter->parent);
 	*cascade_enable = test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
@@ -562,7 +597,11 @@
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
 				      RZ_MTU3_TMDR3_LWA, cascade_enable);
 	pm_runtime_put(counter->parent);
@@ -582,7 +621,11 @@
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
 	pm_runtime_put(counter->parent);
 	*ext_input_phase_clock_select = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
@@ -601,7 +644,11 @@
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_resume_and_get(counter->parent);
+	if (ret < 0) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
 				      RZ_MTU3_TMDR3_PHCKSEL,
 				      ext_input_phase_clock_select);

