Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C803CBE89;
	Wed, 22 Apr 2026 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852591; cv=none; b=FzaMpnunDALK2UcckCyzrvTsrjooLIi+xGMYnSrLeI5oSWiLvj67ii1Eqa0EdX0A7Y6GK2YqNj3Wt4c1cIHCkzOyQ9aPMkGAk2BknIZ2lGt+JL03GJqy/seWwebTF5V22NU5l9PpEdFIMd/2qX28F1KMATbdfuhygAY5pNs9SaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852591; c=relaxed/simple;
	bh=7ys1RZCvPNfZCaHMJJye59Pev//UtvgGOn7nZKjFzCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lepIDDc79DQFNu/nubjgikx1/TrCiaG2Hh24g9nAjqQ4wmVTEEoKL6aS3qrpdDB3evY2E0nP7nYR2gt2Uq465HOH9sdVzwAGurm9LkvIgs155rSFrS+VwTJhhx4aQlHKO7spOzGgtI2LGssH/UHlfmJoqNVjgG0FEJh8WXSX4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4cGOTk4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4cGOTk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B2FC19425;
	Wed, 22 Apr 2026 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776852589;
	bh=7ys1RZCvPNfZCaHMJJye59Pev//UtvgGOn7nZKjFzCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G4cGOTk4vbfxuedRSK7ir/uStL8eVuj1SdezZ67OOKki1ZA30WsbkYhfVRYCqrd5P
	 HWCmMCQcTRkqnnClHuiXbKCxwMDFpvNcwSFfcCxutpmsp5zil+sel+G6VpvttH35wC
	 w8WuZ868bPJMM94/7QZLKV16sEH0g0nz+93zsjvESnUGiJSgXWWbHMJIyOC6bcZcW5
	 2bymkc+HNdJzHGBgskhzHVVVBYxxMP4tTgnyDLa3hgJWUk/bA8UebZK6r6qKB7QyuO
	 UqYWyNqg7s0zjpskvniKAnwovBU+AJmvk/GCZV8JFD8N9rO9lBIFJBRvnhegOstdqo
	 rBo86YPrVbqxg==
Date: Wed, 22 Apr 2026 11:09:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gye976@gmail.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lars@metafoo.de
Subject: Re: [PATCH v5] iio: buffer: fix warning in requesting threaded irq
Message-ID: <20260422110940.261e9083@jic23-huawei>
In-Reply-To: <20260423014426.1999735-1-junxiao.chang@intel.com>
References: <20260423014426.1999735-1-junxiao.chang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 09:44:26 +0800
Junxiao Chang <junxiao.chang@intel.com> wrote:

> IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
> handler, this flag should not be set.
> 
> This change fixes a warning during booting with kernel v7.0-rc3.
> Hardware: ARLs(Ultra 9 285) desktop
> Software: Ubuntu 24.04 + v7.0-rc3 kernel.
> 
> WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974
> Call Trace:
> request_threaded_irq+0x2c7/0x490
> iio_trigger_attach_poll_func+0x353/0x6b0
> __iio_update_buffers+0x2420/0x2c70
> enable_store+0x183/0x270
> dev_attr_store+0x5e/0x90
> 
> There is no threaded handler in thiggered buffer setup, e.g. vf610_adc
> and hid-sensor. They might introduce this warning.
> 
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Sashiko just did us a big favour:
https://sashiko.dev/#/patchset/20260423014426.1999735-1-junxiao.chang%40intel.com
I was making too many assumptions on what the vf610 driver was doing.
The issue here isn't in the core at all (though maybe what you are fixing
here is relevant to other drivers) it's in the vf610 driver. 

It registers a triggered buffer, but not trigger and yet actually pushes
the data from the interrupt service routine.  That is fairly nasty misuse
of the IIO infrastructure.  There are two ways to solve this.
1) Rip out the triggered buffer infrastructure and use the buffer directly.
If we need to 'pretend' that's still relevant use the same approach we used
in the hid sensors driver to keep the current_trigger interface (it just
won't do anything).
https://lore.kernel.org/all/20260220224514.471348-1-srinivas.pandruvada@linux.intel.com/
2) Actually implement a trigger. Then the isr will call iio_trigger_poll()
and the vf610_adc_read() will occur in the trigger bottom half with timestamp coming
form the top half that is currently registered.

I'd slightly prefer option 2.

Any idea what trigger your userspace is trying to use with this driver?

No idea if you are up for fixing this - if not I can have a go but have no means
to test that the driver isn't broken.  I don't have time to emulate this device
just now.

Now that's not to say there aren't drivers doing what I was assuming was happening
here (having foolishly not checked the particular driver) and registering only
a custom top half in the poll func.  For those, your fix would be the correct one.
I'm just not sure they exist.  Maybe we can merge that anyway on basis there is
a latent bug that future drivers might hit, but we should also fix the vf610 properly.

Jonathan


> ---
> V4 -> V5: remove Fixes tag and add back change log
> V3 -> V4: remove unneeded backtrace log
> V2 -> V3: remove unneeded log in git message
> V1 -> V2: use ternary and drop temp variable
> 
> V3/V4: https://lore.kernel.org/linux-iio/20260421103807.7ca935e9@jic23-huawei/T/#t
> V2: https://lore.kernel.org/linux-iio/20260418002334.3643504-1-junxiao.chang@intel.com/T/#mc0803722dce6585bbc8c9e0ec8289bd96afe99aa
> V1: https://lore.kernel.org/linux-iio/20260418002334.3643504-1-junxiao.chang@intel.com/T/#mf0eba6c23049d15c2b43ea5528b5f5a47e216c58
> 
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 9bf75dee7ff86..40eea3a447246 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
>  
>  	indio_dev->pollfunc = iio_alloc_pollfunc(h,
>  						 thread,
> -						 IRQF_ONESHOT,
> +						 thread ? IRQF_ONESHOT : 0,
>  						 indio_dev,
>  						 "%s_consumer%d",
>  						 indio_dev->name,

