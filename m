Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39685306B08;
	Fri, 23 Jan 2026 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156211; cv=none; b=QIhh4xxzjWpIgjAroIdHrNV93r2mqKV5f4WQmU1YliQgoV44BFtXRO6OqOr5zotz34HmqTPDn9n6cAqWWM7jMzMr1YIyYJ507OpdwsN1rxIaK2pNGm325se6R4e3vvpmqYAAkwYNMuhrUES/EtbboyQxllZXTuZ5zQ+Psakt50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156211; c=relaxed/simple;
	bh=2iDxdSx14/uXimquYB8SyE4nT0Qu2Afoq1CG0qGtKyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWyGzu931gnu9Vi7DmD9yTDarxmAihgzRi/oqYPPPYSpBydyLtrsi0UciEwVZbBein3SkjgqQfB2+/q6XrEelDluezWI2cK2X4aRZ4zqRpn64nZ/gjnkMGYiBi3YOZ80+KAU9Da4ieNOBONtHh1C3aT8TgQT/9qVgqMqW9xBFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3FU4HV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3FU4HV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1840EC4CEF1;
	Fri, 23 Jan 2026 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769156210;
	bh=2iDxdSx14/uXimquYB8SyE4nT0Qu2Afoq1CG0qGtKyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V3FU4HV0NnvJ43VWy0++fp1VJHTTRqoKLorS8g8C5yyeWknFk4O7c55fw9R5XDSyb
	 P0HRGHx2LdDwibdafM0RgQsSKm37onm7w2H1nR9vWYy/UUjJGypKX6CiFcI/1iahUf
	 UxjSgraxa3nFSMwpax12WfjvZoD+y6a+RkuvAVEx2YCmtlbV+K5q6XH6GOVQmcwpqd
	 KYogJVGF5mGqa36tMRQ7H0YTFpTdgZsy+8dd85lJZtiD5svMJsInfDOpZBr4u803Oh
	 TzGhk6ZMKfh4kjYAl7L6PxNsDKBG3nDd6aNVQ7rjP2DOnD3L2awH9NdGXj4Tl+hSQZ
	 uoE99M4Vvk9QQ==
Date: Fri, 23 Jan 2026 08:16:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jan.sun97@gmail.com>, <gastmaier@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v4 0/2] iio: dac: Add support for MAX22007 DAC
Message-ID: <20260123081640.590335bd@jic23-huawei>
In-Reply-To: <20260119-max22007-patch-v4-0-e22404a885a6@analog.com>
References: <20260119-max22007-patch-v4-0-e22404a885a6@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 12:24:22 +0100
Janani Sunil <janani.sunil@analog.com> wrote:

> This patch series introduces support for the Analog Devices MAX22007, a
> quad-channel, 12-bit digital-to-analog converter (DAC) with integrated
> precision output amplifiers and configurable voltage/current output capability.
> 
> **Device Overview:**
> The MAX22007 features four independent DAC channels that can each be configured
> for either voltage output (0-12.5V) or current output (0-25mA) mode. The device
> communicates via SPI interface with built-in CRC8 error checking for data integrity.
> 
> **Features Implemented:**
> - Support for all 4 DAC channels with 12-bit resolution
> - Per-channel voltage/current mode configuration via device tree
>   property `adi,ch-func = [voltage, current]`
> - Independent power control for each channel (attribute)
> - Hardware reset support via GPIO (during probe)
> - CRC8 error checking for SPI communication
> 
> **Patch Summary:**
> 1. dt-bindings: Binding documentation with channel configuration
> 2. driver: Implement IIO DAC driver
> 
> **Testing:**
> The driver was hardware tested on a Raspberry Pi4 on top of v6.12.y
> kernel using the MAX22007EVKIT evaluation board.
> 
> Janani Sunil (3):
> 
> dt-bindings: iio: dac: Add max22007
> iio: dac: Add MAX22007 DAC driver support
> ---
> To: Lars-Peter Clausen <lars@metafoo.de>
> To: Michael Hennerich <Michael.Hennerich@analog.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: jan.sun97@gmail.com
> Cc: gastmaier@gmail.com
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
As noted in patch 2 comments I am rushing this a bit given point in cycle
so if anyone else wants to take a final look (e.g. Marcelo who looked at
v2) then that is fine.

In meantime I've applied this to the testing branch of iio.git which will
become togreg if all looks good in test builds.

Jonathan

> 
> ---
> Changes in v4:
> - Re-sent of improper v3 (at v3 I *accidentaly* reverted the dt-binding
>   commit to v1 after a rebase).
> - Corrected description for reset GPIO in the dt-binding
> - Wrap commit description at 75 columns
> - Link to v3: https://lore.kernel.org/r/20260114-max22007-patch-v3-0-769298f50b8a@analog.com
> 
> Changes in v3:
> - Remove node defined for power supplies in the devicetree documentaiton
> - Made use of CRC8_TABLE_SIZE macro in the crc table definition
> - Corrected casting of reg address in the SPI read function
> - Applied reverse christmas tree variable ordering
> - Added a macro fro the reference voltage and reused the same in the
>   scale factor
> - Removed usage of 'supplies' in enabling bulk regulator and removed
>   unused variable 'i'
> - Added step n the probe function to toggle the reset GPIO
> - Updated spacing in macro definitions
> - Link to v2: https://lore.kernel.org/r/20260108-max22007-dev-v2-0-2506c738784f@analog.com/
> 
> Changes in v2:
> - Wrap commit messages as per coding guidelines
> - Removed all driver references from the hardware
> - Update property description for reset-gpio
> - Removed allOf
> - Added minimum/maximum limits for channel number in the devicetree
>   binding
> - Replaced adi,type with adi,ch-func.
> - Added reference to required supplies in the binding, configured them
>   in the driver
> - Channels are not a required property anymore.
> - Replaced instances of 'channel' in macros to just 'ch'
> - Added trailing commas wherever necessary, removed them as per comments
> - Add explicit values for enum- max22007_channel_power
> - Replace channel spec structure member 'iio_chan' with 'iio_chans'
> - Use spi_write_then_read() API in the max22007_spi_read() API
> - Check for reg_size ==1 and hardcode the size otherwise
> - Wrap lines in the driver to 80 characters
> - Update in-line comment on the resolution
> - Separate declarations with assignment, from the ones that don't
> - Update the usage of channel template
> - Add a local device descriptor to point to the SPI device
> - Add a transition of the Reset GPIO from low to high in the probe
> - Make use of regmap_set_bits() instead of regmap_update_bits during CRC
>   Enable function call.
> - Remove the documentation commit, as it is not needed anymore.
> - Link to v1: https://lore.kernel.org/r/20251219-max22007-dev-v1-0-242da2c2b868@analog.com
> 
> ---
> Janani Sunil (2):
>       dt-bindings: iio: dac: Add max22007
>       iio: dac: Add MAX22007 DAC driver support
> 
>  .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 120 +++++
>  MAINTAINERS                                        |   8 +
>  drivers/iio/dac/Kconfig                            |  13 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/max22007.c                         | 488 +++++++++++++++++++++
>  5 files changed, 630 insertions(+)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260114-max22007-patch-6b5c48e37457
> 
> Best regards,

