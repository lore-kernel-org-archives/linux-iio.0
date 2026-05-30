Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5113AA1B8
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141221; cv=none; b=XNju/24rObFDr7nQz6kUtVdZk/mr0C1aHtNLwQnIb6ejpF8FurgwFp35kfEEEhItgJTWcHB4dOWeiMNRNgef8WkCxd7XTsmG9B6A+ECW9NYzCAG/YvrXNLweqY29q2/TCyZgRVwvEJesAYD1OQ/B5zfaog16sTGFhrgrwm1lqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141221; c=relaxed/simple;
	bh=NBy+mkNrqimaOWf2ERo+sQjKJUgFdTb/ZQTPXdtPvfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoaS9XNy+UAMm1ME+Fd/pKrV9Gf3dVR0ROlR4zhwK5iWbFOZITerf9H/GcZKz/v9pznA/Treg20Kk4pWo/OlJJBzlT3Cjgs07J5iQ0IX/c2m0ISHgs2NaYGuWUMhSlgPiIWATWkNkaGVx7BSNoG+39P4jnukkKw7isxaadTtk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nShTw77J; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nShTw77J"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842307472d4so64575b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780141219; x=1780746019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgCJI2YjM9JuHXtmrKn60x1jsb6A7Po4zShmgNdGeKM=;
        b=nShTw77JEUKGyXgHC7N+NDawZ3/9QaL3egOtfuBI2ggfG1ZEE3VxWcidW5zdpaVMD8
         n5QR9hEiaoGybd3BFbFiunVFO82ZYwYtjPtomo5JXLchDNp/xy1L4aObm4oIx5V+fszM
         s6cacFqQECt4t65DNgbxFcZuUr3JTi9UBHpNOg1/+vtBgDJDIe/sUKx7uKu3PNe/Bzbl
         WCoaeZgo3mF4KwJ7m6oe1bVYBgUnGWx35AKKxZA6LtW/W3VjlnlvnoRv82V/9HePHJOE
         9c5iesQLkXYuJAErGHduqBMrRdi03R6X9eFBm0XU2i4BVvZS/9tR2FDNVB0jSyvMnsYj
         sysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780141219; x=1780746019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AgCJI2YjM9JuHXtmrKn60x1jsb6A7Po4zShmgNdGeKM=;
        b=Vh7xFc+RDxGVP6Ry24zGb8aN7YmQYdfZXnDmEHONPVrpL2J3c0U7uwbHX3IW9zHD16
         ygKpcT2gpaVs1UfZbNpArYan6SJf43dxcishcSFxzu4IKYQsO8qeg8/aAg9BPwIkusJS
         jih7LAdzdOTUBofnaPsVEA7J288Ik1r9P5lsZ3P7jY/UnSewXsCVFV9WKUryIAUhzz4B
         OO0HT9BG3GNSTwjLPzM8/TwgocwEe73gAMLqDjfNge+ulITtsQyfa9s1zEsXDj6MVliw
         j0/nPZwoxJSDgEy57NnpwNHeJcsjt5ZAf+Evw7RZGB8W7szpR149DB68CVWNsyqW0BeR
         OAtw==
X-Forwarded-Encrypted: i=1; AFNElJ+33LMKvAe/1wyASqvtF0wMl6Za8Fneqb+t1R3AflwqwfcbJZdAxjsBBkaOGdQpMe+TeN/nLa/YJzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRrGhDPWnMYr2IYPM/ksVyHOye4mwPBG4Ol8LXSCubnBx2T8x
	zteNbj9h5PRU2JQRPip9KCgzgR7LBYShZhwrEuGon/eCU5Eqnf+FqEf4
