Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229B31A575
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778394969; cv=pass; b=rGXZc4RKbEXrLkxOEDSuzQUTR4vxweNpUDSYzLxynQFnANiSEtu5+0B/L2WIesEDLvh9YozdJmtOKivFMID9jgvaEGz78nr+/wD0OeOAFhr4wZo+YvOBvfcR60YiAUd4rIqAAPMWAVYRqNqlqYcFPU21kMUxTc4x8kmWGeHFLiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778394969; c=relaxed/simple;
	bh=XVPuHVaudv1XRrcrlNGyZ1MparSuw9338ihUKYeXXfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBeGw+gp6aqs8J3CRWPQhumW9agSkkQVZcQ9/58AMbFC8RFSSiHb4hXHAs+j59lpr+UF/NjDMsGorEGOOHK201NuCNgqIZVjg3Ip9OdOiiIcJFkCr4utzh3EBlpypa7RBGCW1gSCwB9o2AedzS8Ytxxa21K2gFasbWfqc5QtGUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGI+M4TV; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGI+M4TV"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bd65714dcaso34132487b3.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 23:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778394967; cv=none;
        d=google.com; s=arc-20240605;
        b=ePYW1nCLBH6vWVx/XUS9OtHt+MHlTxeza0tRxpLmMou1YaGrDC6bYgAh6bfZCGwxdp
         bHTeq0o1+C5ueaBfPGGum2ycTTgHdj35M3pS7S5t2/oMtNHcebPlmObWfzFNfmKlaFoo
         Rnv8ioMX1vvKOUXAhzSpcHkuHl8JQH2xx6eD2hq0pwbKm30mH6a6msuj8Ev+uWaNx530
         CheF+/0RVfLYpx53uN80hrDw05E6Hsw+cZPJyoYKPKdtVpyrClaJievM1m2EBzpS5uh2
         yQ4L08JjRo0sVrORanPJ4AMcRQBjcvTyvFKrHx6Ykyyt3tsP291uBhF3SRPQEyN7F9A3
         sTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVPuHVaudv1XRrcrlNGyZ1MparSuw9338ihUKYeXXfI=;
        fh=LXBxYEfGEDZanT9px7UBC5mj4DHb9ru2VmUHwms6qD8=;
        b=lDQeYzR4etGtnOb4h2D+XwFYAo/CSGgen4CIPrqifqF+64S1gBOdplSmEvI52vpQvl
         f+uZD/X9IaZ4mBGSQJ50ON4HMXpoGu3FJO1lg3V1VWu1b1jyggjjTOK3QJAWPgQET181
         lPsiy2dCSTV2qZjuM5D8dYK+Hnnjzeq+pj5XIw+7xlf/KK5smUK/xKAvnbxbNYdR+Fg1
         3wp7q/nNdWKKfWLXeE3onaCmb7n9qXfGPqPgv5e+aHo3OOdC5brZDEXNNO6miIceRQgY
         czHdzssh7TE5Z5im7KvPEBbDdjW+A2AEYsGHC7aS7Na6FKtcQpXzJXfVt0s2AUt2thq2
         aeCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778394967; x=1778999767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVPuHVaudv1XRrcrlNGyZ1MparSuw9338ihUKYeXXfI=;
        b=eGI+M4TVTUl5nFklbbDDRA6r4sDTgvwUxyGYoC8PrVJdlj5nDfMVQ99NKcrujgqSnv
         +q8+I2rq3sOc/3kxaASwlE1h9lgFGXAtX9RzmgErepidF22i2KbuPrdvv8+cd+AGb0vN
         IJfHeVEvRF5hbmmPVKpFSGyZyXWUKh/iSVoDKt4r8Ith5mnSYQKBQFA78eJxZs7d6AEk
         ddoyQECNWzSOYdx1a/HS4cuZb3KDY/NZkzJ6np7tDvep5QTDop9ikvhvOZ7md7oqNs3M
         wh/HHS/PeEdTJoPKgH3qUwQ05FuReMRRzb+X4Wnoo+mEi2TFTHHjsgqxd/WylU+e8/PT
         HX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778394967; x=1778999767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVPuHVaudv1XRrcrlNGyZ1MparSuw9338ihUKYeXXfI=;
        b=Cq1dtFVJtPM3hwv2PCxDnWn419VC/Ns/R5jTznkP0sxe0YFSheR272R9qQqBBlf/LX
         1y/rCu7f34GmXE641Xjcp/NmVwgyBPHDZfhADWVW8X8K3Zi9Ij2BGwc4UtKCu7vAwlFL
         38uP76pgoYL4Qal07AgeG+sTgUF3vuTpboLTJSXUefROBcFUrLJfJvN+zx40vMWc/vgQ
         YMbKvH5YLd2TWEyrdk/+t5HAkRE0BnoND9YTotQSyFgCiBg7nVMg4bRB3WzsUxrGC5h0
         fplAXhARuvRgJPyl1IXXN0sFInWLUiXsEa8YHgzvq49NuHkyBoDJlFY8fz+AjR0fXv2e
         sLMA==
