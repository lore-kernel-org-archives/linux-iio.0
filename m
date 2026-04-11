Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7D3845C8
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917258; cv=none; b=lHpyOJfq84VLqEwDumQosBJ2nVYR3tZ+39V4DbBw3jY1D90ItdFIZrJ5wy1tEBg7DA3oYVjMDZCZixK8oGg1m5bFO3vpUOCW1Cudl2nY+grIXgst0Gi+ktyAzpcSeWrRt0r0uAmYxrXlU0TKOAKq1smRK0JG1v5v/UzdfhPgncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917258; c=relaxed/simple;
	bh=LTzMqV66tyhip/FzmM7s7If76qHy7vcOmvyi8SDooxg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtAuYO8AgKMEbSz1r14xY2vHIDPWmiaLLcOu9FYT4e3TlfXz6dTApAltAEKG269TNx+uz2IK0O98l/srn7EsZFYKLXw7lRjq/vYhHetJ3cskecE2R5zo2fIlTxhHUrqVTKD6bUzBqHh0YC6N+No9RlTuQXafP+GuXWiP1t5bVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2MhXjHH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2MhXjHH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so47107855e9.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775917256; x=1776522056; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJkmdJIDvUIR+BOt7Z1x81oQy5AgLCZSqyJ6Q903sZI=;
        b=X2MhXjHHWTWUb5AvptjtO1aW6ZZze4vNN8/HnLMEqlJITrKNYu3T1cGYOHJeD6D4qH
         mEnxT5Yux4pj/mlYdX0VNyjLzSAAbtO8OeRAKsqVgoDJOTCKP6twKDeWbct/4abp/G3z
         AjpBfMaa5EEXZ7E1C0A5ywTo45lhZJoDhBFNsO/rMmthhTFfcdsCr9xC3bB4Dwo7iXf2
         PmOXz6tdhpvlOyuIM85Qq0FijLVweZVa31HPu9Dpq5vUlgZlhaLcvTTw2o7nz5tPJABy
         tCx+LrjFvCrbRaqFYvowvyLfVssIcIJkiZkWaNWLyTjR6ZqooIhwv0p1ZjBUXpJr+SiG
         DBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775917256; x=1776522056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJkmdJIDvUIR+BOt7Z1x81oQy5AgLCZSqyJ6Q903sZI=;
        b=NPrfGAhEwIjkaX1DJ6IiHRke1J/s+LunKAr5WWlpMuQBNLLz06zqvhZphHBEG/wp8U
         M7T1yCx4trZrZvQZIqP63X2XSv+WNQey+UXHgDjYUV3vUa8xr/+TrJqFErWS57NiuJs3
         dEUlG1SO4yhB5KSTFYFfD3Yj8IbnT50oy6y+f3do0Kj8Y0B/xhmM2UiECavkKaovOv8f
         904eC2kLC6+v4kUfRKFZF6nNpaBW1SK5CCiQ/k+pwCNBfd8bDRnEeclvsUlYWtv7oslK
         TLdBclE49yvK4rB+yzX6QjDm+ZJQ4FDU3Gy53fxQAJmKXwJO75xvjWUcA/xzR1rNPSbx
         PW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz6xiEcMSkIC4u4C1UuUISarmyQOwrRUmLKGj96L5cWq2DJAACA0Aiov8HnzdSDBOVIDf41NdnSCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHateyXO1sdTnx5a8hFEBApOFKSseOLIZjFbg3S7YTPPXUhGG
	Q+HdlSwgyz2tIFM1EzlrGXkEgKZO2nOJwNBBfOHf5LydybDqRG/XHYXA
X-Gm-Gg: AeBDietdqbRFEF7Wyc2/RHarROSXCl47jH0uZ+3LXz94DJycPTdmmFu8yDKGPBB3Tbt
	WvNjJxnev5/VECsKGbXXsB2gM/3Ou8Hj6k2x528AOisgphGtXOn/uKkCupwWaY3EmwHl9mhk6Ts
	FMPRHk5pUrYFVyMMjm10y9JNBKIemExZfNuO75kMKEk5fma84JMoOKrUiSkY35IeZKOqKZlciMF
	6V01ffjC7NUqsyZ9Y2Tg2HMeznRnm6xWdYuscPMRx2WGqOH2zKXQJ/4ejgwtpkQ0nkTQJ5O6DUS
	8hB64wzjDeBrH1DF+qnrZC2whm8+jg5O4kBw9AR1B4wwN+TDhB4ej2oS5ZekY7eUmJMWDES19NW
	Z4nrfLsqR4eOg08X6pDWfLtLZD1gCCAkA+H16HYLMaqgc1G5lUlRg5S3OHrIt3Nkt0pN8qGTPyY
	KeFwhpzqN/nVcqS+NDzV3H2WAK/13VfkQWsUKU4EcMyOo8wap2EWFYedibBsTyb5FepGNk51ICa
	w==
