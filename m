Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2723E9287
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003237; cv=none; b=ClwNdUMBm86ucEe+yXuS2Kae2UAGKJOCyp0hB28YDav/RZtFSKUX6gTHQoXDTOSzCzkVZna2+tLDwwt0SoPeAw1wT196DuEwAsK+rkck9sEhYL6WnC90KcJ5OcY72PzVmRrt50v+9RHQLgkCWTZQfa1t6x5V/ErzvSfLspyTZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003237; c=relaxed/simple;
	bh=Mtuja62FrHidWILVcOTdO+S6ly1ze79AOqSKRIYrB9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KZr6tip+ryKnPG/jwTlRDud+xGhdmsA8wy0mVyL9Hn3Vj/9QiKB/apnfuFt8WCmhsSkJRtIIi7iwl9c2am5cke6g2vIS1E6sxVuUG5UDAsdG1dKilgLaWL1o96Jw4zoe5b9Fg14AgEAj95F9AZcB9iqwbkHuDeGc1zhl41qAEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgPRL3UX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgPRL3UX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so17443635ad.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003235; x=1778608035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEPnTRoMbdigwNtehCMFnXOsqEDViLOsrmjhKQALWCM=;
        b=OgPRL3UX3h5w04xH6Y9sG1J8XY5hQT2yJoKzCtedL1T8jAKP8ma+S14A86OlelnIi2
         nr0Wa1CQ/4UiCnaCYurWnnhnBHkeQ/e1pKqCAHKoJoiF8uQS9CVaE586IPhDTPafioHW
         OLfyHDiK3vYrLmTGiArtg3r/Wr+HToAWMKxA1FukFlZHPOEtmqZBdPi92KV3DcZVB2Dq
         QTbXgRKGk8PhFGV6vwQbZ1zdZbeEPRADmfF/9V6xkAbx63NqbtHOVNhelZCaYBV3MP9u
         u8qML7s8MMRccQeuOKw+lyDN6XoOdxLemFkAdHGD1oNhiXubF+NKRuNRpWs13raojelD
         IFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003235; x=1778608035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WEPnTRoMbdigwNtehCMFnXOsqEDViLOsrmjhKQALWCM=;
        b=IfCHB6m9T+gdwv9K3hsRY847CQyQZnk3oTePmTlR9uauDlfprko1HwJmRbyt9ctg7x
         F4lIHtn13iowby30HReaa3X2iTIvv+gUvuQujFHBED3dxPobmBgtMHKNYBVM3KZkXjhb
         Os1qd8GVpZFsuEKiBSBpZhxg7aY6S1Uy65sTQedvx3VzxrPJZDPR62w5XqE3rKI1vxM/
         nzF3Ecg8c5u4wkIe2fItj09WsRccC9TGp8kkcenApMUkk3yWexCfcmmcBrJi71KlZFi0
         3HOUsorWk2fY+fiYtz/N3AST0/u2xOS+5zfMAkVzvytio4R6jh0vNF5D0g10z4MiCrIZ
         b+Iw==
X-Forwarded-Encrypted: i=1; AFNElJ+dV3ZRSZOpAb3oka8Bx/Esvrjc+tLYZrFCJSTMwtoaRwWuZyhzK85+nofZkD9k3g2htGF3gCSmmhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoWHpxsBGw8T93oP6pjk4QWJOZfIDkpYRPN7LznwmAli53AgOq
	ke6C9fQFxITaYVNtZGaBnGz1nxNZxZC+Hq6NeCqCGIO+KJDGsAJ99TNv
