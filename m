Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4C28C2BF
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771221998; cv=pass; b=YJK1V82NtEvCgxh2ndDzbhnZgjw8m5jwqM18ieIuwD2GAzAdiYlh3eTmVJFLryt+hewt2zc/S4FED1fSJ/6ycShKUqdPGQiOanzuFQS0E2Yz9P75ykvms6A60RIJuA33/qfbLVvt48JIFVd+k8U36FKDrm9EHvEiY6fZyUUHePY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771221998; c=relaxed/simple;
	bh=w6oUnDj8mS1GIYBszh3L1atKbMxJn292y9Z61m2Eg2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1xJjQZu9w8RPgIbIGytXKe8wKAtf5em4Jka00n6S8fTLTDZg+0M74o4SM+/AFWb9eluP/+/IdM0BRRr52dDgVDtmPeI6NosdTODDgCaMKondB9vF1HhgUuDtgdaCjuvuzZO8XnwCDYO+AK4U+OqMDHnKk2RlxgGsn6p17YlKxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYb8O+6n; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYb8O+6n"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1270be4d125so1230356c88.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 22:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771221996; cv=none;
        d=google.com; s=arc-20240605;
        b=IOFI5V3+A1Q2HSpD6a8tvsY5VLVucx3IEhwPUixbfMo/FrB/dreMFQsdsEOeV07sQE
         7+/B/fP11OOQIlwLGzvJE3jpQ1FUDycv2O5BwZhhTKa1xynxRvitBZUR+cRDofiOCv9R
         JgfDkmj9cA7qbcbndpLPIbevSk5Jr7K4TXixhkvq/Kb4KJrSEDsUjoqxqtUI2iok4IFr
         F8C8kFDnXknJn2tlznRAJgL3Nk2R4GgrmHRP5IIxtxB2Ohq2diIKXK1x7j20iplY4Bih
         yr2ndf6saIVGr9+otBebmsBmaB75dVrBH46P4fI0aWtW+J809kaXUJ5oTlrcy07sgQ4p
         EQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KN4FR1nZnYa1IkW8oy31g64ThWxjZHfPWxGnRqBqNoQ=;
        fh=wGT/LyHDV1qVS8zd3JqUSx9s2wNU2lX1pUmU8ODmjBs=;
        b=CMACmF9THuRQtgh0KWk5nUD9uzkyx0CbriKHoCpuHeoAzIvpZdcMbr1lLaT+6pkiRO
         HA0vlrT4AAinxWNw0RLwCnAZTflPtUWkK3IWT5cT7mXZlu4nztbY9BZdpsfaPHdMoKIG
         feGICbTsgglmVgQxrQIznCgRgI25aZC+i37kE6OHIn3Ag310eSLT6h4CRomgddkyKpR2
         GciBr1SH1Fw9q8Fm9Y7RdmKZqQbGE8aZrYyp3i47A3xO7XXWgRWveYCZS+sUBejibfAc
         HBcTv2CYzBd0jKJ+80FAXH8Pn1Z5Da/XTEo1aVb2PPl0E2ExQJsBMBOVpD9bEzgaQHVb
         I+2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771221996; x=1771826796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN4FR1nZnYa1IkW8oy31g64ThWxjZHfPWxGnRqBqNoQ=;
        b=eYb8O+6nG+jmxxlkXJkvsZ054XFB21mJ3yNBWV9SY9EFuLO/Er4ZWTw9whw4rwviIW
         I5uhpEhWbcnn3f685UjClAzsaYHtfA2Wtl2TZLlQxT0gddrYIwy050jOMul8vp1Gs2P9
         KSBwCvPI3ICmdNO+9nsZoaExMqTtXWAJrFXj7u8DvwlF7Wzubqjr5g+1oe4uK65QtCGJ
         XDex2MogrmLYF5Vx1QKXBB6yVioxukY3uBXKnZjZC2LCj1ikKUX+H5nTsRr2hoU8BQm+
         pd1PtoWiWNNRsSJBJqjeSwjLj4NNewPpVD7E787IHfwWOGVa9EW/7aXKh/A0G9ROD5TP
         XLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771221996; x=1771826796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KN4FR1nZnYa1IkW8oy31g64ThWxjZHfPWxGnRqBqNoQ=;
        b=eblKBAtAceD2GRYIKlGwIhUPIE2uTJjcCSQgKaS6vaq+jUK/2uYc6sLmLBdBkM8f2v
         Wa+oPwiMsNaixAU7bLsawQZMx/dUG5U+v28IAK/+yU2a9/QGQ7HaNcLvzz7j1ktKIJ9s
         WppB01RIyJkkLEM/51GfucpJniVBPlTUHJQWy/CaHBeVOuE91ME/ZmFtj1s4fX9P6ZSY
         Qfk0ZVp3QpYcbeypOJpCl6OZh7mfCSVDVQIAgpVZskJ8IAP/39i8Mq+GQ1dkTeSjO4hf
         zb3DsQn61VgGhIrV4Wc77Ud0lRofCWFUD2htQnWrFJMoiz6KVcjWaPveLAEuOn5eiuA6
         rFew==
