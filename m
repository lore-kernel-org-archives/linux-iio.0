Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98712CDBE;
	Fri,  8 May 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245241; cv=none; b=c7qn2Y0IV+GkB+aUC8ai5uUkLurmfra/NQLMGgkCMVc9ZAO0BjNsCxK7utJ/Zhi1zsIkjUiUqIx5EN/47IuzCYXSYG08GacUqEREA9IRwLKANhX7Ya072PNAAHOskPuGAjpv2Wob3vAITqMoLzdc0HDxprEtt9Asyuwq86HIJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245241; c=relaxed/simple;
	bh=re/YCULUu6tGnA/O7SIf/Dx9dxmK01n3tOp6OgsvpnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUVRI3kuX06y216sXBvhSAj6Rg51pmsgu18FkzNmuAHesCTTfFMb/Fk+TXEHaFY/8c5NyoLlFQf5TRpN6fOr1lctRtcec0kji/+0yE61J0QWWTGHCpPjoqVecL56F/b1QFWNV2MJa+CtGIAIngYAt0xmEGZ3rU2keo7sDBmdW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l50hbpG4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l50hbpG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5DBC2BCB0;
	Fri,  8 May 2026 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778245240;
	bh=re/YCULUu6tGnA/O7SIf/Dx9dxmK01n3tOp6OgsvpnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l50hbpG42jMEAHGl3U512HWNxAykjY20vAjOrb5w82bEirqfdyW7UOFR986NmHaHP
	 Ab5MH15k5LOQoIW80Ih0LAKG7s2kkgU9E99hlxIyS1J9FKAa//1RUAxZwTceT4M85M
	 U33BE7DjiNQqGDh6ANWTjvFN1gFA5kmZogCVOQUQqSjnIr5CKiSwLvbj3GpbUuZ9hE
	 T+ZeeiccZMOM+pSgaMkdRecV/n7GpiJnNcpAbSHE2SIa3bzfmeJ/v+yAJfv5txMdJs
	 wILMhP109ZwRjueZ/BN9slaZo9BGkis0uA6eRtE7G57KPRvTaej7dlZEVJXofEEaJK
	 mVQyKTNUwnm7Q==
Date: Fri, 8 May 2026 14:00:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Janani Sunil
 <jan.sun97@gmail.com>
Subject: Re: [PATCH v2 3/3] Documentation: iio: Add AD5529R Documentation
Message-ID: <20260508140029.35ff63b0@jic23-huawei>
In-Reply-To: <20260508-ad5529r-driver-v2-3-e315441685d7@analog.com>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
	<20260508-ad5529r-driver-v2-3-e315441685d7@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 13:55:49 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add documentation for AD5529R high voltage, 16-channel 12/16 bit DAC
Whilst it is good to have documentation for devices - I've made some
comments below on not providing documentation of standard things (too much
duplication) and being careful to work out who the document is for.
These tend to be for users and board integrators etc so we don't tend
to have much about the internals of the driver.  For that see driver!

Jonathan

>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  Documentation/iio/ad5529r.rst | 216 ++++++++++++++++++++++++++++++++++++=
++++++
>  Documentation/iio/index.rst   |   1 +
>  MAINTAINERS                   |   1 +
>  3 files changed, 218 insertions(+)
>=20
> diff --git a/Documentation/iio/ad5529r.rst b/Documentation/iio/ad5529r.rst
> new file mode 100644
> index 000000000000..41fea1521790
> --- /dev/null
> +++ b/Documentation/iio/ad5529r.rst
> @@ -0,0 +1,216 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +AD5529R driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Device driver for Analog Devices Inc. AD5529R 16-Channel 12/16-bit High =
Voltage DAC.
> +The module name is ``ad5529r``.
> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `AD5529R <https://www.analog.com/en/products/ad5529r.html>`_
> +
> +Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The AD5529R is a 16-channel, 12-bit or 16-bit, high voltage, buffered vo=
ltage output

Long line.  Wrap to 80 chars consistently

> +digital-to-analog converter (DAC) with an integrated precision reference.
> +The device operates from unipolar and bipolar supplies and is guaranteed
> +monotonic. It has built-in rail-to-rail output buffers that can source or
> +sink up to 25mA.
> +
> +Hardware Features
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* 16 independent 12-bit or 16-bit DAC channels
> +* Independently programmable output ranges:
> +
> +  - 0V to 5V (current driver default)

