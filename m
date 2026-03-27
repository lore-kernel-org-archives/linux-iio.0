Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CFF391835
	for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614480; cv=none; b=MtATYaVySkopgLCFfNVZpMuRD1ngHk/CJc95lTgGnQsLCnYjPYQ3yzLDotolNcRdGZe1fs9n70DgLWiRGZFjYtvpPZJGTMb+gvDelDoPmtRJG2i4PRiA+9iGW/i9EvpTvMIglFtqQBSi0aJz9eJEJsBAbu1lyPEmvtt8ypzxg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614480; c=relaxed/simple;
	bh=Mj5HHb2stM9v+UnA4mQPvtFEf1IYBNgRKy+7R1fP3m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OetIuZy0E8vJsy15Vb9hT4gyMZd4WbtFvCaocpEryHgEMUJkDt2NRN/Gk1szERsJfY2L5ntqRdX58Znhi1fHenfzoAceE/V/ub4gEFYUhaIKllz39r81da59Idf92j3aHPqkssnYscyjCabEkcMSxl4Qtlk4XOGOJGzoy86EPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIfOx4wq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIfOx4wq"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7393536e53so845257a12.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774614479; x=1775219279; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdNr9PIc0FbsIhNPrh7d0pILsLtmIoyXKFiWeHVC6ck=;
        b=sIfOx4wqwoot/xDii7selOKWnMQZuTcgqHesHJLcgktNa8mkOmgxfm9rCZIaePFnhZ
         Xp94wQYba0st7H9lJlrZNKizmjMDhZNEdc7W4jR496hFq12x7vS02gtM2YfjnEBx0Dck
         rqVXxhLwnzQ9Z+DVS6p6wl4kt4Ng4kTOj5a0PvQINqT1UvntVOwOwMGBI+Il4sPkGdpe
         8AR3JJl9tqGY2yksPjFC+i0JNOwQM1+LXn9LfU+yO+Dc98nGrqrSbEDMAGKA/AiTzVPx
         H9QDbiIgmboR9M99cmevyeZqqhHTxXYhVrPKgRNkGmOl6nbeAcxeH9c/4vpyAPu0gkTd
         pOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774614479; x=1775219279;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdNr9PIc0FbsIhNPrh7d0pILsLtmIoyXKFiWeHVC6ck=;
        b=Pew7uJU6KNPZgmCu5Hatg/jHFNyVf7wD6dfSTIYslkwHUE68YmGNKfRap3OEiDJ1Lu
         OMtXb1VuZDuWw9ursAOQeXUlzKo8adlHu3n07TvNpZoCr7cavU7vfkCa6ZV0P1NSRiQQ
         V9jpUfA0WZmbPaaVq7b/KBJw6Cq9voHB4KeaIjz3MPxAbhIxH0Nu+e5ztZ5yYJnAGlVP
         PCRs+l4shZH0b4avIfPgit7ttrVq1dlAfYmhQN2m115RydQcZ5UZd/lRAMQUvyHlcHIE
         sy2WJzUj9ptLk9mLs5gM4TCBeemIgHh7D/ntyTk1oToGdUXejZr1vV+sdAG0EVZx1JU7
         6MFg==
X-Forwarded-Encrypted: i=1; AJvYcCWVMbq1LMRyhbpXw2WYUfrQOALNnm+WYzU/6z3UIABt3FBqksTcZlIm7AroGv0Iuy/Xk7KbZNSz9uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Bhl2ocoFkl2qnofRMogHZA9K/HWR7QBV5zYvuTouwj/CaH+O
	pb0jkaD93KSQ07R1dcYt/Rtx9z2WNTcxL26bgAegx8mTVvfgUzA43X/S
