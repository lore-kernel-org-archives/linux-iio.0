Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554111;
	b=sMGn4udJUxM+vzfhqM00MY1XwU1VSVT/XxH9e5F9JAxZd1gxEmGyOsNLUeC3c3eF9U2t
	 BFh9VWskyqagL8rUKYgoScKpFq+wJouGUfzWzbQyf2NrCy7xKnRFJns1y0aHSJ6L6sban
	 M4yd/wAE02PeEoklQDT/o7vip34sL6knB/ILepNUqSFv3tBfJVnzdCQ+M1AMl1Hwyrf3/
	 tTh7gw2x1jUn0AAN0gYtIrFxjC91oGEDTH67D+UzLaLFyGV3DlMgS9yUbYKOs0MfUooS6
	 GzPD399hVQt8oHDbFD2b7iQ+raCulvl/o+rbjasj35PRTSWIy0yXzQ8TM1QrNlzO4Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554111;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z+faEv6ruDWxCWVM7AJiDR2LnLtzlyo6EJhbjbGm3Pg=;
	b=lvkimYAzoQyNJNnfG0M4mOi4+9gMLwAoIgaqi9l1WtjUDEmmZtgcx2PPTg6sEiDtAj/j
	 QAwgVXNJf7PLQnksSZrK+rYa2DwStyiwUod8bHqy+sBE3WUhGgufkWwJeCSnjnyZHMS4D
	 Lwp/D3UELogTD041gWWcZIiQs90CYUgnINdkfMCzWD4X/Q9TcUDyOz848VbefwebchXEe
	 zhPlkDP/1P/Nvp5jfjWL8gKZUCaMLB8+jmMOJIbPY++K3apbjuxP1J90NUVGshD6hixSm
	 EYxoHe81wZfsNsStWRqj0BNOlrD/0WT9zfsJJsXJ8AYzCtFLNLJWMReFLaXPWjV6C6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8vC1f8q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F59606A324;
	Sun,  1 Nov 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8vC1f8q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B39D1F000C1;
	Sun,  1 Nov 2026 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554111;
	bh=z+faEv6ruDWxCWVM7AJiDR2LnLtzlyo6EJhbjbGm3Pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e8vC1f8qpKZpmVm2gp4A5WItgJgLf0maJmRTRVFK9m2au+ZwOU6QmqSVvHtmkbpR8
	 5jjcwas5J7awudvgi5hdEh2kbPuQJEBVtK2GrXQWdhhLj+u6lV8dnb0+RML8U8PZfX
	 XY1yGWuGJozyksFNpn2A6kqawieDDnVU9VtNtzOJdRzG8BD7thdyHaDeEpM3068EvN
	 T/qvXhxny1UJ2ouF5fvZHeyNWshWEvBKSHcPwMcQYHk68503GLn50sN30eI7T6YYaU
	 YjyB9iCiGtTF8wUJzOuAUoWn4jaZi/WWwqsAUCDhuLag2xi+RE0fd/oyzbvj/IloRU
	 5xRcc2MHonM8g==
Date: Sun, 1 Nov 2026 17:28:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: linusw@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com
Subject: Re: [PATCH v2 0/2] iio: gyro: mpu3050: Fix runtime PM refcount leak
 in trigger enable path
Message-ID: <20261101172822.6591a452@jic23-hlaptop>
In-Reply-To: <20261101092327.197-1-laixiangwu@cmss.chinamobile.com>
References: <20261101000404.41fe1028@jic23-hlaptop>
	<20261101092327.197-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Nov 2026 17:23:25 +0800
laixiangwu <laixiangwu@cmss.chinamobile.com> wrote:

> Hi Jonathan,
> 
> Thanks for the review comments on the first version.
Hi.

First a small process thing. Please do not send new versions in 
reply to an older one.  It leads to confusing threads and generally
puts your emails way back in potential reviewer's inboxes.

Start a new thread for each version.

Thanks,

Jonathan

> 
> This is a rework of the runtime PM refcount fix for the mpu3050 data
> ready trigger, following the review feedback:
> 
> - Patch 1 is a new precursor patch that splits the enable and disable
>   paths out of mpu3050_drdy_trigger_set_state() into a pair of
>   separate helpers. It is a pure code move with no functional change.
> - Patch 2 then applies the fix on top of the refactor, so the error
>   label now only lives inside mpu3050_drdy_trigger_enable(), and it
>   uses pm_runtime_resume_and_get() instead of pm_runtime_get_sync(),
>   which keeps the usage counter balanced even when the resume fails.
> 
> laixiangwu (2):
>   iio: gyro: mpu3050: Split data ready trigger enable/disable into
>     helpers
>   iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable
>     path
> 
>  drivers/iio/gyro/mpu3050-core.c | 182 +++++++++++++++++++-------------
>  1 file changed, 108 insertions(+), 74 deletions(-)
> 
> 
> 
> 

