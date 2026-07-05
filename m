Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DF29A32D;
	Sun,  5 Jul 2026 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783292951; cv=none; b=U3IQzwCosf5VUE6QzPMnmpjRnmVLRLeAbN/dFGSQuyj/wATP5lSp/V1rm4861Iq1+Ecd0QISwmHxt5WocF5K1veN3mAjmucfTIQ7uJ3Lqun5gQgUyzQ6MBvtbgMJMavWvJrfKI9BBKX8jqRK7cWWa0qhYWcsIUpRfBBLm0ius04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783292951; c=relaxed/simple;
	bh=ZJeORPAnbsffcFMqOaNnhZqTb9keeCuIOE+R7DfIdvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=secOmiLNHQTtp9BTK6vk32QbRwP6BTSgrjgMfQuXd53kdEeO/hJ65JYdKe1dGV5zfG58UjK+M0EkCSxf9sv0S0Prnnw2fYaIcHZleOQuxvDyJmCcC6+xjxc2OTAbBLbw0qRJI0fcY2m3bTeKoqZhOCoKfJvlyk1ICHPW/kD19RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDfnkawJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDfnkawJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237101F000E9;
	Sun,  5 Jul 2026 23:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783292950;
	bh=rmOlS6FrPuH9L9oi1EFj09eUitnoD+qTIdCf4Cb6/vA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iDfnkawJndsWKC3hxKULZcm8wge4owEGOpTXONLF//3TEazF/12zRzNm62ukwdIWx
	 y/TbuURD8DUbrqkDJdMrvpHPSQboP8euOalapYw8IWAdom24HryzAy7DgYhxUkvOsm
	 l9SEf8Strqm9mmmDsy4C4l9TZJyRDYB/bbbHnAJs27+6rh5fnLN7eFSiuUabqBxZWl
	 enQZYjKc4/5iFTPWiWQU3+b3LANOuyA0A9p5NsAIUO72tAF3EOEFqSytvEejABr2Da
	 qPcD65ucDFb3PJ96kUC6VI4NU3ciOmwIE2ojqfOpecGSgt0c4INO8Uqf9nvomSDLZ8
	 JpgdxKvzHZm7w==
Date: Mon, 6 Jul 2026 00:09:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 1/6] iio: dac: ad5686: refactor command/data macros
Message-ID: <20260706000905.7448dc01@jic23-huawei>
In-Reply-To: <akppC9oRzspyq8du@ashevche-desk.local>
References: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
	<20260705-ad5686-new-features-v6-1-269594c7aae5@analog.com>
	<akppC9oRzspyq8du@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jul 2026 17:24:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jul 05, 2026 at 12:38:56PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Replace usage of bit shifting macros for FIELD_PREP(), which would not
> > ignore bit masking when preparing SPI/I2C commands.  
> 
> It's not marked as a fix and has no explanation why.
> 
Agreed - this needs to stand on its own as a description, without needing
to know this is both hardening code and closing down real issues with debugfs
(IIRC from the sashiko reports that lead to this).
Maybe sensible to add both a tag for sashiko suggesting / reporting it
and a link to that review.

Thanks,

Jonathan

