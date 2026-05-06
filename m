Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAD48C8DA;
	Wed,  6 May 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087546; cv=none; b=OiJHLp+YkRQWKXqb4Fgq0bw5YHkgV8zBRLo+n2UHCCDAtooTcwb9DbGIRXvDgl5FUI9E04vVG6FhvsMLMREoS+5CewME3PPkLI/lNBeYWqXW1B2xF3uMC4lyZ6E83W6sxHdocOWlxldgNbwBbrDmJVlGQr1HUYWF1b09mbBG1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087546; c=relaxed/simple;
	bh=xQo9dnjnsv0fmSSIGP1UwNIPp8axdZ0M8J/gaNduLoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLs1g9DYhI3HFpwLdnfdkWMVoHOqe5JsXWo3ajrkutNY0IbklfZZMwTW6czmhbTPfjEap79Q2BiKzmV6OjjOb8gbl21H1XSIMo1ZQzNsQx/vLYidunkOIEDlB7VqSJRc4ymXrMaz554ORvjdGRK5/HJP+n/lnkWk5tD6P9OJvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwaIhVKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwaIhVKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F131AC32786;
	Wed,  6 May 2026 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778087545;
	bh=xQo9dnjnsv0fmSSIGP1UwNIPp8axdZ0M8J/gaNduLoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QwaIhVKc9haWGBKcM2ZzzBFKoGAd/OHlS/hNLMmP+Tj+PmKxyVweGjd3RAsRUw47d
	 SQNoFqeMpc2TX6MFpOV/nPJbcj5W9pfOLa+fSJ6YqoyjlJQ+V420p0q6iNIftdv6Cn
	 Vbf0v0otLXqbs5yQbKRPsfVln+spLfWWBIcrPHNUwIBB8hOTtuHeF5jSTeRFnBt+v9
	 B5scw26PHFUzd0avNWumct8qSXxrAEMsc21ZbS8Wy11SP+zoN7h9hKPi4duDoq2vex
	 l3st8aIgRgDPt47UeF5eiIfoCyt021MsDqZGw9V0KuHSxuQdqaESN16SjCOG3kjKyE
	 GNBkloDZqWKEw==
Date: Wed, 6 May 2026 18:12:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 18/18] iio: magnetometer: ak8975: make use of the
 macros from bits.h
Message-ID: <20260506181216.049f87f8@jic23-huawei>
In-Reply-To: <20260505-magnetometer-fixes-v5-18-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-18-831b9b5550fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:46:14 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Make use of BIT() and GENMASK() where it makes sense.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

One small thing in here.  Feel free to just leave that for a separate patch
and for now leave it as 0x7

> @@ -840,7 +833,7 @@ static const struct iio_chan_spec ak8975_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> -static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
> +static const unsigned long ak8975_scan_masks[] = { GENMASK(2, 0), 0 };
Hmm. This is a fun one... It's actually 3 separate bits so please represent it
as BIT(0) | BIT(1) | BIT(2)

or maybe add an enum for the channel scan indexes?
BIT(SCAN_X) | BIT(SCAN_Y) | BIT(SCAN_Z) 
(and there will be an unused here SCAN_TIMESTAMP

	
>  
>  static const struct iio_info ak8975_info = {
>  	.read_raw = &ak8975_read_raw,
> 

