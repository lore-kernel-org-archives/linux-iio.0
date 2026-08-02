Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA21F4181
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785633830; cv=none; b=EVcw+WcUi3B7ybZL/SEVvQq9kT38DlXbqCZMjWzxyJciGgnJaen/JnSFHISdy+jN1SCcSLYxwa6hLRLDebvHhM/2JMgtJy9893pZsELw3ykyVkaKeMniiVfPvBzeCjgDfkalSlScKBriH29Jg8qlMZvI3aWTMIPaKkKHcX0vSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785633830; c=relaxed/simple;
	bh=Tkcyj1pIcSE+uem/7Raqyt4F4YMYHe/HbEy/1nXpsj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvzLIbAbv4AVfxhGZ8o8+PQgl4Blu9KRxWygn3dpVwEl1byXkUhnnkFSc3W4f6d74Y41HXbrIcs/eM6K1KkMgc3IlOjrsjSo3d65ldnFCMcF7HN/iT6IDmV13Q1+VQsgg2ErptojEcHo3VtS2eZAKgu1LhWpofSrvQpL7IOVSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzu1CwmS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzu1CwmS"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbb973e6749so2517280a12.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785633828; x=1786238628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3pTsE0k2zb7kd5dP6EHONBGSxmW+mcist3GzpPTbszk=;
        b=Zzu1CwmS005pxz3dquClpTNOUD13sMYLvvY9UONgOPKOdfW3hhwe+JyufEouzdyVWS
         yJQkpQeUNS5EqJGl9zOM6YW6fgfrjSjQuSnBtgrGKdUGsqVBXnJtQe6GLAOUZVoGAs6g
         BCj806hdpwWx70wAOZcMQwqeQAuE7IGPk5XQmeBlLPGrf7K/SZzxUjCq3GeUYMjQ96Zz
         BJVhqsLwD5hEqF/HcIIZ4eBa3Ddgsiffh0qMgyYRjn9PwxKKz9FsHzjQhguFTFtJgMxP
         Y+dkBoDFQxpMZCmQ0/7FNzKiQNllUT1+uj385F9xipN92kVS488/O6lXJk8UqHDr0YFp
         oixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785633828; x=1786238628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3pTsE0k2zb7kd5dP6EHONBGSxmW+mcist3GzpPTbszk=;
        b=CvMlYIAOlAhmXBhcVeRfdRJlZOiIa2Do3x4JwAQiRk36C7Zvs3MxbEIA7hf4KAjkKT
         Yeuci5Zf51gtMFLb4BleSDUPV9YoySBuEh5zyMakkL43sLHNqrXqgQNGj8c1U3vHyvJe
         Vh2ZF7v/LIeGnwQ3FNmXi9sI/cuhmUW7joIdwlz6Y1KvLYteDT01nbVA+dXOKYH9O1cO
         hMpHTxOVyh7RKkiWpvWFooIjWw+CqRzgvB6sL6OKXLCBTJzFmCUT21+eMPbxMYZuZGzo
         WLbca6ooOHHf9HAdHv/IRLDBhQn9CILbqXxviD4+a9x2wNLNN2g6C+2aAfam+YIeUy7H
         2gpA==
X-Forwarded-Encrypted: i=1; AHgh+RqZdsv7ZiDITMjrLqvPaOfW3nxHqLIb5gnFE72oZyycfmYEbJzcPZzKlVq7Y7XKd8pnjT+dFexYQgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPN1x1mEz+7RapGK3ybbL6lCbFRUE4S9WR2xF04oUTFXuT4DZ
	yXrmtQxqebylgvA5ABCAmYo1e0NDqeHagdyZyKQkMLCF33LC962euo8V
X-Gm-Gg: AR+sD13qLqYmMY7fuKdSKHYQalGLGmb5k22a8n3/KrYQCbV7++nIAq7w4YrZ4U/tLP4
	fExkOYYOpiL4SFoT39Ye9DwaK4daI5POchVJXD2E8OnyyJ3tj3RqodtQyQ4EeXiSBz8BrUduxol
	7GS4z9CIF/d5wLVTfuDn/keozXqkscZbE4knOW/kxD+OUiqwKqAY/6DRExZRgMs+bHN0TSMoxGd
	W6+agHFgcHjRHsAm6TtbMUsb6V+Cb+D5cKFZKOaW6a/MIUkl3Zpfs23p6M7yWKSDColT7nEG61c
	BVNesJfCbWRwZMcU4QSdKlAAbcNIkeJQGh6LM2g7Ya4Tl/gJYL6B6GWnzLnLzs7SQWesZIN4qnN
	u8XiE5XaO0O7vOAN7JYw+p8vceVwboZe+SXn4PidrdQscHJ7MfXK3BpHIP2O7HwuiCeFCh2TmMO
	lhT/FJRyLIgGcu+36a+tIEEsXLC8n6TVbHqwcXo2Lk8CXjr9u2q5CJwkzUSMvPdn6gT4ox654Hh
	iXWyHvXdwz67n02zNfbIjBdC42u8ulnYJqX/dTzXve1ixN2WWT1lg2G0ohAWA==
X-Received: by 2002:a05:6a21:6b13:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3c92a51e081mr5409487637.13.1785633827927;
        Sat, 01 Aug 2026 18:23:47 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm36906954eec.28.2026.08.01.18.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 18:23:47 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	adinata.softwareengineer@gmail.com,
	dakr@kernel.org,
	bhelgaas@google.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] iio: humidity: htu21: Fix SYMBOLIC_PERMS chekcpatch warning
Date: Sun,  2 Aug 2026 09:23:26 +0800
Message-ID: <20260802012329.9877-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch warning:

WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static IIO_DEVICE_ATTR(battery_low, S_IRUGO,

WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
+static IIO_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/htu21.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index a9dbf08b4f1a..fe7192d142ec 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -154,9 +154,9 @@ static ssize_t htu21_write_heater(struct device *dev,
 }
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(htu21_show_samp_freq);
-static IIO_DEVICE_ATTR(battery_low, S_IRUGO,
+static IIO_DEVICE_ATTR(battery_low, 0444,
 		       htu21_show_battery_low, NULL, 0);
-static IIO_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(heater_enable, 0644,
 		       htu21_show_heater, htu21_write_heater, 0);
 
 static struct attribute *htu21_attributes[] = {
-- 
2.47.3

