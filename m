Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1F39B95D;
	Wed, 29 Apr 2026 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445523; cv=none; b=k/YfrYdfM+HBUf/sE6LRtEt1f67ytV0lWxVnZT1RxDbMKJQDn/ATbJvYZyogHy6T3ShsJTbTwQdYMxn1Yrsdb5LxUVg7oVTi8hhp1q7OZh6lR25+1fTOxOZgMbCMG+akfM31IEMQqeXeqQjJypBbBeTUUt5sBRCGnTVIP4ZbwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445523; c=relaxed/simple;
	bh=PuzO0gP6jYn9N5pQ22mz5LxEGbb1KcskO9wxlrEBVSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KilRXDMSBGkmVj3xhLYl2Y5OQRPNdo7lvWsvxjSUJbhTGJueucfDcf/pxNu1JsK78F7dtx5z0lhIvrBEsgKp9AnOdj9a9SrSXVoAeQf/gI3QgAlZWUW8IBiES0VXjCkhe8a5SrrYkRr69lSm5dD/IRH6BQldPZ4ccwlWsfaCUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dzZINbyc; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dzZINbyc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Nb
	i0J4MdB+kTiCidzJffXzaHFy9pHyi2Pp+N4cV/URg=; b=dzZINbyc1I7b5O2tPr
	5L2oLVhARFBwTPbtIwcsqzryhQZ7vv875QpJORgZTBTENsgez17sIX0JS0ND+/i/
	5zWmin5987B7GAepGiiY5QVsNylqs1pNkCuYUoMy2B4UGGf/zmSnhH/BaLLbs4O3
	aF2c5RtH2ASKXzMCvKLkRBd6A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXg2lsqvFp2vXHCQ--.60764S2;
	Wed, 29 Apr 2026 14:51:24 +0800 (CST)
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
Subject: [PATCH v2] iio: light: stk3310: Deal with the ps interrupt issue in PM
Date: Wed, 29 Apr 2026 14:51:23 +0800
Message-Id: <20260429065123.205449-1-limiao870622@163.com>
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
X-CM-TRANSID:_____wAXg2lsqvFp2vXHCQ--.60764S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury8CF13uF45Ary7GF4Durg_yoWrCr47pF
	WUCF45trW7Gws7GrZxJF1DZF90g3yxt347AayfGw1Ivr1akr90gF1fJFWxXFnY9ryYya1U
	Ja1vvayYkr4qqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbC7w2camnxqm3VGQAA3H

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
 drivers/iio/light/stk3310.c | 74 ++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a75a83594..af1c28c84 100644
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
@@ -688,7 +723,36 @@ static int stk3310_resume(struct device *dev)
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
+		if (ret < 0)
+			dev_err(dev, "failed to enable ps int at resume.\n");
+			return ret;
+	}
+
+	return 0;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
-- 
2.25.1

