Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6E2FD69E;
	Mon, 29 Jun 2026 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782776883; cv=none; b=tsPTknnYWb4I5uBwmeZULS3EvJc1y75YNpEyOAienic96XVYfpvk8xUopL1PDkO9w/Ald8EscVacQtjbJwIQ6TOW1Iae8LIrW2+g++2il8l160gnjH84ZsJy/n0DQGlzNw4cZEEZSc24h6GMbOwGlKs1IccyQaJspHxYRtuQJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782776883; c=relaxed/simple;
	bh=rtm+54lMPyXh2AvhXa6MvRR6q7qgl+tQLL8pQeLwvCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlKIJuRxJbMYUxD7SK3jRwZ3d6KIdry3obbO5NSTauiTfHzxus6oLjVV5s7J+Xt/fXsFdN+pmJ6N5RF1a90VFsntmMJPIEg+xPGZs/jW7I4+Oi8Am7+WbFmugab6lfdqY6DmoltGBxDipLouMBT4S6/ti8T6AVfnnLh6aXP5zLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPA4aT4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPA4aT4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F5F1F000E9;
	Mon, 29 Jun 2026 23:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782776882;
	bh=MeMyWXM5ySTIsgDDp+6WL4WsbLV2tdptGm1+i71qusE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WPA4aT4S0YVFxNBN/YVzEiMCX+kopezf6TvzANtw+AvVzaPq+4NZ4OjKtOc5WUp7n
	 MUGf+gJeKsxLFK8I1G5J6uNMhRFGoDCjW0ZmXuxSSWXHOlxdsUbqugCAZvZk8bRDA6
	 SY755P1et8m8lexU6Esb7n7pFwz8yCCRQbd/PocWF0rFj8SUcnMz+I5y3+PU/bn81D
	 IUi9Wlo1akzQw+bs2ROrWl3doDqAWcQ5GCVnu9pFev2402y9ie+9j5qjRKB5ABfILn
	 Y5zZelV21xGjUl6zn0oHdsC5RrhMdA8yFqhxEWdXXjaUTA7RppHuFNvAjtg26oMjh0
	 MKeHu0Gr1jgBg==
Date: Tue, 30 Jun 2026 00:47:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 12/12] iio: dac: ad5686: add gain control support
Message-ID: <20260630004756.5194faed@jic23-huawei>
In-Reply-To: <20260628-ad5686-new-features-v5-12-577caadbf7c0@analog.com>
References: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
	<20260628-ad5686-new-features-v5-12-577caadbf7c0@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 15:08:19 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Most of the supported devices rely on a GAIN pin to control a 2x
> multiplier applied to the output voltage. Other devices, e.g. the
> single-channel ones, provides a gain control through a bit field in
> the control register. Some designs might have the GAIN pin hardwired
> to VDD/VLOGIC or GND, which would have no "gain-gpios" device property,
> being able to set "adi,range-double" if it is hardwired to VDD. The
> vref_mv field is moved down in the struct ad5686_state, so that the
> overall size increase is reduced.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
I took another look at patches 8-12 and they look good to me
(other than the thing Sashiko raised).

Thanks,

Jonathan
