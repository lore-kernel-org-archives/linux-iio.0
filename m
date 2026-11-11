Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386184;
	b=QbGLu8SXvZzRtj4BJch928TiJHLt89sV+RIUtzNHMpAbLj/WvQPh+lwwTLLLo2izSmD5
	 RP1HC6inA+JAPw0A9h9SheNDzcD3tG59dwIGOCZHR2EJyrfAAR2+Qd/2nP2kfH4xd94Mh
	 enJToRvXnCkKfanPJtRu/J5tOKfwHb051v5+LemD/51hVC+P6VJYGmmKBYUEBWmrleLIg
	 /0AwGdiwvxTS5EYc/zfNDwf/5VMZz0jAYvxnqPycQ3bmZhVPLPNXR6rgadh25JQYM2EIr
	 LpP0CViP9XeUQxdQi0LDGMMxQSvWzkyknB4k76TTQJ+kOBUy8wUXO5S6yUIjw1Fd3Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hwCzX3wFkjwi9d1zxYJZk9eA77a7avCCt18YWRijvq4=;
	b=Vt1hGcVZYv/HoEfeqJY6v3kMyxlpgPARvoxC0h8l/RsowVNtYA7nTbGJ3qZeXeDvLkKA
	 FFyQUYsbc86XfD9KBKemTY3phLGeqfdp+M0YkxkG4+Q0BbpfgpF3SZoq1cSetet3KBmh3
	 7Snyz8QtopXLZvCYJgJ2Ss7+SgqQYhDOsb8F3Q++8j93x3B1OBljglwg/AVfHz30vCB6/
	 FEWQhs/QgSjxiOd0v3vmHGViwkWAzSJ/jCkZy6B/octDfaY60Kv4Wvz0PB68zcrQgwrFF
	 BeO16oeE+3tVngTHWB7whMPxl8Rov7GlMB9q08i1Xv7UazdRg4T0EH3XKPiarQBFS7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=chromium.org;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=da8Yt6+l;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F16606A31C
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 08:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02F16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=da8Yt6+l
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7190aea1so12468775ad.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 00:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794386183; x=1794990983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hwCzX3wFkjwi9d1zxYJZk9eA77a7avCCt18YWRijvq4=;
        b=da8Yt6+loKDHP3T/IbJVtjlnMUo3fPvnNU6t0ZzaWLb0qOFftg9MJmTJwa9iH4RU7H
         O7ZlCq1qrpsff3drm77RcUV3HWK75KdpP4ZoAPY5ZDtnA23dZInLIKx5Ndfczn4vs6KG
         3LwSWbGXCB84crZ61ALLkDMoUdzicDnBzgKButMoTEEfl27Jj9s/zwto+zF0dMu8QnXg
         5UAXiGRPLOuC97vdv8UTnC4ClQnUEMEr53y86M5+gHg7ZM+WSWQyyiI8Bt65DiNYIwSK
         Df6emGo/MTC5BqGCobTWiyX/QfzAul9UikCPvMTfQ1HejeSvhyaA+Ec7nXf8f3fHExjm
         KEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386183; x=1794990983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hwCzX3wFkjwi9d1zxYJZk9eA77a7avCCt18YWRijvq4=;
        b=vmE5xh/X1MxVt+8oXy76lWghblOCXTUYsiKjaPP1pcxnFVXKLbERYYh1mwzexF+esR
         Q3062upwcU0EGzBOaqTpWpMEuRmxffMf+LqLn4HQFMoVgLzMlbcC8PZMXqn1UsCExr97
         p5LQ1lcKvksmcSJcRqJaEEiVMHIEe+K79KLLmySOOMH8kXLt5K1ddTM8Dg6Y9MnHuIev
         4noM60KleBwRIX7fWSlNQuldXEY9B08oTXg35FISj84xI5GVfGy7432OlJu0b+ZktpYJ
         acyXlxQ5vvuFwbiT6ytiNPrYx5BOrW3kbKfV+JZ4tEfFb/mzD/0VK4E65k6D7dqaHOFW
         q+EA==
X-Forwarded-Encrypted: i=1; AL+hErE0JksxiTYsbIkgly+wSeTYRW7wFLY7Ju9xKc7Ur1CH9pPWC/q3iC4Y52XUEpjoVECVyFj7FqoUT+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/q2U2u3V9lrSOQKl7NO1n/Rf/kw1DVo4hZjiZ9uv69llztTIMA
	XQxXX0LvMWVMDDNk9Jq5G/wuVlZMkVhTQj3CZ480dM9hgvJuaPsWUYVlS/NR2K4pEyPB8yuWEKl
	h3JPkg06LK+U=
