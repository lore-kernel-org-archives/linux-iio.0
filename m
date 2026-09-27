Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4C37A836;
	Sun, 27 Sep 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535037; cv=none; b=msSIyjyny87IEAgaGmKGDd0Zcmo8oN5a531QmTwGyhUROFLBfwVfWTnEHNPfrnJADHUFKYex7pL48u+tQUD7ZttttUQ0vsV9wmzLgYbKPQiFsfUNaVXo5LgVTbMrKm1aprzxbSqjiZdd9UXvg0vZoZg6rqmaX6xymKANptAWHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535037; c=relaxed/simple;
	bh=UKNYa9ZSG/OBNMys2hkF5ktchZLmYh2lrz5mGoiWWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyK6AkqldZLcDqfZaBvsr6bEkd4cePpuJeGwpEmD4ZAXifdA7whM7DItu/pUPKlMRmb4kBDpkqdYc+sRDDN9q5u9WjbD+Ekwx8Y2gfGvB9ZyLLJ2I9Sqh0XhcQdp87DgH9+p0w1xlY/S17S+vppSs00nMlQ1dStL85NT8rmkt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKtyLJVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKtyLJVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A2B1F000FF;
	Sun, 27 Sep 2026 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790535035;
	bh=2g1rELljeb6OqpXn8NQ7+2fWd4KTyBy8V9aLvSvhl8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YKtyLJVKctTbRrYtkvEbhMhGbIcQ/ofufv7FnWG1L53/DZC+WkPsfIoRPbdINNIua
	 LJy3kUrLJXk737L4VYOP1Klb6j831rdV/W3jYDGVMg3pQDTJ1rYey+Cc7gBJXYPH02
	 lh/pcUtDHxFoc9TYUABLFt+P7QPJNyiP19/BCO2dbEtVlA675+PLa5+hZUu6R+V/zE
	 sZIWDyAoudAQhyE1aezoMhQOJE2vYbhsTlwg1gKYbWMEiNheWnpRT6PqFbXYWPjONh
	 SERfy+JBkcgMd8UdOVKqGb4pCtkrsHD8m54a8nmxm4ofspaMfcmYE9HUyNYtJe6vui
	 MBGLtVSli8jaw==
Date: Sun, 27 Sep 2026 19:50:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: adc: add support for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20260927195030.6c210d90@jic23-hlaptop>
In-Reply-To: <9be6cfd1-5cb6-4437-b253-1590292b8cbf@linaro.org>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
	<20260925041325.0efac345@jic23-hlaptop>
	<9be6cfd1-5cb6-4437-b253-1590292b8cbf@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 10:12:32 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi Jonathan,
> 
> On 9/25/26 05:13, Jonathan Cameron wrote:
> > On Thu, 24 Sep 2026 15:14:14 +0200
> > Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >   
> >> The MAX34417 is a specialized current and voltage monitor used to determine
> >> power consumption of portable systems. The driver support getting the channel
> >> voltage and accumulated average power over an I2C/SMBUS serial interface.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>  
> > 
> > Hi Neil,
> > 
> > As pointed out too fast for a v2.  You aren't new upstream so
> > that shouldn't come as a surprise!  
> 
> Yeah sorry, but with the initial feedback v1 was far form beeing
> acceptable, will adjust timings for next versions.
> 
> > 
> > Secondly for devices that are all about monitoring power supplies
> > etc we always ask for a clear statement of why IIO rather than
> > hwmon + to CC at least the maintainer and often the hwmon list.  
> 
> Sure, thanks for the suggestion.
> 
> > 
> > There are various valid reasons for that choice, but it is good
> > if they are clearly stated for discussion.  
> 
> I don't honestly have an strong opinion on that, for me IIO offers
> much more options to retrieve data from the sensor and adding the
> complex feature offered. The IIO triggers for example would
> perfectly match with the bulk readout we coulnd't implement with
> the hwmon API.

Ok. Just lay some of that reasoning out in v3 and include HWMON folk
and see what they think.

Jonathan

> 
> Thanks,
> Neil
> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >> Changes in v2:
> >> - switch to shunt-resistor-micro-ohms no more required
> >> - removed gpio.h from example
> >> - Fixed max34417->MAX34417 in Kconfig and comments
> >> - Added missing includes and remove unneeded
> >> - Fixed typos in comments
> >> - Switched to fsleep()
> >> - Better aligned max34417_read_power declararation
> >> - Handled 0 acc_count
> >> - Switched to GENMASK_ULL() for 32bits systems
> >> - Added missing empty lines
> >> - Moved the input correction into a helper
> >> - Set default input correction for all channels
> >> - Switched to dev_err_probe() to return from probe
> >> - Switched to device_for_each_child_node_scoped()
> >> - Handled invalid shunt-resistor-micro-ohms value
> >> - Link to v1: https://patch.msgid.link/20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org
> >>
> >> ---
> >> Neil Armstrong (2):
> >>        dt-bindings: iio: add: document the MAX34417 Four-Channel High Dynamic Range Power Accumulator
> >>        iio: adc: add driver for the MAX34417 Four-Channel High Dynamic Range Power Accumulator
> >>
> >>   .../bindings/iio/adc/maxim,max34417.yaml           | 100 ++++++
> >>   drivers/iio/adc/Kconfig                            |  11 +
> >>   drivers/iio/adc/Makefile                           |   1 +
> >>   drivers/iio/adc/max34417.c                         | 374 +++++++++++++++++++++
> >>   4 files changed, 486 insertions(+)
> >> ---
> >> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> >> change-id: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb
> >>
> >> Best regards,
> >> --
> >> Neil Armstrong <neil.armstrong@linaro.org>
> >>  
> >   
> 

