Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D088305E32;
	Fri, 13 Feb 2026 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969249; cv=none; b=L/WWzXkmbns2JAIB15xF00E6S/Zp6kBEhTK2LzD1RWUzY9SWABInk0fbeAb3m4HKwwEOCRhw1bbg8UOeB1uVx4qzj/xJ8qVmlL3h7JlphwRHpPbV3xa4k5x4f1Li2yjUEZfynsxvnov5ew7CqNcQNXwQiUK2TdoOPkqI7Je2Eok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969249; c=relaxed/simple;
	bh=fyBZBOvRm63EDEk40xoiwwcRMLnqBiSK5e6jEdumIhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z16OxnT3t2cWH79oc5Q7/AiDvConL+0p3XKnYX93lyiqfqy0mysP86U+Cn2froMRoEY/Vhc3Uob4xc18en8VBMP6avDdgc73+ZXQX38mp/QVQkWST096yBuO2EWg8jZWikBFY7M1G146aofnPsdQm9Rd34kLdzFgqwv/D+48174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSQER7Qt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSQER7Qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AC0C116C6;
	Fri, 13 Feb 2026 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770969248;
	bh=fyBZBOvRm63EDEk40xoiwwcRMLnqBiSK5e6jEdumIhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSQER7QtxLkW6KVIUaosZ3F51+neBscYBbgVcl7FtPjEYXEMLrpEU8FIVDGnLnp1N
	 ngJsm96F+rnE7CgNshR/woYsGthxTNLDK6Wr/xEzoMAto/jhgZJ2QtKyr5lL0KpSzD
	 pTb4ZfsnvHDgpnvnY8UA7rX45ZYvjeC5vmFUXrrq/avmSjwKQp4QDzm16R7lhIwynf
	 /yKDSF8fg/8SdNPiGsYPbOHciVSQlPxFaocZWEYsJtLGnCbsuHbfRqo/DVXkku49a1
	 ZYKcrutfDRksF+pNqQQD4N0iRApLbTqnQdtlh1/hXafDt2Gay0ljxf3ykfIhSZWpN3
	 P0h03W4Y0CnJA==
Date: Fri, 13 Feb 2026 08:54:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Message-ID: <20260213-unyielding-pistachio-ape-deda74@quoll>
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
 <20260212-cm36686-v4-1-8f587d4a72bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212-cm36686-v4-1-8f587d4a72bf@gmail.com>

On Thu, Feb 12, 2026 at 04:42:47PM +0200, Erikas Bitovtas wrote:
> Capella CM36686 is an ambient light and proximity sensor developed by
> Capella Microsystems, now a subsidiary of Vishay Intertechnology Inc. It
> has an I2C address of 0x60 and is fully compatible with an existing
> driver for VCNL4040.

I wonder why and how...

> Capella CM36672P is a proximity-only sensor that
> is fully compatible with CM36686, and therefore with VCNL4040. Add
> compatibles for cm36672p and cm36686, with a fallback for cm36686 of
> vcnl4040.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> index 4d1a225e8868..2ba4d5de4ec4 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> @@ -18,12 +18,17 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - vishay,vcnl4000
> -      - vishay,vcnl4010
> -      - vishay,vcnl4020
> -      - vishay,vcnl4040
> -      - vishay,vcnl4200
> +    oneOf:
> +      - enum:
> +          - capella,cm36672p

CM36672P is compatible with CM36686, but this is not expressed.
Confusing commit msg and code.

> +          - vishay,vcnl4000
> +          - vishay,vcnl4010
> +          - vishay,vcnl4020
> +          - vishay,vcnl4040

Best regards,
Krzysztof

