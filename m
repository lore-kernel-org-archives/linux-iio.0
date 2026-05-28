Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D03B38B6;
	Thu, 28 May 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963622; cv=none; b=mu0RbX/PZg93c6cjvJc/JD+6r5aGWDrTv/rIr1armxbY6n8UFhuRjKtJYdK5o+rcXC7vfTQgSUb/KxhWQBezWS7kcsCqYXpHye/5/L8wvvnMMn+mRo1O0mbuW4L+jBTe08mHtz9o/ToIdVp056OLLPbBhaoSzlBpus+B+dofFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963622; c=relaxed/simple;
	bh=9c3bx3l3uN5X27F1yj0iv49/R8e1FXz67g6B4Y2czt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tel7ottudkzwctzQQydfhNXJ7ywDuS4NUf3bMogyjwO8mLHmjXm7jyN420iVxxwTgXlS1dhso1Y3wT9uIV/gQMtSsSqRcCt4YHyiDrgUGKlOIDxWZR0avlM0xWI6YpPRyS72K38KD6UPk1h2X00Op+h672QEAbrGNiD8zAFH/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+F9l75+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+F9l75+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378D41F000E9;
	Thu, 28 May 2026 10:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963620;
	bh=c48CAYeqbThyDJCOi9W0O58Zeg18ossC+geHbjR5F+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R+F9l75+zKZaW5C/tf1wNdXvLTRI9nNWtCvkWsfU18/wQV23F+WQFHL1fa4WyhtJS
	 cqU6mpMQF5vyTwORB2fJE9lK/XJUHwHfj1ETFa9Oe1dupONB7mxEzvvm8r12lI8ODw
	 swSmkYwv/KXMTW4+t8g0lZwzucSwLxmIWC6XknFAe6X7lKk3Khozkpykbsaj37GQVf
	 E1NmPdf+uNNvfdebG1c/8t+Ed7emZ5t5Wcnomo4G2bAySKNhhDDqj/UlE1YCKBrnOp
	 W9773ROuqOpSd5zgrkXnxNjGU8mDwmmoFaPPr7+vKo8d+gRVfaGecHHMA93yBTCL8r
	 bv9HRqijYm5rg==
Date: Thu, 28 May 2026 11:20:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck
 <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Andreas Klinger
 <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-hwmon@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <20260528112010.44b0c9aa@jic23-huawei>
In-Reply-To: <20260527184257.141635-2-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260527184257.141635-1-wafgo01@gmail.com>
	<20260527184257.141635-2-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 20:42:52 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Add a new IIO channel type for liquid volumetric flow sensors.  The
> unit exposed via the standard _scale attribute is litres per second
> (l/s), so drivers reporting smaller native units (e.g. ml/min) only
> need to set a fractional scale.

Hi Wadim

You (I think) raised a useful point in v1. Given the SI units thing should
we actually be doing m^3/sec? for this new type? That would be more
inline with existing units including distance.

There is a slight inconsistency for Ph which is log_10(ions per litre)

I'd like more opinions on this as I've made some less than idea decisions
on units in the past!

One other thing inline.


Jonathan


> 
> Update iio-core's name table, the iio_event_monitor whitelist and
> the sysfs-bus-iio ABI document to match.  The new _scale attribute is
> folded into the existing shared _scale block; only the per-type _raw
> needs a fresh entry.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Andreas Klinger <ak@it-klinger.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-hwmon@vger.kernel.org
> Cc: Maxwell Doose <m32285159@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5f87dcee7..2188557cb 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -507,6 +507,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale

I'm going to assume this driver only uses one of these.  Generally we only introduce
stuff on first use, so drop the one you aren't using.

>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -2458,3 +2460,12 @@ Description:
>  		seconds, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw
> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled) volumetric flow rate reading from the channel.
> +		To convert to standard units (litres per second) apply the
> +		channel's _scale (and _offset, when present).
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

