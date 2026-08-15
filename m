Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2929DB64;
	Sat, 15 Aug 2026 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786830527; cv=none; b=OCpJ7PabHIXZMVc9Y2r6/T/OxB0EpJPHLK7FZPDUVz5H8XNpY+TccRUBG4aN94s3RP0xfFrVNlt/DvQYogxNTsRz6GUs9bw/887YlFlkKBmL6TaI5PmyChQkhpAoRbpFYxFXDxEWJvPwyJNoAdUXFsIr9nBSFYEumWyzVmK9dPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786830527; c=relaxed/simple;
	bh=fOVwma02jhC1OhamIZWkdvlwuz0fRLNfs5j5/Dwlr28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUSsfuJmS7ZRZ1SdKOGjnkjx5U3cp14y9F1dw7V1sSzeJjgte3dcQF25KQU595SeHQ3yG0cYyR2Ki5J0OkPg9h/9L63AkX5OZgJa5zS35n+MRH/m3Yq0nhHifQZosvo6HfSsgCsfGixR+Tf2jyXZWiaYGqj5WBnINkh4zmRMtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvju8Hyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvju8Hyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB351F000E9;
	Sat, 15 Aug 2026 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786830525;
	bh=K622mBfxNoMEQ0Rnt0bsFc4J2+42BrZq9uR3gxYzrjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cvju8Hyq3jsfX1UUhzQ55EfLwK5OtQsBZUbms7lYNLMxiQisgSQy3gurK5BqGVzar
	 3wnbKEkDdFBL/GKdR9Bnowe1TQz5KOQQD6JIsvdJ4RVrlYUcujPSqulTD3ooKn/zee
	 m3Ish+QZgJ410UNuNlUv541GGtPhSxAy/YJKkobQ14zXw1bY870jy3Vq1b3nxpGBdy
	 AuHxgHbeZWnOVzWbJLA8wo6yzGA1ZC0HI8KOLabeMYuHCsQw3dTPMqOFMwmimF7EU/
	 ZPAWJYrp4l5DjTI32HuK0qbCenA51PjsBP+l7zTRQFAp13mlXkW+5Lto8XThvpG5Xe
	 P5nlWixd8nfxQ==
Date: Sat, 15 Aug 2026 22:48:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, "Jonathan Corbet" <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Marius
 Cristea <marius.cristea@microchip.com>, "Marcus Folkesson"
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, Conor
 Dooley <conor.dooley@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>, Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>,
 <linux-spi@vger.kernel.org>, Kent Gustavsson <nedo80@gmail.com>,
 <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v8 0/3] iio: dac: Add support for AD5529R DAC
Message-ID: <20260815224838.2bf9fdde@jic23-huawei>
In-Reply-To: <20260805-ad5529r-driver-v8-0-b41781f5632a@analog.com>
References: <20260805-ad5529r-driver-v8-0-b41781f5632a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Aug 2026 09:17:40 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> This patch series adds support for Analog Devices AD5529R, a 16 channel
> 16 and 12 bit voltage Digital-to-Analog Converter (DAC) with integrated
> precision reference. The AD5529R operates from both unipolar and
> bipolar supplies. The device communicates via SPI interface.

https://sashiko.dev/#/patchset/20260805-ad5529r-driver-v8-0-b41781f5632a%40=
analog.com
has some comments.

I think the dt ones are fine as we do want to explicitly list all
the dac.yaml properties in here to constrain them further.

The one about sleeping after enabling regulators looks correct though.
I'd add an fsleep() to ensure nothing else happens immediately after
switching the power on.

The other sleep related thing about allowing extra time. Don't bother
unless we get a report of problems as there will be extra delay anyway
due to the call overhead etc and datasheet values tend to be conservative.

For the scale related one, perhaps add a comment there referring
to datasheet specifying the reference voltage if an external reference
is used should be same as output of internal reference.

Given your regmap is working I'll assume the one about mixed
endian is a false positive.

Jonathan

