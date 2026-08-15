Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7838E5E9;
	Sat, 15 Aug 2026 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786823707; cv=none; b=JzmNgmZj7rOWTSyIST9RFEVp/85xMxxOLsOKdo2iQln642TmJcmLy/9P510TzrtMOu+6NTeZhHbIP2opvs2SZpnLt7nDS6Ft/iaxqM5zvO1sNJFRYKABLBk6+LldZnWoSevKtq6myxGOQZREBGOG7sHqQtPhN9fwgh4nhPuaFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786823707; c=relaxed/simple;
	bh=RCNQju28qlnnG5qsWOXtws2ypbIBA0nCs8gnEVRSHHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEwNfkcFTEWlSxDYc+/+k3WSeChp62yiTiWJentBRHtc0QAwoBJBrc/DgyB9a10wjzHHHJQSiW3WWcJw8t8PzKL/eLCKNQXWw+ZEg4l4/B3+PUXenSzA47deP38CyEo3ovJNYiI8mvSfgMN2HMmC1ecKXYqJT9+nfEfKzTHJb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvhmSjN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvhmSjN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17101F000E9;
	Sat, 15 Aug 2026 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786823706;
	bh=kMBKU0rITwY608DxPndNNVbf7wU+s4HDR+nTccA0uZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IvhmSjN8aAXHz8PrcIrzMB3L8dl6qG2M8Zwb+RkTXNfhGQS6qhiYSOCDw6ELzKBmD
	 6To5vP3tkjYUCyWNCCh7B828UbN0ZOSUwG94jsFWD06DtDr7owtOhexlH0l1gIPkri
	 jVO5Cf1Vc6IwNSuKLUvuUMakzljdGJFLIieT1l1FuKBhtc+BzwhwrN4x/ecSmAwitU
	 i6/iUbxrDqZ8pTDddRez90yPqT06Fo0TvsegQ7kMRzm36g4itegxsPwwhh6T2egzwN
	 BOcjI0FwltOeo2CedN42q8n2pZteT/tA0ivEiP3/3yZgh1DWLB90fq8AiocqjhCV1P
	 T0ekcNxNbVmrg==
Date: Sat, 15 Aug 2026 20:54:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
 <joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 01/17] dt-bindings: iio: adc: at91-sama5d2: document
 sama7d65
Message-ID: <20260815205457.6cd30d53@jic23-huawei>
In-Reply-To: <20260806074024.531259-2-varshini.rajendran@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
	<20260806074024.531259-2-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 13:10:08 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add dt-binding documentation for sama7d65 ADC.
> 
> sama7d65 requires an individual compatible to address the differences
> from its predecessor sama7g5. The main difference is the temperature
> calibration layout and its handling.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Hi Varshini,

I'll probably tweak this when applying - but if for some reason
another version is needed please look at the ordering thing below.

> ---
>  Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> index 4817b840977a..e8a65fdcd018 100644
> --- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> @@ -15,6 +15,7 @@ properties:
>        - atmel,sama5d2-adc
>        - microchip,sam9x60-adc
>        - microchip,sama7g5-adc
> +      - microchip,sama7d65-adc

Alphabetical order.

>  
>    reg:
>      maxItems: 1

