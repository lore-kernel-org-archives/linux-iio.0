Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0521257E
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777101309; cv=pass; b=mJAug2RMmq272pyuB/G9tifgAZA737jtPKw6dDiDyfAmoc29Fgv3FH74AS383DVHV6QL7I+wUDCK5FpQZ4RD/Xb2z1I7QM6hF9+z/KMJ/JalzMRfR8D9v6hy6krr12N8x/FVRyVaLv21xvXqdcF4OEk4qN/EDXeW0wMSQakqewA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777101309; c=relaxed/simple;
	bh=xtfryrVisdBU+hpF0HkaDtRdXeziVZ9Lz0F2JqFXgV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EteXv+7RuFgUYU+ihlTU0Rnha0UsgAnUFxEPe9qBYbfRQRqxNyf6L7xojwWh9+cupnkagl7fwmyXamD8PRQPnkC9+sOXeHBe07fXV0naP3btIWdFCt7UKJNx7vvoK8vc6s/R9vDGG/uhuQfRUvmJ8TzJ33TTXNVEV3gMAZPuoEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0meR2iV; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0meR2iV"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-650140d4886so997579d50.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 00:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777101303; cv=none;
        d=google.com; s=arc-20240605;
        b=DnOjLccNGESVM12EZ7ZfvznhScBCo65zIkVBgKAzrtW/rLmQiy7tnRrJPkjobrGwV4
         cVF45lzomli/jNalkuuWBxiTFpM9kC7pfVhULTS91vKIVsaWNNV7qAHYApWunEBq4uQI
         cHWFsu5OizCEE4sJh6DsrS3Gz+fCzaOBt/9DVZqTwJPGYwJY00BTyc+UXaxhdC63+YPf
         lsANzlzlVzhLx/ZXa1kgE2Sf2QOfLO4kE0IUQqpKRUYmG+TYflFlwqdTIBiYGNgAkvTf
         weAJitQEI9FLGrCWVmCrNIugVlys6QGgsm9gx6QncYPajFpui51R6v46Uv1rx9Bc/w3H
         nwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MWzqCyqnFoYNJgUt36Ts1VFHGm0O9I+Hv40QbKqewhg=;
        fh=80uUeoO1VXWbnsbvSN9CuQ7ThLlCxymeicQrMMd8ENo=;
        b=dLSEA0/E88rPvbSyIpE3VL+7PvrqzCMITzHxs3kezUn6zoFuVfJ/RY0ThxPgnn9R18
         unPKuPruLD7KMM5fKSBRZa2Cc/1/AhJW7rVrdEO88ai39l8hD5MRZVEu0jFnQ5LvJEUm
         QjL+LOuHCOX3akN4loSRdWtfBgAZAdZGEEQAmgbhERfRpA3tI5qu1aLMBvik5T8dEJON
         MGSfaGDu4xTAY2Aeln8Xg739QPQguR/0Ob5EibPsHhyjl1pLVTGeXriFuN1NH/0kHy29
         pQanYOLrhd+4e3fW/P6jf0/ZI9B2f/KZTqkbCe7oT4HmWzsy+wS/Sci41CbLr9WBVKsT
         5uow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777101303; x=1777706103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWzqCyqnFoYNJgUt36Ts1VFHGm0O9I+Hv40QbKqewhg=;
        b=j0meR2iVOc87up8Ati7uk7JwKAMSBTMLwc7B30/iqe74wNtjyMCoWOMK9c//DUp/4v
         RzVRucjLl4Fi9bRlCwBs/2Yem6FRSnewgGwK5HI3LCB9PK7++dI6DHowRMHUxkdPU2/F
         WaJhqqGfmUlzI79wofoO4FDaBN22VG+90Ctc7q+NBe9aRHPqe9oZciSMDaFBBQHFrsdb
         iYUqVuBqkdKK+1TTb/CmZAZyxQ8n2Ukcxcffoc6U+qPsmuVBsiM7LTYnQwtmpnojGHQY
         vcpeKl2bKXp3Xv3zVLuI0jAQMhW6LT8Br06WM/9v4htm4xezSn+wqSbx3yxLQuNhOsqU
         c5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777101303; x=1777706103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWzqCyqnFoYNJgUt36Ts1VFHGm0O9I+Hv40QbKqewhg=;
        b=YQmTjymOjATg9J+xqqzdPAFvcyxMxaiAqHrBLARjtMW/5D8XtENk+74CcR5bEf/eqy
         A/11CB4sxx9aaG3rLcRL9EQPZjo6Itf/AbABdxnOynuk3MVV1eGJJ757qf4e/jmQLkqx
         +q5Z3CtUSOQROAYir+Ts3lLn4ami+STYxK08UnrI3exJDRgm7g8JMa3zf8hMV1mNoqSG
         IUvQFGjG3mwGPMwtyo4zvBtwuALQXWin/gOR7+UrkRpjv/6Wr3Xyqs4gwzj4Saqadl2r
         FdpRNrEJvXE2T2jcorrSS2pSlQ8bHMT96lRjFmnWmgTbpNXtSqL1aYQ3lY/BuUbrVEJ1
         YY0w==
