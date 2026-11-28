Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830557;
	b=TPHmjI0/QS7WhlY01Cv6FtdJcID97OVtOCUA1jEhOI7kYlqP29uVegpJVnP1M5W+Nafl
	 e3gv2ZaMpLH1tWTu0V7rnR3Eu5tAAyNZHkSlRyPFvnqju5lyzU9Gs4qnrUmqYbpUwckj8
	 vs8uwbg1XtjdpLkhbdz4Sv7ny2mDVwg1ahNbEcZNHswdMcT6XwNLsHGVmLhP1cSIcOOrm
	 NZ6vnkmPkga+noV03BbWci6XT3JVe9Ax2n10W1yXQHpqNoYKBGtJjCOQSLXrzbIDOyGZz
	 aWKAEH7/gFGM1Wk2YnCiGqadpMIDpLVImW3rmo2/rFMrfo7zTgzJwi0QJKRJ9qaRh7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830557;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b0CNu0sMSomQPUMCwSAn1vfvgTsWzt6MgZxeDXpU9B4=;
	b=pNjkyYEarMiRUmL7S+iosNuykNbQPODzMT7jQHiO1y2CSJV8RM1AS+Vy27zoh8M+IbD8
	 XmA5UOklWArvJwtQ7j4i4FHeKlXzvuSWl2S7//VFKBHi9Xq2dXNH2w9kExlDGt5OOuTFN
	 UnndTHCn7LErB16xPHRtEWq4Z9q7HPDkVAhdcurLOx5xROlYCpGmfiWkJSOg9K8wkbaa6
	 WuIWfTdEjapZyneTuMNsroD7QoH9eOhG/Hk18AOlNS9nBJj075qde1ixboPv6CvG4Jfqw
	 NEjnMKIJVjNVAPxhWnr8qf7ApNpxGMA8OWjfDF5Mk5kA6mYn/EMrQ3kD5xD5x3X0zIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ok8en1Zu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C7606A31E
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ok8en1Zu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EE81F00893;
	Sat, 28 Nov 2026 01:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795830556;
	bh=b0CNu0sMSomQPUMCwSAn1vfvgTsWzt6MgZxeDXpU9B4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ok8en1ZubuT1LuPwAaglbxPNFtfsqMRUOc+0AramxHrJ/M2Ks7e98hAKVG/mvq11P
	 k57tnBybzEYORSpISNVWTUNlp3rkENot4+4OlzVkfMt3PcPkVWznCkeRXx8cfFioW7
	 WUybWn0X3hU9IPkD9Purp3C5wtRqTnEjvhOjieuHAo3kg5bEppjc9Y0838BUc9BpK/
	 hHimMqBGP8ZI3V0qgLrZgMTB4Ok6xnEhDhU2XtW/3XcbTAK8R6M9faCQRvTVZTRG8K
	 G4Yy14YtfV46FqOcXONmzQObtIdtMRzNyFCKw5WSlzuAHJ/y9YpTw0sTJwuL5ukuKU
	 C+elmeflGRQJw==
Date: Sat, 28 Nov 2026 01:49:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: He Xin <hexin@hexin.host>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/18] iio: accel: adxl345_core: support mount matrix
Message-ID: <20261128014910.53c4fe1f@jic23-hlaptop>
In-Reply-To: <AB3626537FF1BFE3+20261127030810.3150676-2-hexin@hexin.host>
References: <20261127030810.3150676-1-hexin@hexin.host>
	<AB3626537FF1BFE3+20261127030810.3150676-2-hexin@hexin.host>
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

On Fri, 27 Nov 2026 11:07:53 +0800
He Xin <hexin@hexin.host> wrote:

> The driver ignores the mount matrix described by the firmware (ACPI
> _DSD "mount-matrix" or the devicetree property), so the orientation
> reported to userspace is wrong whenever the sensor is not mounted
> axis-aligned with the display.
> 
> Read the mount matrix at probe time and expose it through
> IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.
> 
> Signed-off-by: He Xin <hexin@hexin.host>

Something messed around with your message IDs so the thread is broken.
It seems to have added a prefix to them.  Try to find out what did that
for v2 or just use the b4 webgateway (look for docs for b4 on kernel.org).

> ---
>  drivers/iio/accel/adxl345_core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 6c9080d..2a77b55 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -204,6 +204,7 @@ struct adxl345_state {
>  	u32 tap_window_us;
>  
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
> +	struct iio_mount_matrix orientation;
Look at the line above and make sure you understand why that IIO_DMA_MINALIGN is there.

Technically this isn't actually a bug because the data is const after boot, but none
the less we should have nothing else in that cacheline because it makes things
harder to reason about.

>  };

>  #define ADXL345_CHANNEL(index, reg, axis) {					\
>  	.type = IIO_ACCEL,						\
> +	.ext_info = adxl345_core_ext_info,				\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
>  	.address = (reg),						\
> @@ -1902,6 +1918,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +
> +	ret = iio_read_mount_matrix(dev, &st->orientation);
> +	if (ret)
> +		return ret;

Next part is unrelated so a blank line here.

>  	st->regmap = regmap;
>  	st->info = device_get_match_data(dev);
>  	if (!st->info)

