Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420743054C7
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154597; cv=none; b=gjAjvFGizeJtYsGC8UwT1a/lifUM+Lg1ZTNOrSVY5ueYmPIIiY64V+0Cl4r5oYn9eNYaal9iPNEyKYsYBRltx2rItKdFoGZn9E3rqZEi9dSuTEWV09IQa1daPC9ZBiKOkOj/8lYfGoCaD9ykW2XBNk/LdcxyRTX5oPFDm/9JY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154597; c=relaxed/simple;
	bh=Adxtcaj5gXdszEkLumv81RUtL2t0seACB+0gj7M3PnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDTK6OTNkuHpXWBA9FIeaFLRtYgWgCTU1bmoPUaJzPoYQiu9YV5qEEiMfMCgZdsfMMS7mXEVGQSGb1Xriqm20TffgM9Ts/U4TDbqk2I0U9WPCln1+FUnudcP9LMw0HAARbz3QHTjAu90tZrGiNLcyYkVneNpchw7Oyzja5uemSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Hu3oL1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Hu3oL1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so27986265e9.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773154595; x=1773759395; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TYlGoIbjoDt3A7y8h3rrcVY2ZMLgrI9LbvC+PaAruog=;
        b=O2Hu3oL1IagBYyv2LhyBGZgHH+GXl2CxoU133deT6ITCy8kVls7AJFrmYs8aWQIbp7
         wwhvEopRkkocCwMzdqyRzPPWvR05Ycm06rKk5JbZV7yDfYlZQ1SjzhwmIDYKGoB4CGUU
         b+RUt7tOuNzUPblSk7JzpjvVTl9kMPSffNEl1mNoemWq2s78WwNbmre4V2Tq7YSXgmko
         mtdJ1xSGXRZuEdODa5aj69j7p1iS6OCZEtwfPse8NwR0WzF3UqlFQroCiT3IBXeWu4+H
         EDWL2lxKD7FHyc/vLW2DijkDvVDOTZvDbJneuS+8Ih0N6U9SX7yIVui3HxQmzy9L+tL/
         7txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154595; x=1773759395;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYlGoIbjoDt3A7y8h3rrcVY2ZMLgrI9LbvC+PaAruog=;
        b=gxhx+t9K0p1f6ohNlYuC8U21/8vw9dQ2IZ2q6tqofKm+CzwPUiT5HxdDJIc9ibIDss
         XjIsUVIaPccwnf//4zVp2J6H1jH75GWMEl2jgzw8XWVFw14uF0kiSPsCmSGN0gScmp0X
         O6ib9TlAyafau/1sQcG+f6PUx1X5VmpqVDGK3yUJB72kfPKU++zcnujeZXCXiD0kWnEl
         8Rm+4+faXOxzOqq3FzLSSk7daBtpdN7xxw8bKr5FtD0kOl4DOY4ZIc/ZfbBNlzduF1g4
         3uh4mnoesguzVIrw8uLwzG/agOVV03vi7HCD/qszswXDN+cFD8J/522qL5Zq3apACTFD
         naYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOkGixbyDmD4tIyFCc6N+g+U6qzkNzoKn5dq+6hc7ck6WV/7m/vgpu3sXpCnPFxZQHRzKTA+QBBPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2Y7cgS9dYLPcRqPlXWMkHGAACc/LGjXMv+6ePjulpFaTNN6v
	lV1cLshgTBXL0GlqPORM7ERlk3DR+7DpuKNMbtI8unu0dep5MLMpKnIL
X-Gm-Gg: ATEYQzyGg3XS9WhG14hg196o+b2pcvjh2Z4gRRrpr2Db7b85kfPqmFsd7NMTSEdzO37
	/ytJeHtlLQAQy+QWrQNlHETv9r4v6a55EdslaDIOEVaj7PGf5rESqYZ//sgcnFOM5k8AWbx+4m5
	mIewl++7z5hQ0oD49uhoxqeVlM/vwkJcSPcWpAvLJ7upuBnYpYdsI9ai52JsIEBpGcEEakmIwqU
	3qXRFnaxlt3WM8DNQx0orWqYRyhbFpZ0oRxaQYxRlTV8iwpYCexBWk4O8fkX3csFM770Q2C80Nz
	SkGCUMdoyJoGVK7k4eM5xs2Cxt2M1fTY156x6k9bDrhMaQBsEWFxLVbmoXKFk0UWRnmAYq9aM9W
	H4rYa8WrR4hldzsWGZZ6xPZ/QelWxBvSKfDFSPCrArOLdcowNusK4VWgadt2ba+CajsvLO786eA
	7zioWPnsilFjYnVxveq9LUTAMGVVbaaRI=
