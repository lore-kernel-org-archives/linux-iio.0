Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052C388E57
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647827; cv=none; b=jggpMzW13wZvrV4ZOHGp1j77ZxeZMTvPghnr6KIIr23PZ1ggioDwSyrBstg6nnGnRZwaULph/CECFWnb+kANOqqpoyw5zj1UjixrrVS+Wod3/fi7aCXGJ1Hh4QCFTnnEgQp+Fqf50xneAuF57THzbbil2xNXhADxUFv54ChmCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647827; c=relaxed/simple;
	bh=/vOOXoRFd80rf12YbVI8A9vnK+2w6WdrvOSLeNdAIU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTvXSfAA3L3B61OlYYS8zUwHr9dbuND6bhr6AUL77LAKxsBC1wLD6DlRDzigRYT1PnReAz/KUBop3JQBl0nrPq0uXnIKhmH34eY2jclWwsW27lgBG1fA/iH5s/mStJMOMbc+rRCU21u7M6n3GFrXxQun6Ym3jH7kQ5OV0HZoNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jynYSsDS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jynYSsDS"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso2627715a12.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 21:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778647825; x=1779252625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBRBa2zjJe16rT7hXzyvRJvpoMNnm7ChCgpZnCI8ZZU=;
        b=jynYSsDSu4hOqre0wPTLOFuVR/8xS7EbYy12ci3oa+PtEeJGQs/AxlPlrObHTBxq40
         1g8bTM5pLjiwr6peGInKBey2iCwRwJN36RRd7bAAf/DXhNfyqHFqo1lAkvAznPQQIJMD
         zpFgb5aALZU1Ek+4WRpkhVHng/RUfH3HIrqZp3h6fi2AW6sImTDEPZ/A3ElMxecjxL2Y
         Eu6gRSJouD77MrXycQ7LF0w/+30XXwObB7XXYFMYd67FuZFG6v3dXmYF2Pf+Jdo0qTxO
         W6LhNntmiIAFSkmEyLtsi5hsgmacq9spoTcYG+i8lNg9kJMCXvpLDr7L8v5dUz5MQdPV
         1vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647825; x=1779252625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBRBa2zjJe16rT7hXzyvRJvpoMNnm7ChCgpZnCI8ZZU=;
        b=HqiA6f6udsxhgqOb0GWVCSoxKdPviTJO16Vj1SNVStJ5BhBWMJW0fD1up3PPpmsjkW
         fW30DQseFaCbVZGNdY8ddGlEIMu8PlDX5VKuf6GNG33dbM9Ea3mIsDF9z3lGreTQWLjR
         umPY3uFRwUcTaCVrgFaa3XuW/zMaM9BRGqkoQKQ88+KhjuJq63iZFi9ToyCAH0L66wdJ
         nhKxDE+a7/2blU2jUzL+5sXS2F6/h1yetOM1wrifK7HeXyZMuNTD1K/Feg/LTiYZrrxH
         Y2hm/i6Bur3H90XvNThIDG8mcMuPcSY/H03KkH2oD7oekEav8JPPjJTA3/IwyQhY+SwM
         YZzA==
X-Gm-Message-State: AOJu0Yw+QW6aOYR+3RZ7ahiwSlKKaeZSzI0UOvBvkYTOS+LHre21HMij
	86W1IAGMwT53gBt+45cwNZiJm6spnOQQEqfwe1nkSI2JnJhLfBo9WGHP
X-Gm-Gg: Acq92OEBzU+K4Q7QWuAGsCI/Jk09ZjpQJK2r93hLQTWsZAjyeMqt3dpoq8l5wD/S5AA
	hXcfTKTewFcJHOkgGT9h/RBNLOJStz/sXSGcUvB5zBKSJ4ISw8HHVIuk/leT2mCGTIxnO69yLWt
	NRDjGemQJGgxUu7shT7/oAD/xH/MpRPRkz5bSRt3kiCp3WNr9oqaewLb/0huVD04ypiXp4scA0n
	5FoKjr3ixkdB3KPbUXfM0dF9VTEOLq2gequGUBZXNTDSg+ahiDlBRyVgbS3AKaK+P3ByAwBzH/m
	9D5fX1+jr4ZmR+H3zr8vvEoozuS/xtdeqnwirieUmul+Ya/exnajlAheP//l8mY0IgORSCBImHD
	9bZ5z2pSt92BKbYEgE/oTLeGOYJyeNkQWK3RNLj8jFQND0KKfpGWXSH4+LpBZDBZHH2lhOXU8sx
	jaYt8S56ZtpPahrmJou1m8z4077KR+TMPEc8kv
X-Received: by 2002:a05:6a21:6d8d:b0:3a3:171f:6b23 with SMTP id adf61e73a8af0-3af7bafc5aamr1960301637.0.1778647825262;
        Tue, 12 May 2026 21:50:25 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm32311914b3a.21.2026.05.12.21.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:50:25 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 13 May 2026 17:49:42 +1300
Subject: [PATCH v2 2/4] iio: light: veml6030: fix channel type when pushing
 events
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
In-Reply-To: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778647803; l=1072;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=/vOOXoRFd80rf12YbVI8A9vnK+2w6WdrvOSLeNdAIU8=;
 b=NviQAiylJep8PRpUWH8EY2+WSWxuAH4EX3+6hnYB0Z0SKlewQlVxXH+YnbKX6ybxZKpHrZvqz
 BYJ/iJUp5DKBXTOJFz1Sn5XLlq+oadtMrJT8ZWiQrrSYv70Lx+s3f0l
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
Use the correct channel type.
This bug was introduced in the first version of the driver.

When at it, fix minor checkpatch code style warning (alignment).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 745cf3ad7092..855f052b60c2 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -871,9 +871,11 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
 	else
 		evtdir = IIO_EV_DIR_FALLING;
 
-	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
-					0, IIO_EV_TYPE_THRESH, evtdir),
-					iio_get_time_ns(indio_dev));
+	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+						       0,
+						       IIO_EV_TYPE_THRESH,
+						       evtdir),
+			iio_get_time_ns(indio_dev));
 
 	return IRQ_HANDLED;
 }

-- 
2.43.0