X-Forwarded-Encrypted: i=1; AJvYcCV4ReolKr0UG+f5mrn1TdAqshYFqcjZEnNBMldjc9zS5deOc/gWa+0X2/iM2lyzBvBmM0n4n2ZKRNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3qZfZ46TDpRCyWTijU42aPGqDvItqLhOjFLLtdiuYxRxtNYA
	UpAbk6ubzv7YxdgBZoTvdLnpJZlQcGM++kousq99YPMu7/QjVlGqOJHhhYjNaO1EzxorInAQ4dJ
	pd9GXCsVMwf+3Hc/M99uZMK5TU8H4zls=
X-Gm-Gg: AZuq6aKQwAbMkhY1hKYOhWEWR62kBV93VPT/rM4I81yOdRvPB5Vj+Pc/2QipWyDDH9L
	/e6Xmhq8WLJi0WFqtdAQtq7f5Qa5Py1xzPIDYbfQsZazqps1xAdmHzOSSOnjzNSDUx2MDBhGyPf
	7ZeAFXAJIDT//Dr9Q4egGDNyTvaJ8o9+Q9Gx3xKhBPYmhnJF1tIbP7sDiiET1V8aLP0CSXa8RnU
	ajVNnpqklFF+JpepLiXOGBETLPItEoqPsrHzmH6y+VG3/nYum/dBCj62jF+ttmU9aBZ72o6fT2e
	Fp8FvbQ=
X-Received: by 2002:a05:7022:e1d:b0:127:3214:c868 with SMTP id
 a92af1059eb24-12741beaa84mr2827136c88.47.1771221996384; Sun, 15 Feb 2026
 22:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212124609.24745-1-antoniu.miclaus@analog.com> <20260212124609.24745-2-antoniu.miclaus@analog.com>
In-Reply-To: <20260212124609.24745-2-antoniu.miclaus@analog.com>
From: =?UTF-8?Q?Tomasz_Duszy=C5=84ski?= <tduszyns@gmail.com>
Date: Mon, 16 Feb 2026 07:06:22 +0100
X-Gm-Features: AaiRm53pjrAnbv1Mr6ApvXPdu8uPWcs4S1N1OQKyL5yNhvVeCfoqZhln-Cswmd4
Message-ID: <CAObtm8zff-pnU=Y7GugU3kg_ucWSrTJuYz1iATUQuPvVfgqi1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 1:46=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> sizeof(num) evaluates to sizeof(size_t) (8 bytes on 64-bit) instead
> of the intended __be32 element size (4 bytes). Use sizeof(*meas) to
> correctly match the buffer element type.
>
> Fixes: 8f3f13085278 ("iio: sps30: separate core and interface specific co=
de")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/chemical/sps30_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps3=
0_i2c.c
> index f692c089d17b..c92f04990c34 100644
> --- a/drivers/iio/chemical/sps30_i2c.c
> +++ b/drivers/iio/chemical/sps30_i2c.c
> @@ -171,7 +171,7 @@ static int sps30_i2c_read_meas(struct sps30_state *st=
ate, __be32 *meas, size_t n
>         if (!sps30_i2c_meas_ready(state))
>                 return -ETIMEDOUT;
>
> -       return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, mea=
s, sizeof(num) * num);
> +       return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, mea=
s, sizeof(*meas) * num);
>  }
>
>  static int sps30_i2c_clean_fan(struct sps30_state *state)
> --
> 2.43.0
>

Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
