Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF2395AC3;
	Tue, 12 May 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585784; cv=none; b=QB1aYpyEj4FKbjjI0Cds53rb9knMFfs2/nO0iHQkIQk4wLE3SNf3o6k3rtLoz31VKJOow8pp+tlv+Jo+9VPLT+ye0AIzg1ye3h6vugRVnUIeGwgvKJ/dHoODFe1WJ6FumJ8gSAjZt35sP9TmK1LEM6+rHY8eqJz2SvBoiqVz3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585784; c=relaxed/simple;
	bh=Gpg3egQ6vVUcNICfzOq/Sa6D9k/UQM2BtrpCKf33v2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVIo/eGfsY5pTEXvrpxEY2HrxOlpYbF8wyE8hzpSWGisl0YYS5u9xF+s9WCLGqLyNxRCtvFQx3/3zuEJxyiuVXgM2cpkFHNkctvsXMmCN2i9LvhwkYpU5h08XS5dw4bzaIWxVE2hUZcuZEhRN3Qsm5tZVSWu49rNVAJ+ebvDBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2Rnbnhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Rnbnhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D04C2BCB0;
	Tue, 12 May 2026 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778585783;
	bh=Gpg3egQ6vVUcNICfzOq/Sa6D9k/UQM2BtrpCKf33v2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e2RnbnhjTAo3qtGayxzsmWU1sRgq+V0oZYN23S+Mt/m89xN3VBTL2Ks4pUXdk20WA
	 B/eUGtbj25ODFGRpha1DJ8uzlZlNEXNJKdZ6/VdRd9KLM4eCxCoqIx3mh0bNHurSYr
	 JWzX2y80GzPQHZd3ll9FJ6o3Q8jiTjuAkHls62Au/9bIoJWEboG9K+ti3Wev0bJTvD
	 LBYVypJ9fkLl/9XSUwIDR3A479GhTMKz7IG/zk5J/MenXQCfIoNQEiSBL8+YSZh0ZT
	 pO0KL4C6przBKkXp6EUCPqhL59ubYsF5JaPjYQbIOujYmxIPSXgrLrnsMAU8Hs+VQv
	 CdzxHEydPRT4Q==
Date: Tue, 12 May 2026 12:36:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 11/11] Documentation: ABI: testing: add common ABI
 file for iio/frequency
Message-ID: <20260512123611.2f7369f8@jic23-huawei>
In-Reply-To: <20260510-adf41513-iio-driver-v12-11-34af2ed2779f@analog.com>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
	<20260510-adf41513-iio-driver-v12-11-34af2ed2779f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 13:42:29 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add ABI documentation file for PLL/DDS devices with frequency_resolution
> sysfs entry attribute used by both ADF4350 and ADF41513.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-frequency         | 11 +++++++++++
>  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 | 10 ----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> new file mode 100644
> index 000000000000..1ce8ae578fd6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> @@ -0,0 +1,11 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> +KernelVersion:	6.20
FWIW Sashiko correctly points out that moving documentation doesn't change the kernel version
in which it wsa introduced.  So this should be 3.4.0

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Stores channel Y frequency resolution/channel spacing in Hz for PLL
> +		devices. The given value directly influences the operating mode when
> +		fractional-N synthesis is required, as it derives values for
> +		configurable modulus parameters used in the calculation of the output
> +		frequency. It is assumed that the algorithm that is used to compute
> +		the various dividers, is able to generate proper values for multiples
> +		of channel spacing.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> index 1254457a726e..76987a119feb 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> @@ -1,13 +1,3 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> -KernelVersion:	3.4.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Stores channel Y frequency resolution/channel spacing in Hz.
> -		The value given directly influences the MODULUS used by
> -		the fractional-N PLL. It is assumed that the algorithm
> -		that is used to compute the various dividers, is able to
> -		generate proper values for multiples of channel spacing.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_refin_frequency
>  KernelVersion:	3.4.0
>  Contact:	linux-iio@vger.kernel.org
> 

