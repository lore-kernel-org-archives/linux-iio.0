Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0B2F7EED;
	Sun, 14 Jun 2026 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462127; cv=none; b=XiIlvPoHtCOGn9O3v70Iw0WI6BW9dXaNbi4If91s7tvQx21trT4xVoQNlePzxt/ga8/hQcTgyjPsh4YIZe5OM8GFTE2NTuW/uI0NgHjItuSGnn91uYIGPk77CJIXa/rek1h9vk+6l/6ifofF+4f29v6Pq6whoTlq6Ke5NcLIrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462127; c=relaxed/simple;
	bh=eXWRvoH/1dfflP16b9lBf0KGqx8u56C/LDowBnnDxls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlsSG/QUumTM9Ra8sdS1bq6HJvpWozI2T1N33nDgNQBkrmsw02N3TYrm2hqYRgQ4/L1ItzTHHr5mSSVGdKDgfcgsVL8tfLEkiGPLcZEBmeSitnXGBXHER80hepsUEN18xzAtRU3EKOJWCAorGHyzC55oZ4CI7GAymYCkD+jBBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLDlNYIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLDlNYIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127131F00A3A;
	Sun, 14 Jun 2026 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781462125;
	bh=ZD5leZoS7K+6+GTKTZ9qL//IxoMeGgDbbRuYSbgX/Xo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RLDlNYIUoQrX0ady3MalsKxtPItxKEthiMNSn4LlEZwgmFavudPWIE/SsGlABDJWV
	 e2T2wE9PvujK7XgWsZVopJk0XZXcN2OE2YioPf8VzVYeUQ+WwaTKxwVmfQBAI+1dAx
	 gJdVg4VhwCkwEdbs9ANlrFJokJY7N8RNSSIbskBl9MmPdYM5CJqsP1zRH+Onwb8L1I
	 O4LxQ7+BS5O73YypnjD9og10NMo2bLZ5Rewptm5MttACpAVXMNxXO7pe4oeFSV0xfG
	 +TJQ9z0XHqwwuCp0/G5W4HAIVz8frZSXFoWNwPZrWWidotsfYGYwXhlLXeoPdOz9wY
	 GXuX4EC/i1DNw==
Date: Sun, 14 Jun 2026 19:35:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxwell Doose <m32285159@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
Message-ID: <20260614193518.389a39e9@jic23-huawei>
In-Reply-To: <aiO2_ATPNmjpQErV@ashevche-desk.local>
References: <20260606004203.158853-2-m32285159@gmail.com>
	<aiO2_ATPNmjpQErV@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jun 2026 08:58:20 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Jun 05, 2026 at 07:42:04PM -0500, Maxwell Doose wrote:
> > The current code uses mutex_init() instead of devm_mutex_init(), which
> > is incorrect as the rest of the file uses the devm automatic resource
> > management API. Fix this so that the mutex is set up in the same way as
> > the rest of the device data structure.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> >  	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
> >  	state->command = command;  
> 
> + blank line here.
> 
Tweaked and applied.

> > -	mutex_init(&state->lock);
> > +	ret = devm_mutex_init(dev, &state->lock);
> > +	if (ret)
> > +		return ret;  
> 

