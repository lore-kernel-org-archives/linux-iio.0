Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE7258CE7
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782551686; cv=none; b=OAsuEx2W1Gtyq989VxYqKSjws1YBV+9rqmUihd/zh37hRbh3/8ZaAVpqHIqS6omEHYf1gmk3JgGlXKT+IgA/mqnQGwE1Cc0zCxyCRkMfnZyH520gcQs7BTQr69TcMkKho5sSZM5EPG9ysqTlsvYgEfklXNFfdBP9AGe2iaGnkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782551686; c=relaxed/simple;
	bh=Z8uCPIIDNXooRopdDUOK8um3dmG4tMzYyiTEArCN3RE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=rtXZgKJjBEpTgcb/Vxb7nxFwbv2Nqqc8a1bR7VtWqZscjKiojcME+Z+bfZmyaZJy5iFHSA88PDo5/wIH/qginf6TzFq3NZJvt7+h++GulkD0HXeAaNGjt7gmT8V2QQIxHfTSvOq1J3OoCqylvAAlLnhyX6k4bt4/3mOx7NJXieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2iZNxAE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2iZNxAE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49241a577d8so13271865e9.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782551683; x=1783156483; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIu3t9txoYMi3zO+SM6qADSS3eQfqtRnLd308UxDVsg=;
        b=L2iZNxAE+GfDf35Dk+f01WuBMdQCktKfGjHNtWcVKuGUIy1+PAwYQl3fOXazrdIghz
         ZILEx/HBcucajngsfas43pp9VvPGOsUz15dgGel2iqNvEkERXeuKecbTWVX+gHeQUG/Z
         adopPWpo0sYWXRFfQ8+vqXK1dHcaBtisK0kvOnFv7X10a9dVHjlkB0rCLZ9Zc/jVGMZf
         k7W99VEYyjD7Z/LkMF2Ng3uQinh8aPH+FkwLVx0Mfr81Npu1o1k05qHNMdnJSazrjetA
         WROv+/hxo0JsW7QKrYnpTnpellGKMOg8aZFGWHZ5kolCUtbG0U+1Xvur+TVJ8voAkVVa
         YFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782551683; x=1783156483;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIu3t9txoYMi3zO+SM6qADSS3eQfqtRnLd308UxDVsg=;
        b=jWax2O5zIIGO0eFCXFS7/ATDy+PeK3vp8NKKXdDEyDFgsl6PTz2TLgsk4vUTDQQunT
         V3XmArvwY8vSz729ZzWGJGjAbIFWKemcMFHDfOIudoZk37AmGsJoex4tEzCHX9gAnZ2g
         HANJdcyu/Q4tz7qcj7eu/MMT6eiUz3v1ahsai51JBYuBYUkplyOx6AIjZgtjveGcoVWf
         +Ela0ZJFRG/WD6ztx0MtUzww0NpmSw1rRqy1qDVa6T4Et6LUr5J/dlcoJ2XU8Dt5o5I+
         7im9wTGNob8lLoXccrSBR6tcZZPeK2guuuNjIOmpk42JzEJ3S6T5KMJ4BTfvuEu7k32X
         2heA==
X-Forwarded-Encrypted: i=1; AFNElJ8iU0x1DTEVhUNLlSKzJnaotIoNPLM6zPD7TY7dGLy9I5q84hoa3ozoVZvqMK19K8u9VB7Opq9tWDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNbFtDz6Npynir9zo5R89TeguP3XVz9PqEwQKy3tOrTqCASLi
	2nx2sqUHNB9K4V/8yPCvuc66nJnyvB43gObCMAiq7Qh/cZnKXSuOyOtntzCC1ixC
X-Gm-Gg: AfdE7cnIohLeguScG6/PT10bPnChqak0Joluh9roW2urwphX2J4bQV3RwtHSB6dXTww
	n89xNnH9vIWkLWP9SREpUB2oXCQ2XgmvOOJVGxgBrJ8mtIJRHGg28J4n6oZMbMyOSuIpZKs76st
	ONn1xxRKsRx95uYOSj5Z2z7dSfpzby3N400Ez43mihmjHs9uO7EciTP5VwUO0q5U7LvlwVcWdWP
	XCu/XtVyHDWYE5iaydpWzm397AfIv/965KjGagIdHI3+iEm+e49EvbFEPOtEGNY5xoLHLXchEPd
	gY17aWYmNodgvnXVJAKkh9nh94t5Zp8MoMONtCkyNKgLq1nYwW1mfLIDBFseAFgf8N+xMVL8xPa
	jS1L3gcglr2dtsqC9rh5yxxQBLekfm2ulWtIyIpBktx6WpMqEAbdadHfrlsaK+wEa21jnxuFwOu
	e0T/15l5oBoKwgd2hp/b88yt5QLg==