X-Gm-Gg: ATEYQzyQh4nmxyfp77dGAzeXlXRDGMSaK9rdPnDA1DPv8Z2x/k3n58J8UaESe1kiDXN
	8xz1lS+oNZ2nGaec51LvAZ9lAlSRNzuMircn8a2vFaGMOsV8u69YDep7teeaPNp4ZL06W3KTivG
	6QUWi16093Z7PzJHAradl1BLMW8QoAMIBXA611Fe0V0UrM3pcjgOFbBJO2doaQZCem74Ws8w43k
	rusg3oidqUIUJC2eR3Dj9kircbAxS4YSUbMd8iq8aYqQqieMmeoAc+imW7HiJykcLme7VWwyjnY
	vaTujqEDYIZe4fcFZLVANSc/o3eUpxtFKaLUxD6V4edesdghBXoC64Q6GtpPGM63FZ0KAzmTqi7
	Y97l5G2/uC25/oHypqFcz7VEQDrGpeUIpDYnL+jjHXBtDJLVBMk08VdPmreVlNCSXY+Uw0Ucghw
	z31xFcvlIwJjRor4enHiU5j/BsQJN2LbPV8TIP
X-Received: by 2002:a05:6a20:7f9e:b0:398:abe1:eaac with SMTP id adf61e73a8af0-39c878493a4mr2683215637.27.1774614478439;
        Fri, 27 Mar 2026 05:27:58 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673931621sm4543477a12.19.2026.03.27.05.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:27:58 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 27 Mar 2026 20:27:54 +0800
Subject: [PATCH v2] iio: light: veml6070: Fix resource leak in probe error
 path
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-veml6070-v2-1-10c3c67eb171@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMl3xmkC/23MSw7CIBSF4a00dywGUHk4ch+mg6Zc2puU0oAhm
 oa9ix07/E9Ovh0yJsIM926HhIUyxbWFPHUwzsM6ISPXGiSXil+kYgXDorjmTFyN1dZwo52Hdt8
 Senof1LNvPVN+xfQ55CJ+6x+kCCbYzWnLpUStvHhMYaDlPMYAfa31C9/RRRagAAAA
X-Change-ID: 20260326-veml6070-1489798087df
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774614476; l=2236;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Mj5HHb2stM9v+UnA4mQPvtFEf1IYBNgRKy+7R1fP3m8=;
 b=tYMZ5IC0B3UteYMjcnzwatvGOUjsyCtnSJ8t+kYeiom9JxgmoN3uwGyhldRJWC2ro7cBa8NcT
 /pJOvUpC645B8UAHNuxOXxnCLfzsJ2sAkKGrA3i0JjtQCE6B1EHHjrn
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver calls i2c_new_dummy_device() to create a dummy device,
then calls i2c_smbus_write_byte(). If i2c_smbus_write_byte() fails and
returns, the cleanup via devm_add_action_or_reset() was never registered,
so the dummy device leaks.

Switch to devm_i2c_new_dummy_device() which registers cleanup atomically
with device creation, eliminating the error-path window.

Fixes: 7501bff87c3e ("iio: light: veml6070: add action for i2c_unregister_device")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Rewrite the commit message.
- Link to v1: https://lore.kernel.org/r/20260326-veml6070-v1-1-5d79022e76f1@gmail.com
---
 drivers/iio/light/veml6070.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 6d4483c85f30..416a9520713f 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -247,13 +247,6 @@ static const struct iio_info veml6070_info = {
 	.write_raw = veml6070_write_raw,
 };
 
-static void veml6070_i2c_unreg(void *p)
-{
-	struct veml6070_data *data = p;
-
-	i2c_unregister_device(data->client2);
-}
-
 static int veml6070_probe(struct i2c_client *client)
 {
 	struct veml6070_data *data;
@@ -283,7 +276,8 @@ static int veml6070_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	data->client2 = i2c_new_dummy_device(client->adapter, VEML6070_ADDR_DATA_LSB);
+	data->client2 = devm_i2c_new_dummy_device(&client->dev, client->adapter,
+						  VEML6070_ADDR_DATA_LSB);
 	if (IS_ERR(data->client2))
 		return dev_err_probe(&client->dev, PTR_ERR(data->client2),
 				     "i2c device for second chip address failed\n");
@@ -294,10 +288,6 @@ static int veml6070_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev, veml6070_i2c_unreg, data);
-	if (ret < 0)
-		return ret;
-
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 

---
base-commit: 66ba480978ce390e631e870b740a3406e3eb6b01
change-id: 20260326-veml6070-1489798087df

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

