Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168381;
	b=EiP2mnZm9qriCTUyxvzU8ctxlUmkRG6SonyDErCwBmMcZrR70N3lh/qlbFiN//OA8v+f
	 1+LRLfn9uNDe/W3EpKCuH2fuoRzG3ATx/5Kukf00qF5d2cFzkgL9suqwdWTQHy22rWcBk
	 JzvVJULgbDaDOEc7gPKz5ch6RN2LbsbPZuJUbdXAgKRt9zSp6pfEbiILcA6eKr+emPtSg
	 WOzTFDOBgrB5iT88lN9CRuvIbe2Dp2lw30AJ4+fhb/bjwRyfk//sGDpPlAyzaZZj7ZyzE
	 aoK2V7Byswhjml86GpOXg+VAvvafUyZA8mCkNClxWXlNFs6pXnsAQwUkF8tNUuYuJiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168381;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ElN08O5mdbGM1wXhaIJBmb+c9WacDgCN//fZfDxOKow=;
	b=YLdE9eF//6MTEvYYCANfaiDMOFO7PCsPWdaYfXS+K79OoXqdbJoEhZ9cLyW2eDYt/iSw
	 3OnM0vFzMwkxK+NwBNLfCsUZdPMim1QY/ic2T1aFuqsiaJearZVHyShl6It5CdY7Zk2Hv
	 sg/pdMqA/RYVinzLTZw1iCy0yyzWicGExscRrV0nVgOD+hhsa80zsjeX9x4Uw5104tWr9
	 +X1xNTtfkTqAgGirZ+N/DYzC72YFIt9Cmugpedt1UtN3lcjemOZKKRIBkXqSu3zvJrvVt
	 TT2nANBGI14pStnPi81ObZ/uZaVjbVJCilaL+S6NavQ8n8Z30oVU4EZLI5KE1Fo9NdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3ipEhXb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA07606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3ipEhXb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4A1F008A1;
	Sun,  8 Nov 2026 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168381;
	bh=ElN08O5mdbGM1wXhaIJBmb+c9WacDgCN//fZfDxOKow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B3ipEhXbzpGCzf98P0ib9VNnU99/joOM0LG3vUDn0DQqlLd4MTjLC5SR/+7DUaVi6
	 eIn53Jfpl3bGtF1Goi1Z/37J1yNT+E2L0o53RPKPARuBEAOVM4d3f9RrXPx+aCkiJj
	 rqpSux356lINN1VnkkW5+zfzVem9Z2313A1JqcBFivSOg/0dYbnhz7ZXnhyJ8b5bnu
	 bWmhmiMzfGVtp+lUHvXkmTTf7bZleAHCxYoUV2JRgEnyj85qXgnSEULZbcf7n+BXXD
	 y6C1/NETw7bOF1B/KXuRjDq+G9ZZCBdcEt6pEY45QBNqogOHORmgXWPLCMD+s/LGU8
	 YnOaMIrUEaOGQ==
Date: Sun, 8 Nov 2026 20:06:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Piyush Patle <piyushpatle228@gmail.com>
Subject: Re: [PATCH 24/39] iio: adc: hx711: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108200614.44fb3ae6@jic23-hlaptop>
In-Reply-To: <auBh6xwZA4JWyBp5@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-24-8b136778eedf@oss.qualcomm.com>
	<auBh6xwZA4JWyBp5@ashevche-desk.local>
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

On Tue, 27 Oct 2026 10:33:47 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:42PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> > 
> > Move the buffer onto the stack, local to hx711_trigger().  
> 
> ...
> 
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
> > -							pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> > +				    pf->timestamp);  
> 
> One line?
> 

Tweaked and applied.
