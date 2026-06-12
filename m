Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A227263B;
	Fri, 12 Jun 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266221; cv=none; b=etTtbrT5wMg9W14L1bf/Nu+mcDSrH9RJnPfp0g9420qVBtdBzvVkA1RKv8SMRB3REPH7vZ2eUrBi/1yVAMs1sjxzGPEjidQMpyGh3iaZiu9YZnaRmHHL+vbivfsaOWIs8vVffZR5j7IptzWEWaUu/WZ1U+7G8KTZUs3TfRWk9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266221; c=relaxed/simple;
	bh=CPYSWHgPrn7Yn6YTTbCo1P5gop3sI0SoorWYDV5NiRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P53Jx3SazhmAvlq2FXaokX0N48gClTzfiSlWkRsMOLWmtv4989oux8IIy9hdCqieSnfmvpdFWcxYAaIvtf56IOJ/Cv1Ai1aTxl0V/17i87oa888INwJd9VZ60BMt2Vk8pL2r8KgqPfTf+cxB+U3ediUDT8Zo5AqnoxJzNcuDCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDCvLYjg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDCvLYjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10861F000E9;
	Fri, 12 Jun 2026 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781266219;
	bh=61oG9MuVuT+pQBEQfNjIs+962WvE1TI9o9L10/gkiOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FDCvLYjgicm6E7mMPg8ldZPyrEqKg7BsIGp1nYmPY7l3rgqtzdBn+PMTD0pv6yzAW
	 oxkvGnoSpMLq8eJBfGe6AaZZxE5r4OCUYRjyn5/Egb2cS93UPUpxGc0rQW5XKMNhn0
	 L4GpdQeuOY9i3tQ3XQZihZfp6kmrA4mZw1Y3vVWzkSxYm22otQ8h4Gpa9EYTP0Kwne
	 VlYbR64EO78oiCj4r1xwfX3FqIEAjAVsfMeU0x/JTSJSDzl0lstIZ1VsLmVFWCu7I8
	 7nwq3v+mEdcA33ljAJitPNIIcN2cBtRwMoAJWHFsuSnq8MzyIFCgGnKzAElatu/t5Z
	 7OpGP2nFYDIow==
Date: Fri, 12 Jun 2026 13:10:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <conall.ogriofa@amd.com>, <michal.simek@amd.com>, <linux@roeck-us.net>,
 <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] iio: adc: add Versal SysMon driver
Message-ID: <20260612131009.1be11ff2@jic23-huawei>
In-Reply-To: <20260611222738.2035062-3-salih.erim@amd.com>
References: <20260611222738.2035062-1-salih.erim@amd.com>
	<20260611222738.2035062-3-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 23:27:35 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Add the core driver and MMIO platform driver for the AMD/Xilinx Versal
> System Monitor (SysMon) block.
> 
> The SysMon block resides in the platform management controller (PMC) and
> provides on-chip voltage and temperature monitoring through a 10-bit,
> 200 kSPS ADC. It can monitor up to 160 voltage channels and 64
> temperature satellites distributed across the SoC, with a consistent
> sample rate of 8 kSPS per channel regardless of how many channels are
> enabled.
> 
> The driver is split into two compilation units:
>   - versal-sysmon-core: Channel parsing, IIO registration, read_raw
>   - versal-sysmon: MMIO platform driver with custom regmap accessors
> 
> Voltage results are stored in a 19-bit modified floating-point format
> and converted to millivolts. Temperature results are stored in Q8.7
> signed fixed-point Celsius format and converted to millicelsius.
> 
> The MMIO regmap backend uses a custom reg_write accessor that
> automatically unlocks the NPI (NoC programming interface) lock
> register before each write, as required by the hardware. The regmap
> is configured with fast_io since the underlying MMIO accessors are
> safe to call from atomic context.
> 
> Co-developed-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>

One question on the static temp channels. I may have forgotten
some earlier discussion!

> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> new file mode 100644
> index 00000000000..c875d156dbe
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -0,0 +1,281 @@

> +
> +#define SYSMON_CHAN_TEMP(_chan, _address, _name)		\
> +{								\
> +	.type = IIO_TEMP,					\
> +	.indexed = 1,						\
> +	.address = _address,					\
> +	.channel = _chan,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.datasheet_name = _name,				\
> +}
> +
> +/* Static temperature channels (always present) */
> +static const struct iio_chan_spec temp_channels[] = {
> +	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
> +	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
> +	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
> +	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),

Sorry, I missed this in previous reviews, but what are these channels?
The labels are rather unusual.

My guess is they are gathering up values from across a bunch of sensors
but I'm not certain. They are unusual enough we probably need some documentation.

