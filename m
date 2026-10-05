Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D749AA27
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208975; cv=none; b=N22GzQq3a5RAty8MJ5XkaGIWFwj/rNuZkLluSmMU2J6jrGWw3jleNTSbECLlctOL48JpF8BKNumdGusX6ckX95qn255PYLJPU7yTF2+jcjlkzX2zjr7NtCs3nXEgMSUxb2YqnecSsp4CMKvFCyhTNxhfq+E1kAOJAgeeBviQCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208975; c=relaxed/simple;
	bh=6BdH2DmECxn5RVbaRfc35a1Andd/jBcjhBXvCAbTGho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ER71q5SQI/9jCEjLKnkazvWsvtF0MClwO8xFwBOWLXrBCnAyJGAOEhpH8Wg39biweu/aTlU9pQJ11kbbq6PZSBQ2gtXGR28P4cA1x9iMOMEjrKiqj/+ZMOCt025AcRRZWd15MDXdPPaVYLYLrm6N9CHQ7OkT51k/rBAeNEk+20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=cJrPuHF3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="cJrPuHF3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a16bc7ad39so3526105e9.1
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208971; x=1791813771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUMSfbsCnH/BInoo0tCk5M5zTEx1U8KIJDTvTDSsJzg=;
        b=cJrPuHF3oCZzzYNmgKBl8uWxUNvWjrvN4QoPhDZzhMEfGHbMiqeGo8fSewpP7zZ02k
         aHfDdmXd8nUokWrah5wVit/eaq97edqobVaibIaqwHhEYLdISQufIwvaTC6Wdy1CoLT3
         LL5Mg4luj4KCMhNRa8YY4UE82V7OPuMhgsoFT6U48xRcSX/y5MJABTEhT+Vb8swanO4W
         ZDqbKxuX0G8t1zpVk6YJEzIDmuYhiyw8XJ4xO+FOzrp2+YkSmuIjH/3FcOij25+MrUCX
         LKDVxdLqn9AgSLorxOEoDybu+oT1Wsmm2N9LPqI1CQ4X/nXyJDraeYVaAkwZlopNiADf
         Dtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208971; x=1791813771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUMSfbsCnH/BInoo0tCk5M5zTEx1U8KIJDTvTDSsJzg=;
        b=Z3c/rDJwCPW64VQZsFvXOFGuCjp5FXFVkO1amwNpIRFZ+/ATttmi99Sh26qNi1JpVx
         XLU3yXc3OePIA97UxwXzACjPzYRM71uiwL+fl8A/uEh4MA5ISBNhJU75hqHrepMrQiA1
         toOJx8vVMp6a6wPfoPe03MLufVzvspJyPJ0WvX9IYlMq/WaqfTKJiT5/FZDsDSXSwWEh
         G9v0qV5RJgN1Dw2Xb61IYtmOYniVs8qB6RasRM9Ik6hsdibuaiQ/6qq+1HN3fTHO5lcW
         ZzVnuzjQL1+iRC02hnDVfOCN6JOOweIdKreeXzPMf0rWE7NMMa6sLEWLRNuzGW3sfH72
         OXoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwl3AqP5NFH9DMrnm6WEd8McM90plryW3O4d0R3T3oMlMSs2Q1Ok6Uop2btyUKW8iNUxUV2w6eYsz4=@vger.kernel.org
X-Gm-Message-State: AFuF++kZkIeQ2VUK5lHOJYa8DheHBIuAF1uI+TCiwpgflozMb8J5t+MQ
	nezDexz1LJxaXwqLqWIyB3cQoFTLDMi3YxYDb+5qlgca93qC8THwBU27egbv3pqWmS8=
X-Gm-Gg: AYBFou3pY0QhIywQaC4ZhGxrpgiISfnLrRpBREYUYotGqsAosXskmg55TPbI9CcytyN
	IJR0r3B5u+igslsAdvjUSf2A+EjTWYAXZD81fyF0dcY2xbJCpTbr3r8d8HCv7L0YnhHTkn3gMTN
	cLveT/8I1vmqhdlk++qFWbWiJJQz9YSpP3xiQryrjIZz5YhAXztKxP4RQlsi9npaQoen8Jtm+5G
	DctKCpI8SpzlA62UddZpFsQltleJtuXVKs+hmHu6pOA9YVcCIiz7LipiApkhADUwdvLuXUKdGWz
	Q/YGGC7t9tyVKbzymJECvXY7Ov5IqEz8TbLoIwmPZcuHEY1HQ3tYVMChTRQOEgdpq4nBT2fg12c
	WWT7Itln5VWqBGsn3p+IFl/RGydlyeT/zIB2sfU2LscMCTh9Q/pTyhGy1TqOOD+EeT4HZpuptV5
	Qw74ntOPxsz7Huz0LxhCWFhqj8YvqARFISRcXuKZHbzZEsJk9IVticyHqt5I3Y6y51glwIJCx7b
	i6NS/wuU+RUSuKffYAW2Iy8
X-Received: by 2002:a05:600c:190d:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a02753fc8emr186953205e9.8.1791208970558;
        Mon, 05 Oct 2026 07:02:50 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:49 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:02:03 +0100