X-Received: by 2002:a05:600c:4691:b0:492:4636:87ae with SMTP id 5b1f17b1804b1-49266880f9cmr146104325e9.17.1782551682986;
        Sat, 27 Jun 2026 02:14:42 -0700 (PDT)
Received: from localhost ([2001:4bb8:16f:1117:42e7:2f77:29e1:f0a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690a1a85sm250344055e9.15.2026.06.27.02.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 02:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jun 2026 11:14:39 +0200
Message-Id: <DJJPU0OYEXMQ.EUU9J2PW7BKA@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2] iio: light: veml6075: fix UV index reported at half
 value
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Shardul Deshpande" <iamsharduld@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260626110400.68885-1-iamsharduld@gmail.com>
 <20260627085313.7507-1-iamsharduld@gmail.com>
In-Reply-To: <20260627085313.7507-1-iamsharduld@gmail.com>

On Sat Jun 27, 2026 at 10:53 AM CEST, Shardul Deshpande wrote:
> veml6075_get_uvi_micro() normalises the UV index for the configured
> integration time. The raw UVA/UVB counts scale linearly with the
> integration time, so the responsivity-weighted sum must be divided by the
> integration-time scale factor relative to the 50 ms base case (which is
> returned undivided).
>
> Per the VEML6075 datasheet the UV_IT field selects the integration time
> as 50, 100, 200, 400 and 800 ms for field values 0..4, i.e.
> (50 << int_index) ms: each step doubles the integration time and hence
> the accumulated counts. The correct scale factor relative to the 50 ms
> base is therefore 2^int_index =3D=3D (1 << int_index). (See also the Vish=
ay
> application note "Designing the VEML6075 Into an Application" for the
> UV-index responsivity calculation that these constants implement.)
>
> The code instead divided by (2 << int_index) =3D=3D 2^(int_index + 1), i.=
e.
> twice the correct value, so the reported UV index was half of the true
> value for every integration time except 50 ms. As the driver powers up
> with VEML6075_IT_100_MS, the UV index was reported at half value out of
> the box.
>
> Divide by (1 << int_index) instead. int_index is already bounded to 0..4
> by veml6075_read_int_time_index(), and (1 << 0) =3D=3D 1 reproduces the
> undivided 50 ms case, so the per-integration-time switch collapses to a
> single expression.
>
> Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor d=
river")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
> ---
> Changes in v2:
> - Collapse the per-integration-time switch into a single divide now that
>   all cases share the same expression -- int_index is bounded to 0..4 by
>   veml6075_read_int_time_index() and (1 << 0) reproduces the 50 ms case.
>   (Javier Carrasco)
> - Add VEML6075 datasheet (UV_IT integration-time table) and application-
>   note references for the integration-time scaling in the changelog.
>
> Link to v1:
> https://lore.kernel.org/linux-iio/20260626110400.68885-1-iamsharduld@gmai=
l.com/
>
>  drivers/iio/light/veml6075.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> index 59187244a..d0ec06eeb 100644
> --- a/drivers/iio/light/veml6075.c
> +++ b/drivers/iio/light/veml6075.c
> @@ -237,17 +237,13 @@ static int veml6075_get_uvi_micro(struct veml6075_d=
ata *data, int uva_comp,
>  	if (int_index < 0)
>  		return int_index;
>
> -	switch (int_index) {
> -	case VEML6075_IT_50_MS:
> -		return uvia_micro + uvib_micro;
> -	case VEML6075_IT_100_MS:
> -	case VEML6075_IT_200_MS:
> -	case VEML6075_IT_400_MS:
> -	case VEML6075_IT_800_MS:
> -		return (uvia_micro + uvib_micro) / (2 << int_index);
> -	default:
> -		return -EINVAL;
> -	}
> +	/*
> +	 * The raw counts scale linearly with the integration time, which
> +	 * doubles at each step (50, 100, 200, 400, 800 ms =3D=3D 50 << int_ind=
ex
> +	 * ms; int_index is bounded to 0..4 above). Normalise to the 50 ms
> +	 * base by dividing by 2^int_index; (1 << 0) =3D=3D 1 leaves 50 ms as-i=
s.
> +	 */
> +	return (uvia_micro + uvib_micro) / (1 << int_index);
>  }
>
>  static int veml6075_read_uvi(struct veml6075_data *data, int *val, int *=
val2)

Hello Shardul, thank your for your patch.

Please give potential reviewers more time to take a look at your
patches. It's been less than 24 hours between v1 and v2, and that
reduces the amount of people who could review and potentially improve
your patches.

In my opinion, the comment you added is way too verbose, and it includes
information that is well known within the driver like the possible
values for the integration time. Once it is fixed, it is clear that it
is normalised to 50 ms because it is index 0. To be honest, I would even
drop the comment completely.

Best regards,
Javier
