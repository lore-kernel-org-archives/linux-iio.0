Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76461A9FAA
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900533; cv=none; b=U5ft5C2EI42PHh0tTPdiKx/mprw/AH2uEwvaptfHxb6LuPaH0Nljo9FMXZiu/G/6RtGEvSmSKHbd9ueAG1MZl6ndMddrosfZu7VJROe8I2SMd6ZtTa+euW8w78s2eQjmQ1IFc+pw2LMxYH2NFtIv7x5mUQl53zTvL4ytZccI7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900533; c=relaxed/simple;
	bh=sUUTc4p7Q7MAk0TuxPkh3WHIjMo9QRDZGHXqzu1O01c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+fsykWhPyu24hkCHCDXiPOycK8El/7olYoWqOYaaW9hMz6pM2IZVV2BafSYdiuFC28FblOo42eDPWO06te81Pj14xVsw0igvfBwMIyUf+whdtGvh+Pg0B70LGZH2DSbqcXQC7eO6uiJW7A0HneLSteZVqxmRjriKtB+uDAcxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAJGrccW; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAJGrccW"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79495b1aaa7so44344787b3.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771900532; x=1772505332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iusn9u4xQvFJzEMelWbMLj7LoP4DkYbFjiqTDekST5o=;
        b=AAJGrccW6VcC//BwO6jckPpRLhhcDVA96MghbutJxCNLfI4fOtLuIVSMCOUT9udrH3
         KC2C7NP9SK15ol5ugtyTuxczDkn0G5OxPCIvrzn4BfV/EBN0mYlCMaZqOjiHEOQxuPJh
         ot0Qj/CwezWQLycDzUyWoNtqFeQMTZ72MB6WrNnPrZB+liW2ATU6yzGthBWTlSaxmddV
         I3t1KaZ942XDURuSU7+QSaiyWk0EufEe3+ahdLPAG7EJf7vnIOgtAwVK2gTlZNYHAw2s
         ja5C1pYiDi4EIH9b+BAr804z3Z7oF2hM0PzRWLekl2aCXTtYnz2NfizXxub/hYCcfPf5
         SQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771900532; x=1772505332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iusn9u4xQvFJzEMelWbMLj7LoP4DkYbFjiqTDekST5o=;
        b=onEUCzvnO2RGEo6Ly0npjuuklGM9kXbxwWaFJ2sUBuGuyedwjnacMvxSt/xN6314Ao
         gI4o8pTQr/JpTNLhd9OVZnr66NMs+EQDnVcJaCHxNkhRJjQanXpwcnp45DipcU1KRI0t
         Pk7FDTwi2zbZVoJ+0FjFXquWA5nWXpLQTje0iYGNgpGNLwF3sz+ehop1CIJQ0bQYBlFO
         4MA937blL9MYFMehIYRduYLUKK4qHGvWZdPCxIGVlnrzk/JuV2HqXAjyD71hWjbXYWtn
         dFpItl7ug+7jQgazX8ETAEgsoJ0oBgwsYJvv+vojAFc3sktj4eeDjx2bUgTcUjTuXEv/
         uL3w==
X-Forwarded-Encrypted: i=1; AJvYcCU2AYEPsvfeZsU1lEXvPhlvsfj4Uc5/d68biGzusStrV51diUY+olVmD4DelvBaLVumyFpzsIPvYac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLrYZ34xxZuREYCQZ+5EvLRYFmjPmbcL+5bqr6ngilOhFXTCR
	lU3/UvVtYpdFEVxjGGkTb6EFPEfWHH/iBA5LdEBEIGtZ6S+Z0yL98Z0t
X-Gm-Gg: ATEYQzwaDgZhMYGuNpAMal8cm0cczWFQDylbd5SPH1U8UkgTvy/OvDqz4/m/kK8bD0q
	lrPKTSXDbWm7PqaUMXzB5fifqwNiCg8H33cfTtOUjCdd+afiy6taTxqeM7bPsnzxW8M1uZ77vOX
	yPl8F/1W2DJVn0rU6YuY3y31RwVn11keChO5uVg5iyeF2xkFC9bkQACfrdlcV8cYWqhYP8yH3d6
	E2fSPZx3xApNa2/XBTWG5G4Dnlo5gou0T88XANN+FKB1r4fUWE7vHX5V7hsmokTYPbOsHf9B3OO
	ze2PdMcDsLrfErYnrodIPSupfQ6JNbAt0xCViYR2Urt9iAMdtukOS24+yxavs96j4CIWuhsIq3d
	GfvJraRXWZ74gJ0zh6xHsu7DKr7w0GeRR85aMplnMJyOmTdxjcZ3Y4P2Y3meqX4kGJIlMckxjHL
	vQxmD84klgIfqGKofxHhpinK6i+xCIBMgyA4tsX54SQ3NAr07IttICka/fKmafKWEQ6sp1xRWrJ
	s7hef1tFC80f4rnbpdmo/3H
X-Received: by 2002:a05:690c:e3ee:b0:794:ea75:4856 with SMTP id 00721157ae682-79828f36062mr94265277b3.23.1771900531787;
        Mon, 23 Feb 2026 18:35:31 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982d985074sm39585407b3.0.2026.02.23.18.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:35:31 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v2 1/4] iio: gyro: mpu3050: Fix incorrect free_irq() variable
Date: Mon, 23 Feb 2026 20:35:08 -0600
Message-ID: <20260224023511.274038-2-ethantidmore06@gmail.com>
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

The handler for the IRQ part of this driver is mpu3050->trig but,
in the teardown free_irq() is called with handler mpu3050:

	ret = request_threaded_irq(irq,
				   mpu3050_irq_handler,
				   mpu3050_irq_thread,
				   irq_trig,
				   mpu3050->trig->name,
				   mpu3050->trig);

...

void mpu3050_common_remove(struct device *dev)
{

...

	if (mpu3050->irq)
		free_irq(mpu3050->irq, mpu3050);
	iio_device_unregister(indio_dev);
	mpu3050_power_down(mpu3050);
}

Use correct IRQ handler when calling free_irq().

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ee2fcd20545d..06162d886b59 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1261,7 +1261,7 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_disable(dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (mpu3050->irq)
-		free_irq(mpu3050->irq, mpu3050);
+		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_device_unregister(indio_dev);
 	mpu3050_power_down(mpu3050);
 }
-- 
2.53.0

