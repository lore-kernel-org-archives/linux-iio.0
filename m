Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5B2D0600;
	Thu, 29 Jan 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703937; cv=none; b=RH4cPDoolPwX3P+j3glc66WrwXn+DNWGzQCAzzbCIs+1nO0Jw4nTUqmT/KRw2sOtN6avqtBMbuQYTH0/kbuOzxJv9HY/feVvXnvWM/HFyT7P5P0+Fx7dILWfhcfU6GJgbyODlngtWFE9LblZ4EwdDW6rgRVuk48t90y4NRPCF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703937; c=relaxed/simple;
	bh=v2rGdl2nXxAwfJQCwcw+me2RYsM0717WzPb/lOqYOHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZH/kwWbOm/WAknJ19eEHi40QWnB7NRKZ1S7oxP/JLMsbgXUNY/92AOLg3LbVkhMU7SOTLlsMmqdzkFfPo/yXac6sAWoyxUDWwDgfwiJ9D121H/wcE4PAWsstEyXrVii3MQdwXSImiBplXwqPiy0RLazFeibnxJdRaNmnfAKWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDo4mziM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDo4mziM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F339C4CEF7;
	Thu, 29 Jan 2026 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703936;
	bh=v2rGdl2nXxAwfJQCwcw+me2RYsM0717WzPb/lOqYOHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gDo4mziMIroavpBuqAGjvecLuQfTXZksRIhyby5FA7IlIt3+yeqYnlLJJ4ViYJCT0
	 uLMW49xJBwiYYpPj6LaFkiNizJRdYX4OZYb+vqBaj86ZDaimJlaw0n0L7WfdUTpbZX
	 3Fetf+Vy3JL3e9lmdjZXnEl66ToCrqvcrzlgkMp3ikfcybTvPLQvaA2krUVKeCOxui
	 vP+GkxY8AZ/o3bLyP3i8x6RkMVxGdivHdzdt03W9li6QOtAeMsewQEAeH42T8w0T3Z
	 eedayceI0Yd5pSrkyPmv+rizjSme6xLjlv0tIikK3x5mqStSm/pUW0NBgMNin3XPoa
	 nFtuVMpTNJO5w==
Date: Thu, 29 Jan 2026 16:25:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Andrew Ijano
 <andrew.ijano@gmail.com>, Gustavo Bastos <gustavobastos@usp.br>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: accel: adxl372: remove unused int2_bitmask
 field
Message-ID: <20260129162527.71616659@jic23-huawei>
In-Reply-To: <20260129141205.106285-1-antoniu.miclaus@analog.com>
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 16:11:57 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Remove unused int2_bitmask field from adxl372_state struct.
> The field is declared but never accessed in the driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
This one is fine so applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 46d518a2a029..9e4e8c8d9e9c 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -295,7 +295,6 @@ struct adxl372_state {
>  	u32				inact_time_ms;
>  	u8				fifo_set_size;
>  	unsigned long			int1_bitmask;
> -	unsigned long			int2_bitmask;
>  	u16				watermark;
>  	__be16				fifo_buf[ADXL372_FIFO_SIZE];
>  	bool				peak_fifo_mode_en;

