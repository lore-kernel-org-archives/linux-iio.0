Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830876;
	b=Rg8WvEKj/FhiWJX5Cdx7mrEw0noQf9jpmF2MuPJGWRGf1Gifaaw5xINNXNXiWWBRb9Hi
	 JW/tSg2VhiWZg4+ix9gGl7XhhOJetys3TqB1D10VDMPjn20jI35Zg1yDpfSdDmO3wiYln
	 UdVNfVpIdWj9aDY1kkALjd8R+POCHqurFEwLRkn7rwvOZWvPUmC9ns+oEG3MHsAMln+ti
	 VOq6dAQz/wEXP90VIoNbGPWAlGUGeDtzTI5PmrTtF5uU8h0k+Ba9ybthx3AF6FIHEOG23
	 +Yh8c2/aj0fDoLv8TSBGCIrErCnrCr99+LBALkZUIUO+WKF/eZcOvqjpVxTpw71Lo2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830876;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gvN2/sm20m6xx6aSVPhcQLvPZaATBqUSOlPWVarEaGs=;
	b=boh8o+L1UhdmpVKH8jzOWInC2LQxSMgJUmEOlR22wrc2XGFKaJ0giSGx06Yh8A5XRFnt
	 YtvqUOGs8vpItwwfq12XCx7smBMxZ26s3QdGh6UzZlYqIG5gXZVydtUQ9dBmImU9mj+G8
	 Nb8bgPiUOpSOTwfD1imA4NIDp2wNQ5MaS4tyw6ph6qstsFfSWY+k/O2wQJBEca7j38wP/
	 vOr9ahCN5CiNfQ6sYfuepg/6yOxbuAiyBH1GQeQIW/0kc7ig60XkP15zfX46WzCKie3JC
	 QQLKQl4Z7otHlg5kH1qdIl06b17NIEfemFNbdhOq1oyAtSpukjrwFUMlb8ULvRIVZFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfPuUE1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25A606A31C
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfPuUE1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109071F00893;
	Sat, 28 Nov 2026 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795830875;
	bh=gvN2/sm20m6xx6aSVPhcQLvPZaATBqUSOlPWVarEaGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XfPuUE1BaDeV8ktYTg033q8OEzkxnBqVZ6SgZ+iyvh58b9h+MPYCD3P9bioO3VMcY
	 6FMeJ0m4SPffselCcHHEo73OSr2r9UVQ73yCGlrBS8jHh4qOKGso29pd2y0FUIJfet
	 /uknGFyyhGBeC2jEddX8IN9M96cJOn9cn/0+GtQNANhWFH3kGH7VY2QGHGEYu3SFHr
	 QVrCg6i7alzDYByr7yuL31MSvhZapNbI+wzqinuowkl9fOwYuefW6qQnQO4DhDzTr9
	 hUTA85WYc6tK1DDxhfkJRa5T2RNjYjpVAXayo60DslvE3sEbdeS/Q1PxVDAsmsofAw
	 v0iHVMSF1YWWg==
Date: Sat, 28 Nov 2026 01:54:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: He Xin <hexin@hexin.host>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 18/18] iio: accel: stk8ba50: support mount matrix
Message-ID: <20261128015429.294d3ae9@jic23-hlaptop>
In-Reply-To: <29709CB0F177D550+20261127030810.3150676-19-hexin@hexin.host>
References: <20261127030810.3150676-1-hexin@hexin.host>
	<29709CB0F177D550+20261127030810.3150676-19-hexin@hexin.host>
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

On Fri, 27 Nov 2026 11:08:10 +0800
He Xin <hexin@hexin.host> wrote:

> The driver ignores the mount matrix described by the firmware (ACPI
> _DSD "mount-matrix" or the devicetree property), so the orientation
> reported to userspace is wrong whenever the sensor is not mounted
> axis-aligned with the display.
> 
> Read the mount matrix at probe time and expose it through
> IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.
> 
> Tested on a Phytium D3000M tablet (ACPI HID STK8BA50) where the

That isn't a valid ACPI HID. Sure it is out in the wild, but
just for the record Phytium should be doing better on this!

> sensor is mounted rotated 180 degrees about the X axis: without the
> patch in_accel_mount_matrix is absent, so iio-sensor-proxy has to
> fall back to a udev/hwdb override; with it the matrix from _DSD is
> reported and the orientation comes out correct.
Put the one you actually care about first in the series.

I'm not against adding this to all of them, but I would expect
the distro folk to decide to backport this one but not the others.

> 
> Signed-off-by: He Xin <hexin@hexin.host>
Just one minor thing below.

>  #define STK8BA50_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
> +	.ext_info = stk8ba50_ext_info,					\
>  	.address = reg,							\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
> @@ -395,6 +411,10 @@ static int stk8ba50_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +
> +	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
> +	if (ret)
> +		return ret;
Blank line.

>  	data->client = client;
>  	i2c_set_clientdata(client, indio_dev);
>  	mutex_init(&data->lock);

