Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FC38F950;
	Sat, 17 Oct 2026 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260225; cv=none; b=D9EFqzpbaSPYI+ewyBJsiOBjJUWbQFcTsKrwD7c0srElO70N/NdvPBhc3ahcS+stB15+3C5prirTIsPXPt1uKWMd/E8pw0Zz8r8BQpaHvndZz/JF0fLYqRUZy58uvgUtGueh1x8Wi1/5WVOCWg0Uog6zV3HFJ7cNYQq91xYeRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260225; c=relaxed/simple;
	bh=DCm93Pp5AGmrkz6wgqf9B/Bj0h6ufC5XP8dotfL9rR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5vHzyuvTlmdYgxfenb0Mi9g0iM83d/CPeBRBg9+MvH01Sbic8zCzftFOSJKeKmojOrDVXrBMQwRagCw7RcKoKoj9jauzE3Ngsmx4B7btW0kQ9GLQfrHe4z40G4mE1l+mkp6eN/p/vtb2Mg5/u/jqyOkNMwFSr9QNsJ8M1Q08VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayBRZUGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayBRZUGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2310B1F000C5;
	Sat, 17 Oct 2026 18:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792260224;
	bh=tK4uOsFJUtazuxNs5JxzECC92CbCr3nkpTxjClesdM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ayBRZUGmLay8go7JfCvHOwd0d2ygjoR51tm0y3LzT/MiAOmof6TcltTtLbWmiNHND
	 NB4PrZr3AploA8gE4WWxFvinAXNN/m7BwhaenViJdpmU1zX5BX3Lcxq7mUuQg1ZWpt
	 6A6RLIJ3EBfsgW332EQ2R/kAqKCRQELSm2kAJThcRvbv1eOHCkZB8DFowNLS5Acr9k
	 tGJpoxV50IGLqdvxjtnfa7JAFhQ+Z09K7DlWdcAy2Vryd8s8/0GoyyNIrns6n3zeKk
	 kz413uIq4BaYAF2GrPdSq3fGbGNbU4UaF3BhuD5ssujpavnJEaemqAxaMW1i0eYY+1
	 LsCSZcXNAlisg==
Date: Sat, 17 Oct 2026 19:03:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] MSM8916-mainline: improve gp2ap002 proximity
 sensor v2
Message-ID: <20261017190339.1706f96d@jic23-hlaptop>
In-Reply-To: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Oct 2026 19:27:40 +0200
Christoph Rudorff <chris@rudorff.com> wrote:

> Samsung J5 is equipped with GP2AP002 proximity sensor.
> Unfortunally the driver wasn't working, no irq received.
>=20
> According to datasheet page 8 "Recommended external circuit",
> it can have tree supplies: vio, vdd and vled.
>=20
> It missed to power up the LED.
>=20
> I found this looking in downstream kernel, where
> several #ifdefs handled the case of 2 or 3 supplies.
>=20
> Now it works. Tested on samsung-j5:
>=20
> $ cd /sys/bus/iio/devices/iio\:device1
> $ echo 1 > events/in_proximity_thresh_either_en
>=20
> $ iio_event_monitor /dev/iio\:device1
>=20
> Event: time: 1791460068846871297, type: proximity, channel: 0,
> evtype: thresh, direction: rising
>=20
> Event: time: 1791460068876669724, type: proximity, channel: 0,
> evtype: thresh, direction: falling
>=20
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
> ---
> Changes in v2:
> - reorganized patch serie
> - gp2ap002: use regulator bulk framework
> - Link to v1: https://patch.msgid.link/20261016-iio-light-gp2ap002-v1-0-7=
c93312fa8d5@rudorff.com
>=20
> To: Linus Walleij <linusw@kernel.org>
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konradybcio@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
>=20
https://sashiko.dev/#/patchset/20261017-iio-light-gp2ap002-v2-0-d6879767a44=
6%40rudorff.com

Spotted stuff I missed.

J
> ---
> Christoph Rudorff (3):
>       dt-bindings: iio: light: gp2ap002: add vled
>       iio: light: gp2ap002: add led power supply
>       arm64: dts: qcom: msm8916-samsung-j5: Add proximity sensor
>=20
>  .../bindings/iio/light/sharp,gp2ap002.yaml         |   4 +
>  .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   |  15 +++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    |  32 +++++++
>  drivers/iio/light/gp2ap002.c                       | 101 +++++++++++----=
------
>  4 files changed, 106 insertions(+), 46 deletions(-)
> ---
> base-commit: a2de78ee6ed8bf8cd99d177c74865a6e8c3cb6ea
> change-id: 20261016-iio-light-gp2ap002-6bd553aecb4b
>=20
> Best regards,
> -- =20
> Christoph Rudorff <chris@rudorff.com>
>=20

