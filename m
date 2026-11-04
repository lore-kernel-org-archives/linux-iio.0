Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783650;
	b=nOSP1gcW6bjt5wbV8L7+pS187qKMGP13qi+ssH9kvDatH9yu351U9fq9ZtMYug4eZ/cS
	 C3Tp+S3JhJ7MePkGeln4ZOv20I2OO1mc7Tt3x+uCMILBVxPBSOPs6+GMgzLSwv+eou7cZ
	 Vy6zFUvEWVdSnMIIgkzKLYlTvh+1+nHROcLc9K7lCj3GuL/bqTzjAAOlwEF/tX0G71OEa
	 aZa/6t4CbCAfQoZsMEPTCWrr9xHxXpv96q8Ai0M1Bwh941V29gbjXRQNY77U0jTK3SVBT
	 rODlFAkhnb5L3uPQ0LRzaa+rYa+AFgBFKe4ObjxJOKuiqnprE+zs17NdjUS1ZdZ8rpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RZxgyHLYpQfVmNKk/t6Xpk45GoPrOkICCosBntPfxgI=;
	b=mGvWMy76LySOaJYWJs1/mNrriX38MH/g5Zu/ZF4XgK92X1QUxXO+DBpxenAq0T+AzOS6
	 97pNzxKxXDulk4xXgjhEKDehvRR8slyPDUtEVjSeDACRpIuIC+L7tG6rwsGW9lQHxHdHd
	 OSJTvQ0Be0hwjV6kf30D6vaoVz8JORlVMNQnkbozfxSJofH4yU5+krpQAW1vdn/v3iFC7
	 REn7t0Q5F6jNl+6yyCeaDJpbgWEx6wt1LTy/Gdz6mGHKyGHr/ve3N5I7d4pg9Bp37CDrQ
	 mdYtUjjTJneYu8eE6uca7D7u5I8Yhr1h1VxYYU/nAZE3Jk3kxk7rfemZ4++vS+tbypQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovEBdQu7;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951F5606A31B
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 09:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 951F5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovEBdQu7
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ba3fba0080so310785e87.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 01:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783648; x=1794388448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZxgyHLYpQfVmNKk/t6Xpk45GoPrOkICCosBntPfxgI=;
        b=ovEBdQu7mXQSVLjL2PxY7Ip5IROKkDFYz/TXSQWSy4CCdAVh7GRNasKRXcNPzYYmHJ
         4b2hHeO44tbZpLSSutXl89L2djpPTQ3BOyipOXWssnxASfmfGdJVKX7uEA/APWp0sXN+
         ox0avHxpHXESL0o8f1+IHjnBeGunRT1QxpDSzx3BWkHgKke9nFIqdbGV5p8kHXRTsaPe
         xlTDptG3+G0WDaV69gejTKSjGeUU18PudEP/nXC+I+xVNClaJYZhYtV1ZjxjJBJmLlCE
         ESW9CAEd7xLIZcHYlrmE9M2js8cjbvUdZjYt4KoOltUvVRjHO0yYTxnOX5AzwIT9NhVK
         Q6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783648; x=1794388448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZxgyHLYpQfVmNKk/t6Xpk45GoPrOkICCosBntPfxgI=;
        b=gKD1o/5aNVgkRXfGBNRQkCeILxP5E1WQNQiWvsRPWFe/gjcna30lWPnvTsB6uDsKd3
         LHcnjxlxC5J8Ugm5Z1Q1UG/gUkGUR+FuMmvRgO98HlQpIr1pwI1H2nYptXpJNrqvy4Yg
         WRN2BclyPIdXdw945q9lf4UiFHCgG4hYtoz71DTKwoMruNrYvkftT7dj3Yb3D6vZqc7E
         qNfZ0enzvWAVuLP+pZxS6Q7YFEKa8iEo6g9szsuGGBNxMqSESlFGqVKwULoHJrmIlYzO
         SqwnvdzJJDjrmPgaIYY7FPpJjYqcC8tiW3+56UKEB3oOTp9MjZze4efqLxqb5x+m6iRE
         bGzA==
X-Forwarded-Encrypted: i=1; AKwUvBym5EDNJRJCPBu5cDw10o53iBMMRNJYh45GTb4JEQFWRZKAUcg8Yg2w29c+g55FpxdvQd4rxKpk9Bs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ldKLXXrW7XHYR1kKLOjv4a84FpprHcp4bCwqRElxza+SPmX06
	Ijw9Z3xzzIF5OWEWD0ghI3PoUGfZeAgT8EsNS6kd+r5XGSqsbJjT6dqN
X-Gm-Gg: AYBFou3BH3j9Jd3lKOhzHzBEoHVLtysM+tMJe2a7a1b7SEzCLu4PfoTS2GGdlWCZgW2
	oCH1W9Z+e0sNIckNnsvWFfBcC/At5tPMQmMaCA04X+YqJ1hhLUyn1JYSzksjCmz/3e/s3H6Z41+
	MVAmQqbAvdMOqKqMJYlJtRyrN+vry5ykbg+DyZhn8IV/UjOvJpxm1C3jvoywk3TVKCPhTVSOe0R
	+Zs84B89FxATUvrh4OB2cR4uO20fmtrNs6aDQrayUrFF1FEJcCuoOMA3+Ch+Ik9zco6hsuBmx+8
	tgA/ZEkEzL2xKrJ/bqb/MYqP2fm+EaYsEE+Nuh88PrguxnIBmkW6t7WQHNo7XvHbjOwk3ODmoHZ
	gYiNOQ8ZMhtBcX6kCqkqNFvERwwApK6slBpkmYvI/tIJWLZ5fxZ+C4EsIVxcQtef8bBJCbYfxb7
	LJhNqXjtnuynkYigkWI7AmB6bUZkOoTdSBM9VofliD6jOqOnrWv+m7rBHv2aVWjG7E03YR7i+A+
	lnD/gKQcZoWIHFF47xxWw76Y9Zc+9f7HkhEX2ktLNyqXxnLQU7LRo6N/fu+5jwnlYNWhT4780p8
	uqfI/tCis3LayfLf5fL8uq/61Y4DeqgxWCrCM2Lw9cBJwxTWu2tUrOiPkhKoXKgnTeLKggL9Y1b
	F5q7xR8qJUstLw3E4jI4hPtdaz2ZvpXAIwDHJ/j1UHl5NJ7cpWI4YrEv+Iw==
X-Received: by 2002:a05:6512:3c86:b0:5bf:b27b:635f with SMTP id 2adb3069b0e04-5bfd957b6e8mr5587275e87.13.1793783647544;
        Wed, 04 Nov 2026 01:14:07 -0800 (PST)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38ab170sm313037e87.16.2026.11.04.01.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:14:07 -0800 (PST)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: pressure: dps310: fix input checks and resets
Date: Wed,  4 Nov 2026 11:13:50 +0200
Message-ID: <20261104091351.710582-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103223008.12675-1-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com> <20261103223008.12675-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026, Rupesh Majhi wrote:
> Jonathan is holding this series for your Tested-by. Could you give it a
> run on the ZTS8032 when you have time?

Tested on a ZTS8032, on iio testing backported to 6.12:

- 0 and 0.5 are rejected for both rates and ratios.
- 64x at 4 Hz survives a timeout reset forced by putting the chip in
  standby behind the driver's back.
- A warm reboot during a FIFO capture: FIFO_EN is clear after probe
  and reads work.

Tested-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Paulius
