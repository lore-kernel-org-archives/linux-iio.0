Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7E259CB2;
	Sun, 22 Mar 2026 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774180448; cv=none; b=aC9yexwBkuAvY2V+MTafeZK55bqVSCnCCRjpMZ4WwfgUGWLoPY7OXIuQsBPAHoge66g3VP2oWo/+zM6Qa0zWm4JxKeV9PuETD/K39E36cRVz1l+y3oDu8sz/APO8T94uwzaWQCCGEhpGOk+0L3UDfi6qED+sM6rxzgdxBku2h/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774180448; c=relaxed/simple;
	bh=db2mMFISaIld4Bk8nMdv/O1Vegch1KJK1osfa1q7w38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLodfk+J5sMXmqeMCeWh08eSSkj7pf++X8ERfZIdHAgZOj6NEPQVYXmQmaDrSHln2wx1wJOqrexqNuxN7Bh2DHz7FIBGIgp+0QP4eWCJPCymebPKRcYjJ/qqwSBerjFrJxqWJly4llpc9jxYWoNyhl1ffle4KD9MXXfjgekFb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWhgmTRE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWhgmTRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A46C19424;
	Sun, 22 Mar 2026 11:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774180448;
	bh=db2mMFISaIld4Bk8nMdv/O1Vegch1KJK1osfa1q7w38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uWhgmTREohkfG3Y3SFotLZoARcUYsl4hqMB63zheaBsULdcsSVsmh8PYHfCNBWWAT
	 T50lrvQ9+ySgINpkFRHYv9lVIJYVoCEdiY4seP0CzlCWWqh38HESsYy5soNnxxC9DB
	 mWIOqHaZsiOotoxQloD9WKFX07HHWQ5mNaXL/+UhcFdsjsZ3UEdDjtLLrbKsTaHCcm
	 ic4a8Y62eo836AyH5W1nCVjY73s+V0+DDDO3wDDgXexBJvlqM7Vc9TnYxP1R2szGrG
	 L3wvhLLc8HVKy+323El67edJVzPu7TK6MsRywWmjrM3Tp21vP7nZppTnK+QIHSXKJc
	 9pI7Iwuykc32A==
Date: Sun, 22 Mar 2026 11:53:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: st_sensors: correct kernel-doc issues
Message-ID: <20260322115359.235bcaaa@jic23-huawei>
In-Reply-To: <abKWh4ACsYzTI9fr@ashevche-desk.local>
References: <20260312051347.681042-1-rdunlap@infradead.org>
	<abKWh4ACsYzTI9fr@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 12:33:43 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Mar 11, 2026 at 10:13:45PM -0700, Randy Dunlap wrote:
> > Use the proper kernel-doc format and struct member names to avoid
> > kernel-doc warnings:
> > 
> > Warning: include/linux/iio/common/st_sensors.h:184 struct member 'int1'
> >  not described in 'st_sensor_data_ready_irq'
> > Warning: ../include/linux/iio/common/st_sensors.h:184 struct member 'int2'
> >  not described in 'st_sensor_data_ready_irq'
> > Warning: ../include/linux/iio/common/st_sensors.h:184 struct member
> >  'stat_drdy' not described in 'st_sensor_data_ready_irq'
> > Warning: ../include/linux/iio/common/st_sensors.h:184 struct member 'ig1'
> >  not described in 'st_sensor_data_ready_irq'
> > Warning: ../include/linux/iio/common/st_sensors.h:219 struct member
> >  'num_ch' not described in 'st_sensor_settings'
> > Warning: ../include/linux/iio/common/st_sensors.h:263 struct member
> >  'num_data_channels' not described in 'st_sensor_data'  
> 
> Thanks, it's a good patch for this driver!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Thanks for cleaning this up.

Applied to the testing branch of iio.git as various other things on there
need a poke from the bots before I push it out as togreg and linux-next
picks it up.

Thanks,

Jonathan
