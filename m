Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676756;
	b=DvWGwHtei8JDKXj3dKfEX8niyvf4mSGn7fyqSHsgBe0ZqEHuo4kdfdwVJoLN5tDuXmK7
	 S4P2muT4Aa8Q8pOVGu/i2/BN7jJYNmc4BZdl2iJ541lmkHFC1C3b+6CFNXGD/2TcW/LOX
	 aqMsshriw/7MC87Me5rmJPqUiu6/QIeuDfb+PvXleHc22sTAxJ7Dj4LdbisHH+5k849L/
	 NJPFzgRcugMxLcrjvPC0nHNcv8pEBto5fhMKPRe17gsyJaYtwA9xuNPiiBb6Pi5CFyvaM
	 4gtm+8fbrX+3GKSuMfoVWy9kiYVLVvVTwomb5p5QicHmfaqpg3HOShVWpM293GZNrPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=YTwcRMSWQ/WwFbflIYFwTeimqUcsUNTJOHfLHF8Dqo0=;
	b=MjiMqLvU66bN5RgNNoaNtT+vmlpYAwQYKAWlywFbrKuOqoiaoBEaAhNI5DkI3SeRxC/1
	 zMSkaUpNHApfaifWsNdph6twQ6vQuUFb0gHZM1yOfQUvK0bdYmuqPdcaj+edbmhTsUBTJ
	 gilOm5blMTVNMI1nuBh7pYw2F5y3YcbFjQpLVcXWVlYBvYWtwfEVVR/QPt2DCIbEZpC9y
	 cUOF4dsAR4skZp4pcmqQMUA9ZK++CbkATEYTN/gRZV3k2A1USBEXJPyfyjjphVL5YxhI5
	 lO8UEEXBGiDeMKPGZ/YpzgOY+bDHTNhB0sL4c3n5sD0/7gxCJnr6eqV0Xs6CK9+2aKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHw3eyv7;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ACC606A330
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 17:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22ACC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHw3eyv7
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so12654355e9.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 09:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794676754; x=1795281554; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YTwcRMSWQ/WwFbflIYFwTeimqUcsUNTJOHfLHF8Dqo0=;
        b=vHw3eyv7tVnu7ujo/f014gkgAnXfEOQX+ah3pcWkkUpbq6/tPFuCYxNQdUyvHdFjHq
         2anngKr5UUeaxV7xvlr5ZsZMq6lwaam/S4Bwe7WVITK02XSKNI9U1r14CG3Iojp3n3fL
         1DQY2rBZzTay3cOVSvPXlmNOlufTR6Mc7AuAw8vJEgmJU01qccyWgckLhFY9He1MQxRM
         zdcnv7adqnSQQYqNCWVXdfQPYYCVW1rLdOp61m7NbeiOZPBpyAFu+jRBRNk2Gjx//FB0
         u8hsxePhaRe8UACcS0A6UkPbM/uCRbu8JTOBFmSca6ZflsfRhZTUAblYhES7tIEww7zi
         iuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794676754; x=1795281554;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTwcRMSWQ/WwFbflIYFwTeimqUcsUNTJOHfLHF8Dqo0=;
        b=xRME4n8nf7eCpqodHyCjuAh8NtadvSU5/prRl7/Avjuu3MQX+8MsaAxWvaFc1BdvxT
         SGpMECkM5VPMmqSQIzRnhkJBQc4lHzT2FJE/DQDknH/vZRzDCJjaj9jRn4bfNfSFXX5t
         zO3JP4ECjUuJfnUVCjhPdLHmQA44SFUtiQiyRH1ruUmWkiZjVIoJZmr9nSjOQoS+AiYT
         MVte80bSEIvlAaVXMn5Hw7gYXGiUKOBRJ7rhZ0AdQuk6SJPa4/dPDGJcj4VZmJoXNLg7
         3rQa4CqWNkJJJSOxVlTTnLbdVFHeHhvFAh36T8/jdgLi1cLdJ+2CCh2PMFRZw71QNfyL
         +JNw==
X-Forwarded-Encrypted: i=1; AL+hErEXmqcxETXZvK12DNENKISadW7GqmLUt+vFLLR1WOEGUAULfxqzL9jpErYnNrr0O2MjzmxyDrxd5eA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+BFosDxpcv/BjzS9c8KkMKjbG0U+pbWhsq4xZkSLxmW8p8RPb
	NrA1fZ/veATVMP8pxCwzmtXIDKvSI64KekYRogN1kra0QnGmueC1hdrB
