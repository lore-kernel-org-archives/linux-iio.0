Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8A3CAA3F;
	Fri, 22 May 2026 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447152; cv=none; b=ZDLr3gdY/88G+EscJTwMKFisKsKcqzZ/8sQJzIummvd86WtVKLheP70/XOVt3Zg3Gr6LmizLA+5i+MJkyJYWLPSKBoc89m8eV03g2vhpxgZkFEHx8ZvpM6dUzdnI1sWD2qSDzpeyzxt9YtLOXB5mFkbKajAo4GCL6WSt7Um5kcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447152; c=relaxed/simple;
	bh=E5Dk29FQOLOQijSVrqHF4W34Bgyq5ffeFX3ANsWI99M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5OxI+8y1eR9axsegsn1I6H2T1zl8g+zPSFft75glESHsmt3kQM6b6x6GAX0dWCiY/kD50n6l7u9IFqq1c99odpg+mUL7mDHqhWzDS0NthTHimzs5oth8EKlBevTU6CDJsn6FttiIzCTkNVxr8wLv71u7GhFA1Cf6qxXspMBkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9QB6l1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9QB6l1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AB21F000E9;
	Fri, 22 May 2026 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779447150;
	bh=t0iogsH3JfVjm/HLma5XLTHRAPZtm7scQcp51vM+as4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F9QB6l1Q6tFJLJV2Qhlt7O14jnsPWAZIu8jlma6ubiDMEnZYew4yDopnKATebtvDP
	 E0Tt1pxsoeideRh+Wis7k3rloaEd0OImeGpnA8OCqcg42ym2HT1hzAjfYdaKONA0x9
	 dQicGeIF4BfPveGJeZMt5q2a8jqMfes5isGL3yfjdehvzrQ2y+ZjwBZsGebQEEV+Oz
	 nRnGob6koD1tRLKBJT1ixY15z27VDIpH05tvn5ZyYSYmmYM82A705Uu+BsGpS1a7F5
	 03iUh0cLxXcmhUKPy4/TFTdMsz04f/Xke/wsU6PVM29XVu8adTlhcp7X1nDcShc1X1
	 nIBgf4BiSDbFA==
Date: Fri, 22 May 2026 11:52:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Message-ID: <20260522115222.0d7efb86@jic23-huawei>
In-Reply-To: <NTZPR01MB095660868B0DE59B2B0161CC9F0F2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
	<20260518081852.116909-3-xingyu.wu@starfivetech.com>
	<20260520130532.15e65a18@jic23-huawei>
	<NTZPR01MB09564579135FBB637DA5F0F59F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
	<20260521123727.6a7d97ff@jic23-huawei>
	<NTZPR01MB095660868B0DE59B2B0161CC9F0F2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 02:20:53 +0000
Xingyu Wu <xingyu.wu@starfivetech.com> wrote:

> On 2026/5/21 19:37, Jonathan Cameron wrote:
> >   
> > >  
> > > >  
> > > > > +
> > > > > +	starfive_saradc_ch_monitor_stop(priv, ch);  
> > > >
> > > > Why stop it?  Add a comment.  We aren't interested in future events?  
> > >
> > > If we do not stop it and the input voltage remains constant, the ADC could  
> > continuously monitor the voltage and continuously trigger interrupts for the
> > bound.  
> > > As a result, the CPU utilization rate will be high.  
> > 
> > Can you use an edge interrupt instead of a level one?  
> 
> No, it is a level interrupt in hardware.

Just to check. That's a restriction of the interrupt controller IP in that
it doesn't support edge interrupts on this particularly line?
Seems unfortunate given the block on the other end is providing something
that seems like an edge :(  Ah well - hardly the first time we've hit that.
Add some comments to the code when you add the timer approach to
re enabling.

> 
> > 
> > If not, then a common solution is to disable for a period (maybe a second or so)
> > then reenable. There are various more refined ways of doing this.  
> 
> This is good idea. How about using timer to disable it?

yes, there are examples in tree doing that.

J

> 
> > 
> > Basically we don't want to be in a situation where a momentary blip disables the
> > event and we miss a later condition that must be handled.
> >   
> 
> Noted.
> 
> Best regards,
> Xingyu Wu