X-Gm-Gg: AYBFou3J0yNriAAQ9u+Ka4UsrZj6qtYU+WPmk/VS6Ro1Xp0feE4NaZEZMcr4reMp6Bj
	VT7RIqy32N9j2H64ELtgCOLv35L966Gj5KqFryHEGBWfaYifxEHWKcugDRWZEf0jBljJfkLTcPP
	NgZS2Z64N95s45fBiwaz7vCJnTsKImDERChpaYCWG2LKL4JhzyUusTUsmNmTeitxJjzIehDdxLd
	PnyOsDM4MRoHysIsBWmqZ09eytQtBbJs8ooa46irv5fBWL+xL9YS0be4yK82S092aLrxgPv3FN0
	R8i3rTSJdvRUzY8fYRUNGBIvxxHquS3SRQeyOmHAoVMegGG5bKmQR0QZH0DEW6RC8nCYe+rQFiV
	PpxxbdyO2TxlbTXEocCmWvgrEzKmPF28V76YE58dgyWn/wuKnlpEpAT0Bc+W1d7H6KtjWZ0XWpf
	cErBepKv1+1GNDBQNMpf7aJCYScjMxTnMWX8rQ3e/REhEtuCRTBc9hNkTI9wZSXV1y5b6svgots
	duhl1VwmfJrR8a08FHNIL9EdMy+Z4NxzUYnhaXNZAe3tYnVe5QB38+b+nlry7OCtw7Nst+Ey9ko
	3Te2itLcOE7zusPrW8q30dOrQ271AJ5KikmaZGYeugNzYT1pWvmcvTpoY0UIxh5WXGzA0KaDS/H
	Pcnj7Uwg+Zy1SJ5mL74sPAodJA/2C7fyWPLCST6dgEn9CVcoPELOd8VnPt0QyS41urLdVc6r1WC
	bwI04/EhQLpbI2
X-Received: by 2002:a17:902:da87:b0:2ed:294c:2b9c with SMTP id d9443c01a7336-2edd7ac1ea6mr22278895ad.51.1794386181887;
        Wed, 11 Nov 2026 00:36:21 -0800 (PST)
Received: from google.com (196.126.197.35.bc.googleusercontent.com. [35.197.126.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dd43bbsm17865115ad.57.2026.11.11.00.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:36:20 -0800 (PST)
Sender: Benson Leung <bleung@google.com>
Date: Wed, 11 Nov 2026 08:36:18 +0000
From: Benson Leung <bleung@chromium.org>
To: Di Wu <diwux@google.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, bleung@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <avQpArYRzrCb5MDq@google.com>
References: <20261111072608.3490763-1-diwux@google.com>
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
	protocol="application/pgp-signature"; boundary="jEief8IRC6172HB4"
Content-Disposition: inline
In-Reply-To: <20261111072608.3490763-1-diwux@google.com>


--jEief8IRC6172HB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 07:26:08AM +0000, Di Wu wrote:
> Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> PAGE_SIZE limit and is the preferred helper for show callbacks.
>=20
> Signed-off-by: Di Wu <diwux@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/=
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index d03e40c91582..624d4b32b034 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -149,9 +149,9 @@ static ssize_t cros_ec_sensor_get_report_latency(stru=
ct device *dev,
>  	if (ret < 0)
>  		return ret;
> =20
> -	return sprintf(buf, "%d.%06u\n",
> -		       latency / 1000,
> -		       (latency % 1000) * 1000);
> +	return sysfs_emit(buf, "%d.%06u\n",
> +			  latency / 1000,
> +			  (latency % 1000) * 1000);
>  }
> =20
>  static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
> @@ -165,7 +165,7 @@ static ssize_t hwfifo_watermark_max_show(struct devic=
e *dev,
>  	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>  	struct cros_ec_sensors_core_state *st =3D iio_priv(indio_dev);
> =20
> -	return sprintf(buf, "%d\n", st->fifo_max_event_count);
> +	return sysfs_emit(buf, "%d\n", st->fifo_max_event_count);
>  }
> =20
>  static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> @@ -465,7 +465,7 @@ static ssize_t cros_ec_sensors_id(struct iio_dev *ind=
io_dev,
>  {
>  	struct cros_ec_sensors_core_state *st =3D iio_priv(indio_dev);
> =20
> -	return snprintf(buf, PAGE_SIZE, "%d\n", st->param.info.sensor_num);
> +	return sysfs_emit(buf, "%d\n", st->param.info.sensor_num);
>  }
> =20
>  const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] =3D {
>=20
> base-commit: b70566610b48ba49dec636019da4d696db64b085
> --=20
> 2.56.0.455.g6c5a503b38-goog
>=20

--jEief8IRC6172HB4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCavQpAQAKCRBzbaomhzOw
wnMVAP9z09pQgMCDirHGoNohxo1OdmFC8Hu9n9+XFZhqMxV9XgEAu7GyPH/nMTCS
qVL+/Vey4OZJEroKyiCXHqlZZf2WJgc=
=nQzv
-----END PGP SIGNATURE-----

--jEief8IRC6172HB4--
