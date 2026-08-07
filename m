Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FE46AF2D
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098037; cv=none; b=L9I+RMZ0uZxrPYeHOGst6a8BORFXdqpGrfEW3Gqt/ma3ygmRmQT58ATQUKUe73neYlin7lkq+U+vKSRXnLGxO8ud5kVa4hvt3rk3LH57c8GWh/FaJFoL4v3ttY8BFSYihbxNzU0johsd8S3l0mfLy8QPJYSI7XMYDY1iOy9O0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098037; c=relaxed/simple;
	bh=zHvxZJ1HTzk1ABYWJzT5MESmqHko3h8ghIIuYn8l+1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMFO663jrQn7R83PAvyMAuFKrBc+hal8dUTb5e9IcRLa+JzyMJoluU3CoUzjrfwWNfAXH2FpE90Bwx5SDRTUvVrWCqIzf+ujfTXa6fIMr+E1B2nHEwQRy4X6Nq0WOJMlPnVg3ZC/J6l5keiDazBXqIxcpcuU9vu1FwpsKncUlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAJWHKMa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAJWHKMa"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957eefd361so23915315e9.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786098034; x=1786702834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sV2OJp2pqrql39Us6FANqWDFNjIhbcgZdjPsmWI3EPI=;
        b=HAJWHKMa3rSzC/Vk/ht5i4iIELdy5gGyNe1N9DslCCXf1mcK217OmdunYNZJeNVcuP
         wR86TLji3UuoHjRor7j4Dgg49eBm5aXcekBUXVhZXWb7tsyLuO+TguNzlhxEhuqz0vsS
         rCq2GY1268xt94wWESbyNOjsvcS+417Mp+DlmVz7PV3GtnWBhoOJGjETINutuMde9oUV
         BkEEmks+dEaiMkXk26EZ7eOEvDlLsB4xADToEgxtdGR8H9e2KY23rhzty+fyyjpB5efH
         7pOoKYyyH8N+8dkk+Jtnk38Fii2+YDyj7DLYYwwOfIw2M4Y1GJsQtD9IdppAuhYdlAIr
         UuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786098034; x=1786702834;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sV2OJp2pqrql39Us6FANqWDFNjIhbcgZdjPsmWI3EPI=;
        b=QM3hvyXiO4HvHrGxZZC6EApvz16jvPneyaM28CEb8k/nP+647CGENVPStnPJkuBKsO
         fzdkGky/4LVmDHwZAoVEVK6n0mAdTOh4wSJmGDHrHGEMucCQSwkLLLZqjNv37r1FP6WB
         WwSTTSFWx2gI1Yi9u2Ag/r3GkxGSbxpB7mKH1B8VEUl5mS1TrOB/o1op4jaFTQncVA+2
         TNVF+PhS0nWTMYX2/XXNbba6W2C687rfR3eicfQuINaiDWub+XXvH2hjDSD7UCGzysK+
         9+n3QRGqvsDkNYfyUzL7nKhShxSVXTWtl+VmXTkogBtWhYmd4b9a4ATFOtbU74pqvv1y
         Hf3w==
X-Forwarded-Encrypted: i=1; AHgh+RoBTXIG0DoGpBbOz1t5f8R+CpYFh8rJhu6GeDgKPpzXAzzzmn0L08UBE2suHTiI222cMnAAqPrkt0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTJvi5p5PGlgwSfo52I15TNS4JOcS/MsmQHqLj/EJwh9F6T/f
	zO+Enbfr/fMdK9zGX1qwz8qLcTM1WuyioKcqcuvZRgOoacD79eYzpt7Q
X-Gm-Gg: AR+sD13Ck5J1neww8sp//oSK9/hxfRMFZABjjPSQWgmO2GhyHPiY9YChIfcuI6I0xAW
	qorPIVbew8jr0AHMn372/025at9+DHcdJ5SO9f7AEAEZTdzICzgPwH/Wrqd6Xxq0JZmsaunZQXG
	231m3TTd/DdrvEPRquANJBjQWnqgsNHywDfs8d/dz8H/T8/1dVVD/2IfbpcV6bz8/wEww9OEMsd
	HqCm59P0K+7CIMc1x9WOw2k3GtOtmVyPky4scYl8taMNNRdyO6gArDVqjfuaUXqJy+lI+n87qes
	n+CSS7oiuldCqFGtbMYqezuA40H4ha6y6+nWxxCiVzCmzY1vzkyvNzX/EhrPCMFoegpu6ZwOdfw
	FAvWGPAg5gcNXTpqFSKPPW61rO7whKELhlKbDVsMHUEuVElDo3THILTRcGbeyD2NhqQNqSJa8FK
	7h++1XDgUvHbhZ6EZJFlx3eHZaUSt9yIS4NwS/Ffuyc/nHGk0f61HcgX3YtfykwGQhieySFTwGP
	EB1W1QVGI+xSXfIw2P7jdwF7fB13bJufZcQ67OdqwXV0gMTuB2nvpDkw3P+KUyFRV7+WmJ4LaRa
	cvGcY51UQvJpQiz+VZHSiIA+675gxfwFqUpas+Izb+u9TLFAxzCp3bE8p/w0eavKspGR+QGe2GE
	BbAUhxpmU7ZAb7L/2lUmq8HU2tOXvMyM/IyrVlpH5M8zXPK9J+mp/STrcTu85nBfAcHpvJAo=
X-Received: by 2002:a05:600c:6612:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4995e0ebf84mr44035485e9.17.1786098013509;
        Fri, 07 Aug 2026 03:20:13 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f9424sm22957005e9.8.2026.08.07.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:20:13 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:20:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: fxls8962af: clamp FIFO sample count
Message-ID: <20260807122011.0000086d@gmail.com>
In-Reply-To: <20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc>
References: <20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 05:14:53 +0800
"Shengzhuo Wei" <me@cherr.cc> wrote:

> fxls8962af_fifo_flush() copies the number of samples the device reports
> in its FIFO status register into an on-stack buffer
> 
> 	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
> 
> which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The
> sample count is read from the BUF_STATUS register and only masked to its
> 6 valid bits:
> 
> 	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
> 
> so it can be 0..63, while the buffer holds 32. The only other limit,
> the watermark, is applied on the write path (fxls8962af_set_watermark)
> but not here on the read path. count samples are then transferred into
> buffer[]:
> 
> 	fxls8962af_fifo_transfer(data, buffer, count);
> 
> fxls8962af_fifo_transfer() reads count * 6 bytes through regmap, so a
> malfunctioning, malicious or counterfeit accelerometer (or an attacker
> tampering with the I2C/SPI bus) that reports up to 63 samples writes up
> to 378 bytes into the 192-byte buffer: a stack out-of-bounds write of up
> to 186 bytes that clobbers the stack canary, saved registers and the
> return address.
> 
> Clamp count to FXLS8962AF_FIFO_LENGTH, the number of samples buffer[] is
> sized for, before the transfer, mirroring the watermark clamp already
> done in fxls8962af_set_watermark(). A well-formed flush reports at most
> FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are unaffected.
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> Cc: stable@vger.kernel.org
> Assisted-by: GLM:5.2
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---

Makes sense.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