X-Gm-Gg: Acq92OFP3F2Q0NCAqk6Q61OCH+O/w0Exe0PgGtje76dfhP2dlgDKN5SYbxRHEiOStwM
	zAr/+/YkgdEMadt2N+PsZihBBgNpAhIHnAbxKX5+EYyCdkWSEeLcC1uk36urcDlPnmcdpNw7XNI
	Az6EeycdwELn+EKFalhe3QPGQ6sjdeeW7bnEoa8eFHcT68pGeBCfVFfaUNpW/HzdlKprj0hCQuK
	66OwhMMkV+is6Gp/ZGs9X0T4PnCywOSLCWW4dB8M9M4dxIrv/yPyj2mqbBC17UshZvcGx8O2X8J
	0t9Rr7LlYIP08aBJfCrZKQuS7Sj0YSwOscyO9ITTWfhQMDp6kagcQPeNHxmRqnr/Mpi/EVykFPI
	NWglW7/RkwX+GgOjxnW7XlCzkIfUXieDv8FT56I8uVpwgli/DjHWX+9xLCz9/mRVXJ6waC1jpKH
	qZWPKvI2U0XN21j+icM1GxI1orm913eBRBjSHJVpuRDdLI3O6zmiYhmiKAU389Niswj5/p
X-Received: by 2002:a05:6a00:27a0:b0:833:2398:cde2 with SMTP id d2e1a72fcca58-8422570a361mr2969224b3a.43.1780141219248;
        Sat, 30 May 2026 04:40:19 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b6797esm5467518b3a.26.2026.05.30.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:40:18 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	apokusinski01@gmail.com,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 3/4] iio: pressure: mpl3115: generalize interrupt pin routing
Date: Sat, 30 May 2026 20:39:37 +0900
Message-ID: <20260530113938.171540-4-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260530113938.171540-1-suunj1331@gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Write CTRL_REG5 explicitly for both INT1 and INT2 rather than
relying on power-on defaults when INT2 is selected.

This avoids incorrect interrupt routing after a suspend/resume
cycle where the register may not return to its default state.

Route both DRDY and FIFO interrupts to the selected pin. The
FIFO routing is not yet used but is required by the hardware
FIFO support added in the following patch.

Consolidate polarity configuration into a single code path
that handles both interrupt pins uniformly.

No functional change intended.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 52a3d0d59769..90e83e34ec43 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -67,6 +67,7 @@
 #define MPL3115_CTRL4_INT_EN_TTH BIT(2)
 
 #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
+#define MPL3115_CTRL5_INT_CFG_FIFO BIT(6)
 
 static const unsigned int mpl3115_samp_freq_table[][2] = {
 	{ 1,      0 },
@@ -624,6 +625,7 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&data->client->dev);
 	int ret, irq, irq_type, irq_pin = MPL3115_IRQ_INT1;
+	u8 ctrl_reg5;
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq < 0) {
@@ -634,6 +636,9 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
 		irq_pin = MPL3115_IRQ_INT2;
 	}
 
+	ctrl_reg5 = irq_pin == MPL3115_IRQ_INT1 ?
+	    MPL3115_CTRL5_INT_CFG_DRDY | MPL3115_CTRL5_INT_CFG_FIFO : 0;
+
 	irq_type = irq_get_trigger_type(irq);
 	if (irq_type != IRQF_TRIGGER_RISING && irq_type != IRQF_TRIGGER_FALLING)
 		return -EINVAL;
@@ -643,23 +648,19 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
 	if (ret < 0)
 		return ret;
 
-	if (irq_pin == MPL3115_IRQ_INT1) {
-		ret = i2c_smbus_write_byte_data(data->client,
-						MPL3115_CTRL_REG5,
-						MPL3115_CTRL5_INT_CFG_DRDY);
-		if (ret)
-			return ret;
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG5,
+					ctrl_reg5);
+	if (ret)
+		return ret;
 
-		if (irq_type == IRQF_TRIGGER_RISING) {
-			ret = i2c_smbus_write_byte_data(data->client,
-							MPL3115_CTRL_REG3,
-							MPL3115_CTRL3_IPOL1);
-			if (ret)
-				return ret;
-		}
-	} else if (irq_type == IRQF_TRIGGER_RISING) {
-		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
-						MPL3115_CTRL3_IPOL2);
+	if (irq_type == IRQF_TRIGGER_RISING) {
+		u8 ipol = irq_pin == MPL3115_IRQ_INT1 ?
+			  MPL3115_CTRL3_IPOL1 :
+			  MPL3115_CTRL3_IPOL2;
+
+		ret = i2c_smbus_write_byte_data(data->client,
+						MPL3115_CTRL_REG3,
+						ipol);
 		if (ret)
 			return ret;
 	}
-- 
2.52.0

