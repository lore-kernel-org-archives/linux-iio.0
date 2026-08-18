Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B232ED55
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043865; cv=none; b=inK2Dj0wTGdTFEmWf9wSLqvGa08tnKnZPhSFSY45tg7rayK4HI8JcEdUUh3BgOQBKKgN04ffffpSQ4HtKtDVx98mnsgXhR01lEfasOF2/BkIbQj9pjIZhWI6sCwjQ89Xl3R+2gV8mi8I1BfVrtAvkpa1rvoxSntobkv4OJfbl0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043865; c=relaxed/simple;
	bh=kZvCKzmguS45AfCxZVg9JU4qPhGTNcY1F1R59el5p3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/R96yoZn/EiHEzCNqIfYNzzJTM9wUzi9/9q31/Fau9hHSllTdASrya+kTOSur5JvI594gsZ5T74qGUS+X65d22GS3gJF52aJGUzIU+xIzFqhh+lglvJ13MoYYXsIoQ1Qsd9wKLMW9U4f0Bu167kZ5XCFuwMSH/FguOSaiujgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=exy62z8p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="exy62z8p"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso5234275e9.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787043862; x=1787648662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZvCKzmguS45AfCxZVg9JU4qPhGTNcY1F1R59el5p3k=;
        b=exy62z8pWYytuleQnsTkRAEdXtlCPI94poVY3HlN12UgYjkltzaWc7lX5y0Ud+o/H7
         TTLrqvSCFGsjhqWo1h5TlxxHxoCL6CgyzaMnXVKriJyHyyuA8nhS5KXRk1YPduD3Tnf3
         BybxSnx8ORk6pZtLpnyi8om7D90R57P8AzTKvj48lmi2M/HZPcy8ddhvULsmGvzTDwAM
         l8cDqPxawLeyjSGN9nr8Zo1nZJSb+/93iaVRMEj+u8FGbCo8B8U+f66d1VDsy0sWmWDA
         Z7M96KeTkyZAD7MzEAXk1dA9I3Eb06GaK7diYj+L1DvwtFpm1gj7sKOl4a4ZUnL3MoEh
         weBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043862; x=1787648662;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZvCKzmguS45AfCxZVg9JU4qPhGTNcY1F1R59el5p3k=;
        b=i9S33TsZ/YtAK2iwTier7obL6nPFUFBB74HernwoxmrzNr2SC14tkkY1B7r+dNWUcF
         PdLuJNXdljkCHudmtAVcan/5zRzfEgWN0FlzfeROdGbiv5PQAgluiT6QLz/xCf1c1FrG
         6HREuad4mopKXx4o9QRtBUN5SyXC8QVFC+AcSqiJS8PkuKKe0G4aF7IGAQAfWrM6bH7c
         kNTmR32uuFLrLWyqp/QMic3dw65n6JMQzL7RnDvGW+e8LrojDQUanMZTW9TL7P+gsHzN
         tMnqk5wBwBpbaSNTKHeFD4ZZhSEz6N0iVaI4USIullLBvoVRPnsU//NPCnRFNJ0MJyiC
         pl1A==
X-Forwarded-Encrypted: i=1; AHgh+RqqpG+3lQ6B99Qvd6vymG5uOMZ2eTM/5Hyh78ut1Zgjpt12T0lu+Wyw3/Qii8b7Nii+LxcNy2+qbu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkmBYsq4XJv1aYzyxXp3zlGIf+bqzvkP30CO5BS08KPUvusoW
	WARr375TljZhnpJKlRVLMyFaBriaYbSwvYO0naM+o9LNLbxrY/t5SixiWaHrvY6B7fg=
X-Gm-Gg: AR+sD11oNC9Jmslq8SdESkj7/ecanbCJMjdGrFgObMFlrFj0q9LY3xNtG++wuE+mgg9
	oe32bgGWhR3MTZRPhdI1Kyz+wVg28Vm7wHsYtgxSh1kqx7udaip0dcqHXseHqcVu7woV1Hz/U0y
	i3RM+Hu/n/jVX7hn1i5oI0ck6rcBxP8BbDUvgfhPzJdVbSeukACCYBD6PZcuZbrobzjieno272b
	U6FoOkt0Eh3A5GVLsSlwgipl0aiEDSQJSbFYAOC2eMs6W+EP4A3qbYweLFEeSqarTjkuSHAjvYU
	c/JDFqUMy5mfvA8H3yRi8lB0gJsHT+Dy+Cbak3mhjEXfat4B8XwxZ9PGmeEjk3srAvkSpEGjgjX
	Sw+JSbo6aPawzPoVXzv32oPP3f9mhNkB/2fw1oi877Ww5XUgV+aTpgXgN9SxmjZOIo3cOpVE3fv
	Mgup7soRSri1RXWR5ptylcRCtWqOumQCugH3ldKCju88EzT8x6kT1YPOm8VXNb7fRSgXVx/Hofb
	++Wb+MW5iqIvsJT6BdgP+/iTyLTyvvARRM7hKOP3w3u6LAGtCKS
X-Received: by 2002:a05:600c:858e:b0:499:5f81:8ca1 with SMTP id 5b1f17b1804b1-499a08d2c5fmr81326505e9.6.1787043862041;
        Tue, 18 Aug 2026 02:04:22 -0700 (PDT)
Received: from localhost (p200300f65f01710416869d85a644e839.dip0.t-ipconnect.de. [2003:f6:5f01:7104:1686:9d85:a644:e839])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a5a3158asm10589099f8f.7.2026.08.18.02.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:04:21 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:04:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: dac: ad5504: Align headers with IWYU
 principle
Message-ID: <aoQfwxLurO9RgMt9@monoceros>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
 <20260817211118.21833-3-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6nhyrc5wlzpmw47v"
Content-Disposition: inline
In-Reply-To: <20260817211118.21833-3-0rayn.dev@gmail.com>


--6nhyrc5wlzpmw47v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 2/6] iio: dac: ad5504: Align headers with IWYU
 principle
MIME-Version: 1.0

Hello,

On Mon, Aug 17, 2026 at 05:11:11PM -0400, Taha Ed-Dafili wrote:
> - Add <linux/mod_devicetable.h> for struct spi_device_id.

no, please rely on linux/spi/spi.h to provide that or use
<linux/device-id/spi.h> if you insist.

Best regards
Uwe

--6nhyrc5wlzpmw47v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqEIBEACgkQj4D7WH0S
/k6k9gf/XJjMKLmyQ+EipN3dYdshWkNe2VVs1IfCcFB64ghyBySWNq9Dyo925dp9
R7MaZxMSUVFUBfeAVhyZUqGlFaRdOpiN4+3i/rPEH5v7lODPg6R2vsenlJKsivy4
sr8bRVqQmm/TTGWqaZJl2MfAjuV0iRF88uAUXHfeIsBNoSobTbr3FPDP9QjV71UM
BuMqE85miBZOrVvss57R9CufnhRZjgS2FSBVeeKB7XxQjobfDBWcJwbGIQu66wNv
rgIkYjqwk50S2DquSk5watkvu6u5HKJyQd/bSMjIJOCc0YGmzZGXd+cxYUr7vrAQ
if6GgpXG3DE3LYSvXgLnCH7yQx/P9w==
=dEAm
-----END PGP SIGNATURE-----

--6nhyrc5wlzpmw47v--
