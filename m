Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB827CB02;
	Thu, 21 May 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362642; cv=none; b=h9GH/Ne3ucvusmJu3l9E++KhG93xeznSs3Uf5OK0CZ4WiuPwyw0hmWCeaZszRiK3n3o+YT2n2pGykpMOvAUz8C5Z3NfFbiGBZYlW3n5kq626SHL+Zx621YucKNpdYPvnPi4gth2vTPIliQdt9j88i+EdntyXMjlcwUUdeCG/KDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362642; c=relaxed/simple;
	bh=SJ+WTQlwX2pDBqZq2B1xBIAocG7W1D344UvQmPDTPRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSQj/ZKOjmE+ZQZKTd5QJdfPkJ5/ozG6RWqzlpkHC2CI9Vr4AxNzIjenqRlCxSE2+A/Fph2X0QOqV2wnX2oaEYZkdldqMnR4FRkQk3LsBpRMq142uM+zdiO3/zRnmxkLCTX5cXL66sxtF35aAKxYZ7grrHU10hdmTaD9wUCbHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bofFZjA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bofFZjA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798A51F000E9;
	Thu, 21 May 2026 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779362640;
	bh=zI99/srHQ3utOYJ8juohVO/8hsM8vSjkPp6N0rbxx7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bofFZjA6WfCSm6Ac1FjQP1upyaDskDeGe5bh7/LwK3rsaBWujpW6d3k2LE2s4mMgn
	 KyTw4dhWTORKR8o5o6s5tUmJUDsrZGZyHaCtiCrw5qlH80e4foXAVdIafWYTiIXeKs
	 HvbKqoDbDVtvfdPB7ibWa8naZheTM1MwHP/VS8iGuTX7AG4qc1kX+U6ZXuXQOaPorx
	 VglV6c+q9rkDmcvwMoGZgP4q7vtFo8vgtwdDGCtw4XtsOh3+HvSPlCFWOsdFj9xqpr
	 arDNX0zW8/hwjtg7a+8Nzedh4OELQkbxaXxMkjbATV5lEf1RRIRB/9me2tMBK77d3d
	 oYBAuGYW+6I/A==
Date: Thu, 21 May 2026 12:23:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Heidelberg
 <david@ixit.cz>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND
 DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: light: al3010: read both ALS ADC registers again
Message-ID: <20260521122350.1d705c8f@jic23-huawei>
In-Reply-To: <20260520175855.538098-1-grandmaster@al2klimov.de>
References: <20260520175855.538098-1-grandmaster@al2klimov.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 19:58:49 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> al3010_read_raw() used to read two adjacent registers
> until the driver was modernized using the regmap framework.
> That cleanup accidentally replaced the 16-bit word read
> with a single byte read. I'm reverting latter.
> 
> Fixes: 0e5e21e23dd6 ("iio: light: al3010: Implement regmap support")
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Hi Alexander,

> ---
>  drivers/iio/light/al3010.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 0932fa2b49fa..1800776d725e 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -111,7 +111,8 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
>  			   int *val2, long mask)
>  {
>  	struct al3010_data *data = iio_priv(indio_dev);
> -	int ret, gain, raw;
> +	int ret, gain;
> +	uint16_t raw;

Kernel types, and more relevantly as the bot pointed out

	__le16 raw;

>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -120,11 +121,12 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
>  		 * - low byte of output is stored at AL3010_REG_DATA_LOW
>  		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
>  		 */
> -		ret = regmap_read(data->regmap, AL3010_REG_DATA_LOW, &raw);
> +		ret = regmap_bulk_read(data->regmap, AL3010_REG_DATA_LOW,
> +				       &raw, sizeof(raw));
>  		if (ret)
>  			return ret;
>  
> -		*val = raw;
> +		*val = le16_to_cpu(raw);
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:

