Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225985;
	b=T2gp1g+M5ktUdMGxBZFjXpU0R0Hu6a98yLygAY3tXRqsSTAuTFX4W5fKh6rITewjBrwJ
	 0956pdSQAlgsLYleaLSJtJwQ9DiLnmkSIewfNFYwS+82+cfD9kuFG40+5EUEMmdeq+RVo
	 /8i8tEyd+Otz2CrBi2ROAqnCXfmw7qAZtT2i26zfIDZWDQHIKAs/BwvHSOZXsW89fhZwB
	 ASENw1WnPS4Alb4Gfk5FS2bWqRzeJ5vxFSSMFm9L05XRCqN57qLiDVCV9BD/B20/IDqw6
	 YJtWU4exLcNYHGmzS2+anF7oa7npTuYtBK0kxoKLBdRm6eKxyp4HWDDHRBdSRcUkIvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225985;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JXLZS1jRb+VGZO0HqZNhzJ4SDAnRA+oeBuGIPlVEtKw=;
	b=QN9vrIIQrLaesBKrXscMcWVXF/lKz4pQ1eCE7h4iQMuHwEioRCMcpRvsOvtogkX9r5LK
	 SGhyIKbYC78FkOYkdu2DqqthmvjLvrA6CARf8dDgBp5K+kxj99uScDaIsOAZxd/gWRTiu
	 iWuJOULsreWTRPL1rCdFaUWO893loJ0RA628IkJqDtyGkKfosY2qTa26jV4X2yY2MJIo4
	 LVHy0sCpo9xdNfE2TyqcqX1BgAayWXV74wPUN0QtEFEGxZFQUlQWzTI5lIXrRsJYbO739
	 zG/xYDiXedoeUpumt4/4ZjdctZ4Mofs3HUfjoK/9Kqd0qoNeuwH+35OsmI7qUthQPQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4PK6551;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C61606A69A;
	Sat, 21 Nov 2026 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4PK6551
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BAF1F000C6;
	Sat, 21 Nov 2026 01:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795225985;
	bh=JXLZS1jRb+VGZO0HqZNhzJ4SDAnRA+oeBuGIPlVEtKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f4PK6551sGtj9oI3CP1QnHgia9OKI8oldjkPOzWlxqt1JTg4GAvRtxmrj6DjFfXJS
	 u+XNRPSTLBarFr5Fejq3AALQb/RgPpHDBaqliZlO+DL+hSv8b2OJAkIPHuQ28bYL1E
	 8BHPgHaVLfy2s5/Svdb7362khi/VaPETmq0U4jubS7CXm1G01mzWlOvcPNDJjG1gBr
	 waVLrm8HSlKmny/C4E7TA6NHaX+ixv9cCZX6cayIRYiREhnUPBn809d8pS29en5Yz1
	 tNL4TEjnQ3531RaHRima3Ss5bk2gsab/zXsAqpasdUo8aNWh8mkGxSOMzbd0jt6LT+
	 FslcXywEMx//w==
Date: Sat, 21 Nov 2026 01:52:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 4/5] iio: buffer: add struct iio_buffer_attr
Message-ID: <20261121015258.568572b1@jic23-hlaptop>
In-Reply-To: <20261120-iio-core-attr-review-v1-4-05b41f8133c2@analog.com>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
	<20261120-iio-core-attr-review-v1-4-05b41f8133c2@analog.com>
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

On Fri, 20 Nov 2026 18:04:00 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Buffer attributes find their buffer through the buffer field of
> struct iio_dev_attr, which is unused by every other attribute.
> 
> Add struct iio_buffer_attr, extending struct iio_chan_attr with the
> buffer the attribute belongs to, and use it both for the scan element
> attributes and for the buffer attributes wrapped by the buffer core.
> iio_attr_to_buffer() now resolves the buffer through it.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/industrialio-buffer.c | 63 +++++++++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 48fdaed6d703..af5c9ecd1b3f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -69,6 +69,22 @@ static const char * const iio_endian_prefix[] = {
>  	[IIO_LE] = "le",
>  };
>  
> +/**
> + * struct iio_buffer_attr - IIO buffer attribute
> + * @chan_attr:	underlying IIO channel attribute (channel is NULL for buffer
> + *		wide attributes)
> + * @buffer:	the IIO buffer to which this attribute belongs to
> + */
> +struct iio_buffer_attr {
> +	struct iio_chan_attr chan_attr;
> +	struct iio_buffer *buffer;
> +};

> @@ -1526,25 +1543,25 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
>  					      struct attribute *attr)
>  {
>  	struct device_attribute *dattr = to_dev_attr(attr);
> -	struct iio_chan_attr *chan_attr;
> +	struct iio_buffer_attr *buf_attr;
>  	struct iio_dev_attr *iio_attr;
>  
> -	chan_attr = kzalloc_obj(*chan_attr);
> -	if (!chan_attr)
> +	buf_attr = kzalloc_obj(*buf_attr);

Maybe some free magic is appropriate here.

> +	if (!buf_attr)
>  		return NULL;
>  
> -	iio_attr = &chan_attr->iio_attr;
> -	iio_attr->buffer = buffer;
> +	buf_attr->buffer = buffer;
> +	iio_attr = &buf_attr->chan_attr.iio_attr;
>  	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
>  	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
>  	if (!iio_attr->dev_attr.attr.name) {
> -		kfree(chan_attr);
> +		kfree(buf_attr);
>  		return NULL;
>  	}
>  
>  	sysfs_attr_init(&iio_attr->dev_attr.attr);
>  
> -	list_add(&chan_attr->l, &buffer->buffer_attr_list);
> +	list_add(&buf_attr->chan_attr.l, &buffer->buffer_attr_list);
>  
>  	return &iio_attr->dev_attr.attr;
>  }
> 