X-Received: by 2002:a05:600c:1987:b0:485:5ba3:37d8 with SMTP id 5b1f17b1804b1-488d67bf736mr88949475e9.5.1775917255487;
        Sat, 11 Apr 2026 07:20:55 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de343bsm15566131f8f.8.2026.04.11.07.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:20:55 -0700 (PDT)
Message-ID: <deaaa498f1036ef39e66cca3d00b54148f4d7547.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: imu: inv_mpu6050: fix unbalanced
 regulator_disable calls, when probe fails
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>, Jean-Baptiste Maneyrol	
 <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,  Jonathan Marek
 <jonathan@marek.ca>, Brian Masney <masneyb@onstation.org>, Rob Herring
 <robh@kernel.org>
Date: Sat, 11 Apr 2026 14:22:04 +0100
In-Reply-To: <20260401082737.781018-4-andrej.skvortzov@gmail.com>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
	 <20260401082737.781018-4-andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 11:27 +0300, Andrey Skvortsov wrote:
> During a probe functions after all regulators are enabled, runtime pm
> is enabled. Before probe function finishes, runtime pm triggers and
> disables vddio regulator. When probe function fails after that,
> inv_mpu_core_disable_regulator_action tries to disable already
> disabled by runtime pm vddio regulator causing following backtrace:
>=20
> =C2=A0 inv-mpu6050-i2c 1-0068: trigger probe fail -19
> =C2=A0 WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac=
/0x600
> =C2=A0 Call trace:
> =C2=A0=C2=A0 _regulator_disable+0x2ac/0x600 (P)
> =C2=A0=C2=A0 regulator_disable+0xac/0x148
> =C2=A0=C2=A0 inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_m=
pu6050]
> =C2=A0=C2=A0 devm_action_release+0x4c/0x88
> =C2=A0=C2=A0 release_nodes+0xd8/0x178
> =C2=A0=C2=A0 devres_release_group+0x214/0x3c8
> =C2=A0=C2=A0 i2c_device_probe+0x6fc/0x9b0
> =C2=A0 ...
> =C2=A0 inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5
>=20
> Fix the issue by checking runtime suspend status, when vddio regulator
> is disabled. To handle this correctly pm_runtime active status has to
> be set early before vddio regulator setup.

The above looks a bit hacky. We're playing with runtime status for things t=
o work.
Also, setting the active state makes sense logically when the device is up =
and
running.

Maybe we should just move enabling runtime to the end of the probe function=
?

Also, fixes should come first in the series in case we want to backport the=
m.

- Nuno S=C3=A1
>=20
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Fixes: 07c12b1c007c ("iio: imu: mpu6050: add support for regulator framew=
ork")
> ---
> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 12 ++++++++----
> =C2=A01 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 3a57a3f440526..86e4d42c4d3d1 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1862,8 +1862,10 @@ static int inv_mpu_core_disable_regulator_vddio(st=
ruct
> inv_mpu6050_state *st)
> =C2=A0static void inv_mpu_core_disable_regulator_vddio_action(void *_data=
)
> =C2=A0{
> =C2=A0	struct inv_mpu6050_state *st =3D _data;
> +	struct device *dev =3D regmap_get_device(st->map);
> =C2=A0
> -	inv_mpu_core_disable_regulator_vddio(st);
> +	if (!pm_runtime_status_suspended(dev))
> +		inv_mpu_core_disable_regulator_vddio(st);
> =C2=A0}
> =C2=A0
> =C2=A0
> @@ -1953,6 +1955,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const
> char *name,
> =C2=A0
> =C2=A0	msleep(INV_MPU6050_POWER_UP_TIME);
> =C2=A0
> +	/* set pm_runtime active early for disable vddio resource cleanup */
> +	result =3D pm_runtime_set_active(dev);
> +	if (result)
> +		return result;
> +
> =C2=A0	result =3D inv_mpu_core_enable_regulator_vddio(st);
> =C2=A0	if (result)
> =C2=A0		return result;
> @@ -1996,9 +2003,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const
> char *name,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* chip init is done, turning on runtime power management */
> -	result =3D pm_runtime_set_active(dev);
> -	if (result)
> -		goto error_power_off;
> =C2=A0	pm_runtime_get_noresume(dev);
> =C2=A0	result =3D devm_pm_runtime_enable(dev);
> =C2=A0	if (result)
