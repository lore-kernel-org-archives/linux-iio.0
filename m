Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608221;
	b=oQ8po4sfq2gjwO898ASXnkv+7HBrYlLNUShBXf98tc1i65ka4cKtMm3zLrNZ2RSKaIUS
	 uh0Coue7sWGkt6v3M+hYBrl1I0Af5Qvj44PSBqiZNb/p+pyNqjTwWw/Q3p1PBsEbRAU5O
	 T/dfS18/MrxBkFI44khA/zqxJ9FDiGFl6vW1hYNUnhGGFk2Hv9iFM1aA2gWbHSTh1EpIH
	 tjaP9JSBjJY2SNwnG5XwmepvdbdG3MUT5IhyhFmU4q4pEgjdaJLJ9sUjZXlP4dpkvs+FF
	 raXe0wBttEuUUqhhYRZx2YMW9yFVL4e61A4fPnj4bRb/a0Fbo5b+lMnoLBQxbKa8+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Yaa6k5Fi/S8yLcSO8oA5OP0KYAzuBkSJifuZS+OJQwg=;
	b=3tld28wijojEQaB4q+Xj6suzN4QOBHx77MJdThm1pK1B1Q45UEk2xhq5jEUbyOxjL/d2
	 MBo5A9S+dWDKwDz7WwBlB8om3pVHlUFX4vfZfV5A1kry+MobGfieHe+ek0+auzu/X5YJN
	 J9M2pQpKsc6hTcUSWEnDC2nugiyGkgRc+MAthm8SNXUHrpehUCLjc/FjYtNV5MtTrZG2U
	 ialWvj9XV5hQKR9DW/kaPniHIC1+s7QFOc1QJnUVT3T39Wogizln6dEqUirfuHajeBF5D
	 5i7zw7RTiNpIR6wSEPe2G2jfpbqod3zJuwN4/doMggFUQFyDnKFMdneJJzUkdLDIhFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4DMs8kV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE663606A319;
	Wed, 21 Oct 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4DMs8kV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39751F000C1;
	Wed, 21 Oct 2026 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608220;
	bh=Yaa6k5Fi/S8yLcSO8oA5OP0KYAzuBkSJifuZS+OJQwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q4DMs8kVxPGEaN7Axg9dakbNTgBP2NukZGUkfwdkGiJd2vewncfX2IL/BP4IW9GQd
	 8HRndU+baQEdiRdKBKFYuHOehHyfenkrIscmvzQk86iUTA/NESFOO3lF2GZmxcHgJK
	 /iY1tW+Bd4g8AwVRtyB5iI9JaSNPAaEOPvVmO//Hbc65Bo2QNSSrULzY1Ba0wt+zkS
	 ItAmKgvV84ZNMX1S/lpls36R9WBNW7mkvuQq6hHTgZ6YvYEm1hVNaG9OMD6E9xlN8Y
	 V4+qzZhzn/zKRVX4zPRD/bt7qwmcT6IRDwFuL6Nrjbu5v5F1GbRmJTNTZ0a/vBm89z
	 kvR2Ya+aXNHZw==
Date: Wed, 21 Oct 2026 19:43:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4] arm64: dts: aspeed: Add syscon phandle to AST2700
 ADC nodes
Message-ID: <20261021194334.587dbe77@jic23-hlaptop>
In-Reply-To: <20261021-ast27xx-adc-dts-syscon-v4-1-4fab164f10b4@aspeedtech.com>
References: <20261021-ast27xx-adc-dts-syscon-v4-1-4fab164f10b4@aspeedtech.com>
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

On Wed, 21 Oct 2026 10:09:39 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Point the ADC nodes at their own syscon1 so the driver can correctly
> locate the reference-voltage trimming data on AST2700, where syscon0
> and syscon1 share the same device-tree node name and would otherwise
> resolve to the wrong SCU.
> 
> Fixes: e77bb5dc5759 ("arm64: dts: aspeed: Add initial AST27xx SoC device tree")
> Assisted-by: LLM
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
> This was patch 3/3 of "iio: adc: aspeed: Fix SCU lookup for multi-SCU
> AST2700" (https://lore.kernel.org/r/20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com).
> Jonathan has applied patches 1 and 2 to the testing branch of iio.git;
> this resends patch 3 on its own, now with a Fixes tag, since the
> driver falls back to the old global syscon lookup whenever this
> property is absent, so patches 1 and 2 alone don't change AST2700's
> behaviour without it.

I've now moved these at Billy's request to the fixes-togreg branch
and tagged them for stable. That will go upstream sometime after
rc1 (rather than waiting for the next cycle as testing would have
done).

Thanks,

Jonathan

> ---
>  arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
> index bc990f79e693..053673cc4b8e 100644
> --- a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
> @@ -246,6 +246,7 @@ adc0: adc@14c00000 {
>  		clocks = <&syscon1 SCU1_CLK_AHB>;
>  		resets = <&syscon1 SCU1_RESET_ADC>;
>  		interrupts-extended = <&intc1 80>;
> +		aspeed,trim-syscon = <&syscon1>;
>  		#io-channel-cells = <1>;
>  		status = "disabled";
>  	};
> @@ -256,6 +257,7 @@ adc1: adc@14c00100 {
>  		clocks = <&syscon1 SCU1_CLK_AHB>;
>  		resets = <&syscon1 SCU1_RESET_ADC>;
>  		interrupts-extended = <&intc1 80>;
> +		aspeed,trim-syscon = <&syscon1>;
>  		#io-channel-cells = <1>;
>  		status = "disabled";
>  	};
> 
> ---
> base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
> change-id: 20261021-ast27xx-adc-dts-syscon-9cf5d733ed0e
> 
> Best regards,

