Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F837F8C4
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643526; cv=none; b=ULHbXmW93jFgZ9Y6cezLaDh8f2leqVtQEgeJuMXG5/1iLwcHLJQ87712gNVZlinv91zgzbCZt2IvJFylLglR1rI1VTozAnEgCB6b+UVVSNa37FY4RBa3DOquG41ZLTzDd7QYpZ1HvS0W45keZnM9NLQRtrs3m2yklomSctWgchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643526; c=relaxed/simple;
	bh=e1c9tPWF1R9hmgwG4AVA1/FzgP3FjnXfyhwAgmLj1SM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:In-Reply-To:
	 Subject:References; b=mT98royJGaJ/R2MqpNcUagBH33RcuN8t9hKeHAH91JWuzVYYxwNesgQFDXSClt5yp2hFSMIB5oGPV19gIhs0eB/Wr6Bzo3DyeDW2sGKL2ldT9O9CYc0WTDy3rB0yVgBjo+RGQwaG0eHkIkNoV5hN8o5farFXhlP8hEldG1rVUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=n2BcUsft; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DNtTbVNz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="n2BcUsft";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DNtTbVNz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=n2BcUsft5FLvtWq7L6p3QqNPpvH4iyCJYfqHV41ef19jhuZXo4Xx0uHj0iLvws278ase1Cw2n7VyQQn5OYeLGxt3CowCzMPJWeqTJomuH3ZHJD5b0LFXAwgsZmV+8KGaduJVLGoEBb0DklIimmGtNc9pWDPBhr6YVJvRBMuRyqi9rkCIFXqnlvKIuNeih1XgEfz6l3Fg1irOUpbewm+XpuKxDGY1baI0K1WsTIpTNZDGGMpr6kIvI/OdqQm3d44y6NDyraFct+sweczmxZtk//bjCj2mSwRJ2SOqpFW1kUMIldt7Z5rbXeJv1DIVxEjNiaEOyeZ7r2TZlXKupY7CYQ==; s=purelymail3; d=maxwelld.cc; v=1; bh=e1c9tPWF1R9hmgwG4AVA1/FzgP3FjnXfyhwAgmLj1SM=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=DNtTbVNzr1fpgKAItQByGV3quBnEX3vjfOVWcYYQc0uroKx7SK2UYnZQ5eVl2gXxTedjt0oFzpIayDv0+HdxQil+h6/aes4na0QQ8Y/51ctgXACc32pC3LhVrCTn8ajyVY1bm9ZTF++JsZpGcw1SZXsfEcewppxEQENs9KIFGdwXSDoZ2Bv9xie/pAv1iA9V9I6z1VmRnlMfdBOGeTw/jb/QQEmlTjoYhG0D+SuW+aDeaYpM3fZ9OEbjDYOuooHbX4UVeOYUFbOPcrr/MIN7vkVimXsZ5+FSOquHjJT/40onLmYpOfo6b0UrHSEWytmDy3W8xQ5QGzBU8TgKBecFHg==; s=purelymail3; d=purelymail.com; v=1; bh=e1c9tPWF1R9hmgwG4AVA1/FzgP3FjnXfyhwAgmLj1SM=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 524005991;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 13 Aug 2026 17:51:56 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 12:51:55 -0500
Message-Id: <DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
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
In-Reply-To: <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>

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
>  drivers/iio/light/isl29018.c   |  7 +++++--
>  drivers/iio/light/lm3533-als.c | 11 +++++++----
>  drivers/iio/light/tsl2583.c    | 15 +++++++++++----
>  drivers/iio/light/tsl2772.c    | 16 ++++++++++++----
>  4 files changed, 35 insertions(+), 14 deletions(-)
>
...
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 53fd423aa7ae..2d041b7530e6 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -7,10 +7,11 @@
>   * Copyright (c) 2016-2017 Brian Masney <masneyb@onstation.org>
>   */
> =20
> -#include <linux/kernel.h>
>  #include <linux/i2c.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> +#include <linux/kernel.h>

Stray change? The ordering's messed up (seems to be case for many of
these drivers) so perhaps we can send a patch to fix the ordering.

Otherwise,

Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

thanks,
max

> +#include <linux/kstrtox.h>
>  #include <linux/string.h>
>  #include <linux/mutex.h>
>  #include <linux/unistd.h>
> @@ -483,9 +484,12 @@ static ssize_t in_illuminance_input_target_store(str=
uct device *dev,
>  {
>  	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>  	struct tsl2583_chip *chip =3D iio_priv(indio_dev);
> -	int value;
> +	int value, ret;
> =20
> -	if (kstrtoint(buf, 0, &value) || !value)
> +	ret =3D kstrtoint(buf, 0, &value);
> +	if (ret)
> +		return ret;
> +	if (!value)
>  		return -EINVAL;
> =20
>  	mutex_lock(&chip->als_mutex);
> @@ -503,7 +507,10 @@ static ssize_t in_illuminance_calibrate_store(struct=
 device *dev,
>  	struct tsl2583_chip *chip =3D iio_priv(indio_dev);
>  	int value, ret;
> =20
> -	if (kstrtoint(buf, 0, &value) || value !=3D 1)
> +	ret =3D kstrtoint(buf, 0, &value);
> +	if (ret)
> +		return ret;
> +	if (value !=3D 1)
>  		return -EINVAL;
> =20
>  	mutex_lock(&chip->als_mutex);
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 4486a1d9d84d..c8a7afc65c1f 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -13,6 +13,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
> @@ -951,8 +952,9 @@ static ssize_t in_illuminance0_target_input_store(str=
uct device *dev,
>  	u16 value;
>  	int ret;
> =20
> -	if (kstrtou16(buf, 0, &value))
> -		return -EINVAL;
> +	ret =3D kstrtou16(buf, 0, &value);
> +	if (ret)
> +		return ret;
> =20
>  	chip->settings.als_cal_target =3D value;
>  	ret =3D tsl2772_invoke_change(indio_dev);
> @@ -970,7 +972,10 @@ static ssize_t in_illuminance0_calibrate_store(struc=
t device *dev,
>  	bool value;
>  	int ret;
> =20
> -	if (kstrtobool(buf, &value) || !value)
> +	ret =3D kstrtobool(buf, &value);
> +	if (ret)
> +		return ret;
> +	if (!value)
>  		return -EINVAL;
> =20
>  	ret =3D tsl2772_als_calibrate(indio_dev);
> @@ -1061,7 +1066,10 @@ static ssize_t in_proximity0_calibrate_store(struc=
t device *dev,
>  	bool value;
>  	int ret;
> =20
> -	if (kstrtobool(buf, &value) || !value)
> +	ret =3D kstrtobool(buf, &value);
> +	if (ret)
> +		return ret;
> +	if (!value)
>  		return -EINVAL;
> =20
>  	ret =3D tsl2772_prox_cal(indio_dev);

