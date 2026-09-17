Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56876340283;
	Thu, 17 Sep 2026 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615580; cv=none; b=lcviUsiSz3SqYzXp8MUxmrSEE5LpXwcunwyq9rinvhS7W6PzPtuudKFvV1aJvsXkNNdyEtIY8OOHVBaKbUVOsh9DhgV2BHz9R9wAzoPmMd9S/ZhchBlBNTj9CRu0R3WRc57XnloqGTkWW88oYRUmn8AXoe0n8+35kek/yIn6lJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615580; c=relaxed/simple;
	bh=qLG5r4Nf4sFkJo7dnIe1aj4ukiPZFf2H3TiRKD6xXRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9UqEurypQtLquvYSnhkF4niWeakffCUrvz5Jeg7aGvoajEyExkQ2sTcdz0mlJTHTlk0rvCMWSvoryFgslakmo1nEOrlrZM47Jhfpuzkt/0vA+wkoxA1H3asOSW2JvxEibfLG2tADIt9d7hsNxIAhuaI/0GyDUFgwlrUeT2x3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv0nud5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv0nud5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D1E1F000FF;
	Thu, 17 Sep 2026 03:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789615578;
	bh=FtFGmJfJO3T4WXOPDTbtREiOEu8bk47njQQuAtDlwXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fv0nud5rcXozT9b1AESj7oJRfJyMxyX9cEjAAcjCzw0VM49Fkh7CzMf2ULfiiR2WN
	 EablLOnrU716GHqPI7exDJRV2twktdUp6cwgAjbpI6/6+3dVlD5YFulg8V8SVg5EDl
	 TEGLntj3T3iaS21HWY+1tu00FF0JR2U5tBKjtKqZOth0AbuYwuHOet9Rwa5DpeRdf0
	 khPuKxo8np9vwH51O4JufoP6+MRQk2/IWn2CtN2W/0tqKaWJbByIUS4hLTnJLWxWLo
	 nBB/pjeR5RvMojATlxya4Dc1VLTKYs5coMy7dT/MbdbUt4tSNSpEq6Zg9yQKkvbcdY
	 ilmdjOlYTO0vQ==
Date: Thu, 17 Sep 2026 04:26:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] dt-bindings: iio: adc: lltc,ltc2497: generalise the
 title
Message-ID: <20260917042612.2175ac4c@jic23-hlaptop>
In-Reply-To: <20260915144624.44841-1-andrei.stancovici@analog.com>
References: <20260915144624.44841-1-andrei.stancovici@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 17:46:24 +0300
Andrei Stancovici <andrei.stancovici@analog.com> wrote:

> The title names two of the four parts the schema documents: the LTC2305
> and the LTC2499 are in the compatible enum and in the description, but
> not in the title. Rather than extend the list each time a part is added,
> say "LTC2497 and similar ADCs", as bindings covering a large number of
> parts tend to end up doing. The full list stays in the description.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

This is one where carrying the ack is not valid (unless I missed
Rob saying he was fine with it). The whole patch was about the title
which is now different!  Given the dt maintainers have automation
around this I'm not sure anyone will take another look. Leave
it a few days then send a v6 with Rob's Ack dropped.

Thanks,

Jonathan

> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> ---
> Changes in v5:
> - Only this patch is resent. Patches 2 and 3 of the v4 series ("add
>   LTC2499 internal temperature channel" and "add 2x conversion speed
>   mode") are already on the testing branch of iio.git, so v5 is a
>   single-patch round.
> - The title is now generalised instead of enumerating one more part.
>   v4 added the LTC2499 to it; Sashiko then pointed out that the LTC2305
>   is also supported and also missing, and Jonathan suggested stopping
>   the enumeration and using "LTC2497 and similar" as bindings with many
>   supported parts tend to do. The full list is already in the
>   description and is left alone.
> - Documentation only; no driver change, so no hardware run for this
>   patch. The DC1012A-A validation previously reported covers the applied
>   patches 2 and 3.
> 
> v4: https://lore.kernel.org/r/20260909082755.366269-1-andrei.stancovici@analog.com
> 
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> index c884b6e03767..67445ad2bb3b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
> +title: Linear Technology / Analog Devices LTC2497 and similar ADCs
>  
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
> 
> base-commit: 36c12dbda81c284d72f3c64689461647497b643b

