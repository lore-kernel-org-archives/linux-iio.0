Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01047CC92
	for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327681; cv=none; b=AEMdhk4EuAREqL05wb7+wPf9WTmI7IuL9WOiN81ojzeDYrBdDLi2ww3CikNqV6OFitNtc0Zwfpm4uVGuyNCXiGCH5DkNyXJotF10QGTLzaX+0Xvzy1dXE5VWTtyecbFZ8JPAnspfaQlqCUIKIJNCELSlC3spjUhc20RiBCwWOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327681; c=relaxed/simple;
	bh=L1jAIAcC9fN0StOdLITAj1z+mZWOsBgXDmgFTSgW5fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/4ZRPkmn8gPnGUdGEiW+b13ptC9gXUfFVvK/gcIU3sRbXSkD/J3fFc/3YZPsszpz51lKfs/UuASKYq4MVbJbnV+Ch/FdBzv3MuLAVN6E7qVfILtDdLqmihpPoLeAFSBMcE6CMMOs+LTGAi85c8aGB5+VUIYQ8Qb/DAsKGHbv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=a38Q0/tf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="a38Q0/tf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso6383485e9.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785327678; x=1785932478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1jAIAcC9fN0StOdLITAj1z+mZWOsBgXDmgFTSgW5fg=;
        b=a38Q0/tfGhG7gYERQDI91E/E41qMUhnDaX8/Hcq2qNk8mUEUfg6obMP0WoJ7/xe/i2
         AlsWbkVIt6xiyK32GFH2BNiISjhYiGkGXxxT9jZdR0rHHpxFj0w+vSzCYRM03BAiPECI
         /wJA2e40BoRB6XO2y1wrPnl8zQHMXulJB/CGcAY7Gnw4bGK7c2M9YiBvTqxQqCbrGQRB
         pzq9fXrIb4YUI3DsAgmtJ0B82XG7sjKIN3kozaI135iOTf1zYOcwDGTqbxA86LL8lzX0
         pt2DWQhSccrm7dSiXSPoe6xcZsoDoNqcJPALei3Ptxhy2uFQBMkgUxnzhbQbb/olunvx
         3a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327678; x=1785932478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1jAIAcC9fN0StOdLITAj1z+mZWOsBgXDmgFTSgW5fg=;
        b=PQWXdCyTeo2FTOGtBrpfjnIJASptoLz2yB8kvWwPUtJmH7ttJxU5jvbgDiIsshwlbQ
         veylNiH/n/GQ9kE+/m69ZsX2Q9ozLVG5vqp3QXpB0pNhmclCPKSrdc6GdCeL7ROO3a+Z
         j4Xo7N4yXSGtBLPgtbVy+cfyMkJN2lph1MmKGSCDHNgMOeCTBFMDglqwoIJBPuxe0YDf
         ZDHEfaYTo1tMeUat22d89/GHiRgshsPrD8Tq+4U1Oam4netWtkNrVyASOSom4RbRjpjz
         XKU1KLK0wrbOa6QJiaDLZylzgn1izEYKamv+MSZJFlms0yijs2NLbyjEQnE1My0BairA
         tLhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpc8NPKCF9hc5l9+0hfv8Sne8boAzv7GaKOVvblAlk5r6XSD78dWo0+IF1GZstMxJx6It3aeDdHEYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwBafxTbIHRMtam4aveUiRDPTdDbmOtB3pOoQUAUyj/OBwhm7
	ZJ9rsZvzhOjokVrW20NbzQ3PiNrP1vIFtT1gybrw+xtSZrYvSiV3mRFzp/DI/09v5Vk=
X-Gm-Gg: AR+sD108K7XDKDBTs6qy+xKY3G0VKs80W6knbAJroJwqNmNVKlPthc/e6OEJ0Z8UEvI
	MQ/quglzbVOHjsTRtSJVhjQNcvftp+u337U0LOgmibnR0Irjh33xY3fAgOUxYQbkJhKhsaSeUE3
	sd1owYTsM3ECGce4ClXL/2xJ0pmN0v9CqIgobVF2jevil+OIjqECvqRig26NgsAADblBgwVDmuU
	wN9oGZZi/TsXkF4fYE2/y7BYwbYapNGhkNhVnpICSViddEQntX68CCDnyxjygMpfaKpVglnXM6d
	ci82uCJTPmYDQ6bD91hq/gUICcwEVz0Ak7L4dOjmZ46kRS2OgTGYMd+F2i5j6zxm7eX0GE6k3Pr
	81JGm/u/cJ9mQeAMpp2oJiXloOhnM0lgWenPr1YZ8XnwnhugIC4r13fqPjDeZ0nF1+eiGfUkr8c
	kCkCkhkI/qWr453Bpd3zNihzs97UdSMCBEr+iopgf/wpLB+opXDtiFhe7j/ddCJJUES442p5caI
	RFhHdmHBoG617YLHGwhnHYroJvF385iTBOmw0fc6kLQrG9CbFU=
X-Received: by 2002:a05:600c:3f0b:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-496c654c9a9mr69940735e9.10.1785327677575;
        Wed, 29 Jul 2026 05:21:17 -0700 (PDT)
Received: from localhost (p200300f65f47db0401da7fd03a16a046.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1da:7fd0:3a16:a046])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49764d6d0f8sm49668705e9.2.2026.07.29.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:21:16 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:21:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: jonathan.cameron@oss.qualcomm.com, krzk+dt@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	maxwell@maxwelld.cc, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com, 455.rodrigo.alencar@gmail.com
Subject: Re: [PATCH v6 4/4] iio: flow: add Sensirion SLF3S liquid flow sensor
 driver
Message-ID: <amnvxnjaDZRrLEte@monoceros>
References: <20260728214943.29820-1-wafgo01@gmail.com>
 <20260728214943.29820-5-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npu7jwznn6fbd4s4"
Content-Disposition: inline
In-Reply-To: <20260728214943.29820-5-wafgo01@gmail.com>


--npu7jwznn6fbd4s4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 4/4] iio: flow: add Sensirion SLF3S liquid flow sensor
 driver
MIME-Version: 1.0

Hello,

On Tue, Jul 28, 2026 at 11:49:43PM +0200, Wadim Mueller wrote:
> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

<linux/i2c.h> already makes sure that of_device_id and i2c_device_id
are available and <linux/mod_devicetable.h> will go away soon.

So please drop the latter #include.

Best regards
Uwe

--npu7jwznn6fbd4s4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpp8DgACgkQj4D7WH0S
/k7vPwf8CZ5HT3Hoc5TbA8Mdmti0FZeaIu/dm6mbU/RU+RejclwSiIoTFPcIqxwl
pRJxIZRPXjP8rMePZl4jzWoBj8e8ngRj8kC6QGaaPTJTVvdMxIwYhTaZqrLYLrMx
xN5e8Yr/AuXIi2Uv/EcynAiUBCr9I7+yFzyXfPghon5QWd2QwqPdjTtJDOOtBg2s
XSO7c5AuzMWUIKG0YCX89H6gEqTogbPb5db62Uu0IsG4odN8cb/muMK1EXIlzh1Q
B7VLNZvLrNT+cAm5lEg96cBKDzJWVCiHgz46Dgm02QVzZIqLu5niWJhL4NncRU6Z
rMAM/O/UGmIfAed7zexAU3h0yCHUJA==
=44Nn
-----END PGP SIGNATURE-----

--npu7jwznn6fbd4s4--
