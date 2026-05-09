Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF432046BA
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317566; cv=none; b=l5DNpQuTUCRDDp3zj9ZhCmyXShQflRnOXg+Y2ayO6BklcxEuIrOKz+UfiHxw/0cd1GkvGJDcMq9a4rqCWne+q1vfD1/FwC1TQWDzrzmMehGgBWW7BOEJtFOl8bVNDZeaziOnhaI0LkWLO4/KG1AotqqIFnl7YA88vuH+s3OXFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317566; c=relaxed/simple;
	bh=1/kBf0xHozRKBUgHfZH4s2QfvLoV2CjwOQxyq6LNX7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYFwLvmOIoUD4FhLGBrhtUi8TGi3PZra6ASyp7+Cn4/gEnora2qRcdRRorl2saro89AOogFkSe1mFd9PO8uA9vhN3ek/JWUP+I8hNHgcie4eJlUEspI1sY4wTLc4ponMDtYZ3NhvjdsZvZyebS+lIY+h0Cy4X+OLo4+3soi8DX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQsCbNeO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQsCbNeO"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so1437744f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317563; x=1778922363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+AhO8sEhmHv5s2bExhxbuqfRz9MhXe5uoP8KtSKLK8=;
        b=oQsCbNeO0f1fXvy2uGqI3rnrEdhpbcZX5mMwRrJO0CfsWklCpEgtrhelBgG1xWluJN
         DRLO//N8ldf/Ig136QjVYMnEqXoA6Ur7iZv6l6WhwNXLm6uISKjSEJ3mJacJ21cMIcwX
         XRxmmzx3ikXco8uxx5LpJLM0hmEuJKWjqQ+iHIL+l379b4p09SSek/eoWFHwrLI3VMa5
         xCXqKQmi31pxFYt6QDJXCzcIVoAKKAlUs2ohLc7ZCAzFZQ0hKgo0L/hma+jVfFnTFEX7
         VDUTJCTPOl3/ls3B8YXusQiIdefi/074pjr8vWvBXHnjd8ThdA8AAuNFoRil8hzxlrIf
         eQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317563; x=1778922363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+AhO8sEhmHv5s2bExhxbuqfRz9MhXe5uoP8KtSKLK8=;
        b=OmrixizBnDHLwF7ifID5Nky2g+CboPxNogYJgvzOAm6Gd1Z2QA3SqIS+FZ8Pd+dk1o
         8n9L0BcFARdloLb2JSlt4gfi6lZeKfsYJq5iPBsmTppG4J9S4Fw4JttcwnCBpL9mc39w
         so6YR2wYB9JLP08BklN+qIoLxxfqldkINkn+ziDDY6SVU/AjuQdEBb8ukbpMKc7UWsWx
         Vz7DcN3svxlSnXx1v5aEwPpVm7Y4medXnMPaxbTQIqG6lfiUwWBWFsz9rvKcCRxzI5R2
         W/+W/OIQ0TjUZ0EpGD3axtfmVSBlPAeLsyDpTm6Ac/fewp9mY/Rc4rAeuwWtd0aBBld4
         Tr/Q==
X-Gm-Message-State: AOJu0YxEQd4/vpreTBmr04E8RJk0U3sp12i1UWYxoQs95u3ds2GM/ao8
	bbtpe/N8eNGPDkRQvjRULpMrsntWCE6hgq3c9JB+YJWT5qnW4R5SdqRn
X-Gm-Gg: Acq92OFDzJFSQUaVS/Ig6PaBeJVU50ur8WPaNe9AEt1lFkT1B9Ppiguf0MBAE7xQEdX
	bKe/uogQ3oewdDGuwp1JzWtFOOpNBEdAigLGxrrA3yqxk/aHA5EBZKg1LXzToXJIv9HIEbhHItO
	sM3K8PfRz0FVWvcID+UllJB88TtRz/Xmiz5We7yLNcPABnssSP8Wp6gHvYVbjWOhHdldeVdLSXI
	8fV5VjPkCDc96dJbs+oGxZGZ5TaUmt5FUqKYr0IHk8kSkT9nWjzzC4HctNegKjv7Ssha0V92UVX
	tKCXIM3qTSpmj+kJQ4Dlv53XX6C4BD+N24GxDHvzajTm5hkr4bmjatmcjPjxV1a/jp+cm5ADDjK
	kZCdpZwv8lPLr67pidIZNxMo4B6XH8zkoMeIua0eG09TBqRY5eVNIyYb78idnR81e4+XGkHxxIC
	3ix0wPKg1SXpFpai7nHf0sONpaR2/PHTUM89tDxmwYgkwLY6k0l8SyRBxfUfAGhtaedvDuIK3ry
	g==
X-Received: by 2002:a05:6000:288e:b0:450:e5fd:e1a1 with SMTP id ffacd0b85a97d-4515b05728dmr25538841f8f.3.1778317563085;
        Sat, 09 May 2026 02:06:03 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491e94c0fsm10655662f8f.32.2026.05.09.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:06:02 -0700 (PDT)
Message-ID: <2cef410ce127b662daeaee4dda2e33c8e2cfafbd.camel@gmail.com>
Subject: Re: [PATCH 7/8] iio: magnetometer: ak8975: add scan mask index enum
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 09 May 2026 10:07:03 +0100
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-7-37827ca68fb3@gmail.com>
References: 
	<20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	 <20260507-magnetometer-fixes-post-pickup-v1-7-37827ca68fb3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>=20
> Add an enum to explicitly define scan mask indexes for the X, Y, Z and
> timestamp channels. Also, update the struct iio_chan_spec to use said
> enum for the .scan_index parameter.
>=20
> This prevents magic numbers from obscuring the hardware channel mapping
> and improves code style.
>=20
> No functional change.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 13 +++++++++++--
> =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index
> fde37cdcdd053bde1630c2f73ab717f9d008e2fa..d11f025e146d098508f35ef31c1ccad=
544612535
> 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -238,6 +238,13 @@ enum ak_ctrl_mode {
> =C2=A0	MODE_END,
> =C2=A0};
> =C2=A0
> +enum ak_scan_index {
> +	AK8975_SCAN_X,
> +	AK8975_SCAN_Y,
> +	AK8975_SCAN_Z,
> +	AK8975_SCAN_TS,
> +};
> +
> =C2=A0struct ak_def {
> =C2=A0	enum asahi_compass_chipset type;
> =C2=A0	long (*raw_to_gauss)(u16 data);
> @@ -835,8 +842,10 @@ static const struct iio_chan_spec_ext_info ak8975_ex=
t_info[] =3D
> {
> =C2=A0	}
> =C2=A0
> =C2=A0static const struct iio_chan_spec ak8975_channels[] =3D {
> -	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	AK8975_CHANNEL(X, AK8975_SCAN_X),
> +	AK8975_CHANNEL(Y, AK8975_SCAN_Y),
> +	AK8975_CHANNEL(Z, AK8975_SCAN_Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
> =C2=A0};
> =C2=A0
> =C2=A0static const unsigned long ak8975_scan_masks[] =3D { 0x7, 0 };
