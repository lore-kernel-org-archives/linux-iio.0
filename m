Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E28211A09;
	Fri,  3 Jul 2026 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103465; cv=none; b=ke0lzUYj3q+V4a8rpcXiDguVgbcvBAL5IZZck6qs4YLaOpBarPqvq+uSiGlka1677Po2ZJtSUwmUYXus44SIhLgTVBeQnjtw4ty+qFBxG8AIHRLhdhVquaICA2Pdyx/L4BuAoG3ZNIwXvlAsMMkynyGKLn0U0gggBxfnaKvbcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103465; c=relaxed/simple;
	bh=yhdnVhATfUwD1M3Ikk0EG9oJWo47ExKIa5EBNyHKoiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNJMdQv1m3COBTFkQpGfyyRm4g9C26TlJMtps8oTv1xApHoVHM0dO3byXLQXnvenrm82sTFWYV9jeuWpdDEZoj0U6FBJDH9JQ9jNFNEXTv9GRdo8XnkNLZf3mNpvi/g7RL0aj008zfWce2cu+zkLrQDrUwVR7ErlgbZ4xVgv5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh7LE2Bx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh7LE2Bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E874B1F000E9;
	Fri,  3 Jul 2026 18:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103463;
	bh=KN5gnCrTvXlQKADtvfFNfjZWzryi8/4lXgAOtCX+ku8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hh7LE2BxsISAzUMxnMRULUY6kWlb20xxmjlyKM50W1ZgFaRK1dDZ5/Z1Zi1M4mnWJ
	 SZFMTPwH8by+yiGQQb98T/Te5OMVPHKS9932Tn2aZuQZp1py9dcSVPXOZ5dUsAlRNq
	 u2ANd4HGKHel/vm4hqFSoK4fnZuQ5k6s1b+IVEQfmq3TL/lXmDsAhPWCH5jDYhiE1f
	 S+y1i6J2i/5pkiGQLJey7u1sxahFR+TdWwF45UXxSnJ/4iJ8VyH8rVhHw766gerB4+
	 BCXe1ogJFIFhssFCnLJQzP6N3rdfJBLbC/b8sySgiMo/JK60EtYJh2zI84ghLlzVe/
	 yaAkoCs8n1a3Q==
Date: Fri, 3 Jul 2026 19:30:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 16/16] docs: iio: add documentation for ad9910 driver
Message-ID: <20260703193059.4deda617@jic23-huawei>
In-Reply-To: <20260618-ad9910-iio-driver-v6-16-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-16-79125ffbe430@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jun 2026 14:27:32 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org=
> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> DDS modes, attributes and ABI usage examples.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/iio/ad9910.rst | 759 +++++++++++++++++++++++++++++++++++++=
++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 761 insertions(+)
>=20
> diff --git a/Documentation/iio/ad9910.rst b/Documentation/iio/ad9910.rst
> new file mode 100644
> index 000000000000..113521fead3e
> --- /dev/null
> +Single Tone mode
> +----------------
> +
> +Single tone is the baseline operating mode. The ``profileY`` channels
> +provide enable, frequency, phase and amplitude control:
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``en``
> +     - boolean (0 or 1)
> +     - Enable/disable profile Y. Only one profile can be active at a
> +       time. When enabling a profile it disables the current active prof=
ile.
> +       Disabling an active profile brings the device to a powered down s=
tate.
> +
> +   * - ``frequency``
> +     - Hz
> +     - Output frequency. Range :math:`[0, f_{SYSCLK}/2)`. Stored in the

Probably spaces around the / for consistency.

> +       profile's frequency tuning word (FTW).
> +
> +   * - ``phase``
> +     - rad
> +     - Phase offset. Range :math:`[0, 2\pi)`. Stored in the profile's ph=
ase
> +       offset word (POW).
> +
> +   * - ``raw``
> +     - integer
> +     - Amplitude scale factor code. Range :math:`[0, 16383]`. Stored in =
the
> +       profile's amplitude scale factor (ASF) register. The physical out=
put
> +       amplitude is ``raw * scale`` where ``scale`` is read from the ``p=
hy``
> +       channel.

...

> +Digital ramp generator (DRG)
> +----------------------------
> +
> +The DRG produces linear frequency, phase or amplitude sweeps using dedic=
ated
> +hardware. The active ramp target (destination) is selected by enabling t=
he
> +corresponding typed channel at channel number 130:
> +
> +- ``out_frequency130`` (label ``drg_frequency``) =E2=80=94 ramp targets =
frequency
> +- ``out_phase130`` (label ``drg_phase``) =E2=80=94 ramp targets phase
> +- ``out_altcurrent130`` (label ``drg_amplitude``) =E2=80=94 ramp targets=
 amplitude
