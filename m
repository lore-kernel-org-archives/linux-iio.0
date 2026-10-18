Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74F3B19A5;
	Sun, 18 Oct 2026 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347276; cv=none; b=BnHMyjdXdNYQnS+2pB2CVcEsb/WTEggDoLaivQ8P20rry67cA/VB5DWhxw+508ufp8r2qBY9ckhy8iwjsfKVc/mvXkLY2DZwqduVtcJANgpsONhX7W+l3ObQC0uWTkcd5QjSq0hYNNMuWN+yDrW/6MrlQCt+xlHnUqEYaDkFZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347276; c=relaxed/simple;
	bh=KF/VQgaar30O52tFsSjFuXLxwlJoiUWlUO+2NCWJRuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUBIUquANL7lZMg7ePbhodXxf2r6aj6JwW2D83xiKwTZfAIAao9ConuWuPeqCh96Mk2eZBtGv2deSlq9eaBW7d34GGqNMvNcmo+hp4t73KdHcgCdgRHQY4qyy+/qX2qpcYFBWB4lDuorzyI2+1QXHegtmorGoKFezONJ4/fHtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYp3StpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYp3StpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055A41F000C4;
	Sun, 18 Oct 2026 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792347275;
	bh=aDGFGwHybP+Q9hzeD6xKra5jBGeeFJhjxze9rud2iHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dYp3StpR6vL7wc7CkoJ5CHRHYv2EDFji5q59oztMsGL9JhZopjjIUwEY/cdCOZHs9
	 Kg/vIX+/ZVul0z7IbVVJrBEAohh6LwyrBESn00cJANZqK6RrUZN6H8VQ5FmcVqEHdq
	 yppc0LZ6YJs2n4upc2LUmtVsx18FH0Xc3+HFcmK6jMW8CKcd/ATS1xVTomXTGM/tvO
	 UmJvWGxcVk7THGqzcM3bubyG1uXfj3b+0VkWpHKF8TdDGR9ZZonbyiITCWkwqC5dp7
	 59n7FvCFZZqkscYKsAa81Jj+Uog3qpHUcvuJMLgZRc9qHZ26c4ve1pLtYpSsJDX1sC
	 mb7DaYCWMsopQ==
Date: Sun, 18 Oct 2026 19:14:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux@analog.com, linux-kernel@vger.kernel.org,
 jan.sun97@gmail.com
Subject: Re: [PATCH] iio: dac: ad5529r: Clean up definitions and regmap
 configuration
Message-ID: <20261018191430.5568339a@jic23-hlaptop>
In-Reply-To: <as1O24cxJRhcSmPO@ashevche-desk.local>
References: <20261008-ad5529r-review-followup-v1-1-84a98e0e27eb@analog.com>
	<as1O24cxJRhcSmPO@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 00:19:23 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Oct 08, 2026 at 11:19:15AM +0200, Janani Sunil wrote:
> > Use fixed width register literals matching the device's register address
> > width. Rely on SPI regmap's default read flag instead of specifying the
> > same value explicitly, and remove parentheses around the channel
> > initializer.  
> 
> It sounds like a three patches, but I don't care much (up to Jonathan)
Agreed but meh, too many patches to review to want to see this again
split up!

So applied as is.  Next time Janani, please break up unrelated changes
into individual patches.

Jonathan
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

