Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793567658;
	b=BNBWYDKo261KMasbzoV96D67vPu7wLdU7ooAukrkNGt8mSYpaKoXSx91Mrkn9aO5kUPq
	 7x8yQFL3tQvDekpHaT870FsG2WsBaiZS/wvd4Q7zu7PXVFcS9t4QyhGZYKL9+uyLKib9E
	 n+XXbvEtkI0QWxWyxDEduvBZQ6In8phnyiLRtMDOYOfq/hkcnXMJPSqOchJYIQfVaOBp1
	 SSwPmKr8zxQ/9r4XWwesW8wyyu4o/y4xIT4AxEcm75aWcwnL4AqU89r6TW+rDoHsmuD0Z
	 RqeqomKqVBi/fExzje8fLicf1nd9fN2TtLHIF+4OWjoTo3dqqpvyBpmuwqtwRKEMNng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793567658;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZNkRVh6Ty401RG6V3W3YBuDyeqLwtI1cJ5oxr/TdzUs=;
	b=n8bmHPRbkjGoN3UWnkXRMRAU9H7YCHjxcnvjr+V415lFhgU2xOsUK+4BlEw7L6LUseaV
	 Zil0pec3E6xKERCXOdj3/ZPkS0AxQESuFtDDHlAIfIhQ3Rf0d953cJybSBOIrrH06pisF
	 dd/JejREuanxnn2KVfy8gtOkc7zzQU8wTz9tzTrF+XsrGQ6FJWE162aJg2nd7DZlJxbWl
	 Phru2d1f50kyj0JY0hODgRK7VgOi502L0JEmg4F8lOgeNAH4BDWIMhRmPM624l6963ppT
	 4PEK89jijpUKBdvgBMmnsSylOtNXTt2q2OgeGzofMu8hfhhYtP2FITW5rw6f86V0naA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtI0IhGI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784A5606A324;
	Sun,  1 Nov 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtI0IhGI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9831F000C1;
	Sun,  1 Nov 2026 21:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793567658;
	bh=ZNkRVh6Ty401RG6V3W3YBuDyeqLwtI1cJ5oxr/TdzUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MtI0IhGI+f3QNHD3CTexim/4WGzwoaiHljWQsSqfmi4liMSnO9BMV0v/Tqb5Mwi7g
	 3mBHxE+bw5aYdqBHlmXNZ6ZRgwwAUBKPTVzFMWIeBc+Vi/EHjtd9G/jCLOmdhbro3L
	 ehq87f1GKiyV9p1CPOnrRa03HsulXIsfNuvg7zDaVURrEZq9UswFDM8XqXtLSJ+Coi
	 gmvN/efPtlG5AVDpcLd6jfpOUIODKw3o/07Vp+2Zq2WHIloyWcqmvGoh7ixl3JWCRv
	 0P4xOdAnL9igbVMeJP8kUvlIfCZm6bLFt1KD3KcYyB35AcPePY0xO3cMOZQOusgtGS
	 2vqFkWqH7+tZw==
Date: Sun, 1 Nov 2026 21:14:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, Benson Leung <bleung@chromium.org>, David Lechner
 <dlechner@baylibre.com>, Guenter Roeck <groeck@chromium.org>, Jagath Jog J
 <jagathjog1996@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Jinseob Kim <kimjinseob88@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Remi Buisson
 <remi.buisson@tdk.com>, chrome-platform@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, Bart Van
 Assche <bvanassche@acm.org>
Subject: Re: [PATCH v4 0/9] iio: enable context analysis for all drivers
Message-ID: <20261101211410.5fa14b39@jic23-hlaptop>
In-Reply-To: <20261101105832.55605-1-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
	<20261101033018.05897c08@jic23-hlaptop>
	<20261101105832.55605-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Nov 2026 12:58:32 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Sun, 01 Nov 2026 03:30:18 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Please take a look and check I didn't mess it up.  
> 
> Diff is fine. Built drivers/iio with clang 23 allmodconfig: no
> warnings, and a dropped unlock is still caught.
> 
> Subject line got lost though. It should be "iio: enable context
> analysis for all drivers".
Doh.  Cut and paste bug!
> 
> CONTEXT_ANALYSIS_dps310.o := y in pressure/Makefile can go now too.
> I can send a follow-up.
No problem - I roled that in.  Didn't bother changing the commit message
as it is obvious what is going on there.

> 
> Jinseob Kim's Tested-by didn't make it in:
> https://lore.kernel.org/linux-iio/CALMSew+nhZp9BoqS5tOgFdiVy13U1r2f4UQa9Sd5zc9pSt_YcA@mail.gmail.com/
Ah. b4 didn't pick that. I guess because the formatting was missing the <> around the email address
that is standard.  Anyhow, fixed up.

Thanks!

Jonathan

> 
> Rupesh