X-Gm-Gg: AeBDiesO5JvGWUZ2rI/G2Q2zt69vEPcO+Mt1YD/AONLXJeWSOf/tlc1AD8VmxZOOwM5
	jmjGVVjGztQww/aS6z30g6ZCHzaFoX75n3iiW35vNBDRI1QfcRA2VNeCLFoS7TZji6t6zPRFGd3
	JnlaQ1NTPQuSpn8C3awSIoxa72h5MbGv+7iZCbRFAC7vZQtdQPN7e2nUp547j7Hq+lzdrUrU42S
	3WIG22eAoIKUu0QxT55Y9bTNrsOKKM/7asBLhIACU7dt5O+o9Ms8zclbyKsiwfV6QQ40V3eXO9c
	lxx41+GLBvbMfynkq5wgj/M4FI2WYqaK4nueUl7mbJO6V0uznJs8jv86rWtBaXnlWxc3+6JhtJ5
	DTY0kpd132y+5RdSU/Gub3JejaOTLzQDyFwc+dnB6Y/Dt6Wa9TEFocqHiP9wKxxPZMr6EU6hD04
	A9oEgdVPa+6OjCnXNFh/xlX6aJAMW1NwrAHpyzs/1SWS7H3S+I87f/BL2V43c=
X-Received: by 2002:a17:903:40d1:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2b9f260b4a7mr158964595ad.30.1778003235159;
        Tue, 05 May 2026 10:47:15 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:47:14 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com,
	martink@posteo.de,
	mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] iio: accel: mma8452: use local struct device
Date: Tue,  5 May 2026 23:16:37 +0530
Message-Id: <20260505174640.3998281-8-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &client->dev.
This avoids repeated &client->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1c984c708ec3..2cd24b1543af 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -222,15 +222,15 @@ static int mma8452_drdy(struct mma8452_data *data)
 static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 {
 #ifdef CONFIG_PM
+	struct device *dev = &client->dev;
 	int ret;
 
 	if (on)
-		ret = pm_runtime_resume_and_get(&client->dev);
+		ret = pm_runtime_resume_and_get(dev);
 	else
-		ret = pm_runtime_put_autosuspend(&client->dev);
+		ret = pm_runtime_put_autosuspend(dev);
 	if (ret < 0) {
-		dev_err(&client->dev,
-			"failed to change power state to %d\n", on);
+		dev_err(dev, "failed to change power state to %d\n", on);
 
 		return ret;
 	}
@@ -1552,7 +1552,7 @@ static int mma8452_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1562,10 +1562,10 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(&client->dev, -ENODEV,
+		return dev_err_probe(dev, -ENODEV,
 				     "unknown device model\n");
 
-	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
@@ -1598,7 +1598,7 @@ static int mma8452_probe(struct i2c_client *client)
 		goto disable_regulators;
 	}
 
-	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
+	dev_info(dev, "registering %s accelerometer; ID 0x%x\n",
 		 data->chip_info->name, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -1631,10 +1631,10 @@ static int mma8452_probe(struct i2c_client *client)
 	if (client->irq) {
 		int irq2;
 
-		irq2 = fwnode_irq_get_byname(dev_fwnode(&client->dev), "INT2");
+		irq2 = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
 
 		if (irq2 == client->irq) {
-			dev_dbg(&client->dev, "using interrupt line INT2\n");
+			dev_dbg(dev, "using interrupt line INT2\n");
 		} else {
 			ret = i2c_smbus_write_byte_data(client,
 							MMA8452_CTRL_REG5,
@@ -1642,7 +1642,7 @@ static int mma8452_probe(struct i2c_client *client)
 			if (ret < 0)
 				goto disable_regulators;
 
-			dev_dbg(&client->dev, "using interrupt line INT1\n");
+			dev_dbg(dev, "using interrupt line INT1\n");
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
@@ -1679,14 +1679,14 @@ static int mma8452_probe(struct i2c_client *client)
 			goto buffer_cleanup;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
 		goto free_irq;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev,
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev,
 					 MMA8452_AUTO_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
@@ -1721,11 +1721,12 @@ static void mma8452_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &client->dev;
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
@@ -1748,7 +1749,7 @@ static int mma8452_runtime_suspend(struct device *dev)
 	ret = mma8452_standby(data);
 	mutex_unlock(&data->lock);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "powering off device failed\n");
+		dev_err(dev, "powering off device failed\n");
 		return -EAGAIN;
 	}
 
-- 
2.34.1

