Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C113AA2D
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776545563; cv=none; b=VL1X10bxGs5gxftvnWn2k6NGfxxSkwxgvmApaxjsWlPuGqVB2NJg/42JT9eccWvvqGBW2qCe7TfyDXZEAfjOd5MEIZWMNMVzkp6Wx5eqQaM/CSMP6OflEOt9NL09+eJ33VB+sVEh1mdDSPHknMDrd8A3OVl1/IDSrguCORQ8RUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776545563; c=relaxed/simple;
	bh=k0zIWNiqztBu59uU8v9A+AuJtHZrCMC4C8GSIfOb1ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giX8YOvTdkaSpqz16IRPk/urqxNn/HQz1rc+0XKTyAqcIfLLNxG6QztyIJYkX6LvITIiuNW4F4s41Qc21/l70Hu6qLuqbOtL3sCNnX5uUgS9+W3Z3+8/0ZHIvtBKaecARcyLm9K/PYGl/a5TNYRXULO6gPpKncVIQo9CDTsr3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=wzMq0FZj; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="wzMq0FZj"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c726ef332so2062606c88.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 13:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776545559; x=1777150359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIvpHJfLdwXFNrcu0Iy1WHK173eb9+R/v0WGKHYF/h4=;
        b=wzMq0FZjLgW2uT9x3wJTePnS36Vp7vvmxos2Lgm4cpm/qYf/AjAsCVAPN15EUldOYT
         rXRbLs3BiJKOnwafOcN0Pr/JFGtukT+b9UeG8Y76FR7ORjZtIhEAOUNcyRWwhLz93Y+k
         MFpC1gDq7Vko7ebqYGXPWlbroKQLQ71NkmGJxOMUTTpOiGQ1AbdWE1gRcV9csUXU2lmD
         uLvCu8fHXLmXVIJrjjnE8cL9Rbwq9kZrNd/0qXNGzFnIbiGScjhr0L0IZ1HV8m0970bB
         djI9h0cy1ZySQZw7FiyjeMphHNPe3BksisX1PHoqdRD98OGLE/PpA1N5O7R8nOvBDMC+
         625A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776545559; x=1777150359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIvpHJfLdwXFNrcu0Iy1WHK173eb9+R/v0WGKHYF/h4=;
        b=XowmsEZ5Eys7l0lWxI2ZM8DcAmCv7TdpjEKbAMndPLpVp81Qb4qvBQoJxoXE5/4wYZ
         9w+if5s8tf/U6khGqf4mswKkgHBuwsnzZtFUzgrX5tfqf6FqQgXKM72/sMnmTXp1lHxc
         MDrBGFZgLifU520D1HUl6Neg4vxG1o2hyZ6EQGNcAxqKX9Fd8L7ktDepVGenwqkkwVKs
         m6EH41E5QlhunfOZRNJEb8G8lYKP0kx9/BkhL/tYXZxX/pmJU+AGqRMC5B2HZn33zdWB
         5jLCV8Oe3FWuxFINfyyIpDTCEgeGeYYCCJ4BIHrlGwxpd6P82YplT6YT8wrli/Ni8xLp
         IRzA==
X-Forwarded-Encrypted: i=1; AFNElJ/5JA4KxM8+Jz5E6UCpmDkyraDLXl4KNwHX1RsB+cRgOdpcFe8M2kKaASGlDblOkIRZ11xZqpiwD20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqHnGAGta9ViiLjW5Nz6nE0pYej16N09ihvtdB9eKo6rjQwuf
	LVnY0K1M1xE0HNCmCR6XGCOKfi2Ab24UMWDEF2e5zCcZY1DFtxn+cSTl1k5A8lYivBE=
X-Gm-Gg: AeBDieuCLvjCuz8rRFTmnOwNe6d9eAXSgmJR4w2DgKcZe7Qf4HPyhETtSTIeyC1N9KL
	cPLDXgXZJYfTzqWWPXFIePb0xcNfgN9GFu5BLSMc8KHOsI2k6MZKfS3BqaT5otOZbbmPOA9Y68+
	dUGkQVsd/XLPX9WtpDJQZdy5qoa9Y5fmH2hOuf48fNwkG4N3Eo6s6/FTiMMWTRNhuyA0HCAcYno
	OqV8UNgOx9itAe0fVofYWWCTmqkMXC7izNuhhtF0oL5SyEKMHrEDDKbLlkl8gEqpsslJeFlbBv/
	0OoeeJloM5x/eZs4LmZiQ5qOQnv1Zk28Mk/BReBNIHMqyCLcze6DoC86KT2ErbCaq89rbVuj3iL
	zRrawUHS6/vySwu3TUIktEr/2c6rp8mE07UJ9ooDsL7/QVR1IS2XYc6kr/GynPLD4WmhlICu78g
	YnBQAQ9q4e1y7YiAGwjRYarsi3dQQkkZsFUQ==
X-Received: by 2002:a05:7022:6b96:b0:12c:3d3c:ac08 with SMTP id a92af1059eb24-12c73f6d728mr3578783c88.4.1776545559119;
        Sat, 18 Apr 2026 13:52:39 -0700 (PDT)
Received: from fedora ([2804:14c:4c:af50:c408:26e5:33b0:662b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a64e5sm7634756eec.7.2026.04.18.13.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 13:52:38 -0700 (PDT)
From: Luiz Mugnaini <luizmugnaini@usp.br>
X-Google-Original-From: Luiz Mugnaini
To: cmo@melexis.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Luiz Mugnaini <luizmugnaini@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: temperature: mlx90614: use guard(mutex) for EEPROM access locking
Date: Sat, 18 Apr 2026 17:51:36 -0300
Message-ID: <20260418205151.172046-1-luizmugnaini@usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Mugnaini <luizmugnaini@usp.br>

Replace mutex_lock()/mutex_unlock() pairs with guard(mutex) from
cleanup.h for cleaner and safer mutex handling. The lock protects
EEPROM access across five call sites in mlx90614_read_raw(),
mlx90614_write_raw(), and mlx90614_sleep().

In all cases, the code between mutex_unlock() and the end of scope
is either trivial computation, a return statement, or a call to
mlx90614_power_put() (which only schedules a deferred autosuspend
via pm_runtime_put_autosuspend()). The slightly extended lock scope
is negligible compared to the existing hold times, which include
EEPROM write cycles with 40ms sleeps.

Signed-off-by: Luiz Mugnaini <luizmugnaini@usp.br>
---
 drivers/iio/temperature/mlx90614.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 1ad21b73e..adf100756 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
@@ -296,10 +297,9 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 		ret = i2c_smbus_read_word_data(data->client,
 					       chip_info->op_eeprom_emissivity);
-		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
 		if (ret < 0)
@@ -319,10 +319,9 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 		ret = i2c_smbus_read_word_data(data->client,
 					       chip_info->op_eeprom_config1);
-		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
 		if (ret < 0)
@@ -358,10 +357,9 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 		ret = mlx90614_write_word(data->client,
 					  chip_info->op_eeprom_emissivity, val);
-		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
 		return ret;
@@ -373,10 +371,9 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 		ret = mlx90614_iir_search(data->client,
 					  val * 100 + val2 / 10000);
-		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
 		return ret;
@@ -476,12 +473,11 @@ static int mlx90614_sleep(struct mlx90614_data *data)
 
 	dev_dbg(&data->client->dev, "Requesting sleep");
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
 			     data->client->flags | I2C_CLIENT_PEC,
 			     I2C_SMBUS_WRITE, chip_info->op_sleep,
 			     I2C_SMBUS_BYTE, NULL);
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
-- 
2.53.0

