Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81118421A07
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207116; cv=none; b=uIxyycYDwXmgi8nry8krO4Fbtn8qxFok4Fvr6oMP+doat0o4QvQYvbqx7pxnXIyqgE2ctXZRwEFXhJW+y9ge26IzgOtIJ1RkY4o9iinQZDtIYB0wBfcszrIEhYAQdB31b+xDTv41vmOrm/t3+ZssZ0ibjj0oURwUE34n6Q2knrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207116; c=relaxed/simple;
	bh=Ph5O7sdd3xwfE3bGAXgs+upkajj44wtizah1gh+lDoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naHaR1ijELDBvc+ruqLdp+NX23mHX+3d1N/X5GhBP46YMSSHgrU7sjdlXsOp02m1EnkShP+JmOHh7iEnPPUHOMWYfQPILQLelumNKj6XAOLIpHLdfNSRaFhY7avx2VLDVh1pSgwNWEkuC8JNkDGQEhzgEI0Cr13UhMpQpG/AWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCidRpY5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCidRpY5"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493f4638f4aso27860255e9.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784207113; x=1784811913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HkXEhjWw8RR39Frioop/yuVyZX8tqDl1VlP5PStyz6E=;
        b=QCidRpY5AiaVnAGt/yYU+uDtue9x62zA+cXUGm40lcq9F61JrpLXcF9VtcxXSjo1vv
         qhzNqXq3KxPXAW190NuvTegi2UNDwCCtJhNxaXR+MIPGhgQ2Dm6jnQf8/XGsddWZywtu
         tK0YPLZ7FZ4rSxKp29JCbBRD9afsHb0bt87y01CS27vUiSOUx06fTcDR2IfjGJ/f4yuG
         ljfyls41AveZEoFpkyfrKWFyjxZ8F7vtFj5t9u7WhhJNHJySsiCRelAr6kQBexJhY+dg
         hPA3V4nrXC21Hem5fA8vX1aLOMdNjALlaZAI1QHKCGpxcHKQIvyfKvDj+1OMRUjWvHLL
         wQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784207113; x=1784811913;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkXEhjWw8RR39Frioop/yuVyZX8tqDl1VlP5PStyz6E=;
        b=tFTZosnNCuT0fPiF3bh9YhJivIAe9ycH6gFg2DyOQ6clPfybop/mFleAkS0IO3+mzr
         KFQMK6QbF8whdWP0A15stDcNR1kmVuSaSEE4AG0/paxkBDL96VRDqlkrVGjdC5XwzhIm
         +DRT0Ik5JHi69VNuttx+hxU6BtlEW5erUObgKHYK4ysP78zzgcX21MFKHsES3+PawuNr
         Wd2+rVUW5EKDx+UEUq0kPAeoDvtDZiEyvb94fnCWkF+1YQK4kgoHSYsHWjfOkQuTJUly
         NYKdc+5uKLIBHdaaI/SkHubB2uNf40v6zmlOEGTyy7xFfye/Fex277N/1Guf5rwoOEz7
         lbLw==
X-Forwarded-Encrypted: i=1; AHgh+RpAPKh5l2wV4xaxKh8MLeOAZYv8J+Lrl66KmHAAXgYuSVW1EI6JbYI+BvzE3z9oUtM826IgyftooG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWewaDLwbtL41vFkvz1NEiNc5sS5M5mIlzEhJ8jNQo9D6Q2W8
	t9Kbv6hM64FLYGUYw+spPZPGqkfph9aR062SsiE2hKH48vbOObPCQRQw
X-Gm-Gg: AfdE7cmwJd80ni4hYamSnYYmVKGT53c5ypp/3hqukRB6qWTw684Cuuolw91rIsE8mMD
	VZiLVE0LuTvgXFcrvcqqIU4Mo6NE9x02err3KUYRx8SoPogUScmsKxtCkfGss24wDxEK/J2qmh9
	0WrWAwewCMojek6pTxYUvy71+NiCegqtoyW1mVa3dD5w3q4MQTvp8PLCgPfBIwhrdnDxzDJAHvR
	dQWKrUj+y830skCMMGWLghwcVXN0K7yi3YGUNhlzdA1YbdrGdPQ76PnyoLW/W9qc03G23Qz0IkN
	YAzKjTqis4fq6c3voFLKb8g4siji6HQxhAwrDtL6XHrtoWoObtm5auT/2NuKItehSshwch7gDir
	AZfHkk99z2s0Y9rahHpkj+LXkCmGyWrCsgI2KFbwOf6BESOZfvvVCQFt4LMPjuaUMk/Nt1BkvdY
	gTIgxuO63ZW7dvWub5j5yvpL31raq4ge0wKkIQKOF9IGt8nqBqzoAama5WR84vEynXXLwR0BJHX
	tZQIPVT4vaCK5rDc0kLlBks1h+7qeDAvP+uGIkunNu4mQfv2BuJp2qZX7+AotepHDehbYyyogc9
	5uH44eW+zJJNMhbY8KbDfl1DmjepiAvxP30y7/dd1gW154Gqw8oVhS22dBIBhN4huXSLjdtcCUD
	ZZmWGEKXYJ8fk
X-Received: by 2002:a05:600c:354e:b0:493:e38b:182d with SMTP id 5b1f17b1804b1-493f881800dmr243163685e9.22.1784207112542;
        Thu, 16 Jul 2026 06:05:12 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e7d22asm57635025e9.1.2026.07.16.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:05:12 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:05:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match
 data
Message-ID: <20260716150509.00002557@gmail.com>
In-Reply-To: <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
	<20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 13:14:18 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Verify that chip_info pointer is not NULL. If a user binds the driver
> using driver_override via sysfs with a device name not present in the
> id_table or of_match_table, match data will be NULL.
> 
> Fixes: 0eb1728461a1 ("iio: dac: ad5686: drop enum id")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260710113149.53EC51F000E9@smtp.kernel.org/
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 713fe71ad1e7..d34250647aa4 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -479,6 +479,9 @@ int ad5686_probe(struct device *dev,
>  	struct iio_dev *indio_dev;
>  	int ret, i;
>  
> +	if (!chip_info)
> +		return -ENODEV;
> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return  -ENOMEM;
> 

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
