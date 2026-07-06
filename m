Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BF1A316E;
	Mon,  6 Jul 2026 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359701; cv=none; b=gBxVRzvg20egivr0BNlvLMLYKtRAKwsCYwo3lqhiWdeI7zdBqZf9mbQtDha3kv3WqMKjM3/JPpFeh36OuYjUHFQz4tnVkvfYQ5Bbi5y2oNEN2Y5Pd1pi4yOhqSt6bgKg2yMcTs9pK57+iZ5fUh64YnADMhKo6LnBTlSoAqSdrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359701; c=relaxed/simple;
	bh=zV+jn7SnDyAvqLRp8h5aOfvgrjcUCkRGuJEkxHt/9n0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5M2p9v7EchobojAu9sy2DlocGAtdHs0LQ5Nwr+S3vfLxez/BKAXGbulGj8Ia1qORMm2AaMllNlaKGmgoeRZ8PtSWfBTNqhNLlwZTiT1a76vby5ieHkuuszKbE6JAge8WXWhcVjdQt5eWuKxSvjcnEzTSByxruayiXGJ5if7ZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZYOKsmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZYOKsmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043EC1F000E9;
	Mon,  6 Jul 2026 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359700;
	bh=zuPBBRpS0aRwhA23YmvNdrzB7AsojZNeWWGW68lifLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bZYOKsmjaY0YstvRpzMq7PZj05CSgKU5fgzyDU2EMQfVrNIPNUyo+e8bu9GkVU52i
	 l5TfTbsb+3xU74wZyTYTHn2OpQHDq6X/RtUuwJoTczs3wEBTpu/Tfux01K6cocb8d+
	 bBwHw+sdFI5hdk83TXmR4ZMtcsukBdqFeM9/8rgOFUj6KY0k8vTo3YH3tQecV0L/89
	 Oql7lwBxXoQLJhLtYRty6+1vViiiWZ2w3Q1SFLIosogOCq385jvlkibtRKOHtV2GPA
	 7IR2jm8ntcPLZ5bl8Ahqn9tnWa1Fsydpcm2KwbRVC1O5LPWUJXgVInV3UOM948hy/s
	 8hGW1RtNKpgBw==
Date: Mon, 6 Jul 2026 18:41:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v6 3/3] MAINTAINERS: add entry for MAX86150 IIO health
 driver
Message-ID: <20260706184135.2e4c89c3@jic23-huawei>
In-Reply-To: <20260706112254.1262002-4-shofiqtest@gmail.com>
References: <20260623140730.12574-1-shofiqtest@gmail.com>
	<20260706112254.1262002-1-shofiqtest@gmail.com>
	<20260706112254.1262002-4-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 14:22:54 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Add a maintainer entry for the MAX86150 combined ECG and PPG
> biosensor driver.
> 
See Joshua's reply to earlier version.  This should be introduced
bit by bit as part of the patches that bring in the files
referred to.

Jonathan

> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3115538ce8291..361a7c8b99ead 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15863,6 +15863,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
>  F:	drivers/power/supply/max77976_charger.c
>  
> +MAX86150 ECG AND PPG BIOSENSOR DRIVER
> +M:	Md Shofiqul Islam <shofiqtest@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> +F:	drivers/iio/health/max86150.c
> +
>  MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
>  M:	Krzysztof Kozlowski <krzk@kernel.org>
>  L:	linux-pm@vger.kernel.org

