Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAEA2459C9
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889789; cv=none; b=ufzF2pTHsi2rgyC84pl1d6sUSLijDV5A1KoEoUunSN/l9tO5OQTMwcsCkYpCHrQ23WuiHkfkdfZYHlTCjP4vlFGNB6qtkkMhXVvcMs0xM/BP+xeASKn7t6DhmRRsW1Mnkdl5DCbyuiQDHL7YjDrK9C8T+WPgy18NVfMVz+0T9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889789; c=relaxed/simple;
	bh=wtcIhaAUsxKAsKcKU3kADEtb1xBm7I+8YtOuQ4iB+X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cL1y6lwZyN4GburpnQby51kxQ657pfg8WnlrdrdQ9wDXd1m21GzM3cnx8unSsJVBkbDZfgNqzxCuIvqWsnEAYi5xFiS+css/u36XUfXWSCCVqNpghNwSydifPfPM425e01Lv0lNcglztjPHKsKmfixG3YswstXxqFpb0aRUo3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMrO8pOI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMrO8pOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B568FC19422;
	Sat,  7 Mar 2026 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772889789;
	bh=wtcIhaAUsxKAsKcKU3kADEtb1xBm7I+8YtOuQ4iB+X0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SMrO8pOIqY5RKz/FwgPVqKlCeW7vBzQRC+6ttxtINhJqcoIxbR3H1SLqUORZ7LPLi
	 6kEBx7cZRlzGbm38o7nSj3unULX5/w0YLAPa+fNJru7DenVKXKiHN+eUOvAcbYNkj9
	 bqllFQR8kBxtLOlu4XKSP+YcTgx6fzEjxED0GsjcmM8Kc7LD/tHoHqs9FjMlY0TkFC
	 zvYa9jBTvchggWH6xCq4gZMzCue5Q/5RfzrN/8+pVJtdXAVKCTTByzD4N7tNXKELln
	 mkd+0Jr5wM8ahI555wCRE4qb/ikT/El4HcUMjgqnnwKpeiJRHWBYcXX0b9WRvRYbYQ
	 USOlbta2VS1sw==
Date: Sat, 7 Mar 2026 13:23:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer: hw-consumer: remove redundant scan_mask
 flexible array
Message-ID: <20260307132300.49f256b2@jic23-huawei>
In-Reply-To: <20260303-iio-improve-hw-consumer-v1-1-1a19b41977b1@analog.com>
References: <20260303-iio-improve-hw-consumer-v1-1-1a19b41977b1@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Mar 2026 11:50:44 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> The scan_mask flexible array member in hw_consumer_buffer duplicates
> the scan_mask pointer already present in struct iio_buffer. Remove it
> and allocate the bitmap directly with bitmap_zalloc(), assigning it to
> buf->buffer.scan_mask. This simplifies the code and there's no need for
> the flex array allocation.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Ok.. I guess the original thinking was to save an allocation as then
scan_mask bitmaps tend to be small and probably fit in the padding anyway.

Still I think it's simpler to read as you have it here.

So applied.  I didn't tweak the line thing Andy pointed out as marginal
case to my eyes.

Jonathan

> ---
>  drivers/iio/buffer/industrialio-hw-consumer.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/=
buffer/industrialio-hw-consumer.c
> index cb771ef8eeb3..24d7df603760 100644
> --- a/drivers/iio/buffer/industrialio-hw-consumer.c
> +++ b/drivers/iio/buffer/industrialio-hw-consumer.c
> @@ -28,7 +28,6 @@ struct hw_consumer_buffer {
>  	struct list_head head;
>  	struct iio_dev *indio_dev;
>  	struct iio_buffer buffer;
> -	long scan_mask[];
>  };
> =20
>  static struct hw_consumer_buffer *iio_buffer_to_hw_consumer_buffer(
> @@ -52,7 +51,6 @@ static const struct iio_buffer_access_funcs iio_hw_buf_=
access =3D {
>  static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
>  	struct iio_hw_consumer *hwc, struct iio_dev *indio_dev)
>  {
> -	unsigned int mask_longs =3D BITS_TO_LONGS(iio_get_masklength(indio_dev)=
);
>  	struct hw_consumer_buffer *buf;
> =20
>  	list_for_each_entry(buf, &hwc->buffers, head) {
> @@ -60,13 +58,18 @@ static struct hw_consumer_buffer *iio_hw_consumer_get=
_buffer(
>  			return buf;
>  	}
> =20
> -	buf =3D kzalloc_flex(*buf, scan_mask, mask_longs);
> +	buf =3D kzalloc_obj(*buf);
>  	if (!buf)
>  		return NULL;
> =20
>  	buf->buffer.access =3D &iio_hw_buf_access;
>  	buf->indio_dev =3D indio_dev;
> -	buf->buffer.scan_mask =3D buf->scan_mask;
> +	buf->buffer.scan_mask =3D bitmap_zalloc(iio_get_masklength(indio_dev),
> +					      GFP_KERNEL);
> +	if (!buf->buffer.scan_mask) {
> +		kfree(buf);
> +		return NULL;
> +	}
> =20
>  	iio_buffer_init(&buf->buffer);
>  	list_add_tail(&buf->head, &hwc->buffers);
>=20
> ---
> base-commit: cd04646c0f3eefdde87538f6ff932420cedc9ba0
> change-id: 20260303-iio-improve-hw-consumer-5955f7f46b91
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20

