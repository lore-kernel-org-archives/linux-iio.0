Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009623C4FF;
	Mon,  4 May 2026 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913015; cv=none; b=Go5MWzIAlMobY/3S8HSmUALa63m/EDfK84E9Kw5YbLDaAiR81gIRypjqg95ocm3UhFXocGfcMv8jPpDmURGW9OaGCoiex0xwDmSF2pO3Rq0y/TOaaD3PCYuBYrid56a0s6YrV9e+Jo5kUDyDIGk1sYKkwFyA1vPBCHlLAqV/ojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913015; c=relaxed/simple;
	bh=B6ZFSqSTUXQcW+fKeUOE8k3qjBTPzp5qcmr/o10xp0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhGvhw67tUG9pkUklDyp1WH9lxWLkoEDbJce1oVZjqXm6ReHOL7rjHXGeHVmSdsMpLl34QzsUPauWFUvVb6WWHMeOASwQ80oe+hv7+2niO0Vfihs0N00KTurRnUt78y3BoRNNn/PfD1tiUsy4gkyutzuesmXQgPGDGdD6pEpAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0t49XDu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0t49XDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC2CC2BCB8;
	Mon,  4 May 2026 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777913014;
	bh=B6ZFSqSTUXQcW+fKeUOE8k3qjBTPzp5qcmr/o10xp0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m0t49XDuOFv2UWzldgqFek1CiL2U9UQce7e+Sit4z+/Pb0Vhzht8gLRiKToi7+ww0
	 w9LsPUNSIJcaeMSbXmBCBk2n8PPveEINTkvt9GOe3jsODegOhCjHK1L9KWPdwhp9mN
	 9pFf6c9+jYJJe/coYsAOXzvcv1trpvS5rxFnPvolujrDRmZ6VoBNymCmVWcE/OU6Uh
	 lMqIaEnTdHrsyzhk8hx2O9MO3aVmRS+mcz3qjPp4oDKexXZwpH6NSZfc41R8WvujhT
	 r5ekfAQ7Vlo2W0rClNdrlS+Bm0nfXyOYXfFc+1y3EEZh+pB5vimyBRiwS3DeBlmQ53
	 VgTkD4/3k7xCw==
Date: Mon, 4 May 2026 17:43:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wang Zihan <jiyu03@qq.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] iio: adxl313: fix typos in documentation
Message-ID: <20260504174326.353b6f02@jic23-huawei>
In-Reply-To: <tencent_EC262467CD5E46CA97CF2B2FDCBCA0565C08@qq.com>
References: <tencent_EC262467CD5E46CA97CF2B2FDCBCA0565C08@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat,  2 May 2026 14:07:00 +0800
Wang Zihan <jiyu03@qq.com> wrote:

> Add missing space in "ADXL313is" and correct "a single types"
> to "a single type".
>=20
> Signed-off-by: Wang Zihan <jiyu03@qq.com>
> ---
>  Documentation/iio/adxl313.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
> index 966e72c01..3662153a6 100644
> --- a/Documentation/iio/adxl313.rst
> +++ b/Documentation/iio/adxl313.rst
> @@ -11,7 +11,7 @@ This driver supports Analog Device's ADXL313 on SPI/I2C=
 bus.
> =20
>  * `ADXL313 <https://www.analog.com/ADXL313>`_
> =20
> -The ADXL313is a low noise density, low power, 3-axis accelerometer with
> +The ADXL313 is a low noise density, low power, 3-axis accelerometer with
>  selectable measurement ranges. The ADXL313 supports the =C2=B10.5 g, =C2=
=B11 g, =C2=B12 g and
>  =C2=B14 g ranges.
> =20
> @@ -112,7 +112,7 @@ apply the following formula:
>  Where _offset and _scale are device attributes. If no _offset attribute =
is
>  present, simply assume its value is 0.
> =20
> -The ADXL313 driver offers data for a single types of channels, the table=
 below
> +The ADXL313 driver offers data for a single type of channels, the table =
below

ooh. That's fun grammar.  Intent is that there are multiple channels of one=
 type
but the form used in your corrected version is at best unwieldy given plural
singular mix.  "a single type of channel" is fine for instance but this isn=
't really.

I'd rewrite as
The ADXL313 driver offers data for multiple channels of a single type.  The=
 table
below...
(so split he thing up into two sentences as well).


>  shows the measurement units for the processed value, which are defined b=
y the
>  IIO framework:
> =20

