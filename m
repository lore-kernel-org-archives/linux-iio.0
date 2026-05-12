Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5812368971;
	Tue, 12 May 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597675; cv=none; b=e7SHIfASqvDq1oP6V9TZeijJdaUBeDgaAdbaMg55KfHvfEl6ZjpGSaHDeSuZc7UiKS1T3x3N72DFZgouBxqjq7YZFRn8PR+3Ai/WptxmboaVlIEai0F6/qqYZ/HJiZuxKUtn327z05B71szzegMcr66avWGKFZResE54zHZLwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597675; c=relaxed/simple;
	bh=2DtjSnpGtV5CSN1MraOImOiHNLH93rL4y2MTn8WpX8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXUFOnCTimZRYXbKmVIC+bQzfco70bOY9/c5s7eLjEh/ZyRQlY2EeAIINchOI9n+H+f3jQuN2ZlCN2H/LqsTblwsGk7BCO+2Y6NP7wBGEvmfTw4650lbgjwq3lH9ygEICUqdY5M6UxXcv3goC2vsMqQnZlBgtQ9zVIJFBSm4Zl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1Eeo8lm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1Eeo8lm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED887C2BCB0;
	Tue, 12 May 2026 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597675;
	bh=2DtjSnpGtV5CSN1MraOImOiHNLH93rL4y2MTn8WpX8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I1Eeo8lmEQog31f3ftO4+a0bthXFZpzskkRlebMCQXG7xUE7KE7+boZQMX/mYQKQV
	 Y/J7XhYO0H0j/4OHlV6I53/WwXr5ESyuqL5bffUWp2ApXh9yI+RZPlf3Cmu4bz71DB
	 qWChXd1sjvCBhNb2FGH6ReWJK2OUIBPpgUT0bmtNioCGq4haOymzS1wE40E+vV+lwB
	 IF8tL1FGlNaEfCrcEwGCCYesoYeqDR7fsGm+1HhM7Wt80QqJJfxNGwtbEsXffj1PcZ
	 8SlDrLuYJ7naoYl9agOX+pHbVh5D3eE0doPpRKzqUdsFxzBJASIF9QutSJ3XJxPFWy
	 rAoIjmuwqoUYw==
Date: Tue, 12 May 2026 15:54:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/8] iio: magnetometer: ak8975: check if gpiod read
 was successful
Message-ID: <20260512155427.107df20a@jic23-huawei>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-2-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
	<20260511-magnetometer-fixes-post-pickup-v7-2-9d910faa28b6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 13:26:11 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wr=
ote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
>=20
> Add a check that ensures that valid data has been read from GPIOD. If
> not, log an error and return the negative read value.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Sashiko had comments but they were all 'whilst I was here I noticed' style
so applied.

> ---
>  drivers/iio/magnetometer/ak8975.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index b990c123e2808c2078abcfaf6b2ef86c09393e6b..63b6e8465f5f3873841550a1c=
d03ce86b95d1d67 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -658,6 +658,10 @@ static int wait_conversion_complete_gpio(struct ak89=
75_data *data,
>  				 timeout_ms * USEC_PER_MSEC);
>  	if (ret)
>  		return ret;
> +	if (val < 0) {
> +		dev_err(&client->dev, "Error in reading GPIOD\n");
> +		return val;
> +	}
> =20
>  	ret =3D i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
>  	if (ret < 0)
>=20

