Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449087;
	b=nYL0Olmlwj6JfDztgwZts7hZ8x5D3pMk+17hG/+cBclECAzLb6888w7gqzQyLyOjcyv2
	 2HmWmudAKFTytaajrydsGJ+UenMv4C2SR7p6+9ZVTUExonNDas6ApEdFc6012unfrcg94
	 dfHyKfLQG00+vh+EeLdiaQ5Dujpm4rBJstikfZ2mJQ0u6/geuxm1KTnv2jK2UfX9ExHPG
	 80MqaCPUcs8EVFgipfu+xBsl5f+zQs3Irev+WslgtvdDMxvUk5loUwul02RoS9FnAMqMQ
	 tRUkxozpIMY5lZDmHud17y38t8+eB9yyGyboGSFVkCJTGAMDIJHEsDpv3Pl9HY15dWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449087;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SlrT5FMkoprSdPGG77EqIOzZqXql0Ov4MKTjkyte/Ss=;
	b=Bbn04wD4p+8cOHd7Oj5KEqdJYKTGwOFZ7rVn91zPU9GsBTDXi+47FwOa3sxmYtmjShjy
	 Uk9CrMVgtVJ2r8mXsss+fbjfH8QZ2U+RDRkarntMNm9gM4LAl1b/DoMFM6hZ1kr/pUYJp
	 C+7mx5j+/vptsHLRL/mLbIjY2bw25JRAqp8Rt4Sr2lQKP1cFwr6CgRXKAq9JAD3I131+E
	 BIpOXlqbScFdla3/qksgtwV5svGA+zJcDh1BhzI3R0F5Ndq/EFjWlGbG6cgjmtVPDaZDh
	 Xo/qE8x/xfnc9CeyXnlu3EHKBX0EFIlEVhTKf0ggzmSA+e6CE5+qePJQadNf4/jUtbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLhzPzQY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F36606A31C;
	Thu, 12 Nov 2026 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLhzPzQY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509E91F00A05;
	Thu, 12 Nov 2026 02:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449087;
	bh=SlrT5FMkoprSdPGG77EqIOzZqXql0Ov4MKTjkyte/Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TLhzPzQYivj9D+1Mpdm76pfOciiUhGkHSAN7OPihm8tRsqyLtVzJKIg9rRxjx7TRD
	 C/z0q2JhKwbZON7YsFshnEKseqG4Xr1vFiZDeGgHsGmrPv8rSVka6zMqFxFJOn2dGa
	 qAyKi0o+fHaffVcqdQFfNQKrUbmNUoKnhyxoXVzW4OVEGN6PWPvrBdI4XaYc1FzNOa
	 c/hup6oQhuEw4ItracQHkJb5y5OFQ3+9Xq3jVV73FVFQSCqIFMXxA7a/Z0lGshGYBH
	 MMkqxf8vcIvegHaz/8e5+PgbhPL/wd09eQ7uOyZk2wdX8TOzTLGmyooRE2ZSmIAM6o
	 cnk2coplo/OaQ==
Date: Thu, 12 Nov 2026 02:04:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Di Wu <diwux@google.com>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, bleung@chromium.org, groeck@chromium.org,
 tzungbi@kernel.org, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <20261112020439.37b0da70@jic23-hlaptop>
In-Reply-To: <avR-KT-6e77EexZn@ashevche-desk.local>
References: <20261111072608.3490763-1-diwux@google.com>
	<avR-KT-6e77EexZn@ashevche-desk.local>
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

On Wed, 11 Nov 2026 16:39:37 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Nov 11, 2026 at 07:26:08AM +0000, Di Wu wrote:
> > Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> > and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> > PAGE_SIZE limit and is the preferred helper for show callbacks.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> > -	return sprintf(buf, "%d.%06u\n",
> > -		       latency / 1000,
> > -		       (latency % 1000) * 1000);
> > +	return sysfs_emit(buf, "%d.%06u\n",
> > +			  latency / 1000,
> > +			  (latency % 1000) * 1000);  
> 
> As David said, since you touched these lines, make the less amount of them
> while at it.
> 
> (But no need to resend, usually Jonathan is kind to tweak this small thing.)
> 
Done and applied.

