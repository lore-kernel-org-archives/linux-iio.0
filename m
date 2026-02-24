Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71687273D8F
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900536; cv=none; b=QUF3yG4ho13q4pNwY21WiEWboRXvoCNAPwAZfzXrqlYlBKoVsOA+6HmxJIljsBP9/FTMS2543nQnMG26eq9hyLEU11jtHrJIApC9c4UsM1Xyj1FaAJI1mLbuc9nGUju37Ev+pnRsN7i0okZVqsiwNpkqQOxYPDqIsQZJKXGRQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900536; c=relaxed/simple;
	bh=KUnaoDdsl8scQ/d6Iox00XXk6u382zdfvElDYxnQ6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THUft9l+2muD9okbBblMskMe1pMPEGu5RXzUFo3XbKB8K+cOYnZFMBQYSSNQkmZiIfKGSOm5F2stZng4W7DFLEHP1JSGAHwHqYBFMtSt92pNiy6cXQci1SwlxuQseTtgq7qedl7YRv5ppe8b9i0IDTQKPJHZBTMlwQ0jwCspj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmEA4bJe; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmEA4bJe"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7947cf097c1so46110077b3.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 18:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771900534; x=1772505334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syQrnKdSaSXvjiSlw6u25fzSgvyUrjxfjMVEd7QS078=;
        b=nmEA4bJeJ/arfUSzBIEiEwvTlUvp7TSzVQYzHrvvPolNeDy6WrGH3Xmqpd9viIwZTX
         1zjMPPfv/9alOSisj0IDL2ZTNDh5blK6cXh44MzvbP5B1BGyAMFTt1C21OUKktBE0w1n
         ws3rkIDrpeVtXA579vcaPtFEYFPrd5MElp+JdncyeSn1PGZt3EO4UW379tD8047DtxGr
         rGudQJthsNCimdIZcFT/9jSW9gR32aThi7yFWvdBbCpNVLM5ME+R1/Xh0Hu4JvDD4YIk
         eC4KtGsdx4m9H5H9vh05g7xmjg3negfw/FvgwcaadWFpRAzIDW56bayC3Jr9eFKJD76n
         WakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771900534; x=1772505334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=syQrnKdSaSXvjiSlw6u25fzSgvyUrjxfjMVEd7QS078=;
        b=NPYvad+2FyT3FovB4koJDAdTSzZ/DWb8UYxzMrFdoQ1VD/oHwP+Q1L+XX3Q7bTYxqz
         fZczgOY/QRO+XpYcTcQPIurGTH9zjNBrKgqgv/e3lnD7eDBS8Jd6V7LW9UyNPfzF03Uo
         02S4l+l/F6q8GBiaNNypuSeS4ns6Ab4gAqmHOBTpI/GWAy8M4ZI9eafSRwX+pcKeEC9b
         uuz2RQo6l1JatIcsBdDWkcws14QwG5KECGCtKyuTftnK66PBC1vU0FnJN4+Tk7HLrvR2
         Ye9EZxw3KYl5Z5mtukHCbrEQqLw5hP21pjsBwiu31m0s9ZF85mGSBulL4X86WOnHAyyT
         +D1g==
X-Forwarded-Encrypted: i=1; AJvYcCVqUYe+7NAPi65DNv4PxASOqpExh7Jm2971Il1wO9n24SgToDyRvzSlgqB7aTe8By8puYyo4x4IiiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmpq1XN+3pW6BLJZrwzTGW9GEEpmj0Vy3vz8Hi3EHPmrY4lZJR
	m0J9bRmkz5LjcSay3kCW5zdjs5N5QEWFKPCztzUA1SY4HVPMLkzJ+XLJ
X-Gm-Gg: ATEYQzyAvdJZEIvc1nfSbJ0YtTOVlp1WZbgIvM1/m/URi/NbG/CvWGGp91YhSVsVkBV
	Z3DdYfnDX5O61qWd8rkRL5kk3f/7zn3wsWEEBucOqqOZ5ocJfXcqELMf1JKzYZi9jitDxjCYofX
	hZlcSgZj7+RRZ+H8JFFx7SnaSO2gXELDPi+5iHdr8TWUu0djrFMgUGUovhO91+eudSEoFxVto8h
	aVG/2DVrnnNJnSi1LmgBe8wYDFcPjJB50KXF4Ia9FjNN3v2z68/NxVcX739Lc8yG53PjDbkirqj
	Q5e4b48vrmJINruQM/+W1efj/Mx8pTRxQC+ieZ9akXcEl89GjtKU3UWv2KEUjvk2dA43YJ4ZppA
	R/dVCSivaAJrlgEXYKZicoXPK/N6UmvoyiEsi2lWkp8IQmktKfnZ2fb3/RGS8Zqj8D2Z35kAitK
	bWvej/T/lFu7aoaOWQq8yBD5fRe31zhXH+rDKDUvln5uZYarCpC7V+ix07J7EF1LEURzjdnuZSC
	WGO44ip24asUSRnWOcd5QPKcQi1+pOD5Ss=
X-Received: by 2002:a05:690c:46c6:b0:794:7e1e:7f8d with SMTP id 00721157ae682-79828f18314mr88008657b3.18.1771900534476;
        Mon, 23 Feb 2026 18:35:34 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982d985074sm39585407b3.0.2026.02.23.18.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:35:34 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v2 4/4] iio: gyro: mpu3050: Fix out-of-sequence free_irq()
Date: Mon, 23 Feb 2026 20:35:11 -0600
Message-ID: <20260224023511.274038-5-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224023511.274038-1-ethantidmore06@gmail.com>
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function free_irq() is placed after iio_triggered_buffer_cleanup()
which breaks LIFO because the IRQ was setup after
iio_triggered_buffer_setup().

Place free_irq() in correct location.

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 73dc7ea1f075..3517522e3a51 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1271,9 +1271,9 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	iio_triggered_buffer_cleanup(indio_dev);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
+	iio_triggered_buffer_cleanup(indio_dev);
 	mpu3050_power_down(mpu3050);
 }
 
-- 
2.53.0

