Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BC35A3AD
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903922; cv=pass; b=qTjiKXlAm4gNEKL4+2X7YpyvnJ/LvEBxHdU2rTmE2a5/odVaMEQHaP76hWsC2I7C7VbgPjzf1R85rdlsxQbikML/EC6B8zzxmb3k0ukRuiivIuFNMiHCeege2HbqJy2K0kitCqQxkxhl7iycisLbOpwfjGtfrkLXwpTeP3/Ckac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903922; c=relaxed/simple;
	bh=1SodSqqkvasZR9USSY2Je9Hrt7Xso6A46JjvpFqRc3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+C7m9YbX2BNDEk6m2cVM99mFtSW645e6HDpLsr8loTsjm0AeV2i8812OnW26NinAVVRU30E/pN99TlMoqcqE4bb5pZ1eW8ZmFxoYl/9sCWJK9LN2QOyYzjkbWAvY+04ec8AF+w4r4BRerDl/MR6ALNKSjxpUkg/kNAN9K4645g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFxEQPXP; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFxEQPXP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso29411265e9.1
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 07:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777903920; cv=none;
        d=google.com; s=arc-20240605;
        b=Px1keufaZnCL+FR4PZHvGF0ZW0DsgRvgYanW6NqwrYJycbTE543lMr+BsYGQQvYEgv
         97Ye0jKDIgYDcyqB7cilduVJbET+AIMwsErPhOLdbqWzkjJLtdWGsnzq5Beq3MF4NZnI
         qHxu1YH2xbGC/ZngBNowU4Ur5J5yGQvNNcLwy3pCzXq6Iu7eOzNlS5HSCOjnFnO/vkIA
         MmV/xK/MzGHITJp9kHjxIRiZG3L5jKmUBb+4GZfaxA1+bY+hBqciqoO7sJIF5atHYsBa
         I4HJ1jjHQASnY0/BlF8T+DTYgrz0YsN6auTkHtyi60HPZic1mTX1HAiyCNzNO7MxH2nI
         499A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Qy3mnElPeqauK2WVNRv6ojV+YSJou9nK2KFjU1pTuFE=;
        fh=K2a2I1ApZZ33jRSvf0A8MruH5vNSQuHiSWk3+jxjyVc=;
        b=R54/6I1ir096vjRFcCCy/NnICRfr47YKqVtKKDUiYsc4/okqKIULvAQPLqqh6scAEt
         ndCZZ/zBy6zL2eXKe7fBNs7z/kKItvs7RXGSW0+7HeE7bCMgpl5Va3HsSzoqCp5rnFY6
         bAkDgzHSXD3YwwYFILEMGrzXdcD71BDxgjAp2l2m497tBq0rdDE+eKiBEIGFxrS52Q8f
         SP6oRsQSk7b+/Z80yyhctcMoqx1VKdEQYAskHck0lzYBS1FZv4fs0IRPcjToN9wR5piS
         Sd1sUko2V+ig8PV58T9otvJx5opuv+i1XzIhUb2ooO6JGDus4oU9MokMmhLG8cq228AK
         OS0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903920; x=1778508720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy3mnElPeqauK2WVNRv6ojV+YSJou9nK2KFjU1pTuFE=;
        b=ZFxEQPXPwdwIROeXTfZLVCqwx8PuWxKDUXMyqqfY5qQe+HDHb6dTq4S7suFksKwKCl
         xCg+d4YWO7eTjOeEf+GzOe69uwCgR5dGoUgYsxCP77AIDhRDPaYSbWdKqoRCdnROg3OY
         0g82Gx1ASFTtus391QpN9+vqU6gmYZqDvNwOM0o49uU0pMBzIlolAkv02J1LG1n/UkgP
         PqRxP8oVMIwQThjwZJBF/fkojcvemW3AVLdz1X+KOiJHBmc55vtPoAjQYUFxjjZ+vLli
         CnFmV3CAgYSVQrd3/cKwhYaaZ2m2uBWdKZM4MI0V/jIfYMV6UuHS3IEHIvu7E8wk5air
         I9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903920; x=1778508720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy3mnElPeqauK2WVNRv6ojV+YSJou9nK2KFjU1pTuFE=;
        b=bO1qoZaC48h5jJS9aq8ZvYu1f25KwP0qwRQC/tcmXDKkRZztZEgBPEk8T9sJY/YAN8
         /j6RuxubuhQc1BjsYE+nVW3M/vvSpQX+0TChx7QSFcv2ajMTaEVzpeTSc3m+4NRPMZAJ
         +YuQCmP7Ikt7/B3+gRuRn1SaZv6FX2vab0FtXq+eFv9unysfKorxgPpXem9eT38NP7ZL
         xOv4n1tZKjaKqffluZof5nFKQ4GV7q2QSxD3RRdyYVBgBKyv5LrUKJ3WE/3s+LtMseg6
         W459Ir75ligdPNq1iIaVocXszdjynuS27JvSsQXuyc6LUlKYWI7cbhzcRCroZblf+IZg
         tAsg==
