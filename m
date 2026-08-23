Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997836C0AC;
	Sun, 23 Aug 2026 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447075; cv=none; b=WIhIy/K/itARnfEKz6mqyPuOaEZyk6k8pVqu4h702tFUfrUDrLchUimLcwjBdm8yDEqRYwp6q0AIZ8w7Kcze1TCjV8H3AlABhvW3XZOCK+QVJ1wWdVyfRrfzwPdq1Id7QTIx6XxV4Qr4Jmd9+6FcrQmbCmiUXbhTlDl9r6zo7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447075; c=relaxed/simple;
	bh=fXUps5RSUnOeRRUhcUgbTwGv3G5IirITcq300NZTPq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJ66/QYaPGrMXQHuhKoI7H+JDqb6Mh7AnlbmEZWs4HHc1cihTLHswxHBJUTO7hG8gh/vntOVb+tmC42DIHYM8+Eel4jwLup1VdN2SdMQPdN3l4KoNikpJvgKCPsyYMOuk2wyYFHxOGwadXKf9CI1MhaxDPwUHbOoGb8KQf+nu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5wscc3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5wscc3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA6B1F000E9;
	Sun, 23 Aug 2026 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787447065;
	bh=yBy3cr4heK17qneA6FHKNxB/ekan5Yw070947ptpcGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D5wscc3qCD68Ot0a6/azQQ9geKBdzow6TnE+r0viWOyv09Q2e7mgHd4ERrlTIutNx
	 BwpJLWvotE97EB6dKka2VKw+TXm4Qtv7A4ZY3BS/XMc6npiseBTJzAb1TM/0mXwd6W
	 GoWGo2jq6MO2LfQ5tl3OGubgiXxA8J90Vxh6UhXs9YxGRPKVJqtfnmlvNvVTZb85Bd
	 p6bpLGyCs3CZC8tMRUwsyOnEItkZGkYcRbRrqV+jBTXHunLxXwfIFpc2U+HAlvqyUI
	 tcm7R/SOcOrNCBiUVmHCogpm4zu9QtMDgEF3jAk7nqZiBza/a8OhRUzEBOuanjeq8r
	 wxRJrcHwP1dGg==
Date: Sun, 23 Aug 2026 02:04:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: admv1013: fix wrong channel field used
 in admv1013_read_raw()
Message-ID: <20260823020419.32c7731d@jic23-huawei>
In-Reply-To: <20260819175119.6235-1-salah.triki@gmail.com>
References: <20260819175119.6235-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 18:51:19 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> admv1013_read_raw() switches on chan->channel instead of
> chan->channel2 when handling IIO_CHAN_INFO_CALIBBIAS. The channel
> field only ever holds 0 or 1 (see ADMV1013_CHAN_CALIB()), while the
> IIO_MOD_I / IIO_MOD_Q modifiers are stored in channel2. As a result,
> the switch always falls through to the default case and calibbias
> reads always fail with -EINVAL, even though the corresponding
> admv1013_write_raw() path correctly uses channel2 and works as
> expected.
> 
> Fix the read path to switch on chan->channel2, matching the write
> path and the actual channel_spec definition.
> 
> Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
This one is 'obviously correct' enough that I'll not wait long to apply it

Applied to the fixes-togreg branch of iio.git

Thanks

Jonathan

> ---
>  drivers/iio/frequency/admv1013.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> index b823adfb0f70..bb06a94ccc50 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -195,7 +195,7 @@ static int admv1013_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		switch (chan->channel) {
> +		switch (chan->channel2) {
>  		case IIO_MOD_I:
>  			addr = ADMV1013_REG_OFFSET_ADJUST_I;
>  			break;

