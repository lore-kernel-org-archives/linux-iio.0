Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF647F2C2
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313519; cv=none; b=XGd+uivzuGsQQ2Xkzc7rqk4LInYmSooahqKiVn0ebDkjc4Z8Naiz+quPTXhlosm50EnDhokr/v1o5Kk2HPVf4A5V4/sWkxstyF7FcsB+NHuCqWMiq5RcXB7DtwiyBDzXSXSPY2qeF4lskfoK5HF4zEQUPindLPthzLTkEeF6nUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313519; c=relaxed/simple;
	bh=ga7ewo+bhPZL/Y48rxxz8sC5ayINjETNSb3dQnDXhIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOWgoRfVpkdlaAN4R6dFXJfkBNBDnFO5CygqDjXfQ90E8E4Z5/8SntOif9rH5e8RKFb1/p662lU6PAIXJ/xVfgD+YJOoxP+QsZIZKdiyKYXTgXkK3MzvY8F3NGIM4NGCsBRusfSqQarnHTIQtUsTvuBeCqaSkvcZASM3WOPUQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSSWnFWD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSSWnFWD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c169ae1cb26so411118566b.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787313512; x=1787918312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dn4PV1MwoFGkSkGi3sdTp0WA3nKp7vJn8YF1veXQeBc=;
        b=FSSWnFWDndOKiE6OE8nhkP1/ElhRTDAE2mHGxwy88D4trjwyqz+hstHsz7z+hPGwX9
         Qcr7klQuNcW2INQZGFyirBV+X/cC1+TmlPZkkBUO810a3w1zkz7DDKUDRG8Hdj2kLrAq
         4Ahg2c2P+TPProR48Jkm7DJUHbTufsbrq1C6425smr2YE/cNgENUwHhzjfZXVXCmEgcc
         FCtcn14S93m997zF2iTBZ9O0fHp4PL64CHwxLUFBkfI1P7rYYZvzzLeom27YX1AySfyQ
         0vZhljNFT6uCG5/1tgfYaBqrQ1kgeaZyY19iMKEsgRJjbHnMNF9mQ24DYKzRgFx44pFX
         exDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787313512; x=1787918312;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dn4PV1MwoFGkSkGi3sdTp0WA3nKp7vJn8YF1veXQeBc=;
        b=XTV3z0fh54sARXyc9lXwadY/B6Jz5QqWQhupXFrMCbtVsdWrYt+TCqrpygnlcnxDBg
         0osEodirXm4/5+94V4R3CKkVeAk9Rg9165MOLSga7Zd+fILuhFKSwJNxDFMHByr1xMcX
         dgn+yARLrfqbvwzyWIYqCq/7jRBoPmDVX9/rEzUzi11HtrOWQPNjuAT7nIyTdaWcDa4f
         C6x7pASbRgENRWohWbLOV1KK5wdsFjKOnq2NOv+qzoGyKfdqwR5M+q6u6SHuVC+1ae1Q
         1es1Ez31Cn/DVSBXRxHaoI25UJv/1eO9Phf1jOWTPOkUdKQkhr5YgvQyLuwXHRug4Zro
         gBgg==
X-Forwarded-Encrypted: i=1; AHgh+RqKJD6LezJjOSMx+4k7UIVRsevhOHKg/PBvu1kq+k2sg7HyaK7l0K7ZIKGhAqCKU8FZZVhHoa9EP0c=@vger.kernel.org
X-Gm-Message-State: AFuF++lcyFpKUlKh/NoACdCUSsLup7KE8759zGFGyNWaQ5sN7XZj1jxf
	8lPSuj849J6uGtcUQy/tgYwOdPlRFsdnqEYJermJjtu//VzDN9ZB7VDf
X-Gm-Gg: AR+sD13M8uRRkOiEROCcKCqBFOHEVYhrm9pIr7yX0uS+4oDhwF+y2ZX7Ldx35E1fFml
	dTkYOW4UsrZpzs/I/ZgQdxg8w+/cPQUCaX3+xcbkoFKeicmcIv16WjvNMhzwtqKS/o+V//xUezq
	U+uZxfsybtEOpFcUHnudszgIwwEqMdYLwHssg1IsDuIDvh96tRE84kLahl8RzMu9kqRWWOSNVjZ
	PXDbmGtqsfMOIT7SiEV9Vs4j8ReylkMDRD47//Vo8LFrQAAsv2MLn0ZSJT+tgAq/tth9aIyxKgy
	FarFsTlwN0qN1AtkaWNruQr+7bRnw4FwjRTD30Hov+e5fYY2m8MZkySxFuXzqzAT3DJQuycl9OY
	Ob6In4MkfRLrV6eZRRc+r343Knat8eeZbYRfbm7t7gJY36mSt0S3So5xplbRqDhUcpheQJdw33m
	AxAj+FsO48BIm94m5RS30HPoYDh1Sel7Mk2pnE3BqWWTewaBCWF3RYRORLfSIqSk8Wz+2heD3Vo
	l/LoG/trpKJJ6ABPAc+VHewaHsomLAQHHMNo/m/2FhkzyItTIGl0Ai2C3doXdWgdILRCZJJmMEP
	pJ7wj7Tbj/isw6xjm2Tk4lGbYVXgPljCRjS1HudVmfzh49KteXkcdl7yKAB53S3crWcJVckv23k
	s69ZyxVxg9hX4FvSRxAvAjpiqhNe2woncsbiITTZMYIXvknSF3SfrBRh0+cUx4xySKBrHnA==
X-Received: by 2002:a17:907:c30f:b0:c20:367d:f8b8 with SMTP id a640c23a62f3a-c244d4f05efmr1123237566b.4.1787313512017;
        Fri, 21 Aug 2026 04:58:32 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e1ab3sm483334766b.4.2026.08.21.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:58:31 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:58:29 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, nuno.sa@analog.com,
 robh@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v5 3/6] iio: dac: ad5504: strictly separate ACPI and DT
 probe paths
Message-ID: <20260821135829.00001fe2@gmail.com>
In-Reply-To: <20260821114153.58607-1-0rayn.dev@gmail.com>
References: <20260821132021.00000d2c@gmail.com>
	<20260821114153.58607-1-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 07:41:53 -0400
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> > ret / (MICRO / MILLI)  
> 
> This exact line was discussed with Andy on v4. Patch 6 in this series
> replaces this whole branch with the output-range-microvolt property
> parsing, which does use (MICRO / MILLI) correctly. We agreed it wasn't
> worth changing here to avoid an unnecessary intermediate diff. Let me
> know if it would be better to fix it at this patch regardless.
> 

Ah, hadn't gotten to the v4 discussion, in that case it's fine!

-- 
Kind regards,
Joshua Crofts
