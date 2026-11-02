Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578813;
	b=nFQ+kVdMcoHbO64xAFDy8qD7iqG59QNpNbQ01tAc3rdKOcqJAiBW5p+TTnfXYHLsB87w
	 18BxVINhrEsPHl5S1b/McTt9UvFdNSH+tkDe7c6rieimaQX36Hm4OrvN81y7UrMwvS3ne
	 3OfjBMD7RmGzA0tqKre5BJ87Q5botbQelbiB+os4IQXMDq/f/HblqnpzTTttdBJsAPWJO
	 wBnxPZ6gQWUg/+0/zutIsc3Zkwo3YsNXGwOvdiXuxbUhq8CHkTeVo6dxzMzyruhhPvIgw
	 MAcn5E89B+bC7blfljR/uvBHYm2WJqbCg8UqqLDeJwJgcs9/Ev6Qpt+iirU+YqSIWxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578813;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WeC6wpdmBLhqUm4VP7fWRjGNXcGGWiVZ7Y9h/7puDc4=;
	b=dCo9NKFqRF4+wq1tCBJNVrgk0Tn/RTeQFU+e8a4twftZlb/cECIznRy2jxQ+y4tUU/8C
	 KuGj1p+IjJ+HoTZ6xOIw+L8uR3MtTqCNjzPp4meGFf83EBZfQCydCmAYS6YS+ZlmdE0CJ
	 3JXB0NttxLMMVJL1niPXH47Vo27rcVCayzhm3MhlFo8slrPx/FhSXel6TZTW5R27DUzD9
	 lNXC/dOMAfBH+IHeh2WChJyeEqBjEZjb8AWmBvel0MbcVvh83PDIyANMP+PvcReA7fACQ
	 TxxglDMeVHEP6xrPq6o+kfX09+6nwa4mKa/LZ1HvQzOiCqrKhqq1VWun4xaMsFPqb0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqjUclKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F24606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqjUclKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C3D1F000C1;
	Mon,  2 Nov 2026 00:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793578813;
	bh=WeC6wpdmBLhqUm4VP7fWRjGNXcGGWiVZ7Y9h/7puDc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XqjUclKImbyqylyMDEchcVJfyxg+fAlpVtuGmV7ZO6V8OH+Rf97ASm5Z7xkcp32Vj
	 OaCe9nYOTn8G4Yv4Xl8ex4pnUE9zzBwSSfE1wJHSlB3yDsLgXBT6aX3V13jZ4xVhdR
	 Gq0Vl2gnmtx7KZWAV6ou9XyKfPSL7KFl2WmCJylPmBJA/D5UkJGIGOVzx39vw9B8tb
	 9IJiFJ9MOy9TL7mtRlpSUmqsZ2F7orBS9IqCf8WI2Pat1lg7A67WCDJKAZXhBgfSHq
	 EL4ol5FGfBqcjxxXXi39zIxqiIicJGc9MISj4dj4rvFhgqmVEJ2CxrJtQgJeCwC1oX
	 m+72WyOk5cpjg==
Date: Mon, 2 Nov 2026 00:20:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Brian Norris <briannorris@chromium.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH] iio: light: pa12203001: Use guard() to simplify lock
 handling.
Message-ID: <20261102002006.69e28c76@jic23-hlaptop>
In-Reply-To: <at8Y-5Cw6KpIoAHy@ashevche-desk.local>
References: <20261026010803.973666-1-jic23@kernel.org>
	<at8Y-5Cw6KpIoAHy@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 11:10:19 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 01:08:03AM +0000, Jonathan Cameron wrote:
> 
> > It became apparent in reviewing [1] that the use of guard() would
> > remove some ugly error paths.  
> 
> ...
> 
> >  	if (mask & PA12203001_ALS_EN_MASK) {
> > -		mutex_lock(&data->lock);
> > +		guard(mutex)(&data->lock);  
> 
> + Blank line. Let's make guard()() to be standalone to increase the chances
> to catch it on a glance.
> 
> Ditto for all similar cases.
Tweaked and applied

> 
> >  		if (data->px_enabled) {
> >  			ret = pa12203001_als_enable(data,
> >  						    PA12203001_ALS_EN_MASK);
> >  			if (ret < 0)
> > -				goto err;
> > +				return ret;
> >  		} else {
> >  			data->als_needs_enable = true;
> >  		}
> > -		mutex_unlock(&data->lock);
> >  	}  
> 

