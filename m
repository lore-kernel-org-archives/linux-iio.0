Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482646;
	b=QMQqUF+z6gAGhxRWocOlgFfGyRXsdoEp8fflUAApLPVPUjTpHFrfregOzgWg3ilT17L0
	 6LpJ5Dhy5nnNWOxFA0dqhiMitLqW9Xy1V7AhnHw0PNPX/Ra5EEhlO+LiVQ/ucqnEhLcTg
	 Dxc+Z9fOZDg0UGpFXN/awBweUIzM7cCeLAd+eUyZGpLN8vzDjF2UQX9bHvmdwePKt+hsR
	 tvOgtejmmcTC4kjK5bmDZfywvZR1QoD6Qz//fjNmBvFaweJmclJKHQHh4v//GewLd+MMn
	 H/xe4a8PgAGLmcqJ9X53VehN1E0ks76AfjCSsbi5Y4HjN/hGq3LDk3OhdZ5gBr7Ax+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sA34k/OHNnDaVB340gpRDLf/E75aOs1zHz4HrHbZ028=;
	b=Sg1/W2wKvkIYmaKKYoMBCMMqSwN/tXpi4wI+N7PWGRtHosMQCtb8fKqHuUbhKV9Y7zOO
	 P3lekstCnFNk6nmAncGGKKwFq03DgGapieJ95HoBsWNVQLC4Z5RMkhDuAEfXJHZYO5cee
	 Fxq6z1WJ6M+jxzq165lgYmIARdTJxYpRUZ1qtXRsP4iC27Prl2lkAnVH9vnfsY+tIZV7S
	 37eNf/3aa8lsEa1WVEMzcUI/+TlUvopzgcXfrS6EC1fD2VpB1bgepf6ndlAaV3YOe88a+
	 kNCrHupx6XL0p0+zMruB1kFA/O/i8DjtSb3QBIXdAGGh71wZZxg2cnDsHNDUvgQwYKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aiXVu9Dg;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313CB606A31F
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 07:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 313CB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aiXVu9Dg
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso1757139f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792482643; x=1793087443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sA34k/OHNnDaVB340gpRDLf/E75aOs1zHz4HrHbZ028=;
        b=aiXVu9DgI1IWaZ097Irs8TW5eaOOX+ow9tvy/BTRbkD2W5eYHU5ZweFqBfiYaNFuRb
         V4lVV+IAfFHS1qREvpgn5lmM2hBWj6IF8brcwIa+mH48p3xelQqthNhznwMtZdd2jiln
         0Q6nxAecGzGuj7hKV6AZHruz19sew62Qr/cAuPXNIYKzzrKRmxdT0bdAlnRaEdVjvLa+
         TSPcwd+/mcZw8zCTKdqsCUDCBUFE/ygpQ+32MyViWHs2/SUVoI9zTIJPK1NAbNNx+loP
         vnJMc60SLHDYYxR3f0YSv5fm+LiTHaomn1IvK6D4DxESCOj2I8yx/KH/o0LRHR/L8yDS
         RwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792482643; x=1793087443;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sA34k/OHNnDaVB340gpRDLf/E75aOs1zHz4HrHbZ028=;
        b=mPHIUfQDLt4NDVIL3ij++xqeAQtIKE3dXIclbXmxHiE4rNQa6mmT6aWBfoFFc+Tr/Z
         yUQ/eHrPmSAZRhRKQHCZqt7VJD99dbtY4qyunFnpf0AW89dx52EQRZrXJYD/GVUutT0n
         ZKPCqm2Ep2EZ1NLJMAok/31zhzMNk5P6Pxq4lyedSGq+5+jL643Snnj3EpLCcvzj+mBy
         UzrQzE43ICrSnZL/YoCAqwYe1wD/rb1ZmJHt1pXb3YnLeVQorHqJaN3R2jB4fo3JjN5/
         cX5sCMQnpqNd5WeOZUoihQT+oleiwPRNFzSOwmG1neRdR3M4vzVJozMCaW0OPwiQgNqy
         NWtw==
