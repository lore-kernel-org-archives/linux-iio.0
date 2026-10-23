Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792768578;
	b=h1rRlcQfpBRDXoztXBrNVyV52kzWGYQaYHHCoXZfH4RKqgT8blEggYo7eyemjsRjxWfO
	 7/TMjbJzQyRMZXPd2mpuWLyVSv/odPcVDLx9I6vbXTg8tiaJJKcI84jEga77aUdxCothW
	 7rd9X3JMvPOH2IfKkf9JR6Z+skW8POsodzO2xcueB6E2krqpdbuM3qmhmZnSjQg0n0GGZ
	 09iYbWtEgbXjumdbPBkwoP9P9w7Rtvd9dk3Srrtfcy5/ykSZ8h3jhoDTcQq2szZwkIuyS
	 xGOqouqlLkwgqdgF3TMtV31TDkbiSH6X6txUA4nClfT0IlG83tnkPQRy62TpMtqPQVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XKdHMd5busSKXIumhnrBjnjX8zKJcu72ko+1MV1LHf8=;
	b=EK6Yb2NhVw1nYgoNlDGAm/VwiYKkSTQcWcfJvbh1vYGg2DfQaH9rWU0BiT6IIxEWmtmk
	 L5FD0x0xaFt8jpW3CCOYZGn7tJKwoWvCM9FPnhnq4TCgvb8G4OEwhecizS8vYS/XDInNw
	 1sknVqq6frEoXZfUaqyOTC0rb6ec/aA0kHh0VK/w07ljFKWSDnvQySjLdA0VsSQs4YbIt
	 00IHAWf/fOjVT3eEoooyuz1uZUEEHT3HurSvYzbBzCeXdRBBLVzB6c4JwRx1qbxX5uvWC
	 CC3Yrx9jGt4hvhWjy4/LrdP019Vou7rEoxmiA9d2Ul0bamlHLQQAMQFMC33FDAeQePA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LKX9R8KI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF0606A31A
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 15:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5DF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LKX9R8KI
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so6220985e9.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 08:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792768576; cv=none;
        d=google.com; s=arc-20260327;
        b=XTiwYw86alUFAy+qgMKTC6AhKJF6A1RSNK8fNJGcvx1QuO5Yd06lo/Hggktgjy+ouJ
         twJPFiIlzXe16qWy+5Bti0/bnjJrGyEnOKSzhLKiWRKreakDIQLVY363QgSxEiZsPKQD
         WOkTKCrN9T/bO8JO0ftG3jM6OvCzH5Ccx0gbtjWRy6bTNtjJgMs6mfX+2GA16uOISA/3
         ziddfbOWOQmvLrvRMw973nsquKC4LySij/h2AF+katUlHTCFicDQ1hYTTtgUWSTcNiUQ
         JQgLhKRjM+pHz8gsd7WGs+wqbPiNhphtRet1mxDWXytQClaaf0ELmaZ4SosA+AxEktV1
         875A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XKdHMd5busSKXIumhnrBjnjX8zKJcu72ko+1MV1LHf8=;
        fh=mdsUAZ7yWwgs42jCr3iP1Rv8k3lPeuC/cTvwwTnEgxY=;
        b=o98CTOWJl+M8gLPp4MzTtiaFqseuSTlwVR8YOGT082L6xmL2A6acp4Uf8tHss3UuFL
         1yDPygXroVakEL8d1CGnry5XYUZJCv0MdhweavphhiFEQO0vUiGSO4vuq++dW5gmG5eI
         MxhgjpaVJcyTcG6TwESz+tK89YKk03QDHCmy2fj4VzNYdQ8tFiYKlgOwBR82W1JMejVl
         BlJM2fgZy9cgc1AHbFOmSw7B+gFGzJxK6DdBWVKMlhibctHpT23ZYM8osgLQh5cc1RAH
         VC/YzdSSwi9nCvdl7kcVRWJe36RIfe8o3+8kZH+OtIPKLWcWcvXVYzmQDSMImiXDQcXe
         yvXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792768576; x=1793373376; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKdHMd5busSKXIumhnrBjnjX8zKJcu72ko+1MV1LHf8=;
        b=LKX9R8KI4FxB9cfjvb+LTM6KdjlOm+VU09RRzcxiN1Kn48cb5th0nu8Ls6Oab68aUJ
         MsaOPofJcLhYorH9aBy4dCZXimOUnYxe2w3hK439XAZWo39olcvZMjHN/rj529+bpO/p
         KRqR1zhdXVB6lDwhSkzdxz8SepX+P4M0rlBnxC5qPE4vSo+grcTPNw9uT5MkzzKVqFHE
         6YWYfFBqNVqHhl7Ayw+I/Fq91ryNxZE6VP+Kbe3eiVA7VT5BxuVuIuCrH9Iaw43Q861V
         wOvPlSXY//gbamTgxFiIK4DFgtqQoZ6GE15vyH72TJyUVUdhOtyDMe1Ta+q6qa36Ahlk
         TAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768576; x=1793373376;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XKdHMd5busSKXIumhnrBjnjX8zKJcu72ko+1MV1LHf8=;
        b=mf/rcX36+fT7OTlVghJSgbjc8SVYpfdragiY2p/KVkAifFuM0UEyVRexUfrkTzAI80
         Von8S0C8e4zPphLSNxz1SkcpF57ECa0YAYfJSu5i9l04u81+MMt/S4KY5ibo8nPFSC2G
         6SDUNsGeULcld1zLr9TUETwKfo5s2qbgM1yEO9N5HjnN9ORAsnxSSMqOCc92PnVC5+gR
         q/KffM2O/mIH6rd/W9l646IVi2idaAglGtSpKwX/d20tW4CIi0/ognOQlkVk1hjkZucd
         Pknr7HXvQ2atvvV58zagynzUGb9XVyo7YKGzfkGD4QvMRI1EUqvuSXmlkydHbm/TNrzV
         3Oqg==
