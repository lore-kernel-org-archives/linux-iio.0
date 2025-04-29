Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483CB22DF91
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948315; cv=none; b=HjbPTRHI7bA1qQJzOpVtcRg8J24uqcRo34fm7U5URJT1d2KjzRYJqK5hGa+fRf91/k3RU6Y+FFtL9PjXO9hfpcQl85bc5taNiTkA+2/h+dPDJlQlNQtvA7ChNfwBACocs1rGH9UefXwO9p9TcXzEla3F7ED5Em0EV38YEn/AQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948315; c=relaxed/simple;
	bh=5aMZ2bZxM//1rxj40LkRZdsZ1wtqSt9vUGp3dqr+nEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKy+/cMAJNW5mkGoS6w96XUxjJExdyDK1w/VkUATBTggJ8sXVska/7K1YD3fKdCukXLAXTlV5R4dLBXNbUkDSQGQadUndRobImSoXdfU4/ZNK0/2k+XDXXz/aJd9sS5zsJp/QRJVNuuogrPZ1CV+3HJgdbA0uxHsxOrOP55R8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrSE6COy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrSE6COy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC458C4CEE3;
	Tue, 29 Apr 2025 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745948315;
	bh=5aMZ2bZxM//1rxj40LkRZdsZ1wtqSt9vUGp3dqr+nEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MrSE6COyotIgtLZTuIhP6YURnq7/6pqXKEREgsv360ZGJP5FZKgQ5wIuhQ2ASMnMh
	 YZjDaHaDYd1vYrwoOLr6fBb9vH4Yi5thbuY4q0DYiII+x23Qv3mcbmME1oDfsi4iZK
	 i3absmqMXsGGjIFRVFXbbiWUO+at9zJ53qAf8OfonCoDxkOuzAG57UxzZI6lQ29LsS
	 9Aq2KcXqQQwoPVuGKSO9KjRj7HJjucvamwuOm4CsW0Yrdq+aKlbmz9FD/d4hyUk9mA
	 AbWZuo64f1L8WiJ1fgh4xTaQwP74fySrpEhC2cyH7HSrxPNer2KTvHEYoJce/pNY46
	 bV13X2xUhervw==
Date: Tue, 29 Apr 2025 18:38:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cesar Bispo <dm.cesaraugusto@gmail.com>
Cc: linux-iio@vger.kernel.org, Cesar Bispo <cesar.bispo@ime.usp.br>, GabrIel
 Ferreira <gabrielfsouza.araujo@usp.br>
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: modernize single
 regulator call
Message-ID: <20250429183829.110fa330@jic23-huawei>
In-Reply-To: <20250429160526.5934-3-cesar.bispo@ime.usp.br>
References: <20250429160526.5934-1-cesar.bispo@ime.usp.br>
	<20250429160526.5934-3-cesar.bispo@ime.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 13:05:19 -0300
Cesar Bispo <dm.cesaraugusto@gmail.com> wrote:

> Replace a single instance of legacy regulator handling in each driver
> with devm_regulator_get_enable().
> This change improves code clarity and aligns with modern kernel APIs.
> 
> Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
> Co-developed-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
> Signed-off-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
As in previous, this should at the very least give a warning...

> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index 31f88cf7f7f1..c99d6acac059 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -911,7 +911,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>  	adc->map = map;
>  
>  	/* Bring up regulator */
> -	adc->vref = devm_regulator_get(dev, "xoadc-ref");
> +	adc->vref = devm_regulator_get_enable(dev, "xoadc-ref");
This doesn't return a pointer....

>  	if (IS_ERR(adc->vref))
>  		return dev_err_probe(dev, PTR_ERR(adc->vref),
>  				     "failed to get XOADC VREF regulator\n");

