Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003443F787F
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252882; cv=pass; b=jkLBbjO9m/uXsnhln6mkWfRkYz4VJkyN8S3DxXlhqnkCH/MRNoSKdPRO2Ak5VwHGHzAu1j9CIm+9SmtoGqIL0sTN4pbuuLtk7DNrj3fIfRt2ZqSaMGHpkyLO8XsFa7IVpwJX9v0BNd9jUPXoF051sWridhEl7IMl4ihxGth6ojY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252882; c=relaxed/simple;
	bh=5IxGXyltzYauLjWwPl8nK/tqMAXlPBjsU5S4lRpDLTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eipEgVXpLs/iv32isR2B4ehXMWnXoqDwnZexQbC+zr3A6TfmoPfnWJb4k15WLT8JsehQ5vqjucqjOHVDqwtPwv7V5rakaBqXDlJGxDmKOMZcb6CuououksJezJ7h+I25tHfr/JuG3exP1vjhH7ztx1EaLT5Gwi5+0cRtGUHP3ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn/WJBLl; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn/WJBLl"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd87e5d8ffso37175607b3.1
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 08:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778252880; cv=none;
        d=google.com; s=arc-20240605;
        b=QOF2GMmCcNH7qiViSbGskIff3gOQuYSk3sWi12sa4W4xOqUuh6++HnvcG5N65IacSN
         8FlUY+1JdwFr9R5nqP6py1vQNwlwhe8weGFnWS+9Kw0jOFHjFunPc1MXJgYAKvK+26dr
         y7MAhatb1hgxzc9p2aUa9VPDphApqPN95jeew3/0MTincjEZ1Hd9fcZArv6ikMttIix0
         eL0545LUhi3JIUHl9mS8E0/3zr92XToeacMFhCdH9nMrMWqjSo7E8Mws9GQjpHXsGZsn
         LM981wYRIiSgpEJALS79OaS7/QcU1iA/Omx1t8X2dMWSzyGZ9h8s25Gg5WFs8gmNgcQb
         hmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=91iaZXpk804ML2FZfaLUUS/RB1+MMBa57i99Tu765gs=;
        fh=szsit64EOo8vQ9+a9GFppXtQW5uDSC4UkjpmWjZ9W+E=;
        b=ZXCJifG9AVNnu8IbKB5To3moXT2LeoCSsxkIKyJMxUdwYIthdkFTSyQCi3BXLTPk3h
         s0PXt+XumiqqrpiLfeDX4qlt25sKiawtML5YQ3/QZDQ3Xtj8SQJZu6X/iulUyY4qeFF8
         cAA8HGOC42q2WPe1uJL9brhdqJVhFJZ185L9lCGKp4HQqGC2CSgYONMrXiQ8/udWb60U
         CMdVgg+CoxVsZTZwaN1wxnJM/EWMmHXYaKOrt805O62XjxCyj5nn8P0pRvROMdr0Puym
         TIlVcljqyTLafxGNBCIxtGWbnZiRmsCwQcXw1S2RRHery+20JEXiZhvSv549+WdT8nuE
         MVzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252880; x=1778857680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91iaZXpk804ML2FZfaLUUS/RB1+MMBa57i99Tu765gs=;
        b=Fn/WJBLlIP6rulWeCKwgMXQ+nqx7u8GuTVEB583RjQw2NUi6R1zs/7liqOzwH/laqf
         V6QHz/igfn9ZwRr3OPsku0S4xR7V3ijPdpkREnTrT2hjRbPp92Olzfj6BXrlWtzq/oL7
         u9gJ0q51J+vY37HmuHUmAaWaPWItRh3uISZEBpzNMhedi6Oh/Vsi6y5wmi/so21E0FF5
         xCvKY2ChyDYa+1hwCDfYiD6Ouu55i7X8ogkhJGnNXnax3/Iscmu8DNtin4/dVlNGm9QY
         a2z+a2pTP84egHMtSHNW0dQQG9+5zju0KAWHOPdwmlunZmYz3+L1wGr3GH5YeU+dsqY0
         Q1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252880; x=1778857680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91iaZXpk804ML2FZfaLUUS/RB1+MMBa57i99Tu765gs=;
        b=BmX7OtAcDQxqY+xMKGQe2dYQijMpzovDBkJaMdh22fv0V5+0ChLBz927z5MHOXfnU2
         q/iBhPl2Ky+LxmpYa0SGgl6iK83qoS/ZWbzMOUJybS/My5IEYWcd3AgroYacdA0wPXhP
         q7bbnihVRDzyrkPFzfUY5dcdG/WvAnEBAcTmpC9RcEAS4k7Q0xX72dAIW3s8MyO99jze
         jMyZBnIVyZbmcqkg11LQ66xTkagzUXtFL6uFQwSQ6dKlcFbwYAeTd43mSdukCiqpxiCR
         O9h8gq3bX9jeY72r75nWkTyrhtJwXkOVA5AeudTlO1hsnGlnmYGlnHXYoM0yZzwBSlZM
         OFSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Dm115I13i3FYNjfm77F3C7ndl2ZBfaXeN5h6QtJeHXLFtVOnCfdtUgz+0E/AEg8ETia1DxlFmuQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynKNowbo7Z2tjNMhl35uzFaXew7Mj5zFnXcvOVkPxQYp8wJBSQ
	jp3ZyHGmHzXjWkFw/+Z3h8TQHeX/mynosqM6KPuZuvRSURO5DjV0G6BZuoPZm8QhC8cw6MRCyZj
	ec4kKzaRduwuugL9sQONDEH0/JNncoNs=
X-Gm-Gg: Acq92OF+muDvSZpYM1f/gvfhP2a7LwDkgp2GXqlV2X6Aqa2x+JBr65VnDdOIQ67d3P/
	fFyCv/RBqdkNSQKEaJTI9JG7mcDeib41LE43BUW9ds+0eIAzKv5vdUrEqTQi09HSe/Ig+I/LBMW
	HyTYP7tW0wkEShGUDKtUXLKlopv6bkPGFtxt1FSv3PdRMtpIOrdnowz7Aguy8J8N4kjjxnGnTv6
	tizYnDd+OAwM7YCVd8DjggEwwvHTscC0he4BPkS89rtOgsLzIzlrZ1Nrt5PeH3qGFj1y4alm067
	C6SLC52EEw==
X-Received: by 2002:a05:690c:600e:b0:7b1:9036:a23a with SMTP id
 00721157ae682-7bf04b72944mr63815577b3.14.1778252879949; Fri, 08 May 2026
 08:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508133915.22042-3-giorgitchankvetadze1997@gmail.com>
In-Reply-To: <20260508133915.22042-3-giorgitchankvetadze1997@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 8 May 2026 10:07:48 -0500
X-Gm-Features: AVHnY4L83YSfFJ1ojZ5sHn3D34bEDdBuapoWoQlZJKL1HBFUsg_Yw_zLXarAm0s
Message-ID: <CAKqfh0HhAZjgT5RXe8tKpAt9FgNAM5+xixDsaWpuyN3FyiN2KQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: make command lookup table const
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:53=E2=80=AFAM Giorgi Tchankvetadze
<giorgitchankvetadze1997@gmail.com> wrote:
>
> scd30_i2c_cmd_lookup_tbl contains fixed opcodes and is
> only read by scd30_i2c_command(). Make it const to document that it's imm=
utable
> and allow it to be placed in read-only memory.
>
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---
>  drivers/iio/chemical/scd30_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
[snip]

Looks fine to me.

Acked-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
