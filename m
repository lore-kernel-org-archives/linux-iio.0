Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181E2E7BD3
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977737; cv=none; b=jxr0G3eP5XZXj/Y8vG3Y02Q8kAn9Y4QkSavei66wAliqIm6hVEf9aGHiIJOH2BYU70rInOKT0J/OLsBrUeZhUJ8jczA5PLlPD9oGBMTe5upjJtmvnkch+SddzHOIDf+IrSew0XGFhvedT+0tXrDrFBJ52WBwZamjyg9WY8USKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977737; c=relaxed/simple;
	bh=uYkbjUxKxZ2WrsbVYP5zIg8sM3STYeehqLx9On9ms1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poIYg7DrhmM83avWmt1fVnKq+L7cOrLfI26DK8INupVgKMLcX9fW9Ii6BGqsIdfck+azl9NBkjH6CwxgJWcgisu8qjTqnwtwiftyHGi6UQ1NGVZiHIJFBAI/GXVZ2rq0NS64dQTdQDIFRMDxobzFqIQ6L0mYn7U/KP5K+n0bqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci6yt6Tz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci6yt6Tz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37cbcf49deaso1516896a91.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977736; x=1782582536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6nfe1mUm5w2Z2at1HYxXfkhKWhlbFCWlsl4N5d/Kxs=;
        b=ci6yt6Tz0MRpqgZ3TlN7pGSEPysRkOQw+KY+R/2wRVAPwj2vpOyynqTMrVCezzokLb
         fNaG2pR4VHz/cIwfsFhCIiGUphotLLCGwk4rDpRNnBR8UDWjnZ14NR3q34ysai6xdOdZ
         5M9K1uo313Lx98ezNakhZe1GrH0ojDn23ZNeaS11ky/G0at0k2YLhiRjUdK/wh6wg3Nw
         OuL4wj+tI0+xbkdWlPX56rW16aaTVggNJudGJwR+ePWvXarcBqtGd8jom8zDcL15QDAJ
         WUA/cnY2nmwkDRiuN3kgrr4I0rbkSG4phknraVgASDH+ZMo8pc2ceZUea7Vq6Dua5URU
         K/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977736; x=1782582536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6nfe1mUm5w2Z2at1HYxXfkhKWhlbFCWlsl4N5d/Kxs=;
        b=GLEqbRjk+QicWNtVO7BGRgm7NHNtg803fGt1S3pCqD8ENWnVcN8w8I/DHp9yeEuhJG
         YKjpbyKWP3WvTlW7tSFEiimGslM4MXkzEAiQvBub+K/PMx7MrF9OfR1CvWp3P4CPMifQ
         x07C45jnRG+tMFFQy9xSB7+1+3V9mFOAsQ0t7fU8DTkqVMHpvPgYaJIz97bJrvn6JVfR
         z8sq2YcJBZpNCwbtHE0llYrFUkArS6esonAUcno5Vu/iMq4VigYOHqVE6cyykz5PEGLG
         z7L3OFwtrKg3BrlrZJczvOvWpnTPS3JDGle/vSHc6BtNgIAxAHLXiMpQ1URxMjY+2TnS
         JcgA==
X-Forwarded-Encrypted: i=1; AHgh+Rp54IWbGbP4bkZmqKznJ4EXsjSGFnGZyzhGdSiK8DabzrJCB0ljNcfIlkhMJPc4YXRVBeVzpLNTOPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE36Q13AejiTSA/4jUrrQLM59dT9ppOp1N0VhSP1j1R14Uw/j7
	Tlup2goRK2nELYEFp/rJDwCKZ9kfoX5kyr0dAIPMhJwJ5k5hxn/veZxk
X-Gm-Gg: AfdE7ckO5aduvxOymnVEoPna+2uNRvDKV2nc511LxR5Wxj/RVHDNKRH23zqtEJQvJS6
	lJMDr0USODxAn3RHcYc6DYwT8XExDbc9vyg/Ry8skFU+TDIbfufhAF7N0P8bbySqPafdE6zYsUZ
	MxZ7JVVS1pck9bB4ZMX3szViFob22yc9oGhoOb2+LTvzLf18Qj9acOtQvd4HTS6oybS33neIeZ4
	VOALBsBMgwpb3jnCt3vwmdO9Jv2SAPfJNW87RZVLUFkWDFfc1+LV3lXOnQKcMpf4ojp8Ed9whP8
	8kp6CIapVckZOTVFf1KDzRADBhDrJWFeMcNAkeWUU4DVV+Nha/RCcyLX7U8eDtdDCD6I+/McsvW
	LtdZWrGRHOufz3mGW8Mn9yLlujk24gD0Of5sdFwcFiA2XDbQaMeat4m9fjhprRsC0Xm3+kws6/v
	AAfgsr0S+mUy8HElAeqXHI9lKroTOqZFRlGgeMvn0NLCdPuG2DvTwsbonXJYYVtzjLd7Iwg8+kV
	u4aYnTF
X-Received: by 2002:a17:90b:48cf:b0:37c:b248:1a58 with SMTP id 98e67ed59e1d1-37d15e13b28mr9737261a91.24.1781977735782;
        Sat, 20 Jun 2026 10:48:55 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:6bd2:aa0a:1945:47e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1536b049sm6344222a91.2.2026.06.20.10.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:48:55 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iio: adc: ti-adc108s102: log buffer setup failure in probe
Date: Sat, 20 Jun 2026 23:10:55 +0530
Message-ID: <20260620174708.111470-4-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620174708.111470-1-prashantrahul23@gmail.com>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Errors are logged when enabling the regulator or adding the cleanup
action fails, but not when buffer setup fails. Log the error returned by
the buffer setup path as well.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 drivers/iio/adc/ti-adc108s102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 7d615e2bbf39..440afe584f5d 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -256,7 +256,7 @@ static int adc108s102_probe(struct spi_device *spi)
 					      &adc108s102_trigger_handler,
 					      NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");
 
 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
-- 
2.54.0

