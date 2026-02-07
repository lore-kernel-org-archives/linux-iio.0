Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A09299AAB;
	Sat,  7 Feb 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770485109; cv=none; b=fUUCMKX+nDau9/QyeemKjUPD1qkvp2zoS1iirbhc2yun18JZ9NDHjXIr+gFJz9lk1wsDh1+Jhn441mZIy9aXl7WYKrl3VYS53UIntl5W3BAyxc9nnXkNGjzkgppQJy3NDnvXRU3zGykcznuFjMBpdxB7l3u2jKsuh1v/BzGRphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770485109; c=relaxed/simple;
	bh=h1oFhv/nEudSAq5PW00qDzY1t8sDxQg9k8HK1ITTZow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ledz+2LbmgczKtAGqaWAaikVN6LHpLYIhRF1aIPnURgG8X1+KL3q9+7KWbBtdEM5W9VHU6+6hs7ZySQmUprOAkGJxdgRXHVIVSSab4ueGa87b2bWbFBdEIR4/bkGdMPkolqoxLyEMnk5KvpJS8Fvt8tboU0C5gWy0ZZqajl1CSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRxwEmMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRxwEmMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7675C116D0;
	Sat,  7 Feb 2026 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770485108;
	bh=h1oFhv/nEudSAq5PW00qDzY1t8sDxQg9k8HK1ITTZow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gRxwEmMG+QwY0MCUj8pqE7OKm2rsUqfx3VIspxPte5MplJ3P7/h6f/u/j5Kz0OvU2
	 /m+l97dRfxaEcXoremhMS1C7n2Fh3bbPBsOJetC2IAcRaD3EgWeQnxDPJkHOnDXcw7
	 r4uhHFLzq1u7f1prsE1D4i5+/JkIv5loYXMk7A5M7ek5LB93x57hWv7RfISirla/49
	 lsQaZDH6scIC+vXvm8A+PaVVGj22AG7OlEETfYC2hlGwf7GVAN7rYGNbjbZoDyUGRE
	 9EoXAVVA0dDIXCUScrJiTmDpSEqIbC80VgKX5BxUjZJxqAQwB3uMrGkkmasgzIIs7Z
	 spMMsO0o2inuw==
Date: Sat, 7 Feb 2026 17:24:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 8/8] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Message-ID: <20260207172458.7f2cca90@jic23-huawei>
In-Reply-To: <20260130-adf41513-iio-driver-v6-8-cf46239026bc@analog.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
	<20260130-adf41513-iio-driver-v6-8-cf46239026bc@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 10:06:49 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add ABI documentation file for PLL/DDS devices with frequency_resolution
> sysfs entry attribute used by ADF4350 and ADF41513.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-frequency | 11 +++++++++++
>  MAINTAINERS                                       |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> new file mode 100644
> index 000000000000..1ce8ae578fd6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> @@ -0,0 +1,11 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> +KernelVersion:	6.20
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Stores channel Y frequency resolution/channel spacing in Hz for PLL
> +		devices. The given value directly influences the operating mode when
> +		fractional-N synthesis is required, as it derives values for
> +		configurable modulus parameters used in the calculation of the output
> +		frequency. It is assumed that the algorithm that is used to compute
> +		the various dividers, is able to generate proper values for multiples
> +		of channel spacing.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d9b7cf86aec..748eeb6f5bd2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1639,6 +1639,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-frequency
I wouldn't add this here. Whilst for now we only use the defined
ABI in this one driver, I'd not expect it to stay that way.

If we do think it is very drive specific move the file to
sysfs-bus-iio-frequency-adf41513


>  F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
>  F:	Documentation/iio/adf41513.rst
>  F:	drivers/iio/frequency/adf41513.c
> 