X-Forwarded-Encrypted: i=1; AFNElJ/KU79rspt0cWkwlirG2SRTrz+GWI4sKx7dxqui5xAuxphq10wy9zljUi/Dq+pjY8Y+7TShnLJe5w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oBOCuv08tSWr8eQ174Nkjb6ImkA2hFXc2nY3z1p9fnCuUcKZ
	LuMegwMZlEDoLmicg/QNAsqYNc6RqNkbSxoRgteaYtR9aBjEVi1SHdO2+BrxZbIectQuV4szpVX
	vIHrXg2rZWtGOmCMSI5At0TRAUM2fV3I=
X-Gm-Gg: AeBDiesgn2O6t4xvcAmUet8U6Zu99Dkzxo3K3OjCOuyEsodyGVcemKllm84FUJpI0hw
	gTUfzqtCjAaq6nxIrCDz1OS8DVE2Y5tBBJbYe9AEfoZCkMj/AqTKzRGuTttH7cwk9mXEswlv/ss
	xoRh86eZ6lZQGKN8vhv1ge/yZxTQIGJ6WHOgrbMtOyVP9OFy1GL2u0GgCcnUIaUZ2bYzLObvjeQ
	rnwhPmu2nlfgt+dzIt4rCq1llBkodspbTQWw/LD2XFikkB28Fk36HgrKr+mFmHMETk911f+bHzv
	2LZq4OQF5qqbcZwN7HswRfPnn2CaQBlsQQEVNTkfcMmsBT1chbxCLvqr8N3bo3u8pWKOxLOyy+f
	TP10pTejlQ2bkPAyHuefjzIF7SgGf0gRB
X-Received: by 2002:a53:ca08:0:b0:650:20d6:7098 with SMTP id
 956f58d0204a3-653109ab08cmr15134229d50.4.1777101303494; Sat, 25 Apr 2026
 00:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422142541.160365-2-giorgitchankvetadze1997@gmail.com>
 <aej1MTgpzToqxOXD@ashevche-desk.local> <aej1jTYHP0tgJOcD@ashevche-desk.local>
 <CAE7dp2qq6bGJGqupDDGvG89-i2kbVvpVkY-6SCxWZLxatQ09FA@mail.gmail.com> <aespfdG7c7sae-nO@ashevche-desk.local>
In-Reply-To: <aespfdG7c7sae-nO@ashevche-desk.local>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Sat, 25 Apr 2026 11:14:52 +0400
X-Gm-Features: AQROBzCOi2qoRrb2ImqDgoiyUW9hVl5Qq9KpWq7RBA6_FrxBsAe4E-XC0VmXDjk
Message-ID: <CAE7dp2onRFBbN-apFGALSvnHjxFwakrjtzqqFfkWe4L7r3xiDg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7625: fix type mismatch in clamp() macro
To: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> You can modify types including for 'target' on your wish as it seems loca=
l
> variable anyway. Have you tried
>
>         cnv_wf.period_length_ns =3D clamp(target, 100UL, 10UL * NSEC_PER_=
USEC);
>
> ?
>
> (Note, KILO as it's currently used is 'unsigned long'.)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Andy, thanks. I changed target to unsigned long since it is local, and used
unsigned long bounds with NSEC_PER_USEC. This avoids the cast and keeps the
clamp operands naturally compatible.
