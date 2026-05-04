Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5641A6809;
	Mon,  4 May 2026 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777863937; cv=none; b=UsMQLU9veLQC5AGsfiJZodh5Q44Cn954eqM+ypR0Ga88SnW2whX0EzyRkV1PM+0tg30bTBnK8tZ0fLKdNAMgHHoGjawruGVRgg/MmvbHVvP+p3KNX3XIpU+LaCElNzDz+OgegK+CKpd7iMItTOePQo/CJFWtXNHQYHFUBYoPIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777863937; c=relaxed/simple;
	bh=TpJXrsPeqoXcwn0q9vDCIUCH4w4ndcfIVo0mhk+excU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TsBtc1Vbx3Ah/9bXqYb1GjzUCDniVTElBPGryUv5w++oK/y6UNG/UkM4ACEiXN/xT2kpmBLf99hE8RMNAT0hfA9bvl/AoWRS44rIg+S+yapdL0OdBneB510Fc/67hL9eS9h3hoEeLk+0W9zA3Bj8v9QFOp+EAMDiui+uYSEb3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EUnc4h4o; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EUnc4h4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6t
	UPptFaHEBspNfHSUpHFM670LP0ib23VlHZnVbovYY=; b=EUnc4h4og/juiSyeNC
	RpDgVRabIOYP1bKn7vjCn8PGYkyuDdDTG4LJQmx0OQLVXOwuy/nYMKt5nnMoPopz
	zyMPAbSJALRw6OMixonABPbjBytEAIEH7R9iAY8gqjck/n42erAFh1qAWaZbOiP2
	MnwM3PZtHgssqa+43HPxugyEQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBntLOwDPhpacQZDQ--.45044S5;
	Mon, 04 May 2026 11:04:48 +0800 (CST)
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
Subject: [PATCH v4 3/3] iio: light: stk3310: Use sizeof() for regmap_bulk_read/write count parameter
Date: Mon,  4 May 2026 11:04:08 +0800
Message-Id: <20260504030408.105762-4-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260504030408.105762-1-limiao870622@163.com>
References: <20260504030408.105762-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBntLOwDPhpacQZDQ--.45044S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWxXryDXw48Aw1fKFWkCrg_yoW5JFW3pF
	WUAFZxCrW7Z3Z7ur1qyF4DuFyjq347K3W3A3y8G3WIvr90yr9xKFW5AFWfXF93urWxZa18
	Jw4v9FWFyF4qqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKsjUbUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbC8BPPnWn4DNMtAQAA3T

From: Miao Li <limiao@kylinos.cn>

Convert the hardcoded count parameter to sizeof(buf) for all
regmap_bulk_write() and regmap_bulk_read() calls in this driver
to improve code maintainability. For details, see [1].

[1] https://lore.kernel.org/all/20260428192213.7c5c80e5@jic23-huawei/

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/iio/light/stk3310.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 0447fbf1b..74ee75721 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -258,7 +258,7 @@ static int stk3310_read_event(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
-	ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
+	ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
 	mutex_unlock(&data->lock);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "register read failed\n");
@@ -298,7 +298,7 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	buf = cpu_to_be16(val);
-	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
+	ret = regmap_bulk_write(data->regmap, reg, &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to set PS threshold!\n");
 		return ret;
@@ -376,7 +376,7 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 			reg = STK3310_REG_PS_DATA_MSB;
 
 		mutex_lock(&data->lock);
-		ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
+		ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
 		if (ret < 0) {
 			dev_err(&client->dev, "register read failed\n");
 			mutex_unlock(&data->lock);
@@ -726,7 +726,7 @@ static int stk3310_resume(struct device *dev)
 
 	if (data->ps_thdl != 0x0) {
 		buf = cpu_to_be16(data->ps_thdl);
-		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDL_PS, &buf, 2);
+		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDL_PS, &buf, sizeof(buf));
 		if (ret < 0) {
 			dev_err(dev, "failed to set reg THDL_PS at resume.\n");
 			return ret;
@@ -735,7 +735,7 @@ static int stk3310_resume(struct device *dev)
 
 	if (data->ps_thdh != STK3310_PS_MAX_VAL) {
 		buf = cpu_to_be16(data->ps_thdh);
-		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDH_PS, &buf, 2);
+		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDH_PS, &buf, sizeof(buf));
 		if (ret < 0) {
 			dev_err(dev, "failed to set reg THDH_PS at resume.\n");
 			return ret;
-- 
2.25.1

