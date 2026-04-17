Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733137883E;
	Fri, 17 Apr 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430250; cv=none; b=jydyn2HprNtQs5sHvlniF3oMivvKx6Pf2JKX1/AJDGeVnFx426wSnuqFc2NvLTRnh+pIzXIoDnvU3EfQ0Zrd662wLBUMCmG1RFhS+ckQGeDrfPbnWid1VqjMFeAI8L/a+mVUuF6ZPZnLy5PYyVeEgOvXctQbcuI//MA83hdGh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430250; c=relaxed/simple;
	bh=1YAn/wYNj/UQGeI0IlF8OED47ycG5/Qd+c5F536VrsU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiaAVIJp/4M2WvXH7SGa5MHO/G1sRY1mKgF9kSmRReOaahiv9uscHRnZxsLd6GFbxT0ap5b17g5RTGZAgNPZTwRveLHfjKVaTzZPOVXT2bgHPyPfg6FwOo92Kun8mzjuAbKpHRLp3YldgKPOOvbJiaCglfj7gNjvHyMGXDo/UFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fxvqD0TydzJ46DW;
	Fri, 17 Apr 2026 20:50:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C72440572;
	Fri, 17 Apr 2026 20:50:46 +0800 (CST)
Received: from localhost (10.203.86.132) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Apr
 2026 13:50:45 +0100
Date: Fri, 17 Apr 2026 13:50:44 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Junxiao Chang <junxiao.chang@intel.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<gye976@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: buffer: fix warning in requesting threaded irq
Message-ID: <20260417135044.000037dd@huawei.com>
In-Reply-To: <aeIZw2gvbZGJEXy9@ashevche-desk.local>
References: <20260418002334.3643504-1-junxiao.chang@intel.com>
	<20260418085156.121947-1-junxiao.chang@intel.com>
	<aeIZw2gvbZGJEXy9@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 17 Apr 2026 14:30:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Apr 18, 2026 at 04:51:56PM +0800, Junxiao Chang wrote:
> > IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
> > handler, this flag should not be set.
> > 
> > This change fixes a warning during booting with kernel v7.0-rc3:
> > 
> > WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974  
Please provide details on which driver is in use to hit this corner case.

That may help people identify if the bug applies to what they are seeing
and also provide some background on how urgent this is to get upstream + backported.

Jonathan

> 
> > RIP: 0010:__setup_irq+0x1639/0x2510  
> 
> Unneeded line (it dups the previous one).
> 
> > Call Trace:
> > request_threaded_irq+0x2c7/0x490
> > iio_trigger_attach_poll_func+0x353/0x6b0
> > __iio_update_buffers+0x2420/0x2c70
> > enable_store+0x183/0x270
> > dev_attr_store+0x5e/0x90  
> 
> > sysfs_kf_write+0x1e8/0x290
> > kernfs_fop_write_iter+0x406/0x5f0
> > vfs_write+0x71c/0xea0  
> 
> These 3 lines are also redundant.
> 
> > v2: using ternary and drop temp variable  
> 
> Changelog should go...
> 
> > Fixes: 23f2d735a932 ("iio: Add helper function for initializing triggered buffers")
> > Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> > ---  
> 
> ...here, when it doesn't go to the commit message. One may find this in the
> lore archive.
> 
> ...
> 
> Code wise now it looks good.
> 

