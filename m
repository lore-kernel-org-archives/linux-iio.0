Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9029B8E8
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624167; cv=none; b=R+UKsrApwG57giroo+XB6xLtgVDnhZBWCJ2sjlgImHOh9Lfx6NZF76HACIkISNlHsf+yLHuoUH9EO0SNjSQAhlxxxiz03k8LHGPLrZbH+q2zw5iLH9V/Ig+7El16LDfh+M7xpGNx56Fzmlk+iuxNekmiQsY4HtnoRJMsaOKIz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624167; c=relaxed/simple;
	bh=mhhPvocmcs0ZyucDY8oH2/9MIVZMDiHeSIKbeOc8dRs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlQZgWo0T/l1Vrqqo1/Kpvyq6RIozWMl/lGJHIcX8W8v5/5HIFnuv6awyoYcQjj7K5Wzf2o1tqvnXv55IWmS83MhNnV+biK+W1Z9SoNkytNVlMcH2tRRd+XOpd1Snsd25Ty0duc2gH2lPR4DgKGzoXxy+zncjh4/CFCqwvgnGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CaJtSMqb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CaJtSMqb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359249bbacso2824624f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 00:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770624165; x=1771228965; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhhPvocmcs0ZyucDY8oH2/9MIVZMDiHeSIKbeOc8dRs=;
        b=CaJtSMqbgQSUzOqtWIb2d0F5yDKIF6/6qSN5/5CN2NDEbJZMJy28BhO0Lx2erjLPWC
         PALbzDz+zTrc8sSmvkKd2cEWLwpIcl4nqUt+bFQTV3n0pSjZR+voQOSNzPd5lVDdn7gt
         PIcK2P8zRBqAmf2IIoaUCySIcnShVEuErHa/W4NTWs1dCh8SN+fVxzF4hcgPDLPziHsn
         pmd66hoxiotSDZ3gnG0sr1iQ9KGnyWWj1+yB2T09fBs8vuglSZpyvQY1DQ3kCHu+4E9M
         LQrssCwWHr9ImvJsco1zHVQOXSzudN4xW22W494dCil9eaO1AND+Y0rWuoVdRyuTYo0E
         Eixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624165; x=1771228965;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhhPvocmcs0ZyucDY8oH2/9MIVZMDiHeSIKbeOc8dRs=;
        b=wbXE2JpCoD9iq2J8HlKvwcx7uxosNEjEvHsZ9fuTRPuBfBGaYyVaPX+C3b+D2iNxjT
         ij4V2Axzeqa63HFR97BQjccX9Ad1ITNP1isSsQq3r/na2ET68puN1p+zgklPVfX94wfP
         xUuXwG99Q99nev1KATa4Tr65uO8MRfue8HmTeZoJ9CyFkUzr8dz/adS/95CL9xt6docJ
         Lygfi/82hcIVtPwTJKhGgFoa6oxsTka+xOgA4Yetj+k7d3Nhe1MPDs6/A1WL/DE7sRRy
         8ddrI3bXWloTZH7ctKL+xQiRS40V9ClfV8Zb9jYNPU00NiksLzeaG1B5V0+Wpq/Zz1oO
         EtqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9hFc5A427wYOyUsEs01AFoIdWUhz9WW1RpxEVXHMs1PGljV0TFNPOkHuUmftFLC8u6PvIOCMlpL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHqNaHOF0tqO/c6Wl9pFnxB0tTgp8CyW/+37MOehB8Yh4mNj/
	4qnHj9317YJ9Yg+hM0I7XYWHy+KR+hCvpNPjGXMOBgiGppkMPrwgSFwnwQeTTIk2x7Q=
X-Gm-Gg: AZuq6aKD8Y3qD4D0vGo/Gp469GoL1YcJvx9QHEJEdCZqg7eVMZm6qSrsVCBkXL7V57X
	Dm/r8PhU+kAkM1i/JDBWHSITlLTTO4cVbJ16hyED9H04B+4YkcRKVStgtFjf+3qkH2W64XIxlvA
	81HeE2KVXMisSCX+Vn6cvAbhEdarL2CXhcth8cefPq5akL+QiVKqOV87FUf0RVotI5IYIUUo5WR
	mmeJlgphOkIz3mA/hLXzrGY+gkqRvUnlKYsWkBZZYCcTgjR29pwSIWKmSgCbswCC0kqn/L4GLeF
	lTQpg4vdmDz7UDZY5WlchpAQVWjmRdTUI1lliLie8ZEFn3vGnhQROuYzAJwqd8kyTczy0kgknCa
	q8BGnT+l0yXR80aRBqVhi4ydpbSftr3HNeX7kA/SpUge7E/xsG9D7hjOIcNyO0zNZjZayhRd7X/
	EymAOcWkZv0tTv
X-Received: by 2002:a05:6000:24c6:b0:435:db9b:5881 with SMTP id ffacd0b85a97d-43629344c26mr14443796f8f.25.1770624164959;
        Mon, 09 Feb 2026 00:02:44 -0800 (PST)
Received: from [10.203.83.32] ([151.35.152.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4a1sm24517409f8f.17.2026.02.09.00.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 00:02:44 -0800 (PST)
Message-ID: <2cedd8f292b893f0e82aacf03c0989b17bfbf69b.camel@baylibre.com>
Subject: Re: [PATCH v5 2/4] iio: imu: st_lsm6dsx: Set buffer sampling
 frequency for accelerometer only
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Feb 2026 09:02:43 +0100
In-Reply-To: <20260122162335.2020006-3-flavra@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
	 <20260122162335.2020006-3-flavra@baylibre.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-22 at 17:23 +0100, Francesco Lavra wrote:
> The st_lsm6dsx_hwfifo_odr_store() function, which is called when
> userspace
> writes the buffer sampling frequency sysfs attribute, calls
> st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> `sensor->id`; since this array is only 2 entries long, an access for any
> sensor type other than accelerometer or gyroscope is an out-of-bounds
> access.
>=20
> The motivation for being able to set a buffer frequency different from
> the
> sensor sampling frequency is to support use cases that need accurate
> event
> detection (which requires a high sampling frequency) while retrieving
> sensor data at low frequency. Since all the supported event types are
> generated from acceleration data only, do not create the buffer sampling
> frequency attribute for sensor types other than the accelerometer.
>=20
> Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
> batch data rate")

This patch didn't make it to 6.19. Would it still be OK to merge this in
the next release cycle? It technically changes userspace, but I think this
change can be put in the "no one will notice" category.
