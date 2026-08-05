Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573521FF25;
	Wed,  5 Aug 2026 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890918; cv=none; b=BipsG4CwVA0X4D9yQdmjFE00rZTEwDjO+LZGlLidljSRyxvuYoWm9ON3bFSKwMTk4j3cdleudNPD2xB5UGe/Fgiq9NOBD+A5AyMQtOJS8MnESRIKMbNxbDQahKrNddvx1oX80xrowPiFtZEsNgW2NgThSJGnqDVYA5Wjxqi1oO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890918; c=relaxed/simple;
	bh=gQN0CBKh59jtGAg3Btp4WBkIzEMHN+uZziOI9RwWSGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+/wZWq1D2+jph21RF36rb1kdBw/hxHQiGhCvH8N54Nb7Xf3nKC2XY3DIQ57qs8C6bGh48HnakhBISw07IcsQ9sXrU5g/R/3jdsM87VaPu2J0vwTJXHPm6rCuLlOp+kJgVcqAK1HOIq4zWPK0KKVgoU00zGuNjZfKQHhJHCVCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4L1pdVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4L1pdVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8357C1F000E9;
	Wed,  5 Aug 2026 00:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890916;
	bh=mLZn85s+rS+pNDmif/k5nTYZ6EZPfvN7lFnahs09mGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P4L1pdVoE6rtcczCvj4eopWf+0Jf4aVP3XxHasczUltVCPxrPjDnRSFsUiGwM7zoj
	 Frd0wff/aFoVVRRXBOYcbaZD5uuWV/4yunizSC9IheGPlhE/PdBdIZ1EWOfvSSrhAW
	 kax23jrvzz11Kh3iLN3rhM9kGfzlzkt646IcdmA48J8v2YIQOqPY78OaHijGhnXH//
	 aw8oWx6gewcu/mttMBpBqEtf0+R38WUb96hfcsHQ9wximv0NwQHheKtPQXo4uqGE4E
	 K2bCd+IlxHMMFnOFNZ+oFs+9/xYxa1KuqUqfxJKAwT3HcIjThO5WUVfKWuPh0Xh7Ss
	 4nVEOjrRgAwzw==
Date: Wed, 5 Aug 2026 01:48:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
 <joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/17] Add thermal management support for sama7d65
Message-ID: <20260805014829.3ff4088d@jic23-huawei>
In-Reply-To: <20260804113338.261782-1-varshini.rajendran@microchip.com>
References: <20260804113338.261782-1-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 17:03:21 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Thermal management system of sama7d65 includes:
>=20
> - Temperature sensor as a part of ADC channel
> - Temperature calibration data retrieved from the OTP memory for
>   improved accuracy of the readings
> - DVFS implementation
> - Thermal system with DVFS as cooling cell.

Whilst to me this looks nearly ready to go upstream, I'm sorry to say
we are very late in the cycle, so chances are now pretty low.
If all seems fine I'll queue it up early next cycle though and so it
shouldn't be too long before you see it in linux next.

Jonathan

