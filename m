Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503844;
	b=SanQYKJWGZ+b/Z8/JGmEWLE8/7awnizVShzrhe0cr9EPlZx8/xwrBKeyaPkAR4ZlSN+D
	 QXwrn2c3H+4faQXdl8Rb9kUnUJAsNTD2AJR/ox7JXbhFi2xGzbj2DRoBobdR9JU69l22k
	 q/GL/u40hsudRJgc2OxGt8aOoOGOXEFTyXhFLNfiZjqgzdo9vXwpTR/ldA3XnDneSTHl6
	 8prcQCUXY9kGv8A2zQTT/Z+RU84yGl/GOGHDMMN5Zt9sevAcsyVXTwC2CZaOBSXEL7cHd
	 1y6sMicUST5JS9sDf2RhOReley3se8p7o9+DAHKQUOsQ/r9O70y8au0hSAufYyMZtyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=u9CfLSB0A/imouTNwCscyC2a5gvZbUF9dxOANpM616M=;
	b=KXqGLLTY4HXJzFldfr3HUWH30u5KYw/jSFmsmCv+qQ3PqBzQ33Ait/JndCJLW74ObhzD
	 KvLY/Mk8kf2MUreOjjKgt/3i2pn29EdXHLKXH1RyMUEBE8vaP3d83aMc6kyCxEpfv/z8Y
	 uzqvENN/g7YoQvivc97NmXLnqyVaXlWQOmtXF18CfmF2KjZGpwBNjyHSNhgFrZPtsU1ng
	 k0jFPXQPGH/OvIw27CsDCTb6EuMNCnWxzHFTRTFLVM4v8akB0qoi1NyVjzZzFFTnQ7P5s
	 IeGLDV4JGZyI5xVtys/psROlhvhn8atdKu2BkLRijH382gf1heVdxtAuuWdZGUntk9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TSd5EhdS;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E0606A321
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 07:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82E0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TSd5EhdS
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso38028025e9.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 23:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795503842; x=1796108642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9CfLSB0A/imouTNwCscyC2a5gvZbUF9dxOANpM616M=;
        b=TSd5EhdS5HWoldS72aSwl8raqNrMw4qaQGCtOIDFAWntsggjKhZVLj6dUDuxMfbVby
         R/rpzCXcvYfpE6AVYL3PB0ZuZHCzrP1UZuiJ/PrDKTGxgeEgfX0drypqw9APEzT317Zp
         4Pzd4g2Cso40ADMvMC7bNNP69wmAcUoETtmRG9r+sxd3cYFCIC4pMq5X4vBHE8PtOALf
         qPLTZ92Z9GZiNTr8MAMYdzf0rD3fydxsUFvqpNdPhPBKVp29fVfpF528SSZcNEHYvLfm
         U59qxqYdZFmy4UxZQDtm+P/g3ejj4LKAnH5R7dc+Wy+k76UCbfCPYL0inPdIamT/qmya
         Qbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503842; x=1796108642;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9CfLSB0A/imouTNwCscyC2a5gvZbUF9dxOANpM616M=;
        b=caS/ILK7lMlc6SySn7nIHvXvILFhbZYStqh+uvgaAL3XzdyeGWZcOGvHcKx1oheLMU
         MIZ94l71raXj5GJVMMDhIyB6H20BkuyiVD439SbHoTdFASAldTyFdhPfUbKCm3vS/bgy
         Ad0hkKeLRe6FCzGZAnbu+zBjFlXUP7mOt8mEG76mjEjITYZBMt170H2Pg+DHVwngTOLT
         RBuJ0H7O7BRk2HL0NI4EEjfP0Gt7ERcVDZIo0cWFL2ykywgxqgK9CRPbRNwmRTPRkJWl
         4ga6MDPv0lTW9PsIuck5t0xMprdSRZTn/4f5+vDIfndGMQm6r8xbq7CDTMwu/KRX8HJt
         80VA==
X-Forwarded-Encrypted: i=1; AL+hErHbN4DPfr1QadyHQiU9zhMME+ZgCc4ATxPZhGO/wNvLnBHBc6sIUS07J4d2EZdNZDgOIXTbJt/M4fc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+yFgdhvPNMsbfOHDEU1vSxbBhh5KrOr0TYLvXLWlktxHz4dHj
	gHHQH7vYG1/NHTTy8lLjfhFK/cjwRiWSRzRhPCzI87YwLLWmNTv6bwGke8c2ASDUUog=
