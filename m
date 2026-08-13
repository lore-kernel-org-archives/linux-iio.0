Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80E3E9C26
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643859; cv=none; b=m/lNqWNliUSkaINGB6apmrEVwzsBOH0DUiVWUPDXaoCPnF9EZ2SNFiASve4rACZbE+Sc9jw5/Wd4eVpEgU46nmTSKhCz4C8i/ACVAeP9QwFJ2DdDT6zu6xRjGprpH3qf4yEy6u1Pjr/WttqRyymsyiqQV4H7b+XE5oQb9fw5//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643859; c=relaxed/simple;
	bh=Bl10qAER8S7IcUAyWGnfVaas467YNuAfuFJb63N7Em4=;
	h=Mime-Version:Content-Type:Date:Message-Id:In-Reply-To:Subject:
	 From:To:Cc:References; b=nMcSOrx1ZAV9205wJ9c37qYCc+hbUeSGqbQX+jKnz3ZeDMZca8rEVVj9TMfWxqkussHR+eUzkDqfNMQnZvj/ybpMClEwQ6iDLjWoOs0o19gQr34l2uP3eCuF8Skzq4E7hzlrhZhqbcA+n9ZnEArTLpAN9DRz5VpzQsx1257lOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=EU0JUf8E; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=pBsi92dQ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="EU0JUf8E";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="pBsi92dQ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=EU0JUf8EK7LPpKCwgYoXRzSBwNS6F3We8f7JuLiWE3EKWsZLFIz2SBGXAiX7Lr11bKFvHtVRPxLCif9uC5CWi3wfETc86mSVr5D9qLbMaBGQ7HOULjdPKZzVpjlEid6cR+EWOX009S7kOvFViX8TJdPqJ8l30d3NfNxUGkdldL6iXKcpM9gCkg9d1mxKP7R5vKnXoj+dN2jL6JJgBoagaZMr9+WV76TXEQWFL1FAJDDt0ju2gWlVVfEAbRGCKf4cQmN/EnjE1mi55LdOdTAINr/LWMgStI5gxuje8xK7kNhoJjB2elVAdVHECGgE0D7voTG5a6WD7K4mD8uO4qmDhA==; s=purelymail3; d=maxwelld.cc; v=1; bh=Bl10qAER8S7IcUAyWGnfVaas467YNuAfuFJb63N7Em4=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=pBsi92dQbHM7tBRXzHhvnkkSSohjJVgHNCAcj47cmnnvTNXDWN/DGp/YPsLDJB21gRXeyZR4VrnUjgHSb6/PgMrWJgq67creQn3dQBfJI9Jg1eC15gYjsUa3eumsL7ElUmrESdOXbvaparv+uGlH1vCS+zHCMTmm6X7HcYfzi1lOxGPSZUNkKlsrdf+pe4S+Mb/p5wPVDiaA+BolQkT4+w/fZ54KfBVNc0wKbfOgoX0838VH2hVgyuj4QraM8NV2oGwZhnHoEq4K9quoly+YVGl3/MlroaPyYDkdbQOS2Q/iNSHddn4q6QQ4a3Bq1CRhI/fF5kuJRmmsxV5Phj2M3Q==; s=purelymail3; d=purelymail.com; v=1; bh=Bl10qAER8S7IcUAyWGnfVaas467YNuAfuFJb63N7Em4=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1504209366;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 13 Aug 2026 17:57:23 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 12:57:23 -0500
Message-Id: <DKO0DUO31PNN.33ZBMHQWWAXWG@maxwelld.cc>
In-Reply-To: <20260813071912.2465208-3-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/4] iio: imu: inv_mpu6050: Unshadow error codes in
 ->store()
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "Maxwell Doose" <maxwell@maxwelld.cc>, "Sakari
 Ailus" <sakari.ailus@linux.intel.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Marius Cristea" <marius.cristea@microchip.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Tomasz Duszynski"
 <tduszyns@gmail.com>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-3-andriy.shevchenko@linux.intel.com>

On Thu Aug 13, 2026 at 2:16 AM CDT
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kstrtox() may return different error codes.
>
> Unshadow them in the ->store() callback to give better error report.
>
> While at it, add missing kstrtox.h inclusion.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 5796896d54cd..38c3f3b398d4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -13,6 +13,7 @@
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/acpi.h>
> +#include <linux/kstrtox.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/math64.h>
> @@ -1303,8 +1304,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, str=
uct device_attribute *attr,
>  	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
>  	struct device *pdev =3D regmap_get_device(st->map);
> =20
> -	if (kstrtoint(buf, 10, &fifo_rate))
> -		return -EINVAL;
> +	result =3D kstrtoint(buf, 10, &fifo_rate);
> +	if (result)
> +		return result;

I suppose result is what was being used before? Oh well doesn't seem
worth it to send a patch *just* to change to int ret.

Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

thanks,
max


>  	if (fifo_rate < INV_MPU6050_MIN_FIFO_RATE ||
>  	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
>  		return -EINVAL;

