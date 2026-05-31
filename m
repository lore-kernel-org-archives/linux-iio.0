Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525223D3B3;
	Sun, 31 May 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780217557; cv=none; b=pykQUShgkjXHKqKVHh9jyKn6LPG0Ib5IZi7VL/j+FTaKPkUbuvpx2jZgDc3eXAAma9nAyyZQsN0FJuAJhYN3uvzA7ohrhzSBqxuhyWdWCfYV4I2tp3XSdIudldo3x6tbCWY/PWmbPqYGrSbh8RmQULP9baVJnFyIwW8bs6UWmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780217557; c=relaxed/simple;
	bh=zisDtHJieZcM7TvC33PAUVwyeP4z17mLfsCKkzyYrUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7L7+YMM+oL/VV56qvKr+prAIwC/s8Um+f89/ldZed3HwmHBEyMYAFKdche5iePlYfq/u32XPcl//3EJifHHhdNc2Oa5B856EuPCcsvIntuhdHOO9oczldQj18TZPqoFItgYJFlrUbv18U4yjx9NUYwOt0WxYgFMfcY4204yixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJM/FXJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJM/FXJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502A51F00893;
	Sun, 31 May 2026 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780217555;
	bh=7f0jp7iLcco0AP5WwlC88s6BQ+0quj+EJAj5G4g39+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gJM/FXJs6AO76GgAKmv7JcadVRLsILcb3UoDG2Df4Zjrlxs+G0unDPBfvMgOW+fSq
	 mXKEdP3e8EvkcWWmlt9c+Plq4FdUkXFQ1C2siJaxWD7xB3ukFf7rRFfIfU8eWAlyv9
	 vPQpCFbGQoRuUVfixtNaK5W+GuOSwvSfFKDfhzMz9tZcYTiN17uVl8kIpm4lAyI3j4
	 qD8/4n/vjDPhLZcikbbazhoGbt3BOtAn7aTzUzmeDl9D4VpEwkF/VUJxSVvX0aXUpY
	 qYnlsrMx49F4jGyDQl52o1S+sbHqVRUUncJa3h/z/sr19OCA0DcWqv7biqvGaaGD/R
	 FbVfveT3vC1Xw==
Date: Sun, 31 May 2026 09:52:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Rodrigo Alencar
 <455.rodrigo.alencar@gmail.com>, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260531095228.66cc9045@jic23-huawei>
In-Reply-To: <driver-reply-1780172596743720241-wafgo01@gmail.com>
References: <20260527184257.141635-1-wafgo01@gmail.com>
	<20260527184257.141635-4-wafgo01@gmail.com>
	<20260528122244.2e408dd3@jic23-huawei>
	<driver-reply-1780172596743720241-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 
> Will go through the includes and add the missing ones for what is
> used directly.

General hint on process.  Don't bother saying yes.  Just delete
those bits when replying so we can focus on the more interesting
stuff: questions etc.

>
> > More than likely we need some level of sleep here for the device to
> > wake up. Is there anything in the datasheet?  
> 
> Yes, tPU = 25 ms max (time to sensor ready). Will add
> fsleep(25000) after the regulator enable. Also tw = 60 ms typ
> (warm-up until output within spec), so will bump the existing
> SLF3S_MEAS_START_DELAY_US from 12 ms to 60 ms.

> > Sashiko (probably correctly) identifies that the formatting that the
> > IIO core does for an IIO_VAL_FRACTIONAL only goes to 9 decimal places.
> > [...] maybe switch to using IIO_VAL_DECIMAL64_PICO
> > +CC Rodrigo  
> 
> Confirmed, the SLF3S-0600F scale (~1.67e-9 l/s/LSB) gets
> truncated to 1 digit, the 1300F loses some precision too.
> 
> I would prefer waiting for Rodrigo's IIO_VAL_DECIMAL64_PICO over
> bumping the FRACTIONAL formatter, since pico covers all variants
> and avoids changing core behaviour for everyone. Plan would be
> to send v3 with all other points addressed and respin to v4 once
> PICO is in mainline. Ok with you, or would you rather see the
> FRACTIONAL bump now?

PICO path seems the easier one, base on top of Rodrigo's series
and add a note about the dependency.  I have no idea what
Sashiko will do with a list of dependent patches, so we may
get some spurious suggestions that the code won't build etc
like we currently get for scan_type.format


Jonathan


> 
> Thanks again,
> Wadim

