Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43E36215F;
	Tue,  4 Aug 2026 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869311; cv=none; b=j/qirdjioCVj2tlYvx7/tl0yog2TR2A/qOGBPnayNfUbLi3Jx7+7Agl0nBHj5o3WjVouyZ5Gqg9FuO5hxLc6FSNt3MSxToBLK142LDr8aNchwW+HAcwy4VNoh4R34nYC3ZWMRRunDqT+MTtpVBWMFBtYA6xwoQ7VJGnjlc8ydBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869311; c=relaxed/simple;
	bh=kTGCgk8xPkvnJujSrRLHmr4WMDqQoGq+ud17lyM+wB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpTb5RHDIqENXl63LsdkKQ1BXkSkW65xg8S2xJtPCGAuUvg/8H8QvRst6Fjjvjt90WBvHLOUzvJK78qfAkoxA+g1q2R2dPgzAXcuo4zPSl+z4L0sVITeTrXw0DES5oS73uwpIzZUbS3j4/I1LcLEqAoe30UBQELpO+ZaM3sksjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wTUAysuj; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wTUAysuj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785869307; x=1786474107; i=markus.elfring@web.de;
	bh=VluR0l58GzqnRCaOv2BYOldBVCpDACGcgQODyhRklpE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wTUAysujZRs81QgFIwhIIP5z8aw7prp0VQlpXl50dMN9xGsJOeThQHzkLQ1DCZcx
	 8HDFfPAXfwHSVSMzQLALiKNTI6uceZtYQqOvt5/cQ9w6/4iuXSwjVM+EQIoIH6fvr
	 n2xOzz5l7FsMNCp4PBEX7xJVI7iiCW4C+N0NXfsFgZh7AUqHKuvn04xjZr+GNPy9x
	 ZoCVTx2cg/ArDlFDDN914BLaDjY9TzFkCALvSvqpygeBGrNzfOWWlGvnx5otRusNZ
	 GbUzr6BM9mJOwWeOowGkOy8K6lklQQyQZx/01LOUvV9QB8wFYweUQXJTh/oH6lx7o
	 TlcNS0QXNfy5z6aSPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1xDxc507N8-00maH1; Tue, 04
 Aug 2026 20:48:27 +0200
Message-ID: <db6d0c14-830e-44fb-bf59-33f72d7556e9@web.de>
Date: Tue, 4 Aug 2026 20:48:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: adc: bcm_iproc_adc: Convert probe error
 handling to dev_err_probe()
To: Mohammad Shahid <mdshahid03@gmail.com>, linux-iio@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <20260804170521.196393-1-mdshahid03@gmail.com>
 <20260804170521.196393-4-mdshahid03@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260804170521.196393-4-mdshahid03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YcG3fxn8ZdzkH7qyDsfhrTiqE9IylbX0rsW9sym/VU7uyUVUKkk
 F4ETldx5GVTZwiCmgOO5YDr6se3S1Kq86FwVb+O7H+xRf21OMA7WQftugJ/wV3f+6TleTh+
 jLoIfOV8j1V95+oYEOZkAVJ8Lo1GBMq33Faypvgp3eMGUKTbt+gceBTsSV7VsabGJSxB1Uu
 ydMfSUMcDdExokVIzBscQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fWm6g7w7iNA=;/3zDPWikwc2dFM8shFYcp4VMx2Y
 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

=E2=80=A6
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -522,18 +522,14 @@ static int iproc_adc_probe(struct platform_device =
*pdev)
=E2=80=A6
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable clock\n");

May indentation be reduced at more source code places?

+		return dev_err_probe(dev, ret, "failed to enable clock\n");


> =20
>  	ret =3D iproc_adc_enable(indio_dev);
>  	if (ret)


Regards,
Markus
