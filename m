Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C651D4854E4
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633267; cv=none; b=NLFc01SErzUc+APKHGDccnnY67U3lAOiWPiFc2LenqLiM3txx5R9r0Z1hg0wCowAZ8ONcB5LrD4yoozfuD0yZfycKBMDJGhiVjCBWH4Ff+9xagCX9ZVdJ0poeZuzoNpVlbuQmWPlWG5w2FTlEVarn1aLLmgR8T4N/tSQSBqVr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633267; c=relaxed/simple;
	bh=xJ79EtUrHEeuEYbAOfI9CE6RiB55ObHJWLRCeFudrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jneHzgPOECPZmWoEk/A5h6FI0i9T5rm+7gC4ODsqCr0yEQEyh5QNGkQn50abcaLV5yaEyHbha9jcF2ZHKfGp4sKqkD4dRP0zxl/hQIp2a6FH5AZHzvzOmq9ZJ1/ewTHMiba0HYtHfiIv8jjlJJaCaul6NOOZZcxupDHeOtUALJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV2GENNu; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV2GENNu"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-934944f2d22so142760585a.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786633265; x=1787238065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWO/kZlEzRmoI80cXBVDsIHqzzbSVdIgM/uL6M2n2SQ=;
        b=BV2GENNuhqjYNU5GgP2QMaG1wkvs4sKkx5883FjWGg5NQOt3B8RtSj2Jb+Rg/vZ4K5
         KefwjvykD8x6v14Q+BeubHO0TgqSqin/XglyWGfjdpCZX2cE8W/JZtvUn0phSRUqYQ5T
         Irvl1BP19fTArsyaLcxDL46HqOJdOIZpwYAyFrNQUXSQ4ccLHgkv5LPo2Gwv6fo9dyYI
         EsYaRIEuM4MQ7P6DUeFzTk3wVqc3UkZGKzxBVJX7XBT56NlPjo/9G6pZy7CtPbVn//2R
         40apkDW9JOcRpbN4dZZ8DwSZ92jSgp4q68R1/PCVbmIf8g16wcSaHFAWhVx6w3f9r5WM
         RGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786633265; x=1787238065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWO/kZlEzRmoI80cXBVDsIHqzzbSVdIgM/uL6M2n2SQ=;
        b=oeXCXDDwXdBEZHA6By/8cAq2IfpJ9jbTvlBMZAdLYVz7hMjYUiC17g46qdMMt5aUaO
         v561EBghpC8r7xzQZOlfHjN6DylSukdXHDRz76I4hMxUqXY0TL5MtMtweVVX7hDePQEA
         p16onp/ubbJ2YbS9uJwI3Yf0OJVaKg089I79lDH2AOBrJS3kxg1JmUCyR9qkJu8/mQ87
         ABXmKmOlMSkQDG57xMfU+9QF1llyDGu7224jaKj/OgHFzeDN2SYP7bfucveCYCwvem4z
         P2Ry/w/PPuzZ+1UiKDTWg6OkzemhhNwbBa/HbAIYUIeiDNZtPBIKjYZcanYm1IjWd93j
         GeTg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1MLvh+V7G4sHt6/Z+3tZbXfWXSnPWb8/L/n5jOWh2183aNhWJpkwimU64EVQcWdVCMuc0cZhqWJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7LxlUHeuv2RP3k3xDP+PHSGQ5MhKRfnv2as9lgjL6mIwVxcz
	EfP5mVtlDHQmIpg50YoEbqL09QW1nFMak7JuQtoCMKJGWJr8cOKSpr1+
X-Gm-Gg: AR+sD1252mXl79FcV9p71ZdVq4TEDzx/SNdAP4n4PvmcZa4ZQJrFyO5D2Ool5hXrbf1
	deqdBZsHNfKdUGFr3lRk0P1ZYM92SiJtMukkF2QozRFj1kGExesDLAVkmzLmorDXbBAHQuqBvx7
	11BEPW1Qm835nPhRNZcWvf3F0OilO8Mykh7O6a0OFwqlTT06cqQh4YeO/kX06uhh+PHdu2d7Jg/
	ilXvMGemZrv8A/FiArISoVP0EfMb8gPDfBJ4yJ9vvvN3OsGu97kcbQFeFzAgwZyqmnVYflwmvhh
	5QhI+x7IE13aD2TP3+mzYIeu5CaXWBRR1a9lEeCrGZng4QD4YPFvuF3N+0eCsrpkACmVCuE1Upd
	XgePnyT6guzqmhj6RXer+c5r9mKbr8QOI5PIDF2cjGd5c+eybtJUqFLgravjIOh08BXb4hdIta1
	O7aXLhrf06mHd5oXRLjuvhCBbaew2Dp/Uq+1o/Spv53Fw2iDFe16CHl/U8/mXfz54/0Eo=
X-Received: by 2002:a05:620a:8ce:b0:92e:745c:6c5a with SMTP id af79cd13be357-936bf91774fmr525733585a.14.1786633264617;
        Thu, 13 Aug 2026 08:01:04 -0700 (PDT)
Received: from localhost ([2600:4808:5693:8201:394e:8b9f:994c:b59f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936cdf54cffsm406785a.9.2026.08.13.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:01:04 -0700 (PDT)
From: Marco Chen <marcochen.dev@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jagathjog1996@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v1] iio: accel: bma400: remove completed tasks from TODO list
Date: Thu, 13 Aug 2026 11:01:03 -0400
Message-ID: <20260813150103.56350-1-marcochen.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two of the four tasks in the TODO comment have been implemented.

Interrupts were added by commit ffe0ab6a9698 ("iio: accel:
bma400: Add triggered buffer support"). Support for events was added by
commit 961db2da159d ("iio: accel: bma400: Add support for single and
double tap events"), among others. The driver now has an interrupt
handler pushing IIO events, and event configuration from
read_event_config(), write_event_config(), read_event_value(), and
write_event_value().

A step count channel was also added by commit d221de60eee3 ("iio: accel:
bma400: Add separate channel for step counter").

The power management and sensor time channel TODOs remain unimplemented.

Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
---
I would like to take on the remaining power management TODO. The driver
has bma400_set_power_mode() but neither bus assigns a dev_pm_ops
struct. POWER_MODE_LOW is also never entered. I don't have a BMA400 but
I would definitely buy one to develop and test on. I also have access to
a logic analyzer for testing. Is this a patch that is desirable?

 drivers/iio/accel/bma400_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 7e3cff4cca91..6bc64ca87f4b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -6,8 +6,6 @@
  *
  * TODO:
  *  - Support for power management
- *  - Support events and interrupts
- *  - Create channel for step count
  *  - Create channel for sensor time
  */
 
-- 
2.55.0

