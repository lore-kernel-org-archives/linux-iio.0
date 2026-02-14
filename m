Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDB23BD1F;
	Sat, 14 Feb 2026 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092570; cv=none; b=LfGmCTwZdqKQdZv32lrA1Vp0U8bnYZv3VPMl/XPI1sH8SV8pVPDeOPFzyn/96VCcdP5PVN1/ziWNDaLvxsBNQ6QYYOuoQteBZmINnbwiA48ne63kKHhqtAiu9XbI7JGOU36PS78Qws8Dbsas88GY6mD/KSw0mxBuuHa4UzhzMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092570; c=relaxed/simple;
	bh=4eeh9ldiDUgoX7LvVNeFMST8ORwO67CiBaYSvcpUj7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnkbhCkwvAZgstig2AH1Mxm0ESQqiFVrss2yVxXbUjEu/OfTq5hFg2PleAC7QPQGq1UZK89XDhB21dzqzMrUZWiFM+OE7N5rFVR5T2/cHgIjCOHDhIyhCZXaVeCA24Pu9e/ahmNkjqcaH1b2+gmlk8qhfMOFP8f0vetB1O6Alws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN+6LBo9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN+6LBo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8691C16AAE;
	Sat, 14 Feb 2026 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771092569;
	bh=4eeh9ldiDUgoX7LvVNeFMST8ORwO67CiBaYSvcpUj7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EN+6LBo9HwooEUd0kyUOIwbheHy6sesqclfjAiXvRbFlfY1k85Bcz/KxxUaFAz6qW
	 xN4aouqzsGbnGMwFVrHxGsWkchMm6waEF3Xmaiz8kOINjesJkUembPYpNI6Boul2B7
	 0CH2FKEPLmTb0EQkOAJInHtGM5p5o31qVLkeurn8wOXE2P1kmdtAdtgoGnO4riVAGi
	 gIZCj9nOgHgYCSQuW2RC/dm8vRqy9RZa8AveLdt0Iv/Os/1hLZbYu57qutnHze8uDg
	 RHIKtQumEeJaWXZqNQdjtFu0kSNeUGUWHl74aLFbr8trizuZXPqkdsACr/HxcIAWM0
	 q1dDT73/ISMcA==
Date: Sat, 14 Feb 2026 18:09:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: vcnl4000: add support for Capella
 CM36686 and CM36672P
Message-ID: <20260214180919.72389701@jic23-huawei>
In-Reply-To: <20260212-cm36686-v4-2-8f587d4a72bf@gmail.com>
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
	<20260212-cm36686-v4-2-8f587d4a72bf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 16:42:48 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> Add support for Capella's CM36686 and CM36672P sensors. Capella
> CM36686 is an ambient light and proximity sensor that is fully
> compatible with VCNL4040 and can be used as is. For CM36672P, which is
> a proximity-only sensor, also remove the IIO_LIGHT channel.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
Hi Erikas,

The following isn't necessarily suggesting a change, more something that might cause
people to have a bit of a surprise.

Whilst the binding having a fallback compatible is the right thing to do
here, I wonder if you care that that when you use the drive via the fallback
that the reported device name ends up not matching with the part you have (cm36686)?

Sometimes we add specific chip_info for a part just to resolve that naming
issue even if it's otherwise fully compatible.

That means that an older kernel will support the device (via the fallback)
but a newer kernel will also give it the name people might expect.

It is an interesting corner case on whether that is preferable given it
is an ABI change as they upgrade their kernel, but the name then ends up being
what they want.  There isn't really a right answer to this.

One note below.

> ---
>  drivers/iio/light/vcnl4000.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index a36c23813679..1f8f4e4586f4 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -185,6 +185,7 @@ static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>  
>  enum vcnl4000_device_ids {
> +	CM36672P,
>  	VCNL4000,
>  	VCNL4010,
>  	VCNL4040,
> @@ -235,6 +236,8 @@ struct vcnl4000_chip_spec {
>  };
>  
>  static const struct i2c_device_id vcnl4000_id[] = {
> +	{ "cm36672p", CM36672P },
> +	{ "cm36686", VCNL4040 },
>  	{ "vcnl4000", VCNL4000 },
>  	{ "vcnl4010", VCNL4010 },
>  	{ "vcnl4020", VCNL4010 },
> @@ -1842,6 +1845,22 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>  	}
>  };

...

>  	[VCNL4000] = {
>  		.prod = "VCNL4000",
>  		.init = vcnl4000_init,
> @@ -2033,6 +2065,14 @@ static int vcnl4000_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id vcnl_4000_of_match[] = {
> +	{
> +		.compatible = "capella,cm36672p",
> +		.data = (void *)CM36672P,
> +	},
> +	{
> +		.compatible = "capella,cm36686",
> +		.data = (void *)VCNL4040,

Is this necessary? I 'think' if you drop it we'll match instead
on the vcnl4040 fallback and then the access to the data will be
through the stripped name only bit of the compatible (first entry, not
the fallback so cm36686 in this case). So you do need the cm36686
entry in the i2c_device_id table above. Probably better to keep
this here to avoid having to reason this out - but perhaps a
comment to that affect would be useful (assuming you verify my
reasoning).

As Andy suggested moving away from enum values an towards
direct pointers to the chip_info structures + drop the
i2c_client_get_device_id() in favour of i2c_get_match_data() which
uses the right firmware entry to get the data in all cases is the
right long term solution and avoids an association being necessary
between the two tables.

Jonathan




> +	},
>  	{
>  		.compatible = "vishay,vcnl4000",
>  		.data = (void *)VCNL4000,
> 

