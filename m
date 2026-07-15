Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8A3C5DC3;
	Wed, 15 Jul 2026 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102875; cv=none; b=KuBLmJkY5m5DumTBkskTfunJ3wuLJCsR6IyJmbcUHVB+ZjohMTQJrCbdWOJjnVqVfqSu0RsTPeGed/zCxpIMT9npryHddyq+gJl/mn8hcH5uFLpZ3lWGCdrcBQm4tmRqZONDiOEHOnmzD5N2jLfaU2K96t8mRwqnX7s3Emijv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102875; c=relaxed/simple;
	bh=JT3L3K9roH4yo1TdcdBEuK//ojglZFvANI/l1YJMkWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nln+1rdWHxIoPxVIXnhtOybFsw/p7rCwwup/UWYjZZ7+9Ys2NiJXfVWcfIFxil6zZ6AhQuEb5wj31yGJ1x9aDOkDDVLINBo0ueHyem+ziCbjvFlkZwjAn6UrLJV/ZB7ylcxaSd0HTBKVHtbTy069yqOJsUi8rv+LLLYJtRm+fYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OwbCqxuK; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OwbCqxuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784102869; x=1784362069;
	bh=Fwrw9UVXkU3Ysrn/2m+Bqz7xfSAHjqk3ovFO9KUFxuY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OwbCqxuKneK/hLI/rMD/3nzRdZJ3mphaaczkuKakFyDogEtUk6Y0tDwUKbs5aP8/7
	 a8sVD8QpO3iNDycgj0KcZz5R+dgoRFPUNdBfDH+5Ia4lgRJpy5rJEk/lYZDH5BAHfr
	 bR1GgU6AAjwzpMLP86pV7Ue05ntP80TPGW+idE8wBDYTETnFFczPFbvbu1z6OHuutT
	 XqMxqnQFUqJKIlDcmOYpwbAIs55p+M5vAPyHXoD2bKhB+ucs1IEutXnJOIGW/fLcJu
	 L/FenqHV+upnKALNJjIg/7+c4J/NotHOMI22535E5s3XzEfgld3ozSRp+SNvbXlQle
	 eVP+AnhJ1+gAw==
X-Pm-Submission-Id: 4h0TLX13BNz1DDrP
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 10:07:39 +0200
Subject: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
In-Reply-To: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784102863; l=2847;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=JT3L3K9roH4yo1TdcdBEuK//ojglZFvANI/l1YJMkWs=;
 b=cVSq83aePMhO8xGnKAIOrlwI/TCHDyGLwOnf799D5TUmDELKRgrBr4AKhFJGkf5rErvhPZYNf
 DaroLA0NWdDCnPkpPGHlDkNqDBfIFRZbiaOe+bD/CeBf/ESTEKhPQAV
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When sharing interrupt line with other chips, the interrupt pin most
likely needs to be configured in open-drain mode instead of push-pull.
If this is needed, you must add drive-open-drain property to the
device-tree.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7d683686dd9d..a20c02ce0b9c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -81,6 +81,8 @@
 #define  MMA8452_CTRL_REG2_RST			BIT(6)
 #define  MMA8452_CTRL_REG2_MODS_SHIFT		3
 #define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
+#define MMA8452_CTRL_REG3			0x2c
+#define  MMA8452_CTRL_REG3_PP_OD		BIT(0)
 #define MMA8452_CTRL_REG4			0x2d
 #define MMA8452_CTRL_REG5			0x2e
 #define MMA8452_OFF_X				0x2f
@@ -108,6 +110,7 @@ struct mma8452_data {
 	struct iio_mount_matrix orientation;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	bool open_drain;
 	const struct mma_chip_info *chip_info;
 	int sleep_val;
 	struct regulator *vdd_reg;
@@ -646,6 +649,22 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
 	return mma8452_change_config(data, MMA8452_CTRL_REG2, reg);
 }
 
+static int mma8452_set_interrupt_pin_mode(struct mma8452_data *data)
+{
+	int reg;
+
+	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG3);
+	if (reg < 0)
+		return reg;
+
+	if (data->open_drain)
+		reg |= MMA8452_CTRL_REG3_PP_OD;
+	else
+		reg &= ~MMA8452_CTRL_REG3_PP_OD;
+
+	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG3, reg);
+}
+
 /* returns >0 if in freefall mode, 0 if not or <0 if an error occurred */
 static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
 {
@@ -1666,6 +1685,9 @@ static int mma8452_probe(struct i2c_client *client)
 			goto disable_regulators;
 	}
 
+	data->open_drain = device_property_read_bool(&client->dev, "drive-open-drain");
+	mma8452_set_interrupt_pin_mode(data);
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 
@@ -1683,7 +1705,8 @@ static int mma8452_probe(struct i2c_client *client)
 
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
+					   data->open_drain ? IRQF_SHARED : 0,
 					   client->name, indio_dev);
 		if (ret)
 			goto buffer_cleanup;
@@ -1800,6 +1823,10 @@ static int mma8452_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret < 0)
+		goto runtime_resume_failed;
+
 	ret = mma8452_active(data);
 	if (ret < 0)
 		goto runtime_resume_failed;

-- 
2.55.0

