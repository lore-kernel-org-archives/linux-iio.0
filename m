Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9423D969D
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704418; cv=none; b=JfXJnL2bEkmUNJRVf0jdWEqmdWaZ+tKH11wzNpxJgQsCa+O64qhosdS0M15tmKKz5md4qDT6wy4mWYttn7mjrTZQvSV4w0tGuTtU0biHtubxHb1ztRumMcwiAepxcXlvmbKWvieXKhSoSbdZ4PdWwB8nAybeT5nOqWnJ5pl7CRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704418; c=relaxed/simple;
	bh=bKv7F9ahkxh8W5WyR3qEm4fuAIz65mC5K/OoAxne/CU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHlHc4J7au68hZcGZobWMnK67y9hmFOQgcSdPsokRyzgg2vuSDQhk5ZeiF5+wKPZGgvbVIWQ/IYmSgWyuc+vZGT5BV/+9/Ur4hCkWeks4SChoRbhjk9TfCVmlkqC9PqGA0hXDjG5T110NZyQTmHln9Qzj9b+C6bYaEPstNsw3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbwylu0K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbwylu0K"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso22935345e9.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788704415; x=1789309215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PC/6bfIhSGPf12M7phejzb1AYIWg3N/E3Cnmwp3VYxU=;
        b=kbwylu0KIQ3Tj6iDOtGcQnuPpJ5XDqSVAQwfk8y04rnFhvvO6hKT5QU9ulAo+dJZB1
         4r+ZPDSc3Zs8dLZRgTE5wkf3qGaj7arb+rEYgD5J5XSBQCQw68rhaNeuBPGdNOwT8Bsj
         nbsDqp+26CokbzgGbbfHcYNQpwl/WVhLruB7PYU4RH/o0XR+qaMbwEZNTAqcSSWUAYNy
         4chFMVo/fkDEo6O99/grjddzIq/FwUFA4/EiGIJjMFTqEkCX50q8vlRJ9cOCVkGi14Bb
         PL4tRUMWOy5V3chDY9B9mbaauSA1E0Hi2YoWGw2ADbG1zBl3PYpC+I150ng2d2cagI1+
         L0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788704415; x=1789309215;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PC/6bfIhSGPf12M7phejzb1AYIWg3N/E3Cnmwp3VYxU=;
        b=CJkq4yH7MptDtEmbaiUXFmVrc6EieHrvvHTxUeqM5UQwzlgiCET5gxoU/t8NNYVy/1
         6GKZKF6xMXelXGhHxhajwfkVOGUaNFy7eRiSInTFWmE4Q1mm46enySbZv0S+nMMGsYD7
         rwXNXEVJTzxrGlTynORBSVtsJnJ3RK56sLUxZgP9+TYR3uP1Rvhi7U6ZNHPMKG5NQeir
         Cxs1tIJXoKTArAgYVbRLA0eKB+ZNm+kSss4y9Az62jaP4BLYpVaCLHohoiE4kqmSdDy5
         h1aDy6Dy3EQ/nXHbgxgUa3dUJ5n9khQjUJ/kOOHBWY73hCwP83ouiXmUrREqe0bgSkMH
         Ud1w==
X-Forwarded-Encrypted: i=1; AKwUvBz9BbJ5ghRKgU+teTrrWPIwKsQnIPj/lipf59fEY2AnXw7n4Nl1iboQbPgqgHJTk247yYT23y582n4=@vger.kernel.org
X-Gm-Message-State: AFuF++m9sxffJXEbMop12tfk8qm3jHWJoTlAWLn/b32c0B+UFQ6lkpzZ
	Cy4YVKdTbOToSbGDZUu6etGZw0G5G0TDl9ToRQkAw9ZRSc72DeMgs6ip
X-Gm-Gg: AYBFou1+fyJ9C0a57sLZoIOVQB6HGDZgXKsIE0vyX7YC0ZanRD1tsB/6isivYWEdL3i
	3axGskyfR9EFQ3zY95Px/Cd3uBKXiL9ey0aHaztOyitUGefOgA67QByXcxb+J6otg8IY+SxVyux
	YwWjA/DAmUOtTbSFafa3UjSBt94SwliJ3K5JJvIO+zdCltPk4YsU0a04e2pY/xdI92qaqCqMf9J
	yO8M/1BsDxmynSxl7fGLGSDmUR/GLlN1Mf3E3vAKi/F0hUHGt+eaolEZ4dH1QC2YCESqoXSYwrd
	btxkUXONmR3Sxvmcxw6aJtVH2p/jC4guj4ma6N0Mp6Gz2YrjAC3CdeVYgl21mSHJ99zu8RDobQq
	bE3ezDwtss8veRGO1Gk9TEVYeBLM3xg1A6iBOBXRKzcnciG+0tM+zJY+8oTyc9S1nB/wELGjoIx
	m78eGhmYzMHgA9OmAGg4oyDCCG6RKJ3RlDXErCiJ5g917IARIzucJPVkE177j3RRezWUJf0tVGJ
	dGIhp/t5RRKU5OY1sK8gJIiWTlOcTiPsKbv626JczXsToUEUSKGck8+lT2mJAvddI4ekGAkvcXW
	sg1B2RI6ayqltFxfnengGGlo7eqARtuZj/ajvnUI2BdR4twjPEuiZ/gzosnL7oRqyBPewK0raKd
	nCk7Re4PZoWI4evHDChWkiBb3PxS01aij+0lkSkjNiO/I1cCYzqCMnH4bkYqnLthpM9W8
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr203713775e9.11.1788704414481;
        Sun, 06 Sep 2026 07:20:14 -0700 (PDT)
Received: from systembl0wer (78-80-112-223.customers.tmcz.cz. [78.80.112.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm315898635e9.15.2026.09.06.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:20:14 -0700 (PDT)
Date: Sun, 6 Sep 2026 16:20:10 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] staging: iio: adc: ad7816: Fix SPI read
 operations and VMAP_STACK issue
Message-ID: <20260906162010.07781ebe@systembl0wer>
In-Reply-To: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 14:40:47 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

No overall description of what the patch series actually does?

> Changes in v4:
> - Separated changes into two logical patches.
> - Patch 1: Used guard(mutex) and devm_mutex_init() instead of manual lock/unlock and mutex_init().
> - Patch 2: Used __aligned(IIO_DMA_MINALIGN) instead of ____cacheline_aligned.
> - Patch 2: Fixed the sizeof() argument in spi_read().

I assume you forgot to send this patch? It's not listed below...

Either way, NACK to this series until all of the patches do exactly
what their commit messages say. Applying patch 1 causes compiler
errors. Ideally, you should compile each patch separately to prevent this.

> Abdelnasser Hussein (2):
>   staging: iio: adc: ad7816: Serialize SPI read operations
>   staging: iio: adc: ad7816: Use DMA-safe buffer for SPI read
> 
>  drivers/staging/iio/adc/ad7816.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13



-- 
Kind regards,
Joshua Crofts
