Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83428C2DD;
	Mon, 26 Jan 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440166; cv=none; b=Cb7V4OLjwkGwWkAEvnT1uqYNfsdcz0bHazSCYW7R6nEzwfV2wccKBljG1p1Pmy0kdXAAHKz62onZuq2iF6RTmns8bxtP2/BeY89arpGXzp9H7iikJXoY1CuL4QIM0NqoDdUxu96KEelrNGiRPacwhCDdssckhjRTRVYQZUUOswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440166; c=relaxed/simple;
	bh=GL/41d+sX+Ag4L89kaXNkvo+lHC56R6P1lh/y6Cfaw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtatAquLs+xvkVhPf1VNXbt3avL1si40ON5vZoSzYnHtb3VcxCpHf48AkVF9B3H1UqUF4tu9zPETje00s53syjotQKFH96PqENTa8wQ2vCw3PnIGYBcbXkwhm0Yv/SFAFzVHkpgfD8I+G1+YRobC+EqYlGJejrkdRCN0IgEKus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8mMM6uG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8mMM6uG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06258C16AAE;
	Mon, 26 Jan 2026 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769440166;
	bh=GL/41d+sX+Ag4L89kaXNkvo+lHC56R6P1lh/y6Cfaw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8mMM6uGxdPHJjX+S9mW8QMc461uedm5I+4cZcqiZ/iJZ+wbuD1WKbSHyjgAkd7FT
	 xREd+kkRhRmrgLhaK9NJp4u6/CzFjGrBoCr86f4IgOkg8yBufBoJhoMhgK52IGwOZX
	 h0epjAqielf2beq4Vwx8GWLNPZgp4PnNEdkx8puvRpYYYKt9JKpY8CbbHOH6XUN8hP
	 fKDLmuWY8Ph5mlL9wtf23SywMzhRgePIy+bA/kmql5cgZMt+IgX1n+WnpDNeJhVeP5
	 kyFu7yqokgczEyLT8AKy+ZAOKFa8sBIa1yL/Bp29399aJ+UI7PmccsTGZOMGldf7pe
	 kH7tsbnkSCqcQ==
Date: Mon, 26 Jan 2026 10:09:25 -0500
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, tools@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Thomas Gleixner <tglx@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Kent Gustavsson <kent@minoris.se>, Gustavo Silva <gustavograzs@gmail.com>, 
	Nishant Malpani <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <20260126-delectable-utopian-oriole-5418c6@lemur>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
 <20260126081510.jr8Rp6R7@linutronix.de>
 <aXc5Efu-PlLNCxkk@smile.fi.intel.com>
 <20260126101034.lnGGQmUD@linutronix.de>
 <aXdJbidb3DPyRaxB@smile.fi.intel.com>
 <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
 <aXeA1AIcOx7yUNaz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXeA1AIcOx7yUNaz@smile.fi.intel.com>

On Mon, Jan 26, 2026 at 04:57:24PM +0200, Andy Shevchenko wrote:
> What I have i mind is rather the scenario when I see already sent (by somebody
> else) patch in the mailing list and I want develop a followup with the same
> To/Cc list. So I want `b4 ... --use/restore-to-cc-from-the-mailing-list / lore`
> type of functionality.

To understand it better -- you want to send a new revision to a patch sent by
someone else? If so, you should be able to "b4 prep --from-thread <msgid>",
but it's actually a good question if that will do the right thing with content
under "---" or not, as I'm not sure this part was ever properly tested.

-K
