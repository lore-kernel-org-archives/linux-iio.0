Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320A364024
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378101; cv=none; b=ZXUo+l9owL9D5dNMrnjVRvSKnruyQ8knGtn6FcQYkpVpH7D7y3WRpLomZB7navamuGw8dV4q7CfVSDFtBCOMGUxIjmtLvl30I7Q6S4fPmfyHl1tWayEIHJsFvixa/yQeTbC8QKfxNzbPVIes8LryxuBf387jrGkjiG6wrEkUc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378101; c=relaxed/simple;
	bh=UqWVeYwge32xDEkRXE18eBU9zg2+MYVjB2Je+Aw57LY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 In-Reply-To:References; b=UTiZWRgn4qVrNy8qJMkvhLQIVKnIccbrXvjqjkQK1rTt0IGfn5S7w16gkg7rOo4lKCo07V4ydrMhlP4+/n4AdQXNL2aYKjSuQoXkabmxIlmdiY4kmiawp/ne1rtpcQ9eFECvgcD/+ofhzpF3o/3XB/R30QCpr9CDmoM1q+dIUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPG7J5uN; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPG7J5uN"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so3102475a34.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783378099; x=1783982899; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:from:subject:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1mPrzvKCMoOvtaEIsAuwl/7Hr80X0Iuxafte3c2t7NY=;
        b=PPG7J5uNzCNgD2aObwPg5NPxilHmDefToq+R5dU6vxlTm4T+DInOHQlJBX0G4zTfYZ
         K5CDmFd+DxnnHQyaBrYYKwtYa5crkUVfkg0+9VVs8jQQP3aWlE6soriNeeMKOvOZfk+0
         5d/rnVhKVyo4f78Lv6toUscw/SncMHoLoKsjD7CIO4NzCYDD7T4aLtIkvju6S2UShamP
         UPotiDPxeX5AQaIcBFvdGx+lIf6oh3lVrwc1VCnRGuFmCJ3MoQzcn88a9WfDif2qTWmp
         j9/csItykk3GZ98x/96DhoRnZI5iUfIjJVBO/Kc5cmme3yTCmyDbryXNq3/cbh9UyVoh
         y+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378099; x=1783982899;
        h=references:in-reply-to:cc:to:from:subject:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1mPrzvKCMoOvtaEIsAuwl/7Hr80X0Iuxafte3c2t7NY=;
        b=ku0TaplGKEO+W9F+xvMxd9rrl1kmnX1jzRsXYMow8ZGrW9BFU7jMe838JPiuXTf8TP
         eiXLXUzkU1SArnM4ymVuv3wDgvCyGFr3xejJ+SWixqoabl6IyG1fINWpRupRIvmhdT0c
         yGXIr5TZ7LU+i6/XeY+gMlDYrkoKCh3OY+YR3SGf07jqH+lA2XDm/yRvHqBLSlMoRog1
         3QvCbHXa3e9t1wPGl0A/jb48fr+Gl1ioQnCPM+y4zXb0Ab4fwtML0yTHfFcz1tnYl7Wd
         bKLWwG9uSlOAiPDjlvolWA0Je7zveRbVxWhXneZh9Huq/zh1dJniyhy0J848D8XX2Elg
         cykA==
X-Gm-Message-State: AOJu0YzeTTjt6Ta7zt74MBoKfylwDK8P0ET2ac4wqpxTcA7kSExt7tyC
	cGXD4wNq42auQcLFeQsmSB3nqfMEs2hEQmnJXXVzuVU4u1TbDvckn2dy
X-Gm-Gg: AfdE7cmGXYvSzJhgU+X+7xzTCcRHNohIBeF+qhE/Dzql9Jki0ALfhiDxbpMP1uAxIbZ
	JpNJGoqb1ZTnEMKCCb92VYUteLCFBVA73PULh+wbJhSvmYYbGX5ko0U4pDihva96iFJDAT3rZ3x
	+QAtn9vBRA8kXJG+t7hAWDpn8N2toK7ufppSufKbKm3FGkGo0YhEv3eJ/VyWTt/SyvXvK90FZes
	d0sN/xULJsgMe62mQnu0DFd1y+LOZvxaAPPYVUm71UCZsngWqxaXmAuPsSMDXO9+LnnSGdMa+Ug
	zG5xVlZVxCIeYeBH8hhElng7G358eIS5CNdEHXOgPpDNlLZVTAKchR0s8qkMeLhE+LBX3VAO16V
	Ea9EeXjlgCip5rnp3xuel/ZgXMnno9I0cdvlATx/BFByfZTWJWDhiLpvaKcPfpLHiKsrdybsg76
	2B5VlZayY+U7I7TSePJLPz7i8Sai4BMrrRiHl+pXY=
X-Received: by 2002:a05:6820:1887:b0:6a1:8192:4d75 with SMTP id 006d021491bc7-6a3556bc0fcmr1668380eaf.64.1783378099404;
        Mon, 06 Jul 2026 15:48:19 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a30fc1502dsm9991205eaf.0.2026.07.06.15.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 15:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=774cd84defee6c311ef331adc024cdbd699518f4706cfad88e915e251727;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 06 Jul 2026 17:48:13 -0500
Message-Id: <DJRURTVMPRQ1.3BFV2WYXAZE5G@gmail.com>
Subject: Re: [PATCH v7 v7 3/3] MAINTAINERS: add entry for MAX86150 IIO
 health driver
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Md Shofiqul Islam" <shofiqtest@gmail.com>, <jic23@kernel.org>,
 <lars@metafoo.de>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260706223930.1807714-4-shofiqtest@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706223930.1807714-1-shofiqtest@gmail.com>
 <20260706223930.1807714-4-shofiqtest@gmail.com>

--774cd84defee6c311ef331adc024cdbd699518f4706cfad88e915e251727
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 6, 2026 at 5:39 PM CDT
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

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
> =20
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

This should probably be squashed into either the dt-bindings patch or
the driver file patch (or both, with just the yaml being put on the
entry in the dt-bindings patch and adding the .c file to the entry in
the second patch).

--=20
best regards,
max


--774cd84defee6c311ef331adc024cdbd699518f4706cfad88e915e251727
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCakwwrgAKCRAQghIb0dl/
ifA3AYCnfwi1AQILgsV3jvx/E4wL7121t4iSMTxV1vXTrdHtIxi7LmXMpxSCJ4ng
w82UOAwBfitnmV+LY9z5Z5ncSexMzIR/Uxm+AuYsx2xxHtn4C/3A3HS63bqi25QM
5oJhkciZ2w==
=qU7F
-----END PGP SIGNATURE-----

--774cd84defee6c311ef331adc024cdbd699518f4706cfad88e915e251727--
