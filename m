Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFA282F16;
	Fri, 24 Apr 2026 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051420; cv=none; b=smzY/g3HaHyzED5se0B9PjVuVCC/szi/9bq/RI93u9ebvPzb3uNBGAFEvHc+CbgrsqWnZLxv+XapvVc1wRUiIoy4a+eK16lC45k4GdUJ74JOY8TtebX0nvkB+/QPrDDfaBJPzUBZzi5/HZBSritAsnVSzrisVSqF4wbkCpqNC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051420; c=relaxed/simple;
	bh=XdfxK7Z4N4ujeQiNlbMpc7dvmS5wTaV84HG35Qag8yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9qPcVfqUj8fPKxE4PGarhN5T2eVz3gpGPWbrwfZNIM+AN5Fmk91jd8aRNGBbDWYbDXwWXDqMlqxy3GcVO2u+iSm+M55gRn6vHhK0TGjua/l37xkyHT8XLPLtJrWzyEgAH5HXlMuclpW/Mpj+gUDCZORjdwHZNWy5doN0ULX3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Shp2y/8u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shp2y/8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543BFC19425;
	Fri, 24 Apr 2026 17:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051420;
	bh=XdfxK7Z4N4ujeQiNlbMpc7dvmS5wTaV84HG35Qag8yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Shp2y/8usVMkmp3nH3JiGMI4RQRORZfjILvqDVsqT/HbZ/5+wxMfnsRwm1pgXLWyg
	 U7lpM3dZeOYrqyEdse97kxABCDvHRnGulW0WoyqWd5xevM92cru3idMxW12p+9OU3A
	 Qmvg9fAUAe7Wc8wPCfrdE1a4FJ6VkdC8elKnZUGWWWIKcOu4OTb0MhFuPxqdksv7+o
	 eZVxA1v6MBf/xulzphI5M6vXct3MiQDP9BGpLGMDq+n0iy46X0r5G1/lAs3cS26pfp
	 zidwFPXkKBn4yRduK0jDfYfbZRcY7MIAT0Wjg94neDgpmvdK1Jdfx43lgJhooCX0wM
	 c1+H2mM3nVT4g==
Date: Fri, 24 Apr 2026 18:23:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
Message-ID: <20260424182332.779db1e4@jic23-huawei>
In-Reply-To: <aekjpkSW_BXO2Y_X@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
	<20260422165643.2148195-6-sanjayembedded@gmail.com>
	<aekjpkSW_BXO2Y_X@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 22:38:14 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 22, 2026 at 10:26:42PM +0530, Sanjay Chitroda wrote:
> 
> > Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops pointer is
> > automatically handle when CONFIG_PM is enabled/disabled. This follows
> > modern kernel power-management conventions.  
> 
> After this patch there are still CONFIG_PM ifdeffery left, why?
I replied on earlier patch to this.
Drop the wrapper function in favour of just having the pm_runtime_xx
calls inline.

That will also get rid of the ifdeffery.

J
> 

