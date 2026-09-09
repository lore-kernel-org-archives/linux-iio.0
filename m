Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EE5328CE
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953861; cv=none; b=eCagqqnp+QAV2rxRYbwQ30XqRnp3glx3wOqPiLtK/Iv0WRhmn9Hb6ITDBpUev35hEcMFnLnkFH1jtCo/9DT/waHrdp8x7kc5fIL0tAYRAn0NCxYKf5VzQdXn+wzNsPl2+sWDL0g97AJXIsuCWjvq2iHoagEIFxugNvoy0Y643Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953861; c=relaxed/simple;
	bh=JuQnapAhvZp0CN8+GfiQfqnFpJHWTmpa2IFU3aLBqpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nasTWhCGz64WM0LA3ANtwONbXfXN8D7RO/dLj7rOlFdg4E/4z+XNnzOnmEnk8bNjsDJN9ohnjtCbPiEYE9onTz602iQV394pkp3ha+/mvUSOVuE8dUXoCmXvdYLw0/L2DwEOosbC2aRn+b5piA0bgGIgMszT2ahknwJMbNcdL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKGEG8JI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKGEG8JI"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-485850cf499so3942690f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788953858; x=1789558658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yzaOs9HiYT+48ZefYVd1sW8HRaJIRxb+CV+smGN/KOA=;
        b=PKGEG8JILrEBCoJrLKLmzj69hCVRk2KE51SObef8swMHZNljThXmMxC8Hk8Q1rFZN3
         V+eFGttMP9l9p4NPEdctsKW4hZmvj65XKywqJftiqQswsyt67PRYqG4jOTDF4+VvHVxB
         /aBd1L0pdD+2uzWcXCl+UOgT2YrAmTN6U5U1yGSyCZI+dA8LEGiLq2JrQWrub+8O9D3N
         XURkQi4iCykkYRBrpXmZ8dhFueGMod/2iyRgLh6Z8mb7QXKl6fD+SSLQ4UFntixRSmp5
         AmCV4oopXD09C4ZQETuAbD9fSzBTlFt+yt4rR8F9HLcYFtJ/ZmhzQMPDtti3RIcx38L7
         uEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788953858; x=1789558658;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzaOs9HiYT+48ZefYVd1sW8HRaJIRxb+CV+smGN/KOA=;
        b=VxYe7/mmubJpsWkc9UkPnD9zkKHh2eeKLDHw6PANPtMV69dlacV7JZvdVGor75tc9Y
         gLtrjNk3mQ6eb853Bx06xV6eiOx3NIypjWBq1h/5jLA5qycldD7QT2js0Jl8RrTtMLGt
         Y7Znp1K8n+MWmjQ+5MQufX1kkZBiVMTozuXyyWZdyVUFEf+jVf8jf5lmvQGAdgtVrHVJ
         yjZ0k5LDDYrrsY8FJbDuK6p/iC5pxTjS7LjSEenKhCfJdp8WizvwSl/pBZLPeUwrzqZm
         S9GbwaySyvkenfb8qczsfu73Tbr4nSs7IqtwI8mXZz80E7FyyaF6LtUf1euS6Dj2acU8
         Bamw==
X-Forwarded-Encrypted: i=1; AKwUvBzd44WL8wlsO2Cz0fdqU7mXRLUbqUQK3ENGFI/DBSbvKR7UpDxVM8IFIEoPQ3aRuXcQW0daD51+gZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++m4ugMeTTlezT+GMsNXe7GQqJ9WwpIb8E0ElGFYpZVv67fp09Rv
	tsPOJfYFaSTEBIWAoS8dvOzhCYvxc26XIurf3xmSJgTQKQmQ/ZGqFqBf1T2u9HwER5A=
X-Gm-Gg: AYBFou1evBDRfdmleX8ysVgsRPShNjAlQTSwhA2YB2sJe1hcaXWWMtNQYp5WUDr3zPc
	/10ufFzYcQajV/DZ+XhXnJCAikPiAiCsaj2oPX3S6r5ZxBkUdOIXiTwKsCyhCC2XRSA5yUU+exl
	dMOE6dR67C33YVX+QEGx//Qw94iKRpyCDJct4Q5J/b7pRhq3hwIF8Gur0Zsqex+ovRE5dlk+aqt
	nRlzMb+g5IUsZcRtU8xAghcW0TCzo/I53jPoPxNSunKceO72RUFxKb3QuLBgeM9EdIWw90q+ibd
	KdvtszfcBQYnMdje3rk9AAP0dCiJEKIdzGt2eMd9F6oiMvTRfBq/RPsVRLYVjAoBMqKqGJZ8MCD
	5dSzD4thsTH+dGup0bw8cX0A4e2ql4zyfvNQILQ0ZDRoksj2Ev9x9o+BlsAIocrg91l+qRv0Ua4
	c41SPkrioPCuL74cuxhcYBlLRLbYX/4m1f7L7Q9CKDKDNR88s1k3Ie213vp6wp05zIjRdLUvNzV
	rep0RPJ0qfwQx00pxBK6g+UeIadTBWfmu8Ws6vPTgW85IqgccaXl9oW1Bjkshe4bkOYscVXQiYq
	FqXtyuF7BqasSEuYRSg8xJJ2+yZebEpboyhJocUfzHnoZSurmmweQZNKK6riAHP2GZ9Xors6/YW
	ERcCrl6dsMGkBazZnoGAma/m3Xl+NaaJ5jHOoq/56dhaZ+OdiGDtobH8KiKgw3unfMv5v18PcXq
	uRTkvCOAEcEg25FRI=
X-Received: by 2002:a05:6000:644:b0:484:416f:9f0f with SMTP id ffacd0b85a97d-485870872d9mr38224650f8f.2.1788953857608;
        Wed, 09 Sep 2026 04:37:37 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858dd90e1fsm46092542f8f.28.2026.09.09.04.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:37:37 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:37:35 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: ad3530r: add support for AD3536R
Message-ID: <20260909133735.000032f9@gmail.com>
In-Reply-To: <20260909-iio-ad3536r-upstream-v1-2-16ab930dcee3@analog.com>
References: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
	<20260909-iio-ad3536r-upstream-v1-2-16ab930dcee3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 14:19:10 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD3536R is the 12-bit variant of the AD3532R, a 16-channel buffered
> voltage output DAC with an on-chip 2.5V reference and an identical
> register map. Add a chip_info entry for it and the corresponding SPI and
> OF device ID table entries.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
