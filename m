Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FF3314B9
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824597; cv=none; b=SeUo5CeXsC1Q+Tn9BWYrsCAWJjLdvi650QFckzBIcBE1/JPXQnCWUyOL5llubm3loGMUxkyNW3UGwImbB4wtKx5FpXmZ6jHxt39KuM42wx/PEv2dRJ8lBrAGujh55g+61okD4kIPZU1KO0RU4fnbkfMBNDK/Ak9Le1hgvFDR+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824597; c=relaxed/simple;
	bh=wWQ4a+A4S2sKyZQzv/EKUwO1l4VSHkxljSr2StWN2s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/Sb+5ua1YmwlFlDdwayILU2GJZWQJW35St6mL1W0c/vgOjHYItyH6OPGwMiMz6X2eF5PC5u4iBuWs/KYhJfY7vN/INZtZyLNYqUzkDOcuelcyxmzfSYbtNvprOr6pLCViznyVR2inzCClIosKJDlewrAdBKhLAfXsLaTh5+Gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb/rozQn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb/rozQn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8453f568e84so1348067b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824594; x=1782429394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=325uk7GeAJdXi5OuOFCWJt9vatlUUqube94idLYZT9o=;
        b=mb/rozQnls0rDiqenWp3H+ADPaA4OcAx1sDkQ2k4tiGdCI/PgabIeNQMTuC4ykwyd4
         bfPyxfsrWn5iTjkpPkoz1z6WoKWaivyXtVM77J0MEQkOUikOXPYIVQqR6DHU/w9NPjJJ
         o2RFsgNHle4i1zAR9Rq5vIIuAV1sYG756yilBjrPzGmjwIsDnhhsbqDAsnmWG4SvCOiO
         LW5dw6OBzO9vGbCgsOGO2lWTVffh9aPnf8XKDXNJVcm+PQwOXvvAHHk0w5dk95KbI3/8
         xkPNoDtFP+Qv3kP1sg3cZEDgMitkRDvvb60Fhqy5GLUVm8OuypoKVguhzhXqy2MR4dZH
         KRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824594; x=1782429394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=325uk7GeAJdXi5OuOFCWJt9vatlUUqube94idLYZT9o=;
        b=aCA/3ougVtBIvHCRFe8vVIW0obK1FsS13Gt3bB/PTaIgfNemWtpjb9vxBU4Fe0JIal
         jOvRdwvGcgmP3cH1rLysqgFwcDwANtD34a5fkdH0dJSUatjFeNMfiG2YnAPFhx79NLdX
         FwA9cQjwuTTyNmVAccbPO3J9Wo+AjnbB4EpIDIDTexwSBjgzPxBKeB0mWBJYxPY1PypP
         5uOBhC9bv9m35DFHumZI2n5AA5l8BHKV6pcqmEimW9Extzgsc5CcV5ec6t8Nhlrfbx+3
         GGZ9dV2TBmiofqAKPyWIquM0KWk6oOIYEw7GbhdBqYPWos4r/PYchKBIfDbTBYmSVNY3
         33LA==
X-Forwarded-Encrypted: i=1; AFNElJ+9ApJsaDO1McFpvoKOap3EbSz4c04qr60P4siJ86p31tINfcd2B1MKcRSPdL/4xYpaVdefyP45yRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOZ4P2ZN9gOK6++KBILqo9vjt44ZSHHJqJmc/N21qKHByXg94
	Zf9KRBgV2fXlhnGvZ7b4GGjs2zumm9WlP2Mak57nWii6xLNnR7g3sg4P
X-Gm-Gg: AfdE7cm8Wwpvqo9fNIr+WIRCWz5kaEjHRRqTG/rCkrMrtHn3Pyne+3pom4p1HkwIKOp
	9ThcJgGge8ltczOK9p+JZ/s8hKgTyxnlhFGyInFweSFRp+g4RGz+v3KhUVJUwBTzQeMtgWLKXy6
	vY1GBxC4H26ZCTGvNXelq0nZqiNWs7hL7L/L/kZCoCbKbWftcpQ49P6RCEdsvJ5qStmIqEmS8JJ
	I/LStn9Ci6mNsCQm0hkwsw+wV4zxRGRx2ZM7LjlyXPf7zWUUVm2NBSLNK+pv1TXxMAvmcvSQwL4
	vcctK5pKiefWdfs0dGgmmjM0euy16Au0J245l9gh5+TDIjc23PmGbK8WMEvnPph6//DYu92aB+3
	Rhw6Wr7QOr8BK99D9uzV917hbPKI12a5BPz2ifVyHQwLhU4w0LQLz/gYiPsYOnYWKtb9SQJOfk7
	4/31WH+QvrQQYQ44urnikUS7o3YwwjxPUGiBmcx1HG6D+ntJENe0knX9auOV5aZSEvNREiN3xsY
	0PDLG+1C+dBbnzPA6k=
X-Received: by 2002:a05:6a00:c81:b0:845:3fea:96c with SMTP id d2e1a72fcca58-8455612f5efmr34818b3a.21.1781824593703;
        Thu, 18 Jun 2026 16:16:33 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:aa0f:55df:e7d8:852f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845537fa3e9sm225135b3a.39.2026.06.18.16.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:16:33 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.or
Subject: [PATCH 2/5] iio: adc: ti-adc084s021: use dev_err_probe for probe time error
Date: Fri, 19 Jun 2026 04:44:35 +0530
Message-ID: <20260618231543.413771-3-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618231543.413771-1-prashantrahul23@gmail.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <20260618231543.413771-1-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies error handling and ensures consistent error reporting.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 drivers/iio/adc/ti-adc084s021.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index a100f770fa1c..9c7ee09955ca 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -230,8 +230,7 @@ static int adc084s021_probe(struct spi_device *spi)
 					    adc084s021_buffer_trigger_handler,
 					    &adc084s021_buffer_setup_ops);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "Failed to setup triggered buffer\n");
 	}
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
-- 
2.54.0

