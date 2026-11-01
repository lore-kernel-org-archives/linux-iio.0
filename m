Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793497779;
	b=KIceVMWZ2xpoP9GsGKT7HnzJFPEfLIjsWT97cXFg++HWO/6Qfm4X14HhPjimVmOJZQ7T
	 fDalmLsor4b1nlHISGgus4i6BvTK6TsSlW/YFo74CjgFlIA84UVcqFe1OiaysUrAUsNyl
	 VdlBxllIzXfymjnd2xtjHBXOSCvYAF4DeFEeFLqjnoMhk/cwt0G7znetjmYthzpcpMDt+
	 s/tsD36gKypnLHSx3ji6SjMVebJwhUFpgvcwqva5l+gEC36aiEZ139Ht+DpfmNls08tCs
	 /DOqpD8qU7TM10WIhMdTAMirc+6lknGTM3UVnxuzo1QuhwslyY0YYpUxxYLm+Y6EJeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793497779;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NLPHjAXnjyuMTdfzoDtQeuMq7VGsQqOCv+QqYzkDD0M=;
	b=EWO7ROSJ1V7Zkh/dCfnUadknjzlMxKfmf/1+vnK7f270iQZSSAUFS6ynT7eBK4TktWSf
	 BXPOiu4z3RygTSyAjINRVtviQOQACV/33woQwfY2JZdxyijursdKt9qrqxfxGleKTkhzR
	 DUY8/jBhf/9eihCqnx3qkZI+mx52FJ6TXAkIqYAY2aR9Se6iqdxzUMiCOoENqgtEJbgIV
	 D9aKuvp1B96VmGEwjQc8WT8msfb5odzrQWAmcHYc7P4koq0IwUGUqys3anZBeOjZoFOjo
	 37wIN0k7wtHbi5K30UfSRtOjpSTWokKOQq+PrdIGH1/X2tgHshWmy+h/aONIFI+GDIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdvZPlnA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592D606A324;
	Sun,  1 Nov 2026 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdvZPlnA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4068B1F000C1;
	Sun,  1 Nov 2026 01:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793497778;
	bh=NLPHjAXnjyuMTdfzoDtQeuMq7VGsQqOCv+QqYzkDD0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VdvZPlnAX2kZker4vaxAXk7QW6Loi5C0hOLs4lGN7kLjh/k6oBTkW5TlcCyG/lE/3
	 uNXECFBiwPgvyYIrWh7TD4JZo5wZm1Fnj3IjeNL4JmIEyvQMigzns4a6lK1FCm/R7Y
	 1Svytth2/hcySiRU2vU9eXWdDpuwiwiOMRGyiPHVpub2pc75sOPhT2fnzqSLBUErrW
	 I46YCqFOGvr9sLC4yZzfb1KgNVWvEmyfCylQxtoYt0MSBTrgV3g1p3OClz80LqyEuC
	 iCZMbnqwjoZ+ec8H87PCWXwLiDGwH3LDWxQhfO4gzU/+lC6+zFBGDM/p8PwyepimCk
	 u7Zc6TsYeQqjg==
Date: Sun, 1 Nov 2026 01:49:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici via B4 Relay
 <devnull+andrei.stancovici.analog.com@kernel.org>
Cc: andrei.stancovici@analog.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/4] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Message-ID: <20261101014935.411c75af@jic23-hlaptop>
In-Reply-To: <20261029-submission-ltc2493-support-v1-v3-0-c7dd5f877c3b@analog.com>
References: <20261029-submission-ltc2493-support-v1-v3-0-c7dd5f877c3b@analog.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2026 00:24:25 +0200
Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel=
.org> wrote:

> This series adds LTC2493 support to the ltc2497 driver, and adds FA/FB
> line-frequency rejection for the LTC2499 and the LTC2493.
>=20
> It includes:
> - the LTC2493 device-tree binding,
> - FA/FB line-frequency rejection (50Hz, 60Hz, or both) exposed via
>   filter_mode, implemented in the core and enabled for the LTC2499,
> - a preparatory refactor giving each supported channel layout a channel
>   set in the core, referenced directly from chip_info,
> - LTC2493 support in the driver: 4 single-ended inputs or 2 differential
>   pairs, 24-bit result, same command format as the LTC2499, the internal
>   PTAT temperature channel, the 2x conversion speed mode exposed via
>   sampling_frequency, and the same rejection selection.
>=20
> The rejection patch also adjusts the conversion wait time for each
> rejection mode. The 50Hz-only mode takes up to 163.5 ms at 1x, while the
> previous fixed 150 ms delay only covered the default 50/60Hz mode.
>=20
> Validated on a Raspberry Pi 4 running 7.3.0-rc4, over an IIO network
> backend, with a DC1010A-A board (LTC2493), a DC1012A-A board (LTC2499)
> and an LTC2497:
> - LTC2493: 41/41 hardware tests passed,
> - LTC2499: 36/36 hardware tests passed,
> - LTC2497: 24/24 hardware tests passed,
> - all LTC2493 rejection x speed combinations were exercised without
>   conversion or I2C errors.
>=20
> LTC2496 was build-tested only because no LTC2496 hardware was available.
>=20
> The source in this series matches the hardware-tested tree.
>=20
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
I've somewhat speculatively picked this up on basis it looks fine to me.
However, there is still time for additional review from Nuno or others
as, whilst I'll be rebasing shortly on rc1, I probably won't push out as not
rebasing until second half of the week.

So applied to the testing branch of iio.git

Thanks,

Jonathan


> ---
> Changes in v3:
> - The channel-set selection moved into a preparatory patch, so the patch
>   adding the LTC2493 no longer touches the chip_info of the parts
>   already supported (Nuno S=C3=A1).
> - chip_info now references a per-device channel set directly. The
>   num_inputs field and the keyed lookup it was matched against in probe
>   are both gone (Nuno S=C3=A1).
> - The LTC2493 patch is reduced to the device-specific additions.
> - The binding and FA/FB patches are unchanged. Nuno S=C3=A1's Reviewed-by=
 is
>   added to the FA/FB patch.
> - Behaviour revalidated on hardware on all three parts; see the
>   validation summary above.
> - Per-patch changelogs are under the --- of each patch.
> - Link to v2: https://patch.msgid.link/20261022-submission-ltc2493-suppor=
t-v1-v2-0-391d908d2877@analog.com
>=20
> ---
> Andrei Stancovici (4):
>       dt-bindings: iio: adc: lltc,ltc2497: add LTC2493 support
>       iio: adc: ltc2497: add FA/FB line-frequency rejection selection
>       iio: adc: ltc2497: select the channel set per device
>       iio: adc: ltc2497: add LTC2493 support
>=20
>  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   7 +
>  drivers/iio/adc/ltc2496.c                          |   1 +
>  drivers/iio/adc/ltc2497-core.c                     | 208 +++++++++++++++=
+-----
>  drivers/iio/adc/ltc2497.c                          |  47 +++--
>  drivers/iio/adc/ltc2497.h                          |  44 ++++-
>  5 files changed, 243 insertions(+), 64 deletions(-)
> ---
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> change-id: 20261009-submission-ltc2493-support-v1-86449ede432d
>=20
> Best regards,
> -- =20
> Andrei Stancovici <andrei.stancovici@analog.com>
>=20
>=20

