Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2E1F0994;
	Sat, 31 Jan 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769863464; cv=none; b=auNQL2TNYwHLAuVIoHwBKk5cDcqyLKpyHQK+CoHK0aZ/DeNoINH6ryxlI+ny2f0ZqHtN8I8A+M1jNdTgYizZqBXeUkqQgQ1xpo352XQI5TFQMFSmhFI55fnYtelMiUl8GbYah2GrhiychdyJ0Nwmgp0nvlA8jkI6PgOAS7CjE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769863464; c=relaxed/simple;
	bh=j4jSBMN6WpOBjy0Z+2YjSWPh90OcjoZ7EkRtPnNT98I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ektgeL2BHuREUupudXLjbMAZzsLajP0dRXqMArIrax3mrAsIcJw4T9ip29V2pBqK9YNKdVaZe4J7cEPLwfhfQTTtA0U26Qo52EI2Y+4siXkQuXqeIFCNLmqGUMNLfM/ebaUAYF0BQ03rzn3JzAAXh19t4NKrYKXVAGsg//DVDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2Op+nPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2Op+nPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EF6C4CEF1;
	Sat, 31 Jan 2026 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769863464;
	bh=j4jSBMN6WpOBjy0Z+2YjSWPh90OcjoZ7EkRtPnNT98I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2Op+nPBxySIhvV58TOwoXAthBkEk1qpBRvdW3lr3JIBCMw8AKLNLfaIqIox4O5Ug
	 sS+sB1DfnUTDWKo+37GPFHUTIYtAD9G+Qvn22sseJ6Ssq2dji/2FAioekdmsgS4Xh6
	 2tirJlgyp1KU2Bmq41yFjBdHv0qam0zo8sczrikVycRCWnfbNsLwKm/eFpidL7JcXb
	 Myt/4Aep3Scbh9fg6IrZqOZPNPdLsjMIItP+Kswe7Ekr8EeWyqLKqh1O3jLnLdYCGy
	 i8D5HJOzheMKX0dOuNDNgBP6N90kct+ZOnH5iD/FsHTmWh9aaK4B+tUr25IjjS50N+
	 wBbvDFR9RrvEg==
Date: Sat, 31 Jan 2026 12:44:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: fix use-after-free in
 viio_trigger_alloc()
Message-ID: <20260131124416.19576731@jic23-huawei>
In-Reply-To: <20260131092333.247931-1-salah.triki@gmail.com>
References: <20260131092333.247931-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Jan 2026 10:23:33 +0100
Salah Triki <salah.triki@gmail.com> wrote:

Hi Salah,

This is a definitely case of the fix not being anywhere as simple
as it might look at first glance.

> Once `device_initialize()` is called, the reference count of the device
> is set to 1. The memory associated with the device must then be
> managed by the kobject reference counting.
> 
> In `viio_trigger_alloc()`, if `irq_alloc_descs()` or `kvasprintf()` fails,
> the code currently calls `kfree()`. Using `kfree()` in this case bypasses
> the device's release callback and can lead to a use-after-free or memory
> corruption.

In some cases yes it can cause problems, but please show me an actual
path to this in the description. It should indeed be tidied up.

> 
> Fix this by calling `put_device()` instead of `kfree()`. This ensures that
> the memory is freed properly via `iio_trig_release()` when the reference
> count drops to zero.

This change is not sufficient and causes some cleanup to happen twice
thus introducing some bugs that weren't there before.
So take another look.

> 
> Fixes: 2c99f1a09da3d ("iio: trigger: clean up viio_trigger_alloc()")
> 
No blank line here.  Scripts that commonly run on the kernel tree rely
on the the tags block having no blank lines in it to avoid false positives.

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/industrialio-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..981e19757870 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -597,7 +597,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  free_descs:
>  	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  free_trig:
> -	kfree(trig);
> +	put_device(&trig->dev);
>  	return NULL;
>  }
>  

