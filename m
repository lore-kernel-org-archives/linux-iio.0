Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850052;
	b=TcHUuM7XKYevH0ahmkZB7teGa1ZyPdhLRsxGsTrSMI9JLPQ1vhcqDGNeWQi1YjfFQtAu
	 KBlAO6pAIBUgbz+5MxVgQGBYa7QcQsJsQwjMqwHdbWYzr4l6QPcHNePJUi1dOAoJEhryR
	 GsvUKgT+nkrhzLTJHuo4EL1aEPCPN77bz5Z6q5QM0+PfAP+WX8mQn01RDJ3x92KqcaSnt
	 SxEbaEAejpKFUjAS+93/49GPXN/QQf86CMrnr+vqWUB25DCAvZ/BwqfsSHz1lXjNrJJQk
	 1AageAS4VTRmunx1TaymCrj2HuxVEcS9xQb9HArFUKWoJQf4KG64CgWnyGN0fxk/icw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850052;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hc1gc7HOIqIM+JBzSQHINvh1wfRLFiIM2EAGfL43Ihw=;
	b=jsWc9tQcmX1GAdlP4gbXC+x68/VHxcQrHWQjfAMulywsQI6tZgAO3GVC9aRmBPYaJya2
	 cKWIT05oEFPa0MIaI4s1flepoPh1fikIw3+kJJKZN6bHSzcpqOEV+APaZdZVuFTqLyd16
	 aqZD7BRbPQ4YAypie05QNGgN1NHj9kqtVtmjGVpzjxhlxgxCXdizCXkL03H0hPEmTFPic
	 0mHP2XgAKhVtq3l5vcSLIKjF0hxvMdQPIXotZumyHf0/TZ22UU0SBqPIzZX4Zwc0qaDRY
	 /Bh7xeUSl/6n4RXyi7mfXVp6OsmbnuRLZY05McZgsDJ1zJgsYTxwsHAL0Cpk2l49j0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iIoOMPqW;
	arc=none smtp.remote-ip=91.218.175.5
Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A278606A32C
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 17:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A278606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iIoOMPqW
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OmufBn96Dn9LWg6ZXLW+oHRP5eoxknXfkSDt0Qar1Ws=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794850049; v=1; x=1795454849;
 b=iIoOMPqWnVCLHKdGoh45uSnVCDqiqw/Rez5tcaUe+nNkyoWeA4FRDWK7pG2fvzZnv25rlG2E
 s09UIVdN5fLphDKhZyoxNrr2AMUgEGsflomA6ljdH8dnB+ryd3IEL/6/p9Gqz7VtxgutdffeAd4
 EDRz8rZ5HTfWT60eOSVmIzso=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4af74e0f8b6e9662;
	Mon, 16 Nov 2026 17:27:29 +0000
X-Mizu-Trace-ID: 4af74e0f8b6e9662
X-Migadu-Flow: FLOW_OUT
Date: Mon, 16 Nov 2026 19:27:26 +0200
From: Petre Rodan <petre.rodan@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 13/35] iio: accel: bma220: use default_trigger
Message-ID: <avs8_igmLZIDOrSB@sunspire.home.arpa>
References: <20261116014823.3132576-1-jic23@kernel.org>
 <20261116014823.3132576-14-jic23@kernel.org>
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
	protocol="application/pgp-signature"; boundary="MIKLrGqWG9rPqcvA"
Content-Disposition: inline
In-Reply-To: <20261116014823.3132576-14-jic23@kernel.org>


--MIKLrGqWG9rPqcvA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Jonathan,

On Mon, Nov 16, 2026 at 01:48:01AM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>=20
> Set indio_dev->default_trigger rather than taking a reference to the
> trigger in probe(). The IIO core now takes the reference during
> iio_device_register(), so it is not leaked if probe() fails after
> the trigger is set up.  Whilst this patch closes the specific
> bug, it also makes the ordering less fragile going forwards.
>=20
> Fixes: b7e17ca10793 ("iio: accel: bma220: add interrupt trigger")
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>  drivers/iio/accel/bma220_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_c=
ore.c
> index b83abfdd84fd..23eff578158c 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -539,7 +539,7 @@ int bma220_common_probe(struct device *dev, struct re=
gmap *regmap, int irq)
>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					     "iio trigger register fail\n");
> -		indio_dev->trig =3D iio_trigger_get(data->trig);
> +		indio_dev->default_trigger =3D data->trig;
>  		ret =3D devm_request_threaded_irq(dev, irq, NULL,
>  						&bma220_irq_handler, IRQF_ONESHOT,
>  						indio_dev->name, indio_dev);
> --=20
> 2.56.1
>=20

passes all my unit tests on both i2c and spi sensors, thanks for the patch.

Tested-by: Petre Rodan <petre.rodan@subdimension.ro>

best regards,
peter

--MIKLrGqWG9rPqcvA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJPBAABCgA5FiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmr7PPYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEHQrJ6djOklji5YP+QHUxpXdzG1eYrKB2YUX
E0O6akGJOqrCAUIqGaon6KVeus9BF7kYhvIJ+jvn6iUvHikWVKXDyLliDJMaRCI1
74f3WSZRZhbb5sFt05SswrKQfX2PRMDlYCdLyCLpbqH5jpiVABqud9QHJgccvRm9
iFd/CW2lHOXwfspSpHwTQSOB+20NHSShlM9eg3hOE8sWsRc2BkoByzTzMxoFKH5T
0X1MajFEBP5sBtL4w4zAYb0Dyrl2Q9HSBka7cBTZ2OstbfJ+CjLMXm1fIFRQQcNA
FJwEOqNQczBpp+jM82BBoaqMIwbukTxkI2LQxCNq0DBD9wI9e01HROCcGirOaJxQ
QWYElzcGF0dyT/XLtpm9k9uMPJUPXxySF+ZbB0+nukO0lJTM4y6FXG1g6t7XHxhw
8ROiDcHDUUvdJN3cPm1pg8vDGPAh8N8+HJKsF2G30wbxofJVQLCAqCh+TT5rwDZF
wR3TtvQFlwMFGQd1PrjlDpbV9rCYh6dOS/X204PktA1Gjal8k8DuI3S0H3bRr0oY
1BTK9qhSIrLXUcTHnv/eEX/Qb80VKupi7Ev17rGDKIklJWeMt4O6XWxmZG7o8IwD
eqzoWxzqaFtVFcfMiyI5bZRCHEB8bzQo4pskn8p5GxBRMzpsvE5raz6+ty2BTB1h
kSE1Vs7t9sBYbKyegK8KDHIK
=Wi6k
-----END PGP SIGNATURE-----

--MIKLrGqWG9rPqcvA--
