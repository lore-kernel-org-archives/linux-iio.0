Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ABC40DFCD;
	Sun, 19 Apr 2026 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776604095; cv=none; b=pJMe8Y0tvcYYLz1H5E8RSlmyrcpbAA7OkeYgdyrMGCU8UgXYXobwEih0HWrWjqLHOK3V2j8mpKmGFawd7Ubzb70Qv0xgQj7jM5K5Jg/V/UuUI4tRV91wEur5c8Lk2qAF5RlAW9hveoa161p8WiB5CyA6uRsosdmwMKHKoHX+htM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776604095; c=relaxed/simple;
	bh=w6CAnNqt+aoUM+IJR0zIfwnmuV4nhsG3WFfasi3BcsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbVWIYjc2GGA7paoEgheF00pi3DANhKMJJdtq8CTnxZvmEEYGXsHBM1+H76KkkcJ4a43KhW7KQVgRvJfjzrkuFKENZhIak3U5vo5rdFwbOmFeVQ0CV7UKA6NrZtQ8F1547CMtUaEButsLE15Wm9DfGatMoyVxWhRGvaEXz/iRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcuBrFjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcuBrFjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AF9C2BCB3;
	Sun, 19 Apr 2026 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776604094;
	bh=w6CAnNqt+aoUM+IJR0zIfwnmuV4nhsG3WFfasi3BcsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcuBrFjMssC3Vw+k6waXSXBPneLWgag/Uhc/2wj0mt5c+z8jLVt50aO/JTERo2qmV
	 jhRh4GKxM+6etxd58H2UN2UOuDp2srsJlSiqxIaI5FdTPjOWTk0gjko73YEzqG8/SF
	 eXAch3ouRkhugJ7n+3vBW0pnR9WZf4VhcKJ8YEfm0CKe2j4ky+JWr38VWhezqIG6lW
	 QWQnI7vxM6ehTUbkgNVdm/CdjJ6vyXkCAE1HA8C/ybfg8VPbO7MJWqXbOSCyN/4UJa
	 O46pgNDq+CYl5S1Ge1cR91GMixEOQ05n39HSxzMHlbAH+M/X6q9tZ9OE8B5KRbyUhb
	 LeMwHsxnRT3Jw==
Date: Sun, 19 Apr 2026 14:08:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Junxiao Chang
 <junxiao.chang@intel.com>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <gye976@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: buffer: fix warning in requesting threaded irq
Message-ID: <20260419140805.6abc77ce@jic23-huawei>
In-Reply-To: <20260417135044.000037dd@huawei.com>
References: <20260418002334.3643504-1-junxiao.chang@intel.com>
	<20260418085156.121947-1-junxiao.chang@intel.com>
	<aeIZw2gvbZGJEXy9@ashevche-desk.local>
	<20260417135044.000037dd@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 13:50:44 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Fri, 17 Apr 2026 14:30:11 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Sat, Apr 18, 2026 at 04:51:56PM +0800, Junxiao Chang wrote:  
> > > IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
> > > handler, this flag should not be set.
> > > 
> > > This change fixes a warning during booting with kernel v7.0-rc3:
> > > 
> > > WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974    
> Please provide details on which driver is in use to hit this corner case.
> 
> That may help people identify if the bug applies to what they are seeing
> and also provide some background on how urgent this is to get upstream + backported.

Another thing I just noticed related to upstream process.
Please don't send a new version in reply to the older one.
Send it as a new email thread.  It doesn't matter a massive amount in a
simple case like this but when things get more complex threads can become
unmanageable if using this style.

Another practical thing if you want to get code merged is many reviewers
do what I'm doing today and, when they have a massive backlog to review,
start with the latest emails that they see.  In this case your
patch ends up further back in history so is less likely to get reviews
in the short term

Jonathan

> 
> Jonathan
> 
> >   
> > > RIP: 0010:__setup_irq+0x1639/0x2510    
> > 
> > Unneeded line (it dups the previous one).
> >   
> > > Call Trace:
> > > request_threaded_irq+0x2c7/0x490
> > > iio_trigger_attach_poll_func+0x353/0x6b0
> > > __iio_update_buffers+0x2420/0x2c70
> > > enable_store+0x183/0x270
> > > dev_attr_store+0x5e/0x90    
> >   
> > > sysfs_kf_write+0x1e8/0x290
> > > kernfs_fop_write_iter+0x406/0x5f0
> > > vfs_write+0x71c/0xea0    
> > 
> > These 3 lines are also redundant.
> >   
> > > v2: using ternary and drop temp variable    
> > 
> > Changelog should go...
> >   
> > > Fixes: 23f2d735a932 ("iio: Add helper function for initializing triggered buffers")
> > > Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> > > ---    
> > 
> > ...here, when it doesn't go to the commit message. One may find this in the
> > lore archive.
> > 
> > ...
> > 
> > Code wise now it looks good.
> >   
> 
> 

