Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C836AB40
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624417; cv=none; b=ciahx3pbkXuaApcJqjHq2GxnbMhl7TdJlY64jbnexCVqX2NlpG6eU6Lt/nGIn5iKKk8WIg08tjcDJw4XNyCrcBG3vGKRu1yk4XzfbDT5DFPP/wbRU+g67N+zB5vawEj1xfJfjSwFxcbfLXRwu3zv6bKsSte8QmeYxY2S7Ym5O2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624417; c=relaxed/simple;
	bh=hhJHUnyXzwi/Kx5IBoqabTPd6BRuf0miytj3h2lUkH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R8LPY1+lU8p6RV/nWNLkJEi4bHFDwAGeUTeZRNz5rGEdeqQjwfa1ZUOVTwJob8ATt3ZJ7QCPPSFjQdbYkVBebv8uixBO6Lj6NOwH1ATA/bEiwXYPfhreK9XwZtYxOYVOywU0LRO1S1QostD456qlO37ubXxchH6Ma7U/UTyu4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDDCweWt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDDCweWt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so79048485e9.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 03:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772624414; x=1773229214; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PbtOTZEyDRKjxabRC490eCkoRx0H/oDiCdXHd+Ic+XI=;
        b=KDDCweWtOzYn4I/UH+CnwrDkMnXZazShDwi08VF9ggh15bE7cTjWoFeFIOotFgPSys
         iGigzH8R+EmSMzB2LZJ0Htgk3yGr4BNCAE1xdwkfVfBBVAfzh8pogKL/8JyYdEQ25vsX
         QtN00GWsaOwfU4Z8z1yfbE8Ab9XWIP1x9V+xrniWhDDznok2gKneHAv7Z07NX2cDmHHE
         p/Mc7giKtIqbtm30dUfkhRQCPOKiVDl9M1Q2Br9gt0xAk1uFbOtSe0PChAblVJJzJ++e
         tXTLbuQdav7rgX3dVTFWc9PC5UOCfgv2WsgZKco6ZDwi8Yei4k8XXW8mW3/vCPWLfL+N
         vaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624414; x=1773229214;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbtOTZEyDRKjxabRC490eCkoRx0H/oDiCdXHd+Ic+XI=;
        b=OLtZSj6OsboW/bLUMmNGSwXdRGTNnZu8b+H3BAdkFx3HKQDYuPmvNX60SpQ8+Om0uW
         wGikwlLcQ+RcRzEC9YgXFd7XRxYNsynIst5dB/tKIF62nIx/w5AXHcR7AjPW22ygaAeE
         +BX//TPr2nZUKjZ2zfePMl8eFB8qGOEpW3uk64VSwh18qbmLA+V/I7tTJ8jRCpb3eTDq
         IgdXohgbmqF/nURPO7Iy4XGRy6E8YvSlWmfJqMiwRd2EygEzwhzHzd2BAyRdXX51Ptpu
         8xGbg/EreLj86GtAuHSmOTTA6wiXEy1yDZunRzsTTzW6OLT+uv8JBD4fVOX8h/N1SDIj
         5NPg==
X-Forwarded-Encrypted: i=1; AJvYcCUzermAOR4X5QvnDaDLQS/FrU0WAZ+WdgeNAZcw4VhGRadn2Sl8Xg6GIg9/rjFqY5CnWaf4LCnNYr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVrNP5F5rRWr7meqCmTEGWXafzKVfmZ7Jx+ktTkVpf2fPmopEp
	B4jxpBDWtt58aYuxscQAu1/7Wp3VGYwrQpZA4zDTVsNe+/SOuw9cCEZp
