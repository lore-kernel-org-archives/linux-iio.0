Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923E3D3327
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947051; cv=none; b=hpJXzsqdqM0DbipkZZWsTvbSgtwoUJnPVUgF0Dq3WY3c7ISxFU4A7rgY3cuYtCvRLpSkP+6rrEgVlnGsNoUv7F626qZYflL1MPk2aDFyUglVaOsiCN0DyRUgWo4Xbnvnrgxac+pXZtif/AL+jy+Uduaw82NPwAtOErJ/OIzb694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947051; c=relaxed/simple;
	bh=2v2upJk52arS90hj4EbIOmXYddCHtTuIw7ewGrMz6DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmDIDtRczjCNOw5xWtp1RhQZ4SRs9h4Edt8KVENoiFJd4fPUce4yzoSrpVZdsxTj4oGFobWUcvB9srdkZCwoYLevAn/puxWMH94VIMuYhBnJvxaav1MZH0O3D0UE4fvPLSEYNtq8rcIfhSBCNic43GlD75QJ+cFjF4Q9MUclHxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKZRI615; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKZRI615"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E56C16AAE;
	Tue, 20 Jan 2026 22:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768947050;
	bh=2v2upJk52arS90hj4EbIOmXYddCHtTuIw7ewGrMz6DQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rKZRI615la0DYQ6wYemVeosww46YJPYwwqSDqKnCb7srKJHgPTaXKeUq0hA9UKYfw
	 zmHhHZTvrsXxwjUoUidSB9pUhZBdVN+iHqIWjyLCakWwwOYWFVKwpYrAyW0qYZ5QDB
	 hJyc0eXtIKOex/PWxnj073Rkdgw35THp+LyCORO9LYYaQfQAgthPS1/gumZiRBbMq0
	 RL9PKYeU+hAwQBixxdff+UfF0rp+6MXJFW9Cc0J2a6AXWfrbPYbK+HcHiOWhMNOrvI
	 p1nlAHDL5umWeMt958Fpff7XnhC/QbULKh46j44gJnSImk6kR8U/8oShgXg3/pWlGT
	 XQuetYatRmCLA==
Date: Tue, 20 Jan 2026 22:10:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Mike Looijmans <mike.looijmans@topic.nl>, Liam Beguin
 <liambeguin@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Ibrahim
 Tilki <Ibrahim.Tilki@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 04/11] iio: adc: max1027: Improve include relevance
Message-ID: <20260120221040.35735609@jic23-huawei>
In-Reply-To: <aW81S3XcVBnuYI71@smile.fi.intel.com>
References: <20260119212110.726941-1-jic23@kernel.org>
	<20260119212110.726941-5-jic23@kernel.org>
	<aW81S3XcVBnuYI71@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 09:56:59 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jan 19, 2026 at 09:21:03PM +0000, Jonathan Cameron wrote:
> 
> > Drop kernel.h in favor of more specific headers and add includes that were
> > previously relying on other headers including them.
> > 
> > Whether to include device.h or the relevant sub headers is non obvious.
> > In this case, there is an access to struct device for
> > spi->dev.driver->name which is used to name the irq.
> > 
> > The justification from iwyu for the additional includes is:
> >   #include <asm/byteorder.h>           // for be16_to_cpu
> >   #include <linux/array_size.h>        // for ARRAY_SIZE
> >   #include <linux/bitops.h>            // for BIT, GENMASK, fls, hweight32
> >   #include <linux/cleanup.h>           // for guard
> >   #include <linux/compiler.h>          // for __aligned
> >   #include <linux/completion.h>        // for complete, init_completion  
> 
> >   #include <linux/device.h>            // for dev_err, dev_name, devm_kmal. ..  
> 
> Not good, we also should treat device.h as "include everything" and try to
> avoid that, above comment hints like
> 
> dev_printk.h
> device/devres.h

It's there for
spi->dev.driver->name used for some reason as the irq name.

I considered fixing that but felt it was out of scope for this series.
I'll add a comment as iwyu forgot to mention use of struct device ;)

Thanks,

Jonathan


> 
> >   #include <linux/errno.h>             // for ENOMEM, EINVAL, EBUSY, ETIME...
