Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423135B631;
	Fri,  8 May 2026 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243478; cv=none; b=Z2DHZyO01uqaLnfP588nKz8MQEuIt1JN4LJ5AVKadOj0UhN8Tw78kOT61ypddCKmnXdWukF9/ekbz7GUSs9BjidG7JQYOpozekAGRS8XDjlUtMq9luyo4IGyT2RSL/ld0FBLsg1QtonKHz7T8pYpKT3ZHQHQpx7tz26jGbk25Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243478; c=relaxed/simple;
	bh=I1PrI7weZ+jucZGEzpk/ecBuGTAVUE9Hz1sP93iV6sI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fi7NM49+KFgOF9bk2m5CXwRTWp8kWCrjUcNWzH8chLtxA6daqcxoqntRoFRwHvIlm/HymW8nFNvOkhAr8D93xZ90W2AYBMw8bs2PQxnv/5TvOF4P+VtVBVXIoUFR4YdI9EannQrZZfHOrUxoxr0sOy/HduTDkb09pyQLaW40F2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlOaZMLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlOaZMLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD01C2BCB0;
	Fri,  8 May 2026 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778243478;
	bh=I1PrI7weZ+jucZGEzpk/ecBuGTAVUE9Hz1sP93iV6sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DlOaZMLMee1gqcD1qiLokN2hgbK2Zo6+HVZEbkVULpnICv9Yzf8ZxgNXpGHcZFkRv
	 0tBYbnDa+9v5qjY5SCc1kV6lxV5I9RlrUQ715kGUpNiTATvVRjlV4+WcnSWhlCGZC1
	 EOhmfVIT6PFVS7AqScaxZQ1YVG1qbeVp6bopmr7yhUy4k1+ndXFhpqbnu/i3S6hSjH
	 3QgMACAnqnsIIGnEAUuhn4xAbxnzIiRFdYb3c0ofy4RSGmn/XD/k+tQbTWN0JlxwkD
	 o9kBmI3TrAFu7a/D/jyK7K0Cxp5TQJMjgAl62Dishl6AHWXsSxcpRWd9tVZyYY0X7j
	 uSCVXRTYf7n5A==
Date: Fri, 8 May 2026 13:31:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] MAINTAINERS: Update Analog Devices IIO drivers
 entry
Message-ID: <20260508133110.644e784e@jic23-huawei>
In-Reply-To: <20260507175132.3063161-2-sanjayembedded@gmail.com>
References: <20260507175132.3063161-1-sanjayembedded@gmail.com>
	<20260507175132.3063161-2-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  7 May 2026 23:21:31 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20
> Lars-Peter Clausen is currently busy and is therefore removed from the
> ANALOG DEVICES INC IIO DRIVERS entry, with input from Jonathan.
>=20
> Add Analog Devices mailing list as contact and Nuno S=C3=A1 as maintainer
> for the ANALOG DEVICES INC IIO DRIVERS entry for coverage support.
>=20
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Lars, assuming you are fine with this do you also want an entry
in CREDITS given your hard work on this all those years ago?

Whilst I feel one would certainly be appropriate entirely up to you
if you want one ;)

J

> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc42e1cacd6b..86b2520d18fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1861,8 +1861,9 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/dma/dma-axi-dmac.c
> =20
>  ANALOG DEVICES INC IIO DRIVERS
> -M:	Lars-Peter Clausen <lars@metafoo.de>
> +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> +L:	linux@analog.com
>  S:	Supported
>  W:	http://wiki.analog.com/
>  W:	https://ez.analog.com/linux-software-drivers

