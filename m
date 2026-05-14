Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C540B6C6
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769456; cv=none; b=RpMerecVP6jgG/cELBJ1OTv44ImqOKz2Weyuhxc46XCgKQN/lo1K6VoHjp3kzo11Rp5Jqupxw01wYNpNEfSJeMC9vsUzYjH2oj197r412i7Ds3s+wldd00DYM0O7coCv0lVrK2T/fsn4xpfPn4brg7T9tv96Lc7VNV1hXT835N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769456; c=relaxed/simple;
	bh=AUW0mcdwLM/HHdmOcHNXgogfv25mhUnEW2orIQaC6HA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vh3h3s55W3mvUfyYTmP7kRijunjv3kesFdboWU62mLwLH6ACGrq9gM0uauIl1vD6IKi5aV8QHv5T17uilkKfP546RLkrTMdE1EeHSDA0QfmsvNJGucXo9vVMKo4mMCpAT7MQIfC1SHujGdefK5q3FQjH5bNMZHU7jpiX4wCzpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGSECTNn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGSECTNn"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a8772a67bcso677010e87.3
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769453; x=1779374253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEUjmFPqrm/ckjHMcLAZuwotGxEYuFfLQPEXC/wO4rU=;
        b=LGSECTNntBCz5fbdyhcloquJiGGYkUuiw65hBZ7zkleUUTSj42RsmeCyTLHRDf5A5Y
         DFrUP6cQb7eWYv7wRJ6Q98G5JbRNk7WulsBU7gnp578LxnvHigaxJwIo1mrIAUDbwWtr
         AzSbK7nDgauRdqYC/9ev4+xPEQloBox6+ZDppo3KIo//CkjkB1Bo2YfZCp6skr45Tagd
         RcMxEHLK6Nr0qoOJtOlnfk8Y8YQ3HyJ59QTF5fI8+DGsAlagZXag6VM9MW1sPwXR3p4t
         RmU6CV+pqzHuXwxtWNl0cadJPu5aqI0q98/F/gLyqrhhABdSIci21FTyq6ybujAY6jGv
         RzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769453; x=1779374253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEUjmFPqrm/ckjHMcLAZuwotGxEYuFfLQPEXC/wO4rU=;
        b=nUChfB7jeVIMB/Hokjk+L4g1mbb1LuCsC3n2H903p98ymCVazlY2kQT1FMPfsPlPsh
         3lW2VFieuS9KJhd+oBjQPBs2Rw/wynsUqCUj3GjSccEgLwMBzh7BIPHYn5n/mFilf+yc
         vS3Tlzw4Ma55zZeeAR39UZfrsrIgmAbMPF1WfPaC95MHMahfjOCWTStnT5yqI74TSnMm
         UyKiPNYrxBQ3l7evacD8zntYg2E1pg+bSEthChK6Xw6C2D3GLdv944rUXUiim9gUppAm
         emE09rNJ43EtSR7bQvlnVkKtGNK3w2sTveKu2RHsXH1tleGOIZ3bpwpk7ijz3Wm0dW65
         Lq/g==
X-Forwarded-Encrypted: i=1; AFNElJ9j0AidUHOreK7U97TfTwegHZ0KP9ossXIOSy4h/xnLtFdXfW1QT87uuf/uB7SJxAb78LxVhbs/EAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCP0bMwYTDFwqVbynWv43DuFxDiosGg6UCEBPYQGaJQ+LOfFGA
	hjCVj35ndOKWTFB1V1GnBZeteMLZrtkBhkRAql/MCqHoZJz1EidEn94QQjL9RalpD4g=
X-Gm-Gg: Acq92OHvz7OYcFvsY6uAMVnJKKxbpINBgXhdCkUbaiFhyJQNwBkyTeUyRn4eS7nT2yV
	xh5jZuFbO9eYFkaKwB8HquF8/mbCLoL2lBLthQEdrU9MiWKQu5qNOXtqn0w9xz/68kKPprz2anq
	faKhVayAO4klsTJmPV4QXNSGswVIFStUmMkb7nZoUHs5SCyOvis2fdILRqoBD2e38/VYU4eRGU5
	5fNWYJdsmUgJ5b8zLCmyZpDSSU87BabPogoE79oB0Ocbtxa//ScNnwSicEj2ehstjuoZq5aI+Me
	zCFIhRGGuOK9nG/zmI2UTjHVWl5SEKoaQraSwBw5ZmHtU9OswY/glORnTuMIyLm9OJNSwjXWJo4
	iPX/ZPpKdeO2TvI25r6tZVfpd7wPDIsYKA90DyjyENPGt4VHn8uI+S7/0OIxHkz5wx4jC8LpPPc
	LmMbAN1kRH19m7gJxRmP+V84Z4e6mqDlt3NDu6a0sTGe6JwTc=
X-Received: by 2002:a05:6512:3b29:b0:5a8:72e2:db99 with SMTP id 2adb3069b0e04-5a8ef9af829mr1161879e87.5.1778769452874;
        Thu, 14 May 2026 07:37:32 -0700 (PDT)
Received: from localhost.localdomain ([144.124.192.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cf0a5sm514062e87.75.2026.05.14.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:37:32 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: songqiang1304521@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: proximity: vl53l0x: notify trigger and clear IRQ on error paths
Date: Thu, 14 May 2026 19:37:10 +0500
Message-Id: <20260514143711.23648-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vl53l0x_trigger_handler() returns directly on the I2C read failure
paths without calling iio_trigger_notify_done() or vl53l0x_clear_irq().

A single transient i2c_smbus_read_i2c_block_data() failure (negative
errno or a short read) therefore leaves two pieces of state behind:

  - iio_trigger_notify_done() never decrements the trigger's use_count,
    so iio_trigger_poll_nested() silently drops further dispatches
    (see industrialio-trigger.c, the !atomic_read(&trig->use_count)
    guard);
  - vl53l0x_clear_irq() never writes SYSTEM_INTERRUPT_CLEAR, so the
    chip keeps the DRDY interrupt asserted.

The sensor's buffer mode stays wedged from then on, recoverable only
by re-binding the driver. The sibling driver vl53l1x-i2c.c handles
exactly the same case correctly by jumping to a "notify_and_clear_irq"
label that always calls both helpers; mirror that here.

The bogus negative-int return value cast to irqreturn_t also goes
away as a side effect.

Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Drop the cited error-path code from the commit body; the diff
  already shows it (per Andy)

 drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index ad3e46d47..7acb94acc 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -87,15 +87,14 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 					VL_REG_RESULT_RANGE_STATUS,
 					sizeof(buffer), buffer);
-	if (ret < 0)
-		return ret;
-	else if (ret != 12)
-		return -EREMOTEIO;
+	if (ret < 0 || ret != 12)
+		goto done;
 
 	scan.chan = get_unaligned_be16(&buffer[10]);
 	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    iio_get_time_ns(indio_dev));
 
+done:
 	iio_trigger_notify_done(indio_dev->trig);
 	vl53l0x_clear_irq(data);
 
-- 
2.43.0

