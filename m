Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921D3F44D7
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960090; cv=none; b=JTIuK1pxAy7So1onaaNrbPsnPacFbVDjf2yRTSDPMh9IeB8h2PZC4aeP2ru7AupJ69ziEa46m+icCBGV60F5y05cOUF4LT9DfWL534W4U29GExLLUODoCb8KosNMyP2Xtez7ySdHo/F8p2dks/+PQ14xqtfg1I+KpOsaxCPYR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960090; c=relaxed/simple;
	bh=pDr7mi7egq3Xd+OpGVwwm8oE92ju/KDFzIKYrYbruc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNOMO8Ty2bB0AC8ZdK3EEl6ez1AZPAp8dGNgQVrrEzNgkfEBRen1tZTHW4DqtZADUdqBVuWbJEB47ip9gxWbH1lpTy6+Msxgtv3U2FCH97/sSZt2nIJyDWiT+cVEaXyT9fZMZcKuqw2DdjgWlvqEgSZzhqnCY/atV69JJxWk8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4i8U7+2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4i8U7+2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954df200ddso22121185e9.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786960085; x=1787564885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UOVNQpPLxNG+nZZz+2QurUs28OONGC9prKgB2CFOhCc=;
        b=P4i8U7+2NPZ1UNL4ewPLlTJvRlcdlzKVZ1x7VWtoaI3zoNx1+/inZlbxkIfzhSvnNw
         UgnExDl4k/LVV/wapzvXXQxY2sxtB6JtGhWNjm+m7YgVe74v3GiEYJEKkQenhwjOCHsl
         1UwggBkl3ptZvxV0W089isMhukmnLjNLrmbhSmSlNm3x5XhfbUE/jZtrwrLl7cAdA+i5
         PDh7wELtoouhOk0E7d97npISoGIA3+FgGP1Adn4P+tcDFROZ91PdaQtIj93YvPnhEmz9
         sCXhfoRExzkQEFnumTaf7SY4KQUCux+Jol2lqdkAn1XteXtlP3ZordfxiOR3MyTf2OlW
         X2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786960085; x=1787564885;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOVNQpPLxNG+nZZz+2QurUs28OONGC9prKgB2CFOhCc=;
        b=F13dGOo9jB0O9DqGBnrPr+8q7tgwHXJQSAD835Uo9BsaU0NV6PCXbObaP2HLWx1ce1
         cDMF85sdUObNEGCVJ7EuyaBTW3S7ht/83T1GzRPbEx8YWDv3MP+wXZtbuNlQAvKzNTIo
         OqL93MSpq/dvlOOnSsq6xQaIg2PtwGb5WoT4FFTp1MwWc6d5SJU+BY9Hx3coW7Y20hSF
         DSPnh99Mds6IChjx4Mi9C7A/AecbL/dBvMgZCRuKfyzFy74deglqSvCQ0ZU8i/WoOVpx
         XAeA5VKYRGn4fNGzkgZOV8bzlf/eJvm6x6ayX+Z0VRhdP7qKWp9AMgDUZWl5ZTp0snaR
         XFLA==
X-Forwarded-Encrypted: i=1; AHgh+Rprv4VtXM8kusPRpnaHHTknY/VVLgCDXbACPRQQ4tzRkbTeXOh6D3zwk06K/nAkOQdPAF3tK4d8uoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJr+06dYJWSEpWxqV7/zP6S+oR4uksMDGoX6YyxL+gDyCh6cl
	1xSWc5WXDihmsfzilt/cuHkdzNFNT88G5u6gXXmq53uLIyc6yCTLGvRg
X-Gm-Gg: AR+sD13wtu9Oo1LiLi3e4pHmInzaSCUuYQ4o/sBeGXqfwjvVgp+i0k9LNebx88GsizF
	tkMrWbBX1DDuljyLSkMEmpch3q/9gmU85vQaivClb0AK40FkQINp/HAhDAm8u441p9FXBdHE0F8
	lYieQqyKjvl9EPRp9wmuYlWDAOBIHvv0qRCQXhcXOv3qLcCGZJMgbAwWQ8fgYFF4meiL6H7tTE3
	V1fCHj7Dgn53yOvtuz++A7et3yscLubKBxY6hVpXyBnVUphFTJvZJ6EZ/DqBFoM0Cbbe7MozQHD
	ythhlYLngWSXAtZcfkdRGS34vRMvZkOnXrBlhF23u3BApCJC1B8LLn7Ro4Wm0k9dpkZjL+rqgAT
	oohcK9+HP6BqnoeNov8/yqK1j4Lih9nVHVEgtGEOYUnLR+Eu1T2ktLSFVGTBdev9ZymYljvukpd
	ADBZwjEVC+7pA7JnUWg9dklyG+DXVkE1lilYufpoE+JOmzmYkn1hETKQhn7+f8CwlViVYfM2lPe
	7tgIrEU9pOUWDFuKup1mm6g0HRZUEhbTgAr2uUvDaRZiSfGFp9iMzfadSJ7PSxQhOEPG3qoXslh
	qfzuXeG6l7Rc6SQAjcYx9VRGg/7FzcWey11Fe00b9eLS0ClzEMLoDDBLPzdpYCjC64qoP/GOo6+
	gfA5iE1qNu1+dtghG9UxwxIpF7obreLqNGB+qt81WZSn3dCmBvb632JlmwqtsL8YqNJ5twXoVtK
	wHzQor
X-Received: by 2002:a05:600c:8209:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-4998796f497mr392883625e9.13.1786960084649;
        Mon, 17 Aug 2026 02:48:04 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996100184sm168855245e9.1.2026.08.17.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:48:04 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:48:02 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Henrik Grimler" <henrik.grimler@axis.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 3/3] iio: accel: icm42370: Add FIFO buffer
 functionality
Message-ID: <20260817114802.00005872@gmail.com>
In-Reply-To: <20260813-b4-inv_icm42370p-v2-3-11aedfdf76d3@axis.com>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
	<20260813-b4-inv_icm42370p-v2-3-11aedfdf76d3@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 14:26:12 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

...

> +static int inv_icm42370_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42370_data *data = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &data->ts;
> +	struct device *dev = regmap_get_device(data->map);
> +	unsigned int sensor;
> +	unsigned int *watermark;
> +	struct inv_icm42370_conf conf = INV_ICM42370_SENSOR_CONF_INIT;
> +	unsigned int sleep_temp = 0;
> +	unsigned int sleep_sensor = 0;
> +	unsigned int sleep;
> +	int ret;
> +
> +	if (indio_dev == data->indio_accel) {
> +		sensor = INV_ICM42370_SENSOR_ACCEL;
> +		watermark = &data->fifo.watermark.accel;

You don't need this check, since the ICM42370 is an accelerometer only.
(I assume this is still an artifact from the ICM42600 driver you copied
from).

> +	} else {
> +		return -EINVAL;
> +	}
> +


-- 
Kind regards,
Joshua Crofts
