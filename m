Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DCE396B70
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317686; cv=none; b=HEh1pBdc/BNKmFJbpiR45r2AJ1qcK1lyec0IvbCFBCKKGR8vD7/QOHQy+Av9AV/ciMDUr8zr4hyupORNmfWx4/RHHdTMI79ZRgLpsRjTGtFhUTk7wQahxQ9JVlNL2Snsi7GActW7ynBGxuEfasgWiaulMV8ap43rw2bbSy6MSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317686; c=relaxed/simple;
	bh=ybcyN8TM/mVLwVKWlsB5ZfBuqshegjD8DdEl5SoHmsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKGnypUiiaEddoUtnFQK0X3h8MriuIGr3nzPv/gYpD/UKOvQicQTaEPTiYBzC2l6idAQkJQCOpfcaFhYfrb6sQ6p3hvh+PMdu+rBp/DUbKRCGFK2VPmTTeWjTbj7fbiGfrMKyxxF0bCO9Vfb0hKc4GCPM/yM6YJt0N1XQ3bu4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdaPAOvd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdaPAOvd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891b0786beso18481205e9.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 02:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317683; x=1778922483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ikFuRE+zF9+kBhEqi6GSbp7NQvJugv+YEC2hAcroVtw=;
        b=NdaPAOvdxrsMab8ERQZTALSTQ2yIlqEdn/097ZFl356BftRs9/Nao2XAptqVc8zOf/
         YEx1Uu+vdHb0hEL+y/w4a2aTY4sIFzSH4l8NQOMfzRl2kbmAkxOBg/9cAbsGguNqmryj
         FdvdRrV5ENsK3x2dMMt5sX8ZSAtqMwoaZJdZZUrT84NTjWFnE14kwVs0425thhAt+62T
         lR8jzGhTSov8QMFCac6OwbbY3s+ucYSAtFHo1Ke0JGAcfjpDu8UZEVu47StxsmA9Slow
         59n9M0X4tOPWlb3XKUxk88KPl6WrbKFUriINDYHLZmYzCDXsaCHlHztyxSGEwDiZQV4m
         PZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317683; x=1778922483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikFuRE+zF9+kBhEqi6GSbp7NQvJugv+YEC2hAcroVtw=;
        b=kr6ETFT/tVWKYNn+CO53zY6f+278kuj8QxaXs2HYAOi6RBxQeiQ6asc3bx79MBeezq
         g2APBlQN7OEpZmarRX0OxKu/vdl4FnYcNFN5U6DJdNHt04SpZQDsRZxubVwSWUIDv/TX
         KCGVXZdxx2SRDYKvncnfsh+L9kSmVIYrTxY+TiJHFpcUS+i0+BhWQnv7CXtwA4+8B+mm
         kbOrm+Olmc3nqir743e0d/6IsTGVR9w+/XlM3rhL3o9pW0wTehbggUTl/X240IXxo9h+
         XH8cN/ktrBIr+pNtw2bOmWs+DwMb4/E5GbppQwlrcz+ZC07SL2vzM0FWkwHJqyUoAYK7
         QxJA==
X-Gm-Message-State: AOJu0Yx8Erst9uJYTr+V0KHLRcxMJyd+r6K5DMLxIV7mzSOxk2j5c4JN
	+tnjg2GNSJ2kXNlWW250nuYJmlH3Q85vASt65XtRAby6V9qaZXhDAteE
X-Gm-Gg: Acq92OFhMKVl2vbQ1mkM5kuN4H0qTp+8QSPcc4XsBGVLNXYocbiRPDu5F/P3B5dy5c3
	/xd9OKss/xcuc/f2zRCCV8WAsia4uZhwdIPUIj2Pf9TCVKgx++TSR+uED7Qhh1zUEOipgP+cT/M
	UewqT5o+7jDwBzYHYUgcnkBdXzs5g2KjITXAb6FiPW0KHFY/mwKO/o4AA5WuY/gpPQmjTpQwLWK
	fuss4z9ZDj2W1Z2FrYmUCWXdUHPu9PHRXTTzrmu7YhTBV7SzRXS85XlgUv5sUxR89ktwowtaRW1
	DGD1DCA8CUb2JKKv9oNy7qSI++eF4EqAhRZyXS8Lxozt8d0/95skjsMhuBn2j4e9WJXAnS2Q7Av
	R/3dLt0vVtPPbrA4NUR1Gff4nh2vXAqzOGWyFavD9JPjzUqt8aju0kyJNK3xw+cPrlT2YPzSW39
	YAs99tkaTowuttm+EIf0oYXE88dKaE2crpqhJAUBwYo+JLB4aUxCDF3uyfpoUq2o6iKQ0A/YiVr
	+N9zlfngdJN
X-Received: by 2002:a05:600c:a111:b0:48a:7b7b:c2b9 with SMTP id 5b1f17b1804b1-48e51e0bb44mr200557075e9.4.1778317682943;
        Sat, 09 May 2026 02:08:02 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7041c4e8sm35190485e9.14.2026.05.09.02.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:08:02 -0700 (PDT)
