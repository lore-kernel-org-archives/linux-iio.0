Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261B3E1218
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025157; cv=none; b=Y2BQjNOk22bXEJZi03aDk9nZtXFMmTzaSJK0J5+YdC86TsNaK5+C8ZblJQZQ7I459F/42oD74+k1V4PPdWFFzANKsu2MWyyXzg5+azBwYK9pJcOw3iYb6J3s2fRLLM/SRco5sccGB/dem+wWgkk/qiyHBpThLguH/QJU1LNoepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025157; c=relaxed/simple;
	bh=TzB0TDBcyModHlhscKkRyhu+DntXkSWYAGvIUGrcGVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFt5dOZmAbYixgzH+g1iePbJzf1nMuUqu1qFXx6kY51/8zVFK64SrdW6fqXLfJ97RK1zRdF9ogJ5JOOt6oOw3OoUMeoEKL0M89T1nCwxoSiW9Qq7BvzvaCtNkxkQDGi2jK4T30eFtKOmXhjs+bQCQO217wZ9StEhxwTba6qI1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlUWndON; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlUWndON"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b980785a0bfso333294066b.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025153; x=1774629953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUcQHeprPMeRllf18ooNN99GRIW3qgL3Mo3SFM1oI1s=;
        b=YlUWndONzOoH252UuKR4mPrWecWzZbY3hEXU3k4sXXZk6zyzicZPwNbhM3fvPZO0ER
         t0qt0VnOpFRqKPjMxftLTD+UEwncaZjI3m938uV1P9wiDmQv5+cY0V9rhR9cGTUPyRwy
         ei7C6/i/Sng9dWcvH9ASMfBkRjMllw3TKyVYAbrtVzHGhWXsCk904zNxfkQz9r7zB/fd
         aVd5Olcm/wAWqAD8EL0FYaERCfN9IVBGQVBdS+wzUwFXpIUar/a/xz8mdtUFBpbR4v5r
         xATi+IGhyt96biURW19ijTc2SaDiZp/MdSwjIgHcBbaEo+1peQoynkzXiv7OFwto8C2R
         V//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025153; x=1774629953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WUcQHeprPMeRllf18ooNN99GRIW3qgL3Mo3SFM1oI1s=;
        b=OvF7zwNO89W9tJfeX86Fj4SJJK02ycUJf0swgvFk+vhlrOtBGBH5zMbDVCC5LCFjEB
         zdq70URBvjDwP5Jlh1kycL/7XryazWDn4BjfeWBU+YaObeuezWPrNq8T483u/MqzcZ74
         3kVdoxQdltAQwb1SJe9i43eG0Y8rW/558Bo7sTqRIZm99cqE0QtH7v1yn8Q38mSCto2S
         qu8peEnwKuh7v8WGP6nSpAI0hrZ+bB3OiAoEFMx5ve20vvkE8hg8DInpGOavQsu2XAGn
         jlQK/oJWKwZ7HuwZjXeKEqPlACgOTnMKAZyKtJLdeT1s0pu7CIdJXMEEdNOjVeRx97uT
         kXNA==
X-Gm-Message-State: AOJu0YyRBY+f2OTbi4dYctZRpQiqCFU6P4dLgmdQd1fxiz9PUR6WDRn0
	gCfubSfmcf01317JkoItCwXxCqzmHh5NGewHfbZppu7d1w/S0vlmjIxo
X-Gm-Gg: ATEYQzycREa01t1DFfiN7tWxyxqC88RwATwmbE+LVeIchQ7BTQe4yffGEYyF0Vure/X
	AHrexmNpR27IMXdtadcso9OSkt7N6h5kMZzPT4d2qauAE//Afppdtg7NwYHtBPvCVcDiR5ApZqf
	J2TVL0CWFccTrIvtOwfLRoNTPwN6wEXCjNqxHTHAIBS5UAwV+djBq0yRKSVZg+EouwzGYALGYcS
	NMkBk9u/0NkWQr8hK50hFicwJfJEU/v3PfrZItm8GtBggIWZyd7AIoKm2t1xRI7QRcTUaZmXk6e
	WDxAS1x22Tq0YrjJKIBWG9hFmSxSW3TN6TRukeWdqUevjzgJzbUHYpm0wn9y/OImNktv2FQv/Gm
	skwVmj453fWst5MT3MgE2UBF3NBAFMggNPPj4PkU3AaM7McfQx82t0QMUiEC7GX3ymv+tkV9tCo
	cIfmtdFF8QLj9tl3tkOCrnl/cjdmPQZcwfiyo5
X-Received: by 2002:a17:906:2092:b0:b96:eb74:3152 with SMTP id a640c23a62f3a-b982f21d50dmr180531966b.22.1774025153243;
        Fri, 20 Mar 2026 09:45:53 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335f1747sm176730466b.33.2026.03.20.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:52 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 20 Mar 2026 18:45:43 +0200
Subject: [PATCH v6 8/8] iio: light: vcnl4000: add support for regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-vcnl4000-regulators-v6-8-0d24d20b1a5b@gmail.com>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
In-Reply-To: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>, 
 Raymond Hackley <raymondhackley@protonmail.com>
X-Mailer: b4 0.14.3

Add supply, I2C and cathode voltage regulators to the sensor and enable
them. This keeps the sensor powered on even after its only supply shared
by another device shuts down.

Reported-by: Raymond Hackley <raymondhackley@protonmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 0a4d82679cfe..9650dbc41f2b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
@@ -1985,6 +1986,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const char * const regulator_names[] = { "vdd", "vio", "vled" };
 	struct device *dev = &client->dev;
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
@@ -2000,6 +2002,11 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return ret;
+
 	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
 	if (ret)
 		return ret;

-- 
2.53.0

