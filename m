Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7606236A73
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608423; cv=none; b=o7XWKrPTXUp7V1lsWKwDlDAUtcabTWg0t7sIqdQdv7qm3B+bF1unTYMfUOpYdNV60JIntibB7IhAhEQ8vAZPIwV03kYgb7AQ+fSG3/7lQWXiA/bMQXbRBJ9Cl8ly0VwKA+XQKz/MQvAAPzDKxDm3p5D6lJ22aIjBJXzfcW8NTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608423; c=relaxed/simple;
	bh=VzX6g3lIajNovlrTefHtsXrHHczuBrvgOnSyCfqNkC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYI78Px8fTqzcqHGtONFUXeFyiHk1aoLhEHZT3sxY6ov/DSjcisxG7bvLrpCXa0M3Hu1gilUjzzJMOw0Q6DNC1fN/sD9V6kFIgWhubrTf46z7o+ZZh0dJmrwyEq4x0SnwZh4PeaCTgUs11unW/abHpgY484vLSQNb8FTJmV/FpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD7/1WZa; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD7/1WZa"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba6737fafbso32520eec.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 19:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608423; x=1771213223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzi8pCQ8Ziy85qehusmKDlTJyyfVwuNngkRLpKcT0QY=;
        b=kD7/1WZa6QYal6IYD4L+n96w8jc37uKV/88UJ/EbR0kkBz40sb5qroFLwBJ5OA6vSv
         Co12k/4SvElzCQZPv0zp+qTTO7a+k6ehz/DjzIRs8c2NjdIjyB2Ae2gG+fuYNqnpGRDE
         2ASjXdbw7vIqSZsiNUV+rARYf+pfJpZcZkyLsUdsxCQ124a8kCW4a0zGFPz9Teqd4RyF
         LQEPQFlF6IZj99l2Nxp5Ha1womgZqW4ApxumJkcbOiqEzlLq/gaVL2D0wqvkBUXURnTD
         bRE3J3CPzfoAj0ivCzCuU5NpKaoxljo5q4NWAhv0/TgDQj1SUzR8Ejjc1SMZwlkwCOQ1
         YMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608423; x=1771213223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fzi8pCQ8Ziy85qehusmKDlTJyyfVwuNngkRLpKcT0QY=;
        b=kNxbL3Ww/cMb2Rj8eAa/jDm5wJ8VsqSZrx8rXu/Xm/2xUFd9lmuvUUGTjddYCtr2wH
         5qjk0UNrIK+7TQ3IBA+tQ+MkmNRLwI2jvj6FXsY7UdQJQpSXDiww/kVL5Bj3nd4EVagg
         3yZVe2iKKZcJyeDcn4Ishg5P7F8RIN0OPkk+ulshQGO0gUbW7oXK9KHt3n6rKeBwxG9B
         RncJfq3VkPmXo5Qu2Kk1VDC+sdsJZKJoVaMns+sVMka/mBE0W8Euv0zTZXylRr0KS4YT
         Wdjp8Fgn9zVL/wBzkVQ5gtgiCmuvULiNx31kQTmZ7AUd+r6WoG7cQlc93B7+74e+0NRZ
         MoZA==
X-Gm-Message-State: AOJu0Yz6DwfgYXAtAhWic/rgXgHp/yyuw1myZlrqlETcde+ODmmj/k9w
	jzWPREbCZGYF9Ts1kdFAhYNwat1dkNTFpM7ACFNU/zBegQQjW0nxsDSt
X-Gm-Gg: AZuq6aLYB+ZUmN80t/+r8dnQgWStCsnKvsFFDe1ko5UPzVDnpV46Dc1EKkYu1bLOMr+
	wJsxoEhUafj6AJyi7zl/SkYkDR8cVdaliZ5vclauRAnE/TysjqtF5/fM80fYkc0GNkJIMsaVclV
	QJjnawrG3X6jq4YjQBWheh5XwYqvv/CXqOHE+PFBlFMakTv1pDelqzldVZJ7b6NVLesENoa6qPm
	brV3CLqWnWWHJ6aPVuuyLYZ5OCg4nvvLnw5eFHGolg0p+UgxZZyvM8ZHrrMOEWDIvic7iAXekmY
	/E812ZRUAg8wkFXeh8RnkxOCPDF+FhtV++9jwvgxGGFWGSSBR/Pig2a4U2foUlCN778nHB7nGic
	Ccupq6cnCllHnyrmUk2OvMo+1YevHoI8du+Z41jPA5VdF2U42LZfORFk/xqbst/6U/fLsHHOUWC
	m1LRM6D47AfUk=
X-Received: by 2002:a05:7300:8812:b0:2ba:6978:2b0 with SMTP id 5a478bee46e88-2ba697806damr442444eec.4.1770608422761;
        Sun, 08 Feb 2026 19:40:22 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af5ca2sm7682073eec.8.2026.02.08.19.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:40:22 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Mon, 09 Feb 2026 11:37:06 +0800
Subject: [PATCH 5/5] iio: proximity: hx9023s: add ACPI support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-upstream-20260219-v1-5-2b4d74e309d1@gmail.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
In-Reply-To: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=VzX6g3lIajNovlrTefHtsXrHHczuBrvgOnSyCfqNkC4=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJmdYT9dhMrjVk4/Xr6ToV34eco7Bf5K48X6dZvEVd7du
 3XAvz6jo5SFQZCDQVZMkeXM6zes+aoP9wT/ds2AmcPKBDKEgYtTACbydSrD/4zGKpmdmyyzcncK
 pO9w9vrwLeCuq/98N5kzeVo+AaJPxRj+F83TW2Lst3Tq/gWR0zM5qq43/7SQqVGPjtutH3rY4It
 vBAA=
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Extend the hx9023s driver to support ACPI matching by adding TYHX9023
to the ACPI device ID table.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index b680b89956bd..6bf5a02c3615 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -8,6 +8,7 @@
  * http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
  */
 
+#include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
@@ -1106,7 +1107,7 @@ static int hx9023s_probe(struct i2c_client *client)
 
 	ret = hx9023s_property_get(data);
 	if (ret)
-		return dev_err_probe(dev, ret, "dts phase failed\n");
+		return dev_err_probe(dev, ret, "failed to get device properties\n");
 
 	ret = devm_regulator_get_enable(dev, "vdd");
 	if (ret)
@@ -1195,6 +1196,12 @@ static int hx9023s_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend,
 				hx9023s_resume);
 
+static const struct acpi_device_id hx9023s_acpi_match[] = {
+	{ "TYHX9023", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hx9023s_acpi_match);
+
 static const struct of_device_id hx9023s_of_match[] = {
 	{ .compatible = "tyhx,hx9023s" },
 	{ }
@@ -1210,6 +1217,7 @@ MODULE_DEVICE_TABLE(i2c, hx9023s_id);
 static struct i2c_driver hx9023s_driver = {
 	.driver = {
 		.name = "hx9023s",
+		.acpi_match_table = hx9023s_acpi_match,
 		.of_match_table = hx9023s_of_match,
 		.pm = &hx9023s_pm_ops,
 

-- 
2.43.0

