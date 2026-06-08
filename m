Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E935F189;
	Mon,  8 Jun 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941484; cv=none; b=bb3/LJZoC37AphY/UHmH/bMmrXoxpfchA7DodXFir0FT8gbSFiN8wz1qiekvHKLlqYd0ntsl2fui1XRQZRJOXQq4rA8tW2OWjAyKVjhw7r4F0Ug8T4L9+OjRWWslHeBbW5l5zzabFlclhPbYYqf53pDPcoGjoh5gQUXutCd/p4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941484; c=relaxed/simple;
	bh=5NcgjT4hZvcU3NIkrQ4SKnV6hudoqNKTZHe6zRsl9cY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieYqHf6zk5t/kV8mCdds9t0awMVmfsvuagJhG7LgyANslhqb4GNVIpbDT0mRjwpm2BxwOdHOCeMfCGMan8zYujeYtTt8mqmoO/6SdZdHHCmA9MsJYfuFE9ys+qJFXbir8YIfSrSO3hi13W5DYJzGqh+zVciv2llGxXhdPRHlEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQR3puUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQR3puUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164791F00893;
	Mon,  8 Jun 2026 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941481;
	bh=BdATdjJ6PxodlNuywaIhmD4mUhh0pmup7ce0aBhkcLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mQR3puUSIcKv6lS3+jugU8AFrpF2/RKq4UtPcE4i44GHLb4+MavMkx+kZrnwAI5gF
	 DybuMSOCaJkVVqkiy5WHWRAV+Y7D6rjm8MI81jkjMkA8NSMDEGYuVljau/tDB7YcXr
	 SUk1RMyUKq3+0ezWWdryJm/zYhmga4LZkduPr4fbTtXXfGcbCYRcPEZZvA5ki+rZVO
	 Hla+UZ2jiEZWMdE6BEnSDsqUBYx9ahgZgl3ZEgH9t+FOI9UmBBea1Sl+Tpd6WzCqlU
	 luHEvgWw+jmbwaV90rsiX6Dj86g2zB0mT1RprkGHktQxXgi4N1sDS03vCaQSfdVGRZ
	 D/tDeKR+2CctA==
Date: Mon, 8 Jun 2026 18:57:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 jorge.marques@analog.com, antoniu.miclaus@analog.com,
 mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com,
 duje@dujemihanovic.xyz, wens@kernel.org, sakari.ailus@linux.intel.com,
 linusw@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Update title and enum
Message-ID: <20260608185750.02c4242b@jic23-huawei>
In-Reply-To: <20260607183542.368184-2-jakubszczudlo40@gmail.com>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
	<20260607183542.368184-2-jakubszczudlo40@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 20:35:40 +0200
Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:

> From: jszczudlo <jakubszczudlo40@gmail.com>
> 
> Add ads1110 into title and enum compatible for ads1100 driver.
> 
> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
Hi Jakub,

Obviously not related to your patch, but can we switch existing
pair of entries to be in alphabetical order whilst we do this?
Normally I'd ask for a separate patch for that, but given it's
so trivial and that would create churn vs your patch, do it
in one go (but make sure to mention it in the patch description!)



> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> index 970ccab15e1e..4c43996b7ec6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
> +title: TI ADS1100/ADS1000/ADS1110 single channel I2C analog to digital converter
This is on the edge of the normal problem of never ending title growth
that we cheat to solve by saying something like

title: TI ADS1100 and similar single channel I2C Analog to Digital Converters

When we do that though we tend to include a bulleted list of parts in the
description: section.  Whilst I was looking at that I noticed we only reference
one datasheet which I'd assume doesn't cover this new part?  Perhaps that needs
updating as well?

Thanks,

Jonathan
>  
>  maintainers:
>    - Mike Looijmans <mike.looijmans@topic.nl>
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - ti,ads1100
>        - ti,ads1000
> +      - ti,ads1110
>  
>    reg:
>      maxItems: 1

