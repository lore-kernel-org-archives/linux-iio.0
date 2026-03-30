Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448E3B2FDA
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862159; cv=none; b=cM5rGOYI0EH8AaI6LjrvL/p4I0S2Vh3hF2nMdw+gD/KxW3wZif+pXpmy/pWf3oCa9rY6UcmP0UGcvUT4+kzoVY7xy6R4/zZk59Sw3iD3RL+k1oKF7QKsRMraiFEoUtJi2W0jmKS2utKnr6gHRyWyb2HdBEMayrrEbv+TE7f5QTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862159; c=relaxed/simple;
	bh=uJQJTH8moVmyTGveeKjRuEQVn/vWsWL+Z/zWmO3fQJw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKK15U7i2wusrxkEzgkVAqlefl7KlPvSC/8lGTn9EJro2r8x0Ty3VjBYF+l8nrZwYdR/tmfKXYXpAd2xhhd98p7eNRKN0Dm7RjwzF1J9XseVAmzzbI56nsL2oDVXGwv0/+V4RVLGcIbrYx+tmyqILvaoL9dLszIMB1N1hKyXnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfo/UdMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfo/UdMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183E5C4AF09
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774862159;
	bh=uJQJTH8moVmyTGveeKjRuEQVn/vWsWL+Z/zWmO3fQJw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Hfo/UdMp7wRSgbg3n0mDQs9o9oDFs+Qy9pp9syDgU968oTxyQa0opHC+Qo7Qj96ji
	 20ijtmiTev9HrE8M3cWexEdc3WfiJC6E3asrmW0rOIuHniyZDNwJoNQ87H8BvuzyWh
	 HslDcMLb9iTQ+7ZkYaQDovbiA8CWS8jaglEKL3agbnsO03Voq5U9/rLUKdWUeBPekE
	 cjDc1Z01OBSEipk+CK2pzaacYv/Azro32VE8Jlxi2y5Vms81RWbfpy15nytrxcQWo+
	 DQtfa/+4YE0bEZ0B+BsUggayiRq9pUm+NvMJhyEHj8dkbnsfVA6i/rSRRhpiC2euRc
	 L4XK4CpJmyRFg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38b13652c87so35540921fa.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 02:15:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNJEcEDC74QngWcdyQVmcMLXxIob96xmcbcJh8ON8NiKmeqSnB4FTPw8UEp2NPZkBwW2jTcwOE2+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJ67mfXFGhW+U0f9PbPB/6N2JC7ZN3CWRiJ6d+Mz9xqJdowHL
	LeSHj8UJCp0sHpeGvEipIDz4018HtZQ5nl6Y0PmMbm+POQZYzC74b/nofhq2tuwO/tvp1pKizwv
	g0hwLGBy/90G3QnyPT0rg5I/+V25apQdMo8rnX13j5Q==
X-Received: by 2002:a2e:bea8:0:b0:38c:6b7:ad47 with SMTP id
 38308e7fff4ca-38c730c292cmr40980991fa.7.1774862157784; Mon, 30 Mar 2026
 02:15:57 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:15:56 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:15:56 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260329-ti-ads7950-facelift-v4-2-c568c508c49a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com> <20260329-ti-ads7950-facelift-v4-2-c568c508c49a@gmail.com>
Date: Mon, 30 Mar 2026 02:15:56 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfZBTMfubuuZ7VoQw++H5-eGCNcPB+hPTyT10E9zgbgkQ@mail.gmail.com>
X-Gm-Features: AQROBzCrznh8qvkdO82M9irjc5XXTJL6cKCiVZd1tktP1qJ3tEXw85BcwGBhbEw
Message-ID: <CAMRc=MfZBTMfubuuZ7VoQw++H5-eGCNcPB+hPTyT10E9zgbgkQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: adc: ti-ads7950: simplify check for
 spi_setup() failures
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 00:47:07 +0200, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> spi_setup() specifies that it returns 0 on success or negative error on
> failure. Therefore we can simply check for the return code being 0 or
> not.
>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/iio/adc/ti-ads7950.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 6e9ea9cc33bf..c31c706c92a9 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -520,7 +520,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	spi->bits_per_word = 16;
>  	spi->mode |= SPI_CS_WORD;
>  	ret = spi_setup(spi);
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(&spi->dev, "Error in spi setup\n");
>  		return ret;
>  	}
>
> --
> 2.53.0.1018.g2bb0e51243-goog
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
