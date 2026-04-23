Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0CE22CBD9;
	Thu, 23 Apr 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966145; cv=none; b=c0BTM5pxrmOIWrzB6qPz+DMFYlu68UpZKPqUj4j5TcclpvZCygxddWxp89IyrzA2v3bVrdPNPgiUKZsvJBv79JjvVRI219pLJAJIoE+vBBBnVMgsNChVfPMgezEnmBsuePWQWZ8T2i0o3dswfie6FCo84GFhOh3qRj7TIsy6RVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966145; c=relaxed/simple;
	bh=vC8KLp/ZYL05BM5vifW4NmG1K5qDUMzDjIy4MMQDH28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Elg6nGGSCtkFsU0F6jKLGAkzuBMRvIZXC2EBxpPRO1kL1FI2mqp7d0pSq08YkxxW8HpILx3mlUEHpolGD31ThLoGoYPS6W67WNvdBt0Lxz5MFWD3N/+t//Q2qf54OZCfb8alGY4nJZsSmZb3X+cfGhd9dkElU1iNM6TFlva5EHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX+bdzfP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX+bdzfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E23AC2BCAF;
	Thu, 23 Apr 2026 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776966145;
	bh=vC8KLp/ZYL05BM5vifW4NmG1K5qDUMzDjIy4MMQDH28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZX+bdzfPYGouGx8EqWv6vXOFV8j4+0R9Mo33ZKiziTSx1nvIAqt/hR4st7Nxz08KT
	 xnWfGrZcVzGyKoRf0ULi8RlDYa152xFqTHYLDJS/soz0/KxrgI+xyDYTIoP+ocalT7
	 a6sJR1yLoullefQMaDY1h3ini1DXAc2fORhXxRofx7D2x4T0laXrU/yvTeYazTndVn
	 Nj2Bk6YHgOzVlsDVBy7RexXxPOBdvXGTYfyK2h1m5p2noDrN/Fa5u3BuTFWxwVR8U5
	 GkVBE2MfP8/c4emffpSh7Q+SuJ2nmrRmnTeXFTG9KMcS5pWkLA8kGw0U0giz1GGjfl
	 J4uxdSyrWT+zA==
Date: Thu, 23 Apr 2026 18:42:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, =Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom: Unify user-visible "Qualcomm" name
Message-ID: <20260423184217.56d21c30@jic23-huawei>
In-Reply-To: <20260423173545.92271-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260423173545.92271-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 19:35:46 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Various names for Qualcomm as a company are used in user-visible config
> options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
> "Qualcomm" so it will be easier for users to identify the options when
> for example running menuconfig.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Fair enough. Applied.

Thanks,

Jonathan

> 
> ---
> 
> And "Qualcomm Technologies" has even variations over the tree:
> Qualcomm Technologies
> Qualcomm Technologies Inc.
> Qualcomm Technologies, Inc.
> 
> I am doing this tree wide:
> https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
> ---
>  drivers/iio/adc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a9dedbb8eb46..1115e81ac45b 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1354,7 +1354,7 @@ config QCOM_SPMI_VADC
>  	  be called qcom-spmi-vadc.
>  
>  config QCOM_SPMI_ADC5
> -	tristate "Qualcomm Technologies Inc. SPMI PMIC5 ADC"
> +	tristate "Qualcomm SPMI PMIC5 ADC"
>  	depends on SPMI
>  	select REGMAP_SPMI
>  	select QCOM_VADC_COMMON
> @@ -1374,7 +1374,7 @@ config QCOM_SPMI_ADC5
>  	  be called qcom-spmi-adc5.
>  
>  config QCOM_SPMI_ADC5_GEN3
> -	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
> +	tristate "Qualcomm SPMI PMIC5 GEN3 ADC"
>  	depends on SPMI && THERMAL
>  	select REGMAP_SPMI
>  	select QCOM_VADC_COMMON

