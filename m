Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FC3A3E7A
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507003; cv=none; b=pR4dwhNs2W5aKeiTJoGC7ezUUOij7CNGRM8yLsITHeY6caC2wp5L4ezMlj9Xo5XMN080Gu3ACnozB6ENzvgIVVdwPHTePrEXk69y9GFdhZW3rJdAvMGSQj1Kv9s3r95IYG4HTKaABZZ4nnyDG4+560i0Lw0KPozobXCOYLcoE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507003; c=relaxed/simple;
	bh=mZMfpnTdnLr0aOmmb29NZteWLRSVAezX26+ecj/KXLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8TL5zhMvElX2VDj4pfhlO4hOExSzg5nnxmof33MyOFclYWYGNebmCuEpMNJ54Rwyjaju/N1kq5z0BMuGbteb4kCLMx53h0tFD29iA5jFCb2/iCNSqvyFiKk3nW0mFMQeHR7Bjpq5SlzVLHwB2EBAAcNauo4L3kPuR93VWq4dqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXj/LWOd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXj/LWOd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c569cb1so3993555e9.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507001; x=1779111801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JHMd7RvPcvLzlV0c3MAuHkYdaeF/YNvuNQd+ogFq8k4=;
        b=KXj/LWOdeKYP06et9zYqMR/JDYJoNIW4fg5wR8tMU8a6RlUZu6cl07qaAIwPxufoyW
         E7GWOgEnBheN7+F2QiNPvCHiQFHwCDwsG7ATDXXsexny7vfaGenzP1hRaxlwW/C5a7oD
         SWXSADpevlIQaADUYvovXBvnB05fo/ArF8mAMBb9nDZic1FIstrVtade4x3lRfeqBHoQ
         ojRQ2Og6UKc84JZhUDNG9qUPGboR73GqDXJJSQ6jeZmAf8LeqVW92CReAN07fP76jfVI
         HQcE5XyYYQSqbMbJar4Qloe9OFIuh1QNJgApz6xQqnYB5/5Xa3tV56hyxdubkK3fM8wd
         QsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507001; x=1779111801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHMd7RvPcvLzlV0c3MAuHkYdaeF/YNvuNQd+ogFq8k4=;
        b=V5z9eJM/l3hLpgxeXjuZLBdWciFNsigCIQsvQax5adquITyiKxWcaDbtbArDo//Mck
         nigNerMS8BNU3Ybfb1+LzJOkj9ha/TCrwdjr/IZ4qwyL80Dff0ySOM8g8hcnAX1D1LZA
         WwvqzYfTPKJEDgqg7Hsw9MFHLI4DtKK1UXseHHJJMsbypoE1T+AKXHCt364n/Nidkukx
         X8w3DYiWlyK3Sx7V75FaLqm0hnZGZuCQNJQ4ePmXxsCz7ON5BAd0K5a/ORZWHGvbkTU7
         Vr1uq4i0v/XsnPbtdGKYerfbtevP3gTb6fcNCkPOGnI/Lslw3vG687O/Tkz6W2m7d31N
         9mqA==
X-Forwarded-Encrypted: i=1; AFNElJ9/fWByfVdO40MEzJDkf81MVk7rZAOrQ7sHXULDotfSKCPWLSNc+KVZG52y6NBUlSulCN14dTimwLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9mqU0LIbQbmbMAup2vE6rsnTQxxT8aZpsXcpgaxY1dEu8JEX
	tfMUgoEXu/cbdHCu6v/+INyrMLNkwqmuvMj4T98stdIaplOmQvkFZAQR
X-Gm-Gg: Acq92OFUWUk2wyrJtnHr0dErHrMNRWWf1URKrbGnJOsll0K9pXESH+g/NGM+RwEgbrc
	fXl/i9zdKVKOPepfZaVJm49DGN7NQS0R81rUY1JaQyNbG9Bcv5disJvUkdK67U8zvWWkp439C5o
	2CVBqjAfGyPtuIoz0Sr2bu5F4rkR6eQgu9Pkod5gqkMCogMHQCOJjVGZW8JbntfBWRVBKYP5aZ1
	t1iApnNk5cI/i+tBN98WdHqFWUGVdPVEhfQ4Pi/gj3YUvzyIkFTQHQMp+2Y8Aw5LzCDux67Oy9c
	2rznIjDsL8zQLwYqDDW9AgbAITj7PlHHx/+3xfkxkrLnKGaNPlPibSdnq8YD1TlvrSzGd+VX656
	iOXzexWQWU2MfEoqj0x8IJT2m1ktQ/xrtHK1vURTNMWfmdCWJc4NAMdIp+tXfJ74ghwO5ugWpQo
	0GpzRPFDhIeq1bJjZIONoDcKk++IKMnxOCZXvvTzzXJMyj
X-Received: by 2002:a05:600c:8908:b0:488:93c5:4dc with SMTP id 5b1f17b1804b1-48e51f4fda1mr137473205e9.7.1778507000897;
        Mon, 11 May 2026 06:43:20 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7040a9a9sm324847825e9.9.2026.05.11.06.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:43:20 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: gyro: bmg160: wait full startup time after mode change at probe
Date: Mon, 11 May 2026 11:27:55 +0500
Message-Id: <20260511062755.30-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bmg160_chip_init() calls bmg160_set_mode(BMG160_MODE_NORMAL) and
then waits only 500-1000 us. Per the BMG160 datasheet
(BST-BMG160-DS000-07 Rev. 1.0, May 2013), the start-up and wake-up
times (tsu, twusm) are 30 ms.

The same file already waits BMG160_MAX_STARTUP_TIME_MS (80 ms)
in bmg160_runtime_resume() after the same set_mode(NORMAL)
operation. The 500 us value at probe was likely a unit mix-up;
the old comment said "500 ms" while the code used microseconds.

Reuse the same constant via msleep_interruptible() to match the
runtime resume path. Without this, register writes that follow
the mode change can hit the chip before it is ready.

Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/gyro/bmg160_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 38394b5f3..44e90af5c 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -258,8 +258,7 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	if (ret < 0)
 		return ret;
 
-	/* Wait upto 500 ms to be ready after changing mode */
-	usleep_range(500, 1000);
+	msleep_interruptible(BMG160_MAX_STARTUP_TIME_MS);
 
 	/* Set Bandwidth */
 	ret = bmg160_set_bw(data, BMG160_DEF_BW);
-- 
2.43.0

