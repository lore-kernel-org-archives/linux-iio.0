Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15A415F00
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228768; cv=none; b=M9kEdJQTdoXFZjGtsZTG5sCf5KOd+VtkoNXIo8gAbpLDt4uZHXNTobe0fAI2LiDECp0PPff2DbwcwhxH8Z/03r3XqZRzpJYPOt0K+Cc8Cb5rG5GyWcUZ3yNzLG1Oju1TsSwdTYZZZturlH+dIe+/59naTpZysg89PqZa7AjoBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228768; c=relaxed/simple;
	bh=/az9wwtwzNUAm+umPMS8X6X6XbGoBVmRWn/PzdN+a20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPR33Ud+boYCkYrIeD3N9Wgara50HHVSuVNnzpVxkZOU9l2677/qosEJMuc6X/PazZPUuZkhy8uWitev50hgK5P2SyJOK+b7kMnHDhdvqTwEF8Cv6v+/5Z26GSLr2S7UOjXOkODP6ejbr4gtUKgIhun7YBmFiip7lFpTEu8gieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZUGXJeV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZUGXJeV"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-856114a8247so4250107b3.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788228759; x=1788833559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lRjUZEJS6BcJ/ykufOuQV9s1kDgTbH3LbjoGvDl9y7s=;
        b=BZUGXJeVawBZi9mOT0bdaGmLlusE2/sCyhvNBjvbhQrE93D52+nRdl+CV3UKBF92Gc
         oH9q2js/ljhoOEfSGoS9sJd/UEWGPdPhr/zQY56Ns9P/33Zjxsn19gftWu7LXq+h/hz7
         tsr+a83vXIi8GZoEQqakuX2Ww2z7pa1dwGQfDTeppx63uHEutJVrBWRBUiuUpjXVa+nr
         AcAGCCUvhDwMXpLJ98FKf5xYI3zRZ9jqXGy7G78KwAlqYEZVhBu5L9OmrKwEcY3VyhLA
         E7j0szhz8ylVu6ByXZFlNPz1A4l0Vhh/YPTqlEQ+K5GUPKvIbRJ+RoFLv7B6dHej6NCb
         /K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788228759; x=1788833559;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRjUZEJS6BcJ/ykufOuQV9s1kDgTbH3LbjoGvDl9y7s=;
        b=RuYTNbP9WsV2rurfJjDVfdRjdPKH0kP03qajjSprJYOc8uSHxKQLj3nIG5Qaig4iPW
         3JnZoUnp7mNJ1KNoXXTbQ4gW2oPlPM2jcNqMylKFg+WXUUPWUR7Pmn5epurar5zlAGwx
         54Pzqf+KmPt9UiGd/1siOsv7YpjGS3IKHMvYajUGwr2obc0VZrjIH8uLJQaGGOXc8IhT
         b1YaE2HGvsH2JtzqHxBJAt26Hc61Solco74/O6fGz1cv05AkquqEEJZTXB6K3v+lDK7j
         2TZhxsuxln+7RI+zuvuYJ5MJHHQQBhNCfjnf8nzccfcB+IXHDu1b5cXWwlZzNJyiHcBF
         mXtg==
X-Forwarded-Encrypted: i=1; AKwUvBxUyNqJWPgCGF1pVkE+k+ytVrPqu7HFdZxwdi+P9Kz3BOkx2fveJtVjKTQt/9vDrZYZDEm5x4szXgY=@vger.kernel.org
X-Gm-Message-State: AFuF++neCuJ5LQ8MIVGDoiIAaScmQAoz7tMMuNhar5EuzIgB6zGZ8WAD
	l3WX1Flx0cgaoFLw9reKOsU5/Tq2MahQMRHA4sOqFjWWdf9P1na47wW9
X-Gm-Gg: AYBFou3NLg2pVmjKhKWrTHwzJpHf+GOy1gru4u1kdMf7OmJlqDagZloDH+r+kc4I9xt
	ykcND2FG3vP5tESdUnqGYQ58FcDdJMZmVhfJLN47TORTgHrmB2EZoqopmf9JsDUKMid6EjBGWZa
	A1OC4JxXSFGlUli5mYSrhHEmoT7xZN+uYRJ/LmZeDzyPzOUsjt4b5xhCaXRFy2jmB34rrZxfO0G
	BymjAfGwlKi7sF9ktK6QjWOsE0RU0SxPUm8Btkcf2xLMWS2QoPn0cZDtcOn1rq6z/uCJgmRrwQl
	xrJ5rSsD/+amTZ2uk/t0Wb/IPUGCBZtEFWa1KT7EqIE/tZaOaJCLCQPYz286D6MBmzN6IkHdOIk
	Ydsy57+XGf47hPrYtWrmBvlDKoLZv/IgtfvPPeEDMAsuTo/LAIpA79Ip2JP36n1ly9OB9xf24Fi
	s/UYVkx1MlqC8L5QzLCEDv8Y4R2pb3SO+8/rfW8M+9VWC+w6cihra8qTMU3AF8aBtWXMvZ
X-Received: by 2002:a05:690c:f14:b0:81e:9826:942c with SMTP id 00721157ae682-85d625bd769mr118991397b3.0.1788228759485;
        Mon, 31 Aug 2026 19:12:39 -0700 (PDT)
Received: from localhost ([2804:30c:94d:7300:da0f:c2c1:1aa6:43da])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e65f146f8sm64998207b3.29.2026.08.31.19.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:12:38 -0700 (PDT)
Date: Mon, 31 Aug 2026 23:13:28 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: bcm_iproc_adc: use
 devm_iio_device_register()
Message-ID: <apY0yIA2EX-n3wl8@debian-BULLSEYE-live-builder-AMD64>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
 <20260830170919.470974-6-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830170919.470974-6-mdshahid03@gmail.com>

Hello Mohammad,

This patch looks overall good.
Two minor things inline.

On 08/30, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Use `devm_iio_device_register()` to automatically unregister the IIO
> device when the device is detached.
> 
> This removes the manual `iio_device_unregister()` call and makes the
> `iproc_adc_remove()` callback unnecessary.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 11f2bc12c19a..38a153d6fc70 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -570,7 +570,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = iproc_adc_iio_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "iio_device_register failed\n");
Optional change, the last return check can be skipped.
	return devm_iio_device_register(dev, indio_dev);
>  
> @@ -578,13 +578,6 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  
>  }
>  
> -static void iproc_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	iio_device_unregister(indio_dev);
> -}
> -
Now that we won't call platform_get_drvdata() anymore, another thing that can
be removed is platform_set_drvdata(pdev, indio_dev);

With that dropped,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
