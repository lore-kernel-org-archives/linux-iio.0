Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA73CEBAC
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921557; cv=none; b=PpSIG+zwEXwWMnOT7M4xgFnZwSM+sJHLJWF/+ek5q52pREyBk/C5AxIgeiJm2A7rtc32W5qUljcrXGgFmn8zmR0TQXm0JOycBDYinICKTsqG2FU3j6JlUVtSO16neAV7TB0CkRGRrMEoxnIGgxbpf54wneJHomhfRKrkkvWPiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921557; c=relaxed/simple;
	bh=fwyYVczkGGhNbbtuDw6wb0iPQK79Hav8hEBxFnyoihs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pv7qW+h7cp2sFv3e8En+oJDpPQlJbtsWaw1k7GcrlenaRoj9ajmEckymM5+76tKwcC/VbS1XOl9btpFhTv9+b/LgGoTt9oUPBpumPwNeNisvnK4Opjl6t2GiTDh6tp9C9M9MSnBU/RxBkRULYOEeesh3RwjN+esJLz8sos6zRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ+p+LcP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ+p+LcP"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b976536806cso122505166b.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921551; x=1774526351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5lDxPgHMLUWf4KOAgcF/BaGDb9kL4QT6S8GOy/ie+w=;
        b=KJ+p+LcPAg6rX4yzoY8TJmHJ6WFt4qPQuZi50EsAg4tC6I/tiap+lBopao4J5I0hBB
         30HNCZoDi35A/yyPYWSqXkgdGXHccs+Sp06tub5I0Wh2Z9ZpFKHa6/Ichi5NFJKL9aFl
         Tv50VE1zLX1tPmY8jVcsXRZ5/YhCVqIkxUgfGnTHfYhXgNLb9WnehyeKBqiCWyyc6Elb
         uTajEnR85h8uJXZeDYaGo1EapgZZSSl/6DRmkscE2NTPclDG0ZEouL6vr8SXfC3q0C6f
         HjNwttD4NXBmWYdCzKz9rmfRvMyRYVLCwvUxNE1AfoWOBEulgm7frtrZtKJAy2ea6P1j
         bEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921551; x=1774526351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l5lDxPgHMLUWf4KOAgcF/BaGDb9kL4QT6S8GOy/ie+w=;
        b=ifWjpw8aVV7k9YVHpvaQHMcdh7S2r5GjrMR1HcjY0IByaDudTQNLYRwamXMqGqhuiG
         mDUh+JYwabxf47TSyud1V5g4o5lQJJpj5/HNCu6CtVmfhZYUtEGi/Wk//QulsrxhZY3W
         /HKE4S7X8MGWD6MV04jWo5Bkusj9EEOfEIYZdo75j5VN+adbZ57l8/IS7tje3pj49wVr
         3OUVo9k7iuCMM9NnJmDVoxHV+TvQd62VM3527ifpKouB/JvximCvFVyLPWWVaRaYAN3/
         axCuaHZSZlqg84x5ofRtt7T6rjAa5JGI/ZenssNsB0/WX9tsfU4sppnOVQZe10LG/fCg
         ijdA==
X-Gm-Message-State: AOJu0Yz+aUCSBusUkJYl7iwdcnvTkbljSMuBuiRddGucqg6aE2qS0TZ5
	+EdVPmlRnPClv7cSsNC6Ume3QwHPfvEnf2boFXdMEGOvfR/VE6gsJoI6
X-Gm-Gg: ATEYQzy6ZK0Vds+F27iM95VXgQmMnBajzS4AJUDvoYpVsc1crELMXgYuisq/Ni1421P
	DQmRiajDXxlYZ2Nu3LE88KUughOrZj0nzTsRq/nPMCD5IvOoDUioCj2GOb16ElNAkkxkCM0PIfE
	w/jsy7puGv4Vx/H+ntTa9jXE8nEX97DbPO4gLszKzOhXkhK1dKNicNVrz4UxUQi1JoKrEFAuIsR
	OdU/ObVeyKTtMImq6//eCKpw+9tvGa6rQXNhuaXPJjc2smYomR1w3VM/tDPnJ9vay+NCJymUq67
	8X060aDrdY3aZLJ/okl1hl8FRRijUnFKO6M5X1iLT3ta1rV+5ZxuJbeZIiJ+mIPHYFTEMd011qw
	36eTwEUWijlzQ+OkGPzEtfU5WfZFY6/9vMwyeUyDqoob6T+8Q7gZ5ws1TGkEWPu1ofB9hIt1hAy
	yu51n/D3Yo54/dbytKhoI47X7+jw==
X-Received: by 2002:a17:907:869f:b0:b93:89cd:2bbc with SMTP id a640c23a62f3a-b97f4b83175mr487536366b.56.1773921550571;
        Thu, 19 Mar 2026 04:59:10 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:10 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 19 Mar 2026 13:58:41 +0200
Subject: [PATCH v5 3/8] iio: light: vcnl4000: move power enablement from
 init to probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vcnl4000-regulators-v5-3-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Given both vcnl4000_init and vcnl4200_init end with
dev->chip_spec->set_power_state(), they can be called once from the
probe to enable the sensors. Move the set_power_state function from init
and call it after init function in probe.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 939ff2d65105..287ccd89cfb2 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -280,7 +280,7 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 	data->rev = ret & 0xf;
 	data->al_scale = 250000;
 
-	return data->chip_spec->set_power_state(data, true);
+	return 0;
 };
 
 static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, bool en)
@@ -425,10 +425,6 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = data->chip_spec->set_power_state(data, true);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 };
 
@@ -2003,6 +1999,10 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = data->chip_spec->set_power_state(data, true);
+	if (ret)
+		return ret;
+
 	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 

-- 
2.53.0

