Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C247DD5A
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994974; cv=none; b=DTfpjitcBf5dK1c44z160FME7ikPpNEwXlfi0U1KzJKn3emcnC03DMUhUqjNfFan1iDspXHCkaivQiD5R0yulyN5rm9implss3YHc4gyWUcEMHJ9u85Kl3hHBozAcoBcvh+AkhPKsPDW2t/K+cf/YnZO91qCGEpNwKQ2bDgLPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994974; c=relaxed/simple;
	bh=1x5GAL1DORzWHwvyrqJKkBqOZ5riJZa+Y0KiM8aQ778=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVhtTK/UahuWcBJcxCOvZHf9d3mISjdBaSbfPUmke632nsszFkCqtzriv3YkpSYhRqiV5sgYGrJ0wy8109Uvxcr1muNMZJwJpGUVnYF1wkIzmaHhPrvWWpKYW5vofs1x6B2wcLbLspCyssLyIWisPrdDaxFaRS7AwwGwaYx4LJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sS+CJUbK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS+CJUbK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b77b150aso14786545e9.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782994971; x=1783599771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jna+clLnXx/9tBJDzzTY3BVQ+u6bUDk2L+uu9/fOCCM=;
        b=sS+CJUbKP0cRKj0Yt3P/maXTG0DY88JiyonlRuO3xqSY5epPrOprwAV/1WVoWq7n1e
         OYyQy9lzUb3Wr6ve199rKne0mKBkDBFKCzepEJ1tKFy25Xo1zGLYX6zIkPSYwu+VcFzs
         SaecZkrC3QH0nYfVRVmArr3+AGfFe9J1gg7QsiAv+AEbSTBOAWoVPlhjuoLUX1vMbkiS
         0gs2l/Lm1VxnQS7llDTFyaZf6Y0Dcbwb344eXlOAQ3e1rqaYCENapsZspyOhmyS8NF9a
         2E+myaQhPllGLqYnOp2q2OJg4W5cimb6UQKEUJp/tEcCHwRAH0X65QReMpVh/sw+5UMj
         n++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994971; x=1783599771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jna+clLnXx/9tBJDzzTY3BVQ+u6bUDk2L+uu9/fOCCM=;
        b=oJzLVhh2AUxXCsJyN6czgOcLe6GmwB1HF1iKPWQ/hHDMSHBn9EnvM6i3wvw7lBL2ro
         ChKsKlzs/ZoMZb05vby0Gjsg7izLgrCorpLgR/JRPtk4RBken7PqMrG4LZMR4VKJ5h73
         eby+PzKeDHNX79l1iTaA7ju9R4g0ncUy9cjCuOcx/yE1otuc21pp5dt8QPGkEs5jwIH9
         AvWKE7BQLtln7ro+cKmts5Z8Lk7yDOLSeDJI5szBXqMXn7ozsPp8MpW7qdKC5JN2bLVT
         +STqzamhis7oEsB+mYhbuf1YtOLgODpaSgXSI8239AKX1MITWI5TaB5OGzcOUbkvn0Or
         Irjg==
X-Forwarded-Encrypted: i=1; AFNElJ9BmpgbgoBuYAl5N8Rbe7TMgIbp/681mvEgTW206hD3ywxnQlbejlFockecm+6JrkIgtZj4DmKImaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Eax9SSP14zbRtPQufUiTJeF9QUEZDUwSKUl83CbXhyeE7ZKZ
	qmuThpcJUDMwqxysvlSkqKyl+L2bEgc2+P0yqsCzaWOkzAirBAJBahjC
X-Gm-Gg: AfdE7ckRtaNTKqy+nCrsmWA0c3t7KnRyPKLlo8ehQ6oSGIVJSYFHsArNgXvEzmlcWIX
	PQQHrA0NaajeRfodhxkuwFMe70QTKGWdmTWLRzXj42P2qk3f0A7wt/D/t80Wb6LJooQjjhxFTOU
	OLgq6cDLRNmbveMn1TwvNzKiiYsWgA8LqrxSPjeLbUzR8IJfGUvZ/MkEju7VpkfrfKaDeRA3LOY
	iCCoFrIosayiFj7HcsMjFhz7edkISCyTPKJ6jV7L/5YGXVjWUSyd03as7YT0IgWVNi/yr56FdlU
	uysB8Qvo+z1B65lqzHN2IgkPjSGAEyzZvCk8tJHvk3J9wwdHTFbxfi/hLMiyUzTW56cgErAxSTJ
	qhckqWUnQ76sSjRUICSLDom/LBIlgNRhCqJAFxtcdGFSPZT6hTT+s/w3zq9TLurMzdjf0Vvf3EW
	V/LnxtmsCW4UjR79Q=
X-Received: by 2002:a05:600c:8718:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-493c845bc60mr13403035e9.4.1782994971119;
        Thu, 02 Jul 2026 05:22:51 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bf11eba5sm86926685e9.0.2026.07.02.05.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:22:50 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:23:54 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Anas Khan <anxkhn28@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix typos in comments
Message-ID: <akZYSPu2YruEFr3R@nsa>
References: <20260702101129.62445-1-anxkhn28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702101129.62445-1-anxkhn28@gmail.com>

On Thu, Jul 02, 2026 at 03:41:29PM +0530, Anas Khan wrote:
> Fix several comment typos in industrialio-backend.c: correct "through"
> in a channel-spec comment, "initiates a process" in the activation
> comment, and drop a stray apostrophe from "Gets" in two getter
> kerneldoc comments.
> 
> Signed-off-by: Anas Khan <anxkhn28@gmail.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/industrialio-backend.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 4763e224ebc6..f7a4be8ec320 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -649,7 +649,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_get, "IIO_BACKEND");
>   * @len: Buffer length
>   *
>   * This helper is intended to be used by backends that extend an IIO channel
> - * (trough iio_backend_extend_chan_spec()) with extended info. In that case,
> + * (through iio_backend_extend_chan_spec()) with extended info. In that case,
>   * backends are not supposed to give their own callbacks (as they would not have
>   * a way to get the backend from indio_dev). This is the setter.
>   *
> @@ -851,7 +851,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
>   * @back: Backend device
>   * @timeout_us: Timeout value in us.
>   *
> - * When activated, it initates a proccess that aligns the sample's most
> + * When activated, it initiates a process that aligns the sample's most
>   * significant bit (MSB) based solely on the captured data, without
>   * considering any other external signals.
>   *
> @@ -1017,7 +1017,7 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
>   * @dev: Consumer device for the backend
>   * @name: Backend name
>   *
> - * Get's the backend associated with @dev.
> + * Gets the backend associated with @dev.
>   *
>   * RETURNS:
>   * A backend pointer, negative error pointer otherwise.
> @@ -1050,7 +1050,7 @@ EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_by_index, "IIO_BACKEND");
>   * @name: Backend name
>   * @fwnode: Firmware node of the backend consumer
>   *
> - * Get's the backend associated with a firmware node.
> + * Gets the backend associated with a firmware node.
>   *
>   * RETURNS:
>   * A backend pointer, negative error pointer otherwise.
> -- 
> 2.54.0
> 
