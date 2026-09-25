Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250423B2FE7
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364287; cv=none; b=f4kehnPRw+Dgtak7JLOY6FC3wArzFcK6GuOuv9rfgu8TjQtW4T8QN8IdF0NG2iK4zA6hyJRUtFnpQjGPKky4WY/C+l+Tlh5hRMPcXUgYCqPBJb+hp+aEr2r+zsdzmRufYLMeEgpyfIPQNj9ldPTGmIRejsG9I3tVKwqRc7ldolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364287; c=relaxed/simple;
	bh=7S/MKduvHW3eZ0cEHVQzZei57mdgxITKfqv+Mzb0+Os=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NfFpV0lrvYrDBn/0u64yUrT4LZLrC5JSTNgtzGGnMQ2oeGijva2Cz6Pb+aWI3R+Z73PLYeQRTwUp1bmeoLs2U7Z7j+lGc7emUmEREUVywar+1shjAcXMaF2YnADZvveeQ98XzlI+pAjN9quYgV1GF4bA8hbDrLA4a5xIOvJU/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKG+lVrw; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKG+lVrw"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cd63c192b9so232677e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364284; x=1790969084; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7z+aHZZJ9kwGfOKnNeUVi/yULRqMkVDfnGrm/awK8nY=;
        b=JKG+lVrwLdmlikedoA8gbiM81wgJyXjc0pz4aWuQitS9ASmGKngljtPdEq3yEvgLzq
         q+SrLZ3f3afE9DP+25yhYei3Emuq8JLXQLn4CkV3CAO0sfmPKdJzSApTfB+KVaaIskrA
         guE+xzs1K9B0a1FELOZah79veNvkmGAKrBR+3Uyp3ajC9nJBHqo6pOrgLKz5d2EoP0l5
         FtTGwmN4mqa+0KmWqlAsm9Y9U/D0QcZ73CszKIvpKW/olxCfmYukI64RE1lCKE7wT9k8
         BVL0zPRWm8zk4yrPrLdwy6rd+hQl1vlevIjA6HPzpyURSpfmi92hCukqIWcTo6qj6iEL
         bYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364284; x=1790969084;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7z+aHZZJ9kwGfOKnNeUVi/yULRqMkVDfnGrm/awK8nY=;
        b=mMw0aOhJTJxUEY5Ji4J5LZl3mJrnNZSmy8M+WXWCePYPl934yM2xi73wZNzFPHNaIZ
         7jtL9xlUDWG1S8hd0m/bIi/9TvykAV7ejqsTKL0utr0cM9wSp8WER48q/PHYaKwJQxv3
         4EC2qyz3LSoTtUfDVVwNEjcRSW75J8mvZXeK8oPFPSxqvpEKXYhPryJg4EFA/ztiT9+K
         K+rrvgldQhgkTG3JPbhUvgICn5o0x6la9KHICGxI8QNOWwR0RdUUtPrREwOaU3eJ6zqN
         PJj3B5o5JVBOYt5+vBCVMZ+ZwvJ20tOAuE/xgC1EzWCEm7WK/FOvbuZ7xUOiYVcz6YND
         x7CQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0m50mAMb1hRICLImsxmkAWLZRdY04kujR1zm7nBgFBI1GthbO3aYe5IVH/ruavuaq1mUE1i130V8=@vger.kernel.org
X-Gm-Message-State: AFuF++k0XPGHEI6L9hFhNa7/RBaZm43egk5pOFdmYTJJ0v6EVxcWY7hB
	7Hyl9esmxI/FTXRevPWH4wZFZHCSrWhbU0txvatSvXBBjHxMD+bD+lfa
X-Gm-Gg: AYBFou2twC2tRwRaN5dy/7h2ffksF2dU17Q+HN7qiYfkngrkV8IegxrLO4nbt/h3TDw
	T44MkaywPF96VmVTC8RlWW54E3zR4FDZ8XPwt9Mr7v2hbLc+sxRnTN7u/xtwP13nzdLKg6s2Aff
	6/fzwmlAeg35pKB0+VHGiXQsC+Zr/YiuEfPq0l5NS+nZ7F9hlNKxoeMH8LtG0JXX3VD7EM81nNP
	oQqhBBXQ72FDzsJzwFTCb26t2/oM7H9kVOqTW54ueCQtU/+C4HXKkNHWHxvnZwHO4Dvl7ef9NxZ
	WQM9MY6k6VmNVKjtHJxttF+0+ASgmUXCSQbwG4+VGIIoZ4SEC+JTeu94JBjB7h74MbTqEIlIYif
	6G2neqPHK8yTebZoYmXMBtO2Glpv8/C4dxB0wN5zcIpmaXcklucteatZz0AG4nXDsYOWa50bjya
	PZEv2JKXQDQLqIZBxPZZXMacKg2JSyDDWPXThypSIce+TU0pttU2qnwIzMYeo+eacBTAZpObjh5
	ApNeVE9fAnW+RcJeZfKNUuM2RwXWVhzaOOFhQRu
X-Received: by 2002:a05:6102:8098:b0:7a7:1db6:c769 with SMTP id ada2fe7eead31-7b1c751f1e3mr1094309137.22.1790364283907;
        Fri, 25 Sep 2026 12:24:43 -0700 (PDT)
Received: from localhost (host-190-210-193-94.iplanisp.com.ar. [190.210.193.94])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861b0b6ce4sm3698675241.13.2026.09.25.12.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 12:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 16:24:39 -0300
Message-Id: <DLON63JAAXEO.18FNAXS16CHHB@gmail.com>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH 7/9] iio: adc: ti-ads1018: reject devices without match
 data
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jiale Yao" <yaojiale02@163.com>, "Kurt Borja" <kuurtb@gmail.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260925125754.2162337-1-yaojiale02@163.com>
 <20260925125754.2162337-8-yaojiale02@163.com>
In-Reply-To: <20260925125754.2162337-8-yaojiale02@163.com>

On Fri Sep 25, 2026 at 9:57 AM -03, Jiale Yao wrote:
> SPI driver_override allows a device to bind to this driver without
> matching either the OF or SPI device ID table. In that case,
> spi_get_device_match_data() returns NULL.
>
> ads1018_spi_probe() immediately dereferences the returned chip
> information to initialize the IIO device, causing a NULL pointer
> dereference.
>
> Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
> data") fixed the same driver_override issue in another SPI driver.
> Reject devices without match data before allocating the IIO device.
>
> Fixes: bf0bba486b5b ("iio: adc: Add ti-ads1018 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

> ---
>  drivers/iio/adc/ti-ads1018.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> index d9ec4a8d7ce5..8f2d03eee77b 100644
> --- a/drivers/iio/adc/ti-ads1018.c
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -624,12 +624,16 @@ static int ads1018_trigger_setup(struct iio_dev *in=
dio_dev)
> =20
>  static int ads1018_spi_probe(struct spi_device *spi)
>  {
> -	const struct ads1018_chip_info *info =3D spi_get_device_match_data(spi)=
;
> +	const struct ads1018_chip_info *info;
>  	struct device *dev =3D &spi->dev;
>  	struct iio_dev *indio_dev;
>  	struct ads1018 *ads1018;
>  	int ret;
> =20
> +	info =3D spi_get_device_match_data(spi);
> +	if (!info)
> +		return -ENODATA;
> +
>  	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*ads1018));
>  	if (!indio_dev)
>  		return -ENOMEM;

--=20
Thanks,
 ~ Kurt