Subject: [PATCH 07/12] iio: light: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-7-2796f713945a@thegoodpenguin.co.uk>
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
In-Reply-To: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, Eddie James <eajames@linux.ibm.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=6651;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=6BdH2DmECxn5RVbaRfc35a1Andd/jBcjhBXvCAbTGho=;
 b=8wCMSmEnlrOS4daOOmuhGD0G9PEjg+ELM9v8FpIHywsoIXYaU9lkRzSi6Jiuf2dBXLcVs975h
 719ckEEpC5JBlIW1eoTnyYbYkzoJWbX4rHf8yHT8p7Axf+7hKxNUr5P
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/light/acpi-als.c   | 2 +-
 drivers/iio/light/al3320a.c    | 2 +-
 drivers/iio/light/apds9960.c   | 2 +-
 drivers/iio/light/cm32181.c    | 2 +-
 drivers/iio/light/isl29018.c   | 6 +++---
 drivers/iio/light/jsa1212.c    | 2 +-
 drivers/iio/light/ltr501.c     | 4 ++--
 drivers/iio/light/max44000.c   | 2 +-
 drivers/iio/light/pa12203001.c | 2 +-
 drivers/iio/light/rpr0521.c    | 2 +-
 drivers/iio/light/stk3310.c    | 6 +++---
 drivers/iio/light/us5182d.c    | 2 +-
 12 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 1983a7f17aa9..9faaffb94b8f 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -238,7 +238,7 @@ static void acpi_als_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
-	{"ACPI0008", 0},
+	{ .id = "ACPI0008" },
 	{ }
 };
 
diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 8bb7f7e878c2..1610a09ee204 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -259,7 +259,7 @@ static const struct of_device_id al3320a_of_match[] = {
 MODULE_DEVICE_TABLE(of, al3320a_of_match);
 
 static const struct acpi_device_id al3320a_acpi_match[] = {
-	{"CALS0001"},
+	{ .id = "CALS0001" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index afe520de60e2..996ab9a9ee27 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1158,7 +1158,7 @@ static const struct i2c_device_id apds9960_id[] = {
 MODULE_DEVICE_TABLE(i2c, apds9960_id);
 
 static const struct acpi_device_id apds9960_acpi_match[] = {
-	{ "MSHW0184" },
+	{ .id = "MSHW0184" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, apds9960_acpi_match);
diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index b32a94028f09..8b376e5a9f08 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -527,7 +527,7 @@ MODULE_DEVICE_TABLE(of, cm32181_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cm32181_acpi_match[] = {
-	{ "CPLM3218", 0 },
+	{ .id = "CPLM3218" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cm32181_acpi_match);
diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 759cb71ed1c5..3463da0f7a98 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -820,9 +820,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend,
 				isl29018_resume);
 
 static const struct acpi_device_id isl29018_acpi_match[] = {
-	{"ISL29018", isl29018},
-	{"ISL29023", isl29023},
-	{"ISL29035", isl29035},
+	{ .id = "ISL29018", .driver_data = isl29018 },
+	{ .id = "ISL29023", .driver_data = isl29023 },
+	{ .id = "ISL29035", .driver_data = isl29035 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 038ee49723ae..8a08cc468872 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -421,7 +421,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend,
 				jsa1212_resume);
 
 static const struct acpi_device_id jsa1212_acpi_match[] = {
-	{"JSA1212", 0},
+	{ .id = "JSA1212" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, jsa1212_acpi_match);
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index fa0d16890c8b..5d2d020ddbc0 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1589,9 +1589,9 @@ static int ltr501_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
-	{ "LTER0301", ltr301 },
+	{ .id = "LTER0301", .driver_data = ltr301 },
 	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
-	{ "LTER0303", ltr303 },
+	{ .id = "LTER0303", .driver_data = ltr303 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 8c344f1b3fe2..2d25bdcfe5ae 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -603,7 +603,7 @@ static const struct i2c_device_id max44000_id[] = {
 MODULE_DEVICE_TABLE(i2c, max44000_id);
 
 static const struct acpi_device_id max44000_acpi_match[] = {
-	{"MAX44000", 0},
+	{ .id = "MAX44000" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, max44000_acpi_match);
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index c0f4db8d95f7..657ba24def38 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -450,7 +450,7 @@ static const struct dev_pm_ops pa12203001_pm_ops = {
 };
 
 static const struct acpi_device_id pa12203001_acpi_match[] = {
-	{ "TXCPA122", 0 },
+	{ .id = "TXCPA122" },
 	{ }
 };
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 7d82efc31f3a..b429c7b8b0fb 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -1095,7 +1095,7 @@ static const struct dev_pm_ops rpr0521_pm_ops = {
 };
 
 static const struct acpi_device_id rpr0521_acpi_match[] = {
-	{"RPR0521", 0},
+	{ .id = "RPR0521" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, rpr0521_acpi_match);
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 7c8a1d2b2ed0..37ae90c84779 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -775,9 +775,9 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
 
 static const struct acpi_device_id stk3310_acpi_id[] = {
-	{"STK3013", 0},
-	{"STK3310", 0},
-	{"STK3311", 0},
+	{ .id = "STK3013" },
+	{ .id = "STK3310" },
+	{ .id = "STK3311" },
 	{ }
 };
 
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index ab518311fd79..5d05c751e13f 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -941,7 +941,7 @@ static const struct dev_pm_ops us5182d_pm_ops = {
 };
 
 static const struct acpi_device_id us5182d_acpi_match[] = {
-	{ "USD5182", 0 },
+	{ .id = "USD5182" },
 	{ }
 };
 

-- 
2.53.0