With such wide ranges we have in some previous drivers made it a device
tree constraint.  It rarely makes sense to switch between them at runtime
as these are really about what circuit is downstream of the DAC.
That needs to be there from initial driver otherwise we have a
backwards compatibility problem.  A 'default' of smallest range should
be safe though (gets messier for some device where 'smallest' could be
unipolar or bipolar)

> +  - 0V to 10V
> +  - 0V to 20V
> +  - 0V to 40V
> +  - =C2=B15V
> +  - =C2=B110V
> +  - =C2=B115V
> +  - =C2=B120V
> +
> +* 4.096V precision reference (12ppm/=C2=B0C maximum)
> +* Built-in function generation capabilities (hardware support)

I'd drop the "(hardware support)"  Given you are talking about functions
of the hardware, bit odd if the hardware didn't support them!
=20
> +* Output voltage and current monitoring (hardware support)
> +* Temperature monitoring with 8 on-chip sensors (hardware support)
> +* Over-temperature protection
> +* SPI interface with CRC error detection support
> +
> +Current Driver Implementation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +The current driver provides basic DAC functionality with the following f=
eatures:
> +
> +* Basic DAC output control for all 16 channels
> +* Scale attributes for voltage conversion (0-5V default range)
> +* SPI communication with regmap support
> +* Reset control framework support
> +* Automatic hardware variant detection (16-bit vs 12-bit) based on produ=
ct ID
> +* Debugfs register access for development
> +
> +SPI Configuration:
> +
> +* **Mode**: Supports SPI mode 0 and mode 3 (default: mode 0)

In what sense is it the default? I'd drop that as just depends on the DT.

> +* **Frequency**: Up to 50 MHz (typically tested at lower frequencies)
> +* **Word Size**: 16-bit transactions
> +
> +.. note::
> +   The device default configuration uses address decrement mode (ADDR_AS=
CENSION=3D0)
> +   for multi-byte SPI transactions. Therefore, all 16-bit register addre=
sses are
> +   incremented by 1 in the driver to access the last byte first, allowin=
g the
> +   hardware to decrement and access the complete multi-byte register cor=
rectly.

This doc is a slightly odd mix of stuff for users (most of it) and
driver details like this. I'd move this to a comment in the code and
keep the doc for users.

> +
> +IIO Attributes (Currently Implemented)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Basic DAC Control
> +-----------------
> +
> +For each of the 16 channels (0-15):
> +
> +**out_voltageY_raw**
> +  Raw DAC code (12-bit: 0-4095, 16-bit: 0-65535)
> +
> +  * Read: Returns the current DAC register value
> +  * Write: Sets the DAC output code
> +
> +**out_voltageY_scale**
> +  Scale factor for voltage conversion (millivolts per LSB)
> +
> +  Based on the formula: VOUTn =3D A =C3=97 D/2^N + B, where A=3D5V, B=3D=
0V, N=3Dresolution
> +
> +  * 16-bit: 0.076294 mV/LSB (5V =C3=B7 2^16 =3D 5V =C3=B7 65536 =3D 0.07=
6294mV)
> +  * 12-bit: 1.220703 mV/LSB (5V =C3=B7 2^12 =3D 5V =C3=B7 4096 =3D 1.220=
703mV)
> +  * Read-only attribute
> +
> +Debug Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**Register Access**
> +
> +The driver provides debugfs register access for debugging and developmen=
t:
> +
> +``/sys/kernel/debug/iio/iio:deviceX/direct_reg_access``
> +  Direct register read/write access. Format:
> +
> +  * Read: ``echo <register_address> > direct_reg_access; cat direct_reg_=
access``
> +  * Write: ``echo <register_address> <value> > direct_reg_access``
> +
> +Usage examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Basic DAC Output Control
> +------------------------
> +
> +.. code-block:: bash
> +
> +    # Set channel 0 to mid-scale (approximately 2.5V with 0V to 5V range)
> +    echo "32768" > /sys/bus/iio/devices/iio:device0/out_voltage0_raw
> +
> +    # Set channel 15 to full scale
> +    echo "65535" > /sys/bus/iio/devices/iio:device0/out_voltage15_raw
> +
> +    # Read current value from channel 5
> +    cat /sys/bus/iio/devices/iio:device0/out_voltage5_raw
> +
> +Scale Attributes
> +----------------
> +
> +.. code-block:: bash
> +
> +    # Read scale factor (millivolts per LSB)
> +    cat /sys/bus/iio/devices/iio:device0/out_voltage0_scale
> +    # Output: 0.076294 (for 16-bit) or 1.220703 (for 12-bit)
> +
> +    # Convert raw to voltage: voltage_mv =3D raw * scale
> +    # Formula: VOUTn =3D A =C3=97 D/2^N + B where A=3D5V, B=3D0V

