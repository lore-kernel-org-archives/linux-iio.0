Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EBF2BEC45
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361565; cv=none; b=SQzEFowCnx4B9PxZouT3TKE1D+ozSENgum2FE/MhRHJIDJVW7RKGyofX1OEYo6FgdTpnopqu975LRslfgzwuQGatt3GaKC9qbm1U3Kgf9UJluwh05tNa3/Cve9IqdWUH3Kh1WVdSIQ9bVpuODpKFSamSrD1OmF74dY3dmBtm58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361565; c=relaxed/simple;
	bh=kyO0Kztq/EWSl7hefaMz35kuy2WDsxmgAX/RqqB/wqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAIFuCU0F2749YzHQzyC8I2KWxI+/XIZyVYlBiyLksuKhQVgHwhk28jZVmHdPpdvMKOvhJkYzc+j0sbx5Q5wpWOqU+9aq6BtM3L//6gd1OFgQV49dSlf301qiertjZ1jUYDxF8jj4uHL4B6m1AA2c/H8nOjR60Ss3Ndk+92SRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0PdAxks; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0PdAxks"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-404254ffe8aso2685627fac.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778361563; x=1778966363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TClOWT8aHdrbSRekQXx5ViituCwMT6kPSJNtcS0Sujk=;
        b=P0PdAxksXodBhJbF9bfSUdlG0JOYykyyPqNAEOjV8pEJdl8am+TPfTHYa1hX0tg51m
         ME2HCauhL8sAWvUpj0uc8ubTMTCyV/eY85pea+5nWYDdV3u4eYSnyI4pKwug6Y15mPM6
         0wJAP18F51Dho0tZVhk2z6U1wzE02QXrBLauN39LQJI5iRdg/uVt/Xafp03vrJvunjoP
         3ihYCFmNf+znaL0dzLx8UONhODq2fr44RZhpO1D0RPexHaINJF5jB+b6kEUCShNWkmns
         UTTO440K8pONMR//k9YTsmNXw+noAj+G7BEeBzZ++9i5zZqZOYTnLPKnC589+WQ1z54P
         CZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361563; x=1778966363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TClOWT8aHdrbSRekQXx5ViituCwMT6kPSJNtcS0Sujk=;
        b=iSFIVrI7jclYbf6Dbc9yexj2jBxLUEF8oyMwd6yyVOnvYRiuzmRlN1Qwe3qKDwosKg
         ru6RghgWB8hGOzcgfPlaDNmKia+QTib1z5c0iPGL2hjbdgDuD4f3lVpwBM66ZT4V7gWG
         3dMiXB8eL1RORiRkOGOgYFElVTKV6lzPC8C2qX74FssFaeL5XzYtxhpQd6nzqF8S4prF
         0lbifeS9EE1v4URhCqcdvyLCD2KkluO5shnD/mjdhSnU6UXWOpyZqLBR1C4Gu9jRKUGa
         nD0xugTbuTSKIzUEWMyMzjcXSKfQMw9s0y5IWoRWH6NLdG6MnF7rxFfaZVqmgBcF/U5r
         nubQ==
X-Forwarded-Encrypted: i=1; AFNElJ99xW3HQXdy5xlYwNjLWOLcOL3O6KcmeE77SjxrzQbVmAtFgvATldHI5qjVTz5cvSN1darYu4YQS+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71CXdKldEPsFtaFHKSw1cbhcV81iqjYpyPzgPpHrNISLpHqE/
	sI8+dq+z+802vSuxyci0k+yGKUtx3gSZS9zMN6cR39lUdLHmOxybbBS2
X-Gm-Gg: Acq92OFrz+h5ioI2JtrDs3GYgM8WJ8ohshmcDHKtDIUQChYzVUVQd4QEgb28Wllw6Cq
	elaxveIbga6Sa/nS2rCWLruwFImuyG3bz2PA59oZrEwhZoPnpHpJUUJ8/YQTlldQ7KiqCNl7La4
	2OQeYRCgoth/gqE0mGk/BZh2NzqPSD7Zc+Ucy1Fq8zfxA8qZsHx9iVal69hG3rpOTXd7iuX+4DS
	6cs/cpbn7p2koXRDLe3kjxzcENPx3BqhlpBlc8Za6yG/wH2sJwQEt9zDYeG2l0nBwGCpMOxAUpL
	n8KthRWfEHHuQKGieaH/+JeiVMzljd+a2qs877Dtdyf4khtzyEjRebmpWJ0LNVGaCoH1UulqGz0
	CvqEkKMRfcrVZL/GKwhaVXUdiVkH1DdQYV0nMyErqXuzGxZuU08RPLncU1Ks7rIkJz0Ez5si5y4
	uiYQdeqxHZ3fB/kfHVO0/3S/2d1/F77T/+9UbN2JoWTJKlJvd7ndCe64HAEg==
X-Received: by 2002:a05:6871:c64f:20b0:435:ba1d:af1 with SMTP id 586e51a60fabf-435ba1d151emr233527fac.12.1778361562918;
        Sat, 09 May 2026 14:19:22 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435573e6ec9sm5476581fac.15.2026.05.09.14.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:19:22 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero error
Date: Sat,  9 May 2026 16:19:20 -0500
Message-ID: <20260509211921.84969-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scd30_read_raw, the current value of tmp in the
IIO_CHAN_INFO_SAMP_FREQ case is unchecked. Add checking to see if the
value we got was 0 to prevent a divide-by-zero error.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/chemical/scd30_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index be8c055be184..3e2bb6f4e42c 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -237,6 +237,13 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 		if (ret)
 			return ret;
 
+		/* Likely only taken if something really strange happens */
+		if (!tmp) {
+			dev_err(&indio_dev->dev,
+				"Invalid measurement interval 0 received\n");
+			return -EIO;
+		}
+
 		*val = 0;
 		*val2 = 1000000000 / tmp;
 		return IIO_VAL_INT_PLUS_NANO;
-- 
2.54.0

