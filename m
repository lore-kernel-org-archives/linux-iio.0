Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498869;
	b=LoJpj9gzEe5LN9fxDd4Co74K+MFgDvuWVMIUEWw8mrz1WAxlj5NR5K7wZyWIl3Vftwga
	 FwW6smsPM51s/T46mg3cNrBIApeXA+oX1OZ49lUREUGpFMSylVNt0mU4apxaEKTkJXz6/
	 5UpedJSjBtcNOJO12GUKTovUdyM7+Ij3Swm/AbTTXLIR7rRBr/h7afXPl46TUIjzaZzlo
	 no5LsPb/ttYhILTESd/CGYf4RZCMvqCo9eedcA3dwSSuZJvu/Tizm2A9Bd449DAF5Uqtz
	 axnUYzBF2oOymtvB+y6f4xMAenBa4dQrEFPvbC95uTK9i5s8Xuu0ASUXYjNrkq1wsgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498869;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7FqCNCiJJeh+jYJp8CROnWa4/dpV2I+dALOUk6aQY+g=;
	b=eA4Xw8dPDeDZ7ybKygXcGOvzZDWcTDLkZ6qWL0gAYdjAgoTtb4gUeV2MtAJ/hx26KBfl
	 KSDyZwRcqcixRUwExatPH0r+SZWVvg839kmvhg1+6KTUxmpiOsEsIs9K6UN+LhCcItJBy
	 9w9Gsu49gBvEdSAWghTRMEOTz/GceKvtuiZGTOaaTcNh2ClVEEB5P7wr62+NXYbH1ChYc
	 Vimw+AtwchGVVPsQT183K625l5iGfnYxgAig1eKm4/Ya98uaw3Dc7t3gqhEeDcoXCItWu
	 c5YgkOV1dD0q/dCLq0K5uCSSmi+3p13hGZj/dGj2l6L8UwDmOEvt2enkSW0DBuFDgzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvEsr0DD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18839606A324;
	Sun,  1 Nov 2026 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvEsr0DD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1C81F000C1;
	Sun,  1 Nov 2026 02:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793498868;
	bh=7FqCNCiJJeh+jYJp8CROnWa4/dpV2I+dALOUk6aQY+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KvEsr0DD62nEK2cv6iq5kFw0KXPC6JIU2zNzRJgkKe78Gi+S5p3NEu98fdm5VX/Xq
	 uDpkMHwK8RJ4Mn5ZqlGE8rCEyC7fW/ZVUsy3vcjnHqy7lcTUYWrJKiTBLbsc2lyBpg
	 9pfWwvuxxGKa5swlpfh+hv7D1l2PeXmuaKR5IOYkkWUjpnoWV19mrRWmxmlivBE1YA
	 fvrSgrLHLjZkqVorjc3g6RvUohgkkjD6WuzoKZVoBmIDKR/SwMbZiiN1ZWhGJIxOQF
	 OQWd+FXxki2er7XxYcj74s4wQKgLrylkIerf6Gd/yrAt6qrYmkewg7dlzCpucHQIfX
	 FbbUmTsk6UioA==
Date: Sun, 1 Nov 2026 02:07:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v4 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261101020740.4fbd4522@jic23-hlaptop>
In-Reply-To: <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
	<20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 14:19:06 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage, average power, accumulated average
> power and energy over an I2C/SMBUS serial interface.
> 
> The MAX34417 datasheet only specified on how to calculate the
> accumulated average power, but with the Sample Per Second rate
> we can easily get accumulated Energy in mJ.
> 
> By default the IIO driver only supports single-shot Voltage
> and Power sensing, but the accumulation can be enabled by
> enabling the Energy IIO channel which then enables the
> Continuous Accumulation Mode.
> 
> The counter is common to all channels, so when reading a single
> channel we will copy all accumulators to registers, so in order
> to permit reading individual channels we must accumulate the
> other channels in the driver when Continuous Accumulation Mode
> is enabled.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

FWIW I took another look and don't have anything to add to the
comments of others.  With those tidied up hopefully this will
be ready to merge.

thanks,

Jonathan
