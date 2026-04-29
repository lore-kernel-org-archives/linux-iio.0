Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78F3A4F3B;
	Wed, 29 Apr 2026 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447012; cv=none; b=i0sAQ9thp8XSawCgQ4MAB80vf8qOXrcUjQa52t+Kojk3x4wxJIzfilYllryqB3mnoRfAYGOOuOf6MveR0ckjfEtyd1zSIS15BzFeTW+nrpt7s+tP16Z4AofOV2w/hMYm5+60wYRU5HDBxBrlSGXx/cSbseNF0JULwSg+AyFpjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447012; c=relaxed/simple;
	bh=Ro0BhA8vzYhDjG4lkidScw64pVFgIG4KkL7SFiESN2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aajvU/0wXUFM/iFF/7FK6OaavLX3Ww+m+oIODODQHeCwaz5amlE3jwr/nn60xKRVoHi4r5ypxzmpOO4j91QRKiA8OIQSuC5VT9xPrJmzh7Hu8rKAquCESZcfaNtxohPWTj+df+el8GQDfs2vuUjTFb69Y1/gz/Xj8klE5yZPr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jp9CwUMr; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jp9CwUMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=b3
	/fcfCOHsI9F+f/mgPCSQgnERqbR8q4YboBl0W8IPY=; b=Jp9CwUMrra4o7P1sJA
	a7XFvor+wHYOmH6q43WUJOEp7uQsrRMk5Wl9ga82eKeTd+zhBIc9jG2MSpf+kexO
	Q7gmOOwZO4Wa7VxazkYoK1ko+vE4/d9DrYCrpc5hdX7TTwmGUGhPGtO9Z/HZmHnN
	B0gO7Ew73W4ZcRC2BGmQOseKg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn2ym8r_FpzL4vCQ--.82S2;
	Wed, 29 Apr 2026 15:14:05 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	dixitparmar19@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	waqar.hameed@axis.com,
	limiao870622@163.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH v3] iio: light: stk3310: Deal with the ps interrupt issue in PM
Date: Wed, 29 Apr 2026 15:14:02 +0800
Message-Id: <20260429071402.209438-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260428192213.7c5c80e5@jic23-huawei>
References: <20260428192213.7c5c80e5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn2ym8r_FpzL4vCQ--.82S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury8CF13uF45Ary7GF4Durg_yoWrCr4fpF
	WUCF45trW7Grs7GrZxJF1DZF90g3yxt347AayfGw1Ivr1akr90gr1fJFWxXFnY9ryYya1U
	JFWvvayYkr4qqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbC8B3xv2nxr71rYAAA3i

From: Miao Li <limiao@kylinos.cn>

On the Inspur HS326 laptop(which integrated with HiSilicon M900
processor), if the STK3311-X chip's PS interrupt is configured
in "Recommended interrupt mode", the interrupt cannot be triggered
normally after waking from suspend or hibernation.

In this case, neither disabling and re-enabling the interrupt nor
resetting the PS threshold register can restore the interrupt to
normal operation.

If the interrupt is disabled in suspend() then reset the PS threshold
register and enable the interrupt in resume(). This resolves the issue.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/iio/light/stk3310.c | 75 ++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a75a83594..f7c4e5014 100644
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
@@ -504,10 +523,15 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&client->dev, "failed to enable interrupts!\n");
+		return ret;
+	}
 
-	return ret;
+	data->ps_int_enabled = true;
+	data->ps_thdh = STK3310_PS_MAX_VAL;
+
+	return 0;
 }
 
 static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
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
@@ -688,7 +723,37 @@ static int stk3310_resume(struct device *dev)
 	if (data->als_enabled)
 		state |= STK3310_STATE_EN_ALS;
 
-	return stk3310_set_state(data, state);
+	ret = stk3310_set_state(data, state);
+	if (ret < 0)
+		return ret;
+
+	if (data->ps_thdl != 0x0) {
+		buf = cpu_to_be16(data->ps_thdl);
+		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDL_PS, &buf, sizeof(buf));
+		if (ret < 0) {
+			dev_err(dev, "failed to set reg THDL_PS at resume.\n");
+			return ret;
+		}
+	}
+
+	if (data->ps_thdh != STK3310_PS_MAX_VAL) {
+		buf = cpu_to_be16(data->ps_thdh);
+		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDH_PS, &buf, sizeof(buf));
+		if (ret < 0) {
+			dev_err(dev, "failed to set reg THDH_PS at resume.\n");
+			return ret;
+		}
+	}
+
+	if (data->ps_int_enabled) {
+		ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable ps int at resume.\n");
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
-- 
2.25.1

