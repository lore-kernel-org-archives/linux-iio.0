Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C54FDA41;
	Fri, 18 Sep 2026 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738892; cv=none; b=htu2oOZrjtMRuT+HY7LmFLI5DLAGjvMwZYXiEu9dNfyBN11Mmm/ZXVhdbcCvfld2R/2GUP0Bk7xZNyaSbpU5Iq290COfw+rSE1PlJxG/XFK29yBJ9lmKgDgmpbJgdRCg0nh9exjtTmcXd8ChTeTfad/tv+7gp0bEUM5VIHMlLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738892; c=relaxed/simple;
	bh=S0+TGh/h4+UFW61/vihct0C5r6oNSK0lqI/qa/nC41I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxQwKt/WU0dqwQnbrh9YF4KMBs4VrXXcci+dgmSVJGDJBb/gWv94ZwrfnFDrePJiD/tFGAEAVN5KGZjYWkRXK6M6KpG/Vup+iwDWHP9mw0WvWe34NcIDi5RkgT5XKtWjxjC8EzpgGPD9zJ+KVvrO1a5YzKqz5oGT6Xkdxcbekro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Uq8cJlCC; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Uq8cJlCC"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68IDf76a029543-68IDf76c029543
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Sep 2026 16:41:07 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x7Ypv-007Nmd-7o;
	Fri, 18 Sep 2026 16:41:07 +0300
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 16:41:06 +0300
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH 3/3] iio: chemical: sgp40: Implement turn_heater_off-command
Date: Fri, 18 Sep 2026 16:40:19 +0300
Message-ID: <20260918134019.1101308-4-jmatko@utu.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918134019.1101308-1-jmatko@utu.fi>
References: <20260918134019.1101308-1-jmatko@utu.fi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgJAygB
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=SXpp521fGMKCupgRYWcmk2dGLc+m9cXA26+JbieW7lE=;
 b=Uq8cJlCC40s/wHdr1btAie2yURRTxCkQd6Wnb1AP3dhXlfPqDC2XR5SdgY5Uka7fmmFVuHYPiVLZ
	HnCLONw/gJcZQZEjY20ZMz+tS6N2a8nj56baB+5TUZd3CwXOd6gMvjaK969ufJzVA9AGDRMMUn/9
	3DdQis2nBG412rDYsRIRBtKEYKO2KZcTzkYxzJN+xTBhRve7Jghb8xK2hkuZkJM5La9ABwJfhHlg
	dEt+7BPA2pxfKKG37Di4IR+1t0Lj99by0dCrh5V49Z7XN4XIb/8AdGBhQZpCLlu/yPjbKZ77/N+R
	4YYSuvc5WfNfbuUDC5Em4gsBvSp/fxuFcFXHtQ==

-Turn the heating element off and enter idle mode.
-Present the functionality as device attribute,
 'echo 1 > turn_heater_off'.

Saves approx. 2.5 mA compared to regular operation. The heating element
is automatically turned back on when measurement is performed.

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
 drivers/iio/chemical/sgp40.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index 28d5e737d1dc..a4fc5c778303 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -29,6 +29,7 @@
  * by writing to the out values of temp and humidityrelative.
  */
 
+#include "linux/device.h"
 #include <linux/delay.h>
 #include <linux/crc8.h>
 #include <linux/module.h>
@@ -259,6 +260,21 @@ static int sgp40_execute_self_test(struct sgp40_data *data)
 	}
 }
 
+static int sgp40_turn_heater_off(struct sgp40_data *data)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	struct sgp40_command turn_off = {.command = {0x36, 0x15}};
+
+	ret = i2c_master_send(client, (char*)&turn_off, sizeof(turn_off.command));
+	if (ret != sizeof(turn_off.command)) {
+		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeof(turn_off.command));
+		return -EIO;
+	}
+	msleep(1);
+	return 0;
+}
+
 static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
 {
 	int ret;
@@ -417,10 +433,22 @@ static ssize_t serial_number_show(struct device *dev,
 	return sysfs_emit_at(buf, 0, "%llu\n", data->serial_number);
 }
 
+static ssize_t turn_heater_off_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));
+	sgp40_turn_heater_off(data);
+
+	return len;
+}
+
 static IIO_DEVICE_ATTR_RO(serial_number, 0);
+static IIO_DEVICE_ATTR_WO(turn_heater_off, 0);
 
 static struct attribute *sgp40_attributes[] = {
 	&iio_dev_attr_serial_number.dev_attr.attr,
+	&iio_dev_attr_turn_heater_off.dev_attr.attr,
 	NULL
 };
 
-- 
2.55.0

