Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448AC3A63EA
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950145; cv=none; b=YwDYppZUg4j+loog6Cp9k4tAjwUrvxrdq/JZGHJa8xYkpK+3qeWJt6+ebWgmZsjQz9uV6m95j8ichZEe0+cK+w6zf75o2+zPsrZ5Z1g29HyTt350jH39VQLxPsYeJHt5+2ksjxWnvtu4Pv6nAC0nz7lBBtI1474SgK5Kx1Z9hjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950145; c=relaxed/simple;
	bh=LLmBgOGKQ1qgYXxjfeK8boKNlXniFY+Q5EBH79xWGvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu1+v3c/M6kaDs/s/C0WgaraNJ8Hxt2C+g240U6iM3UP62A1DTB49jBUcr5XtowQIOG/k5JOIqIRBiuZpMDb3rYxK2EmqD5TNSYeyntSTxc/saYUHYMiZu8nhtI6ikGAwxAhBN2g1K3PVXNDbmHIBKnLdT1akUl10HdtCrEDxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ziqN87gu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ziqN87gu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 88485C20338;
	Tue, 20 Jan 2026 23:01:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ABEF4606AB;
	Tue, 20 Jan 2026 23:02:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19383119B01E4;
	Wed, 21 Jan 2026 00:02:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768950140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TreuwGMpIeYNk63GLZLQ3HNUc7bshFktVfXuohKMyLk=;
	b=ziqN87gurgQbp1p96wgTNmkOMFl190jML6BcP7b3M7lyN1f/95Z3l0C019oAf9+cTL2I+G
	Y9MPNUTmyxWqp1jyLFfnAVW3MAEa73RZvWrSzHx76ir8UuC90IRT1ZWakonw1QmhrrKBLr
	OkPqbowb590K+pf+Xut1ZFRud4njULwOl5ocW+wpx/dJydQPKHyGQO+2PpaH9X6vtLKPxA
	CrK97a61lSL0pvUEy+aPcPV7vvj8erOA8h1LimAmOezeD5mxjv6/d65o2ymswqhJoCASJU
	/KlhMb9BM7v7E77Z3lZ/GGhLrJzSd479u4iF3qy2O1c2iKgddPGMaaEpMtCw9g==
Date: Wed, 21 Jan 2026 00:02:18 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Frank Li <Frank.Li@nxp.com>, andriy.shevchenko@intel.com,
	carlos.song@nxp.com, fluturel.adrian@gmail.com,
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: Add stub functions when I3C support is disabled
Message-ID: <202601202302180c990bfb@mail.local>
References: <20251230145718.4088694-1-Frank.Li@nxp.com>
 <176840281753.1259180.16475027635174872850.b4-ty@bootlin.com>
 <20260115171220.000001b7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115171220.000001b7@huawei.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 15/01/2026 17:12:20+0000, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 16:02:06 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On Tue, 30 Dec 2025 09:57:18 -0500, Frank Li wrote:
> > > When I3C is disabled, unused functions are removed by the linker because
> > > the driver relies on regmap and no I3C devices are registered, so normal
> > > I3C paths are never called.
> > > 
> > > However, some drivers may still call low-level I3C transfer helpers.
> > > Provide stub implementations to avoid adding conditional ifdefs everywhere.
> > > 
> > > [...]  
> > 
> > Applied, thanks!
> > 
> > [1/1] i3c: Add stub functions when I3C support is disabled
> >       https://git.kernel.org/i3c/c/8564f88df202
> > 
> > Best regards,
> > 
> 
> Hi Alexandre,
> 
> This is going to make for an 'interesting' merge window as I'm getting
> build failures without that patch.  I don't suppose you'd mind
> doing an immutable branch? 
> 

I just sent it, let me know if this works for you.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
