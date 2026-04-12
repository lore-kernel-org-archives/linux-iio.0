Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A878313E24;
	Sun, 12 Apr 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776004340; cv=none; b=bJHiw/Y7FJpCFVji3emx029qDbRaGwPRXuvE6EjUEvB1vC/hi/3dccFAXHxI57KJ92/BemCBcyI9GYasIzgV5Glth02RgVbj11AuCGJZGBol014KKyBlZds2s/jA0Ubf3VjJm3XdSNoiG8EdxgUw0tvVWBSDiir9EP6EgDYtQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776004340; c=relaxed/simple;
	bh=7WfdRn6Z59E+7VmpdZJQMn56lCZNgJBwwEK5R50/aRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGuaCbnM4WnOsMgQPNlmRfb4N846a6BgYCHHUCZQUW5r7ddHgxMDZLKF8MOwU9KmpDaycuQUFb5m+5rBcfpwG+eCz9azLZnc2BL7myzc9cvDasV+EpNqUYsG+6VrLyVipWSYQb9pQvK1xNZ8f7ftc7CPcVyWQjPfH3dMXrVb7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvxlmyge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvxlmyge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8BEC19424;
	Sun, 12 Apr 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776004339;
	bh=7WfdRn6Z59E+7VmpdZJQMn56lCZNgJBwwEK5R50/aRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VvxlmygeZdaNIoPYJJd7/+WoLnb5Mfh8oZRWBlihPBuUb8ARf3gwSxdIPJIBf3/vQ
	 V4RiYm/dcfjEtiHJ82jwwyW//7DmK/kcap5VqZhIqBWfeL2k/ZoyWZ4nby8lcqMQ38
	 fts0+buQww3/rlrmq5k9ivCPkuAMj4jzkY//CpsUyYwL6tB1Ck3BID8DLii5uiBFrW
	 OvfFoTqQnghevZ4T8X1r236Xy2+l49tfWSOPgrgIOtF3U0kshYwnfnCLo/6bMmPI+3
	 NnWYkW+g8lTi8IdGrDtoYiDMMPkEo2a05ReAVhb+tgYdLgky623bCjEw0+ntAcCgwS
	 dT387CYr2Cewg==
Date: Sun, 12 Apr 2026 15:32:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: health: max30100: drop unnecessary cast
Message-ID: <20260412153212.62a27aa5@jic23-huawei>
In-Reply-To: <20260321205646.207ac77f@jic23-huawei>
References: <20260314-iio-health-max301000-drop-int-cast-v1-1-ed4982d559f5@baylibre.com>
	<abfojPjXKhI6V9e-@ashevche-desk.local>
	<20260321205646.207ac77f@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 20:56:46 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 16 Mar 2026 13:25:00 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Sat, Mar 14, 2026 at 05:33:01PM -0500, David Lechner wrote:  
> > > Drop an unnecessary cast in max30100_led_init().
> > > 
> > > val is defined as unsigned int val[2]; so the cast is not needed, nor
> > > is the address-of operator &.
> > > 
> > > Also fix alignment with ( while we are touching this.    
> >   
> > >  	ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
> > > -					(unsigned int *) &val, 2);
> > > +					     val, 2);    
> > 
> > You want to have ARRAY_SIZE() as well.
> >   
> Should we make val a u32 val[2]?
> 
> Obviously we all know the unsigned int is that big, but in theory that might
> not always be so...
> 
> This is the only place where it's passed as a pointer rather than value from
> one of the elements I think.
> 
David, this question is outstanding so I've marked it 'changes requested'
in patchwork.

Thanks,

Jonathan

> 
> 

