Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867CE309EF9
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278996; cv=none; b=mBTOHnzM2pb2pjIdghDE4jOUob65BEpkz/teWLmSla2frqBFa2RQjbfbSYKTUPK6fZK83WLUzefc3wqNb14zk7pp3Lowz6gUYQPjnXXajyH7esnfppCHEgzgsU7tO18RDaefjin0jVGA/fh+kZG20qqL3YXfljyEl2s7Zz5L5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278996; c=relaxed/simple;
	bh=devex1NxxbO5Ce8hDzE0PrM0NXXbvrKcL0k+gmPGkkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZYtbH/DbCJcD9nUZlELio8m1h3s6N0l2Zcgvqu/k7yHlGu3EK6IUyjQ6g7G+Gd8spZ2LZCpQ7ViGfBRUKDeoQLM8ADjvF9lecQrfYml7Zm4bUm6Mnvw0r3V1i9WwiRN8NbiuHexEStz7PPqM7VoIJgVx+SVAXEkzqN+p19Qs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WOb786Ov; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WOb786Ov"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so41953155e9.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784278994; x=1784883794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=devex1NxxbO5Ce8hDzE0PrM0NXXbvrKcL0k+gmPGkkk=;
        b=WOb786OvzsfQN/n21RIzt2pT27L/IFLWc6zo5CCZ1u0wU+5C1DjHdAazpctkqj4f83
         wsZrrX7fTzUV8QMOu+u/13PIyxezdfGzrhVsc2pIjZ/f5Wc7GmZnCvRwoEQf05lRKmCr
         9ivkWLHmtTrMAf204ovHOMCMoqpaa9PTc3cwGHl6SG74LdYbwRskt8QLlla+xugK403n
         W446gR+C2AKdbWBsVexpcK9TqHQfVLOOIEp0V4Gi818KQoCHDEQO/JuPKhZQw4igulFN
         PGLDLwPcos6FMa52ICGEY9+xD3BHzoWB0XgDHtaEmBKvilJJaFJOAG11G0uvv8e+uHTZ
         DLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784278994; x=1784883794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=devex1NxxbO5Ce8hDzE0PrM0NXXbvrKcL0k+gmPGkkk=;
        b=pYUtH/V9ozMWc/nxDgxSigoP4DuDcoByTokR2VkPz6VSToJ39wqNlMp7SfqiGIDSQs
         24WqyKescOlxHOvJLdQVXRlYo7W5kzp5kjnrCp41X2yIA7/Ay/Fk3yltwIlUGzg24ipv
         ggfIJXr5yoR5ZJLt+Oubit1OPhecC6Dy2eZ4RVz3fCE033XAuk2qWTUJcqJ0NTUmNPvc
         VD1I+13xbmITsJvc65j8VvVE5ivQdJIbY2nygrQfXIjBN20egtmu1kqCzcDN3kLpcW/V
         jdAtn/KFCKzl4nStk7m/T5rC7dFXHq265afi93VfORzzRrKm38mHfH0wUWuB5Cc6JEm8
         UJIA==
X-Gm-Message-State: AOJu0YzXhqJc8fHESl/RIKO8Ez/lkcX/G4WrchHjwkBuqGTZmVXMJenp
	5WoJowcxCfxQSDDw7Sc52yYZQvZOJib3VZK0HuDs9hrtYRlAFT8OcVSB+LigIu6giug=
X-Gm-Gg: AfdE7cnckXYJbU8qXwbMUKO+e0mkaElGmn5ev0AdZTxVg+4u/oN/yD3A/JMKhIHnc7k
	AjTlqN3XyFYueQ+dgEr5VWPkygke4K/gACKTp/2xoQg5bvnj4p25z1xmy3oKEDtM658q8oa9DaF
	PJMEdFh2wDX1XfWQWUlZBjp/PpD5aVz0sXspX9hM6uPSCMCzL5MwEpaX/F3QZcljzApeLwZrkgd
	xjZ7WZVEFEs24oaz1xxeHR2mEm+cMOqxrp1UXOUj633159MRf5+D7FjdpmgFFZQZnfpHzBEeqxY
	Si4VvlN+H6PCe2enyUgFuVYQIiMwtLoXYYGTaruUMu4wTkRGqBpljFbFNSN6M8HIxF5BzICoUPg
	9Uzd595qX6qKtAtY23EsBqyWu5PeJI2VRha6LZGspiVH4RIJw4uwzxCU10vtc55kK6tDw7ssUyf
	bJDL1Xl3fXSSavigy6djuxlg4Q93qpofhxkuIBkiDW0HmdFY27kbzgGq1mrGy+GvGwZMHAFrNIg
	fH/
X-Received: by 2002:a7b:c416:0:b0:493:bc92:ef45 with SMTP id 5b1f17b1804b1-4954a50c54dmr12670645e9.24.1784278993613;
        Fri, 17 Jul 2026 02:03:13 -0700 (PDT)
Received: from localhost (p200300f65f47db047d2d8b161e35ab77.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7d2d:8b16:1e35:ab77])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4954a2e850dsm35096125e9.9.2026.07.17.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:03:12 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:03:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V17 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
Message-ID: <alnvV0OwqMtRVmF5@monoceros>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
 <20260716182637.24310-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e324wvcflz4pjyjc"
Content-Disposition: inline
In-Reply-To: <20260716182637.24310-5-macroalpha82@gmail.com>


--e324wvcflz4pjyjc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH V17 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
MIME-Version: 1.0

Hello Chris,

On Thu, Jul 16, 2026 at 01:26:31PM -0500, Chris Morgan wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/spi/spi.h>

Please don't add an include for <linux/mod_devicetable.h>, I'm working
on removing that header. The two device-id structures you need
(of_device_id and spi_device_id) are already provided by
<linux/spi/spi.h>, so you can just remove the include line for
<linux/mod_devicetable.h>.

Best regards
Uwe

--e324wvcflz4pjyjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpZ780ACgkQj4D7WH0S
/k4xZAgAtfjTKvZT7A4NQhBqkvJ3Oh/IEog67mulCKGQg4I14S3TLgflro4SP/yy
Ok9NOw1Vn3j3SaeaMFYTK5mkJ8Pl3zl8WKMkZwRK0VDFFNM+3RH0T4UdYMzkGGw7
XC0daPY9wUVkAZnnrtimlUmStbsWWa11jGq1yDHeRSypF3U6dBhyEcOFdaC7pnlD
9h5M0F43a/c9H6lRUVWguiN2egwEtvJtzQzQmW+r1+5I4zUanpbR5xP6gGhYcnPz
HF9zOCNiqJV0BiUdzTFh1cFZyHdMTktzpDmWvPm3kmGSetsOtzLp6y2rEXxx6r1w
X8sGDrKRln9uoLX3A9H0jCz8WLXAoQ==
=wy4O
-----END PGP SIGNATURE-----

--e324wvcflz4pjyjc--