X-Forwarded-Encrypted: i=1; AFNElJ8xqJry9k4wCFtBCKQEfKdpzKOHqG/iTE5sH91K1DZHDt0Ddwysfy4zm2fi96tHiIfmZmQ/6FX/OAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxqgN72bFHPY96VoiK8DF6MFxHQvXwGms7MTSHmUq9payPHCu
	AhysUk2K3VtC/7pP4vTwqro/7ouDI4wgTCqOnre7Y0XHvQl9lozCEITn1z7FTYtPUHqxW2YOvQi
	2iYGuVAnnZphDFTSL8fKzU/32JE8IcRQ=
X-Gm-Gg: Acq92OG76hxT7dT6IYDrMyayuCW4NVd+mFfavb2s+q5tB8aI/mvKmdk82siFfZsNzTO
	CD7q5swBDJNMY9qg4F6PoXY/0LbWsAk5+AVzijfwq/pctFORkERiU9+O/7iWvLezYYRthtwNC3F
	gx9DwLmIrNsbwxmP7s9umW7bYatqugM1X7WvdOhkp6iCMu8qAuBmNIHEQhm45uMvXJopImvTpcd
	bnDB01DvYnma7SBWePw6l5ttsuxi5VQnkvnjvIgEZ2qKSuzqS+gxgRVJwPWNV0ItKG57YB4bSFo
	s9/NgnsTj8F/4R8=
X-Received: by 2002:a05:690c:10c:b0:7ba:e420:7ffc with SMTP id
 00721157ae682-7c104daa119mr49302637b3.25.1778394967174; Sat, 09 May 2026
 23:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509090320.85481-1-dennylin0707@gmail.com> <agAkRBbJiTmWxGtS@ashevche-desk.local>
In-Reply-To: <agAkRBbJiTmWxGtS@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 10 May 2026 01:35:56 -0500
X-Gm-Features: AVHnY4K1-afpEJc8d_Awt34ZUpRahp8hORh9_ArNAzQniWxelZARb_jFw8-Niu8
Message-ID: <CAKqfh0FkUfAh=O6BdM3mX+koRaQk+RF2732XFESR9utxeeWMJw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: addac: adt7316: check SPI write errors
 in probe
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 1:23=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Sat, May 09, 2026 at 09:03:20AM +0000, Hungyu Lin wrote:
[snip]
>
> There was an attempt in the past to do the same and it was NAKed, so is t=
his now.
> NAK.
>
> Instead, add a better comment, if you wish, with the citing from the data=
sheet
> to explain the magic here and why we don't check for the error codes.
>

Agree with Andy here on the comment, I'm personally not a fan of how
undocumented this "spam data on the bus and see if it works" stuff is.
Make sure to mention:

1. We're in the transitional state between I2C and SPI
2. Facts from the data sheet about why this is what we're doing
3. Why we shouldn't check the return values from the spi_write() calls

best regards,
max




> --
> With Best Regards,
> Andy Shevchenko
>
>
>
