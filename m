Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62C63CB;
	Sat, 26 Sep 2026 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383794; cv=none; b=VIpDkULir4/7Id1JT6NdtssUHMqjn86kxmMjXjb4cPtpENsDdaVS+E3r2lRZxIzwhfDWQnVQ36uXXVjhzvi6PB6n/JgLxRG8uZdgjIuc7ia8UYK18Gbfnwnf4VG0SZNNwoGweejWPGxNlPfxvpKOoQfsI8cxXQronTQV2BjeY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383794; c=relaxed/simple;
	bh=FF3ahQZYIkGr3GugY9kBYnQfvecJ1k6fKmHgHBWzzvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRIpDouCzGuA8tCHmAC4cqgt9S29aFUOT30bZjE6l9Q+PDQ1ko2CluCJ95/4agd3V9+i3NZ+qTyAbBLB4ddcrxLG9Fnlnb8s1rQFsFW/pfavshqCs1XEEcQpBGChD3LAXRyI7CYoyJed11WbR/0wupEbDyPtcCv+UH8BJcoebRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYqdXeGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYqdXeGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2441F000FF;
	Sat, 26 Sep 2026 00:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383793;
	bh=EZbnDljGQjAjqoG8QowbcPEN/0Wwm33hrwvbtHHIKbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GYqdXeGErjt6hw+wda2Smic+f0G7QaeXnQU0FJUiIArMfOhgYCWY//9/wRIFPwFTX
	 5IoBSm7AVpl7Rss46PD6B2kKHtpKvVfVCbqTyYn4ElZZZX4H7qD01E1r0OXv+TKS2R
	 l0f6wYTnzKyhN4RNIh7DY/osE5sg2mxyHW8MvvV7ZF6UzZq2M1qJb9UCUGtPqpqrpq
	 KCTX1ljEAsBFkGTOJIOB+rm2S4xPAvR/Bx/uuuOtZ82wNzu8z3AUsnwiEgR7MyhDdP
	 tPyqdWFQmf35bSTugiUH+5+xSE6JawjjcdIX0ueKz75uyibgQQYTNFN1YDj1BPK/Gu
	 eQn8QzMFDT/Jw==
Date: Sat, 26 Sep 2026 01:49:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "jiale yao" <19888972804@163.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Matti Vaittinen" <mazziesaccount@gmail.com>,
 "Danilo Krummrich" <dakr@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: reject duplicate event disable
Message-ID: <20260926014942.0af1a16e@jic23-hlaptop>
In-Reply-To: <21e57d3a.1d0c.1a0d9008daa.Coremail.19888972804@163.com>
References: <20260925140945.2254656-1-yaojiale02@163.com>
	<araCbz928KEnAamY@ashevche-desk.local>
	<21e57d3a.1d0c.1a0d9008daa.Coremail.19888972804@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 22:38:07 +0800 (CST)
"jiale yao" <19888972804@163.com> wrote:

> At 2026-09-25 22:17:19, "Andy Shevchenko" <andriy.shevchenko@intel.com> wrote:
> >On Fri, Sep 25, 2026 at 10:09:43PM +0800, Jiale Yao wrote:  
> >> The IIO core does not filter duplicate writes to the event enable
> >> attribute. kxcjk1013_write_event_config() already ignores repeated
> >> enable requests, but a repeated disable request still calls
> >> kxcjk1013_set_power_state(data, false), dropping a runtime PM reference
> >> that was not acquired for this request. This can underflow the runtime
> >> PM usage count and trigger a "Runtime PM usage count underflow" warning.
> >> 
> >> Return early when the requested state already matches ev_enable_state.  
> >
> >Sounds like a bug that needs to be fixed and hence Fixes tag to be applied.  
> Sure, I'll add the Fixes tag in v2, 24h later,  for any other comments before sending it.
For a simple request for a fixes tag, I'm also fine with you just
replying with that tag.  b4 will pick it up (though technically in the
wrong place so I'll massage things whilst applying)

Fix looks good to me.

Jonathan

> >
> >-- 
> >With Best Regards,
> >Andy Shevchenko
> >  

