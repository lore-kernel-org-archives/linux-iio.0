Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C7326924
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725438; cv=none; b=YjLB+AFawBFbnZVFyiADFhjA1FDxwPHb9DMOOecpaAZjXIPdFdpSXzuDm3xcDW4ipNOX3yNOTI9HBY/ftoz90I46b+ZtsikJJuwrZC/S56L1eHmGfjSgnTaZsGJQDB7Zd79oYmGgDd28+9ld3Wx35qLvex5zAKNO8dno8i/3QpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725438; c=relaxed/simple;
	bh=2tfEnautz94xtqTzRD6wYgisVeO0R9PdV+JjVwDjjnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n72U5+JR2HoCircklXETHz49EeaLQiGhosC8UOfrzIMEUvEHswEYyuCw2udcaTpPaGC1KQTwdbEjh2Y8qnAtgDrMYosW/9AnrtTB5HRYVuP34FE6I+LAZTLrumeNpP9Y8faIvoKtGcZ8WRWJtvpBT96D8fZ+5Qr7c9mo+jQAjUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5V5UYm6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5V5UYm6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43591b55727so3563862f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 04:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770725435; x=1771330235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tfEnautz94xtqTzRD6wYgisVeO0R9PdV+JjVwDjjnA=;
        b=a5V5UYm6RUMlQ7EA4CNpjWFHbncR+H8N0scIMPbwx8ccQvjYXhpFnMlAq7R9S0nY76
         NHIdj4n1fPaWdQN/LiT/75BwOyXZDPTVW++UbqhRknneGDteH5ZRXsnlHLWx8+3wLNyj
         U6G++wxaVUtaea1/FeDowpo6bM9fccF7KQp4ARu3qpLcB0Lq78fYRT1EIEI0iFSm6JwT
         ptN2Vv6koPp4hf0Jl6PSj0HrDXlS6aTlrO6H2sQ/YyzfebXb8NVEGnrbcCQxLLrHMpRV
         F1jy+g6+kgPgqiu8R/sieObqheIdjolnAdofHL2mk3+RB1cXUX6D5NHbL7D2O3QltBFy
         /Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770725435; x=1771330235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tfEnautz94xtqTzRD6wYgisVeO0R9PdV+JjVwDjjnA=;
        b=CjaxMsmsB2l14MQrBoTmDFolyR3jqOOevb2RqAZSOigsMMRxon6mk97xZhQYkk3SwK
         6usdZD5Zrj32udtsUIDPg6spAGd2zVLG/lPe1bdHwQZzYPkkrvOlhImDQ/+uL21JfNLY
         SxMzxibqrlG4mNQH81pxfCnaNZa7oFzrBr3U5nGpeMsKUzy4SPmkPIL+T8vr0fUqT9u1
         vLIqeQRNbpE4kI4g261909S5/J32OQJtgvSPYOJbVzDxGgx/Bq5uxEnDejKei7XtT8/a
         bJ5uJK+Qaz9OLxa8uNNTpp1JqnLdluwkN9jUg1PATfvk/2nxfzG4U6gq3uU/X2Uh0YLS
         NKQA==
X-Gm-Message-State: AOJu0YwzHqYFBqI3n2Ryr0C3sTOhd9eY51LAG+9B0klhXoGpmA0sv+VR
	QqbS8rF0MhJ1RlU3RJxple61DjKPHn/gILuZY0X+OAEsTYllLErQUXzsnqiu4A==
X-Gm-Gg: AZuq6aKRwTY5XL8SXrzt27vHd7VK7x7+YxmRm2U2sUCRuyZKcqMU3vOivgDX+Yc8Srq
	Dkiv7rwiHAetEbEJXhiNJgLIoIFnJ7q4/urO6quHtB3nQV6pv+xCOiISvVtqOqQjEZYeMwfXr1y
	h4z8mABW5oH6Me2L1EnLERQTix+db7NNes2ynlaqt7oi+IinVChEuvxsjFNGlo2xTSMA320xUau
	TVcL+rNfoZXUJKWQa7kBy2WVkwCUQvZ9VjRZV5ymW6bQokqwqVdDUJ/KPQUh7HJ19z4//MlBXSR
	RnIebMSuD8BbyJ8Hf3abN0qw1hUPVGdlZGZ+Uh59m3/8R5Q46YPg8weuUh16zUuUOLeiIxGk6Fh
	4EOXus3QqxjYON3ilrSjrRFZOdAk6hnbL1+VhokRld3BjSrHe4Uxz+jz8UV+xtEp+1m7Q0sUk89
	0V5uUOJ2v7SfLV8xnvmfAO/pCH6LupsyUXJNJ2377a76bzo+TYYSdQmbSD4wIF0g==
X-Received: by 2002:a05:6000:2007:b0:437:6758:ce80 with SMTP id ffacd0b85a97d-4376758cfeamr13833982f8f.25.1770725434972;
        Tue, 10 Feb 2026 04:10:34 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376ab6e4c0sm18585301f8f.0.2026.02.10.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:10:34 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Subject: [RFC] iio: dac: ad5504: Inquiry regarding voltage scale calculation
Date: Tue, 10 Feb 2026 07:10:32 -0500
Message-ID: <20260210121032.4630-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings everyone,

I've been reviewing the ad5504 driver and comparing it with
the datasheet, and I want to verify my understanding of a potential
discrepancy.

Datasheet:

https://www.analog.com/media/en/technical-documentation/data-sheets/ad5504.pdf

The Issue:

The driver currently uses the vcc regulator voltage to calculate the
output scale. However, the datasheet (Rev B, Page 1) states the device has
an integrated precision reference. The output range (0-30V or 0-60V) is
determined by the R_SEL pin, not the supply voltage.

If my understanding is correct, using vcc for scaling is flawed.
For example, a 40V supply currently results in a ~9.7mV scale
(40V / 4096), whereas the hardware output (in 30V mode) is fixed
at ~7.32mV (30V / 4096).

My Questions:

1. Is it correct to replace the VCC-based scaling with fixed constants?
2. To support the 60V range, the driver needs to know the state of the
`R_SEL` pin. What is the preferred way to handle this hardware
configuration in the bindings?

If you can confirm this and provide guidance on the binding, I would
be happy to prepare a patch to address it.

Thanks,
Taha
