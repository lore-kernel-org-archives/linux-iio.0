Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E33290B8;
	Sun,  5 Jul 2026 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783294639; cv=none; b=mwsKCkSzw0SlPBQh8ZK92QHIYZOO2tavGRFifRdZNBjLMt+RqbbnBjlUpn41qP7hnbGVn+tbvHtRIo0NTqL0qFyyj6FLmfVl1Eun+ylXUQatmaLkF+Il8mow6bR6FO/yl42SJvuJKpULzP1cSkVNQTTSe1bqwZpMPQdeGcLn0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783294639; c=relaxed/simple;
	bh=kRfSAPMkVypfChTSuUcXtr7NNpb/SGTYh+rTsbf4Vrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gE2GchBA9fT5R3Fc/IsrO4BHfk44LwhzIMCkOdlqvakt24i1k4NTE8uRsZId6EgMhILp4ueKd/UKjcUu6EjhKTNYN8v2wO8ejJrG3jPUe17X1RGsgq3hcT+E+Pw4if+qsvS9eOzlZ3KnCVNber9WAKBV62D/8djzgmCaYpqAiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4QPnyuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4QPnyuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BD41F000E9;
	Sun,  5 Jul 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783294637;
	bh=hXeMFwClC7BGFE+lisq71o73p0vg62JvaM+ulIBf+cA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W4QPnyuODJ1sXUVnW4JLMNhmX57X2WJV6BvALQ9boKmNPxd41DQg6lZcRzpbTLzio
	 4A+bV0auD/4Nz/yBXrvYeY8M3olLHW3vxg4cu+BtG/q0384uPazpg5OZPYvAbG10w3
	 5BuvoNhQSKOpxoNFif4131XPGbb0S2AJ2zNPkitDnRZVYy2lF6TxlicAarGuI0wh6f
	 ZhEuJdPB3VIqfWMirJD1WsGH8m+qucF0XChAdB9YMEBy4KuOkEHsik6PJDRUrCIi9m
	 I950elUNgQihP+aN+pvYyvgvqgF3c5rcG/x9q4XWxHbuFUjaZM+DVnBxx+B2K+03sp
	 loFemucp59gOA==
Date: Mon, 6 Jul 2026 00:37:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads131m02: Drop redundant NULL check
 on devm_clk_get_enabled()
Message-ID: <20260706003712.753a5870@jic23-huawei>
In-Reply-To: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jul 2026 19:24:39 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> devm_clk_get_enabled() does not return NULL (only valid clock or ERR
> pointer), so simplify the code to drop redundant IS_ERR_OR_NULL().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
See the stub.

static inline struct clk *devm_clk_get_enabled(struct device *dev,
					       const char *id)
{
	return NULL;
}
Not sure what the reasoning behind that is.  Maybe that
clock could be already on?

We could I guess make this driver depend on one of the clk
related configs, but today it doesn't. So to me this NULL check smells
of protection we don't need so I think the change is fine, but the
patch description should reflect that stub and it being considered
reasonable to plough on regardless.

Jonathan


> ---
>  drivers/iio/adc/ti-ads131m02.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads131m02.c b/drivers/iio/adc/ti-ads131m02.c
> index 2f8f75c8216b..27c8abff216b 100644
> --- a/drivers/iio/adc/ti-ads131m02.c
> +++ b/drivers/iio/adc/ti-ads131m02.c
> @@ -848,14 +848,8 @@ static int ads131m_parse_clock(struct ads131m_priv *priv, bool *is_xtal)
>  	int ret;
>  
>  	clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR_OR_NULL(clk)) {
> -		if (IS_ERR(clk))
> -			ret = PTR_ERR(clk);
> -		else
> -			ret = -ENODEV;
> -
> -		return dev_err_probe(dev, ret, "clk get enabled failed\n");
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "clk get enabled failed\n");
>  
>  	ret = device_property_match_string(dev, "clock-names", "xtal");
>  	if (ret > 0)

