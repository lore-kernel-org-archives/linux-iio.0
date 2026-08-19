Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ADE3D75A0
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127928; cv=none; b=P4Daz1FECLp9PHJ/cWVZOYkDfB55jyWOFXF+xCtEzUrxiIN5rJfK9J5jGpvdxEdm9iIfJIBq4Pp8Q4H8KDuwwTttptrdSPN66Lw8igfD0g0HJhAa/Tm7ZttaoOn1cReKl2f/4RowQWFIptYmQY9reIraOEsHnBunZ7apcsDA81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127928; c=relaxed/simple;
	bh=0qlzCb4XxZoTqc5bYz7C/qbvFkt8AJhYaLM0S1vbpJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cdhd1+BHMuOWpYkoa81/i8a/LKueajhhSZFfEynwUmz7JYwry5OSa2EYQb2cndYDigV4SdTLW91Jg98gH3+zHNsuxynnbTilVcYB8c3eE2zyZeGoDE6M1KLuogPiLLftTi5S1qNJUwWS7wdtlro8YT89khGPMp+pUmYcgyUtzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0CDUU7F; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0CDUU7F"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4813ea321cdso1243993f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787127926; x=1787732726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SAG4QBgBLWT2fC9Hd/KCO+unr0wXvjoWFWHd+CcrkoI=;
        b=P0CDUU7FSSbrlU8oZBMcHRoPK/YNkjwtpkql39OYb8U8tb6i0jad1i+9n4xPS1XPDw
         akMDen2kFC86hYgFq4lP6dao9a7vD5S02D6Ay8KNsso/YOKrLUb0wUXgpu6uk8DBMdfH
         FpA0LcURRd14KgGmSx4KwugiOwmEZAFaIFzIb+SVWBp/FYhhTkpDwufmcQ/CGxeq3rMI
         JvEMhOUvPUW1Guag33K64UkQlmqVbdVeHcZpc8ygRfdIC89L7wDirHPf6mSOT+INvq8M
         GV4nnA7ISZcsjx1DglVZUd3kNpoXONpt38D/UgbPC1bmRd8OODyWcRaGvd2eD/x/Ragb
         VmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787127926; x=1787732726;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAG4QBgBLWT2fC9Hd/KCO+unr0wXvjoWFWHd+CcrkoI=;
        b=hF87ls5tJ7KybqZSK4QneVyJL7kdmNj+KiYt1mwOVOtUoZ/1p0TLaEQXVOb7dZPelc
         vgOaJZP4k06Vpa6yLkOOROlvwFM8lOIxGxvo9ha41ZJ/d4dQc4Ug5SBPlJ86U7vBdqSV
         F2ZXnaxJylNc7eTlHPFc+XwoEJrfhtKoS2xxKuwmKxmgjoGqQEYe5yHl3nuK0C+ssgBi
         PxYTY2sdoarvstuj/D0v9Lb03TUyXQOokVW49jkBeqziw6CSxPEqpRENwhMhypdtUFfs
         svmBzXhOzPLO3tXr9BbFa8juKTyAAVT7479sMQoDvee1WG+oLLs5fyUSrRary9WcW8em
         /72Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro7hnU4qhSVsn5rs66WIgHyPcfvzaYLULKs4K0k+tTz/LNFJ2E/ciEkzSjIPGmORgldiN5l2PHUJPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0mXU4JRFAcsF8zoGaPM+P/nHzMt1lpP0p93yKkZ4h/AEhy1r
	dQPC/CyiwahAi2aNtTR4M535IYxnjCaRHEX9oYzJTFiLsiTbbg5tyMmB
X-Gm-Gg: AR+sD11Tx0HRwT5wPuSjlfmlMIilHu1fyKvoKZliklha/RqfzOKKEumdejv6rdwN6Wk
	7pIsiVHJF0/pMV87qvp/jXmMfV60pnA9sZYgCSFUM10sflJ/J9gFLKfr+48KeHH9PNTMOzvijvp
	jB/4Y2KXfUi8jdAB9fVmvASNmETd1Kze44GOmQ+NjkNxxdhA/jU4kJORERszljyLBYv8M34XsMS
	bquhd7XFkmScwBdf7CZrYglP8DQp7FN+PuDQvAlHlI1Fuz2CptLY79cSfeND9xmNPIIVeGKDWAz
	SW3LYkzECj2J2XHE1Z0NuKrcDoTNYF3UKkGbtjwu8DZ9ZeJG9c670blv3RpYlSyxVJ7Av4xlsJr
	JVDSm8Up2Y0RnoA0xHTe01O+0Lr8Ukx4n2YaGsOdtHBqM3STezC6YgGmtvulP6AfJrOSHMONAYh
	5vqYbcPFIKcaW0qe7vXDNlvcPJMBjk9Tikggg1MRgfcKMvp13lFXAybLHSPq6G2sdESn5L5DQBM
	Mc1wwm1wDnVcELI+3KFlv+vbQxvOOYXQkD60qebaeITqCd0rTvc5RT8/UlSJw5L7gEIZGil4N2N
	rteqSP6r8pzQLbpY8b6z6Rd+wKxsh0KI5H3qAwBbLqdPkEqPKiR/NVQbkRZK3EoPsUM8O9b2uDa
	JBDGd5sh12Oh5k4SudqIPzjZdhhozzokbwx/tPp9WM6g20OUX0DQCHPW90JjTY+QUKCsP+w==
X-Received: by 2002:a05:600c:3f10:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499aa0f306fmr50702575e9.6.1787127925636;
        Wed, 19 Aug 2026 01:25:25 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0d6721sm59079895e9.11.2026.08.19.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:25:25 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:25:23 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 6/6] iio: accel: mma8452: Reuse existing dev
 pointer in mma8452_probe()
Message-ID: <20260819102523.00006d40@gmail.com>
In-Reply-To: <20260819-mma8452-open-drain-v5-6-d8aa590d7c36@geanix.com>
References: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
	<20260819-mma8452-open-drain-v5-6-d8aa590d7c36@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 10:15:33 +0200
Esben Haabendal <esben@geanix.com> wrote:

> In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
> struct device * pointer was assigned to local variable dev, so we can just
> as well reuse that throughout the function for sligthly more readable code.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
