Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579936;
	b=dhvH3ZPXMQDNUW0Om4yldIgD3RKv4elie7cvJtEREI2meW7B7VEIErS3EwulOFAO4Bhs
	 Iysywx3sqWk47SutlJLk0Ln2MSK//yP7nvnP1gN1Mr1vbaWWcKA8KNz9MpdTY2/qFZHpf
	 7JCSFV2hye/EiZyLifRSFUzaDx6HrkRRvBhcVH1w/1mzabBLivgEgRuiIKyKZYbJUhkCV
	 3/ai1IL15E+yiqcMl7od4ZcPwIDpJp7Ky5ZW8KjdiQ76qx/QEVglDpHf91iTTuqdnT+RE
	 6pwy/P7GF2wPMLzst9+Sr9j57X9cLSWK976AGQL0AKVXeLMCwZpHK+cPQYQJjkjJzBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579936;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iPdpKJXi8RfcmX40aTJs1ytH9Wi9hRg6/+LGPmxS/5M=;
	b=ZtqaX/VKf++BkqZhnYatiFxF7YOghUCX4vOE2ctBSdeJLOWlFChuA/pC+4eEzfyxl+nY
	 ayNig+leijz3lt1A39nmr4wTtsQZQK1WWUg7QE5T8WNASw3xbCBvEi/4h59k+/QKq7jvJ
	 uhMAZlKkHC6G2PtapnVQu+VOdk7LsMPzkPmKjvENqshET7krdJ49bqWt7H+lXi7DNcyr2
	 XSbBD5DYHx6v2QZMXGf25idiGJTsOgPv8bwSRDVVeewLCnbg8Eeb7XvQCyo74faUoYwck
	 znm0UNCIbdxboo707kldqqsH3+tEkywhb+SffvoCOYbhl6n7n6vMDt+xEBeCZuuU6KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgHsqs11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DA606A327;
	Fri, 13 Nov 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgHsqs11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEEE1F000C4;
	Fri, 13 Nov 2026 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579935;
	bh=iPdpKJXi8RfcmX40aTJs1ytH9Wi9hRg6/+LGPmxS/5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FgHsqs11QfRipLad4Rw6gJ9/LIQUFB0kN2R02FuNVMWvPbey56DXGDHs7FK/sLPmY
	 P9/7fJ/u2ggeVqM4bCB+U9WLZ9fH3EDJMkekRm2IFEWy09XSBsb8xje/OC6TDfM8hW
	 06Kp8RDbuVJhzQ9gmjH3HWNIRZqNIS6s/3/TB6Ic6mrwARPEXuvdDwpjxgl71sSV7v
	 bUK3GAwT6o+SLdeebJh+c5WGaVTldlfavWMwrwCBqFEG/qEXtii+C+DjGrQzXsOPai
	 K7UtK1KRiF5fXXaDNoMrVifE7wNBtA6q/ehoIy77f3/5EHbY9AZRxpepofK54TB8BS
	 cRfqGbFWscRng==
Date: Fri, 13 Nov 2026 08:25:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-pwm@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	Jonathan Cameron <jic23@kernel.org>, linux-doc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: iio: frequency: add
 adi,ad9910-axi-backend
Message-ID: <179457993302.748838.1907399146153848587.robh@kernel.org>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
 <20261103-ad9910-backend-support-v3-3-0e9224ddf7b7@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-ad9910-backend-support-v3-3-0e9224ddf7b7@analog.com>


On Tue, 03 Nov 2026 11:52:59 -0300, Rodrigo Alencar wrote:
> Add bindings for the AD9910 AXI backend IP core. The FPGA IP core
> interfaces with the data and control pins of the AD9910 DDS, streaming
> data from memory via DMA into the 18-bit parallel data port (F[1:0] and
> D[15:0] pins), which is clocked by the PDCLK output of the device. It
> also drives the PROFILE[2:0] pins and the DRCTL pin, which controls the
> slope direction of the digital ramp generator (DRG). The DRCTL pin is
> driven by a PWM generator, so the IP core is described both as an IIO
> backend and as a PWM provider.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../iio/frequency/adi,ad9910-axi-backend.yaml      | 74 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 75 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

