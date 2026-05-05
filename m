Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD526433AD;
	Tue,  5 May 2026 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947169; cv=none; b=Gm8Qok/IZv9P+BafVEq4EWf9rOW6B9otnVhMPcgh/h7jh75ep5LdkED3dj1/dX9R5PasHqxQhshyNXMmmGd9/5MPL6wJRHVmt76tQCHlmtWUsPhuxDCsdnfQd30OJI9U1ikpnPgD/EbK3Vp5M9FavISJBdTK9aEQh8BvKcpOQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947169; c=relaxed/simple;
	bh=oTEdrN/7wEq/G4o6w7TEl9WN9NPam86xKGBZiOofGdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oA3zlFILIWsiBfg7u7N+Yj5E4mDeGV5OGMRSFjhmaVWh5lcrmMTR6kKUB5J8ACeJ3Gin35qxjgXvEAd8fFL09E92li13mdoP9q5JXF+1B39clSszLBYh20zLTUfkDkHDuPSWa5nN3cicvVhZxaLS8018wRA4/wWZaO2/d8zNBsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A883C2BCC4;
	Tue,  5 May 2026 02:12:45 +0000 (UTC)
Message-ID: <5cd0103e-50f0-4942-b0a5-2d9a9a722ec2@linux-m68k.org>
Date: Tue, 5 May 2026 12:12:43 +1000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] m68k: stmark2: enable DACs outputs
To: Angelo Dureghello <angelo@kernel-space.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>,
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 Angelo Dureghello <adureghello@baylibre.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
 <20260504-wip-stmark2-dac-v1-9-874c36a4910d@baylibre.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260504-wip-stmark2-dac-v1-9-874c36a4910d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 5/5/26 03:16, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Enabled DAC0 and DAC1 outpus disabling shared ADC inputs on ADC3 and ADC7.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>   arch/m68k/coldfire/stmark2.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
> index 30da9bcbfd63..8fdfb9415cd7 100644
> --- a/arch/m68k/coldfire/stmark2.c
> +++ b/arch/m68k/coldfire/stmark2.c
> @@ -137,6 +137,8 @@ static struct platform_device *stmark2_devices[] __initdata = {
>    */
>   static int __init init_stmark2(void)
>   {
> +	uint16_t val;
> +
>   	/* DSPI0, all pins as DSPI, and using CS1 */
>   	__raw_writeb(0x80, MCFGPIO_PAR_DSPIOWL);
>   	__raw_writeb(0xfc, MCFGPIO_PAR_DSPIOWH);
> @@ -149,6 +151,12 @@ static int __init init_stmark2(void)
>   	/* CAN pads */
>   	__raw_writeb(0x50, MCFGPIO_PAR_CANI2C);
>   
> +	/* Enable DAC0 and 1 */
> +	val = __raw_readw(MCF_CCM_MISCCR2);
> +	val &= ~(MCF_CCM_MISCCR2_ADC3_EN | MCF_CCM_MISCCR2_ADC7_EN);
> +	val |= MCF_CCM_MISCCR2_DAC0_SEL | MCF_CCM_MISCCR2_DAC1_SEL;
> +	__raw_writew(val, MCF_CCM_MISCCR2);
> +
>   	platform_add_devices(stmark2_devices, ARRAY_SIZE(stmark2_devices));
>   
>   	spi_register_board_info(stmark2_board_info,

Same comment applies here with regards using mcfreadX/mcf_writeX as to the
driver itself. Uses of __raw_readX and __raw_writeX will be changed in the
very near future to use mcf_readX/mcf_writeX.

See the those patches at:
https://lore.kernel.org/linux-m68k/209d0653-6386-4b64-9e15-e358f84453ab@app.fastmail.com/T/#t

Regards
Greg


