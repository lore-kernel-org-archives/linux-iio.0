Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C515746E
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771222058; cv=pass; b=gGRrqQCscmp8abZYWbi/ukkt2Ii+vnemrPubtsHTSbUrJb+MEt0eLIq8Nd1+RDRx4O/y/FW3eTxgk5Xy1X4F6jVOVMo3vvbJwn7EA4ZtCefm7/g1wEWoo9g7Hr01fi8WG3oREs505rnT30Wve1+BZqO8Su7sjzNyOGguqKlR1ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771222058; c=relaxed/simple;
	bh=+TSWFSVndFBHqEYkgl+UwckcgjESGd5f9iSElJBXejk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUr1AjButrhHiahndsDFsoAMwsfwmZf2izIodLVKRJNmTXNxZoq83kItlYWQMt5w7XZoPVmOa5x8dcCeEgJyLUUmkDyiexN2mkTHHCdjydpQ6YfHWSvy8+ioP2tC46bSLegViZMFuGPkZK15frD/cBKT1TjDYin2t5t21n2qXJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W26yh728; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W26yh728"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124afd03fd1so4130721c88.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 22:07:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771222057; cv=none;
        d=google.com; s=arc-20240605;
        b=g1H73UPTWp4Ob5H+4FPURZLKLWCJHtqnLU9FMssQlceVESGfq/KmYB5twdwad372fG
         weA9aQxs7VdelLxHVc8YJqNPlWKa2da0X5fIwqrQixIiYbByrPIL5lrecC4vbii0VBQp
         tAOzkn+YlOyLmDO4ur2AVPWhStHV6+e2bseQTo8gXKbWghPKW++N2RDVk8PeA941/kF9
         w6COCwzxoarBVmsFFSPzNcuy53ihkh92ichckGdQs/uKuRrbuM6+pwSbgQLAtS6B+reF
         9WEdXmbuaENp95nqaDXABww5skJzBkfQW/o8Mg3aGvDp6y9aHclnRIz0vvbn/xZ6u6ja
         TIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnKyXRtTSpcQXecEX2tXqGAjED7Y5hSLnYN4YSmgW8c=;
        fh=LLwD82A8vO0wdgxL6ElJIzQTvPHprwC/g+t/R34ePAE=;
        b=QC9A1f5VnrFOPDmwmSeLsiRt25TYGzTHqIMowbijHnyiJNXRJDqc6tPoTYqF+hSWI6
         pFiZnG8ANNALRbXQ9HikCmDnBMWJYG9VBLqS72dPf7VnvICUcK9mE0xEXFuv6+TYBA2y
         I3d8mxldRlXralbTtERMfd6MzcTaU/nMWOwdKV7GXYs78Q3RIu8oo4YZwNg4lmW21LeJ
         D0FoahYWCZBAI5L7DhyXOvUfYN11lUcBAaSkKHBxqnZnlB1VqCzdpesQVbYVtPNtdoJl
         3xA7UX49Rx1F/X7bNmGjx9nFQegcbxlDwmurVNxseaYmZ/JVEyaOAeY28sK++3sJc63n
         ApVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771222057; x=1771826857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnKyXRtTSpcQXecEX2tXqGAjED7Y5hSLnYN4YSmgW8c=;
        b=W26yh728QsuTGAEH7JwX8Z6J+maIpSo4DMZjjYK/LINg96mhc1zqXCPmdOkmV3q4fu
         fEBk2VAJCcduSHtt3h9cLDqfMw0Ja5ldgTFRgEogQfv+kvqnAgM6suEILZpLdc3lLDYy
         tlCHqixh8cQvUtDf3YU3gGRp1UyNm3JVNSYMt0qAxIhRUaZyf0dn5ciwg8TvKRUPscZ0
         xYtap/CvjupS98h5ipqHnQHxkcfHMZYX4KJRLutEV57rLprQ5hXYO5UKNF8SQgudZtbm
         Tcv9pocaAzsbUrItFeyjy2pxwA40d5tZiolhB/0yMUKYWACgRhDNg4K0DQii2kdYnsRZ
         JGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771222057; x=1771826857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnKyXRtTSpcQXecEX2tXqGAjED7Y5hSLnYN4YSmgW8c=;
        b=aHzMekTn3tAxV/fIErk0JxYzf41DoEWO7OSb3h6Bry3xGdLXvrlRc8fecObAE6IvCr
         b7V8frjQS8AfBGhLArJzwJIAap0YuDScruxdEnfrA4DnYiHcLkvlB4DfMdzPcEs9P4e/
         TGIubpHI+LLjr0Ir7/VZURzhKGl2GwkfWwUgb1Ff6ShZbO0Pr3/TpCBrsXdMLP58/nd+
         xjj+WP0DD048Pj945K151pNf/RocfagTQGzBMdldBO1m8mc+26LYZNkYn11imtoN1J5Q
         uON6KIheDjmNuiy9buyyiQaXcfseaXYTrB6uk8vgS5BOfNBeTsp5Kph9+a17iG0XfkHA
         SniQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBfW/z/yrJxZUffr1wWZxbLaJpXPirT1/D9j++D8l0Ra18gcSrp2WhrY96VN/aoLXNyBLk7EAc7po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2ugQDGzCQcqBaErPMVFhV93yQ+YWYVHQbwz7NAFm7Eb+s6M4
	RhDS5NqUtsNszdEprWgK23bE4dfPNUJExOT0mjRaM/4xPwgw+hq2sEiktWeuSLyDKC+J6ktDI5M
	GQLPFadqN4zAvzjhSyTWVZt+keW0EtYc=
