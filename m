Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262502BDC3F
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222849; cv=none; b=qmbwigfuzBhlyRS2hTTCiQbCfLIX2+DJBYtjhU71cJdRekaZTOKrUAeLL2Lz9bVFP+Rl35HXJsNSaEMQ4Ijo0L+4c/ydZbpmTRntApmkIVqiUskqASgAyDyvYkJmOrB9hZPcjAlfL7h60P88pmkQKPkITTsHxqHn6bga+iCd700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222849; c=relaxed/simple;
	bh=AmJzAwkpGNcbesSQbn3M5nVXXEHJl1Kd7Y1uVDI5uu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPfYUf1yeSMG4z7f+V49aURpsm8OzHAmlIc7bcckaP4WZx78gWCnxTceUp2qJKw5tZcprFie1Ugal8nI077e1CEm+Njzn1vDdO2QBWB1lgXUcmvFy6lF1G9XCMHxmCCLb1ymiR57P1NpCV+vLdbaalO93tfvDci8tcg9/QcxrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKLetuOT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKLetuOT"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439f59dfda2so1145916f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222846; x=1773827646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw5gX3EdSpWwdEcJs/5ar7LileEwolaW97u1s2g+7SM=;
        b=AKLetuOTqnh4za40nbNK16XFxarXK3qmtnpvbQh4nfBFmGm5ZeF04UpLII6F2REYGH
         +UUctpA7jQ1DidixRMbrPnXGKp0jaQ/AHBp4fyBM2gcyaG4GCfopUs2LrzjiTm9ePEUR
         0CGFBYBbCuR241YcNMniV0/mrumfdwWvwT9dDvteQpsuJ+IMaKV1ZJh09CYWHh7ERA+q
         68KNjXwHP09VquIfebcNXdfKtBdVvxTVLPShsMc1YIHJRp1A2jgAdWrO4v3jJcXXOfI3
         dYL52phqg0ZGN+tcdvmOh2v4+lSapvUPgUpQFEwaIaVpAR8VXQSub3XBU8Ulh+qU4e8G
         l55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222846; x=1773827646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aw5gX3EdSpWwdEcJs/5ar7LileEwolaW97u1s2g+7SM=;
        b=AmO8GFc7HDETJZJHUGUPohG6b2mg8bjmPxXAP9u58lmS4x8phGWLlGAsZjZgUcu6k5
         d92n3AGM7b6l3k3tBEYfV3/FQMwzjZh0YRt05zmQWTvl4s3cKVcWLx+VDphoGw0BNezQ
         31x73eIphihW7exmPcqb2Hh9ep6Ky7PJq8p6mya/+XcLmIzKd5l/UsmYVhOBSwsOJAnl
         dykoxNZr/RJvPl6SkZwy7ySr2vAcMG4lXLiirnOgFf68k/YtPn2leEuHagSg400s6iEJ
         012/rMPb5Rkyl6d9WxJd8aFQFDdo02eRlAWIhgdLlua2sHZw9JBpphT1AstJt7m0yEjX
         ATgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOTYm+251xG4ok7FhEQ4J0CGFsByd2nlhaq3ZNI88YtuQrNEv4wCy5+XKDtMpzLXt70ggrdAu5M5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDIua/kV0R7YcTB7+AmWQLcRHl9Cxna7VvgOG+bpM0iTsMyh5
	H3SgGpaET7s2ke6oWXC4AkHpgvX0F/im/czmsA0c2TMcb5i4QU+zOsrr
X-Gm-Gg: ATEYQzyk7QPpQmErilW8T8fcX2JmfJ3+sIf9utsZpkGEE+k/EMpryFobXctkIMZbbbV
	XJpUNIuwMwCQcC9Deus1EKnjd2eMT1mnF7NiKZhAGzGspiSRmq9BfARIPCwkqJ4Vb2+WIp6gR6/
	oyhmSWTL7koSvkWl7le4zSHFUVFHPJKRz4D72AfzzbJB6XBAwW5Z9OQU/gKsf+t3W0/4mLNCRUG
	SiYvXzAq9xtvVsxBjxR5gt/JEqqdCDQ9ioCX73IHo5iMqHad71TFaQG6QOGISIY8KkIhlJHZDzD
	cD2eIzzm7jExwY2W+gN5xvaI0Q77m46wXQeHwj32aTjAlSOlXGutoFLh3X0zrsWoIweBLDIad9E
	D+kyb8HZX1ntrUrH5WTcYWUL+BYzU9JYsX1KZ9sqi51FAFmZzlcRa39+qEpsZ3sSlwksWBAtCu+
	g3WW7ZF+yS0dw7ubQG9aYobaYAuRqQ5dBCNUQWQdTDS5OM0lzY6PRzvWeVbg==
X-Received: by 2002:a05:6000:40dc:b0:439:d750:42f6 with SMTP id ffacd0b85a97d-439f82050c4mr3857148f8f.24.1773222846480;
        Wed, 11 Mar 2026 02:54:06 -0700 (PDT)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d61esm5693608f8f.8.2026.03.11.02.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:54:06 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 3/5] iio: dac: ad5504: Align headers with IWYU principle
Date: Wed, 11 Mar 2026 09:54:03 +0000
Message-ID: <20260311095403.9908-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <abBuAZTSeTjRhyZY@ashevche-desk.local>
References: <abBuAZTSeTjRhyZY@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy,

Thank you for the detailed review across the series.

> >  #include <linux/device.h>
> Is this still being used directly.

Yes, it is still needed for `struct device` and `dev_get_platdata()`.

> >  #include <linux/kernel.h>
> And what is this for?

You are right, this appears to be a leftover. I will double-check its
usage and drop it in v3 if it's no longer needed.

> The rest of the changes looks correct, but still missing headers:
> linux/kstrtox.h
> 
> asm/byteorder.h
> 
> Might be more.

Good catch on these. I will add <asm/byteorder.h> (for cpu_to_be16()) and
<linux/kstrtox.h>. I will also do another general pass over the includes
to better align with IWYU principles before sending v3.

Regarding the probe function (Patch 4):

I will split the `struct device *dev = &spi->dev;` refactoring into its
own preparatory patch. For the scale calculation, I will restore the
`-ENODEV` check to maintain ACPI compatibility, use `ARRAY_SIZE()`
(adding <linux/array_size.h>), validate the range array indices properly,
and drop the legacy `pdata` fallback.

I will include all of these fixes in v3.

Best regards,
Taha
