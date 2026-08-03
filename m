Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7D40EB88;
	Mon,  3 Aug 2026 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761115; cv=none; b=PNt8yBvFa3IZrEuFTsYWKR5X6kDGVu/zaiA5n76UD8ywXjFecGYBPiDL+J9RMF+REcH3vzJFUnqUFf5hL4cVRMYHTOW747u/BXIKuhl4vevlwGT5u1icOnkvl+AsoSAhj96R45TlfztodET6fWTveZfoRriGJUcH+gtYcZEVuWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761115; c=relaxed/simple;
	bh=7fXivCLVSka76Bc85WhxJU+gZnoBwIO/05AYaetWOpw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=myPeiih4U2jd19yRSft2LU42V8KTXDv+MnLQrjrjvz311rWf2XTHmVr2P8siLoxQFHA/7SiXbTxvGkmMoVHx992E6p6wGCuOjSffu19gBy9wsPTE1BFQA3hyypvunAJ3oSJr5JiUXTOOziWy3nphIyOEYE4V81D7hc0kN+PJIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Hewo0JmE; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Hewo0JmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785761089; x=1786365889; i=markus.elfring@web.de;
	bh=wXdnqxkVLre8xyhoz1MyjV2h+syz3JVof1/RR+MyPp0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hewo0JmEWQUn4qh4teeEjmMMtoGU/FVNvDgA5StYCYlt6dsa2oEqoRBp1GKpWc0u
	 327i6NEn7bW2uT1tO4wLBokSx4oBYruHijKSrAywPxHh/3Vf0zZE0pBxrmnj9IKns
	 RyvkSNDNC0DSF/4PJjKDKEWfJCaLTa3dAEgRE/+Tz/w8wWFO7Tw6EIdqBPmd/OKg2
	 J4H1dsoDahhj3lF4fAopkF/0boICrJcYkEEpTQFQ3pEAGaHYr3wGovUGqjVCxCNQs
	 CSi4IRdFLqXuSNAuoWmtytmlqsKcyl7E0pFkvQW4LsCI9mDn62jeWNK3bhOcOX3ec
	 6AIkkP8b9oW8K/4fiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCoku-1wi6bo45LM-00AVk0; Mon, 03
 Aug 2026 14:44:49 +0200
Message-ID: <9d56c8d2-67bb-4c04-94cd-7fd5c7ee940f@web.de>
Date: Mon, 3 Aug 2026 14:44:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mohammad Shahid <mdshahid03@gmail.com>, linux-iio@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Lechner
 <dlechner@baylibre.com>, Joshua Crofts <joshua.crofts@broadcom.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <20260801090953.61603-3-mdshahid03@gmail.com>
Subject: Re: [PATCH v4 2/3] iio: adc: bcm_iproc_adc: Introduce local device
 pointer
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260801090953.61603-3-mdshahid03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PNflE5lriMcmjKpchPSOSGRQ5QK0Q8ceiwP6punGcQUtPq5fcii
 0RJDnonjR+8gMQ2wBIn6AZi1kWqnc3wKfN7yTPH10dfpwpMHP882n3O1paG/Y8+Nt4Rj2yQ
 7MCwsUGEGH/TWJD/cXOck1/yJv7dR96EFcx0jIzqcCFatDKxUcM0W+5dv4dvPFidxoxatwP
 z+OT/2R2IDwvrpS/YvDVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fBeTI1pT05k=;Yj54u55zx3cpp5LqQ5RWtn/08Qc
 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
 AIA

=E2=80=A6
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -506,9 +506,10 @@ static int iproc_adc_probe(struct platform_device *=
pdev)
>  {
>  	struct iproc_adc_priv *adc_priv;
>  	struct iio_dev *indio_dev =3D NULL;
> +	struct device *dev =3D &pdev->dev;
>  	int ret;
> =20
> -	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
> +	indio_dev =3D devm_iio_device_alloc(dev,
>  					sizeof(*adc_priv));
=E2=80=A6

Would an other adjustment be a bit nicer?

+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc_priv));


=E2=80=A6
> @@ -523,14 +524,14 @@ static int iproc_adc_probe(struct platform_device =
*pdev)
>  	adc_priv->regmap =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node=
,
>  			   "adc-syscon");
>  	if (IS_ERR(adc_priv->regmap)) {
> -		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
> +		dev_err(dev, "failed to get handle for tsc syscon\n");
>  		ret =3D PTR_ERR(adc_priv->regmap);
>  		return ret;
>  	}
=E2=80=A6

Can further source code refinements become helpful here?

Regards,
Markus
