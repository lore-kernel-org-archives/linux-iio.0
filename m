Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8B3655E8
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325953; cv=none; b=R2hUmaheYxPBOB78AI2r62liValXvNTizJOxHWvvfOmvdYfrfnHuN4ybGBSnx2ow8nQtP9VLKew0UVfV1DLweC9mk+lBuCxDcOY9WdeUAnBhO/LSgyxRQjnAD5s93aoQNFguRloASpmcKlUgKoIDKxp1lO0z5AokEW1+cdiNyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325953; c=relaxed/simple;
	bh=lcp/CBy4kZgBjlr5Z0knFSJ6FF9nOYjdrFkpxNP8EHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 In-Reply-To:References; b=go3HB5600CjKd2sDDABBhvt2KA6xKR2Vqh2ZNPRfHudYy8+QoUoHOx5R4rI4GXwy2fwZmaK0IsM+9lYJ11NyUJ7kxh30GWLFJlFvDhM7XuIs5okZ6qAW57FV0j/3MHNarirPa0CCP5XQn/T9VBLR1LMlgDW45/AYbrlUQdpXu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=oCDmM/ng; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=C5h9tNwe; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="oCDmM/ng";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="C5h9tNwe"
DKIM-Signature: a=rsa-sha256; b=oCDmM/ngQUreT/wHC562dmn3H2BJi+NqHPu5BhOcSkNlVFzxntQUEFRmYLUFVyKMimQBfhYso9w/eaEBz6Cygv+F0sw7JT6eSOcmH1ZTGT1tPvuHNLsW6h3FwVfGFF8EhTJ6lBn0Udh36ynUIPyVp5jhZr/uXy2REy7nLaYLRY1nBOYG4xhOLwnlSjlH5UvorYcV6mI/ryH5m94iSSxr7cR7wBFytHjFCpuii///L4ecZiQLAPLlvCgpIsGyYazDPAKRHBY3bJGm8Ia9rjulUveHPom9IsYRTAD0jy1mEjUFIxG+eqBY2sE4FHeECZepOsUdCtCI774L3MFf2E5QGA==; s=purelymail2; d=maxwelld.cc; v=1; bh=lcp/CBy4kZgBjlr5Z0knFSJ6FF9nOYjdrFkpxNP8EHs=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=C5h9tNweHVE5HFWFLkUvVtuzMJSzqt8KaSBkMRaogpobppg/yuJxhAYiC/PM9wBVQyuOZ/U14kAeccxreQ95AMgcCPjuzwXHoPmaiXmMd+QZpBkyJjcMaWX8NjBVyo9LmsHWLLgql1wvTYI/wzOIFgk2Mjkgdxly+T6JEeEVMKE8LGUVzxH6Tylmd2wIfAFhiCCPADyjkJhKrEy6zYUvgdd11HnCll4m4DdyLe5QWKLGCjVF8MtVvQZdYmY6lEuxqq7ud06hzFT+8Kt4IrtOqbRVU0lY6+QNuFz4Pm6TrYpEa05SfHoazEJPoqjeUcjWbgU1+fhsCaAMj/JI0uxChA==; s=purelymail2; d=purelymail.com; v=1; bh=lcp/CBy4kZgBjlr5Z0knFSJ6FF9nOYjdrFkpxNP8EHs=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1903436675;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 17 Jul 2026 22:05:26 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=19ca535ba7206f74e2c734404e7325eaf8c51c8c9a932c22068d2f31db9b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 Jul 2026 17:05:22 -0500
Message-Id: <DK16R0RUSGG9.2LHH6CNKD0IAV@maxwelld.cc>
Subject: Re: [PATCH 03/13] iio: chemical: Remove redundant
 dev_err()/dev_err_probe()
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Pan Chuang" <panchuang@vivo.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Gustavo Silva" <gustavograzs@gmail.com>, "Maxwell
 Doose" <m32285159@gmail.com>, "Tomasz Duszynski" <tduszyns@gmail.com>,
 "Matti Vaittinen" <mazziesaccount@gmail.com>, "Siratul Islam"
 <email@sirat.me>,
 =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260717094408.509583-4-panchuang@vivo.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717094408.509583-1-panchuang@vivo.com>
 <20260717094408.509583-4-panchuang@vivo.com>

--19ca535ba7206f74e2c734404e7325eaf8c51c8c9a932c22068d2f31db9b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Pan,

On Fri Jul 17, 2026 at 4:42 AM CDT
Pan Chuang <panchuang@vivo.com> wrote:

> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"),
> devm_request_irq() and devm_request_threaded_irq() automatically log
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() and dev_err_probe() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/iio/chemical/ccs811.c      | 4 +---
>  drivers/iio/chemical/ens160_core.c | 2 +-
>  drivers/iio/chemical/scd30_core.c  | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
...
>
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd=
30_core.c
> index f85cdd8bd84f..770571c21521 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -686,7 +686,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_=
dev)
>  					IRQF_NO_AUTOEN,
>  					indio_dev->name, indio_dev);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "failed to request irq\n");
> +		return ret;
> =20
>  	return 0;
>  }

Please split per driver and resubmit and feel free to add

Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

once you do that.

--=20
best regards,
max

--19ca535ba7206f74e2c734404e7325eaf8c51c8c9a932c22068d2f31db9b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCalqnIwAKCRAQghIb0dl/
id6VAX9RgcpaqiH1YnuvLPnG0kxhe8ChFjaLZwnv2IEv1MHJeU8PZwkjLvZzKi95
EteGZSEBgNNa+el3N6kQyA3nC9IdEKQ6BOk8PL32fxk2N16pzAwC2vYe/YS9yXJi
bRUcshnAqQ==
=epud
-----END PGP SIGNATURE-----

--19ca535ba7206f74e2c734404e7325eaf8c51c8c9a932c22068d2f31db9b--