>=20
> **Device Overview:**
> The AD5529R features 16 independent DAC channels, with 16 or 12 bit
> resolution, allowing independently programmable output ranges. The
> internal 4.096V precision reference sets the accuracy of the output
> voltage.
>=20
> The device can encode a hardware address in its SPI command frame,
> allowing up to 4 devices to share a single chip select. This series
> introduces a generic spi-device-addr property for describing this type
> of addressing.
>=20
> **Features Implemented:**
> - Support for AD5529R 12-bit and 16-bit variants via device match data.
> - Support for a single DAC device using any hardware address between 0
>   and 3.
> - Reset support via reset controller framework.
> - Dual regmap configuration to handle 8 and 16 bit registers.
> - Per-channel output range configuration from devicetree.
> - Optional external reference and bipolar supply handling.
>=20
> **Patch Summary:**
> 1. Add the generic spi-device-addr SPI peripheral property.
> 2. AD5529R binding documentation with channel configuration.
> 3. Implement AD5529R IIO DAC Driver with regmap support.
>=20
> **Testing:**
> The driver was compiled and tested on the EVAL-AD5529R-ARDZ using a
> coraZ7 with a mainline v7.0 kernel.
>=20
> **Driver Rationale:**
> AD5529R introduces:
> 1. A unique register layout
> 2. Mixed 8-bit and 16-bit register accesses
> 3. Hardware specific features like function generators, multi-die
> hotpath registers etc.
>=20
> The device warrants its own driver due to these fundamental
> architectural differences, that would require substantial changes to
> existing drivers without providing reusable benefits. The standalone
> driver also allows future extensions for related devices in the same
> family.
>=20
> **Not Implemented in this Series:**
> The binding includes generic, peripheral level device addressing needed f=
or
> multi-device support using a shared CS, but the driver presently
> supports only a single device.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
> Changes in v8:
> - Rename the AD5529R supply properties to match the datasheet supply
>   names.
> - Describe and enable all four positive and four negative high-voltage
>   supplies.
> - Reject duplicate channel nodes and configurations with too many
>   channels.
> - Add the required 20 ns delay between reset assertion and deassertion.
> - Add a macro to represent the number of channels.
> - Return -ENODATA when device cannot be identified.
> - Clarify that spi-device-addr contains one address per physical device.
> - Drop the Microchip binding and driver changes from the series.
> - Drop brackets around scalar spi-device-addr defaults.
> - Simplify the regmap_assign_bits() reference selection value.
> - Link to v7: https://lore.kernel.org/r/20260722-ad5529r-driver-v7-0-7781=
cd74ad75@analog.com
>=20
> Changes in v7:
> - Drop #include <linux/mod_devicetable.h>
> - Add comment on minimum HW reset low width.
> - Flip the vref regulator error check.
> - Clarify why spi-device-addr is an array, with one address per physical
>   device sharing a chip select.
> - Add default addresses for mcp3564 and mcp3911 bindings.
> - Initialize AD5529R regmap configurations locally using designated
>   initializers.
> - Update "Patch Summary" section in the cover letter.
> - Link to v6: https://lore.kernel.org/r/20260715-ad5529r-driver-v6-0-cfdf=
8b9f5ee3@analog.com
>=20
> Changes in v6:
> - Rename spi,device-addr to spi-device-addr and define it as an array at
>   peripheral node level.
> - Fix the SPI binding patch subject prefix to use "spi: dt-bindings:".
> - Add spi-device-addr to the MCP3564 and MCP3911 bindings.
> - Deprecate the existing Microchip-specific device-address properties.
> - Replace adi,output-range-microvolt with output-range-microvolt.
> - Move AD5529R device addressing from channel nodes to the peripheral
>   node.
> - Include linux/types.h
> - Honour non-zero hardware address in the AD5529R driver.
> - Dynamically expose only the channels described by devicetree and
>   remove unused scan type definitions.
> - Use explicit reset assertion and deassertion as the GPIO reset
>   controller does not implement reset_control_reset().
> - Use the MICRO and MILLI unit constants when matching output ranges.
> -  Simplify optional reference regulator handling and remove the
>    external reference comment.
> - Simplify error messages and stick to 80 col.
> - Link to v5: https://lore.kernel.org/r/20260701-ad5529r-driver-v5-0-ed08=
7900e642@analog.com
>=20
> Changes in v5:
> - Move register bitfield definitions next to their parent register
>   addresses.
> - Remove spurious extra indent.
> - Rename ad5529r_output_ranges_mv[] to ad5529r_output_ranges_mV[].
> - Remove extra parentheses in regmap_reg_range() for the readback range.
> - Use reset_control_reset() instead of reset_control_deassert().
> - Use 10 * USEC_PER_MSEC instead of a bare 10000 in fsleep().
> - Use fwnode_property_present() to explicitly guard the optional property.
> - Rewrite external_vref detection using explicit if/else.
> - Follow reverse christmas tree variable declaration order.
> - Improve invalid channel error message to include the maximum.
> - Add a new spi property to include the SPI device address.
> - Update ad5529r devicetree binding to allow more than 16 channels to inc=
lude multiple DACs.
> - Update cover letter to add a mention about the multi device support.
> - Update driver commit message to describe the device further.
> - Link to v4: https://lore.kernel.org/r/20260609-ad5529r-driver-v4-0-2e4c=
02234a1a@analog.com
>=20
> Changes in v4:
> - Fix DT child-node regex for hexadecimal channel addresses.
> - Wrap long DT binding description lines.
> - Simplify optional `vref-supply` and `hvss-supply` handling.
> - Update REF_SEL programming for optional external reference use.
> - Clean up range parsing and error messages.
> - Simplify debugfs register access by calling regmap helpers directly.
> - Add clarifying comments for reset settling time and RAW reads from `DAC=
_INPUT_A`.
> - Remove an unused vref regulator pointer and an include.
> - Rename the REF_SEL bit define and clean up small driver details.
> - Toggle pins defined as PWM pins, instead of GPIOs
> - Update cover letter to sync up latest changes.
> - Link to v3: https://lore.kernel.org/r/20260519-ad5529r-driver-v3-0-267c=
0731aa68@analog.com
>=20
> Changes in v3:
> - Split into adi,ad5529r-16 and adi,ad5529r-12 device tree compatibles
> - Add DT-based output range configuration via adi,output-range-microvolt
> - Expand DT binding: vref-supply, clear/tg GPIOs, interrupts, muxout
> - Correct power supply voltage specifications as per datasheet
> - Reduce SPI frequency limit to 25MHz as per datasheet specs
> - Switch to autoincrement addressing mode, remove +1 register offsets
> - Use DT match data instead of device ID detection for fallback support
> - Implement dynamic scale/offset calculation per configured channel range
> - Added explicit val_format_endian and reg_stride for 16-bit regmap bus
> - Code cleanup: alphabetical includes, ARRAY_SIZE(), unused defines
> - Minor: .sign=E2=86=92.format field, simplify read/write order, optional=
 hvss-supply
> - Remove redundant driver documentation ad5529r.rst
> - Link to v2: https://lore.kernel.org/r/20260508-ad5529r-driver-v2-0-e315=
441685d7@analog.com
>=20
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
>       spi: dt-bindings: Add spi-device-addr peripheral property
>       dt-bindings: iio: dac: Add AD5529R
>       iio: dac: Add AD5529R DAC driver support
>=20
>  .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 254 ++++++++++
>  .../bindings/spi/spi-peripheral-props.yaml         |   7 +
>  MAINTAINERS                                        |   8 +
>  drivers/iio/dac/Kconfig                            |  17 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/ad5529r.c                          | 530 +++++++++++++++=
++++++
>  6 files changed, 817 insertions(+)
> ---
> base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
> change-id: 20260507-ad5529r-driver-866bbdd864de
>=20
> Best regards,

