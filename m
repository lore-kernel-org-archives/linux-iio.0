Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7F3ECBE6;
	Wed, 21 Jan 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025616; cv=none; b=VWr/+qc94MIrNyX23lCnZLid8LolrxGU/4lfhhu3cXoc2jViRwQSkL5ba6zEHEyvSXgqSgXchCFobVzG4VqMS8Nb9zWhAotytZAiiFxXRAVJg8snVgIuSN8tYRMZbNPCH/uBBnCR7jYJCtc61gG+hnujRjha0URB3PbjcGJ0G0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025616; c=relaxed/simple;
	bh=k5StDB744iuYc5dUgOf9B8d4U2oXZcIkwrLmoQPyQc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYrCdFLy8iwhBYcr1aInXYKrG2rKhxKNhEhJ8E971/H9oauJOrD9YzZHaqeBm9VZinpBCYvDlGgMaY5fYbjlX7d3gNk8JQlIdzGUdsZ5cwo+ndvbvvQxkvOeaDtDsR+QK9B25kFIT90baT5JNlMje60lh3eE9+Z0/iQwAZgB6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6bCkqg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6bCkqg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B67C4CEF1;
	Wed, 21 Jan 2026 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025616;
	bh=k5StDB744iuYc5dUgOf9B8d4U2oXZcIkwrLmoQPyQc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6bCkqg95gGOANpwCMpjZc0i5lfopXO6D/SHW34+RNKjBD53boMfZUzp9TFe8fRey
	 j++ReBuvvT132sI2sZEPvrc9xc5a+tnnU3UbcraEXnuvWYxDB643QW7Xa/I/B5nRor
	 cxREGEZTwKRJYUdtfE2lxVvJuFNDhA2P45fjo3TXMXsT8HApoBGE9OehNLA1di4970
	 j5N8h2d8Bz8HrUHBWokBTjRyc6wJemro+L0h0ub4wraRlwDB9+zi0Koklu9fA9PYwe
	 eNuSSNVackVvcZzgtJBctVlBhqmdMBROTEYNJAq6L+3vqxDFqembzF6SeE0e1iHNIp
	 zTrvkAY7b3/Sw==
Date: Wed, 21 Jan 2026 20:00:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Frank Li
 <Frank.Li@nxp.com>, andriy.shevchenko@intel.com, carlos.song@nxp.com,
 fluturel.adrian@gmail.com, linux-i3c@lists.infradead.org,
 linux-iio@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: Add stub functions when I3C support is
 disabled
Message-ID: <20260121200009.44dfe893@jic23-huawei>
In-Reply-To: <202601202302180c990bfb@mail.local>
References: <20251230145718.4088694-1-Frank.Li@nxp.com>
	<176840281753.1259180.16475027635174872850.b4-ty@bootlin.com>
	<20260115171220.000001b7@huawei.com>
	<202601202302180c990bfb@mail.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 00:02:18 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
> 
> On 15/01/2026 17:12:20+0000, Jonathan Cameron wrote:
> > On Wed, 14 Jan 2026 16:02:06 +0100
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> >   
> > > On Tue, 30 Dec 2025 09:57:18 -0500, Frank Li wrote:  
> > > > When I3C is disabled, unused functions are removed by the linker because
> > > > the driver relies on regmap and no I3C devices are registered, so normal
> > > > I3C paths are never called.
> > > > 
> > > > However, some drivers may still call low-level I3C transfer helpers.
> > > > Provide stub implementations to avoid adding conditional ifdefs everywhere.
> > > > 
> > > > [...]    
> > > 
> > > Applied, thanks!
> > > 
> > > [1/1] i3c: Add stub functions when I3C support is disabled
> > >       https://git.kernel.org/i3c/c/8564f88df202
> > > 
> > > Best regards,
> > >   
> > 
> > Hi Alexandre,
> > 
> > This is going to make for an 'interesting' merge window as I'm getting
> > build failures without that patch.  I don't suppose you'd mind
> > doing an immutable branch? 
> >   
> 
> I just sent it, let me know if this works for you.
> 
Thanks. I've dropped the temp fix and merged that ib.

Looks good.

Jonathan