This stuff is very standard.  Consider if it is worth documenting
for this specific part.  To me it isn't..

> +
> +Register Access for Development
> +-------------------------------

Likewise this section is very standard so I'd not expect per device
docs for it.

> +
> +.. code-block:: bash
> +
> +    # Navigate to debugfs directory
> +    cd /sys/kernel/debug/iio/iio:device0/
> +
> +    # Read device product ID (register 0x04)
> +    echo 4 > direct_reg_access
> +    cat direct_reg_access
> +
> +    # Write to a 16-bit configuration register (example: LDAC_HW_SW regi=
ster 0x19)
> +    echo "0x019 0xAA11" > direct_reg_access
> +    cat direct_reg_access
> +    # Output: 0xAA11
> +
> +    # Write to DAC channel registers (16-bit values)
> +    echo "0x149 32768" > direct_reg_access   # DAC channel 0 mid-scale
> +    echo "0x14B 65535" > direct_reg_access   # DAC channel 1 full-scale
> +
> +    # Read back DAC register values
> +    echo 0x149 > direct_reg_access && cat direct_reg_access  # Read chan=
nel 0
> +    echo 0x14B > direct_reg_access && cat direct_reg_access  # Read chan=
nel 1
> +
> +.. note::
> +   For 16-bit registers, use hexadecimal format for addresses (0x019, 0x=
149, etc.).

Are there non 16-bit registers where we shouldn't use hexadecimal?  Otherwi=
se this
note seems odd.

> +   Values can be decimal (32768) or hexadecimal (0xAA11). Register addre=
sses shown
> +   include the +1 offset required for decrement mode operation.
Ah. This is worth noting as users need to be aware of it so keep this bit.
> +
> +Device Tree Configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +Basic configuration example:
> +
> +.. code-block:: devicetree
> +
> +    &spi0 {
> +        status =3D "okay";
> +
> +        ad5529r@0 {
> +            compatible =3D "adi,ad5529r";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <25000000>;
> +
> +            vdd-supply =3D <&vdd_regulator>;
> +            avdd-supply =3D <&avdd_regulator>;
> +            hvdd-supply =3D <&hvdd_regulator>;
> +            hvss-supply =3D <&hvss_regulator>;
> +
> +            reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +
> +For complete device tree binding documentation, see:
> +``Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml``

Hard no to replicating the device tree example - that is just
noise. The cross reference is enough.

> +
> +Driver Architecture
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The driver is structured as follows:
> +
> +* **Core**: Basic SPI communication and device initialization
> +* **IIO Interface**: Standard IIO DAC channel interface with scale attri=
butes
> +* **Dual Regmap**: Uses standard regmap-spi for both 8-bit and 16-bit re=
gister access
> +* **Reset Framework**: Reset control support

Not seeing value in anything except the dual regmap and again this
is mixing user stuff with driver internal details.  That stuff probably
belongs in the driver.

> +
> +Development Notes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* The driver uses standard regmap-spi for both 8-bit and 16-bit register=
 access
> +* SPI mode 0 (CPOL=3D0, CPHA=3D0) is typically used

Drop that.  We don't care as long as both the options the dt-binding allows=
 work fine.

> +* Reset control framework support for device initialization
> +* Register addresses are incremented by 1 for 16-bit registers due to de=
crement mode addressing
> +* Scale attributes provide voltage conversion for 0-5V range
> +* Automatic regmap selection based on register address (=E2=89=A40x13: 8=
-bit, >0x13: 16-bit)

All this is driver internal stuff so I'd drop it.

> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* AD5529R Datasheet: https://www.analog.com/media/en/technical-documenta=
tion/data-sheets/ad5529r.pdf
> +* Linux IIO Subsystem: https://www.kernel.org/doc/html/latest/driver-api=
/iio/index.html
I'd skip that IIO generic docs reference. Not seeing it as adding much in t=
his file.

> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 007e0a1fcc5a..27f2ab41f05e 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -25,6 +25,7 @@ Industrial I/O Kernel Drivers
>     ad4062
>     ad4691
>     ad4695
> +   ad5529r
>     ad7191
>     ad7380
>     ad7606
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 143714e27d51..41f42eb1adf2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1513,6 +1513,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> +F:	Documentation/iio/ad5529r.rst
>  F:	drivers/iio/dac/ad5529r.c
> =20
>  ANALOG DEVICES INC AD5706R DRIVER
>=20

