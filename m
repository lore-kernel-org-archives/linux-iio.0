Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE03DFC9F
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908399; cv=none; b=XgUmtdiMv34ZgG5nbA327uYOr269N0j5fTqR+49+pq4KapX8cGBhLZgVW8DYkvbqio0JfhpLWIPwvsiKoY8HXrh7ir1Cu70fr0gn5qy8fkrZQHdhB5egVPMZwfBlfEvfJCTZA/59scFkyxbx3DOa+32LtSdC/gtrOM4Z6CrNjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908399; c=relaxed/simple;
	bh=nZqDNsTW5YI3WO5FCIMPK9tAHdYtK2t1spypNegMioU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2LbIlKz7KXt6aG5rc+HC92MCdCqjsxOzEtK0BI8tfemF+MobkEtHtoHVqMPhv5Lzql8PhI0gkzEPLZW2S8IbE2EqVHLbntScHED5811IW3e7hh5K+8owzMgr/1csYA6c5EHf3QkOnRIlWm9mWglzciw04GpIz1/aZ71KGpYl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp9mbldt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp9mbldt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D24C2BCF6;
	Mon,  4 May 2026 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908399;
	bh=nZqDNsTW5YI3WO5FCIMPK9tAHdYtK2t1spypNegMioU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bp9mbldtjiov6A0W2EvIb5ON4+1lfLIh/5u2hUTbcAqTSt5tbemD4dvNtZTnUARPO
	 EcF63A3cRaYyK6+IQoO4dQ9t5NeV1TylCTrlOIT8yirU/DbNLgaMoD48T3mTnbGOgq
	 JGjWIVc2z9q79r0wP1ioFGzpMeNqObVFwHecQddeuDFa9Jw53H4itcUBNpErWnBsNh
	 ESWVgzx56q17jDzbIFWyYhg+Qk3MDJLDQMZxhoHoGKysp6R8TjgV0caqxaa4/PU8gO
	 JlBwBzrRRNcDwWVRipyefexCfw+AVdiLDytdG6MoY+Jz0hdymUOjX1pmupQXSqpS3k
	 vycLsf+QCAx1A==
Date: Mon, 4 May 2026 16:26:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, "Rafael G. Dias"
 <rafael.guimaraes.dias@usp.br>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, Felipe Khoury Dayoub
 <felipedayoub@usp.br>
Subject: Re: [PATCH v2 2/2] iio: light: stk3310: Update includes to match
 IWYU
Message-ID: <20260504162632.24f46f74@jic23-huawei>
In-Reply-To: <afJhT6z0qwQL-tuQ@ashevche-desk.local>
References: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
	<20260428161339.1187956-2-rafael.guimaraes.dias@usp.br>
	<CALoEA-zxZgPwgb7o_=F9Q=bQSYiQi=THtCpgu0mW3EEzbXEAcw@mail.gmail.com>
	<20260429112300.696e2722@jic23-huawei>
	<afJhT6z0qwQL-tuQ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 22:51:43 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 29, 2026 at 11:23:00AM +0100, Jonathan Cameron wrote:
> > On Tue, 28 Apr 2026 18:49:36 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote:  
> > > On Tue, 28 Apr 2026 at 18:14, Rafael G. Dias
> > > <rafael.guimaraes.dias@usp.br> wrote:  
> > > >
> > > > Clean up the included headers in stk3310.c according to the
> > > > Include-What-You-Use (IWYU) tool. Remove the generic <linux/kernel.h>
> > > > header and add explicit dependencies to improve compilation accuracy.
> > > >
> > > > Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> > > > Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> > > > Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>  
> > https://sashiko.dev/#/patchset/20260428161339.1187956-1-rafael.guimaraes.dias%40usp.br
> > Had a few comments.  I added asm/byteorder.h and linux/sysfs.h.
> > 
> > Maybe we could argue the sysfs.h one will always be included by
> > iio/sysfs.h but I think it's better to explicitly include it
> > for struct attribute_group and similar.
> > 
> > The asm/byteorder.h is simpler one as that should definitely be here.
> > 
> > Anyhow, tweaked whilst applying and applied to the testing branch of
> > iio.git.  
> 
> Please, also drop irqreturn.h as implied by interrupt.h.
> 
Done.

