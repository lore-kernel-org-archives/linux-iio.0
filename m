Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55393E0C7E
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178425; cv=none; b=gVi1NT29L28xSHecC2tRGPajge9ksGcpLEz39NexmJ3SciHtUopv65HDCjY+vUy3K/Yc2qpCEsDy0VEjcReSG38C4qzuxDD2rrT+DLXF43pqJrrIC/Ss1FPXV6SUR2qFFZFAMWw5R+5khPfkiT13lInEaNqvn/3uKeEqsos4cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178425; c=relaxed/simple;
	bh=g9nLY+gx35wywoJxTathLacco3bjnjE4rCh2YjS82u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWY8UkhMQAt5o7iyo5UsOUbrd0XZfNR+Fy9kvBIYGGMraesu0fCtYHPhlgOazjE0sGXg37kUFLHbUtNweTqcMJwKYAyT2hx2gzgL4DFAv01nnXEBEPpjm6IHKmqLGBnDQ9J6tP9JjdJD0CbQkpweKdgWLgT6mKzME+3HfG5gBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=i+dKyMue; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="i+dKyMue"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ad135063so24582545e9.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779178422; x=1779783222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0N3CN1rW1qGUulc4D6QPIeOttKI9scgeLJb1ELVOCY=;
        b=i+dKyMue9tydcMl0vfeTvlLJ8249tayt3sYTzqWNxCEZAnbTgocVqy8FYpVoO9uq/P
         eCX5R8weyFNC3EmhCWAThjM9Scom8quGY4ELvxYUOaX0zhp7G4fGmUuIA0GTUWQfHUMP
         qibDJ1kHZ3A2wwV53kcaL8f0dwejxtFaiWXc4sL6l09lkEfObvihyu8c0PWXSF4Rd1Ts
         +wHRIBfiMkUbx5s7HB1xpV2AOmkmoD3qPDI+TBHvryZ/2XY9vUzhDCCVqKn9e/5hDNXG
         tDS+uEMh2KO52TiiBl7jio+5FobdG/7z2J1xIcvYBcEjdB4woVCiyyAffifWHuZcPf9E
         J6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178422; x=1779783222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0N3CN1rW1qGUulc4D6QPIeOttKI9scgeLJb1ELVOCY=;
        b=hNrpj1967cd/Ak7qXP0IqArZoWdz/4//oJqaEoFbl+HNu2XjhIwQ6aWUiDzG9Ub4Ik
         84FjmTKGGB5PYPy9cNHn4VzmOhv7f5WW9AGUog2FRLoIDKWGBRWcrzTl7btyEKEin6Eh
         JusXWzZfeeuq/ykJ6swMxR6PA3R4ZEgtWAfebXREMxYnkP3Zv7PWeEXhlGb+GxY7tozD
         Ev/pXbGnBbDfUH1cZ2BC0gLFAAYkdCNPwc+0rHwuHNn/sShoo0IJvTRkJ3f3W2jcLvOn
         IgRk3Qfi8cHRVcfm6qbRDDvnc3k3JNSc7nSpfmDbYK8ptMVJvCZSYJo0brQSoH1NTYcz
         IA1g==
X-Forwarded-Encrypted: i=1; AFNElJ+gKlZegLiz35gxsTZHccfLQH/Pazj0d7DZ5gzjArClo4P/Nua/0kYg4RUyswtm99V/UYxSgxVBsOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Od4GFdmGXQN9p0T05LCJZ/BiAFlR+HN9SIshJqijfYrk+F/s
	0dXNUKoG/t6QuHdmKUPua0J6MiNfhonBuq+2DCUePSd56PC4bS0k0IdiZkfFH1+rqaI=
X-Gm-Gg: Acq92OFtFTYL2qka7wrfy77kVWo0vPplXMI0eF+kEATrXy1JD4ltN2Y9/wvUoBTznho
	H4CgmmrDMqqPWiaR21xr7arqfvStkHexvwjuKa6GtkwLCkcPv2HRlt8+kVyoBr4Ut4lulgksfUU
	NSeszQBnegB8E+oPMl6r/rdHeGwojx47vvQfQ8GdPoqYcPH7Gzn+dLHa00k6gJbiJ+3LahUuZTA
	daRcWcdPNFD2iv6Sgpc2sBSL1dbLo0+4ri3qkyfjO/pAIxbpR5+DlonFvIIIkMjlHmt8cBdFuMq
	9hQ3iYaxBfMG1EQYbPJo2hN9AmxcjN4ML7OmLWCHU7TbOgsi9plTIcvViFRDtU30RBcQ9Twz43V
	UycWdHpKAglFKvRcSliAm/YZK8bg+y/p/9/DLV6xa+WX0Et5V7v39W3rL1aslz47Y+nCsjNR8vH
	XmSL6xw3fjwpzRDrduAlLw4h3WXX30QlwhqJNdfdyzawENaXvyAlsqsHkvgUuahyL3f3ldenPTH
	YofcbCM6dPMSBM=
X-Received: by 2002:a05:600c:3e11:b0:48f:e230:c3fb with SMTP id 5b1f17b1804b1-48fe6626a8emr287480865e9.33.1779178422272;
        Tue, 19 May 2026 01:13:42 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe53ab6aasm332858535e9.2.2026.05.19.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] iio: dac: max5821: Drop unused i2c driver data
Date: Tue, 19 May 2026 10:13:06 +0200
Message-ID:  <5feaecf87460a13d389f7b524a12f908e410143e.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=g9nLY+gx35wywoJxTathLacco3bjnjE4rCh2YjS82u4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDBuia+WECkoPhv/leZ75pMoZV5Z2rVv72nsDT qKuWDv8FJiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagwbogAKCRCPgPtYfRL+ TpN6CACXouIfK/IOMZOQYyi+DgJoSziPEWh3EJtZp/G5eX8eLco//oYgdcoaRXSI5hqRhMizvcw y4l7VxWKxJS2M/+ySCo+hd0EwOTnRxl5wFQUkbL3Bpxvp8z3IlS3nZAUXbkExSMJ8FrlDxE/z/f BkDda9j3uC0UzQLWl0Bxq2xlFO1cZpwpYpgshZCK5K1NRUMm5+YSlW8G3gzHP+AE+aRzqF2t1rx cP+/m+AVMP4QOK0OQiP6KJ9OmaSKWg6naKbZek3hPtQBIY+vXfsnJ/J0BQ8oBGnpNlWFH3jUSMI TdTgxwcfIpwobHq5B5J9tz2fxOx/uQdY5XhJC2f5Eo6Qyxws
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the single i2c_device_id array entry is
unused in the driver. Drop it and also the then unused definition.

While at it, convert the i2c_device_id array to a better readable named
initializer.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/dac/max5821.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index e7e29359f8fe..f3ebbdff5487 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -26,10 +26,6 @@
 #define MAX5821_EXTENDED_DAC_A			0x04
 #define MAX5821_EXTENDED_DAC_B			0x08
 
-enum max5821_device_ids {
-	ID_MAX5821,
-};
-
 struct max5821_data {
 	struct i2c_client	*client;
 	unsigned short		vref_mv;
@@ -332,7 +328,7 @@ static int max5821_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max5821_id[] = {
-	{ "max5821", ID_MAX5821 },
+	{ .name = "max5821" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max5821_id);
-- 
2.47.3

