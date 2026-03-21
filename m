Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4F2E093A;
	Sat, 21 Mar 2026 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774092355; cv=none; b=QdSdfLnIefMJSfwhzyCLvbQLwy2iUIfvHNa6TtlTSLnRjgYoSAW5LLTg9qLMLYZtS3ioJMw88lZYInFj56hMmzuG9IZ9wWC9r8D8QHRNG0WA57myyF/2UQYQowYUtESegqfc65bJK8MQC6zkhtnpBl+PFK4WGkI5/R5Hf+Lsjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774092355; c=relaxed/simple;
	bh=e+XpW8dP/OzHkIaUBSJbITfqdjL2YwKX+19fbhh8Nh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XV2BhouSlbNuOiagxAIJ7rGHxihOOsdM7lH37PFybixI6cgO4/1Z7sVzZ5fDhPOV63E0iOAFpXvREskpT25X2I6zS8yInvHTS34UIZW8Ix3hc+9oHbkp2c5XuT+wEFAYsvK4SrDq5nYAWADUTvaK0YsEPDv3s8HxCUJEihxcyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wiaq3Lba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wiaq3Lba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BDAC19421;
	Sat, 21 Mar 2026 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774092355;
	bh=e+XpW8dP/OzHkIaUBSJbITfqdjL2YwKX+19fbhh8Nh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wiaq3LbavmbvnpPKuURINPDGxT5Fs5bMxryI3f/CL6t3QBBnnPJ2Ahtp4kbHZ/kv7
	 HWsVqdllyCUmS35KYSserHlQVbgDo6lSS6+CDJyl+HVOebZrjx2BYIWXhcLr9hpnE8
	 uJGlB0kBgS9FmYGI3A/3Ac/W1ccISleZ3DcMJlSoDSV90tRmiXdFmHXjyCSNHLVuCG
	 rVNzOXE1KZd0e/bzTojW5JCPCfQ/InWkdeWCFwzn/6LHckLJ6qtfuPRRI43SEWjifB
	 IGuBaMTO7ujb+SKRev9JFn4FeXsQgIubCddUk71kOFSa6zB8tTT0sDs6i349eN08zD
	 EkfjxnmPH2meA==
Date: Sat, 21 Mar 2026 11:25:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Petre Rodan
 <petre.rodan@subdimension.ro>, Jorge Marques <jorge.marques@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] iio: accel: adxl372: add ADXL371 support
Message-ID: <20260321112545.06498a9b@jic23-huawei>
In-Reply-To: <20260321100729.2440-1-antoniu.miclaus@analog.com>
References: <20260321100729.2440-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 12:04:55 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the Analog Devices ADXL371 3-axis, +-200g MEMS
> accelerometer to the existing ADXL372 IIO driver. The ADXL371 shares
> the same register map as the ADXL372 but differs in ODR/bandwidth
> values, timer scale factors, and has a known silicon anomaly (er001)
> that prevents reliable FIFO operation.

Applied with minor line break tweak in patch 3.
Looks to me like you've addressed Andy's comments and there was nothing
else outstanding. I'm applying this without waiting to see if Andy
has any last feedback mostly to make life a bit easier but cutting down
the number of series in flight!  

For now pushed out as testing, as such (for now) I'm fine tweaking, dropping
or adding tags if more feedback does come in.

Thanks,

Jonathan
> 
> Changes in v4:
>  - [Patch 1/4] Reformat info_mask_shared_by_type to use consistent
>    multi-line style matching info_mask_shared_by_type_available.
>  - [Patch 1/4] Drop trailing comma from ADXL372_ODR_NUM enum
>    terminator.
>  - [Patch 1/4] Drop redundant NULL checks for chip_info in SPI/I2C
>    probe functions since match data is always provided.
>  - [Patch 3/4] Use 'if (ret)' instead of 'if (ret < 0)' for
>    devm_iio_trigger_register() and devm_iio_triggered_buffer_setup_ext()
>    return checks in adxl372_buffer_setup().
>  - [Patch 4/4] Drop trailing comma from ADXL371_ODR_NUM enum
>    terminator.
> 
> Antoniu Miclaus (4):
>   iio: accel: adxl372: introduce chip_info structure
>   dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
>   iio: accel: adxl372: factor out buffer and trigger setup
>   iio: accel: adxl372: add support for ADXL371
> 
>  .../bindings/iio/accel/adi,adxl372.yaml       |   9 +-
>  MAINTAINERS                                   |   5 +-
>  drivers/iio/accel/Kconfig                     |  12 +-
>  drivers/iio/accel/adxl372.c                   | 300 +++++++++++-------
>  drivers/iio/accel/adxl372.h                   |  20 +-
>  drivers/iio/accel/adxl372_i2c.c               |  17 +-
>  drivers/iio/accel/adxl372_spi.c               |  17 +-
>  7 files changed, 244 insertions(+), 136 deletions(-)
> 

