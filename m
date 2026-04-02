Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9DE30F7F8
	for <linux-iio@vger.kernel.org>; Thu,  2 Apr 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143057; cv=none; b=eber/++j6fc3pwie0PHQ7ML/mVfbzeJngbgNaYdUtt4AAoKOy5WUVFLdkiG4UfLuDN/Sn2SOBNZbNXcsBfK7DmplU4LNrrHCzVVQaCuZ/v0CXtReDG1tfx97plrLqavV53GJcMlxK5fIeR2IwSv3aS7ydt8T/N8UkK2sM0MjNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143057; c=relaxed/simple;
	bh=qqYIlX/ogMR1tiVGPxMuhx0CZ/IF8ISju/5h5Esyr1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLn+4po0rGDdJgYdAwKww/IX+TmzMEc4+2xZKU4LRvs5yuBzAHQwUxLV91rrALQUhsWHfgCGpfw9bSdgCp7jiDPIeuqRjZRW0bf71bcXF9jE6VUAMFyRiNTekZbizRStaKC/gCfyt9RFOixAh5MahHcyoSuWdVhL2/4XCNThC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW8jz0bm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW8jz0bm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso10106935e9.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Apr 2026 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775143054; x=1775747854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjcxZkjC7ao4lhP5f+c/QRvePzRlIefpoXPLd+zFiP8=;
        b=mW8jz0bmh1zLoXxZ0dPp2SCFixZPHKNDUEkBZ13cA01rttAILLKaLcdHm4OF4Y5ETu
         zxoOMEWUwg+y+UkfqWvbhPj78pTC4n2vjVptI72Qfhd4rikET4L0dEFF2E1rw+/zelrM
         SauNq3hGZUHD1Cywt0C8dFByAHG6grnMSgMb19zYdfwL1mWoN7KWCjR2TShR+RxDJAzn
         oMb9UPYEbH0FttryUY9peXcdrqioZ0E9lB61WNxYKsuD0odqvke3mSEH/Es4H/h5F28n
         yVWJ4iWEKrTPVq+I1ngj0NWC5+DXLCu6bRQAWmff2s0UybTmLh/x9hEUrz/EV/cj3/PJ
         XQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143054; x=1775747854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjcxZkjC7ao4lhP5f+c/QRvePzRlIefpoXPLd+zFiP8=;
        b=lSUJL/TeBVvR2+l7JmskVhWIy/XzbmYudAOlNP8QUevbYbhmFFpBEg1V8LXSiXsuxT
         GUDs/ASUgr2uOaZtHRyzNgLt+xPVVOtWZMGbV0nLM00Tf5JmaaEUB54Ui5pqxDWqIaC2
         HtpeHWIpsCxWPNtQfZa0w+awiUjdc1HC7cZ4fCHw7hr8JqxzPBV/X6rc4UiIMs6Ks2Tf
         HGyHAXSw/poH6840uCBCRT5aJ7006Rny0cj90I7EsUS6RJR0b6x/Kp7hobDStCG+gF7F
         Y9BQGapW/0/XbGZSUF5RStbSL9QDUAMXPh+xM8HVRsMzkQFB/wMJVQA8sFajvWOV54Z+
         Y+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWxt57QdxhVGabVfkhPsCfo3zhVwUjLDaSBukZFsGQyRXGZf26tdkNhFKvxvwMmQMoQmOtO//0jY1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPI/o4kk7NIvGTj+HIQAPfnqbdh4gD1O9C8GvrDiHWTU+CZ/eM
	lTTCIvq4S+xeTvqa1qUIpK/Ng3GuTZfefUDfKTiw+f3uEoFXye1mOT5b
X-Gm-Gg: ATEYQzzfdPNOeYxY7zxxFNmRYl9IQVuovoyky+3ICr+aFT85VE6R8FTYnn73vfEPNK/
	SznujhUsnwYQ4JU0J7LHqXXNW75Jxx048l1RgCRA2CqaxkSJ5YJrGTxSLQ8o2TBxd+COk1UfHFo
	QgPxR2tI0Wu1Oa4oM95JhJaDPN04mjZyqi4ZdIWThaBm1wDd0NqwbqGdBvZ0H47RuaSggM6Ymfq
	SEOFtA7SFgRPWun0uPGXnMMZVGr21N8D8YkOaDblqvnwNyygam+F7iHDHXFGyp2tcjb0ndCEFyc
	opqRilFWkMXYLPuABCfkL3xbVrAt8mK3eFiVaZ9A2lDJUiYssICbRNQEsM59U0wBBwilDbjfVG5
	hxYenkgPd8sZIm79uIz093YjGBPnquYFCAybVM8N0PVACZj4pkCUnBJqUuggLSu1fcRYjJET5gJ
	Hf/pSESO5h4Cq7ZUky/FubpFpiTJbSzmHWk6MVii9DGcrRUAVbD58z
X-Received: by 2002:a05:600c:34c1:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-4888359dc50mr132126455e9.24.1775143054090;
        Thu, 02 Apr 2026 08:17:34 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm327405075e9.2.2026.04.02.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:17:33 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 1/2] iio: light: cm3323: fix reg_conf not being initialized correctly
Date: Thu,  2 Apr 2026 17:17:29 +0200
Message-ID: <20260402151730.18901-2-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402151730.18901-1-aldocontelk@gmail.com>
References: <20260402151730.18901-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code stores the return value of i2c_smbus_write_word_data()
in data->reg_conf; however, this value represents the result
of the write operation and not the value actually written to
the configuration register. This meant that the contents of
data->reg_conf did not truly reflect the contents
of the hardware register.

Instead, save the value of the register before the write
and use this value in the I2C write.

The bug was found by code inspection: i2c_smbus_write_word_data()
returns 0 on success, not the value written to the register.

Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
kernel. Before loading the driver , the configuration register 0x00
CM3323_CMD_CONF was populated with 0x0030 using
i2cset -y 11 0x10 0x00 0x0030 w, encoding an integration time of 320ms
in bits[6:4].

Due to the error into the initialization of data->reg_conf in
cm3323_init(), the print of integration_time returns 0.040000
instead of the expected 0.320000. This happens because the read of the
integration_time depends on cm3323_get_it_bits() that is based on the
value of data->reg_conf, which is erroneously set to 0.

With this fix applied, data->reg_conf correctly saves 0x0030 after init
and the successive integration_time reports 0.320000 as expected.

Fixes: 8b0544263761 ("iio: light: Add support for Capella CM3323 color sensor")
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/cm3323.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 79ad6e2209ca..0fe61b8a7029 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -89,15 +89,14 @@ static int cm3323_init(struct iio_dev *indio_dev)
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
+	data->reg_conf = ret;
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
+	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_conf\n");
 		return ret;
 	}
 
-	data->reg_conf = ret;
-
 	return 0;
 }
 
-- 
2.53.0

