Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BF380FF2;
	Sat, 16 May 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778950705; cv=none; b=EBUiKwpZv4WrZ5kmzRL2KI6PU+ok+nGpTo+/RTag8mN+iRHORQFgrKZFUFNFqTzmKUcFbhCcwSHKMmVI2gesxmZ3QQ2ajGcE2q25TV3OPM587KMEn8qsGdkYK7dUCuvRpz5KrLQbyd5WkUKgaltHWQSrIc7H5qUvNiYS0NwOKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778950705; c=relaxed/simple;
	bh=CIwuWhPJ00zkI95FCL1VRyyq54s2jRfGDejHBgfBsxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXZrLr+R+QLmiCd2lGjhuAR6axsz1gbqQJx3U2Pt71f/pOHKm5Tck0NFeaufsLye9Ynde+gFC3WIFJsuCkZzUKUaheRhc+VUHsGNpVajE5dLz/r6kTQGKFT8gOd4f2mRAQ5Fp4VI6ppjB+2wYqwHeBR3O7L4xUuBmZzDh4iJSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKK7KkLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKK7KkLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDA8C19425;
	Sat, 16 May 2026 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778950704;
	bh=CIwuWhPJ00zkI95FCL1VRyyq54s2jRfGDejHBgfBsxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dKK7KkLPvR3B+q9k/SSixSWrdEenZqA8qZfattDLWAEdtBrBoJh82z5lceQWQ2cGj
	 2N2PH2C20+lHg+FfaQ9EXpFK6pBiKeYZglqAD1jOmvEh06mhELDOu7anfM3bfrXhqv
	 GhbpGc5DBdpuVJjcuOWHQFDgvBVwJ+AmDRcQD4+H2Hhu3c9tuJgtFpZbIyrv6FP/xs
	 TpuaumKCWOo0ho6R6MEklFKqNH9h+dddjd3/+2VzouNFdu3fZlwTm6xtbD80qErgVb
	 u6qQ+lO9ZP+BezbYAmXby0iUCVuMJr4sWet61I9EB4M4Y17maL93/LEQrmn2DWNTeL
	 f6IbcIRbnVsWg==
Date: Sat, 16 May 2026 17:58:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] iio: core: Add IIO_COVERAGE_PERCENT channel type
Message-ID: <20260516175814.5748124d@jic23-huawei>
In-Reply-To: <20260514144712.64374-6-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
	<20260514144712.64374-6-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 17:46:52 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Add a new channel type for sensors that report fractional coverage as
> a percentage. The first user is the ADT7604 leak detector, where the
> value represents the portion of the sensing element that is wetted.
> 
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Few things from sashiko that you should address.

One I want to talk more about...

> ---
> Changes in v2:
> - New patch.
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  1 +
>  4 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 925a33fd309a..0570e8b8f5e5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1980,6 +1980,16 @@ Description:
>  		Raw (unscaled no offset etc.) resistance reading.
>  		Units after application of scale and offset are ohms.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_coveragepercentX_raw

The bot raises a valid concern about having the unit in the _raw attribute name.
If there is a scale (which incidentally probably needs adding to the ABI - as
_raw on its own is a bit meaningless) then it only becomes percent after
that is applied.

Perhaps
in_coverageX_raw is the way to go?

> +KernelVersion:	6.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) coverage reading. Used for sensors
> +		that report fractional coverage as a percentage, such as leak
> +		detectors where the value represents what portion of the sensing
> +		element is wetted. Units after application of scale and offset are
> +		percent.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/heater_enable
>  KernelVersion:	4.1.0
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index bd6f4f9f4533..ee8ffa2cfbc5 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -98,6 +98,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_CHROMATICITY] = "chromaticity",
>  	[IIO_ATTENTION] = "attention",
>  	[IIO_ALTCURRENT] = "altcurrent",
> +	[IIO_COVERAGE_PERCENT] = "coveragepercent",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index d7c2bb223651..39830dc0cfb1 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -53,6 +53,7 @@ enum iio_chan_type {
>  	IIO_CHROMATICITY,
>  	IIO_ATTENTION,
>  	IIO_ALTCURRENT,
> +	IIO_COVERAGE_PERCENT,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index df6c43d7738d..3339be7fe32c 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -65,6 +65,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_CHROMATICITY] = "chromaticity",
>  	[IIO_ATTENTION] = "attention",
>  	[IIO_ALTCURRENT] = "altcurrent",
> +	[IIO_COVERAGE_PERCENT] = "coveragepercent",
>  };
>  
>  static const char * const iio_ev_type_text[] = {