X-Gm-Gg: AZuq6aIKmkzKPDZa0JLNudXwyciZxtHTnfHPvTtdtT/2Nr3KOFJAY9E0qd+txBkDOgw
	q+yLn9lvSjyhZJIInbfC4yo2DE4WoQSj7cyElGr8iIcIYZSZ7Y0hmglQ3/A+1M1j0gJCKoBXR9+
	gWZjh2nT3791u5g7TVQCpPMslN8UYoHzMVCBVo6EZEW0dWTXPH4LhM+qjapl2kO9HiAYY3AjSa3
	D1DB8S1Uu0mDvkU1j6hOCkGGZZTzBx943u0gIpM8elcPBJBwyNhiQUOof8gR4Cut4PtIuoHrrXI
	mLxO2Es=
X-Received: by 2002:a05:7022:4a1:b0:123:330b:3a0 with SMTP id
 a92af1059eb24-12741b70060mr2377623c88.14.1771222056878; Sun, 15 Feb 2026
 22:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212124609.24745-1-antoniu.miclaus@analog.com> <20260212124609.24745-3-antoniu.miclaus@analog.com>
In-Reply-To: <20260212124609.24745-3-antoniu.miclaus@analog.com>
From: =?UTF-8?Q?Tomasz_Duszy=C5=84ski?= <tduszyns@gmail.com>
Date: Mon, 16 Feb 2026 07:07:24 +0100
X-Gm-Features: AaiRm53GhLbCTD7GdFqFzd_WZL7ADpAG5f1-yATU75X30OPM34wOzS_UqlWncLM
Message-ID: <CAObtm8zKUAWNS23nRMhc9ZR-zn7xeVOFPiV4ai_x7Bkd5puiyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: chemical: sps30_serial: fix buffer size in sps30_serial_read_meas()
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 1:46=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> sizeof(num) evaluates to sizeof(size_t) which is 8 bytes on 64-bit,
> but the buffer elements are only 4 bytes. The same function already
> uses sizeof(*meas) on line 312, making the mismatch evident. Use
> sizeof(*meas) consistently.
>
> Fixes: b2e171f5a5c6 ("iio: sps30: add support for serial interface")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/chemical/sps30_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/s=
ps30_serial.c
> index 008bc88590f3..a5e6bc08d5fd 100644
> --- a/drivers/iio/chemical/sps30_serial.c
> +++ b/drivers/iio/chemical/sps30_serial.c
> @@ -303,7 +303,7 @@ static int sps30_serial_read_meas(struct sps30_state =
*state, __be32 *meas, size_
>         if (msleep_interruptible(1000))
>                 return -EINTR;
>
> -       ret =3D sps30_serial_command(state, SPS30_SERIAL_READ_MEAS, NULL,=
 0, meas, num * sizeof(num));
> +       ret =3D sps30_serial_command(state, SPS30_SERIAL_READ_MEAS, NULL,=
 0, meas, num * sizeof(*meas));
>         if (ret < 0)
>                 return ret;
>         /* if measurements aren't ready sensor returns empty frame */
> --
> 2.43.0
>

Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