X-Gm-Gg: AZFdTZdQqA5HJvXnHEipzQKS+U+sc1JQRuaXbteGwmKry+L5d97Ib4y+Aev8KpVd3Ot
	OESuzccbbscCs0Ijzpc4+JfHBQM9Xc03i9F8pqA7yLmWbRyIvjZrNI4x1MwtBDHj+hjNxwNKn3I
	CSqYh2d7GQjxsEoAVMMx2xPtCHbggpfzjz9Ge+cP/K00/GDDQ1ZoJWHFhnDN9HSKchQS6nGpWQ2
	DiBunVKjpbsFIUYEY4QE7CjbLAEW9PV2jOQv+gLRSMTfn94OlNOypyyKdE5O1tGUvMbzPsBTEHi
	zI+CZAAqeHTTW7eB8fGf2x1eLPOjN/78VCzF/jfXfJwJcXPy5R7nzCfbZBKfwgVdhrfHImearo7
	NtPvvdonCHHwX2oGPb08Sqx0Jt/FpWC/xFAeD/dPcs46JtN4aYP9KAS1Ikg27xruz2AWAsT+oxr
	pTYhZxEE/FuG+j4dgjmYlTApSzM9/DJSLRqTvs4IdezrKqU6TzywQcB5SCrZr7Pnc7E1Hr2CEoB
	ccElwwOPvXrsvN70hvCQhT4p+UDKnWterY/9tYeSQGouYg4E5ybrskoV9gn5uncpJ/vTkiNmH9i
	6q5FBW74XJ+dGDmt1/BkFK2+RV+UqeaPIw==
X-Received: by 2002:a05:600c:8b5c:b0:4bb:741d:ea0 with SMTP id 5b1f17b1804b1-4bb8880f621mr286056745e9.17.1795503841981;
        Mon, 23 Nov 2026 23:04:01 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884911e3sm490535995e9.6.2026.11.23.23.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:04:01 -0800 (PST)
Date: Tue, 24 Nov 2026 08:03:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: pressure: dps310: include what the driver uses
Message-ID: <awU0bh5ChdbAsArK@monoceros>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-8-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fszsr5ckxyppdn25"
Content-Disposition: inline
In-Reply-To: <20261123220649.36887-8-zoone.rupert@gmail.com>


--fszsr5ckxyppdn25
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/7] iio: pressure: dps310: include what the driver uses
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 12:06:49AM +0200, Rupesh Majhi wrote:
> Include the headers for what the driver uses directly and drop
> linux/iio/sysfs.h, which it does not use.
>=20
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
>  drivers/iio/pressure/dps310.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 7581ea4c99ba..fd17fa38e9fc 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -18,28 +18,40 @@
>   *   c0 * 0.5 + c1 * T_raw / kT =B0C
>   */
> =20
> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/cleanup.h>
> +#include <linux/container_of.h>
>  #include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device/devres.h>
>  #include <linux/devm-helpers.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/jiffies.h>
>  #include <linux/limits.h>
> +#include <linux/log2.h>
>  #include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>

don't add <linux/mod_devicetable.h>. I don't know what made you think
this is needed, but it is not. i2c_device_id is already provided by
<linux/i2c.h> without the overhead (and useless dependencies).

Best regards
Uwe

--fszsr5ckxyppdn25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsFNtwACgkQj4D7WH0S
/k48zggAl4Iig3L62WdS6ePjBytal8tQRFPGsxyBA1NXxl2jcHEwwl14ShW1cBmP
P+sG7lpdy/pLgyQH+GduRAlUtQugN+nE5imRC0GBeBHUUhI1f+2fk9MEKSkTGdM+
jYrfBEQNUYreumF7jFT/3xtzexQYQs3JrKBxQazIqC3iPg6baCXjCjQxn97bNYxz
lGFVy1AmRyu1ZvcDzWUciIpN3RzavRG8OulTFsnLeYUppq+mgBUx0mTSPvx+Mx1S
l+b5LBbZjAih5nvEIxl+l2NPhqTwp8l+qLgdZlJ69ZaIFQicBXwYedGvwuVtf1LK
MFYVpywwKtcVCMTqx6RmKhDGWJMPvg==
=cIBF
-----END PGP SIGNATURE-----

--fszsr5ckxyppdn25--
