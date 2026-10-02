Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBD2DB79F;
	Fri,  2 Oct 2026 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951644; cv=none; b=nOS9SwmqBYoTwEMOhHbIUDmViY988WRuv10rUpD6zDdVl9cqGu8Do1NEJHThVeK9I7JJepS76rBtn2RYZAkWsjrJe1znvRhr7P+tLN1zEELkUO5PdHZe3pVlAY0TDKBSaeIYTzBjKDpLJ8exUI2RkI5OhEPmjhcST3MVMoydu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951644; c=relaxed/simple;
	bh=1jK2YHK2WSx82UF/frParOUH55P/f85eeb9pKT/u1IA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAXQT7D19+ydKq9UgOjh+pi0yrNapRxv1I5c/fogTGLjCBIIdvxP+u0QNJzh5A95Lc5WrNEuevpGjJAKxzFQsH+T5hWURihghP1KoUp9KlQ7lox4YGSUlTPI19c5MPAEkh5e/hkODd3Dsh3wt9fAk78/8XS0M5R817z72KkYRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1QzSLcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1QzSLcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407BD1F000FF;
	Fri,  2 Oct 2026 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790951643;
	bh=UWFt/auOpOsMrP7EpBMqStCL4hrQWzQBPhqFcgSREmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J1QzSLcp1U1ErWHL32Sd4uGAeqWd/YYc4L6UiyBsiCSt8cSqVFhbwcwnl+CGt8Akf
	 N45YG0fAl8KwiLvfjSSwEcgetgdzg8WNClnau5EEUwllls3BgQayYyyOw0rHtGXdEz
	 4Tqa0P+BBleam8KY1b+V5VY7FgdDoxn7zOSeUTA6B1iUWHA4n9w3OP/QUGmv9aHWJO
	 a4j1ZBd1SPDMlKoV8PZWhVx5ghxncF6Jzor0dVNfvSQJElV2m4TL73yLPt0kp4E1zJ
	 WNBoQc2MsIdClt77xa7VLbpv6cISF3351jVo99VCIh1n2/2jNg7eWe+b6dcxLL6ql5
	 X/wGyoIgma6mg==
Date: Fri, 2 Oct 2026 15:33:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com, error27@gmail.com,
 narcisaanamaria12@gmail.com
Subject: Re: [PATCH 0/3] staging: iio: accel: adis16203: fix axis mapping
 and cleanups
Message-ID: <20261002153302.5c64819d@jic23-hlaptop>
In-Reply-To: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 21:48:57 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Hi all,
> 
> This patch series addresses a fundamental hardware mapping error in the
> ADIS16203 driver and performs a few necessary cleanups.
Hi Abdelnasser.

Unfortunately, this is the most extreme example I've seen recently of submitters
not checking the mailing list archives or indeed linux-next before posting.

The driver no longer exists!  Support for the part was added to the
adis16201 driver and the staging driver dropped.

Jonathan

> 
> The ADIS16203 is a single-axis inclinometer. The current driver mistakenly
> exposes two separate axes (X and Y), leaving a FIXME comment on the Y-axis.
> According to the datasheet, these are actually just two different output
> formats for the same axis (0 to 360 degrees, and +/- 180 degrees).
> 
> This series removes the unsupported Y-axis, fixes the inclination naming,
> adds a missing SPI device ID table to ensure proper module autoloading,
> and cleans up the register macros to align with kernel coding style.
> 
> Best regards,
> Abdelnasser Hussein
> 
> Abdelnasser Hussein (3):
>   staging: iio: accel: adis16203: fix inclination naming and remove
>     unsupported Y-axis
>   staging: iio: accel: adis16203: add missing spi_device_id table
>   staging: iio: accel: adis16203: clean up register definitions and drop
>     redundant comments
> 
>  drivers/staging/iio/accel/adis16203.c | 108 ++++++--------------------
>  1 file changed, 24 insertions(+), 84 deletions(-)
> 

