Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551BD3E51CA;
	Wed,  6 May 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083671; cv=none; b=ZeSLp5FBS9gtS54X4DAh8QDToUL7nt0PVr51qbkdmT3wFfAm6eROj+pngphBhea11n+fIgzqJXE3APrKRUcIlX8qk2lYe7GC2tHTla3PHqA5aCu7Ioz2GFNTYG+6H4J/5UP39zPlxC8EwTUOKi+xLMkBaNskhiyz/fysbgQuVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083671; c=relaxed/simple;
	bh=myWPkFAPWnrGXDyBlpWFWbsi/jhj8ocmdvFf2lEx9uY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAQRFC21g3qWAUE/fBZreC2/R0zmATxObE2Km33RmxJD+t9xUMj3ak1WDbbZXOBrWIXrAj8T+Bg1C9y+uiiaV0rHwQ4n2YOye3hfZK+6/gChahwFieFKk0biAaJKhfSiqsTUkm086RwIjZnNs276mIpSqHHuFe36isUyRkzqY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhjyxdnJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhjyxdnJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CF4C2BCB8;
	Wed,  6 May 2026 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778083670;
	bh=myWPkFAPWnrGXDyBlpWFWbsi/jhj8ocmdvFf2lEx9uY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RhjyxdnJQ1XdbZpAPgrUQhMgXABEVvanvCH/6Q/wXQPjyugrOmsPUU5FudET0GKVH
	 Vl7gKEiC+Wt4vvRXdJbLwbSMzE+x5F44Kqw9tYHs/Bqpe8+01ovKBpCpwfqqLDUavj
	 srEiKptQ2j8qxIyli6Zh0VuA930jM42zUK862rO71JEgnG6Rd55YKMD9ktgNtrSXA7
	 5rSH1RYIGWCM52uFnAJ7/Qlfe7kjFB9hGmp/ZXzEHi9gPYbCmvOYEmgSiXm0fvdI5F
	 eyIvdDouTrIwwCTPGARA1zcBBwu1lqyudXmaOoegECkjVAPu01WtZsVeOSGBE0vDt9
	 tJWMKVNzkmEXw==
Date: Wed, 6 May 2026 17:07:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wang Zihan <jiyu03@qq.com>
Cc: corbet@lwn.net, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adxl313: fix typos in documentation
Message-ID: <20260506170740.2e49d2ba@jic23-huawei>
In-Reply-To: <tencent_96704F824670A593EC348F183D5C5AAC5C0A@qq.com>
References: <tencent_96704F824670A593EC348F183D5C5AAC5C0A@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  5 May 2026 17:22:43 +0800
Wang Zihan <jiyu03@qq.com> wrote:

> Add missing space in "ADXL313is" and improve grammar for
> "a single types of channels" to "multiple channels of a single type"
> as suggested by Jonathan Cameron.
>=20
> Wrap long line as suggested by Andy Shevchenko.
>=20
> Signed-off-by: Wang Zihan <jiyu03@qq.com>

Applied to the testing branch of iio.git.

Thanks,

Jonathan

>=20
> ---
> Changes in v4:
> - Wrapped long line per Andy Shevchenko's suggestion
>=20
> Changes in v3:
> - Reworded "a single type of channels" to "multiple channels of a single =
type"
>   per Jonathan Cameron's suggestion
> - Split into two sentences for better readability
> - Added this changelog as requested
>=20
> Changes in v2:
> - Fixed subject line format (was incorrectly [PATCH 1/4])
> ---
>  Documentation/iio/adxl313.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
> index 966e72c0109a..cc0829be0447 100644
> --- a/Documentation/iio/adxl313.rst
> +++ b/Documentation/iio/adxl313.rst
> @@ -11,7 +11,7 @@ This driver supports Analog Device's ADXL313 on SPI/I2C=
 bus.
> =20
>  * `ADXL313 <https://www.analog.com/ADXL313>`_
> =20
> -The ADXL313is a low noise density, low power, 3-axis accelerometer with
> +The ADXL313 is a low noise density, low power, 3-axis accelerometer with
>  selectable measurement ranges. The ADXL313 supports the =C2=B10.5 g, =C2=
=B11 g, =C2=B12 g and
>  =C2=B14 g ranges.
> =20
> @@ -112,9 +112,9 @@ apply the following formula:
>  Where _offset and _scale are device attributes. If no _offset attribute =
is
>  present, simply assume its value is 0.
> =20
> -The ADXL313 driver offers data for a single types of channels, the table=
 below
> -shows the measurement units for the processed value, which are defined b=
y the
> -IIO framework:
> +The ADXL313 driver offers data for multiple channels of a single type.
> +The table below shows the measurement units for the processed value,
> +which are defined by the IIO framework:
> =20
>  +-------------------------------------+---------------------------+
>  | Channel type                        | Measurement unit          |

