Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAE3112AB;
	Sat, 21 Mar 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774095925; cv=none; b=rDzUJPZOft9TbJg9bWZUEOWv4TG01EE5KU7JOZS8ZkIsQupUUgvfuDSAf4bmQeujTy9t+kv8JNOd4YwgWPGWoPFs98mKLezzRHpF0/dfnjK0VUo0DvMsEtVXPLQ/PAs+fA7QBTcwjhkq5Y9559wNuiuNIvFLLkFlE103X8NykzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774095925; c=relaxed/simple;
	bh=iuEyECH0QIxCvZQCIFVDc4Ky8/6AfH2F/jbQ1Zw4Ruc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHHA567zhFrqHUdGziFCC6ypXaKcbZ9IXU/en7KSzb1bTInILMNqeUm4YnCyu30guBtN8LAQwyzznhf0grsK5k3WdZF0zstiWL2OT/2634jGLHTulRqKkcw+aUMnOJq8Hj9R68JKFn/eESDCbSOOEQ+DMPqTjHp80q2BYbmuQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypuv+Xd5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypuv+Xd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB1CC19421;
	Sat, 21 Mar 2026 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774095925;
	bh=iuEyECH0QIxCvZQCIFVDc4Ky8/6AfH2F/jbQ1Zw4Ruc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ypuv+Xd5TLN2Nm53Ai2ZpliVNqfCDWZ12l/UVtx/xaY48wzmKop5qjUagkfrG4cnX
	 0yjhkg9H18OVDyrY9hWOKFlx+yubmrQEimmIJnTP0HBBpJq/vqZCpRT46ufx68FflK
	 GSH7JQXIfdTlN/xMJqqjUbJOTuluxC7ZxzBYeQNAt0LJoswjnm1MVbcrgafey5G+Rt
	 d8J3s4ZZN1h23wqQ7CRJhQV0YOA/3uXHeDBsFIXC/FLpyB5sIz9/NcmD24wCaZJkVh
	 zibhh5LhTx4rEC+bViBEj9R4RTmasgpNFRqkAleIVKv4zOIGVmspPE4E0D3FL6RbsP
	 N3JsSXMUGyr3Q==
Date: Sat, 21 Mar 2026 12:25:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260321122515.47fe0023@jic23-huawei>
In-Reply-To: <20260321100154.1258-1-antoniu.miclaus@analog.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 12:01:50 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> Architecture notes:
> 
> The AD4880 is modeled as a single IIO device rather than two independent
> devices because the channels share power supplies, a voltage reference,
> the CNV conversion clock, 

This might be worth confirming as the datasheet I found implies they
are separate - if there is a section that says they must be wired to the
same clock, please add a reference.  They aren't wired together internally
and in LVDS mode I'd imagine they are kept separate to make signal timing
simpler as each complete channels worth of LVDS are in blocks in the pin out.

> and a single interleaved data output stream.

Aas per my (very late!) reply to v6, is this true, or is this down to
the backend? My reading of the datasheet suggests they are separate
interfaces from the ADC itself.

> Splitting them into separate IIO devices would make synchronized
> dual-channel capture impossible from userspace.

Would be more complex and require some extra glue logic in the subsystem
I think, but not impossible. Just hard.

> 
> An MFD approach does not apply here either - the channels are not
> functionally distinct sub-devices but identical ADC paths sharing a
> common data interface.

As above. Not seeing that from the datasheet. I'd change these to say
that's the backend constraint.

> 
> Each channel has fully independent configuration registers accessible
> through separate SPI chip selects, so per-channel regmaps are used with
> no locking between them. The data path has no software involvement at
> runtime: the CNV clock triggers simultaneous conversions and the device
> outputs an interleaved bitstream captured directly by the IIO backend
> (FPGA).

Again, reference for that interleaved bitstream.

> spi_new_ancillary_device() handles the configuration path;
> the IIO backend handles the data path.
> 
> The debugfs_reg_access callback is not exposed for the dual-channel
> variant since the IIO framework provides a single (reg, val) interface
> with no channel parameter, and exposing only one channel would be
> misleading.

Leaving that for now is fine. Can revisit if we care later. Given
it's debugfs and mostly useless after driver development is done
I doubt we really care.

> 
> The AD4880 is a fairly unique part - having separate SPI config
> interfaces per channel with a shared interleaved data output is not
> a common pattern.
> 
> Changes in v7:
>   - Drop debugfs_reg_access for dual-channel AD4880 variant
>   - Pass struct device * to ad4080_properties_parse() instead of
>     using regmap_get_device(st->regmap[0])
>   - Use 100-column limit consistently for function signatures
>   - Add architecture summary to cover letter (per Andy's request)
> 
> Antoniu Miclaus (4):
>   iio: backend: use __free(fwnode_handle) for automatic cleanup
>   iio: backend: add devm_iio_backend_get_by_index()
>   dt-bindings: iio: adc: ad4080: add AD4880 support
>   iio: adc: ad4080: add support for AD4880 dual-channel ADC
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
>  drivers/iio/adc/ad4080.c                      | 231 ++++++++++++++----
>  drivers/iio/industrialio-backend.c            |  59 +++--
>  include/linux/iio/backend.h                   |   1 +
>  4 files changed, 273 insertions(+), 71 deletions(-)
> 

