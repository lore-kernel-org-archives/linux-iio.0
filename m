Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A213DD849;
	Wed, 24 Jun 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323669; cv=none; b=rn8MlqGlL+nxcKAUVBtlW1bOzLk2DpT6EMnmwdXNQ8pxybKGj6pBc2OwcZg6lMlu0rf78pTZG7+jSWwPzUVw5+bFWeQm5GlLuYD/9IdY1p3pxcEw7o8dEDt25htqzjCIDdE13yHXNX0TkCq+dedizG3N1rnoQKsbKHsHB3gLViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323669; c=relaxed/simple;
	bh=ALBEtwjepZqlEbvrclu6P3MtoEUruOZOfzgtaoZhits=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY1Yr3au7n/Es+O5u62tVkQBcdFkWNVNte5E3pWvZhOWBgPjPWRKxM/q4O5Z6xbfM/c7Bk/BrSxYkJMGijpq0NcMVB1tafIu//YE8GpiAqRaJOH69qdVQj5NviqPM+d4kX9cJP6/mzONCc4w+SdKWmd3fW78hiZuzuTs7982Ud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA/YsN+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA/YsN+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1E51F000E9;
	Wed, 24 Jun 2026 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323667;
	bh=TjsxU9uavoJeT1Hb5q4NRfJ2a188WNAmBO8+ox9rIlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gA/YsN+W+i3r7tNWNKOOu2tDCDiGhJCEZfv034+L3j48JokoETP/POr9AidK6hwSC
	 0ltSuy+vxSIZzrsvM5HjqoAL7T0kD8LgJtewQqsXyx9R6RRRc7rQg0Bi+TjLNF0Ywg
	 aKc+dHbL1HqldwjA2DBuh4yoSd4dh/JP7n3OvRqfWNw4gHyhFAiOqNgmyLR99pVhtc
	 G4upxU0bGNWfdByZRjnFLl6WCACrLSOb3vR6sJdzHp2a0o0gH+wfkqeIv3/5evkAdi
	 bpnPs+4Um94frnv9mNg0+A1hs1UbGjRq8a9LgcvR4NApA/vXt4JXINy0D04/zL/03j
	 zV2M4CimTbU+A==
Date: Wed, 24 Jun 2026 18:54:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/13] staging: iio: Initialize spi_device_id arrays
 using member names
Message-ID: <20260624185419.27db9ef9@jic23-huawei>
In-Reply-To: <cac7a68e6a6adb1b58207640ab045e59eec86f53.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<cac7a68e6a6adb1b58207640ab045e59eec86f53.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 17:54:41 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> spi_device_id that replaces .driver_data by an anonymous union.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied.  So that leaves the pair related to Andy's comment and that ADI IM=
U for
a v2.

Thanks for your hard work on this.  I merged it fairly quick because
I know we are going to have some merge conflicts (mostly other folk
tidying up individual drivers as part of more complex changes)

Jonathan
