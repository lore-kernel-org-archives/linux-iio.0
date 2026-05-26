Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40637F739;
	Tue, 26 May 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812042; cv=none; b=Fg1sYxhI9mFPGOpW8Oy3qBxfXthKspNN0/swPXjNRl39aum8qzNyOhH3DyPzpRes3zqSwHNzh27VBpgPXD//TPlnQ/cQxaW9YrXOHMqs1j64saRPdCU6HkJtzE5DLoM4EMtK/hh8Z+FEOjoC22LqcKdm119sfyaBlcrHw0ir+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812042; c=relaxed/simple;
	bh=VnPqzbv7llruyXvOI6GeydA3bx3LlC/uAq+YVptJWA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auD3Hi7ucXZkA1U0mqxZQFiFibFYh/lA3n/SzSeqDe1q1C5bnM0/xB2bYx0PgPy+lMuCBppXbh9PLtTpZwdvetzF1OnFwvLlniWrQETofw73/4YN+KGaexhpMI9YYlKuMdv9/p4RnRPbjK7lxVPryoJnwV4JHy3idh8DSjKly0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE8Fz7NY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE8Fz7NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91281F000E9;
	Tue, 26 May 2026 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812041;
	bh=MzePDLcEoQr1fqJhp+P7M1pmUvqw+V25ZA+ZRLQHkQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gE8Fz7NY65W8xILq1ILPkswg+WLZJYPN+eFKEFEYCQb5xpwAeZDa6iAX/pylzun8r
	 hg9cFy10ul90oqeotDqDmPlsPamcbkaPsmg5MM/rJEHJcUYMxQJQql3rH8yuDcn45O
	 VEpC0TinDmFkJPXubVKgHOeVe0PFkgqvkc7uvUGLCN7tuzhNJsGIbEU2X1fsTNUJ1O
	 FXBh0b40ALuzjKYRBq1J0rugkkhNJ5Yau+pyTbbtokrDFyQ2BSP60rc6YHLnKoeg+z
	 8r8I5WVAv2WIjDlf/rIxAGoJNjS/2+9s3hiudGpdNSw0IS13u/YN4oiwz3KIHOV14e
	 aWk6X+ONbYPfQ==
Date: Tue, 26 May 2026 17:13:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@roeck-us.net, jdelvare@suse.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/4] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <20260526171350.6fadc595@jic23-huawei>
In-Reply-To: <20260524205112.26638-2-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260524205112.26638-2-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 22:49:36 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> From: Wadim Mueller <wadim.mueller@cmblu.de>
> 
> Add a new IIO channel type for liquid volumetric flow sensors.  The
> unit exposed via the standard _scale attribute is litres per second
> (l/s), so drivers reporting smaller native units (e.g. ml/min) only
> need to set a fractional scale.
> 
> Update iio-core's name table, the iio_event_monitor whitelist and
> the sysfs-bus-iio ABI document to match.
> 
> Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5f87dcee7..68eb703c1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2458,3 +2458,20 @@ Description:
>  		seconds, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
> +What:/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw
> +KernelVersion:6.19
> +Contact:linux-iio@vger.kernel.org
> +Description:
> +Raw (unscaled) volumetric flow rate reading from the channel.
> +To convert to standard units (litres / second) apply the
> +channel's _scale (and _offset, when present).

Formatting doesn't match rest of file at all.

> +
> +What:/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
> +What:/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale
> +KernelVersion:6.19
> +Contact:linux-iio@vger.kernel.org
> +Description:
> +Scale factor applied to raw volumetric flow readings to obtain
> +the value in litres per second (l/s).
I'd just add this to the big block of existing _scale.
The units etc are all covered in _raw so we don't need to really say more than
this exists.
 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 22eefd048..aa34fcd8e 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -98,6 +98,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_CHROMATICITY] = "chromaticity",
>  	[IIO_ATTENTION] = "attention",
>  	[IIO_ALTCURRENT] = "altcurrent",
> +	[IIO_VOLUMEFLOW] = "volumeflow",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 6d269b844..49480f321 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -53,6 +53,7 @@ enum iio_chan_type {
>  	IIO_CHROMATICITY,
>  	IIO_ATTENTION,
>  	IIO_ALTCURRENT,
> +	IIO_VOLUMEFLOW,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 03ca33869..078004750 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -65,6 +65,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_CHROMATICITY] = "chromaticity",
>  	[IIO_ATTENTION] = "attention",
>  	[IIO_ALTCURRENT] = "altcurrent",
> +	[IIO_VOLUMEFLOW] = "volumeflow",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -193,6 +194,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_CHROMATICITY:
>  	case IIO_ATTENTION:
>  	case IIO_ALTCURRENT:
> +	case IIO_VOLUMEFLOW:
>  		break;
>  	default:
>  		return false;

