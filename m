Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446173D3D11;
	Sun, 20 Sep 2026 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929595; cv=none; b=JNMDYQIEhoX8Qf8I2iFYS2/xRVxTg/ew02HpHFOMZQDUF2MaEmk+zIdKEwEAlttLMpr3/6E+AO2aIfS1gQAe/YpYG28icOhfbZCQq6FFhlFbf36aFtH5cGjbxfJeEnHePoi0f99t2TdbCk8PZhCf1jwOWm4zOwywZlS7rfoJxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929595; c=relaxed/simple;
	bh=0F83T+kpWf95ysEKR0Z8VWJXdr3qoR1mYtB9dNbC+uA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3QUY6HDwrJo5wQPPn/aMOfQxu3ejKNW7UlBbiVVrDGAprEEr/VY5mmzi8DvvVhN8/O8D/tNUQb1ODUm+4hx2y1AbpWORCFrSrVw6FdYyraJ8IADlBQWVb8HUJAHCn5biWEoaLo7xi5jt+uTDTHXbECBdcooYrncuLJzG25Q7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW0VwwG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW0VwwG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF1D1F00899;
	Sun, 20 Sep 2026 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789929593;
	bh=7Ed/yUUn0HUZjb229iaADfwGMg+cTfNLXSc++PMyoB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HW0VwwG/ZZDACtzFQSvFq0OGEZyVWxs4L37vhA0PZfmzYLy7eDFBTpjcRZzGpkmfV
	 7tGftly98ND8ctYRuSe8Zz+dVNOxnqNI7T20Xkx+quwSQsqYQ6MoTkVx18Y3Te9cw8
	 6832F8jfgXbSvYbeyBZzhRLC4T5DDUa4btcXdxByXta5AB3vxcFEN8DO/ICNJcHzOM
	 MUE/Fjx6McYRUTp7ZkW58YA/EFjKcpe2Q+Q22MjEEqgJbuIAXuh2qy0uziv+88Tw9w
	 +sZQg37fVSmBRz0POo33khmv9Te5kb7PO+IbjkQvta+TBHNSmRjUKJtIxcFtnppH6x
	 ymA/XskYgYgdQ==
Date: Sun, 20 Sep 2026 19:39:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, arkamondalofficial@gmail.com
Subject: Re: [PATCH 4/5] dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to
 20 mA current range
Message-ID: <20260920193949.45606414@jic23-hlaptop>
In-Reply-To: <20260918122032.134947-5-arka@arkamondal.net>
References: <20260918122032.134947-1-arka@arkamondal.net>
	<20260918122032.134947-5-arka@arkamondal.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 21:20:31 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> adi,range-microamp gives the 4 mA to 20 mA range as <4 24000>. The
> values are in microamps, so this reads as 4 uA to 24 mA. The original
> text binding described <4 24000> as the "4 mA to 20 mA current range",
> and the data sheet (Rev. B, Table 32) confirms range code 1010 is
> 4 mA to 20 mA.
> 
> Add <4000 20000> and mark <4 24000> deprecated, so existing device
> trees still validate.
> 
> Fixes: 777baca07ef1 ("dt-bindings: iio: dac: Add docs for AD5758 DAC")
> Signed-off-by: Arka Mondal <arka@arkamondal.net>

DT reviewers.   Better to paper over a dt that is specifying the wrong
range as this does (deprecated) or just make it obvious by failing
the binding checks?  I'm thinking failing is better as gets any such
dt fixed up faster.  I also suspect no one actually it this because the
disconnect they should have seen when reading the datasheet and considering
what they wanted should have meant they saw this bug!

Jonathan

> ---
> 
> Notes:
>     Checked with make dt_binding_check; no relevant hardware available.
> 
>  Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> index 5121685337b5..ef0398170eb7 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> @@ -65,9 +65,13 @@ properties:
>        - items:
>            - const: 0
>            - enum: [20000, 24000]
> +      - items:
> +          - const: 4000
> +          - const: 20000
>        - items:
>            - const: 4
>            - const: 24000
> +        deprecated: true
>        - items:
>            - const: -20000
>            - const: 20000

