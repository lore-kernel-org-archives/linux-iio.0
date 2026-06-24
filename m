Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759F399CFD;
	Wed, 24 Jun 2026 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323426; cv=none; b=f4+urrbmApc4GTCf/+4PsVndUIajJLfieBljFTrZoBJ3a3j9zfuAnWHuTXB0vqpjX7ce/HwxYc3fFfGOaGT/xe+80dy4DwwkzUQQ/OP+qEM6VaE3o5YZbBUIt5CwUvACynbSjyNBcvnBAEBdlRBQJwUzoDsyZPcF2jNoIxQYhxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323426; c=relaxed/simple;
	bh=aAY9edTK8lFtYA3ZLHy3gApMQYyErzjc1pAoqQI9vxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPRgmcGF1vqop1T+tJPr8m0tPODm2pLt9iQDwznUuL+ersxBKrElrvO6pwo5L3JsUBpJGnCL43Q1p82KabksbR7/ItgLFwAmULozXupqYEKHCWBKQwYF1xE+Wa3a7C50j/aBz/0ZL2ON1+4KWhzCD+ChUJk6He5iOvIbmJsPFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQvwIk/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQvwIk/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0131F000E9;
	Wed, 24 Jun 2026 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323425;
	bh=aAY9edTK8lFtYA3ZLHy3gApMQYyErzjc1pAoqQI9vxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HQvwIk/efX0TVSwkB5rthB3CdOyKESLUtY1hD2yoJPB6PnnHhteh5aI5IW5InVGp5
	 7UZb6jyNdamrCwMPkDC8+SfSWxgna9H8W0JAEOWw1xSnRurv/YZgjQ//6duOAT67po
	 gXjtiOYTiXKdulfbGp0y2UCCaeqO4DLioVky6bO/BdjRSqRkFWHH7am7lAumVYRMTA
	 +Nk+sigcYLZwvWQ/8HtqzilO9YHMCEw/rvePr5nrZEn0dTBJhco1bfOf2BdR/llA6C
	 GSSokvQNpHCdftgxCFlQaO39uj1+dh1XceZTIqTOBciwWMpdfQDX7LuMSe4KGzpWSu
	 AdU7mx2XODAaQ==
Date: Wed, 24 Jun 2026 18:50:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] iio: accel: bmc150: Explicitly set spi
 .driver_data
Message-ID: <20260624185017.649ddfe7@jic23-huawei>
In-Reply-To: <2f0bfff94332c5d42f29b33556bb6ba95935408d.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<2f0bfff94332c5d42f29b33556bb6ba95935408d.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 17:54:37 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> There is one id entry that has an explicit assignment to .driver_data.
> To make the intention clearer, assign BOSCH_UNKNOWN (which is also 0)
> for all previously ids that had .driver_data =3D 0 implicitly before.
>=20
> While touching all entries in this array, convert to named initializers.
>=20
> This change is similar to commit e50856dc41e8 ("iio: accel: bmc150:
> Explicitly set .driver_data") but cares for the driver's spi part
> instead of i2c.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied.