X-Forwarded-Encrypted: i=1; AFNElJ9OO+DJvpyHurXJPnJhvSZBReT9cKNeUwn5TRuvmrvRUzsQmTaoN6LBOSgGO6PabJNGezUdTGd1hD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypg7HTp/W3Iq76Bt3+yPYOfR8mc+0WlVaEO6LN4Ut4Oporu0RG
	f7pysnVnL5ySJhh9uOCfYmq2Cmo7JqczovfIHbVQvI98iAEYnV0Ft16gXMMhV3+4ECTN8rZ+SG5
	aGlWtUoiNCPFsGVRnv4A3sIlYlqKXC40=
X-Gm-Gg: AeBDietniwnR+EUNCFUxy6AgZjcf5dD3nI6i+cmxGV+pNyl/336MfC41m3Hfxx4Pji9
	7ahvcmAanQcCBOtvwcDcxKyAcd7AvyT+01sJt+M9euX2PlQ5A4sAjyfQ0x40jI+6VUw5PcXe7F0
	+BrVV6VBT2CaWeir+1GXqibxObiW5u0BuSui+4Z7WY2ADiInUPkwY23OtdExv4+DcRVJbCAMWvI
	p/tQPyH8RyOH8bLPz3xmRswzLh3O5LDkPfMVfUhmR10kijsc4k/ZwYnW1gYdY6WIWIR2/40uoiP
	y7Z1uWndMx5Dj3fmr1dSpR6c4+6fau7W0lA0fuWN9b7zVa03KSCgQLbZV498GYLwaDUl2DHa5+S
	yuiJdmyPEqgb3QKrrpJ6rh27Kz5y8khaaXx+e/jfNXC4PatZW0XiT75qbO+80dFN89co0M3qVBQ
	oauKziy27KFpKYoU2u
X-Received: by 2002:a05:600c:3e0e:b0:48a:52ce:a4b1 with SMTP id
 5b1f17b1804b1-48a98893048mr169925545e9.15.1777903919642; Mon, 04 May 2026
 07:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com> <afh-smyJoL7xRiqZ@ashevche-desk.local>
 <CALoEA-yr9B+74KdSY1iEYssvPQoSXdYjXpNFBzrdZm4RHvJ1jw@mail.gmail.com> <afin2x3jBmBRKsuY@ashevche-desk.local>
In-Reply-To: <afin2x3jBmBRKsuY@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 16:11:47 +0200
X-Gm-Features: AVHnY4J0v3o3WfGv1j6GMDqR5FcrYKi9uTOE8hQUMfx1-mkYzax-aUkNERWNgDc
Message-ID: <CALoEA-yeMbbbS+h2YmJ7sr8CXMkQpDKT2=s0pU7+oh=yt045Cg@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 16:06, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > Okay, this was suggested by Jonathan on your v0 version, but I guess there
> > is no need now that there are poll and timeout parameters added in the function
> > (or maybe the suggestions were for the parameters only and I
> > misinterpreted them).
>
> The idea is to see them on an average one page in the text editor, all of them
> at once. As long as they are quite close to each other, the temporary variables
> are not needed. Moreover, I found them a nit harmful in terms of readability as
> one will need to jump over the code to see the values, while with explicit
> numbers it's all being concentrated in a small code stanza.

You've convinced me :)

-- 
Kind regards

CJD
