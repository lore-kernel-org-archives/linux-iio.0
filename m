Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5E3B71C6;
	Sun,  2 Aug 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785690899; cv=none; b=If0AGt8aDgxu1pFSySfasq9eRR8fW5JRCA9yxu9cxPTVZKeOmoNTZCKiEZT7d3mS/YxYMfH4fAGIZe9pVGA3KZ3gEAKEngD8kjcAfYRTGr9iLPtVGKPTODN7pHSa9O+iMGdopZNUN9aQrNk/MhsDYMJimZ3GYOphUyPMtTsz1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785690899; c=relaxed/simple;
	bh=bJQPRPnBwrNvzbWdDn8UdEdCIN4B45DhUiezXv0/AJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDPpTYrxHk5IUW7YIcojkKNEP9OVv9GdXVwvSYu5ZCXhQyd7DYJUbi6gBjAJqX4x1KXwV1axGfBwqoLSTUotz0ZevzwDKFLJ/R8PgIB9o7ZWHZ9svgSD89la8IAQH+0ydL7EoPcEPXIJbHiISU1JxFPVLblQi8XU6BlEGwEkaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWrVek5C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWrVek5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D881F1F000E9;
	Sun,  2 Aug 2026 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785690898;
	bh=+mWb9cxgHPz89lNbjczirAai50Pbwj8bl52HCnd6Rkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jWrVek5CNAmiu/Ep0+4YSGNPFfclgUaR+gEFLo4HXhr7TuldekpJ2QKIFh8BdR3YF
	 bT4TZqVyDJzl70epD6+EeDK+WO2rH/ivMNjZz9z/SLWszgd20NVRxYYnsnmrYNrRH2
	 7Um2OwtYGqgTacLw+XoT4Cxyi8KgjICsJUyr5hNwQAP+B2m0ymrT8IX7QaTO7c1w7e
	 s4qJUe5nYb5WMwmxiJoGSiVYC41i3TvgEdy0KzpCzf5BXdw3XUcXqT+PXne5zPIppL
	 gJPkxLJDRGpzxGi+0GdyD4unFMz5gaxkIqlcTrcdveo0Zb3knyxzxLiFfnJIXDHA8w
	 dOAXumtRHyKLQ==
Date: Sun, 2 Aug 2026 18:14:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: hts221: Fix checkpatch symbolic perms
 warning
Message-ID: <20260802181449.12b7e117@jic23-huawei>
In-Reply-To: <20260802014945.17221-1-adinata.softwareengineer@gmail.com>
References: <20260802014945.17221-1-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 09:49:45 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> Checkpatch warning:
> 
> WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, S_IRUGO,
> 
> WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, S_IRUGO,
> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>

Hi Adi,

Rather than doing this minor change please take on making these
report via the read_avail() callback.

This is a reasonably old driver, so some of that infrastructure may
not have existed back then.  Moving to the callback makes the
available info accessible to in kernel consumers and ensures correct
formatting etc.

To make that sort of change you'll need to work out how to test it.
Probably just commenting out accesses to the device and reading only
the files you are affecting will be enough here.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hts221_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index bfeb0a60d3af..bad98da100bd 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -521,9 +521,9 @@ static int hts221_validate_trigger(struct iio_dev *iio_dev,
>  	return hw->trig == trig ? 0 : -EINVAL;
>  }
>  
> -static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, 0444,
>  		       hts221_sysfs_rh_oversampling_avail, NULL, 0);
> -static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, 0444,
>  		       hts221_sysfs_temp_oversampling_avail, NULL, 0);
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hts221_sysfs_sampling_freq);
>  

