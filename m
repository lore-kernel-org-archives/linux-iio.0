Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C19288D6;
	Sat, 14 Mar 2026 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773488225; cv=none; b=rEx0Ba5hbjJ0hFWu/cMuBsOQwLo2GnbfiNTI4qQKvOZ4M5s3ftnv88KrpmtXTa3+6+xovh7E4s5we+72lubEMPO0fbo2aQKAdVLMu15A2mFcA8ME4HpGMg7lCV3qvFN6T0y5zyqvayN9FqOVogqxonE4lRal6vaniybsZ34/8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773488225; c=relaxed/simple;
	bh=+I1vpztz0Fs+olHCNWhnMMvy8X93cDQgQm68gTo+xcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osplWgXDYygvUAxcX29i4n/fOPjoDiBdB/EjupS1VM8I1iN1Xhq3c0NO3AK3mPT4JV2weIlF9pycAG47Dlsm883kDLdOSYNYJ2ZyYNi+yx4yCt+gN71hoLIvGOTSGIW+6rOGTjURGw9LE6TXXInuOiOr2PEMJ8uHLPWkHQfJ8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGkJekOI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGkJekOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF31C116C6;
	Sat, 14 Mar 2026 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773488224;
	bh=+I1vpztz0Fs+olHCNWhnMMvy8X93cDQgQm68gTo+xcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JGkJekOI/c7F4i7Gq1pAmWrGqz7mTE8kedKrMXPJHxqufmLSLERbgyQChLUccahN4
	 B+SHKP7mVSx86y2Xfpj5MH4kEe1TZZL0xMg6zoc+8ALNCSNQorgitf7D2qfAhtale0
	 ScruvbmcKayMwLujJIeD7dazM+H04YqDqKpGxldDLB+5Ql6pAla9O1Yqnd5N3TwNzh
	 WPK8Ge6jYqlnFper2c1nMN0W7B5U0JUG+HKdvCSRXzdlTLxza5cPHFHvOR5tyEAT3d
	 9tVg5o8mthqdF3goajFEmFou+ibhvE27mNVI41+z/DBrWiUNkZ7NwFKS9Bmd9Hktm+
	 UQNW9U/QHTHBQ==
Date: Sat, 14 Mar 2026 11:36:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260314113646.7b36030b@jic23-huawei>
In-Reply-To: <20260305113756.47243-1-antoniu.miclaus@analog.com>
References: <20260305113756.47243-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Mar 2026 13:37:26 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
> the same family as AD4080.
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface and LVDS data output. The driver uses
> spi_new_ancillary_device() for the second channel's SPI and requires
> two io-backend instances for the data interfaces.
> 
> This series includes:
>   - Use __free(fwnode_handle) for automatic cleanup in iio backend
>   - Refactored devm_iio_backend_get_by_index() for multi-channel backend lookup
>   - DT bindings update for AD4880
>   - Driver support for AD4880
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf

Series applied with that ordering tweak in the new backend function patch.
Note that this crossed with a new device being added to the driver
and so it took a fair bit of conflict resolution. Please check I didn't mess
it up. 

Applied and pushed out as testing (subject to exiting a tunnel under London ;)

Thanks,

Jonathan

> 
> Changes in v5:
>   - Drop the SPI patches (already applied)
>   - Split the __free(fwnode_handle) cleanup into a separate patch (patch 1)
>   - Fix "Get's" -> "Gets" typo in devm_iio_backend_get_by_index()
>     kernel-doc (patch 2)
>   - Declare loop variables in for-loop initializers (patch 4)
>   - Drop redundant num_channels > 1 guard around ancillary device
>     setup loop (patch 4)
> 
> Antoniu Miclaus (4):
>   iio: backend: use __free(fwnode_handle) for automatic cleanup
>   iio: backend: add devm_iio_backend_get_by_index()
>   dt-bindings: iio: adc: ad4080: add AD4880 support
>   iio: adc: ad4080: add support for AD4880 dual-channel ADC
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
>  drivers/iio/adc/ad4080.c                      | 230 ++++++++++++++----
>  drivers/iio/industrialio-backend.c            |  62 +++--
>  include/linux/iio/backend.h                   |   2 +
>  4 files changed, 278 insertions(+), 69 deletions(-)
> 

