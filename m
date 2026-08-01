Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188923D7F4;
	Sat,  1 Aug 2026 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626479; cv=none; b=P/j2ujQVKnTCcvILIFKfGY8e5HMroI7BhAD1i0VzQmXiBnGpoe0a6V5fGTkTzXRT9tqmnLd7lYqjkZ55fMo/DD7EaMPgT/Lm8GhYnNDItTB4p0Q6NDOulXZ17CFto5k7XsPr6t/u/vwfc8USPW2uf/7b4sh/vN4fbyeCo7LgrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626479; c=relaxed/simple;
	bh=gLtZ2Qjl8ITbKqRBQb3FmgMLB5Zk7ZvvbIdgioAXcU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0S4AmpRlqygKk8i3UcwutH1pBZ/VheY7+DFQG2e+CfKJHf8Vy8B8dRgpMHc1SPLPJI6ACyJO59W1TTKPBhhXOqu4L0sP3QiZKlng83H7m/NFOtk0H6dFEhWIBtqEC4b2mOX4uB01k32+sJdMYFhizOJvY0i5f5ol4PG84nJByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWoJ2XkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWoJ2XkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374661F00AC4;
	Sat,  1 Aug 2026 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785626478;
	bh=iB4IndDnDOWGa7qWjf/210qCneJBnZwaynVmwXaidSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KWoJ2XkD+MDi9FHF6I9qqh8JISY2lMBj0VPv7HT2Kzfp4ghTBXRc6DcfKnynTTSbv
	 Ik69Wqfp1FnmpHpdjNtcfrwKNi++OlVxauusyUV6h+SsxwaqoTlvMMJfECIh6pdThr
	 OCB80LvyT6kAVg6r8PVmp3zr5u8+c3lVMjwzptYgNNdcAJEqaUj0HOypmJMaLcixOf
	 Q9CDHKPPFawIVIhXD8aMfYz+CR1lN9XK+ZlhYf8QVnq98b/fhv5euwbc19fYJsashO
	 OooK6gOPiDAAq+SdFPrsi1X09c4oG60VfIDGaSe+ZpYLVhymEjp1LQYl6QRjjMM1R/
	 YWZL5TX7xtzTA==
Date: Sun, 2 Aug 2026 00:21:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] add support for Microchip PAC1711 Power Monitor
Message-ID: <20260802002113.3e93e299@jic23-huawei>
In-Reply-To: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 15:03:47 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> The PAC1711, PAC1721, PAC1811 and PAC1821 products are single-channel power
> monitors with accumulator. The PAC1711 and PAC1721 devices use 12-bit
> resolution for voltage and current measurements and 24 bits for power
> calculations, while PAC1811 and PAC1821 have 16-bit resolution and use 32
> bits for power calculations. The 56-bit accumulator register accumulates
> power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Make sure to check https://sashiko.dev/#/patchset/20260728-pac1711-v2-0-609bc026093c%40microchip.com
but keep in mind it is far from always correct so treat every comment
as a strong hint their maybe something going on rather than anything certain!

It invents IIO_CHARGE as a channel type for instance :)

> ---
> Changes in v2:
> - fix review comments device tree binding:
>     add PAC1721, PAC1811 and PAC1821 part numbers
>     add Vbus/Vsense input ranges in attribute definition
>     change accumulation-mode from int to string type
>     remove size and address cells
>     correct interrupts definition and add attributes for the two
>       alerts, microchip,gpio0-mode and microchip,gpio1-mode
>     remove microchip,gpio attribute
>     remove "vbus" accumulation mode 
> 
> - fix review comments driver:
>     add PAC1721, PAC1811 and PAC1821 part numbers
>     run pahole on reg_data and pac1711_chip_info structs
>     remove average registers - VBUS_AVG and VSENSE_AVG
>     add PAC1721, PAC1811, PAC1821 to features/compatible
>     add missing headers
>     remove rarely used defines like PAC1711_POWER_24B_RES and use the
>       numerical value inline instead
>     use ARRAY_SIZE() instead of define for the number of accumulator
>       related attributes
>     add explanation for bytes length defines
>     use spacing convention space after { and before }
>     remove pac1711_shift_map_tbl in order to use just
>       pac1711_samp_rate_map_tbl and an index saved in struct
>     use read_avail() for sampling_rate
>     change mutex comment in reg_data
>     use fsleep instead of usleep
>     use a local __be16 variable in endianess transformations
>     add missing error returns after dev_err
>     add info_mask_shared_by_all for sampling_frequency 
>     use dev_info instead of dev_err_probe in chip_identify
>     generalize input setup functions into one
>     remove device_property_present
>     rename pac1711_single_channel into pac1711_chan_spec
>     rename pac1711_of_parse_channel_config into pac1711_parse_fw
>     remove unneccessary comments in probe
>     define in_shunt_resistor as ext_info instead of custom attribute
>     use calculations only with 16-bit resolution instead of multiple
>      shifting (12-bit registers are left shifted)
>     add scale computations based on new voltage of 9V for PAC1721/PAC1821
> 
> v1:
> - first version committed to review
> - Link to v1: https://lore.kernel.org/r/20251015-pac1711-v1-0-976949e36367@microchip.com
> 
> ---
> Ariana Lazar (2):
>       dt-bindings: iio: adc: add support for PAC1711
>       iio: adc: add support for PAC1711
> 
>  .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   24 +
>  .../bindings/iio/adc/microchip,pac1711.yaml        |  209 ++++
>  MAINTAINERS                                        |    8 +
>  drivers/iio/adc/Kconfig                            |   11 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/pac1711.c                          | 1274 ++++++++++++++++++++
>  6 files changed, 1527 insertions(+)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250901-pac1711-d3bacda400fd
> 
> Best regards,