Message-ID: <c0909d796cc6568be96e6afa795c83e2f9892524.camel@gmail.com>
Subject: Re: [PATCH 8/8] iio: magnetometer: ak8975: make use of the macros
 from bits.h
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Date: Sat, 09 May 2026 10:09:03 +0100
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-8-37827ca68fb3@gmail.com>
References: 
	<20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	 <20260507-magnetometer-fixes-post-pickup-v1-8-37827ca68fb3@gmail.com>
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
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Make use of BIT() and GENMASK() where it makes sense.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Small nit, anyways:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 26 +++++++++++---------------
> =C2=A01 file changed, 11 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index
> d11f025e146d098508f35ef31c1ccad544612535..d8d9f706f96bae3be19e8db17b9473e=
6e0eef4fc
> 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -45,8 +45,7 @@
> =C2=A0#define AK8975_REG_INFO			0x01
> =C2=A0
> =C2=A0#define AK8975_REG_ST1			0x02
> -#define AK8975_REG_ST1_DRDY_SHIFT	0
> -#define AK8975_REG_ST1_DRDY_MASK	(1 << AK8975_REG_ST1_DRDY_SHIFT)
> +#define AK8975_REG_ST1_DRDY_MASK	BIT(0)
> =C2=A0
> =C2=A0#define AK8975_REG_HXL			0x03
> =C2=A0#define AK8975_REG_HXH			0x04
> @@ -55,15 +54,12 @@
> =C2=A0#define AK8975_REG_HZL			0x07
> =C2=A0#define AK8975_REG_HZH			0x08
> =C2=A0#define AK8975_REG_ST2			0x09
> -#define AK8975_REG_ST2_DERR_SHIFT	2
> -#define AK8975_REG_ST2_DERR_MASK	(1 << AK8975_REG_ST2_DERR_SHIFT)
> +#define AK8975_REG_ST2_DERR_MASK	BIT(2)
> =C2=A0
> -#define AK8975_REG_ST2_HOFL_SHIFT	3
> -#define AK8975_REG_ST2_HOFL_MASK	(1 << AK8975_REG_ST2_HOFL_SHIFT)
> +#define AK8975_REG_ST2_HOFL_MASK	BIT(3)
> =C2=A0
> =C2=A0#define AK8975_REG_CNTL			0x0A
> -#define AK8975_REG_CNTL_MODE_SHIFT	0
> -#define AK8975_REG_CNTL_MODE_MASK	(0xF << AK8975_REG_CNTL_MODE_SHIFT)
> +#define AK8975_REG_CNTL_MODE_MASK	GENMASK(3, 0)
> =C2=A0#define AK8975_REG_CNTL_MODE_POWER_DOWN	0x00
> =C2=A0#define AK8975_REG_CNTL_MODE_ONCE	0x01
> =C2=A0#define AK8975_REG_CNTL_MODE_SELF_TEST	0x08
> @@ -95,8 +91,7 @@
> =C2=A0
> =C2=A0#define AK09912_REG_ST1			0x10
> =C2=A0
> -#define AK09912_REG_ST1_DRDY_SHIFT	0
> -#define AK09912_REG_ST1_DRDY_MASK	(1 << AK09912_REG_ST1_DRDY_SHIFT)
> +#define AK09912_REG_ST1_DRDY_MASK	BIT(0)
> =C2=A0
> =C2=A0#define AK09912_REG_HXL			0x11
> =C2=A0#define AK09912_REG_HXH			0x12
> @@ -107,8 +102,7 @@
> =C2=A0#define AK09912_REG_TMPS		0x17
> =C2=A0
> =C2=A0#define AK09912_REG_ST2			0x18
> -#define AK09912_REG_ST2_HOFL_SHIFT	3
> -#define AK09912_REG_ST2_HOFL_MASK	(1 << AK09912_REG_ST2_HOFL_SHIFT)
> +#define AK09912_REG_ST2_HOFL_MASK	BIT(3)
> =C2=A0
> =C2=A0#define AK09912_REG_CNTL1		0x30
> =C2=A0
> @@ -117,8 +111,7 @@
> =C2=A0#define AK09912_REG_CNTL_MODE_ONCE	0x01
> =C2=A0#define AK09912_REG_CNTL_MODE_SELF_TEST	0x10
> =C2=A0#define AK09912_REG_CNTL_MODE_FUSE_ROM	0x1F
> -#define AK09912_REG_CNTL2_MODE_SHIFT	0
> -#define AK09912_REG_CNTL2_MODE_MASK	(0x1F << AK09912_REG_CNTL2_MODE_SHIF=
T)
> +#define AK09912_REG_CNTL2_MODE_MASK	GENMASK(4, 0)
> =C2=A0
> =C2=A0#define AK09912_REG_CNTL3		0x32
> =C2=A0
> @@ -848,7 +841,10 @@ static const struct iio_chan_spec ak8975_channels[] =
=3D {
> =C2=A0	IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
> =C2=A0};
> =C2=A0
> -static const unsigned long ak8975_scan_masks[] =3D { 0x7, 0 };
> +static const unsigned long ak8975_scan_masks[] =3D {
> +	BIT(AK8975_SCAN_X) | BIT(AK8975_SCAN_Y) | BIT(AK8975_SCAN_Z),

Small nit: But maybe GENMASK().

> +	0
> +};
> =C2=A0
> =C2=A0static const struct iio_info ak8975_info =3D {
> =C2=A0	.read_raw =3D &ak8975_read_raw,
