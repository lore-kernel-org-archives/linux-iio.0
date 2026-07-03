Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE62AE7A;
	Fri,  3 Jul 2026 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783041428; cv=none; b=DbRLLKHv1kc1pOZ6UPVTYWF/5o/7chhJKYdzC3FI2dff9jUBe+jiouzSOEgl06nqc34PWqVH431DCpxEC8llVVCreE3mbc3f2aGU+uDfOo1ZBD3ePeHdHIzZqVBO4Z+glfMoIMgqOK7ofEeJSsLcktkK6WqBQe8a67OFgGF8B8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783041428; c=relaxed/simple;
	bh=3y7fpKrE1/gOembclcsTWEzP9WVWSnAAmk+pJ9dlyT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtlfBGGOsrn9W8XSv/b3kNUHrRUaD4jBpXHlmei4Ex8dayD2U3fLnP/xiNLRAtk2uzw+ccy1d1kp8MARTV3Hv9jsr+oZc3DMsNfqx2sdXkiGMpIajFwtE8Nb7MLMBzKHtoTN996vqNoqHToJLncJMTCYmPz+qOKEBZrx+Yg56WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZDh3mes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZDh3mes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC821F000E9;
	Fri,  3 Jul 2026 01:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783041427;
	bh=jwclxt76G1zp/pi/Ab8M/JfxTSuYHD3BXwuzx/hA5dI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZZDh3mesisJgiWwnv/aefMmFVJluE7LhF1tuscFHf5V8ru5h3SJwFrlA6cMs/otYF
	 vzQZMzcG1nzFyEqMYuotB8g7g/vGzvdmU8wmDOBUHasKiT/hn/Qgp27/T1zGf3Ezy5
	 RhJEps5G10Y3FFCSnVkIZ5msIMlBVxTIcnUJGW4moAENsIP/Kq4d/sWOKKLq8PcbZG
	 8L1q+reVbtaYunOBkgB+gpbHN5QTyqnlkeLqNkmCF9e1lKsTnYYXjhh8KtbhXy0/DG
	 L3JYrLym5xldFy7ky653yjU4kMU9PkKIHVw6ZGn+2OGV4AdkD4cPY0cz65HwOwKuXW
	 cqOh0fYTNiW2w==
Date: Fri, 3 Jul 2026 02:17:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 01/16] iio: ABI: add attributes for altcurrent
 channels
Message-ID: <20260703021700.0d4803d6@jic23-huawei>
In-Reply-To: <20260618-ad9910-iio-driver-v6-1-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-1-79125ffbe430@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 14:27:17 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add missing attributes applicable to altcurrent channels, e.g., frequency,
> phase, scale, raw, label and powerdown.

I 'think' these aren't missing until this driver.  The only upstream
altcurrent channel I can find is modified as it reports RMS so would
be slightly different from these.

Maybe word that to say they will be used shortly.

Jonathan


> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d8d6d85235b0..f52db6abcf31 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -478,6 +478,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
> @@ -798,6 +800,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
>  What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_powerdown
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent_powerdown
>  KernelVersion:	2.6.38
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -808,6 +812,7 @@ Description:
>  		together.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency
>  KernelVersion:	3.4.0
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -834,8 +839,10 @@ Description:
>  		all the other channels, since it involves changing the VCO
>  		fundamental output frequency.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_phase
>  What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_i_phase
>  What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_q_phase
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_phase
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_phase
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_phase
> @@ -1735,6 +1742,8 @@ Description:
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_raw
>  KernelVersion:	3.17
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -2125,7 +2134,9 @@ Description:
>  
>  		Raw counter device counters direction for channel Y.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_label
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_label
>  What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_label
>  KernelVersion:	5.8
>  Contact:	linux-iio@vger.kernel.org
> 

