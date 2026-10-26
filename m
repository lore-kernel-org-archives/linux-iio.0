Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983193;
	b=vHi+jC5LTzmlSZdJDrSds10yFox/Mrw19mdtAu3q92LzmB9P9TZn6KrNIuJTENbU8w5+
	 4HkoYS0nGR3NOgJk6r//kzJ64YWNKwgOC9vsK41owbnppV0R6dnDtXW4Nb5e8vI1BZcsf
	 DMotbwnLeJA7C80/uEpkas6KgkNW+7Qqql0ghj0skLrXMEUfux/dmsq+OTICeU6lwE+9f
	 A455GfxdTBPUMXmuQpCzSyGqdxfm3C6HkGkbqgyA2AmoEWIs5/CsnXIInwaNG2xEMl3Tc
	 0nBTrpYhjZYujyowP7OrlZKoE8l+O3jwMzUy1D9oVxmfHWdmgZMDh21ZO4WIMPK1fQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983193;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=agh72Qss4ABdzK/M6v877pX8NbLoD6L5vuSt4NpILOw=;
	b=AcP7TBdnVNx/bJMlcZRViTie+TS3hvzi9mP4r0Xmzf4kGYI7oCXiMGjPv1zIlpn6DSzd
	 hGw3Nkq9nx5HyumypvMreGRhp/3h9zkdck5WnVxHJRp+Dx3lYl+RLGXvQHMW3mi6NVM6k
	 odv8raU4GIxppnkcR97R0faiVVGkiaSIS/b3UZeg86ldAsO7eAhAAV9+sMU4Ke/6GvRZT
	 qO82gYhmznZSfqRSHW1iZR2k+BOdpPZDmhf7pXIKiqQmUK3ym2K4zOkPtSoOQR1T9etHP
	 0vAj2E2VqIMSxpJJHpLmK0DzUgGd8jAKj7SdEMhPd2CHN8NWWzH+4CZjeAO+3Ka0qDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQa6mSTE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9586606A31A;
	Mon, 26 Oct 2026 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQa6mSTE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4117C1F01825;
	Mon, 26 Oct 2026 02:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792983192;
	bh=agh72Qss4ABdzK/M6v877pX8NbLoD6L5vuSt4NpILOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mQa6mSTEl349w46VcBnqaVHgVs+rie4UWFvFV/x7sWKmwLz56W5cZjAG8Mobw0qem
	 22314WNUTNUfPu5CkjKzFoiUebxJgRbHoCGOAx+b6u2fy7pngOZgdbn5ybzrQmNHdb
	 r5Q/rTPxVR9cGW09781uoqhy9kasUyYs+I0MpK0bRzc7p5kihwwmXQxcheLm9xpM9d
	 hFuSBmZ90cr7y6hFrTlGxqjGK1A3rCQx2HpLxO+3jzbaB2PouOKFH4/RT6Kn8LFaQL
	 n+D4rueF7TNcqA7gf2R52DxgezQOTEaFCDV9F1MiY2T/n5zMYfd3v4kPFBS8eIZLiC
	 0+avzXjS39tWA==
Date: Mon, 26 Oct 2026 02:53:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Cc: vidhu.linux@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
Message-ID: <20261026025307.3e142195@jic23-hlaptop>
In-Reply-To: <20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
	<20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 00:03:43 +0530
Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org> wrote:

> From: Vidhu Sarwal <vidhu.linux@gmail.com>
> 
> Add a driver for the Benewake TF-Luna, a single-point time-of-flight
> LiDAR distance sensor with a range of 0.2 m to 8 m, connected over I2C.
> 
> The sensor is run in trigger mode. Each read starts one measurement and
> waits for the timestamp register to change before reading the result.
> In continuous mode a read can catch the sensor in the middle of updating
> its result registers unless it is synchronised to the data ready output,
> which this driver does not use yet.
> 
> When the signal strength is too low the sensor reports a dummy distance
> of 0, so such readings, as well as overexposed ones, return -ENODATA
> instead of a distance.
> 
> The datasheet is available at:
> https://en.benewake.com/uploadfiles/2025/04/20250430174501874.pdf
> 
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
One trivial addition to comments from other reviewers.

> diff --git a/drivers/iio/proximity/tf-luna.c b/drivers/iio/proximity/tf-luna.c
> new file mode 100644
> index 000000000000..b2f6e664b614
> --- /dev/null
> +++ b/drivers/iio/proximity/tf-luna.c



> +
> +static const struct iio_info tf_luna_info = {
> +	.read_raw = tf_luna_read_raw,
> +};
> +
> +static const struct iio_chan_spec tf_luna_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
Where there is only ever going to be one channel it is fine
to just not use an array and hard code num_channels = 1.

If you plan to add buffered support (no idea if that makes sense
for this device), then I don't mind you leaving this as an array
to make that step easier later.



