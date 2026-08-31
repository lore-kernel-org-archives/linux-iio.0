Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3F3AAF5A;
	Mon, 31 Aug 2026 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155074; cv=none; b=GVC/0/QLJikCMhjVEc62c6m8xvc+mUBBc5Jac13rvH9KG7Z/D0uKTUsJlFleaLUcgLrm5LalIh4q3pB0JvreJ4YSZqqnoyZU6RaNOkb/i1yL1Ad5hht+x8D+byDvfEw0Jz58U+eU8emsmpEG85V6yMBO+cbBI5CK6lOWWRIVYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155074; c=relaxed/simple;
	bh=lu4b4yBLz1LvsRWFeL7HVjz3aLxkLu8n6l+V4qUh3vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpMLjzvGLqsyA9Zt+WvjXk/EnD6uk6thGVumJN7W/ynQchbxI62Nyra1fgjGkg2e4pTDGKgXJuqZ72Ilzxv95L4AjFiDfHdSQPuMdxTRbbiMfl3kT8BX6ujYdBkpNGnCEQ/4GHOSbBAyU5Y1HqXP6EeMW2UJGqCFtVny1oTXaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W9GMxX26; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W9GMxX26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=RJ
	fzAU8fGbKX5nVI+4RclKOstvXiuaTKNACOpeoz4XA=; b=W9GMxX266i/3NdGZtP
	owc0XvhsJG5MVvDwLLQIcp7echJVpiZYlDEOwVDIoudG7Sp62bR+h99lLIEDKpIA
	MD4mEbf9hhtSDO9cL/sKmHJ9tC08ImOHPH/W8gTUUJRYsVjTnb3KI1hSyRupDNci
	TczjKyV1/myDiey5iSG8Oud/Y=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3nxWrFJVqhT4sQA--.61087S4;
	Mon, 31 Aug 2026 13:44:15 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v2 2/3] counter: rz-mtu3-cnt: check pm_runtime_get_sync() return values
Date: Mon, 31 Aug 2026 13:44:06 +0800
Message-Id: <20260831054407.1695146-3-dayou5941@163.com>
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
X-CM-TRANSID:PigvCgD3nxWrFJVqhT4sQA--.61087S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFW5ZF18JFWkur1rCFy5XFb_yoW3JF4rpF
	1akFW7tFW8Xrs7CFZ7tw1DXr9Yg34SyFyrGFy8K3WxCF17tF1Yqw1DWFWjgF1rCr95JFyj
	qw4Fgay3CF1Yqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2FALUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+g8w3mqVFK8fvAAA38

From: Li Youhong <liyouhong@kylinos.cn>

The driver ignored pm_runtime_get_sync() return values. When runtime
resume fails, pm_runtime_get_sync() returns a negative error code, but
the driver continued with register accesses anyway. Check all call sites
and propagate the error to the caller.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/counter/rz-mtu3-cnt.c | 98 ++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 18 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 3654e0fdab20..17912491e522 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -102,22 +102,27 @@ static inline struct rz_mtu3_channel *rz_mtu3_get_ch(struct counter_device *coun
 	return &priv->ch[ch_id];
 }
 
-static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, int id)
+static int rz_mtu3_validate_counter(struct counter_device *counter, int id)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	unsigned long tmdr;
+	int ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		return ret;
+	}
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
@@ -125,6 +130,8 @@ static int rz_mtu3_lock_if_counter_is_valid(struct counter_device *counter,
 					    struct rz_mtu3_cnt *const priv,
 					    int id)
 {
+	int ret;
+
 	mutex_lock(&priv->lock);
 
 	if (ch->is_busy && !priv->count_is_enabled[id]) {
@@ -132,9 +139,10 @@ static int rz_mtu3_lock_if_counter_is_valid(struct counter_device *counter,
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
@@ -165,7 +173,12 @@ static int rz_mtu3_count_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		*val = rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
 	else
@@ -187,7 +200,12 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
 	else
@@ -203,8 +221,13 @@ static int rz_mtu3_count_function_read_helper(struct rz_mtu3_channel *const ch,
 					      enum counter_function *function)
 {
 	u8 timer_mode;
+	int ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		return ret;
+	}
 	timer_mode = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
 	pm_runtime_put(counter->parent);
 
@@ -279,7 +302,12 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
 	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
@@ -300,7 +328,12 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
 	pm_runtime_put(counter->parent);
 
@@ -377,7 +410,12 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
 	else
@@ -504,7 +542,11 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		goto exit;
 
 	if (enable) {
-		pm_runtime_get_sync(counter->parent);
+		ret = pm_runtime_get_sync(counter->parent);
+		if (ret < 0) {
+			pm_runtime_put_noidle(counter->parent);
+			goto exit;
+		}
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
@@ -543,7 +585,12 @@ static int rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
 	pm_runtime_put(counter->parent);
 	*cascade_enable = test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
@@ -562,7 +609,12 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
 				      RZ_MTU3_TMDR3_LWA, cascade_enable);
 	pm_runtime_put(counter->parent);
@@ -582,7 +634,12 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
 	pm_runtime_put(counter->parent);
 	*ext_input_phase_clock_select = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
@@ -601,7 +658,12 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
+	ret = pm_runtime_get_sync(counter->parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(counter->parent);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
 	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
 				      RZ_MTU3_TMDR3_PHCKSEL,
 				      ext_input_phase_clock_select);
-- 
2.25.1

