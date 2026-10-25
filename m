Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792969675;
	b=Ygu16EJ3xJ+WiQoCDpQqMtvhHRYdNBt3BWw3lUrN6bxFPoEhJiwz+VgaN0oEo2YZkpNP
	 7smPOvhL9rtRvq5ouE3Q72y/YMKvS9w5kLp877ICitBZX694rVDv24XgT0FqXwQU1HQDY
	 JvN4kALsFOtJl6/B5Hte7UXGSHVuuh5L720KqihyAgQNohJ7ZuC1aDuLDg0RdDsgUjNO5
	 WaZubSLNCBk1Iaf3uqypTR2gBeyXyeIB/jZle0XXDM6q2PPEOoo/FCv9APnIW1s4iCyhG
	 qPqUZcxiJz9YnkK/wqeX4zF1XoZOqH0/l8ZSlO0JfQMz3jvc4Z502OAhTlLopVJsnxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792969675;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jsgwf9WxiWZdmsH5Xo9Oq04atBIwspMffogmcSjWqeY=;
	b=L8i6ZW5H8oTZQHQeOD9jKxcBRfW3u5KDd5QQtB4grAIJZLEmSLZhun6fiulSw3JyM7Qv
	 A9Q3ySRUqEaXj6Zt3loOwewbAqPQav/lUXG/s3GPra7J0liRfDzrKBQ8ZfPIrC1lL9MWu
	 2UB4hfT/c+1PRBqO5RY3qPw7KdYfE71E1pRRXjj+a1YVFrmnUJZ84+E7YZAqjXXfBa5+7
	 KxUHjlmAr2pZtgSWY4GQPEYDrTKfdVyy5LHc/RyG+Xf1zpK31VWuo+KksFgW6pNv+H9Ov
	 0uFTo2s2AVXP+WtDOaPSQy+xsw69zH37wIuENSQU+kvX/ykvpUoOdbD4aPBrVQD/yMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHzh3czY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB2606A31A;
	Sun, 25 Oct 2026 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHzh3czY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308351F01825;
	Sun, 25 Oct 2026 23:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792969674;
	bh=jsgwf9WxiWZdmsH5Xo9Oq04atBIwspMffogmcSjWqeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OHzh3czYyt0IlTTXun32ixVlFpCZUZNPZNeTa+oxseDP0BCFp761LRENdT+2zMo5Y
	 qRCPcN2uv/Euh1VBQuS1+8I7XmJmrpqQjyhiNuiHK9k7mQfo9x48K9T3PCDXqcDxkP
	 s4Omc1POiXEGPHDIlBe9LynZpaazVZKVni6SP+FyWH5bnl2ICZPQpzcT7l0B0YQZrf
	 uHDgk5HA4h5KlI3tUUnm6Yuub4XNMnsS9gpEFg0EHbOy8HoYsunoLQoU9pv5GBozgF
	 tSGlhY2O7eVYAfmKV4rO2UoGxcO+HljPK+N/PvLgE44wp9qlNmyVdUkahV0bVmaU/U
	 a/Z9XZLlpwXYg==
Date: Sun, 25 Oct 2026 23:07:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: adc: ti-ads1298: fix power-up and clock
 handling
Message-ID: <20261025230748.38e228db@jic23-hlaptop>
In-Reply-To: <20261024231335.280955-3-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
	<20261024231335.280955-3-stephanbrrs8@gmail.com>
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

On Sat, 24 Oct 2026 20:13:31 -0300
Stephan Costa Barros <stephanbrrs8@gmail.com> wrote:

> Fix three issues with the power-up sequence and the device clock:
> 
> - The datasheet powers up the supplies first, then the clock, then
>   waits t_POR = 2^18 clock cycles (128 ms at 2.048 MHz) before the
>   reset. The driver enabled an external clock and the vref supply
>   before AVDD, reset right away, and did not wait for the 150 ms
>   start-up of the internal reference. Follow the datasheet. Probe takes
>   about 280 ms longer.
> 
> - The binding describes one optional clock and no clock-names, but the
>   driver asked for the clock named "clk". With a device tree that
>   follows the binding, the lookup fails, the optional getter returns
>   NULL, and a clock given in the device tree is never enabled, while the
>   sampling frequency is computed from the nominal 2.048 MHz. Ask for the
>   first clock of the node; a device tree with clock-names = "clk" still
>   gets the same clock.
> 
> - A command takes 4 cycles of the device clock to decode, the minimum
>   reset pulse is 2 cycles, and the reset takes 18 more. These were
>   converted with the nominal 2.048 MHz, so a command ends after a fixed
>   2 us, short of 4 cycles with an external clock below 2 MHz, which the
>   ADS129x allows down to 1.94 MHz. Convert them with the rate of the
>   clock in use. At 2.048 MHz the delays do not change.
> 
> The clock lookup was seen to fail on a Raspberry Pi 4, with a
> fixed-clock in the device tree. The power-up order was found by review
> and reproduced on an emulated device only. The decode time was found
> with an emulated device; it is not seen on hardware running at
> 2.048 MHz.
> 
> Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
> Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
As before, this is multiple issues so needs breaking into more
focused patches.  That may come at the cost of some code
churn but it will make them easier to review.

Jonathan
