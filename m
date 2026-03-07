Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908CC34EEE4;
	Sat,  7 Mar 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883486; cv=none; b=ceVajqR9x5ykxt9Ew1gCypOzVgzw20ForRXKHUS8C3wyVjC5JTzfpLnr0M+0Cw3oQt+X8wSgywGxfhPYKQJ1K+JV8mxByG8+SIJmwyZhpDxcagcdZIm7aZc01m1STe3mDhjGHE7nZJ25FlOeKj4asc3F9o3fqyAYYFZPstk0zwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883486; c=relaxed/simple;
	bh=4vEmIvT6/hd6IrLoExqkfyoQm4aseR8ycMrBsF7re7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9uZ47COiv/iPnx/agEIslPn1em0sh5PZEAbmxZUcv7bBzJBMJ75h6geYeXrGJ9Lvf7U+pFUtPrqfTBZ1GXndTe7tSCCHDTsurdaWCNpbWIUK+t1A4NhXlA7pd6Fe7+4+5xOKKYyx6d7+nJfX604JxhRCQxSWvaJOgzxHi4vKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnfGNmg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnfGNmg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3A0C19422;
	Sat,  7 Mar 2026 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772883486;
	bh=4vEmIvT6/hd6IrLoExqkfyoQm4aseR8ycMrBsF7re7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnfGNmg8z5QIgwvwihbNXmE+Cgu7rzfv6CThYcbnKdoiEgGHDr90C0If0+2JdHXCz
	 5EUIJhggaB34bDwPI1DlE7RqEMQPsBL2BELJ3gH/bcohET6qo5ToQVqqvIw45sYjEP
	 1mdpcJct9cp3tiVNE+o435fVkIvPymQBRXGPxPuIhVYjJpRDCDOj3/reNDr3VsJtoj
	 s4Gwo2RXKs1HoVa40rex7mSQA2Ewg3zclOXRw5DzmFtN26iLW6mYkeVMPlIZTsN53b
	 +b4V5XWbl0M2Ipim2RvSHG/S5XZ9bljdzzCGM3aK1BoO+oP1UFHT/SSIDDup+GNnuw
	 vmlr8AuEetAYQ==
Date: Sat, 7 Mar 2026 11:37:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: light: ltr501: Add liteon,ltr303
Message-ID: <20260307113757.69abe0f1@jic23-huawei>
In-Reply-To: <20260305195917.831104-1-afd@ti.com>
References: <20260305195917.831104-1-afd@ti.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Mar 2026 13:59:17 -0600
Andrew Davis <afd@ti.com> wrote:

> This device is already supported by the driver and this compatible
> string was added to the of_device_id list but was not documented
> here in the binding, fix this.
> 

Needs a brief note on why it is different enough from all other supported
devices that we can't do a fallback compatible.

Seems it has a mix of scaling and channels that doesn't match any other device.

> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> index c8074f180a793..ab9bb68dd7363 100644
> --- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> @@ -18,6 +18,7 @@ properties:
>        - liteon,ltr501
>        - liteon,ltr559
>        - liteon,ltr301
> +      - liteon,ltr303
>  
>    reg:
>      maxItems: 1

