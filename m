Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1A40DFB0;
	Sun, 22 Mar 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774180048; cv=none; b=T2LO9+AwrErir4bY5eK+nBzsODbISnC854brPosJV8O1l6hCJbY+Gc52bB1+JEVbiyVgDgkNO5rCcG04ra++77tFjVljKhnIwBVcoCPDfA0qINieYTdb9z+ow5oEvyVd4YJkEbMKB5Tx5Yq/IHWrv4g7YDm9ktfaFwMj4wTW8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774180048; c=relaxed/simple;
	bh=/uhx2vnKfI9P5umHYonv7l6izl4XOAkgeAWZyH0NMtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXrQ0yvH31laZzTOJlTRbwUl/Sy395guGYcYlWs6nEb9kRkDjRe2nWG9sFQbW2K/9Mp+Ao+jg9UoIdfRkjN649vcT+LIGE9BwqjwUV6oqhh5+hENFhu5GftYEAhVVA/U8kylKb9QgFJewuaRC6xzoyBlIa5v3NWN5WSYYOoFIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8zncel7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8zncel7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20CFC19424;
	Sun, 22 Mar 2026 11:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774180048;
	bh=/uhx2vnKfI9P5umHYonv7l6izl4XOAkgeAWZyH0NMtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8zncel7jPxiXul4VSSMo73mnqZQwGDIAj3fROQSMm9Sq3Pn7h2G+KpZv1iZvckgP
	 7R7r+Kkp5uAYvfGG9UO7zARsLsWOOkSIXYXyZOThZrksNqKJtaLGbJiqtr7IcJYOUS
	 KaA81YWjMLEJxD+48TFu16J5OGSw2XBWzNTCNrUkjKG8Rq56Ada44F9WO8IP6GoM6G
	 GxeInFOU4D1tB5Bwpy9SZSfy0/+MA4xO9eny8ZQZqi69bboBEifzjK7Jzn4nO9NNN4
	 MdhqzUBV7iyXbK4CLxBUq8t6xz05q0rmlVgMjtLgOpCA3NHlVZn5aMchwriB9n2U7V
	 +fU4W4kEiOj4g==
Date: Sun, 22 Mar 2026 11:47:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lothar Rubusch
 <l.rubusch@gmail.com>, Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5770r: fix error return in
 ad5770r_read_raw()
Message-ID: <20260322114718.11992040@jic23-huawei>
In-Reply-To: <20260312112025.57554-2-antoniu.miclaus@analog.com>
References: <20260312112025.57554-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 13:20:24 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Return the error code from regmap_bulk_read() instead of 0 so
> that I/O failures are properly propagated.
> 
> Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks

Jonathan

> ---
>  drivers/iio/dac/ad5770r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> index cd47cb1c685c..6027e8d88b27 100644
> --- a/drivers/iio/dac/ad5770r.c
> +++ b/drivers/iio/dac/ad5770r.c
> @@ -322,7 +322,7 @@ static int ad5770r_read_raw(struct iio_dev *indio_dev,
>  				       chan->address,
>  				       st->transf_buf, 2);
>  		if (ret)
> -			return 0;
> +			return ret;
>  
>  		buf16 = get_unaligned_le16(st->transf_buf);
>  		*val = buf16 >> 2;

