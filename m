Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB8430C618;
	Sun,  6 Sep 2026 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658886; cv=none; b=jlWZw5oO66vYis9Z3fpt4EDio+5u/7iPaWdnMO65I7z4gKId95nM9NEURHUOpa51Sl7CJxf2COB9ufKfLDkcg3/IqPnXhmrH1sZ/wSsL67gP/o2T0IQBSviFY8MjwiFAQ3ekHPgeaBYX7MDvHL/T5CaRjj3Fyeu+RVzDntmkrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658886; c=relaxed/simple;
	bh=wBn+RPBD66DE4XtSVWIYB4Hg1YYjMjcP2taQPKPYJM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0vWxd/NuiO/0wYLsFfTxN138qf1XJaoSTnmx+ZnalSS4Mz6bNPWtKiJi6RYBFJtQZG45XUfmRikHUsa1u+TIy4N06s9Hb7egIGxqDrNMOAOll/NvugQySFQg6nLsQkNFo+BxzVL0G1YUgCOEwFQfZ37gpb4SOsb4GXT9isrJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMg5kz1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMg5kz1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C61F00A3A;
	Sun,  6 Sep 2026 01:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788658885;
	bh=Vvw4uC3ADqP3m1Y2DpiU1raTJp1h8zMJUxu2QyRZaY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fMg5kz1+3TaXgxIDdpa/JsssJ+pwMttUldcyTKeqQKYECw32U91gqt2wkGAiQLe7z
	 fA+fi6iO3DkWX0Sgwg/zmW278Ewp8hH7MM976SFzAY6R4mCDWRYzj9/qEtWzOQgcoF
	 mYaibh17deVlHC7mcZaHoZEzqye83a5xEHZyEpNgHDGXmambvn8vIbcQ1Ml0Nj5mFb
	 uq9ieS4+ikI/JYuAUrldtJL5IJObJDJdMOUleqWS0oQGpJ1ZynQQwA00WmDXyqVUbF
	 T8VZViYZGksb+fOao9prvXfgvzW6FWCQXvLtEUdevhQC07dWELns1+56iBYKy0IXsh
	 Df49eIKt7BRXQ==
Date: Sun, 6 Sep 2026 02:41:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] iio: ABI: add settlingtime attributes
Message-ID: <20260906024122.5c434b32@jic23-huawei>
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-10-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
	<20260904-iio-adc-ti-ads112c14-filter-support-v2-10-f86592360658@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 17:09:55 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add new generic attributes for input settling time introduced in the
> ti-ads122c14 driver.
> 
> Usually, in IIO the output data rate is 1 / sampling_frequency. There
> are known devices (generally ones with filtering and oversampling) where
> the first conversion takes longer than 1 / sampling_frequency to allow
> the input to settle in order to have a valid conversion result. Then,
> any subsequent conversions in a continuous sampling mode would be done
> at the regular interval defined by 1 / sampling_frequency.
> 
> This attribute is intended to allow controlling that settling time
> duration.
> 
> A device that has input chopping enabled would see this settling time on
> every conversion since the device setting (i.e. the input mux) changes
> on every conversion.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
One query inline. I'd like a bit in the commit description on that
mostly because I'm failing to remember the answer and there isn't
an obvious right answer.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a8e1cb8e7490..045589058655 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2402,6 +2402,32 @@ Description:
>  		Specifies which filter type apply to the channel. The possible
>  		values are given by the filter_type_available attribute.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_settlingtime
> +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_settlingtime
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_settlingtime
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_settlingtime
> +KernelVersion:	7.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Set/read total settling time in seconds for a device to settle
> +		after starting the first conversion after any settings have
> +		changed. The data for the conversion is outputted at the end of
> +		this time.

This probably came up in earlier discussions and I've forgotten it but why
is this not the difference between the time needed for first sample and
that needed for subsequent. That's the only bit that is settling related rather
than acquisition time.

> +
> +		Depending on the device and how it is used, this settling time
> +		may apply to more than just the first conversion, e.g. to every
> +		conversion in a single-shot conversion mode or when a device
> +		setting changes after each conversion (input chopping).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_settlingtime_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_settlingtime_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_settlingtime_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_settlingtime_available
> +KernelVersion:	7.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Available settlingtime values in IIO range or list format.
> +
>  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
>  KernelVersion:	6.6
>  Contact:	linux-iio@vger.kernel.org
> 

