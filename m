Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67D1E505;
	Thu, 23 Jul 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847650; cv=none; b=hXfNOtE5s/HK/lAbxJ5wMUXuRrzThJeIf+hV/QBKY7CcGO5u9su/Xy0brI6fulkYxH9U/UhxT4wncjCEwt/GlnInAL4t4roEFKJFHnKoU4mMm4myHqpvp9RLGZlBu3+iPxW+NXBeTzpj0u1GfA7mWzZcSrbfuo8feWe8qpfcYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847650; c=relaxed/simple;
	bh=MyYBcm0rzOZRACcuAW88z8nMR34DHRdQLtRob5c9LQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UE79uT/khNJt6uC2dkVByLItWqISPIWrcLvsStXMtF1y9Z9f7rUPaxVuqGtTERYST/eVpUDuGsqcdPChlRBlhBitXYAWh8vGAeXUGJkxhdsgU9f+TJ2I0mkFWBe1z8FyWg7EPTSw5ghnWIFQpgq0ymC8E6LoDlSCpQZ2F01yfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diT+k9y4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diT+k9y4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203091F000E9;
	Thu, 23 Jul 2026 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784847648;
	bh=SPMLoYpwJ0Z7SvhrKhc4UEOkKChMILIGRhgOdnAF4TM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=diT+k9y4juzTasJHqvBZ/0ENISn8XkAtug4O9Lffg6HMC30k9g1d7izvoCBhiJTYC
	 Y9FZs5698DBLx5+PBJoPxiBUxmfAaJecRJroyj4niHH4782mzL68CDcOXV183aCO2a
	 TkIB6j5akIkgtdZCz/yBAP/AYqmHkNgtc+DT1uEPnNQJJ51g4I2YO3Ef81q+xtdRfe
	 963cJtB2pXb9Yj7FJyAX04I463t54IKffPV5IfM33ewks/YeSoighCnj+FzOgFGa+z
	 Li248P1m88P2K5dAFDtp67TwCH495c7ahom49twda+/4+gmATy8johfTsWKBk5H7J7
	 amKU7fe+g7jfQ==
Date: Fri, 24 Jul 2026 00:00:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: adc: ad4080: add support for AD4883
Message-ID: <20260724000042.21d0c56d@jic23-huawei>
In-Reply-To: <20260720133707.103366-1-antoniu.miclaus@analog.com>
References: <20260720133707.103366-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 16:37:05 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4883, a dual-channel, 16-bit, 40 MSPS SAR ADC in
> the AD4080 family. Like the AD4880, each of its two independent ADC
> channels has its own SPI configuration interface, so the part requires
> two chip selects and two io-backends.
> 
> The first patch adds the devicetree binding compatible string; the
> second adds the driver support (chip ID, channel spec, chip info and
> device-table entries).
> 
Given how trivial the dt binding is I've picked this up ahead of getting
the customary ack.  IIO is very active at the moment and I'm trying to
reduce the number of series in fight where ever possible!

Applied to the testing branch of iio.git.

Whilst there is a fix series in the fixes-togreg branch at the moment
it doesn't overlap with the particular areas of the driver so it should
be fine for them to take different paths.

Thanks,

Jonathan

> Antoniu Miclaus (2):
>   dt-bindings: iio: adc: ad4080: add AD4883 support
>   iio: adc: ad4080: add support for AD4883
> 
>  .../bindings/iio/adc/adi,ad4080.yaml           |  2 ++
>  drivers/iio/adc/ad4080.c                       | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> 
> base-commit: 7961435cd21903f761712cdf8fe3ed5ea24ebdc7