X-Gm-Gg: AYBFou3b6sg6BBpn5cYBtSgC4841NwZ6NSbppaQB2N2vNWZMPLbEl+SJFqWJ67FYVEk
	FCXwZyZyqFg1DuhnFfCfU76sC16t7O7i+41AnrSI1/vE4B/qkd9XJRoiZl70e+lkWstQhWGr0ZC
	e/O8zM4DiKOnrKzGWViININeSX4fZUbUUVIssf+05it9TXwbn1fZ7M58IVrr47cDaJKnNijKeaN
	g9jqYNuG1y3bD4D4uYJPV+QALPDtIMtvGuWwD0Jz6mKapbTwdxfymivRU5vUWYJ/dKL2kcvLjPH
	V+0pQoZfzzjcw4S7qAkhcIeibgM9dr8H5LVicngeyqLbaE1LrUHErP8gwTEutFrTbuD7bdOHpqK
	BceFVe3iTWLw1Q9Gb7SQfHuzknGWKt7qd4kyH/ZCfFxreJVMWJV88t5qB6stNoyfW0opOj+ILzG
	OdmqoYo51GxF3QniICNuDSmzRhK/2uvMj2ZKsR4ENl92OY4bKHYSGZe6Y/PFaXil+TTrGPfSVw5
	Dr7Baq3duAE5U3ipbpYw/s4YysD4ycRTcHR2/Zj8XBAQe3+OIgBRhAM/+x7QX3xZNYVvTvtzaiO
	h7S7uEsLc0vRTzefqyux4Kno390cR6gclBsamuesSPN73LUuHU3OBUc4KVEDyyb/WfUc52Dc/Vc
	7JsCA+QKE+Nr+iUqktlEip5LUFYSthLEpdCsM89Aomf6Hs4QDBJFZJLiQA93ptg7H/5D5P7RyWY
	N/chc0hxZvkLY4nJRgJYVmJwfhwrzIi8FeAzHNLIZvkuKKqNHRPIY++l0IXDDFhtyleCaEmDA8+
	vuz9L9OGTHBfXwHB7xqRRTAuQ==
X-Received: by 2002:a05:600c:5395:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4bb55abba24mr132258135e9.30.1794676754290;
        Sat, 14 Nov 2026 09:19:14 -0800 (PST)
Received: from jernej-laptop.localnet ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm20031827f8f.7.2026.11.14.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:19:13 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@lists.linux.dev, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andy@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Michal Piekos <michal.piekos@mmpsystems.pl>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Samuel Holland <samuel@sholland.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Felix Gu <ustc.gu@gmail.com>
Subject:
 Re: [PATCH] iio: adc: sun20i-gpadc: Use
 devm_reset_control_get_exclusive_deasserted() in sun20i_gpadc_probe()
Date: Sat, 14 Nov 2026 18:19:12 +0100
Message-ID: <lGotwwBTRaeZcOCAphaQBQ@gmail.com>
In-Reply-To: <368d548f-2b86-4da5-857a-6ee9473a8d0e@web.de>
References: <368d548f-2b86-4da5-857a-6ee9473a8d0e@web.de>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 14. november 2026 ob 18:08:10 Srednjeevropski standardni =C4=8D=
as je Markus Elfring napisal(a):
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Nov 2026 17:55:16 +0100
>=20
> Use devm_reset_control_get_exclusive_deasserted() to replace the
> explicit reset acquisition, deassertion, and cleanup action registered
> with devm_add_action_or_reset().
> Simplify reset handling and remove the custom reset assertion callback
> while preserving reset assertion during cleanup.
>=20
> The source code was transformed by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/iio/adc/sun20i-gpadc-iio.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-=
gpadc-iio.c
> index baa7661db13b..070d061572c6 100644
> --- a/drivers/iio/adc/sun20i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> @@ -157,13 +157,6 @@ static const struct iio_info sun20i_gpadc_iio_info =
=3D {
>  	.fwnode_xlate =3D sun20i_gpadc_fwnode_xlate,
>  };
> =20
> -static void sun20i_gpadc_reset_assert(void *data)
> -{
> -	struct reset_control *rst =3D data;
> -
> -	reset_control_assert(rst);
> -}
> -
>  static const struct iio_chan_spec sun20i_gpadc_chan_template =3D {
>  	.type =3D IIO_VOLTAGE,
>  	.indexed =3D 1,
> @@ -225,17 +218,10 @@ static int sun20i_gpadc_probe(struct platform_devic=
e *pdev)
>  	if (ret =3D=3D 0)
>  		return dev_err_probe(dev, -ENODEV, "needs at least one clocks\n");
> =20
> -	rst =3D devm_reset_control_get_exclusive(dev, NULL);
> +	rst =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);
>  	if (IS_ERR(rst))
> -		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control\n=
");
> -
> -	ret =3D reset_control_deassert(rst);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to deassert reset\n");
> -
> -	ret =3D devm_add_action_or_reset(dev, sun20i_gpadc_reset_assert, rst);
> -	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(rst),
> +				     "failed to get and deassert reset\n");
> =20
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
>=20