> +
> +Writing ``en=3D1`` to one of these channels enables the DRG and switches=
 its
> +destination. Writing ``en=3D0`` disables the DRG if the channel is the c=
urrent
> +active destination; writing to an already-inactive destination is a no-o=
p.
> +
> +Each destination channel also exposes a read-only ``scale`` attribute
> +reporting the physical quantity per ramp register LSB, which allows conv=
erting
> +raw limit codes to physical values.
> +
> +The two ramp channels ``out_altcurrent131`` (``drg_rising``) and
> +``out_altcurrent132`` (``drg_falling``) configure ascending and descendi=
ng
> +ramp parameters independently.
> +
> +Destination channel attributes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``en``
> +     - boolean
> +     - Enable the DRG with this channel as the active destination. Only =
one
> +       destination can be active at a time.
> +
> +   * - ``scale``
> +     - Hz/LSB, rad/LSB or mA/LSB
> +     - Read-only. Physical quantity per raw units. Multiply a ramp
> +       rising/falling channel ``raw`` value by this scale to get the phy=
sical
> +       ramp target.
> +
> +Ramp channel attributes
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``dwell_en``
> +     - boolean
> +     - Enable dwell at the ramp limit. When disabled, the ramp
> +       auto-transitions at this limit without waiting for the DRCTL pin.
> +       Disabling both creates a bidirectional continuous ramp (triangular
> +       pattern). Other combinations create single-shot ramps at the DRCTL
> +       pin transition.
> +
> +   * - ``raw``
> +     - integer (64-bit)
> +     - Ramp limit expressed as a raw DRG register code in
> +       :math:`[0, 2^{32}-1]`. The physical value is ``raw * scale`` where
> +       ``scale`` is read from the active destination channel.
> +
> +   * - ``sampling_frequency``
> +     - Hz
> +     - Ramp clock rate. Controlled by an integer divider; the written va=
lue
> +       is adjusted to the nearest supported rate.
> +
> +   * - ``raw_roc``
> +     - /s
> +     - Rate of change. Number of register codes advanced per second, com=
puted
> +       from the hardware step size and the current ramp clock. Writing
> +       requires ``sampling_frequency`` to be configured first.
> +
> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Configure a frequency sweep from 40 MHz to 60 MHz with a rate of change =
of
> +25 GHz/s:
> +
> +.. code-block:: bash
> +
> +  # Disable dwell on both limits for a bidirectional continuous ramp
> +  echo 0 > /sys/bus/iio/devices/iio\:device0/out_altcurrent131_dwell_en
> +  echo 0 > /sys/bus/iio/devices/iio\:device0/out_altcurrent132_dwell_en
> +
> +  # Set ramp rate at 250 MHz
> +  echo 250000000 > /sys/bus/iio/devices/iio\:device0/out_altcurrent131_s=
ampling_frequency
> +  echo 250000000 > /sys/bus/iio/devices/iio\:device0/out_altcurrent132_s=
ampling_frequency
> +
> +  # read the frequency scale to convert physical values to raw units
> +  cat /sys/bus/iio/devices/iio\:device0/out_frequency130_scale
> +  0.232830643650
> +
> +  # 40 MHz / 0.232830643650 =3D 171798692
> +  echo 171798692 > /sys/bus/iio/devices/iio\:device0/out_altcurrent131_r=
aw
> +  # 60 MHz / 0.232830643650 =3D 257698038
> +  echo 257698038 > /sys/bus/iio/devices/iio\:device0/out_altcurrent132_r=
aw

Why is this writing frequencies to altcurrent channels? Shouldn't this be t=
he
frequency ones?

> +
> +  # 25 GHz/s / 0.232830643650 =3D 107374182402
> +  echo 107374182402 > /sys/bus/iio/devices/iio\:device0/out_altcurrent13=
1_raw_roc
> +  echo 107374182402 > /sys/bus/iio/devices/iio\:device0/out_altcurrent13=
2_raw_roc
> +
> +  # Enable the DRG with frequency as the destination
> +  echo 1 > /sys/bus/iio/devices/iio\:device0/out_frequency130_en
> +
> +RAM mode
> +--------

...



> +
> +.. code-block:: bash
> +
> +  echo 1 > /sys/bus/iio/devices/iio\:device0/out_altcurrent100_powerdown
> \ No newline at end of file
Tidy that up.

Thanks,

Jonathan
