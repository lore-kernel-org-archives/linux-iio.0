Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4C3101B6;
	Fri, 25 Sep 2026 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790306011; cv=none; b=HUk8ax1TjUOU46xECbdvDEdr0TrIO7jVpvL66Hp5RmzYrNDhqgSSdoqEe9rWLHR6aYVaPQiVUb6RSlb2nd1SQ4x08EYSNcbchobuVsFa8/o6UJhad+JEjHbrvH9PIhJ1iatpXjJnxCoh6zMZ2OHZvufy7qtUsf3p1XOjZQqc2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790306011; c=relaxed/simple;
	bh=T32/hjgORTXsuMbRW8Zkp2AeUJQZyw698e6PwAdRKlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4dm9vdixLDOsHewRCqotSfGWtGDq5nut+swYMW924vBZM1tAhVAskPUtrStk51ORj+OvIEoBPyFNOJzsWfn8UtT8sAP0XQa4W42shtbkhwXxtZJ+cCSjPxq842+vbOhd3E9PFAhuwfgqKl/5jllaeSESXWiTAguuYG327JDyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgGXXrFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgGXXrFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D931F000FF;
	Fri, 25 Sep 2026 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790306009;
	bh=zWZpOHbrH1ynze092c7hjoCL9rCDDiHK3exAqFp1cns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fgGXXrFW6On3qVsYRcFztHK5sR6Gzv9CffQqICfr7IDvnDcp6ZukGGw1D2ZTZPNzM
	 K6Ui0zvKU91/VOMImec650GtrE7p+g9VHveW01vT0iBzhngnCSfcfWHV1lEzVcIYW5
	 SjirHULhgS4U+PYXsepHRNSAjd1mDfwnHWB8vlhSvljP8SJv3Cm9at+0S8xAk9rEtB
	 M4QJP4KZ6AdI3uMbIalk9P0y0+TkZld39oNbwg5gpVQAwMxL3b5l8U9R603EKsY+gV
	 zEjT8k8vI1gU6DwR46lLvQQk4RXyiqs02hO+Hnq5+pBG0PXSku6Etgri4u08gBj9OE
	 r1sBVpzuQ49JA==
Date: Fri, 25 Sep 2026 04:13:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: adc: add support for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20260925041325.0efac345@jic23-hlaptop>
In-Reply-To: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 15:14:14 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to determine
> power consumption of portable systems. The driver support getting the channel
> voltage and accumulated average power over an I2C/SMBUS serial interface.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Hi Neil,

As pointed out too fast for a v2.  You aren't new upstream so
that shouldn't come as a surprise!

Secondly for devices that are all about monitoring power supplies
etc we always ask for a clear statement of why IIO rather than
hwmon + to CC at least the maintainer and often the hwmon list.

There are various valid reasons for that choice, but it is good
if they are clearly stated for discussion.

Thanks,

Jonathan

> ---
> Changes in v2:
> - switch to shunt-resistor-micro-ohms no more required
> - removed gpio.h from example
> - Fixed max34417->MAX34417 in Kconfig and comments
> - Added missing includes and remove unneeded
> - Fixed typos in comments
> - Switched to fsleep()
> - Better aligned max34417_read_power declararation
> - Handled 0 acc_count
> - Switched to GENMASK_ULL() for 32bits systems
> - Added missing empty lines
> - Moved the input correction into a helper
> - Set default input correction for all channels
> - Switched to dev_err_probe() to return from probe
> - Switched to device_for_each_child_node_scoped()
> - Handled invalid shunt-resistor-micro-ohms value
> - Link to v1: https://patch.msgid.link/20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org
> 
> ---
> Neil Armstrong (2):
>       dt-bindings: iio: add: document the MAX34417 Four-Channel High Dynamic Range Power Accumulator
>       iio: adc: add driver for the MAX34417 Four-Channel High Dynamic Range Power Accumulator
> 
>  .../bindings/iio/adc/maxim,max34417.yaml           | 100 ++++++
>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/max34417.c                         | 374 +++++++++++++++++++++
>  4 files changed, 486 insertions(+)
> ---
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> change-id: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb
> 
> Best regards,
> --  
> Neil Armstrong <neil.armstrong@linaro.org>
> 

