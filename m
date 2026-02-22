Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81135B641
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796364; cv=none; b=ZpZVWsVYQPQECW43UrCvyCE3GlqAY1DZUwGpRq+H60Xw8cy7qlK/qNWcdegSO6U27EHb/hVsTy8OeEphj4FCB11NW2ab9svUXvbnwZRs64pzKo1H2j4LQrKTn0REUxmDGWoZLKRpyhNGpScGXTpHe9Z0I3dJvyL9ZGCfyMKR3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796364; c=relaxed/simple;
	bh=HzrKTPvXlTJ+y/nQ94Q31CSXj4sSzxZ6mrkMBtYDf+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eap3UXFYJeTkJdu6lpZBGjt9Anvmle2eMcxC2nPCfp4qyvZ7z6JKUntYEpmy8wAzuBo04LrsM/PT26Pmsh2RF1SVUOMSsbndQQZeTFB8IruJcFbMgykSd/H6DhTE+nCDs/C+iSwR7HntKe4GN3UKgn3PpDPeLPbV0qLFS2G27gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn1tevL3; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn1tevL3"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso3950088c88.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771796361; x=1772401161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+Ki2+Wg/SQ/F2z698NW70nywxyMc5k+gAsNO7ctLsc=;
        b=Yn1tevL3/wwuJVuLOU8KBiAHXeacUF1Pa3/X6DooDGcqPDV+zOWho+JvRKNFrt5Vu9
         WeP/edmf9Ln66n/0N1PpE5cMrqp2M8/BLCwgZBgAde9OqVi7MRSlNpw5ekyeZi+5yBvx
         3MF+gAYrXAkNu8LuSWf4Lem6jbtzQWO3kOBP+jTdf2jQE2Xi4Ts2acLKkjN9+WJkbwm0
         9ZMEVUNgPEmOUiOMl0exU5liEQIW400ML9z0mGIJCEdUzAoAoCJHUzS+RFDeQbIAgH8F
         Zlr9pAYfqgtOwi3SNK6DbwBY4jI/x9BFxQtBEV5a5oRqDMUkxjctH/QG2f0e+ke3DkdE
         821Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771796361; x=1772401161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+Ki2+Wg/SQ/F2z698NW70nywxyMc5k+gAsNO7ctLsc=;
        b=IFpamH41kZEdzrl5Cn2RZTt5AZVi7X5t6WYsqVk4YXoDb2RvV+gDhdsyLd5WvAluvt
         bDeyE0MHcfBwzOsVIZ+9Q4rpu0sXwoI6YZAxk3XxkHfQAmCDMHCzPZprVmPYIv3+b1zO
         r0uuhTPMAHRXQiqByGnFyiihXqcaUkfEhGImgKv0ubzHrtiUvMYNGeXpVHs9OegCYTi4
         1aPX64yRG0DV7O6PKU5KwJCJWH3QMP1/ackfANYmSR2fyUEq0ipFRhZVcUkAw/K5FqUc
         f5EBIE0aL3W3t6Zz+1RSm+hUTlCluXO265NHAIDdFRECvMLyG5sExrJ2lO0C3kqQR21Y
         vNog==
X-Forwarded-Encrypted: i=1; AJvYcCUoqCfJd2NXAuo+8XYLcBMW+2tstkVCc4AMMfAH1npccsbpZvF5mQXR46IT2pdjUxu7la6WB1dPLWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfmqnF5541sbP+9QE+dpOjf7PC+4zas1K7Q/x2DXXvGcPWbl8
	ADVdvQo6+7Yfiwc3qpX+wQ2DyJfO6xRVb5/dgsDfuOEl77+39P48KnnxzsrBrw==
X-Gm-Gg: AZuq6aIJB0/6Fb0Ghrn9Nv5LoIclt2LMMdy3+zv0ssWoxV9BZGFN8Q/dPAgLs6731Pt
	31XhbKSrRHU8Z9Keo8bxmZki/pYIrX6cyxqDnUSrPTYy8ldg4kGSbyr5MWDGigeXaRV7YDLApaZ
	EQZde1+43o1FJpJ0T5i+EsdqjzV9sV3ucuTTsdcUKOs2+I1ofXtNXAx0I8Ga76ir3Y5dw9EKSH6
	sJlTppsjG0YpMSvhYIQ5eIXDJwgiwGDG7zNmXXEnnm7JH36uwNWAsGiKFyAJUw0PnmGgf3HlamJ
	A2G6evaxOGTNra5esapxflWdzemrG19Sc+6aU9RsBJb4NcBHNSeAqNIs2JXZWp2UMGjKdWQbz7j
	nno4favWAiNCrebK6m3HjAe6yXoYwWECRo9gvFLoXSZ6jdsxxQajGlJlwVJ9kn6WDsAq5DherCj
	N8DgOf2DMxk+0Ru259Q4nSwKU/WgJQbGocsmErCXD3gss3VfK3jLqD6SI7mxT8sjs=
X-Received: by 2002:a05:7022:608e:b0:11a:61df:252a with SMTP id a92af1059eb24-1276acda11dmr3017797c88.6.1771796360879;
        Sun, 22 Feb 2026 13:39:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8c936sm6588341c88.14.2026.02.22.13.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 13:39:20 -0800 (PST)
Date: Sun, 22 Feb 2026 13:39:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: adc: ti-ads7950: complete conversion to
 using managed resources
Message-ID: <aZt3FRfuZEWrvQsO@google.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-5-dmitry.torokhov@gmail.com>
 <20260222140923.10bd9b7a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222140923.10bd9b7a@jic23-huawei>

On Sun, Feb 22, 2026 at 02:09:23PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Feb 2026 18:29:28 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > All resources that the driver needs have managed API now. Switch to
> > using them to make code clearer and drop ti_ads7950_remove().
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Hi Dmitry
> 
> One additional comment from me.
> 
> >  static int ti_ads7950_probe(struct spi_device *spi)
> >  {
> 
> >  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > @@ -598,36 +605,36 @@ static int ti_ads7950_probe(struct spi_device *spi)
> >  	mutex_init(&st->slock);
> >  
> >  	st->reg = devm_regulator_get(&spi->dev, "vref");
> > -	if (IS_ERR(st->reg)) {
> > -		ret = dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> > +	error = PTR_ERR_OR_ZERO(st->reg);
> 
> To me this reads worse than original IS_ERR() / PTR_ERR() pair.

OK, I'll keep that in mind. It is no longer there anyways after
converting to devm_regulator_get_enable_read_voltage() that David
suggested.

Thanks.

-- 
Dmitry
