Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDEF3E9F82
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878360; cv=none; b=KfCJLJIy8PT4DOEdIqxvNugI5As0YxSPdTJdRAqm2XEVWhKJu/NS3Eib+OTs4vZzqoEl96TklsK1wxLYUEWMUtxS9QBYkAG2p6l1cmhVJFO2hFiJa0KX7o/hG53cpv1HSbNCHzKZI5f73YpeYXJgMiW/MqJAUaljJR7ByLUDML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878360; c=relaxed/simple;
	bh=PWCsswThJB+3tBBD+8y3czASdCOr6q4KwLn5O0hTWpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJv2pc1Ab9Lf/rDhjz7xk2f5y+V5wDwIo/4VS71TijCtxFLEl0VXskahSMVmokK/R3dovNOajs5WuNJ1Z/ujJjw2MdhcXbRxc4uGaadjMvIkPjpk4GiIqdiBM8Aze2K23edLFlRgOHCS+fCZ2bc5FsDFjYaAHEKO27Js1zA5R3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKe5QW8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKe5QW8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B0D1F000E9;
	Wed, 27 May 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779878358;
	bh=ZBttee2tMVudZntqDkekJXEhl3NrFYb8POIleHUuOIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VKe5QW8jc4v4tGo/3YetPpHN8XbKXbkjotu8ZnbO9+mqUAuLtByRv/YKPACAWHuIL
	 3+dMruHJUP1dhDaM7Uw9to/K3Ydstv7qPDjy6ZJkX1r6oyBTVsU9plg77YbFRGZETE
	 XwHgbU1q41OmDoj2Vf/qxr5l6pfQkX5Wjo1ysllSAsEAMzRvJucUIrkSTZcUh6qJ5f
	 XEf0XspQSnknODUDzhJ0KLooSLRvM6E4L51pReWn9F8gU5TYwwj8Pwt8I7/YLtNgNW
	 oINwzl6Yn3lnWYo2ZgvMg8GDusAVL6cXuBkc45vHDXFVquVboRcBexwv2A06vEmhSf
	 +oa1JRICdD1iQ==
Date: Wed, 27 May 2026 11:39:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [RFC PATCH 0/2] iio: pressure: ms5637: Add variant specific
 compensation
Message-ID: <20260527113912.50bd7f79@jic23-huawei>
In-Reply-To: <20260526185612.35048-2-adamianlouis@gmail.com>
References: <20260526185612.35048-2-adamianlouis@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 14:40:29 -0400
Louis Adamian <adamianlouis@gmail.com> wrote:

> This series adds correct temperature compensation and pressure scaling
> constants for the MS5637-30BA, MS5803-01BA/02BA/05BA/14BA/30BA, and
> MS5837-30BA pressure sensor variants. Additionally, it adds a Device
> Tree binding document for the MS5637 driver. Without correct
> compensation, pressure values were measured to be off by 100kPa with the
> MS5803-14BA at room temperature. 
> 
> Note: MAINTAINERS has not been updated yet as I am not sure what to add for
> the MS5637 driver.
> 
Hi Louis

For a cover letter of an RFC there should be some questions, or other reason
that it's an RFC.  To me this looks like a proposal for something to upstream.

Key is that RFCs and normal postings get different types of review - and
different people in general look at each type.

Thanks,

Jonathan

> Louis Adamian (2):
>   dt-bindings: iio: pressure: Add binding for MS5637
>   iio: pressure: ms5637: Add variant specific temperature compensation
> 
>  .../bindings/iio/pressure/meas,ms5637.yaml    |  52 ++++
>  .../devicetree/bindings/trivial-devices.yaml  |  10 -
>  .../iio/common/ms_sensors/ms_sensors_i2c.c    |  81 +++---
>  .../iio/common/ms_sensors/ms_sensors_i2c.h    |  47 +++
>  drivers/iio/pressure/ms5637.c                 | 273 ++++++++++++++++--
>  5 files changed, 403 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
> 

