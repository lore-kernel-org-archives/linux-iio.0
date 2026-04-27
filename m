Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB43B2FF4;
	Mon, 27 Apr 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283038; cv=none; b=B8LRqIQzQCP5X2x9th9KP6EBolan44u9UFEe+wsvWrEHTh2Z1go/rry7YGdokBkepAb7wJY5jAheTqUDJr87vyu7fJp0cUTrqTKGqe/02Ut2/j+zT2DohnC0ZqEqkCrdq8j+u1bat+ngLPmKsJcrTyKOnuHEYAeCJRjYlIffJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283038; c=relaxed/simple;
	bh=wo2WWGMAaAzAci32tk/krwC8k383jUiQkSiitExvBjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSPy2mCRy3w2SyYjPyX50TQFskCdVjpJOQtBJDO3RMA7YiE4R9MNIA7Dx0Q6ujozeiP2gZl3pRiQp1Q8PKp9vS+pviNj1+q4UUwSVRPisdkVUWbVqap3Sb0c+T/dCY5X1qcCg84DPWIrUbpnWq0iDrA22x1NS5YAfa86AFcXBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=adeHbaF9; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="adeHbaF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=O8
	UiA3R+GpT52Ku20qeyM6l4zNcb6mflvxF4xKA095c=; b=adeHbaF9RPsOfa2B69
	ExnhE14StQfRXt+/XsyQ8cLRzIWnseOWDn8HgOVj0e2jlH6uNnXmG7yo38Spnp1a
	jovE2ewEJO8uOUN0E1BK9KX7j08s2q3gVOpE5vYpuuUpB8WlqoUuuC/e1fqwFJ8F
	so8d/hFG+8OJUZGiLiCagH9Tw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3j6CzL+9py3eYBw--.26650S2;
	Mon, 27 Apr 2026 17:43:17 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH] iio: light: stk3310: Deal with the ps interrupt issue in PM
Date: Mon, 27 Apr 2026 17:43:13 +0800
Message-Id: <20260427094313.81460-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3j6CzL+9py3eYBw--.26650S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWfGr17XF4ftFyktFWxXrb_yoWrWFyxpF
	WUCF45trW7Grs7GrZxJF1DZF98W3yxt343Aay3Gw1xZw1Ykr98Kr1xJFWxXFnY9ry5ta1U
	JayvvayYkr4qqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJGYdUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbCzRVPHWnvL7XGkgAA3C

From: Miao Li <limiao@kylinos.cn>

On the Huawei hisi platform, if the STK3311-X chip's PS interrupt
is configured in "Recommended interrupt mode", the interrupt cannot
be triggered normally after waking from suspend or hibernation.

In this case, neither disabling and re-enabling the interrupt nor
resetting the PS threshold register can restore the interrupt to
normal operation.

if we disable the interrupt in suspend(), then reset the PS threshold
register and enable the interrupt in resume(), this issue can be fixed.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/iio/light/stk3310.c | 71 ++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a75a83594..367657920 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -117,6 +117,9 @@ struct stk3310_data {
 	struct mutex lock;
 	bool als_enabled;
 	bool ps_enabled;
+	bool ps_int_enabled;
+	uint32_t ps_thdl;
+	uint32_t ps_thdh;
 	uint32_t ps_near_level;
 	u64 timestamp;
 	struct regmap *regmap;
@@ -296,8 +299,15 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
 
 	buf = cpu_to_be16(val);
 	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&client->dev, "failed to set PS threshold!\n");
+		return ret;
+	}
+
+	if (reg == STK3310_REG_THDH_PS)
+		data->ps_thdh = val;
+	else
+		data->ps_thdl = val;
 
 	return ret;
 }
@@ -331,8 +341,17 @@ static int stk3310_write_event_config(struct iio_dev *indio_dev,
 	/* Set INT_PS value */
 	mutex_lock(&data->lock);
 	ret = regmap_field_write(data->reg_int_ps, state);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&client->dev, "failed to set interrupt mode\n");
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	if (state == false)
+		data->ps_int_enabled = false;
+	else
+		data->ps_int_enabled = true;
+
 	mutex_unlock(&data->lock);
 
 	return ret;
@@ -504,8 +523,13 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&client->dev, "failed to enable interrupts!\n");
+		return ret;
+	}
+
+	data->ps_int_enabled = true;
+	data->ps_thdh = STK3310_PS_MAX_VAL;
 
 	return ret;
 }
@@ -671,9 +695,18 @@ static void stk3310_remove(struct i2c_client *client)
 static int stk3310_suspend(struct device *dev)
 {
 	struct stk3310_data *data;
+	int ret;
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
 
+	if (data->ps_int_enabled) {
+		ret = regmap_field_write(data->reg_int_ps, 0x0);
+		if (ret < 0) {
+			dev_err(dev, "failed to disable ps int at suspend.\n");
+			return ret;
+		}
+	}
+
 	return stk3310_set_state(data, STK3310_STATE_STANDBY);
 }
 
@@ -681,6 +714,8 @@ static int stk3310_resume(struct device *dev)
 {
 	u8 state = 0;
 	struct stk3310_data *data;
+	__be16 buf;
+	int ret;
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
 	if (data->ps_enabled)
@@ -688,7 +723,35 @@ static int stk3310_resume(struct device *dev)
 	if (data->als_enabled)
 		state |= STK3310_STATE_EN_ALS;
 
-	return stk3310_set_state(data, state);
+	ret = stk3310_set_state(data, state);
+	if (ret < 0)
+		return ret;
+
+	if (data->ps_thdl != 0x0) {
+		buf = cpu_to_be16(data->ps_thdl);
+		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDL_PS, &buf, 2);
+		if (ret < 0) {
+			dev_err(dev, "failed to set reg THDL_PS at resume.\n");
+			return ret;
+		}
+	}
+
+	if (data->ps_thdh != STK3310_PS_MAX_VAL) {
+		buf = cpu_to_be16(data->ps_thdh);
+		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDH_PS, &buf, 2);
+		if (ret < 0) {
+			dev_err(dev, "failed to set reg THDH_PS at resume.\n");
+			return ret;
+		}
+	}
+
+	if (data->ps_int_enabled) {
+		ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
+		if (ret < 0)
+			dev_err(dev, "failed to enable ps int at resume.\n");
+	}
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
-- 
2.25.1

