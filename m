Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17130B50F;
	Mon, 27 Apr 2026 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284147; cv=none; b=DsiLXL29oNG2q4VSkrSOyJiJ7uym/H+LUTnGYwaGzXPCL+U85rjMAHjaoMou+OQAI5TDXfkgqi5EFfIKhwU0dxlipBXiRN4dAyMzrNHTpSG8AZDqPMtm6MbYVYOfESQBqgTqLtiU1VnHVNKPmFlBlVOGbsXOipkKrdGAPG8jwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284147; c=relaxed/simple;
	bh=4DfioJ/mB1drFxmGI83xMHBZjcdtFiFlpc6xIXaBAco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+V/wWBOa2jTaBxf1LOrnuN/v6lRXGb/VMRqXVeEm7u06xTnze+6N0ytraN5rvC6cMUzpUm+bogHibDUPWO8+EqnC4qzpvu5rRMEZJX3uoOXP97VT4olZPrCgBHFI295wW6u+K8BhtgzF9SWh8HVQ9yLiTltIkXyxv/yZn3lEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYC1DeQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYC1DeQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991D4C19425;
	Mon, 27 Apr 2026 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777284146;
	bh=4DfioJ/mB1drFxmGI83xMHBZjcdtFiFlpc6xIXaBAco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OYC1DeQwIPgyHw/KkayOQHL15EDe95Gcy55heLgDQ60X/CmZT9VHshr7uGBSC+HQx
	 Odgdf5qUCFEMYFoAM/az+4DfLbqO9ACcvpHAGDvrO5hTVHosM55JEYCAvZNcoNQ2vP
	 rUaBgioAGrwn5J0XIVhKc/0jPIvmnPu0FqtUiqcTjpGn8kxhI2fav7jfPDHGsOcBQa
	 Juj/S9Lb8B/y9TcXL1ufbqFSb0oNU8iUy6bdNKSh3nCO/+mEt54XWp7Qw4xHEamZmW
	 hXvut4piynMYxi31opVvMlzMsdRaCHwkwEyoafD7zZS0bT4CIYuNJRVEg4pqOagOL8
	 NO47on161Gwzg==
Date: Mon, 27 Apr 2026 11:02:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: Add error handling to
 adt7316_spi_probe()
Message-ID: <20260427110215.1d3eb495@jic23-huawei>
In-Reply-To: <ae8b6wdyNR-G-i1m@stanley.mountain>
References: <20260426205039.125818-1-m32285159@gmail.com>
	<ae8b6wdyNR-G-i1m@stanley.mountain>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 11:18:51 +0300
Dan Carpenter <error27@gmail.com> wrote:

> On Sun, Apr 26, 2026 at 03:50:38PM -0500, Maxwell Doose wrote:
> > Currently, the return values of the adt7316_spi_write() calls in
> > adt7316_spi_probe() are unchecked. Add error handling to return early
> > and pass on the error code if we receive an error from
> > adt7316_spi_write().
> > 
> > While at it, move all three adt7316_spi_write() calls inside a for loop
> > to condense the logic.
> > 
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---  
> 
> A lot of the time, functions can't fail or if they do it means
> you need to buy a new computer and there is nothing the
> operating system can do to help you.  spi_write() feels like
> one of those things.

We do normally check spi and i2c writes.  Though given spi doesn't
have known markers like I2C does, it's not always clear we can detect
an error.  However, these are 'special' as the comment above makes
clear. Device is in i2c mode and a magic SPI hammering sequence is
used to make it switch. For this sort of stuff all bets are off.
If it were the other way around we'd definitely expect errors from
the i2c transfers - though as mentioned above it is really hard
to tell if SPI failed.

Anyhow as far as I'm concerned adding checks to normal calls is
fine, but not to things around reset, mode switches or power
management unless you can test them.


> 
> Plus we wouldn't add new checks like this unless they had been
> tested.
> 
> regards,
> dan carpenter
> 

