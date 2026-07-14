Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4726451044
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031945; cv=none; b=cWXco48z79U6D8t6a+6alzVqN1oTWU9IeZyNWIfO5XFi1VLdwGe/IRjtkwQeXMQ0IaRnqpe4Wa/UrV4itAoOmZMbqxmv4Y+4XGWbjMCvRf7HtrtxnzGL9Z4jUx2IiAbSqehnVT6e328puNtKi+6JZ6oiMTwWywnZULzyD8uJXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031945; c=relaxed/simple;
	bh=YFYrDA/Zup+EeQmmG+q8ETAwHPGN2mpzqyXxNr5vYmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWdqU1b/KR1z+d3eiFqJUHz8Bu9Zqnsv9HJJIfb9kGbZ7jF9XVmhJkkmGmOutjQQJfgDdtMl/xsolQxvsS91gUN5S/3ASaTY+tq7Jy5hgN9zkg9k8AI+CZ6zw58yDjcNqpbW6U2OKtthLUybKVdky9X1WocloSM/bp9EOOFmrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUWDlDK7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUWDlDK7"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38175907a56so700077a91.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784031931; x=1784636731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XwHT4GdFbig2jr1kX2eCEaA4sA1+o5bux1cQhvEpZhw=;
        b=oUWDlDK7H/4Tml54Hgxl2u5ll4lEGK4qj+nmFxgGFPCvvGT2YWToChfasBlUROrx0J
         49NZAbRw0kIoNHZqK9Vpd1RR0Wz6tkJ6RIOBXMdIJ6LQWWNE1W4EQ2SA9IIypYrKqtds
         B/gN0+shQ1ZCGMxyA51Gj1QxnZHPRpqVeqi9syEXyFiY4g9gpZ0qBr7gv+shm0Qcneuh
         FK5MQT9qsJyNYFxNrGWMtJ1sbyWIRmjyA9u3xEawAfqcfqR+1Sc9JSPGYMTVIvDxaz0k
         qf8BIWs49OJtBgnsWdz3yFsVSh0sQrVlMyxEiePWFrkEo+3uc5JyX/S9ds2pswQWZ5D8
         llIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031931; x=1784636731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XwHT4GdFbig2jr1kX2eCEaA4sA1+o5bux1cQhvEpZhw=;
        b=R2KTpLUcBffZUFTB/5I60543HzLDEa6t3/aBdkPCHMPMgN7D7AI5XgrQ7g6I/dLItL
         bDRXkGjDo2TMKmXSbNGs1joNVkTbF3SP0b7Drr0KspxFsv4g2VwGo9BRW8CdS88LdpVu
         Z3uNZ+hCpXpPZD4WU1fii8VU5o+l25uY5raWer9Ky08QgiLVJseeQ4cOMu1N4eVNvdrI
         REJSB01SsKpwe/HmJMLko+20Y0VEFbi7r48OVw4HN2rgkswWsFSPRAVzboD8zcf2j2Lw
         SHVyWGqpR8wVxEQYXcrt3vnCA2EqAmCDIsycXkVgA13krispsFqKnmOM2i/0iqTiv6lS
         RSBA==
X-Forwarded-Encrypted: i=1; AHgh+RqvEuYeKdYtzVaG6MVpwZBsNIFJXL4CljVguU09Ckw25K3Yp1f/DQs2XQ/jBdtEXTltxjCX94KfeL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Gmpvs7CFPEt2kw0C0YdiiF8PSrIxr68NiEkV7xq8dYcqCIR0
	TMzEcMXx9PbPoNr23+JnuwPEvh/WVetD70YIgnarYoF95njuAP28K46C
X-Gm-Gg: AfdE7ck7KzwZeo0omlAQiYGgJA5WkJdM4eIR2eo6dax5F+K3coO1S0DeF9Jjt1JH7VX
	bIcou4F1P2Y52dd2x6NNak9uT3JNyWYvegxzWaNxvRxSTpEcLE5Su5iQOgZ7XFp4TQnr2XvD4+t
	V+RH7ZSvyVDimLG4W0AgjMxzkWOdwT2kayqNbeMF3nLz7oHk+V9G6rYi3kJGlU5sD3Kno9AGX1x
	JDDQqMxg2xXjqVGqH4MBNtwkpjs5cA1UZl9HpY4aeR76RMdBZJODLr5ZDmM/8Uh8AV7gcVwWM3k
	RNEZy6+f7U/vh4y9sHlzvzmhBxhaNQzjggLsPRuRHL12Cw7lfremp64EfoTc6ASQSd7GEA42T1p
	7mE7bOvIidQF7jMOzzYF74FLeL9kOyT4LN5U0LxG6tc5F7nAF45F4M059plHGOP6aP+5tneOOH9
	JGNYmhZktM6F57qEZ8JPWY1aBsdZ0NSBAMCp/7vl2JO8E=
X-Received: by 2002:a17:90b:562b:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-38d1596cd89mr18458990a91.16.1784031931338;
        Tue, 14 Jul 2026 05:25:31 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm96163178eec.1.2026.07.14.05.25.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:25:30 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH 1/3] iio: accel: kxsd9: validate input before acquiring runtime PM in write_raw runtime PM in write_raw
Date: Tue, 14 Jul 2026 17:55:21 +0530
Message-ID: <20260714122520.3201-6-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714122520.3201-5-birenpandya@gmail.com>
References: <20260714122520.3201-5-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kxsd9_write_raw() acquires a runtime PM reference at the very
top of the function, before checking if the requested mask or value are
actually supported. This causes unnecessary hardware wakeups for invalid
inputs.

Refactor write_raw to validate inputs first. Additionally, modernize the
PM runtime call by replacing pm_runtime_get_sync() with
pm_runtime_resume_and_get() and adding the missing error check to
prevent proceeding if power-on fails.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 7ac885d94d7f4..b3acb20441d86 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -139,18 +139,21 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 			   int val2,
 			   long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(st->dev);
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
 
-	if (mask == IIO_CHAN_INFO_SCALE) {
-		/* Check no integer component */
-		if (val)
-			ret = -EINVAL;
-		else
-			ret = kxsd9_write_scale(indio_dev, val2);
-	}
+	/* Check no integer component */
+	if (val)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = kxsd9_write_scale(indio_dev, val2);
 
 	pm_runtime_put_autosuspend(st->dev);
 
-- 
2.50.1 (Apple Git-155)

