Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9C3264FD;
	Sat, 17 Oct 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792261099; cv=none; b=hHsGH2sGp8NHbGLyiVbxcuFIlygsBcSu7C4rHgP2+GeMSmtEbSO9b0mS7k1vTo/hBeQ48pnxp94tH//rYbuGO4vVdZ24EO4gk3aPY1JrzZhSgNLGVuYrWfGgU3yT7wybUmmg+fy6tihNQySv0dz+WexNzyQhdo7c/+kQy6wf+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792261099; c=relaxed/simple;
	bh=UJvrkUpwgAjUB8i4BUeu4gVGoD4bjBcXb1bdO/1K2fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iljym5b5E2J/1tgZEzvZ3IEYopkzdDunS1QKCPgdTgHjlTj3faT/3zUi1kjupgLTcpYGWv/91WthrriOnM9+VnrB/pHK6wy1BdZbDPfo/l0nbbnKuiemcYbUFTwYqPiQKbghMXBFOGlsB+ztOgDyN+PvYksKxcQCrKW+yvIZAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5MW4B/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5MW4B/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155611F000C4;
	Sat, 17 Oct 2026 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792261098;
	bh=2tybnaskFF1K3dm/+sU90/So1lPJtsLSrsZzRJnLBmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W5MW4B/gIHuOih+r9qZAnYOky/WZVCQqj1m/5FTmJ01pkFwpvHvwZwPXDrek509TS
	 JrQHhPFVHNhRivRuTVAag5CI2TM2p/R2eJEoLGfmIwXIDG0UlgQtuf3EssXLn1xiyh
	 +Xa4rM9iJe5XDvq/iQME/xp1h7A2/2a6nIQvRUEDy4Csg//aZD1U57Nkb/RUN9btQB
	 fsent+rqIQZj5oEYEApX4J7JcKByBSX0u9qJVJP5y0wbRabXtF1G6qDWfTLxS+FXBx
	 AiZsXMMn5BpkXyXMatn6g0uomhJ/bMl2eAVovAqeOBewQQMhiANxVTYCb4z9/I9ra6
	 M2rhfrgpJrnNg==
Date: Sat, 17 Oct 2026 19:18:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: ags02ma: Check for short I2C reads
Message-ID: <20261017191757.0e18754f@jic23-hlaptop>
In-Reply-To: <20261017094639.3002-1-nikhilgtr@gmail.com>
References: <20261017094639.3002-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 15:16:39 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Check that the I2C receive operation transfers the expected number
> of bytes before accessing the received data.
> 
> Return -EIO if the transfer is incomplete.
> 
> Fixes: d58013f39b30 ("iio: chemical: add support for Aosong AGS02MA")
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Hi Nikhil,

Given in practice we are very unlikely to ever see this condition I've
not rushed this one in.  Next cycle is soon enough.

As such, applied to the testing branch of iio.git.

Jonathan

> ---
>  drivers/iio/chemical/ags02ma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/chemical/ags02ma.c b/drivers/iio/chemical/ags02ma.c
> index 151178d4e8f4..2219965d044f 100644
> --- a/drivers/iio/chemical/ags02ma.c
> +++ b/drivers/iio/chemical/ags02ma.c
> @@ -61,6 +61,12 @@ static int ags02ma_register_read(struct i2c_client *client, u8 reg, u16 delay,
>  		return ret;
>  	}
>  
> +	if (ret != sizeof(read_buffer)) {
> +		dev_err(&client->dev,
> +			"Short read from register 0x%x\n", reg);
> +		return -EIO;
> +	}
> +
>  	crc = crc8(ags02ma_crc8_table, (u8 *)&read_buffer.data,
>  		   sizeof(read_buffer.data), AGS02MA_CRC8_INIT);
>  	if (crc != read_buffer.crc) {

