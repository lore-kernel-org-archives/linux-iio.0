Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8B3403EE
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785603094; cv=none; b=d2Zr1ceISG3DLvggtPQISjOI5aF4FMT5k7+JOABCZIK4SNBlDbqC1fMhokLTjkifXBpmHuNtwMohfNnp9PZMpDKNS4vH5uo+dwSAEOywMa+NQIuc+BYCOqIfkwWoAfF8YeDFOzqQeIs2yxdv/l/qQNFbAlGCsD2VcZaYnySvo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785603094; c=relaxed/simple;
	bh=vp2cwsDxvl/hA1J6ZiwR+Y6hDJeJPa4NqysQAU+BJ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj6HywHxqvc2Dn2ts5Z+izIeyc7q47lpPrP7Jl2z/HHy8QEiZhwTXaGg79lHB8FIXg8v0VbZasthhHgQQEnSRa0rsQD0h4i+x/pJ//+jZrLWMdAbdFYec3lWYVsYfu5yi9CtvhA/0ORwzKc8cpyISImYKKqJynwV8wp3YHIw5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LU53pT5M; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LU53pT5M"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso2003739a34.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785603090; x=1786207890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5+2v1sY4AeVSWaNfB8Ebbw6gwnqPCWWxIR5v90l5No=;
        b=LU53pT5MBkrC7FBfzl4bz/i3wx/yx9QGF5tPV3Yl+DAMeR9nSonJVeXJvDyVB0XJ5c
         yRhWjXsQZDiX4j8yUgw8eLNt2zfKVlP+rvNJJlDem1Znl7bUhnPrqCzUXtdp1eTvdZfD
         T4Z3rr1py+tif8ZYSXtFUs8fb907ESN9C9vyGmuCzCLHHrXtzMYo4w2269YEiEu5RI8I
         RukywV3Z0ta0p2ftyzL0UmWpSBTh4vTMJvSZHp9l9/i5J91CBpPTcAgqeiNefxCGBykI
         tLSnRoHYl1YbaRHJTAcxxJ86jYmSLIqswscZ/Jc/GEa3hsqhFTBl+VCbBDuQw66pzul3
         f7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785603090; x=1786207890;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5+2v1sY4AeVSWaNfB8Ebbw6gwnqPCWWxIR5v90l5No=;
        b=awXMDaDXONdgLNhjyfmI2cI0uKiyUvQtBYcbzLVgq9tcc3Ka+yxEvF1D1mKw+nFqrN
         TmJFjOtpzuvAKC/T6+CYyfRHCIgfj2Dx+a2zQ2oe0jL1s9FkIC/OKLgNWP4zEzNbI7fi
         QqpZiwp4mHrMHwNa2ihYEap0nHzNSF8gS5dQ78352B2k5mDaxQRmo55ikmUuRyzwVmSO
         SKPfHc2iVTAOU4DK7KqOfVzY62gk2MNasz2XVa37TXJvTbIsaZe8U+8cZq7pTTRW2k7o
         u/ANTpgcvbeqrI3R63nKJhIE2W9uu6olFBsNqJLcfRpLFaoEzuaAR50cgh0OnfVZyBxm
         soLg==
X-Gm-Message-State: AOJu0YwoT3BHS73ddXCiRjR3XiHimRVGrLgRxmaBCtgu2rjHEeio7vxP
	rWqmKJ//628VzICykTDpfhWxBRrzT0friuzfhMdX2cTghjwdYjeX5+jV9ucBa7s9918=
X-Gm-Gg: AR+sD13tX73sPspsIdo/3P1eNDUwF9inS8bkhGp9fSoFCiSOfDdm7rM6E19JU/vn0ij
	5CnMf8bq17qQE8vRULsvZPC+u/UlQHf4s1rgPZ0Ayaq/pMcD+V+9NNvFULaWbXB8i17/0tRn/PQ
	Zc8pDqa5UcQeNYw0YFj4+bAs83x6C038/5z1T1Ixdv5v0VD/qHl+KGAUsrAShw+uSbJkoxGQbYc
	FyU5WddJCFToXPMWXT4ty3/WCLqqFGuhkObTgwJ+yJONSlGfzDZPaCvVqKyhfeG/PJKJEowFwZM
	OI/E4LOntKl2qwbXiM86BlcIN2iRgIZN6ARdZGoDHoDbeYVTIQCxaacUTrNtWo29cTmxyUwkHzo
	FXVEacrtyB3V8X1SwnlNplXLwXlxuw4B03bX/Ct4c4ZJQZIC1EI4k1KM5JcfqFqGxdmkV1IAo7l
	GnqsbH/DNCnf5DLBrrq6DeKVTOnvzxgxkrMWra1sgYCy9kLo74TJyCCYAx382jf7CpGwCxRgHn+
	Kp+jveqTYMKeTWKTQGjmdkwBGB1ZyOgJ73UshQ=
X-Received: by 2002:a05:6830:7107:b0:7e9:b4ea:2ef3 with SMTP id 46e09a7af769-7f1973ad4a9mr3229106a34.13.1785603090388;
        Sat, 01 Aug 2026 09:51:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed970adsm3586102a34.8.2026.08.01.09.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 09:51:29 -0700 (PDT)
Message-ID: <674b473d-49b4-4e15-97df-337991f98e04@baylibre.com>
Date: Sat, 1 Aug 2026 11:51:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: xilinx-xadc: Correct Write edge in CFG
To: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
 <20260729125455.95893-7-DileepKumar.Nagavarapu@amd.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260729125455.95893-7-DileepKumar.Nagavarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:54 AM, Dileep Kumar Nagavarapu wrote:
> UG585 states about the PS-XADC interface configuration steps,
> REDGE is 1 and WEDGE is 0, this is consistent with the XADCIF_CFG
> register default value.
> 
> Current driver set WEDGE which is inconsistent with TRM, this patch
> fix the WEDGE parameter setting.
> 
> Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
> ---
>  drivers/iio/adc/xilinx-xadc-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
> index bd033315c72f..b113f904b8fa 100644
> --- a/drivers/iio/adc/xilinx-xadc-platform.c
> +++ b/drivers/iio/adc/xilinx-xadc-platform.c
> @@ -346,7 +346,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
>  	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
>  	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
>  	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE | XADC_ZYNQ_CFG_REDGE |
> -			       XADC_ZYNQ_CFG_WEDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
> +			       tck_div | XADC_ZYNQ_CFG_IGAP(igap));
>  
>  	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
>  		ret = clk_set_rate(xadc->clk, pcap_rate);

This sounds like a fix, so should have Fixes: tag and be the first
patch in the series.

Also would be good to know if this is causing actual problems or
not so we know if it needs to be backported or not.
