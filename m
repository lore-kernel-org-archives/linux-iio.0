Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208E44A72C
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031955; cv=none; b=GdMK+6lxuJUP4AW1w/ue0uqWPR5Kyqb3ByWYERK8Bst3dOKKwCmsnnBxrKEnG4rQ9NigUl4cG3FT9xIw2GK6vEQUBwFnp7/k9eLByqEUkjF6Rwi1ATmqnHnctAPOHjiTduDn9I8YOixlaav4O6ZkFDM+p0ZwJUaz0UIliqFVNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031955; c=relaxed/simple;
	bh=0+vGZfhgz1bD40ocE4HqL+yXZ99EIYUdksleBRdm8Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnBVHQsxyZ0vCBOslD1ATFJdZqIrVsk958YOxivLYXP2VdoA/TASYLvv/KIhKVkodVsJloyQ0gIIpqfS75PEBqmhCDaMNbUiAoAOdR0rgDX5/gBhSGRqa3atexA/uE8kAfxvZMtY43bhI0TP2jdjKxBtzhZPvuSu0lWKYa6cnYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XbXL7dz3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XbXL7dz3"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-474560436c3so704207f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784031945; x=1784636745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0+vGZfhgz1bD40ocE4HqL+yXZ99EIYUdksleBRdm8Wg=;
        b=XbXL7dz3fsVvyc9B0lAyOQGiZ0GJFHAGz7YKnOfyFIbbT0womjk52r/GJgXawi6QPm
         8btG+ebYd1TuTnvOZRhwVc3bpXaRiT9loRvyur1bl7qO4s0fSRClcW6uamday5gxj+c3
         zve+gSDe5U2DUuFS9h+6QzOnEK4HfUd4TM1UpeRnwj4F84eCqcJV3wue37LBiQc9Yxux
         2LshZPW9jn9L0dfARhojxWuC683EosDYTMaGlXbRLriSqu2S5nPLuKbRR2Ts/mX3f+zV
         0CSkMIKE8uxhEaY1C2FWEyaecif0pMJSGuR8id/UbNiO5MX0jTp9gKpz98tY+jVGOudc
         gIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031945; x=1784636745;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+vGZfhgz1bD40ocE4HqL+yXZ99EIYUdksleBRdm8Wg=;
        b=Zf1Cb3OpPdObuJGpDpNPgRSQafvHtf27vcBn9kgj3oKzrk2uB0AeaPmoDjPyM+TasD
         PRdeHOcuKk2AdgkCAahRm4eclpe+vHheN869PP1wFtPZAD0VFLRqXExs8hDrgn9avXVy
         4Jz21E3pIv0wibgA6LN6wJZCwHm0EJN/ByP17+vl/ry6+b4GjFRyQtA522r7wg1VX6q4
         m3bo8pObCHjU5Z9d0ujWijvdSREJPtfv6cO5LBDpN5VE5lrh6weH4LBxc8etY9cIpKtY
         Y2N7qrmkaIKMhZpSEGzqxwjEQOOCrFRG9Ctsr0oLwZcCsOW3YXcMYVtlSyJOrSABJedh
         FJVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rplvm/Yi6GnkNiQyjhUKngJclHBhk3oiKHGO7iEuqxG0RZjCImm3pABsIsWHE7yFrwKdg3Sr1240fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WWg2moRPcgzDss2MexlIu4GlBPGDGgMsoAf0xiZssh5ZVUFM
	a6RcYRMWzi5h+NAbBPgzo0XGPBbicwiGfi60PBlCfqveoZtAHEiNOtETnDvopSDRQJQ=
X-Gm-Gg: AfdE7ckzEWzzjr5mWACCNFfgI3qfUJO69X+/1pMvw2udwaKM3vZPVOfTsaTvMA71O/9
	VOhECEJ/RJl83XbNTBcKpe2Z9Xfgt4ATy/UH8rGXtUvZ73UatOxF5Q5z7YRtdkqwrdwakApp8lX
	rIq88fLaUgD++qc/YaheYTv2r2XZIPoZxARJzYWlzwsOxsJ1P65pWjj0BkFFUHpn27ACd4S22/b
	as91CCEGJ1JnQZ2bTb3+PFk+ULIVZp7BKAZgXqsK6EqG6HLYJTCYeOQX4IWLbr1lu1B45ZsW4nq
	YW7yc5hkx+IES7E6tAfHjl4XzKZSA0QslKJInEnMAfkHpjtnse1yuGNEB3KYU3LVTVF8FF4rfHb
	8qqasoBJv6k28Mi+uVRourxQx+YS/Wgpj1zlcT+LpK7wADPaxGkiC9rPI+hdJcljVgtqR/496pg
	2oAS4f56bW/RSk4WnzGrk0ChGTlo/f3SQOI0C6sd1Tyfbg1COXOBV29N2UKeKG7aqXvQhL7mYp6
	7R+
X-Received: by 2002:a05:6000:2210:b0:46d:d5da:f0a8 with SMTP id ffacd0b85a97d-47f2dd08423mr15598269f8f.47.1784031945403;
        Tue, 14 Jul 2026 05:25:45 -0700 (PDT)
Received: from localhost (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b44a:8042:1173:aa03])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f4635a63esm8284732f8f.9.2026.07.14.05.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:25:44 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:25:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v2 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <alYqhghiVxVW2vQu@monoceros>
References: <20260713081127.115197-1-cwweng.linux@gmail.com>
 <20260713081127.115197-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a2h5qyp6npg6rco5"
Content-Disposition: inline
In-Reply-To: <20260713081127.115197-3-cwweng.linux@gmail.com>


--a2h5qyp6npg6rco5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
MIME-Version: 1.0

Hello,

On Mon, Jul 13, 2026 at 04:11:27PM +0800, Chi-Wen Weng wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please rely on <linux/platform_device.h> to provide of_device_id and
drop the include for <linux/mod_devicetable.h>.

Best regards
Uwe

--a2h5qyp6npg6rco5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpWKsUACgkQj4D7WH0S
/k4ixQgAlt+F41bzzFr8wApKEHEDE06Wyl2Bj9mhJ2lBUH5L4+vpMsXE0WVLJKmu
HL5Dt7P0owSyciNzhp+pTCgs7ucr0yB3ysy+rILUBGjH8sExdTwINM8+0I8q2mfq
uUinfFczaWbZRevyDkY9F5RPUt6WGRFz9uNnFrkZfNHOJL4jo69d7MftM0IW+ruv
2SQnD38ccuoMsiZYcVDkSnDVXcruoWqhk4ViKjx/a6i5d0HhZHyfA6eSAaSfR8zf
dHm5Fk26lHBT+xuv2TXw5FDGI2/h899mXnFcQGR9zsH5ImhmUvJIM+sL4FZ4fC1A
UTd+40tRC7LtdqphWXA0H4oK7F24Yg==
=GMY+
-----END PGP SIGNATURE-----

--a2h5qyp6npg6rco5--
