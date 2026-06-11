Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2C331237;
	Thu, 11 Jun 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196638; cv=none; b=jEbMUUO8/0UkpbgyZr8v/P5piHk9qMjFa0rH0+slopkp447YEEV5k2MFmKmFyB7qWe73sBibx0iPxMHxDiArDY2hA4wlBPLXFSnaOXfQsg6WIp0ntY9cHlvwuy3LdjVKOAknqmCMmgzLUFtfzp0Rg2Mjl8ahTiiFUbJejDivLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196638; c=relaxed/simple;
	bh=U1KVKxjuvnfisihCAghWkQmgzGa5gGjhdBdcbOEWgMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH8aNRBBny2DJRDVg6+poOe3DDlE0WnVt/+B8OJlL2uJtfwRbbIrddZPHfmS2WW7HZziQnZ6KBsdw9bnSLumwJx2X8JYnsLyFnhOkuE3XIz3uyiYoiMnPBNh27VXyou+ae1h2RrqP4u+RXVSoElOOKpNYiompCJchkUx0yB3FZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7bkjSnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7bkjSnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D4A1F00893;
	Thu, 11 Jun 2026 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781196637;
	bh=OOi287tBYTHxEB/ky8DeBDCW9Y0nF8BKDZe9RcV5LO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n7bkjSnGxCKF2pXQOetFe0SAWTWgcSeKhOv07hI9NvpW9Zv+PU44TaM1zmzipiru7
	 SGULOzHJk2UcUmjuHcmHjiGpGug2RxLw1dgVEoPEroS/PpVOO5bPXxDj3paOTbcPh3
	 3Hj4Y3wecneKBZciciE5Gv1REX+cAre20Ljr2Q/0WJkxfUG3QjxyCin56QN/fIVKxP
	 6i6+eWtSfWNmYRIr6VXNqdR61f/9tQkXu/ztu5qGyeM/PbW07HeX5unfkYqsoLiGhr
	 2Q9eYJ9bNbCyZmAv2VudbQS7mKFMABFjfb02gerCAT8BE1vz1ZGgZG7ReRQvUwqCDd
	 4RB2zF8jv+lxw==
Date: Thu, 11 Jun 2026 17:50:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Louis Adamian <adamianlouis@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <20260611175027.18459126@jic23-huawei>
In-Reply-To: <aimvBvJp8CsNKlPU@ashevche-desk.local>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
	<20260610020458.104818-3-adamianlouis@gmail.com>
	<aimvBvJp8CsNKlPU@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 21:37:58 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 09, 2026 at 10:04:58PM -0400, Louis Adamian wrote:
> > Add correct temperature compensation for ms5637-30BA, MS5803-01BA,02BA,
> > 05BA, 14BA, 30BA, MS5837-30BA. The temperature compensation formula is
> > shared across these sensors but with different constants. Add
> > ms_tp_comp_consts to capture these per-device differences. Add pressure
> > variant specific pressure scale variable.  
> 
> Is there SPI driver? If so, why only i2c is affected?

Excellent question.  I went digging.

The library is used by the tsys01 driver which has both SPI and I2C interfaces.
Seems the SPI side never got added.  The particular driver being modified here
is I2C only and the modified library function is only used in that driver.

Feels like maybe we should revisit the division of library and driver, but
probably not as part of this series!

I also too a quick look through and with the stuff Andy raised acted on this
looks fine to me.

Jonathan
