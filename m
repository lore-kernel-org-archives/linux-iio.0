Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07C3ACEED
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894927; cv=none; b=DaMjdTkRL6yjD5T66lsLwhj/L9PBBliUSnAjjwnbA0sxfxk9j8GxPhWrhy1nT2K3VSpwyxHlfd7hm+uFPF2wCI+PFKEgNnOtQED0g/bYAeDjWQsZS1WCe77752CExubLUvIa83pYw7D5Djj4KJm7g9wtwkG6KJIZrFxRqaMT+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894927; c=relaxed/simple;
	bh=D5aocd7LzcUTTHKmUFRWoUuPVx4SWmW7g0SA54wCh78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqtiQSFsmfhzUWVUzIe0OJ2uxBf+VMLymj1y+uww6RcXDIU6MsVxo2Ccib7/yvqiLqxByuOx91SbgkHU3MtXxMhAXW/qcFOs59ZZ7DHdX8bNAh77xMowY/iE95rNlArM5c3hlxnHTooDVZ4dyIpktvtBniZtmUjDoAm2hd0Z0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4ZZyqyJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4ZZyqyJ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1745891f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791894925; x=1792499725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ah9kS2eOZPTjVhcN2vGZg1uNRYJuhJ0H56YtxNuvC+c=;
        b=l4ZZyqyJ87fx5f6T6jsGQlkaJSFAoZnipq7YyLo5Jb/ShuoboXcsvQuitMncNE1jTJ
         UJpxBoyIpXIXvTUSQs2lkvnKoo1hTf2YRCHb173eC+B1ksGGV8NKHrRelamqMGe0q8Af
         ncjDzMxuQnAqz8HKUUdJsqRU8pXJ3bENuw5f/k6/dsF0ANNKm0AI/+rfbE4WR1Z9crNk
         du7QaZDNSjsBO8JaaARiffOCu9AvwgNHaC2ceMa1lnTnBFmCKTNpk8nYESnyxcsy04X2
         qpqnrNbBDCOk2LGRxk3KLnLsw4sZoohw0TZXY3kgsIu7bp5hanDWh45ua8mzrNYbSf63
         FPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894925; x=1792499725;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ah9kS2eOZPTjVhcN2vGZg1uNRYJuhJ0H56YtxNuvC+c=;
        b=teDvBxyCgZHoL0B615QwgdrnN++gb6PKTOW+mtEIIrGzI7k7anKPSVI2NBs730Ryy9
         tetneb7O+A9LYMRcYBn/C2Psc7cprhB+vOjBMWl8m++0OuEEbN8cyMJR/wJEoPIth/Kj
         maaQYz1Z6O/wz6gG4QDt+0PrF8CdnGhIKzNoAiBrw606s0gfnCa3J6UdHnYtq1XJc4DW
         AszkWK2eXbyXM3Er4xm4jsuaPd7LgizloBd/ic0yQDU9c1z5RaBucGzd8wGBXP0Wz/8q
         1KGjQo469A+p1oRvOy0E7MZuv9NZXz5bZidrjJznaIh0Omtd9AxcTzN8mXRJ/7PBr4py
         lgIA==
X-Forwarded-Encrypted: i=1; AKwUvBzogVx0WOi8stTBhduGDv1bbN8v/TdgWyI3j+4hkpJh0KmQ/WhXuv5QqWjVxxvG4C+1cQ6743ayLE8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLFge6zKHtHS0SkZuhjWRcY3zcB63WrSzzSo+qi7BPLpoU6yKi
	2a86w7qmYBmpytcikmbVcgK5mFuIVW7cd/yNp5CTxXz/8DTFNuN7QB8B
X-Gm-Gg: AYBFou0joNP8wFYWYkVqKZ2FguVMgqDdWBtHGZ2LsB5SA24usjpZB0zgXFMeC5R2DFp
	JjcH4PITvrK6MkroHuA7ymJ0k11uUYHZSs1eXuyQHj6rmRUy4hns096gsyMFIe3nEleFb85YWSv
	NhcxtLuoEMmxazl99wI47dCwh14fFNNXvg/9XJFKHSUtiy4cSXoIa2HCJ8JIKaG1sY13uShDpak
	6JNu4mBSOU/HI5/RHkqvvCaogbKx0z5EcKbwi9sNUFkv55MjZqhcoj5rkw9JYYDZ9cnbQGHvUD2
	Wqce5sgkN63xVRd7WaT3wd7X2+ZEPvj7LXDNwmH03UPNUuChUSe0pkmrP0mUzwoG4k62Owi9zzu
	r1UjgeO6X3mILa8Qp5PwY494hsFLxk9cfJLBRWqQF3zwLRn/ZYOtLdpeyXnu9wVTkJWeWTyU8v1
	CwDrOz/opw38xlPspSt4W5Z1UuEjbMc+jsE+CjBeTakvmP3+fmUaeDMrHHlolQGCtcpA30/oW2Z
	W+VfMx6/Q5vC7UxbQTF1CMwLHPtFCZMcXB3fLZ8R4/Mp5BDkz9PasfBHpfg0S985uRKNP1AbKFd
	qgefz/57WA1cia1ei0izLISp+K1x2hECNmDwqVVxznVeXmYtyRxXbJUDxCpPKNiCBKWf6qK6RV6
	mjb1lGAAQ2bs0hgtcF1+sgUtJPZLqH/ZYT5lFXsQbSZtJnB9A7GKmgXTrSGHeOiyXFJ7w025P/s
	5Gw5zi
X-Received: by 2002:a05:6000:2212:b0:488:823d:5086 with SMTP id ffacd0b85a97d-48dba6f5688mr22978399f8f.0.1791894923407;
        Tue, 13 Oct 2026 05:35:23 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967affsm4477888f8f.1.2026.10.13.05.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:35:23 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:35:21 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shi Hao
 <i.shihao.999@gmail.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <20261013143521.00006de9@gmail.com>
In-Reply-To: <20261013115639.167433-3-marcus.yu.56@gmail.com>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
	<20261013115639.167433-3-marcus.yu.56@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 19:56:39 +0800
Chang Yu <marcus.yu.56@gmail.com> wrote:

> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> 
> The AS7343 is a 14-channel spectral sensor featuring 11 visible
> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> flicker detection channel.
> 
> The driver exposes 12 spectral channels (11 visible light and 1
> near-infrared) via sysfs. Runtime PM is implemented to stop
> measurements when the device is suspended or torn down. Power is
> never cut (PON=1 always) to preserve register values.
> 
> Future patches will add configurable gain and integration time,
> interrupt support, buffered reads, VIS channel, and flicker
> detection.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---

I think this is ready to be applied.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
