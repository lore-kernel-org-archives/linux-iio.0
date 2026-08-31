Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C81E36F8EE
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211322; cv=none; b=rAAbRV/Bsv5OpQA0zmP29G9ZUfSswCykPTR3yiEAP2Ydh2RWZISpxFDQdyjbwJ5G4KbWJXuf9DpmaMOVF2hb+CrSaC7ENCOkkBpcCDmCeWT8EIRdBPJSLYhrl2OsO3yzrw8vxVvJQ0rU6YgVPCk3+8dI47+85wAQhVQaVdU3Mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211322; c=relaxed/simple;
	bh=Y2qk4HBX1AlLiEEPrVMcaqicrDq823MQUt2643iTcUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZN6gvPfzX8hxhtHP3HUQ2VI+nySfxr5S66vEQQaPPIVN+Fb++WMpLASMUEnWIch8AoJY9mCFa+Eo8B+iX8piNf7evcerM36Zt9pqCWvg/g+SYKHSK+2h/jdMdD6VdtFtNVFu+Nlr+NJm3g2HyZZshQiejg5Y/ZMK8+3mLB8VGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rM/SIWZV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM/SIWZV"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso45978865e9.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211319; x=1788816119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RDiF/p4/pzvSLemuA3E3Ov7A4ABDMtf2q8xgprPA9ZQ=;
        b=rM/SIWZV8IxZzfgdpeeTmlENPqDc8O40zNKqjePbXAQWUkW0QTWID8T4w8XxjOEjpO
         yUCKi3OxuF8gx7FtduYUvueQExAUEdhj4f6GCCc7Ja7ecRCzptn/YN0rEZWrWFEHJjxV
         XNCgP6pGRxc7PUiw3MzSDH/8zOUfGNrn1+JaRvnOnJmIfZ85qaTy33vuzMFUulRZq9ie
         rwlpWyg/3Ot3JO9IK6v4VPEFL5qVccUSwDBET8gk5EFpvkA3m1ttw+GP4NgvWGNqfjbp
         4WZVf9KW/R2/bPWJnx7UlayYozSM//bWTxG8TfaqIbUYKmO7aLMU/z38XQ5Y1Q8G0GM3
         xjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211319; x=1788816119;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDiF/p4/pzvSLemuA3E3Ov7A4ABDMtf2q8xgprPA9ZQ=;
        b=VDzeNGhtrM0nu+f1N9wjkx48Ru0vbvf24j3ZUgjLTuqrDQS6k41ioW0YYI66g8UN/0
         V3vft8RgSB9fUrl7++1LDIVHNhLW9Om34DYJ6Qh88rqhQ1EED/FamXDzbm2tTlT1CdR2
         XsatbP3aRE3ZPH+FtrSo3Epj5Joycymw155peR2WCQ/hU1wvl/Y6JD3WLfO4MFjkxhTM
         XtQ3JYoCrUEx57FGKCY48ocVId+08nwqBVJ1bjgKVaDyQa3yK8A2ngDi81TjfjDThMA1
         0VGRlc2azz0kFXFhcOAHhwlV5xLYC/Di09lS5Q5XH5qwtgdZQQe7F9mFi07EU0l+Sw82
         X+Lw==
X-Gm-Message-State: AFuF++kUtF7ObpGV2PCjvl+1pD2QKvUlMzqlmZsw+CFqUzP0awSrYflZ
	Vln/vp5QXe5Cc1Vf95EbHys2f5hWiywntGNtZbjtXVD1FkAF/U1MJlu6
X-Gm-Gg: AR+sD10z4vub4lEJV+/aiBqSeP9tBJdUrYl3Km9ltcLj3wQ6Duf0x7fC6LsSkNeY1TU
	MK1/CjDX+nhXPWVa3TYo0JchnnVhOYRgGNKTTVFLIBZh6GZLUdMvE9ppA74kWL5WYwldfyMoYD8
	WnX+wXoczO7IeeucOQqBzEDC435RsA6Dfi8Md8wFGzCNvTBpViNRZRvi7f5zR0vowFvTH5XJ3OO
	J62CFNrh7bC397gU/LGamApyC+q24OGB/IwWXTeln1a7ld8DeztSeg99rBdT9hoX8C/ly8/Qu4V
	iQyZPZEtdGH8LKRNOZp0URfVaI33Hkki/W3JKpuqz8FYzd9Pon78Ww7jr1EskhnRIdTwloYn3r1
	BexZi1H8iM4wP3GPGko3cYw9d2A8NBbpxOOrJX8PiM5yrkAOjqUb8tc2BAuNYqbG8X5vznSMgk0
	Duycfrak7snk+YTv7arYwKqfV+7hBTXxzAyg7t3Thcr0u557HpWcYXpaFIenQvfWURgAZvWSxu6
	wJBTn71K91W8gQvckQc6UjXVnI44q5z7X5ur50dPmMUJLPtIj3oNDBtjSo1nAOBFIINStfWx4Zr
	GV+nKfZXm5BQ69fY2WLOkrncp0pYiso07coVQvMwcI0Rv1Zl3qK61ShaM97uKWiH1CcFfIMVRN8
	8OIEyxkUL9XRZYno70l7t1WTleyFjSU4=
X-Received: by 2002:a05:600c:4f8b:b0:49a:2c4b:403f with SMTP id 5b1f17b1804b1-49b91c46494mr383888935e9.13.1788211319270;
        Mon, 31 Aug 2026 14:21:59 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a903eebsm196936865e9.4.2026.08.31.14.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:21:59 -0700 (PDT)
Date: Mon, 31 Aug 2026 23:21:57 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Akshat Chandra <notmissinge@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: add SGP41 driver
Message-ID: <20260831232157.27037a5e@systembl0wer>
In-Reply-To: <20260831151235.64076-1-notmissinge@gmail.com>
References: <20260831151235.64076-1-notmissinge@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 20:42:35 +0530
Akshat Chandra <notmissinge@gmail.com> wrote:

> Signed-off-by: Akshat Chandra <notmissinge@gmail.com>
> ---
>  .../devicetree/bindings/trivial-devices.yaml  |   2 +
>  drivers/iio/chemical/Kconfig                  |  11 +
>  drivers/iio/chemical/Makefile                 |   1 +
>  drivers/iio/chemical/sgp41.c                  | 384 ++++++++++++++++++
>  4 files changed, 398 insertions(+)
>  create mode 100644 drivers/iio/chemical/sgp41.c
> 

Not only you're missing a commit message, you're also missing a
MAINTAINERS entry and a dt-bindings entry! Please fix this!
(Note, the dt-bindings and MAINTAINERS entry should go together
in one patch, preferrably first in the series).

-- 
Kind regards,
Joshua Crofts
