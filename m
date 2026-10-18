Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F915342523;
	Sun, 18 Oct 2026 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290825; cv=none; b=p+zsqlLow//rGYXwNt0CnBVjmoYFAEeWzijgW7N7VJWwpuvYmW9Y7heiK0u1n81S/bAXKB7W3YjHYINcQKaxVx3BBFxkHsx4NeMsw2hFlPBh9yGtn/QafjrGDIRlTslrOcTR0VvZYnRTeSY2Givgmy7eLzcp5kPvHaZMVFFfBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290825; c=relaxed/simple;
	bh=/q5PbLNw2ChnqLUDimmbQ6ILn66UIYEl00R7gRZz/wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8oxQD+5buNbeiOJH+yER+GoSEw8cAHUaamQnqMzyOsu3XGfXTU66JmcUJPKRzB8I+aoFh5vxfCXp5d6WTSILYhDLBovPVVxLIoZzXq6SXIyNlt9/qq+VJ6tF0PGCQEv5CI526HE01Di8nhEdb07zO5cAJVxtEr4i/DQIyVDZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXQrFILH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXQrFILH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3480C1F000C4;
	Sun, 18 Oct 2026 02:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792290824;
	bh=dX19vZ/sQ7rmexNY/w8tQK6/vEzEILtO03C1ggNJsFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DXQrFILHTBM/RjwT2IPIqYs049BUyb2DjcRR0pWRwySC+sTnKq7sRWvQGAybVghrL
	 WNcBUkuB6AgOM5lczQoP8EAHZonDYYQPPNbIgO1hDoZBdJnHDJ6B+UOOUj3kWRqNGy
	 CoKcORFQAdob/+sTphNXlGnIJugnkbbObKUEof7Qt2CsohR0efMHILzZI2Dep7/6fb
	 iV1YkN8le5rInwKsWdrwZeT6UIluR7b/sIBg/egf9NyaGTm8Gnu9wVqOj5PaFuaPg4
	 cjZDf9WspQzuy/AbOBY9LMOwWE5WWlLLsEHAhSUGlo6/G0XNPzhmE4ejH4uscMsgba
	 9AD+8JwF2oc0g==
Date: Sun, 18 Oct 2026 03:33:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] iio: imu: inv_icm42607: Add support for
 ICM-42370-P
Message-ID: <20261018033337.3d2d9fbf@jic23-hlaptop>
In-Reply-To: <20261002-b4-inv_icm42370p-v5-4-c65281b745c9@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
	<20261002-b4-inv_icm42370p-v5-4-c65281b745c9@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Oct 2026 13:54:28 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
> accelerometer with built-in temperature sensor. This device is almost
> identical to the existing Invensense ICM-42607-P IMU, but lacks
> gyroscope. The device supports I2C, SPI and I3C. Implement only I2C
> support for now, and provide support for raw sensor reads via sysfs.
> There is also a built-in temperature sensor but it can not be turned off
> similar to the ICM-42607.
> 
> While at it, change so dev_err_probe() is returned
> when the WHO_AM_I read fails.
Say why this is useful.  We don't have prints on every register
read fail, so why does it make sense for this particular one?