X-Forwarded-Encrypted: i=1; AKwUvBy8/c1l7WcFj4s384YwAYCto68vPqxN+C2Mum191aqBKWANKFXA8PcrKjK0ivPqBitaIPfMMhH4+yE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEpX+pXYCG1lJN/XiW0b+MSSc0c+qdoxlp7Nm0j6bTRQt5Qst3
	mXnjlLUQfoAdTl3zpRQrSJR8t7CLn9uegA2bFjsf8++6SkyVhlR1jJjP
X-Gm-Gg: AYBFou3UHp5o8SndGO1ByKlkhJNqL5B5mviVn0kTCatHDR/KucBLc9VDkUdavno5ljz
	daFwWHzsWGLi7OjNmGqcVjlYkQaTZMfrIvI2IkH6Tlp7loboDc/6W/s95vmzHx0E6O0R/YGgECv
	IwpYZViCfRgb0//3DqZmRVCEqvVCwz1ygLAwY7Ru/4/eHrxQkP2EtdyGnQj3TqGmzeGX3q+mBGV
	FgQeiQvCuNrpmwtcc24y72Cx8koOp37srjlBOMSJ2yb3U7cAKrwb5eI/Ugg5jNF3tYKRe67eztW
	tDuFQE9eFS8yfO5dMjEom2WLknWI9bA7BfHVzD1DgIsSmAwJPGWS0NZ/xkOVQ9euJKBcPbLpsn2
	5QK8H6wZINcxKGMY10KHzRlM6Yn6dx+12Xfm5EUkLGdaGmFi3cUlpsoV7I2hYqNFr5WWdB7D/yQ
	fYvGx/vZPy4esR/LIwbtns9yRnY0aEUqT6FtTkVolSMhtxx9Ppoes+Zhbff5/9pE+AIc66UhY1i
	3g/wPXQO8ViVZ5pVuUCYngxv2a+wwZaIPcmhJ2xsX2s6VwgcMkj5NLl1OO3ZVEAfmLyV+s8jIaT
	b6SidRvCogZVwVuMRfR3MXJ2eMud5HfJtl1xnXgXi44ubApu1EwIxuO7qnHKsnknQA8i2GAFpCJ
	0pOIKrSCO7aqa5hIn5soe41p8kwoj37cSGtnY30frJsCi6tqdemmCpdZofE4WiNhKwGSsviK2EB
	MLzdbu
X-Received: by 2002:a5d:6391:0:b0:48d:c178:f6e9 with SMTP id ffacd0b85a97d-48e07bbd618mr15587418f8f.20.1792482643365;
        Tue, 20 Oct 2026 00:50:43 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8185d2sm4581409f8f.28.2026.10.20.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:50:43 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:50:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev
Subject: Re: [PATCH] iio: osf: avoid a large stack frame in osf_core_init
Message-ID: <20261020095039.00004c88@gmail.com>
In-Reply-To: <fc593496353a60a15fd5ef1a2786d41dd9bdff3a.1792403576.git.kimjinseob88@gmail.com>
References: <202610191514.fRYyu0HX-lkp@intel.com>
	<fc593496353a60a15fd5ef1a2786d41dd9bdff3a.1792403576.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 18:58:49 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Clang reports a 1344-byte stack frame in osf_core_init() for
> hexagon-allmodconfig, exceeding CONFIG_FRAME_WARN=1280.
> 
> The aggregate assignment materializes a temporary struct osf_device on
> the stack and copies it to the destination. With the mutex and caches
> added by the IIO support, this structure is 1328 bytes in the reported
> configuration.
> 
> Clear the destination directly, then set dev and initialize latest_lock
> as before. This preserves zero initialization of all other fields,
> including when the core is reinitialized for a new session, without the
> large temporary object.
> 
> With the reported Clang 24.0.0git compiler and Hexagon configuration, the
> frame decreases from 1344 to 8 bytes and the warning disappears.
> 
> Fixes: 7329986669f2 ("iio: osf: add IIO devices from capability reports")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610191514.fRYyu0HX-lkp@intel.com/
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
