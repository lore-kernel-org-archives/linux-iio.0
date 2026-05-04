Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5C19D07E
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912547; cv=none; b=ji3y4IRgVc1LDXkkPrBquJZtO06JmRjBDyipjXTEke5pBA4S1mkK9GYY+h4dlM/RvuUMrWHvFkez0HFE8JWtgXO+Zk8ijyA/AzlmWXrmg5AkXdKWf302kCTDIXUpgwtD+C0UpzCevaevbUVIC7yI8q6tJPAC7Wx/cr0Bnz7Ra/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912547; c=relaxed/simple;
	bh=slbNA8SLFuX9vvt5+UszgbNW4OFsHcC7uVyD03h36eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0bZJhcsXvgxJNiluEpFmPFDQW+ybRWsI0QwIp+3RwhaCarMtbhOxO1PeT+dDRzsJ2hKHeP5BfmJQU5I03vcmFZ94p6xEEiYpQEuF7/T/95zDs41tQ0RrqETjEMq+6cPvpyvj4eGCIa1qgr/A/BmEJURDTls0Ihh4kgV1073Abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaimn2sS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaimn2sS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254A7C2BCB8;
	Mon,  4 May 2026 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777912547;
	bh=slbNA8SLFuX9vvt5+UszgbNW4OFsHcC7uVyD03h36eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uaimn2sSi8yUCaKJUBsOUOeS8apdnUF3cLWyecetES5NXukTDqEyU5mRgrVB7WvSG
	 73lFW2Znc14MD701WgVHPUWITTzC02x0nJESxmaDPpPCNp5SjxYpUFoy0UjHc7AW9p
	 J7VKVRhX42PofizSA/qif9THtWQDck76kEnR9b/l6n7AyHsrHTvvg1V3EYIDfFmAdx
	 GaMSwZMyqDPFkdq2ot4B/vQ083TXCNp2g+midAlylM+JKyFXxLcp29qfK19KNV7SKg
	 mBaV6GLNGOBGuaDHrQwZqgyQiHobEyaBmCgLiArgN3LxbuWZwlp0ihtppSQdQD0Jta
	 Kd7ZVp3uMH8Ew==
Date: Mon, 4 May 2026 17:35:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 nuno.sa@analog.com, ricardo.kojo@ime.usp.br, elliancarlos@gmail.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: veml6030: Generalize hw_init for
 veml6030 and veml6035
Message-ID: <20260504173539.6f13785f@jic23-huawei>
In-Reply-To: <20260502234348.131563-3-gabrielblo@ime.usp.br>
References: <20260502234348.131563-1-gabrielblo@ime.usp.br>
	<20260502234348.131563-3-gabrielblo@ime.usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 May 2026 20:41:04 -0300
Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br> wrote:

> Modify veml6030_hw_init() function to deduplicate the setup logic
> for veml6030_hw_init() and veml6035_hw_init(), and remove
> veml6035_hw_init().
> 
> Additionally, introduce struct veml6030_hw_init_config_desc to store and
> pass the custom configuration values specific to each device variation.
> 
> Signed-off-by: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
> Co-developed-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
> Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
Hi All,

A few additional comments from me.

> @@ -1074,9 +1051,11 @@ static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
>  		return dev_err_probe(dev, ret,
>  				     "can't clear als interrupt status\n");
>  
> -	return 0;
> +	return ret;

Why?  If we can get here with anything that isn't 0 then fair enough, but I can't
see any change to make that now the case.  If we know it is zero then explicitly
returning that is good for readability.

>  }
>  
> +
> +
Please proofread your own patches for stuff like this.  It's very
easy to introduce stray changes as you develop your code so only
way to catch them is too look at the end result before sending it out.

Jonathan
