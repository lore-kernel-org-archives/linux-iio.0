Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795822393;
	b=SL7eM4WgNr+BqAd4Ta8P6jz4riprtc7ig544cd1XRODE3aVrhPaE0sE7J8fLgJw9iNVk
	 xU6Hv01dVu0e079EejW1Mc8xzZ7FGHTfP++QikJ7x6n1IqKnDG2sXPWwtwXl+Dp8+yFRR
	 fEoPiiZ2yHvFlxfuyY3Adr+TdV/52/qN4VGWAeRBIceVyQ3rmYB5xaQwQcDDveTpdECXl
	 XyMegWyYZDdMZhdwQPZCbrl3cENSSh7jIh2jvWsBiU+FV0M6KwKItYHG3EReTtOZOaLxO
	 Mmx8rMEemeoWHP3MQbCIE5zLwvyDYsHGM8tkJ3MOHC6pK5ilbUwySl0p5jssFn35VEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822393;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8nngIs7gwvxnYNNnqBOO7c37DqQ6Fbks03ryrz0eP/w=;
	b=ygrrXRdjQQ+BM9tfqKfUgIjO/nnggbOFe7geZteDhNxjWpGffb+wwjDx+UoqgqMQWD/K
	 T2PcYBJBkjWk221Na4Ld5h8FbkrzV/wxvGKc2+LW3vwc8qLQM9TqgAQwq7KIbaVCfuq6w
	 Ftr7pFZzGGEL4pbq5YJcMyuSImEu1KzUuiCEzKtTAEPlkAnzimxcMDsD2QHUMOYyLiHx/
	 fj/+o0fi4+wqBwh85KuiWyMLH5U20R9F5UOU8/qlWxsvzwij5v+zkaC1pGfOohQBS4cAF
	 9bSpekjOItBwBTf49++W2bk7PJkmEA2lfxyoCUXh1oXyWNK8tss7I+BHKJ6TRh7HPAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W8g/xdCb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60C606A32C;
	Fri, 27 Nov 2026 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8g/xdCb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08E61F0089F;
	Fri, 27 Nov 2026 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795822393;
	bh=8nngIs7gwvxnYNNnqBOO7c37DqQ6Fbks03ryrz0eP/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W8g/xdCbOlQ/H9v1E0J4HjojSDxEoiBXVNnYrtokkH0u8DdftHARodaDaffmTdNkv
	 rC+y2nYsnglIk7tDeRLvYHtxjfaY1OwDCVieG5i/pkNpaNerNHAgFAhKtt4NSKJvVp
	 y5T4iRcdaNLd5zQbprJNEznVzDDihvL+TD+wcBUgDjy1JqSpKnsoERI6w0TCd1Of2j
	 rDXWFnshN1OtA7oW+WjplZgZCw0eEkDWIb/O3n3pC+yPnjAYBAwMLy8kZkSPTPAYDr
	 2Ms4e5RNTplUqQGelQ1XuKEN9TIDjatK5V4ZJJLFy93EI95Lwzv5h9N05YYCjnTLmp
	 kYOVxsEvygb9Q==
Date: Fri, 27 Nov 2026 23:33:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux@analog.com>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 0/5] Add support for ADA4355
Message-ID: <20261127233250.30bb880e@jic23-hlaptop>
In-Reply-To: <cover.1795816065.git.marcelo.schmitt@analog.com>
References: <cover.1795816065.git.marcelo.schmitt@analog.com>
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

On Fri, 27 Nov 2026 18:51:32 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> ADA4355 (and ADA4356) are programmable transimpedance, current to bits receivers.
> ADA4356 main difference from ADA4355 is the set of configurable transimpedance
> (Tz) options which result in different scaling to miliampere units.
> 
> Change log v1 -> v2:
> [device tree]
> - Added explanation about why the parts can have a fallback compatible.
> [IIO]
> - Improved backend interface documentation.
> - Fixed mistake on the scale to mA.
> - Made reads to the mA scale also synch with scale write operations.
> - Set buffer setup ops to enable backend channel.
> - Enabled vcc supply.
> - Stop calibration on lane calibration error.
> - Removed unneeded includes
> - Alternative in_range check.
> - Declaring loop counters within loop declaration.
> - Unknown chip ID message update.
> - No longer keeping extra IIO channel pointer in state struct.
> 
> Previous submissions:
>   v1: https://lore.kernel.org/linux-iio/cover.1795003864.git.marcelo.schmitt@analog.com/
I'm sure you'd check anyway but for anyone else reading along, Sashiko
is not at all happy with the binding.

+ some smaller bits in the driver parts.

As such I might take a somewhat more superficial look than otherwise at least
partly due to my 483 unread IIO related emails.



Jonathan

> 
> 
> With best regards,
> Marcelo
> 
> 
> Marcelo Schmitt (5):
>   iio: backend: Add calibration source interface
>   dt-bindings: iio: adc: Add AXI ADA4355 IP CORE
>   iio: adc: adi-axi-adc: Support AXI ADA4355 IP core
>   dt-bindings: iio: adc: Add ADA4355
>   iio: adc: Add support for ADA4355 and similar ADCs
> 
>  .../bindings/iio/adc/adi,ada4355.yaml         | 104 +++
>  .../bindings/iio/adc/adi,axi-adc.yaml         |   1 +
>  MAINTAINERS                                   |   8 +
>  drivers/iio/adc/Kconfig                       |  11 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ada4355.c                     | 822 ++++++++++++++++++
>  drivers/iio/adc/adi-axi-adc.c                 |  66 ++
>  drivers/iio/industrialio-backend.c            |  28 +
>  include/linux/iio/backend.h                   |  22 +
>  9 files changed, 1063 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
>  create mode 100644 drivers/iio/adc/ada4355.c
> 
> 
> base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d

