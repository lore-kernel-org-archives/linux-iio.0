Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4DF9E8;
	Sat, 21 Mar 2026 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774126869; cv=none; b=YgeZn8upKh9gIXCicRM6Wdbl1yWM1WqJKzYu/DysBDZ1PY2Jz387MuGE6lL6NrU00XUH0PlfHqytZlpt/odSxfpvHbIM1PsOTJnxRbqwWbViPkd0q1T4xq4tiYld9Hup1lv5ssRnEWsVehPmXu5ZQ+qnoGu18mvZ/i0Bf00Kyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774126869; c=relaxed/simple;
	bh=kAeTQtLNT2GbrzxH5L4iT3dqYsDVuy8utf+BJNRxlpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2ekWW/tEsvlGv7sS+b8GkW9kCOUmJbuQmEcJTEmUDrgG/8j5YHpr5Bpiv7oXlwbG8iXBr8IgaR7EBlwy9bZB0oEQBpri8XjuInLtz+t2NL+jnjZQnwt5gRvMta/aS0OOMA1xKBF3TeQ95kT0up9EaWy9YLtlP1VfPxaTpUgBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsYTxl7V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsYTxl7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D333C19421;
	Sat, 21 Mar 2026 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774126869;
	bh=kAeTQtLNT2GbrzxH5L4iT3dqYsDVuy8utf+BJNRxlpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WsYTxl7Vc0oOdcZ8y93ueRgTO7yzVKe3IUxyrWTcU8pypU3pIdlhZjMEiymMr04ji
	 fJSLgRpMG5uBqPyW5ESt7Ank0gpA3uVn0uhmYaq5xBvMvb6jpgFfQ+nt96sElASAwp
	 f2bIDFkOwE5n/2giqJpmtbwFewJWFH3boSmSFQpwhQr7Oyklf1WIzzpWOA9OeT4Kz0
	 85n0hcfNKQWFNlYPnXPuspL+wjgEAiI9EPe9HYyqgdJ8q6ibN0xFMh+gkwsY8/c31/
	 06wUM0Q9NOksOZ/FJWRfpSo/W9RqONwlpXu1JdtxgL6sRzLFjW+yvtmeqXKwIWhhkT
	 EgYdBkvKD+W3A==
Date: Sat, 21 Mar 2026 21:01:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Parthiban
 Nallathambi <pn@denx.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4035: fix scan buffer on big-endian
Message-ID: <20260321210100.78ca299c@jic23-huawei>
In-Reply-To: <b8ed1390-7bd5-4f6f-8975-5aceb72cde0b@baylibre.com>
References: <20260314-iio-light-vcnl4035c-clean-up-scan-buf-v1-1-400d273eb026@baylibre.com>
	<abfYN9gszSSb83J9@ashevche-desk.local>
	<b8ed1390-7bd5-4f6f-8975-5aceb72cde0b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 09:37:53 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/16/26 5:15 AM, Andy Shevchenko wrote:
> > On Sat, Mar 14, 2026 at 05:18:10PM -0500, David Lechner wrote:  
> >> Rework vcnl4035_trigger_consumer_handler() so that we are not passing
> >> what should be a u16 value as an int * to regmap_read(). This won't
> >> work on bit endian systems.
> >>
> >> Instead, add a new unsigned int variable to pass to regmap_read(). Then
> >> copy that value into the buffer struct.
> >>
> >> The buffer array is replaced with a struct since there is only one value
> >> being read. This allows us to use the correct u16 data type and has a
> >> side-effect of simplifying the alignment specification.
> >>
> >> Also fix the endianness of the scan format from little-endian to CPU
> >> endianness. Since we are using regmap to read the value, it will be
> >> CPU-endian.  
> > 
> > ...
> >   
> >> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> >> -					iio_get_time_ns(indio_dev));
> >> +
> >> +	buffer.als_data = val;
> >> +	iio_push_to_buffers_with_timestamp(indio_dev, &buffer,
> >> +					   iio_get_time_ns(indio_dev));  
> > 
> > Do you have plans to drop this old API as well?
> >   
> 
> Eventually, yes. My plan is to wait for fixes to go through first.

Agreed. Given the need for backports, better to do it in two steps.
Sooner or later we'll end up backporting the new _ts() variant
(if it hasn't already happened!) but lets not rush it.

Applied and marked for stable
Thanks,

Jonathan

