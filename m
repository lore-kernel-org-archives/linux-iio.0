Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579286;
	b=uQ1HRFuQ+B7qv3Iviizdjp8Y8G6rJpFY5QL40aPKU6gFjvc0N0kXo/qqlT6P/ApWA0w/
	 Aq5ucalcMQf8hZB7xWi/6ZJGw37MzuynumiemKaHKQbygRHoYq0xt1qTaADn7ljR0M3Jp
	 /J4BhnRD1+z0UnZFnAE/dmTECE2+8F18DfDaMuPbKqZ6jNlUITzKhCbX6vMiEv+799Jkx
	 FFiSfS2kMnhr1y1aeZ7mQXKjHnk2ADZVCWRkTY/V9HWtLIfeujKTbxAJKHVg1CwjSWsp+
	 4YNZPJJ1dRkVGlw50Ln15xTR5DwuR8qjdw2wPQ4YZUzeJdspR54YtEPtdkEYkpQtKyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579286;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bdwDl6M8HEFuMP6JuRDefHyTG2RwyEVFFLdnE2+FDnQ=;
	b=kODjlvVHXfcBsx9B07wMu0iZ0JGnIO21kFBNYRv7dAyloTHDogcMlAJsxk3yOp7SQ+B4
	 OjOOgZyb9zp9xyH3+8X1AaQwyAY8SCUQHL/tWyhWtEGXfSWxkK2tMxiT0LpZB17KYiwTm
	 nFiIyzFfdO1sS8QWVNRW9nKs2f4yl0YAwFIM4ni66vnBXaWW/o4jxBlFYkmgyg4TJhHTL
	 RmRxK36XHrlepgEh0mOPRPWJPm+Jw0ozcbZpt1gZU1oRWEGhggQ9u+5Vi3SnrWrGdiHBr
	 QlG6CpLpk61TqfIjLmP1wCn8hbcDo0XkCVSeg+eV134/NhW7ZUZQ3WvLmQDZ6S85yng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWzPIUWz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EE606A324;
	Mon,  2 Nov 2026 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWzPIUWz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419291F000C1;
	Mon,  2 Nov 2026 00:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793579285;
	bh=bdwDl6M8HEFuMP6JuRDefHyTG2RwyEVFFLdnE2+FDnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VWzPIUWz3S7oErit9QLDUxRjgiGZuxXVo/8r0OlX6RZz7RnFapcebksP/Xs+J7Xpb
	 lsZXSfMFP/mT2wqMZNmUAYe4kGp8I6UPkzsAKn5nEUuVSCaB8NrP0h+StZqjVz6uiY
	 H+g6BZ5579A7/mmLhQw8jAqKeHwqG36WF3lrhoMjWTQEAFGtq0ebbCV2X7ULI4bLKS
	 m1TYv8TQirHQPbdcBO27VNGE3+NGg4x0tAUNL7fAVIFEuj0LsJ9Q+BppxjP3DJBUSi
	 wgAWjRNasMhF+MjEwO3fHaXgN25tYtkpYrk5Y+j2ctSwvXHzUa9eHWgsl6Y0y80i9A
	 tB2i0bkXbDVtg==
Date: Mon, 2 Nov 2026 00:27:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 00/16] iio: adc: ad4134: Enable greater sample rate
 data capture
Message-ID: <20261102002759.7be64317@jic23-hlaptop>
In-Reply-To: <20261024025421.5c612c54@jic23-hlaptop>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
	<20261024025421.5c612c54@jic23-hlaptop>
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

On Sat, 24 Oct 2026 02:54:21 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 23 Oct 2026 19:32:58 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Extend AD4134 support to enable greater sample rate data capture. To achieve
> > that, provide control of digital filter type selection. The default filter
> > type on device power up only supports sample rates up to 374 kSPS. In addition
> > to that, enable interfacing with AD4134 in SPI 4-wire mode that can support
> > reading ADC sample data through multiple wires. Finally, use SPI offloading
> > to speed up data transfers at up to 1.49 MSPS.
> >   
> 
> Hi Marcelo,
> 
> Series looks fine to me. I'll not pick it up just yet though
> as want to give some time for others to take a look.

Applied. Still a narrow window for last minute feedback if
anyone is looking at this given I need to rebase on rc1 anyway
and then let 0-day have a few days of fun with it.

thanks,

Jonathan

> 
> Thanks
> 
> Jonathan
> 

