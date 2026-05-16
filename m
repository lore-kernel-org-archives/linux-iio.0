Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C13E3162;
	Sat, 16 May 2026 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944305; cv=none; b=E6yd05chd0wI0mUkFBH0Lt30luOBOzsEEaFTeY0JRRNGDk74d4T4ceQtA5Y83hJH7ro7Yze34msJNY3XBdioE+4O1B8+im2sF0CU2lUi0Dk2HkT8szEyk4NlGjfikx6+1Vg2bl5K07wfIf319+wXXGlpWm9tN8O6l0+O41aHiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944305; c=relaxed/simple;
	bh=lg0rxOCQCLqVZWSQOLYhY0Pgw1UG8QKlLFT66nXg4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJr6801XY28WvxotF68VI7H3yUA89DqMb7ib9H5XPBwyDJqzNn+5NqVCTSvaMrKi+rteEHXBIbQuJxpf/HGVASUcKXGSysLCEAikynq9zhqveoxAcwyjzpT21EGfleGejpPnqANzFzWXvVRxmXGjOdbGSTtR8agp678M08scgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU1UZoDV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU1UZoDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596EEC19425;
	Sat, 16 May 2026 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778944304;
	bh=lg0rxOCQCLqVZWSQOLYhY0Pgw1UG8QKlLFT66nXg4pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gU1UZoDVy19Pq3Edyqd3E3hghl0X0D51BZtWufEL/1oSmP1iF+9FwKYIpIn9mJQJ7
	 Bk2n8NFI3SYgZM+9NsQyjR+K0koZs9vobLisKzAheWcy/RBzWT51YuiFsYPl+feVnM
	 /Qgp12WQdwMR3mv0YeHGWQcZLC4eO8c4O7AiqQTWy0kSOWdhL7M3E3oVqbL5EfSgDs
	 QUw4P1apzogbuG3hNhHsDfAYRvBk/IIhdqw/OZLOOPDY7j+yvt5dMSUH9Miuz/Wsqz
	 riRhtTZiAVJeV3jLPpw5tHTFexJMuKqqt8CHO4JUdTXjdJgrZqUpvE1GkElDBAEqd1
	 xx40wphMHeTVA==
Date: Sat, 16 May 2026 16:11:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai
 <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v3] iio: adc: sun20i-gpadc: support non-contiguous
 channel lookups
Message-ID: <20260516161134.0fc1ad10@jic23-huawei>
In-Reply-To: <20260516-fix-sunxi-gpadc-sparse-channels-v3-1-4d229d18ff3b@mmpsystems.pl>
References: <20260516-fix-sunxi-gpadc-sparse-channels-v3-1-4d229d18ff3b@mmpsystems.pl>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 May 2026 07:48:37 +0200
Michal Piekos <michal.piekos@mmpsystems.pl> wrote:

> Using consumer driver like iio-hwmon which resolve channels through
> io-channels phandles will fail for sparse channels because IIO core by
> default treats phandle argument as index into channel array.
>         eg. <&gpadc 1> will fail if there is only channel@1 specified
>=20
> Add .fwnode_xlate() which maps DT phandle to the registered channel
> whose chan->channel matches the hardware channel number. It allows
> sparse channel maps to be consumed by drivers like iio-hwmon.
>=20
> Tested on Radxa Cubie A5E.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Add iiospec->nargs validation in sun20i_gpadc_fwnode_xlate()
> - Keep Andy's Reviewed-by tag since change is narrow validation fix
> - Fix spelling issues in commit message
> - Link to v2: https://patch.msgid.link/20260514-fix-sunxi-gpadc-sparse-ch=
annels-v2-1-d4a66b70c7a7@mmpsystems.pl
>=20
> Changes in v2:
> - Move loop variable declaration into the for statement
> - Fix indentation using clang-format
> - Correct commit wording
> - Link to v1: https://patch.msgid.link/20260513-fix-sunxi-gpadc-sparse-ch=
annels-v1-1-6c21e290bcee@mmpsystems.pl
>=20
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Chen-Yu Tsai <wens@kernel.org>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Samuel Holland <samuel@sholland.org>
> To: Nathan Chancellor <nathan@kernel.org>
> To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> To: Bill Wendling <morbo@google.com>
> To: Justin Stitt <justinstitt@google.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: llvm@lists.linux.dev
> ---
>  drivers/iio/adc/sun20i-gpadc-iio.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-=
gpadc-iio.c
> index 861c14da75ad..8a75498557ff 100644
> --- a/drivers/iio/adc/sun20i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> @@ -139,8 +139,23 @@ static irqreturn_t sun20i_gpadc_irq_handler(int irq,=
 void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> +static int
> +sun20i_gpadc_fwnode_xlate(struct iio_dev *indio_dev,
> +			  const struct fwnode_reference_args *iiospec)
> +{
> +	if (iiospec->nargs !=3D 1)
> +		return -EINVAL;
> +
> +	for (unsigned int i =3D 0; i < indio_dev->num_channels; i++)
> +		if (indio_dev->channels[i].channel =3D=3D iiospec->args[0])
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info sun20i_gpadc_iio_info =3D {
>  	.read_raw =3D sun20i_gpadc_read_raw,
> +	.fwnode_xlate =3D sun20i_gpadc_fwnode_xlate,
>  };
> =20
>  static void sun20i_gpadc_reset_assert(void *data)
>=20
> ---
> base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
> change-id: 20260513-fix-sunxi-gpadc-sparse-channels-2b6b2063bd49
>=20
> Best regards,
> -- =20
> Michal Piekos <michal.piekos@mmpsystems.pl>
>=20
>=20

