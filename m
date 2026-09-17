Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A0052379B
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651428; cv=none; b=h0sYWqFJG1W7ErOkiPlpoZlheu8IGdeCvU7TPNT8+7oo9CYOLaSW/t+LcV4pAZ+S6hIq+sKrPS5yBOcsUCQWBqv9uO5aipOR0xIymeGy/+Is9YIHAiGzpb6ABrYK8eWVSUX/cb6KKhv2e6cVJv65tKdg7aoOf3ykmhqB126n+eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651428; c=relaxed/simple;
	bh=UwR4EnR2P6r2criarI36QIvF6ZP1tZBnh+pnESvF5oc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CK1GX/9T7hwEFHaT4h25oSQ3wLGNx24NSMt+Q76EL6QT2cFLNm6saLbKVkI/vg1p2ax/CjAvB+sieLh0HKf66o2WYUZ4i4QdJN4dZyUIm9YNPrqQNpRc4eLqQYhBJa+Uns6/H05LqvCGyGl+h448dZv0yCwa3jHrzdnXYXrs3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0wShByO; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0wShByO"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso2235585e9.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789651422; x=1790256222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wlR+1A8pVxSkzEFR/sTLjE5ojiMsY5zMSc9uTNA86D8=;
        b=n0wShByOqfhcTnft7l0JAwg+DLqDXCJVL0AUc9jGIU1vXBzRr8APOjQRG8ZYXQgXaB
         GCVoQoQ8wpyzS64w77MmbJR+p5qBBW5bRvurhvNk2mSgg2uc76+IG6o9opoJIgt/hveh
         edgmwvFAKhSdksqEMpGrz5/QhdGTmXCE5Cg4sGXm38VKMeAk8N2VwLruWleq3XKWd5/p
         wErhVG9/QUf9hLjDv7U1d/RfrR9qtBbV7fNnUaXsZXSKZ/OFVhdlnFsKVxWBxbbj7nGT
         PgSkOjS60Cp3tHNR0llIWn4xA5G3uiFWEJZM4vCPvvop3/wrrO8gXNCRmm3Hp2bIRNT+
         K32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651422; x=1790256222;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wlR+1A8pVxSkzEFR/sTLjE5ojiMsY5zMSc9uTNA86D8=;
        b=zBbyZGsJgto88s8TVM2xA6xwJ9zBam+wCVEfLEPHo61AxI2Xt+1gNbfziPFGvsKbjL
         K8syD5CkYuzBwUisKPGYgH6WJbDbzuqcpQubXKbh6EDfumZVN1NMY+zD12DqBsrjF+VG
         V7xs8Tad6YiqqIll2WrFtD1MUo4dk0NTO4TKQ5La3rC2SJNfX8yPv874YHikcG6vt6uF
         +uu+3H7scrvhm4HzdJj8veq8xPo0JrKh6dWdIJ6zwgMj1x3BYxMi1tH/R55hgAZ5CI5k
         ndxYFMNPRS4nIwVl+gyEs6PLhI1SIyZPeNia0KjnSud4FUJPRZ9OK7WysgfkYEhQ8+rY
         4zkw==
X-Forwarded-Encrypted: i=1; AKwUvBzemB4ingJQ9ktgJQ8HLG4V3cZanYkgqohW74ih2az9ueQ8oNjlyjfVKdmzOSAIQLjM2sr89y2ngis=@vger.kernel.org
X-Gm-Message-State: AFuF++k9tEcZUAecPEGjlAtBYXqyQ4WXYG3OYWl7mZhjRnurpvFcA039
	EEGg2e4ud7diE14ZI3s9m4mEvz5bl+oKys6EQKXxXqgbdsCWIjtqexPa
X-Gm-Gg: AYBFou2om5kzbIqls4/yJaSm2jjCTlQinL0eCbSJdwemxp69YuNz4MIDBRxXSAMl8/y
	nAi14vFFCZIYTeDfcFJdfewSqPjFVjblqr3K3JxI6gHaDR+U2tyED2Ro9ttPKqkGEvWKk9zYijX
	mSCp/IqnT/q8zXv8pp8y3UfwPjUbWMpAtEZfMXk/3P1stCGHfLS4jIawyp5yu9tEhTspTxA9RWM
	3kNuO9QQvBilkZUvsYQ01aBw1LovyHmICetCOTXJ8OLHnrS9axQ23HFZmk1pCCNG6LA6x1f/8cq
	l2+E7l6WrCLmYE8J3k1AOsF3fDKX9gglviY/Q0gr1yD21rjUzEt3touFiYjZiPY95ay5WPaYX/M
	9zjOsJH/T9dSvWLXNYTVQ1aHZYyIfTPDfxTc0hvjeGqOf9brMXfNdeUgKtl9afTgDeLCEQR9WaI
	Ba9g5y7wd8yeDCZLnoxJRzQUePVwlKPt6+dy15hMsGU6FIUlRi+p7KZhlI6dRdana9TexxWBaqo
	S9VOjEJCae2KOo+4MI9No7l6nzrTMM6VgkNflkfjX8ifs9BDhUzixg1OY4RI7nJqV+aGCK8jEwG
	uOAe3AQBrDXLEnNmlP2u0A8udgCC8ixRE5u4k/5bmiCjCDYVzjeXtiWTsThI+qww/ENaLhD321Z
	sZkohuZUUI/nNkmgXzStHw0s7OQuV0+L87LnIwo/rXYlPNwM0ONCiSwEuxayMlelmfjdoX4KUXF
	HgwUuT
X-Received: by 2002:a05:600c:3491:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fbd1befe1mr52916965e9.5.1789651421842;
        Thu, 17 Sep 2026 06:23:41 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd32c5e1sm108045795e9.5.2026.09.17.06.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:23:41 -0700 (PDT)
Date: Thu, 17 Sep 2026 15:23:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: isl29501: Fix return type of
 isl29501_register_write
Message-ID: <20260917152339.00004fd4@gmail.com>
In-Reply-To: <20260917130052.636055-1-salah.triki@gmail.com>
References: <20260917130052.636055-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 14:00:52 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> isl29501_register_write() was returning a u32 instead of an int.
> Since the function returns negative error codes (such as -ERANGE or
> return values from i2c_smbus_write_byte_data()), returning an unsigned
> integer type prevents callers from correctly checking for negative error
> conditions.
> 
> Fix this by changing the function return type from u32 to int.
> 
> This was found through manual code review.
> 
> Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---

Makes sense. I'd mark this for stable.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
