Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33803A5445;
	Sun, 18 Oct 2026 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792293232; cv=none; b=JONZLI9gFujBaeD5I2ThDuvoMzC/eFvqm2EOkHcviZkAHZ6WMqQ7TkAZzgooLorYAJYx8MMgNEy7lFHv8Zsg2GpEFzSVzBOUHrUGDggAeg4JmY7B10tG/wIb8jVDBoUYk5YCpHSGx559VPnc3aQ3AYm4rIziG4I05FGpmTrXfbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792293232; c=relaxed/simple;
	bh=kSmw2hp2kR2lGR35g8XIaZmEI28wNuXKChyz8/4F1cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foNwTdpyIZ/mO0mTdpzXXIwdXabdrUQRr3JlEUJS/XzgVFtdDJOhjzKlGNJiVivNIbsWNUmkJqI5zAYtGUo5GLGLyIuZUsXp6RRDlvRLlchTcS81pRi//CTCmhaGtA7MLGOxe5/XUwFkx5XH5uPbEguMfIASsprfybyr87NhZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEwjF4gj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEwjF4gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3C01F000C4;
	Sun, 18 Oct 2026 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792293230;
	bh=wHdY1xPFPZttG4uKs1wCydcqFXStNj75zmExskNwhS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oEwjF4gjGxKbbe92+laFtChwmpvuAN6ezhZzVNH6pHCtwrN/Vgnlj9Mf1DcR+PfJQ
	 F3DnQDF3Sbrw07MnbJ25dp/kD+k82S3hE9CfTGyHH9qmpdmE0qw9siPvYcCcQvTL6W
	 cr5BsUqy/BOJFFcb6GVH80YSXeogrs9B8PAyPLXSMGmtpGXT3ondXbK2YHCaV7Cumg
	 dm7+JSDU7nknUPKXippind7Pmwzlddgw0Tn7G508YWxeXfZcnWXentHoWsa9HwAGym
	 Jtt+0aGw0c7vlMrN42a43MhLsDlXIwWFF6X/AKnz/ZDqhgKgMaZcdOPiln2qxAY6m2
	 mPshuEVa6iTHQ==
Date: Sun, 18 Oct 2026 04:13:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici via B4 Relay
 <devnull+andrei.stancovici.analog.com@kernel.org>
Cc: andrei.stancovici@analog.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ltc2497: add LTC2493 support
Message-ID: <20261018041342.0c5dda2d@jic23-hlaptop>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-2-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
	<20261009-submission-ltc2493-support-v1-v1-2-3dad1d4b152a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Oct 2026 11:43:35 +0300
Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org> wrote:

> From: Andrei Stancovici <andrei.stancovici@analog.com>
> 
> The LTC2493 is the 4-channel member of the LTC2499 family: 4 single-ended
> inputs or 2 differential pairs, with the same command format and 24-bit
> result. Add it with its own channel table.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
Hi Andrei,

My only comment on here is 'where there are 16 and 4 channel similar chips,
an 8 channel and maybe even a 2 channel are likely to show up!'.

So upshot. Use an integer for number of channels instead of
that bool.
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index cee9a2f50b82..219f7d49854b 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -31,6 +31,7 @@ struct ltc2497_chip_info {
>  	u32 resolution;
>  	bool has_temp;
>  	bool has_speed_mode;	/* SPD bit in the 2nd config byte (LTC2499/LTC2493) */
> +	bool four_channel;	/* 4 inputs (LTC2493) instead of 16 */

This feels like it will bite us in future. Can we instead just
encode the number of channels?  That will mean setting the value
to 16 for existing entrees but that doesn't seem too bad to me.

>  };
>  
>  struct ltc2497core_driverdata {
> 

