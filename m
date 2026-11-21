Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795226892;
	b=UCuN4bTstlWDF8Rt8LWvkymf5jNSkF/QEVHu+0kuuWNZU73D609Wp1XSqRfcM1zQTO6Z
	 8VSLhAUFGUJywIZQZKlnKNklU5/RLSRpfJyAkVS7UXoEI5s3SIsUeIKCy9buSDYjHbAVJ
	 bEQkEkpSOI2Ftvfv5QeD0m6tUDvprwFgK2PRY9ugWYSrsEtGoou0XnqyPE9Jw6Zqy8ZG5
	 vI6zz22YUwlOMy31RoaoG86HNq42mQ7XUd1FlWAAMS2INGEJmi3IQmOUm7pB1VcPlxcbq
	 CLwiWmNiFqHXcZ4zk5rZtH+t9SGVReblMLo9hfJHbRtcaZtwywZtHdRfE8ik8jNfW9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226892;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BahDE6s5R1VGugdoTMQHJsCnR5ZeNY43u7fcH5jf3qg=;
	b=beLoX5yfB3n5mQLsDZYyhe7fVtrdO0Ce+FPpKTdJLHqU9NsebZ1lw1CBE0pNUk8tqP5K
	 6Gnbv+mQK6q9g6pe66AC8tfvv4oniGrl4qN1mPwnyqJtOzC6Oy+FgQzI9GbsIiXMLkgF6
	 KEm4ru41/z6mJACmNs+hLStrGwLYQwUF1Zt5W8hDItweHZOf2gqaOEpONB8pLZfFNuUXO
	 scb4ztOId31WtRNPlez+Os2crhFOPxu1cZcHeDuq97KbFFCHwnJSkHLr6tM1NTKtbSE+W
	 A8xEYK10N0j312aooBavYb8fLukoymvch3sNcqO0FX1g8xTHPr12q4B0A2woSZouTow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXJC5ZMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA23606A690;
	Sat, 21 Nov 2026 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXJC5ZMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10FD1F000C4;
	Sat, 21 Nov 2026 02:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795226892;
	bh=BahDE6s5R1VGugdoTMQHJsCnR5ZeNY43u7fcH5jf3qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XXJC5ZMdZajVmu5iFAuQwEWK+z7Pekkk8m2B+7eSFCPe1fWCSdWeer/eB/66lhvIz
	 FPKjhi3ABA8vm7qGtKOgr2uw3dQO94g/FC7A554xAwGXiKI1KFktcn5kYM4SL/8F7c
	 ucrs0wG/yZfgWDmsWrXDS6+Vzn/ghI1Am4UJdEHEdfaOJP12r27U5PlBRMjI0FRy/O
	 sNTvRoqVtzEf9aEQCVdy1Lq/1kAezvRYwVv3lNm+992SgRK0mxHBbsH6O25igJkQPJ
	 8gjcRhAtCfVhWHhlX3y+sEXpMvJ+2gj+42wmxXOOhkcl378jQiP61vh0ygbrwJMBZT
	 iy0JaSEC2qoJg==
Date: Sat, 21 Nov 2026 02:08:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: ILYAS NHASSE via B4 Relay <devnull+ilyas.nhasse.skf.com@kernel.org>
Cc: ilyas.nhasse@skf.com, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adi,ad7124: make interrupts
 optional
Message-ID: <20261121020803.3bf00a33@jic23-hlaptop>
In-Reply-To: <20261120-ad7124-no-irq-v1-1-7826c5c3fd25@skf.com>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
	<20261120-ad7124-no-irq-v1-1-7826c5c3fd25@skf.com>
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

On Fri, 20 Nov 2026 12:26:47 +0100
ILYAS NHASSE via B4 Relay <devnull+ilyas.nhasse.skf.com@kernel.org> wrote:

> From: ILYAS NHASSE <ilyas.nhasse@skf.com>
> 
> The AD7124 signals the end of a conversion on its DOUT/RDY pin, which is
> also the SPI MISO line. Using it as an interrupt requires the board to
> route that pin to an interrupt-capable input as well, which is not always
> possible, e.g. when the ADC sits behind a digital isolator that only
> carries the SPI signals.

All that matters in this is

DOUT/RDY may not wired.  The next bit is useful for why we can support
that case.

> 
> The end of a conversion can also be read from the RDY bit of the status
> register, so the interrupt is not needed to operate the device. Drop it
> from the required properties.
> 
> Signed-off-by: ILYAS NHASSE <ilyas.nhasse@skf.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 2e3f84db6..875f46477 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -76,7 +76,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>  
>  # Can't have both clock input and output at the same time.
>  not:
> 

