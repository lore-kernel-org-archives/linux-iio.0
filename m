Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4D171CD;
	Sun,  5 Jul 2026 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783294239; cv=none; b=JYPgznSPH43IKh296/hE6JilaIV/UVUnCGhrw7hSov+DE/r5rsY1bjB5tZpiD33a1YeougvE9o9mTOUJ+6wRPc72MGjGSkI+dKj1RQxtZiRA0oOAGWWSo2+oC8+sjhPWMtycjHoI7rYedyG3BoLX9fF8okeAS2OlyARdlZKz2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783294239; c=relaxed/simple;
	bh=5AcIbcuFtEUyP6sxFFKcgr89AoygcfdorTaXzY09l2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PanXgCJZYYYBkFVNex7fVq45KE+53JMJj1L3VdXhNLVeGtti7+tgbQOCajOQHbyNtq2nnyEPvjrOIHITI2UI4okBazvFrGeeKHPyfwl4DkUxAz0qLmzJHL4UJoPOJGIC/lux/sAqPkRwZAePVRSfQR8wM7gFv7X4WXrpz/95Ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUsf7Kpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUsf7Kpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934771F000E9;
	Sun,  5 Jul 2026 23:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783294238;
	bh=zZTwoaHjkB6vZT3sgfawcpSUPTBYtrajEoyeIMSHMjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XUsf7KpwmQxX/I7vwRcYGzaqlI+rg5IZ/e1c1nM5FNJ6qk3T53oKZfjDGQOxBCNNs
	 G1CSs2EPpj0lKQ6r4C56SSD8JGUWt51p2y0psZ9K3lkJY99Kc/CDZVQmhKsmnfl6Ul
	 p4gLLS2OXhg8Yopdr8c+vmUkM1d4oz9lvnaGUAPHF9s1TFrT1pNvOgfwhzfcRCv2Mo
	 rCs4OdhHLPtej644h8itWF6FPC0K5/LUPrIZ82UJGTqlFsLkKnn33YdMUd3yrvEFhb
	 YS7MVPUeQVIVkRGOxZmIeU9/kDWN7ijjpwCaESXNkOrR/YzU9UYfuWs1UYohjnsWfu
	 L9n8iJZDzHOOw==
Date: Mon, 6 Jul 2026 00:30:31 +0100
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
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Maxwell
 Doose <m32285159@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v6 0/6] New features for the AD5686 IIO driver
Message-ID: <20260706003031.0556b685@jic23-huawei>
In-Reply-To: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
References: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Jul 2026 12:38:55 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This is the second series of three on updating the AD5686 driver.
> 
> Initially, a big patch series was sent:
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> Then, the first patch series added fixes and cleanups:
> https://lore.kernel.org/linux-iio/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/
> 
> This one is introducing new features:
> - Consume optional reset and correct power supplies;
> - LDAC GPIO handling (active-low, held low when unused);
> - SPI bus sync() implementation for batching multiple transfers;
> - Triggered buffer support, leveraging LDAC and sync() to flush
>   all channel writes atomically;
> - Gain control support through the scale property.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
I took another look through and also checked Sashiko output.
https://sashiko.dev/#/patchset/20260705-ad5686-new-features-v6-0-269594c7aae5%40analog.com
The i2c short access thing seems real so would be a nice additional trivial patch.

The other report is a false positive but I can see we have a naming
convention that is less than clear after the changes in patch 1.

Jonathan
