Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D434B1AB;
	Sat,  7 Mar 2026 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883236; cv=none; b=eYaL/jPl56EfTZKjULXP6yiZdxWHQU17ef8Vd2kyBI2ZQU754YJW1o98KU9yQnsaFuuXKoVbNL+Zx3HhKLAux3tIHZnqzFcUto6mdaoR4dm1F6YyCmF5LFjTVliqeoo9mYWH8YtYkj3y/qNMCX0y0Y8XrYBVOS0c2bkCdzLJfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883236; c=relaxed/simple;
	bh=DX8+xCr22O9KlDW/8VXkPWhIAH0JAZqq/dxy7iBInlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMzFCAA8fb2MxrJgdrz2yK87nIlS7rsFa//Q9GG8i0DhtPcXSOG34gjfBUCsWu7oDfMuPpNRDOUIPl1bb7cWpC54GXpY0FGwts7ygf3F70BT5vqIze7G82LSHUXPfPYSkRQoQGmDIWlViNrnUEG2OMig7aZ64XTY/MG4iGNeBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVenn+or; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVenn+or"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C295C19422;
	Sat,  7 Mar 2026 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772883236;
	bh=DX8+xCr22O9KlDW/8VXkPWhIAH0JAZqq/dxy7iBInlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVenn+orq1t9mpXceRZch6cqgvRwUBM6vzvpguyo6OfWiN46yZ4k+Z49Lyr7Fef4w
	 5mzK5czQCQdNUshsFFRO9Db6oSAelZoxkKA+FMAyvKHao5WzrFzCEQFEZBdnUg/rUZ
	 0TPr9SN8eLiAnPNunxoU515lscAc4H/fhSjKoDzz4IiHgPJCgDlJf1TdCb9oJuvCKg
	 QVLvs4D0VGS4y79mn0yfKPAWyAX68HaN7CIYjnABBRx/Uk70sWBYsvqpY2+iCGqliz
	 6GqIQeRaU1fHnLwLyMKBKebKm5vol2w9zaTEEDEsaBYQWfWBWMMm0tyJpvUiGYuil+
	 QRQnM6vIVRRTA==
Date: Sat, 7 Mar 2026 11:33:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: iio: adt7316: refactor temperature
 calculation logic
Message-ID: <20260307113350.2d6c6862@jic23-huawei>
In-Reply-To: <20260305-adt7316-correct-macros-v2-1-3702e3841c42@gmail.com>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
	<20260305-adt7316-correct-macros-v2-1-3702e3841c42@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Mar 2026 23:16:58 -0800
Michael Harris <michaelharriscode@gmail.com> wrote:

> Replace the manual sign manipulation with sign_extend32() and change the
> affected variable from u16 to s32 to properly handle negative values.
> 
> Resolve a logic error where the sign bit was being checked at bit 10
> instead of bit 9 for a 10-bit value.
> 
> Convert the data variable to be in centidegrees celsius (0.25 C per bit)
> so we can use simple division and modulo for sysfs_emit() instead of the
> convoluted bit shifting and masking.
> 
> Signed-off-by: Michael Harris <michaelharriscode@gmail.com>

As Andy noted needs a fixes tag.

> ---
>  drivers/staging/iio/addac/adt7316.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 8a9a8262c2bec34f3c3e79d8174f492b9a23fb70..1412808c50c76a68b5771a25c46dd3308c5cbcdb 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -155,9 +155,12 @@
>   * ADT7316 value masks
>   */
>  #define ADT7316_VALUE_MASK		0xfff
> -#define ADT7316_T_VALUE_SIGN		0x400
>  #define ADT7316_T_VALUE_FLOAT_OFFSET	2
> -#define ADT7316_T_VALUE_FLOAT_MASK	0x2
> +
> +/*
> + * ADT7316 hardware constants
> + */
> +#define ADT7316_TEMP_CENTIDEG_PER_BIT	25

As it's only used in one place, I'd think just use the numeric value down there
and if you feel it needs more background, add a comment there.


