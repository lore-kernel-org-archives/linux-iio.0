Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E1348C4E
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414136; cv=none; b=VYJq1yyuKCHz0+xwl5PPk8OFxrBOwrtdegPf3OflNZeJ5Tj7fhmwe1rwMUMtV+yHHWwP4nAuga0czs3dntDFPreKkZT9h6N8G4vI27leq0efo3Tl5G2loOREAbLpDIh3psrDJzaNfzXYG9s3kMUeDz7NFPR43al8TC/4mpi5OWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414136; c=relaxed/simple;
	bh=ZnQilIaD79Onwbpdt4qaqS+3l12GDRzxu1mzuEFLoBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJKsVZSTtvXVTE1exdgkWiVcvicAB/XQUHOQVNurXSAp+btkv+dcuB0EKJpL/V0SoofEzm0k9msyhA0rdslAeJzd4gXBt2gkwd154IpVbXrz85a6ZfKZqqXZfCz4WsYK2T1bk8tYf14kW4a1HVmhmB/I5o1oXQDRvRyL6AGSrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Yjzr90Gb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Yjzr90Gb"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-475881b9a4bso3381868f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783414133; x=1784018933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZnQilIaD79Onwbpdt4qaqS+3l12GDRzxu1mzuEFLoBk=;
        b=Yjzr90GbzxrPyuNaXh+j2YwI5Un0YT9v2orcwGo4aDLAniuQBzp0zETKg05ygk2CHk
         xA2rdDiG8+mMZfQeSTpG4wU/3/GvMJdppb4p6teJY5XUfPAu0H8HFPSVx8rai4/6f6yn
         yDtMvlYL9v7Ko71mL8eHdDeMKLuWBmE0OkRbsXidVfc4PZ8KH9PCXytMS6v/HR5I+xfX
         BiJMEbuVDlHNhEVH2uUn9BgOj0uoH8tT0740AziAmXcENu1TmLmygXS5bSWNX7e3IBiO
         NB8GLjBDSpP+fluwnovV99HexIKCqyqNvPCDJvXO6MvxltscJU4IZl6SytYKD5sgPFFg
         nbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783414133; x=1784018933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZnQilIaD79Onwbpdt4qaqS+3l12GDRzxu1mzuEFLoBk=;
        b=NtchzTw+IIzOpGHxGsA3nCDi1SzioiThHOGek3vLDpcu44ng3SFg5xL7z2s2ud3Ndv
         XCpWa5Gb5J0sKj91Q/ynEL4Gxyo8aX2FGXFj0xQE8w+JYFP/uJtdfIJun3CDG+QmUT6E
         0C5hWMUxmxAH3GbkaD3yEU60joTYR1ROc64oh/vhbLrNcSIZDTcXPTLiAO+DpMu3reSa
         yA1C/92IbeuVCxeNr7D5y0vRKLrqHIcrkVoyZC3mYPWp6I6kcfjL50DcZgo4me5xVjPb
         EmGeMsWvIH9va/ctUrDiS8zW3D/qmZ8H+/GAxmwCcXxGVXC6l7dCP4aIrq/+TnMIEyok
         HEng==
X-Forwarded-Encrypted: i=1; AHgh+RohI7wvagqB4hxlB1W2eeyDo7FoVe7FW5/cSqXaPzUQWUjaAd5fnl6jbAQ/Gz25Std6aRbItS2bq2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDOP3+pmTAwjRX4kvPBiRnm9JusGQaPbPQbSExYRw0XB4Hwvmd
	/p8LAvs5hfdoVus+VWDkG9RMRCuFCkmlihi3qwEoHxuxcj708+Xyrff2UTRLV35GfpY=
X-Gm-Gg: AfdE7clRXejrqRGUBDguNsb308hRpZM3h5J83t/Wj7CCiX4Er8Agr1mrCr5gDQzQYcB
	o0CMk6HtKbYegeimmXyzk59RQHoQzbR1LIxRdx7RiOvXsSGZLJnrgDFOjOVCoQzQOEKQ7U7hhGC
	gUml5QtjvwlGRqrHEtpssRQ7y2X/8PQ21lBfKYQQMyq6D9VuOqse4Eh7obPNOrh9Umc3+ebjJ3u
	3yEW3Zirpil1NlNhacwFojn4w4sZs9Bl1QbtUi1Ysl+gp5lsponDwkN3MyYn4CCRhqNG0fXVVWt
	E+a2+w+OMGnSmcrtPCEHUV12XdibBzl+BMEsxHo5X5Mr17m4vFRaukiol24z4VD40oq3VgZtwKg
	1mwWs04I3JrNopDBfQgqYTEiZR2/803ICNNOphOlx3NFa6urFmqpEY9yE3St22+iWAMEAjzxCUC
	NHuLZ8XkaRW+f3Jc3FSoSPahbymnXcs7QNCWCH/JNTZUAr+o1qUw4ymSXQTP+JuCQtrfiuyPDAA
	Dti
X-Received: by 2002:a05:6000:2407:b0:473:1ccc:15cc with SMTP id ffacd0b85a97d-47de664a423mr4602888f8f.0.1783414132916;
        Tue, 07 Jul 2026 01:48:52 -0700 (PDT)
Received: from localhost (p200300f65f47db0437b4d928ee3eb6f8.dip0.t-ipconnect.de. [2003:f6:5f47:db04:37b4:d928:ee3e:b6f8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9de1d910sm31134462f8f.6.2026.07.07.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 01:48:52 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:48:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: osf: add UART IIO driver
Message-ID: <aky9ZMNbsvMOzRBb@monoceros>
References: <20260707014525.1015-1-kimjinseob88@gmail.com>
 <20260707014525.1015-6-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cc6pi6fldaghp7ck"
Content-Disposition: inline
In-Reply-To: <20260707014525.1015-6-kimjinseob88@gmail.com>


--cc6pi6fldaghp7ck
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 5/5] iio: osf: add UART IIO driver
MIME-Version: 1.0

Hello,

On Tue, Jul 07, 2026 at 10:45:25AM +0900, Jinseob Kim wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe


--cc6pi6fldaghp7ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpMvXAACgkQj4D7WH0S
/k6kYwf/QrsvVB+FpqOTdJQKQDyBUgE8X47AQ2lzuY6x2BS7Ix+fTBZoIZP2vHOw
VQsrn6N7UpvUQPxL+wvolGEcWyw4N6ADBNzMfMohNfJEiHRbLUC2O2GpHzQ3mQuK
YbplvW7QAx3edKqE8sTV3GzCxmlLyXoxyXyIBoWvxpQsKg/hqy8Vy98P9Zl61ZKR
bnRIi1XyBNsIn0f/ZVYDB/nntHLtinS4OhNe0PMiK4vRY7OGyJE/REkLHRITQUml
/rCrt2WKiocboCDZq2Ca0fZtMlQwJWAhNwtElfaFRW0tyTfOSswQ6Xu6VPq7faXo
k0WNen8fn54frelJ7YLGLK+JRBKecw==
=viEt
-----END PGP SIGNATURE-----

--cc6pi6fldaghp7ck--