X-Gm-Gg: ATEYQzx/QDq9S96x+qjS7nwQoQ6xKfl0leBF9aD0BpyYzeL8Wqc1IP+XGvGUmCaQM4f
	JPtwi5dLARul7MinJ0gp1VubFLc6ATJHZyLBxXH9PsAAjifjq1gm8aajuKmP02QzBWFyQ9mUsai
	urGgz9lO7a/86TlUDlnNACBpeJsbRVxbYF4kYwlJCmPBVCVUK9NyXeJPE2ake68kiao0P/TEtxP
	6xaxwPVtWfRu7Nybig1qvZjXmLPPENRuz4sYQMk36YTQFFnXcBb0ibyuYnUPRMkpBTGXvkksdJX
	RwBItaaXNG1cIACIotc5DdGMj0NrsHKIpqgYP5Kw73yVWksW7mfuGuwmaHX1zEBjLlwjDMOMsp1
	+2S0eTHvFG2Yhjikdqlmv9NX1xBv/aIU0s3dSs79oCa9Gpmt4LH5CoUMxW/uS8wNXmkJF/9ZjTV
	uxPGDyz7YYYJzqFRSujPUic5RgqYdLsf8=
X-Received: by 2002:a05:600c:a51:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-48519889928mr26061705e9.25.1772624414000;
        Wed, 04 Mar 2026 03:40:14 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884225asm47072305e9.6.2026.03.04.03.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:40:13 -0800 (PST)
Message-ID: <7888782857fca26d6562c5cf1807fc7488c9dde8.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Christofer Jonason <christofer.jonason@guidelinegeo.com>, 
	jic23@kernel.org
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, 	michal.simek@amd.com, victor.jonsson@guidelinegeo.com,
 linux-iio@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Wed, 04 Mar 2026 11:40:58 +0000
In-Reply-To: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 10:07 +0100, Christofer Jonason wrote:
> xadc_postdisable() unconditionally sets the sequencer to continuous
> mode. For dual external multiplexer configurations this is incorrect:
> simultaneous sampling mode is required so that ADC-A samples through
> the mux on VAUX[0-7] while ADC-B simultaneously samples through the
> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
> VAUX[8-15] channels return incorrect data.
>=20
> Since postdisable is also called from xadc_probe() to set the initial
> idle state, the wrong sequencer mode is active from the moment the
> driver loads.
>=20
> The preenable path already uses xadc_get_seq_mode() which returns
> SIMULTANEOUS for dual mux. Fix postdisable to do the same.
>=20
> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christofer Jonason <christofer.jonason@guidelinegeo.com>
> ---

From a code standpoint:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v2:
> =C2=A0 - Align continuation line to opening parenthesis (Andy)
> =C2=A0drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++++--
> =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-=
xadc-core.c
> index e257c1b94..3980dfacb 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -817,6 +817,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev=
)
> =C2=A0{
> =C2=A0	struct xadc *xadc =3D iio_priv(indio_dev);
> =C2=A0	unsigned long scan_mask;
> +	int seq_mode;
> =C2=A0	int ret;
> =C2=A0	int i;
> =C2=A0
> @@ -824,6 +825,12 @@ static int xadc_postdisable(struct iio_dev *indio_de=
v)
> =C2=A0	for (i =3D 0; i < indio_dev->num_channels; i++)
> =C2=A0		scan_mask |=3D BIT(indio_dev->channels[i].scan_index);
> =C2=A0
> +	/*
> +	 * Use the correct sequencer mode for the idle state: simultaneous
> +	 * mode for dual external mux configurations, continuous otherwise.
> +	 */
> +	seq_mode =3D xadc_get_seq_mode(xadc, scan_mask);
> +
> =C2=A0	/* Enable all channels and calibration */
> =C2=A0	ret =3D xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xff=
ff);
> =C2=A0	if (ret)
> @@ -834,11 +841,11 @@ static int xadc_postdisable(struct iio_dev *indio_d=
ev)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	ret =3D xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_M=
ASK,
> -		XADC_CONF1_SEQ_CONTINUOUS);
> +				=C2=A0 seq_mode);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
> +	return xadc_power_adc_b(xadc, seq_mode);
> =C2=A0}
> =C2=A0
> =C2=A0static int xadc_preenable(struct iio_dev *indio_dev)
