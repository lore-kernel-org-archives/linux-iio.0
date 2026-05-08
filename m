Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E172F2607;
	Fri,  8 May 2026 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243826; cv=none; b=mZEHzOjF+ZFrnLlQK5qSGxntrqu/0WIecamkQY1x6mukHssb9XeRLndpCUQVfluokFy3o/pmKcF3Vthm4gJSRFNpgpp1aRN9h8UsjJDMtEvcB0Wwb11j1gGn/L9klLvt1eE3wwYkOK14NPnk8STmXIYiA3Z2JvPZnKZSFsdCgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243826; c=relaxed/simple;
	bh=dMIWcg84Ps/y5Wn5AybPuEpvHMUPCnAm2q1DlReTSKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjUYtunUHz+2FG4JfaWOOZUoZQJYvxhbv97hPOaBxHP/QVJyOIQFcrrsTEXvm8QLiSHfn4TsImka92jqfX9U2UgXZanqDPJIsxEmOJnB2VGYAAEsFcPEJOxCmuBFn7j1BU56XCNe5KSYOBrw27AAFix2WK5DqY8IA3Btaz3ogrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGWNopU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGWNopU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D62C2BCB0;
	Fri,  8 May 2026 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778243825;
	bh=dMIWcg84Ps/y5Wn5AybPuEpvHMUPCnAm2q1DlReTSKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kGWNopU/RfNy45NoVsTsLXvt6SIa6ZobxwgykyjK7gIU/wZkrqeZXMc7GTLorEMgP
	 2z4us38m2o2sBaVpe/xS0RbHVKYIWfrSOVCo+eDY5IfLHFvtASiLV3u3TGOPo3Pt2G
	 8XEbzvyxNxENyI8s+Ie4J4QWhjJXxWrp1Bog550IdN+NyKX1n01aYSo6s6PIQojhVF
	 YkFlVjWg49wcyziEZhyBJsaV7I9kbnow0T89Ug5Z2PD8l4cHCh/4hLVaNkZAemTUgp
	 PPaHo/HVRizx5cjbCLM77OibFtWyU6O0vQeTIStZnPISU4o20V8WO/v3wJxFZPeiKk
	 s1r8OLqCP7qxw==
Date: Fri, 8 May 2026 13:36:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, "Jonathan Corbet" <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>
Subject: Re: [PATCH v2 0/3] iio: dac: Add support for AD5529R DAC
Message-ID: <20260508133653.5c4f9169@jic23-huawei>
In-Reply-To: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 13:55:46 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> This patch series adds support for Analog Devices AD5529R, a 16 channel
> 16 and 12 bit voltage Digital-to-Analog Converter (DAC) with integrated
> precision reference. The AD5529R operates from both unipolar and
> bipolar supplies. The device communicates via SPI interface.

Hi Janani

Welcome to IIO.  Please slow down.  For a new driver convention is to
wait at least a week between versions so there is time for more reviews
to come in and hopefully reduce the total number of versions needed!
If you got feedback from Sashiko or other AI tools after posting then
feel free to address them in replies to your own series - they aren't
a reason to move faster with a new version.

Key for why we don't want too many versions is that those few of us
who review a lot of code very rarely manage to hold in our memories
what we checked on previous versions so tend to end up doing each version
from more or less scratch.  That means each version takes a non trivial
amount of review time.

Anyhow, you've sent this now so I'll review it but for v3 if needed
slower please!  If you have time and want to increase the chances
reviewers get to your patch, use it to review those of others. That is
is typically where our bottlenecks lie.=20

I've not been griping about this too much for the many cleanups on the
list at the moment because the overhead of those is smaller and also
I know some are students trying to get patches upstream in a finite
window.

Thanks

Jonathan

>=20
> **Device Overview:**
> The AD5529R features 16 independent DAC channels, with 16 or 12 bit
> resolution, allowing independently programmable output ranges. The
> internal 4.096V precision reference sets the accuracy of the output
> voltage.
>=20
> **Features Implemented:**
> - Automatic detection of 12/16 bit variant with product ID read.
> - Reset support via GPIO.
> - Dual regmap configuration to handle 8 and 16 bit registers.
>=20
> **Patch Summary:**
> 1. **dt-bindings**: Binding documentation with channel configuration.
> 2. **driver**: Implement IIO DAC Driver with regmap support.
> 3. **documentation**: Add driver documentation with usage examples.
>=20
> **Testing:**
> The driver was compiled and tested on the EVAL-AD5529R-ARDZ using a
> coraZ7 with a mainline v7.0 kernel.
>=20
> **Driver Rationale:**
> AD5529R introduces:
> 1. A unique register layout
> 2. Mixed 8-bit and 16-bit register accesses
> 3. Product ID based generic identification
> 4. Hardware specific features like function generators, multi-die
> hotpath registers etc.
>=20
> The device warrants its own drivers due to these fundamental
> architectural differences, that would require substantial changes to
> existing drivers without providing reusable benefits. The standalone
> driver also allows future extensions for related devices in the same
> family.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
> Changes in v2:
> - Fix IIO scale to use millivolts per ABI requirement
> - Fix documentation voltage calculations (2.5V not 2.048V)
> - Fix bipolar ranges in documentation (=C2=B15V, =C2=B110V, =C2=B115V, =
=C2=B120V)
> - Fix alphabetical ordering in documentation index
> - Add missing newline to documentation file
> - Fix scale units description (millivolts not microvolts)
> - Include a section for driver rationale in the cover letter
> - Reword contents in cover letter 12/16 bit generic->variant
> - Add dependency array for spi-cpha and spi-cpol properties
> - Link to v1: https://lore.kernel.org/r/20260507-ad5529r-driver-v1-0-b446=
0f3cb44f@analog.com
>=20
> ---
> Janani Sunil (3):
>       dt-bindings: iio: dac: Add AD5529R
>       iio: dac: Add AD5529R DAC driver support
>       Documentation: iio: Add AD5529R Documentation
>=20
>  .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   |  96 ++++
>  Documentation/iio/ad5529r.rst                      | 216 ++++++++
>  Documentation/iio/index.rst                        |   1 +
>  MAINTAINERS                                        |   9 +
>  drivers/iio/dac/Kconfig                            |  17 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/ad5529r.c                          | 564 +++++++++++++++=
++++++
>  7 files changed, 904 insertions(+)
> ---
> base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
> change-id: 20260507-ad5529r-driver-866bbdd864de
>=20
> Best regards,

