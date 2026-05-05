Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBC43637D;
	Tue,  5 May 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984634; cv=none; b=heppkHyLZwJJHSZjYQtCzkfEX25khU/6JCLLXkL/TnUoZaI1UZ47LlmqSPZOww/qy770dEYHenU2RZ7pd57ZA2uRLr1SvjrgJ5AxHzN+uhQb9166yV9Y8G57bGYZM0dRq9cFIxf7tvFLfAfugryeapNbMQUS+bHXnvQ+DN1qan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984634; c=relaxed/simple;
	bh=1m9avQlsM62D+/5M6xA4b4HibYUZEtJGW857V6lXFhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu4asHa7cmX+vuY9F1gsEiuhv0tww81L+wr6JM0dmRYmIWr3U1+SuigUyGGrKMRN4ZG6v/b8MhinyRTxfI/ipUhyahZHVO/5yghqw2mR/xLwJEnhmjA0aCzbrtmLuKFVwKT/hxam08HfEKepT485YRIJefEwYPHZrFyvNsRySCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyV5Mz9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyV5Mz9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E02C2BCC7;
	Tue,  5 May 2026 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984633;
	bh=1m9avQlsM62D+/5M6xA4b4HibYUZEtJGW857V6lXFhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OyV5Mz9JuFVK7WklEviBgb+BTYFxuIWdzcLkQoO04YD3wsb33m7lP2y48jPvgingY
	 sLj4Bel8u7a0YvYOhLEksuwuC9l3z6xrGjf0tLLQf+67MJT+/8+ViPCBy0gNwm4vKB
	 TkVXWm/zTO6asGJes5c8FkPm3UKS0/WnxWK0Ot+J/87T5bgMLfJ2N2UGJEDs7NG5ME
	 3G7LN/l2M/FlqPvEnYN5zKVZ/Mo0fkHLHC7Gr3zI0GW0yHSoxBOrfYVxS4fpl6Acly
	 S54BcLYIA4T9pmcz8CD3VASpVhxyG4tlrzYRcOxpN/94zj841m8MS7Y3x7aCE07EAn
	 Z37lndPr9dwKw==
Date: Tue, 5 May 2026 13:37:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Peter Rosin <peda@lysator.liu.se>, Peter Rosin <peda@axentia.se>, Linus
 Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Wolfram
 Sang <wsa@kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update mail for Peter Rosin
Message-ID: <20260505133704.45a34756@jic23-huawei>
In-Reply-To: <afjuXkgkhnRX6DDu@ninjato>
References: <7ddc5b09-b6c9-99f9-d951-6b3ef96f8c1f@axentia.se>
	<afhUW7anAEURM0Gz@ninjato>
	<e8f64a4f745ebfac9395906f19d1b586@lysator.liu.se>
	<afjuXkgkhnRX6DDu@ninjato>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 21:07:10 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Hi Peter,
> 
> > Thanks! If anything, I should have more time to spend on the kernel going
> > forward.  
> 
> That would be awesome! Your in-depth knowledge about I2C muxes is much
> appreciated!
> 
> > However, right now it feels like everything is in a state of
> > flux...  
> 
> Good luck!
> 
> > It would be convenient for me if you could take it, thanks!  
> 
> Sure thing. Applied to for-current!
> 
> Happy hacking,
> 
>    Wolfram

I'm late to the game, but want to add my best wishes and
Acked-by: Jonathan Cameron <jic23@kernel.org> # for IIO
