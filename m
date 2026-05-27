Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D0A3D6473;
	Wed, 27 May 2026 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880624; cv=none; b=HQCGco7KMRH6gMW2NjzfKUAxjaV3sGhL+IJY3odjG2FFEk4NQnYFQhe7Y/CmK67QKG/IV/p6NxzLyA0cIruhqtEWHV5BYR1k2Ad5eJwKdFKHQXga/dGo3pPr78osnbjF6LrfDv3YB+rMr2f1h2QLFkT48BO5puhoktlKjpNrtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880624; c=relaxed/simple;
	bh=TV27Dz68oILJadF4SE/lQl4xhTeV4MyxytBZ6vJWnJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWdPheUvpVPsVYSnJhyONso0YDGSt8TZvsA4wV2Ks9K0ebE1xlASMoBH0VjRCJ3BnNHp9Pi48Mb2mLQAcrCyt5iwA6vMmVOSi93WpROjvCR1SZlv3URtsNE6UcS0uT4Ch3AEEdSKGRbUbG8eqkC1xcerCZywMGaWzDE369v8itg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoV/ivlC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoV/ivlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A191F000E9;
	Wed, 27 May 2026 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779880617;
	bh=bznQsg5OdfZmNLj1aA7dUb7Vuazi59aNs5ZdREDkNoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PoV/ivlCYoWoq/BhW3u77m/wVQS37HNr95EM5AHx1VJCW/TBzS4PN00mwS9BLk75s
	 cNCSP3AIcjfdkBXUiqz8yW26ktbBeKYeHoUJDrSjj3fnvnvvRvFUWGNb5P3GchZy3+
	 nLCcmJf6uqxZN/w4UL1VX6oCAqgqee5J0esgL8EMr/hbel+YfpsW/GWrMvBKzNg6Da
	 2IBVCvA64NcKYgLgFBIo+1ZwYnh/V2zVxfDnBu/A8KRq5r4qkv8AesNfyMulqSDKI3
	 +BZQOQLlVF7u/uYK8L+Wy1g2ClB54JQ1bzUAO2hXyw3WLKsXiVRlMnnl5ynfnqHYvl
	 2IlljrTQJ70rQ==
Date: Wed, 27 May 2026 12:16:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] iio: adc: ad_sigma_delta: fix CS assertion and
 registerless device handling
Message-ID: <20260527121648.6cf31312@jic23-huawei>
In-Reply-To: <20260527-ad_sigma_delta-fix-v5-0-446fd2bc7330@analog.com>
References: <20260527-ad_sigma_delta-fix-v5-0-446fd2bc7330@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 12:38:37 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> This series fixes two independent bugs in the ad_sigma_delta framework.
>=20
> Patch 1 fixes CS being left permanently asserted after single conversion
> and in the error path of ad_sd_buffer_postenable(). In
> ad_sigma_delta_single_conversion(), set_mode(AD_SD_MODE_IDLE) and
> disable_one() were executing while keep_cs_asserted was still true,
> causing any SPI transfer they issued to carry cs_change=3D1. The
> postenable() error path also failed to call set_mode(AD_SD_MODE_IDLE),
> leaving the device in continuous conversion mode with bus_locked
> incorrectly set, opening a window for concurrent SPI access.
>=20
> Patch 2 fixes ad_sigma_delta_clear_pending_event() for devices with      =
                              =20
> has_registers =3D false and no rdy_gpiod (currently AD7191, AD7780, and
> MAX11205). These devices fall through to the status register read path,  =
                              =20
> but since has_registers is false, ad_sd_read_reg() transmits no address  =
                            =20
> byte and blindly clocks raw MISO bytes =E2=80=94 indistinguishable from r=
eading
> conversion data, partially consuming any pending result and corrupting the
> stream. With num_resetclks =3D 0 on these devices a further hazard exists:
> if pending_event is set, the drain path attempts memset of SIZE_MAX bytes,
> corrupting the heap. The fix returns 0 immediately for registerless
> devices. This is safe for all current instances: AD7191 and AD7780 (with
> powerdown GPIO) are reset between conversions by CS deassertion; AD7780
> (without powerdown GPIO) and MAX11205 are continuously-converting and
> cycle ~DRDY regardless, so the next falling edge fires naturally. A future
> registerless device that holds ~DRDY asserted until data is read would
> need num_resetclks set or a rdy-gpio instead. The same heap corruption can
> be triggered on any device with rdy_gpiod set but num_resetclks =3D 0, so
> an explicit data_read_len =3D=3D 0 guard is added independently.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Hi Radu,

Applied to the fixes-togreg branch of iio.git and marked for stable.

Note that as this is all a bit fiddly in the ideal world I'd like some
more eyes on this and will be happy to add tags or indeed pull the patch
in response to any reviews in the next few days.

Sashiko is now 'happy' I think and it found a lot more issues than I identi=
fied
in earlier versions.

Thanks,

Jonathan
