Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720071531C8
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720491; cv=none; b=uRtcIZpfRPr2rk8/NSOzEDbSXlyfFj6JbtR/CCSmxtOUpzU0gJ7Rc2jC1wb6wtoXzVuK3i1R7lfTt/s4pO/M8v/yn+EUPkf6gaO3rpspYIt0U5IHR1vKaqMLn4ogx+n7+c/7TlAGc4n5yPqwzOveMXqlgPzSkdcCh0vmWhRxoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720491; c=relaxed/simple;
	bh=DpZqDpgWFdqDiUupU3hy+hp66wdYNBtQrPd1t+nKiRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rz3yGY7yqPI99kdbQgpyVE3rQz2YbQulD+JoAPkJlJObFtBabG8y+Ql4KGrhWtG8QA5BBlfE3vszIL19bFVd/GQesXwvIaStgDGvw9WGceIJKJyXBTLrU7zJn0CQhuOJoJaLTVl1WzvOykVJPEyNh9ub67ykp5srXOTgRaXyGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE8kAGLE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE8kAGLE"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso3208032a12.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 18:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778720490; x=1779325290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/TJCCyg3GNNF+cgc4ppW8pNVQF/2kpZ5OGVnmEUE2Y=;
        b=nE8kAGLEOnpAiwsOx7rhu/Ae7K6KKRSzvz0GHMEVYNMyFMjOFhy6pyJckphG4RAK6z
         WIqDffZ6sUAS/UAcvoo58JZ5qWT6gsFuQ8JxBzfUqt4oWtmWSheOkZPU+tZne3CQOuBt
         eb5bCZA8VCywwpV3VfuHmdnCZ7LCgrAn6HanNt80uFLRAPVVhMud6uCKiH4ddQOuBeb4
         1uwLq3M5Y3HjJuG1jv85f5AtvyN/lbhcHuiTjgrCK8Nvp1Mzs5680Ds4Lm40TDQ4zWRo
         3NCpDzn5FCSBWKx2vsJdUiVYi3knc0HJEB9Wm+j3OOxvA7Bno3R8NGiCrEihniwUfVTr
         7sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778720490; x=1779325290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P/TJCCyg3GNNF+cgc4ppW8pNVQF/2kpZ5OGVnmEUE2Y=;
        b=NcGpXP7IDa69uLzC6P5Pu9S8+SGP7SO9Mk2GaV+B9CE5B0SJtsGeZzr5DwzqmIcClF
         g1NoykhNmRtfXsspqR5cBNrV+22rMEMHpuk23qERuir1xDAkKcsqL8OBxDwAuVy7Sqlv
         7rAIUvQuQDQPVBFz5llF/nU46yM4syIiEplpQx+lq2oTTc4MzpLLi70tNfwqH4hunHF+
         W+TrlNwNeDZRmJW93DcJ8tlvNP9Lv+NHsfBTggU6jS2AMUkXVx2SogQ7JgSYOm/ZUiDO
         xGFs5NB7lWQ8xY7bz497KKidDKYzdDS5/QXfUIZ6LMXDxvWMwvsZZE+P47QMjRzN0buM
         PQRA==
X-Forwarded-Encrypted: i=1; AFNElJ8iY2TERLrrF0fPPftF3LoyyXmA3GCfy0GG/+FwU9T+hTkCaOoDl6TQ04SroiqpUd6oaMgIRHrob3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynF9gjU/LxFxr4HntkAr/RWskTmjaijm0gXF6SuwVc30+ZUa18
	4D9Z/aLDDn02URMoJfzQJ7Bw3kkPk2VlS6MfOL5RIJFxe/8T8X5xli0R
X-Gm-Gg: Acq92OGL+3zAUXpmK6EqvjW9oLOm85Pr8ArxE782UIpTTzCQxdrpZeluF/jgbjSpYDD
	1cLPann0b1/Utd08/QvWKemhRWUg2thPFXEnLfIW2MJvUh+Yf5YYjtm2MgCtu3Y+XwLsJL1bJa9
	8iRG2Wklp0q0wQTX657AFPnb3eGLv34CVttdVmnA8sLgfXEvtqJ8wCC6rRZcRmIlzItxTZSJotL
	t7woeKQAZD6t3WnFdKbwbTuu2G5rYZIKopSqaGqSvybrRuM13PWW4Xb3oJDV9Oj/r7zNpx9EcfM
	vJDMj9bP4Yc756xHr9HCk1903I85hkfAqEX3At1SnsbCyOZHu7Nfi3pzTJPjlwXGeTqD3iRb5Sp
	Dj3zGfpE6I1wpikeNc3TjunL7S2/FmdSMxceA8tJNH91+qFUQYYYUjA6hIgL7bH6td7F8/NCIz5
	jhCMuZR0jzx1nfw05Hb55Q5aAtT1+K6Bxl44XT
X-Received: by 2002:a17:903:bc2:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2bd27139901mr47310305ad.16.1778720489578;
        Wed, 13 May 2026 18:01:29 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fbc05sm4645895ad.57.2026.05.13.18.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:01:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 14 May 2026 14:01:11 +1300
Subject: [PATCH v2 1/2] iio: light: veml6030: fix channel type when pushing
 events
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-veml6030-fixes-v2-1-abdd5837be50@gmail.com>
References: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
In-Reply-To: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778720474; l=1127;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=DpZqDpgWFdqDiUupU3hy+hp66wdYNBtQrPd1t+nKiRM=;
 b=OrFqgirHI7m+cM4ZxxgUcUAQM1us2yF8oTs0fAFVY6/ocWNtSozbqMaHSve1Ak/YMHkAT7vNQ
 zldFm4QZ10pC8uirk0rCYe9S9qWdG1/XtG2wmY8jMPFlLrvsbw27Pxb
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
Use the correct channel type.

When at it, fix minor checkpatch code style warning (alignment).

Cc: stable@vger.kernel.org
Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 6bcacae3863c..da8c32cabfd6 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -875,9 +875,11 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
 	else
 		evtdir = IIO_EV_DIR_FALLING;
 
-	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
-					0, IIO_EV_TYPE_THRESH, evtdir),
-					iio_get_time_ns(indio_dev));
+	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+						       0,
+						       IIO_EV_TYPE_THRESH,
+						       evtdir),
+		       iio_get_time_ns(indio_dev));
 
 	return IRQ_HANDLED;
 }

-- 
2.43.0