X-Received: by 2002:a05:600c:138a:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-4852691c5bamr277357445e9.5.1773154594345;
        Tue, 10 Mar 2026 07:56:34 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa7aacsm100218115e9.13.2026.03.10.07.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:56:34 -0700 (PDT)
Message-ID: <26ee13c084488bb66aec8e240e416e3e43f3b697.camel@gmail.com>
Subject: Re: [PATCH v2] iio: imu: bmi160: Remove potential undefined
 behavior in bmi160_config_pin()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Nathan Chancellor	 <nathan@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>
Date: Tue, 10 Mar 2026 14:57:19 +0000
In-Reply-To: <fb653ed07fa99e3ebc51374bb367cba5712e4ca1.1773114154.git.jpoimboe@kernel.org>
References: 
	<fb653ed07fa99e3ebc51374bb367cba5712e4ca1.1773114154.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-09 at 20:45 -0700, Josh Poimboeuf wrote:
> If 'pin' is not one of its expected values, the value of
> 'int_out_ctrl_shift' is undefined.=C2=A0 With UBSAN enabled, this causes
> Clang to generate undefined behavior, resulting in the following
> warning:
>=20
> =C2=A0 drivers/iio/imu/bmi160/bmi160_core.o: warning: objtool: bmi160_set=
up_irq() falls through to next
> function __cfi_bmi160_core_runtime_resume()
>=20
> Prevent the UB and improve error handling by returning an error if 'pin'
> has an unexpected value.
>=20
> While at it, simplify the code a bit by moving the 'pin_name' assignment
> to the first switch statement.
>=20
> Fixes: 895bf81e6bbf ("iio:bmi160: add drdy interrupt support")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/a426d669-58bb-4be1-9eaa-6f3d83109e2d@app.=
fastmail.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/imu/bmi160/bmi160_core.c | 15 +++++----------
> =C2=A01 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi16=
0/bmi160_core.c
> index 5f47708b4c5d..4abb83b75e2e 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -573,12 +573,16 @@ static int bmi160_config_pin(struct regmap *regmap,=
 enum bmi160_int_pin pin,
> =C2=A0		int_out_ctrl_shift =3D BMI160_INT1_OUT_CTRL_SHIFT;
> =C2=A0		int_latch_mask =3D BMI160_INT1_LATCH_MASK;
> =C2=A0		int_map_mask =3D BMI160_INT1_MAP_DRDY_EN;
> +		pin_name =3D "INT1";
> =C2=A0		break;
> =C2=A0	case BMI160_PIN_INT2:
> =C2=A0		int_out_ctrl_shift =3D BMI160_INT2_OUT_CTRL_SHIFT;
> =C2=A0		int_latch_mask =3D BMI160_INT2_LATCH_MASK;
> =C2=A0		int_map_mask =3D BMI160_INT2_MAP_DRDY_EN;
> +		pin_name =3D "INT2";
> =C2=A0		break;
> +	default:
> +		return -EINVAL;
> =C2=A0	}
> =C2=A0	int_out_ctrl_mask =3D BMI160_INT_OUT_CTRL_MASK << int_out_ctrl_shi=
ft;
> =C2=A0
> @@ -612,17 +616,8 @@ static int bmi160_config_pin(struct regmap *regmap, =
enum bmi160_int_pin pin,
> =C2=A0	ret =3D bmi160_write_conf_reg(regmap, BMI160_REG_INT_MAP,
> =C2=A0				=C2=A0=C2=A0=C2=A0 int_map_mask, int_map_mask,
> =C2=A0				=C2=A0=C2=A0=C2=A0 write_usleep);
> -	if (ret) {
> -		switch (pin) {
> -		case BMI160_PIN_INT1:
> -			pin_name =3D "INT1";
> -			break;
> -		case BMI160_PIN_INT2:
> -			pin_name =3D "INT2";
> -			break;
> -		}
> +	if (ret)
> =C2=A0		dev_err(dev, "Failed to configure %s IRQ pin", pin_name);
> -	}
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
