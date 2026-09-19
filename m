Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAC339366
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857227; cv=none; b=lt+K463MUE3JYsxEvMjvFa6OFOCy4YSZ9RkuPIMEpjhDjQ/03ZVRDGrrsthPoEmTsJ2Tid7A+946x83H1/ufxCLivAOtqqtYaXij2L+oZlq0bj3+LllVy/Oa5lGw89x7G454KxWvfGwxpgUuz9H2ph76g5wtCW+CqFifEEyfVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857227; c=relaxed/simple;
	bh=Nq8hmbT0klHnk+cmwfMkWkiE/aDzI8pSKmhkUGauk8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=bKq/QTl+URM/qW+I/fZZYyY/5yCtU0SwY558NJgjsD7vsWvvr8kFoFW05/9TdpYwW0ETjTTh56m95bGxYfam5uAoFgvQuurw4G6c+sKnXemzZRQtLCjljkGwGct6VKyqwJnZolPd4puEcecQt61jMt0pmwq0ZXSjgUE7PtNrnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=ihwKmsUn; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ltTEhZPo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="ihwKmsUn";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ltTEhZPo"
DKIM-Signature: a=rsa-sha256; b=ihwKmsUn2KDZi4rfrFRi/q5H70xz85n6nR5cMQ6W1q0NbohkPSm0fhJvmH01Ug8i+Ndns6S1ycwuiCX0xeenCro80KQ+2uA7rROo1Yv/WdwxK9HoTk0osxoX1kXS+MffrnFPm8Nov5l8OvEoFHr+xW9cdWl+RQXpMWNw+74f5OUCGt2UvU3tlMbX//TRE1gA5OM9+QAd9SAtmw7XuhmxQFT34X5lmhXMFuNN5kxwvsTE87f3rPRpJp3DPFd+pn9xWFn/4LJxlTkB/TEM5K8EHOQV/QaN/NY9yWYXET45TM5PnoJ2cvYadUtA2GDviUS0hp+bQ1K0sFH3hFx7lq4Jig==; s=purelymail2; d=maxwelld.cc; v=1; bh=Nq8hmbT0klHnk+cmwfMkWkiE/aDzI8pSKmhkUGauk8k=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=ltTEhZPoQn/WDmKnbEoDC4AM4vqz4GUfH54yDunqAOm9SrGviN0cHuFx1F040xJ0pk/xcyBInTKH1ApBJGjoXeFx4b3StCigmWi8h9EGYh6u9usb2Ux/huHzE8TWXKP4e5SJec/I8xBRIspg6YtmHvBSfbClexktSWob2tX8ZdmE+MbvlTkAnOEQc8Pampb82FcQRKCgK1YtTzsXKGjcMT3kpA+MWjcWPYahbiml0hWWf5EL9ukTYlWbSfzxTcgeQudSfI0p28tNHFkSfjcE7NpYXGcAhNvPk5+yGIW1iqbASZLJC7wgj2yXRwh5yQrvsYnyTdtoFKNCNnOXDg2hWQ==; s=purelymail2; d=purelymail.com; v=1; bh=Nq8hmbT0klHnk+cmwfMkWkiE/aDzI8pSKmhkUGauk8k=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2110463059;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 19 Sep 2026 22:33:37 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 17:33:36 -0500
Message-Id: <DLJNFI3A4WZ6.1PWFZJRQIDLZA@maxwelld.cc>
Cc: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>
In-Reply-To: <20260919195507.94130-1-thefireking@gmail.com>
Subject: Re: [PATCH] iio: adc: mcp3422: use sysfs_emit() in show functions
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Angel2Eyes" <thefireking@gmail.com>, <linux-iio@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260919195507.94130-1-thefireking@gmail.com>

Hello,

On Sat Sep 19, 2026 at 2:55 PM CDT
Angel2Eyes <thefireking@gmail.com> wrote:

> sysfs_emit() is preferred over sprintf() for sysfs show() callbacks
> since it is aware of the PAGE_SIZE buffer and has built-in size and
> alignment checks.
>
> Convert the remaining sprintf() calls in mcp3422_show_samp_freqs() and
> mcp3422_show_scales(). The formatted output is unchanged.
>
> Assisted-by: LLM

Pretty sure this should be the name of the LLM used (feel free to
correct me if I'm wrong though).

> Signed-off-by: Angel2Eyes <thefireking@gmail.com>

The DCO requires the use of a known identity (e.g. <first> <last>),
but this does not seem to be one.

Please read Documentation/process/submitting-patches.rst next time.

> ---
>  drivers/iio/adc/mcp3422.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 36ba00edf..fd9e72265 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -262,9 +262,9 @@ static ssize_t mcp3422_show_samp_freqs(struct device =
*dev,
>  	struct mcp3422 *adc =3D iio_priv(dev_to_iio_dev(dev));
> =20
>  	if (adc->id > 4)
> -		return sprintf(buf, "240 60 15\n");
> +		return sysfs_emit(buf, "240 60 15\n");
> =20
> -	return sprintf(buf, "240 60 15 3\n");
> +	return sysfs_emit(buf, "240 60 15 3\n");
>  }
> =20
>  static ssize_t mcp3422_show_scales(struct device *dev,
> @@ -273,7 +273,7 @@ static ssize_t mcp3422_show_scales(struct device *dev=
,
>  	struct mcp3422 *adc =3D iio_priv(dev_to_iio_dev(dev));
>  	u8 sample_rate =3D FIELD_GET(MCP3422_SRATE_MASK, adc->config);
> =20
> -	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
> +	return sysfs_emit(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
>  		mcp3422_scales[sample_rate][0],
>  		mcp3422_scales[sample_rate][1],
>  		mcp3422_scales[sample_rate][2],
>
> base-commit: 69fa76f0af3414cc189c3b0b807cb59e327ecc00

