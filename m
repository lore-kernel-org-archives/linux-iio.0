Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F546B5;
	Fri, 24 Jul 2026 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851322; cv=none; b=XNi5E/5um43RprrMlNliLlZ7tT2Xxwx5OCnAhFCe698s57+YRldP6AKfEoZDmttEKav3UugzgF6wWGEt3EVAE0wOsvdR/OxIZHimdfu65OaHKzihWf+xHa/BSV9bBOqGOC8BwHTBAh4IymD9GQ7th9R3oRlAMLBKgj8BEgBUjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851322; c=relaxed/simple;
	bh=oPcV50+LAPmgnflf2fxVknPYz3D2NBIy+7AQfuXHo18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrZZZBx7SPD4synNGzeXeEtcYHyY6xDM1D9rhzeTxHzuhDThg5odMbb41s4ZEAFqzxlrftbaYDWvio8oG1nxP07bq+jCtI9kPwiNoAptaH2VC9RiQknyxl9U/zgwvxMDPHsDIuxqJAx9m7R8yy6f9KcbqyeQGP47SyeJvBR2Gpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMloWg/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMloWg/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10B61F000E9;
	Fri, 24 Jul 2026 00:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784851320;
	bh=ijuLmy4r5ItKRoZppbMBHhzjpRalw6HQqE/s/XgaemY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VMloWg/x8fBrwIZVDlZjB7OlTvMgTTVnqQhoPFZU6DUpgmIii13hZJ2X3BKKtPyAB
	 RjNzyCYQ3qxGQJ+fa8kjDUNTSmyP+97YeKuOoruT0/FJW0jOsbX8ZOFgAwqWo2EsfC
	 StH1wcxyAlK7bkdH5Q5DeqqL2sVW78tgYz15R7nA+Dmqy1xPieY04b4zneCAggYJWD
	 G+exbwljgo/LYORZ2wtfLzLaCeHZA4fXRmqHQ01XVbyp1zwp+SIpQd/aJZIcoQZs92
	 7TY65czSbbAD34RH0jAJ5IIapPcG7zLQYFx+N+YaljQkugX+hQx2GamvrzW2vYshvr
	 Fz71syx1ed4tg==
Date: Fri, 24 Jul 2026 01:01:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: inv_sensors: convert to kernel types
Message-ID: <20260724010155.4cf3c327@jic23-huawei>
In-Reply-To: <al4GseUNqFlMMF70@ashevche-desk.local>
References: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
	<20260720-iio-common-inv-sensors-timestamp-rework-v2-1-aec31446809c@tdk.com>
	<al4GseUNqFlMMF70@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 14:29:53 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jul 20, 2026 at 12:38:32PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> 
> > Convert standard types (u)intXX_t to kernel type u/sXX.  
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> >  void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
> > -				     uint32_t fifo_period, size_t fifo_nb,
> > +				     u32 fifo_period, size_t fifo_nb,
> >  				     unsigned int fifo_no)
> >  {
> > -	int64_t interval;
> > -	uint32_t fifo_mult;
> > +	s64 interval;
> > +	u32 fifo_mult;  
> 
> It makes sense to also amend the ordering to follow reversed xmas tree.
> (On a glance there are more places, but let Jonathan to tweak if he feels
>  so.)
> 
I'm feeling lazy so nope, left them alone.

Picked up the series on the testing branch of iio.git.

Thanks,

Jonathan