>=20
> This patch series adds support for the following:
>=20
> - Tag-based packet lookup for the NVMEM OTPC driver while preserving
>   backward compatibility with existing ID-based access
> - Temperature calibration layout handling in the ADC driver to support
>   different SoC-specific calibration data formats
> - ADC driver adaptation for sama7d65
> - DT nodes for OTP, ADC, temperature sensor, and thermal zones for
>   sama7d65
>=20
> Changes in v5:
> 	- Placed the DEFINE_FREE helper in the header file and added it as a
> 	  new commit
> 	- Added IS_ERR_OR_NULL(_T) condition to the DEFINE_FREE of nvmem_cell_put
> 	- Reorder signing tags alphabetically in Patch 1
> 	- Kept the changes minimal by retaining ret variable
> 	- Collected the Rb tags
>=20
> Link to v4: https://lore.kernel.org/lkml/20260727122633.117435-1-varshini=
.rajendran@microchip.com/
>=20
> Changes in v4:
> 	- Reworked cleanup.h usage: define and assign __free() variables at point
> 	  of use after early returns, add DEFINE_FREE(nvmem_cell_put, ...) for
> 	  nvmem_cell cleanup
> 	- Split patch 3/13 into two: refactoring (layout struct) and tag validat=
ion
> 	- Used struct u32_fract for p1 scaling factors
> 	- Return -ENODEV instead of -EINVAL when layout is missing
> 	- New precursor patch to remove unnecessary casts in of_device_id
> 	- Removed trailing comma from single-line initializer array
> 	- Moved emulation mode validation into a separate patch
> 	- Added FourCC validation for packet tags; invalid tags fall back to ID-=
only
> 	  access
> 	- Mentioned FourCC in commit message and comments
> 	- Used intermediate variable for off % 4
> 	- Rename tmp =E2=86=92 mr_val, val=E2=86=92 tag
> 	- Addressed style issues: Removed comment blocks, put functions in
> 	  one line
> 	- Remove blank line after compatible in regulator node
> 	- Reorder properties.
>=20
> Link to v3: https://lore.kernel.org/lkml/20260630093603.38663-1-varshini.=
rajendran@microchip.com/
>=20
> Changes in v3:
>     - Updated the commit message with reasoning for a new compatible
>       without a fallback (sama7d65-adc)
>     - Split patch 2/12 into two patches: a patch with cleanup.h changes o=
nly
>       and the rework patch
>     - Added comment explaining the TAG ACST
>     - Fixed the holes identified in the at91_adc_platform struct by
>       pahole tool
>     - Dropped labels in the dt document example
>     - Added temp variable in mchp_otpc_resolve_packet() to avoid % and /
>       operations in the same instruction (avoiding compiler optimization)
>     - Added the SoC details in the ADC driver Kconfig help section
>     - Maintained reverse xmas ordering in declarations
>     - Fixed node ordering (alphabetically) in the board dts file
>=20
> Link to v2: https://lore.kernel.org/lkml/20260623105944.128840-1-varshini=
.rajendran@microchip.com/
>=20
> Changes in v2:
>     - Preserved backward compatibility with ID-based packet lookup to
>       avoid breaking existing users
>     - Removed sama7g5 DTS changes (not needed with backward compatible
>       driver - will be sent later to update to the new access method)
>     - Preserved the packet data structure returned not to break the
>       consumers
>     - Reworked ADC driver to use a calibration layout structure instead of
>       hardcoded indexes, for scalability
>     - Fixed kernel-doc Return section
>     - Removed stray blank line in mchp_otpc_read()
>     - Removed unnecessary UL suffix in writel_relaxed()
>     - Dropped unused packet types
>     - Fixed stray spaces before exclamation marks in error messages
>     - Added ASCII representation to TAG macro definition
>     - Removed odd MAX enum with trailing comma and refactored
>     - Moved DTS patches to the end of series
>     - Used cleanup.h helpers for NVMEM data buffer handling in ADC driver
>     - Combined multiple v1 patches into logical units
>     - Used correct subject prefixes for dt-bindings patches
>     - Used fixed-layout NVMEM syntax for sama7d65 DTS and binding
>       instead of deprecated syntax
>     - Added cpu-supply linkage for proper DVFS voltage scaling
>     - Updated stale stride=3D4 comment in dt-bindings header
>=20
> Link to v1: https://lore.kernel.org/linux-arm-kernel/20250804100219.63325=
-1-varshini.rajendran@microchip.com/
>=20
> Varshini Rajendran (17):
>   dt-bindings: iio: adc: at91-sama5d2: document sama7d65
>   nvmem: add DEFINE_FREE for nvmem_cell_put cleanup
>   iio: adc: at91-sama5d2_adc: use cleanup.h for NVMEM buffer
>   iio: adc: at91-sama5d2_adc: rework temp calibration layout handling
>   iio: adc: at91-sama5d2_adc: add condition to validate calibration data
>   iio: adc: at91-sama5d2_adc: remove unnecessary casts in of_device_id
>   iio: adc: at91-sama5d2_adc: adapt the driver for sama7d65
>   dt-bindings: nvmem: microchip,sama7g5-otpc: add sama7d65 and dt node
>     example
>   nvmem: microchip-otpc: nvmem: microchip-otpc: add tag-based packet
>     lookup
>   nvmem: microchip-otpc: nvmem: add emulation mode and OTP access
>     validation
>   ARM: dts: microchip: sama7d65: add cpu opps
>   ARM: dts: microchip: sama7d65: Add ADC node
>   ARM: dts: microchip: sama7d65_curiosity: Enable ADC, DVFS
>   ARM: dts: microchip: sama7d65: add otpc node
>   ARM: dts: microchip: sama7d65: add cells for temperature calibration
>   ARM: dts: microchip: sama7d65: add temperature sensor
>   ARM: dts: microchip: sama7d65: add thermal zones node
>=20
>  .../bindings/iio/adc/atmel,sama5d2-adc.yaml   |   1 +
>  .../nvmem/microchip,sama7g5-otpc.yaml         |  28 +++-
>  .../dts/microchip/at91-sama7d65_curiosity.dts |  27 ++++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     | 131 +++++++++++++++++
>  drivers/iio/adc/Kconfig                       |   2 +-
>  drivers/iio/adc/at91-sama5d2_adc.c            | 124 +++++++++++-----
>  drivers/nvmem/microchip-otpc.c                | 133 ++++++++++++++++--
>  .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
>  include/linux/nvmem-consumer.h                |   4 +
>  9 files changed, 404 insertions(+), 50 deletions(-)
>=20