X-Forwarded-Encrypted: i=1; AKwUvBw2mwiGRpQB4qtVwajD7zPKLDhJPOuAqmGeYuUY/yu3+Z4nYLbeOehoMh6HxDpgj1+gWYJX1dMQx5Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAkkgFvWgaN4mJFwhvmrF3Gouq2nAY6u10nIZAmvuK75TO4KFv
	wUBdFm/aKHnOcQF/WuG3DH70b1XkmeEJZSCf05s41ZQLxmavyNr6B6xZJlByHfvXkIDivPZ40Il
	ojM6FCxDrbZZxFpVjjBIIj0N0i6VSLpQ=
X-Gm-Gg: AYBFou2FCHOLIfg3CB81qu5tLErzjkdVYtCiqMPYwf/fA38vVgFp99xA280gPjF/Nl5
	ER3UsAHbxewmJ4Drmg4hj0J5UD8w6st4DUNROSCAf4aZfD9cfeKf1tLL0LvPRDyI1N0aTI2thBQ
	PZ/PcHIDjaBGEFmTk/cB/Q4e12BUlujK3XspBFLjJHwBaKwwydo805Mp2pTpMTYEv58bSeDe21b
	0NORuuEXIunDkSedePoasbP8ZufeiVxk6uUkex2QeMrtdXHQh3sQ2q8t7rdMy9vUN78Sn5yoM6m
	j/78aogLF6Rlx31bi6Z/v+tfrFtp0qsOIxbqJc8DPWRZ7+He8MA6nlppP66VsPjIsWch6UIpJcJ
	W00VGERwhrECOBxMtP8Thh7S3wzkZeXxioqA=
X-Received: by 2002:a05:600c:c170:b0:4a2:190f:cf6a with SMTP id
 5b1f17b1804b1-4a2190fd130mr18697725e9.35.1792768576052; Fri, 23 Oct 2026
 08:16:16 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFkCdFwEOUq1nG42GPDHHMLDoVEWJQ63bJd2tPTJ30AKvdKn2A@mail.gmail.com>
 <atpCQhRG-c9z__Bn@ashevche-desk.local>
In-Reply-To: <atpCQhRG-c9z__Bn@ashevche-desk.local>
From: Viral Patel <viral8854@gmail.com>
Date: Fri, 23 Oct 2026 20:46:04 +0530
X-Gm-Features: AclHuK_DeBJ2lfnRu784zGBrpgPfMRaQzx-DAW5xSz_V5KlCdXNpZVw9nZTIBlE
Message-ID: <CAFkCdFz_b+P0LiEYuKmFPDKyyLjX4A-Xa9S7XN34SrU9o3upLA@mail.gmail.com>
Subject: Re: [RFC] iio: magnetometer: Infineon TLE493D-W2B6 support - new
 driver or extend tlv493d?
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, joshua.crofts1@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 22, 2026 at 10:35 PM Andy Shevchenko wrote:
> I haven't compared datasheets myself, but if your judgement above is
> correct it justifies a brand new driver to me.

Thanks. I've cross-checked the list against the TLE493D-W2B6 User
Manual v1.11 and datasheet v1.2, and the differences hold.

> No 'x' for sure. Name after the first supported one.

Will do: tle493d.c, compatible "infineon,tle493d-w2b6".

> Have you checked other drivers? No more (close enough) matches?

Yes, I went through drivers/iio/magnetometer and pending series on
linux-iio. Apart from tlv493d.c, the closest are the other Hall-effect
parts: tmag5273.c (TI), als31300.c (Allegro), si7210.c (Silicon Labs),
and the MLX90393 series under review (Melexis, command-based protocol).
None share the register map, the 1-byte read protocol, the trigger
bits in the write frame or the FP/CP parity scheme. The remaining
drivers are AMR/compass parts. The only overlap is the X/Y/Z bit
packing with tlv493d.c, a few lines of FIELD_GET(), so I don't think a
shared module is worth it.

I'll send the series once it's tested on hardware.

Thanks,
Viral
