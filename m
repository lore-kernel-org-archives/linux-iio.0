Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D17314D37;
	Mon, 29 Jun 2026 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774715; cv=none; b=mjkrBvsRqCda3FIHtwYkkRdXXYG0o0/32lVPKu5KgKWuSH9Oe3WwB0Orin6t9Z6phoOcTdsJG4qLAovecQ50gWw1nfxM2taQCmnTBpLxhpFspMiPL/H01/loyFudZaB4FHWb7LjAdUxnJvRjfz73CplsZzgG8vLfwiIq5cVZFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774715; c=relaxed/simple;
	bh=ZZ0UGOAeCoILpOiP+u0sGoq7qa/crFZTm/8spg9Zl3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQS6ArcXrp/tSHoFzI1WkjouaBc5QSMhTZsImdwdccpafAQKb8xqOG9zS8V1vGW0XEV+Q1uwxbobqadfzs4u+0badkHDR9kotdcnIGmk7wZwPmmRHRiU9+qvViDudpyUcTH3NafrfDN+KQn0j+feK5KfmL5ysvAHVfQj46RXIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKERiuyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKERiuyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18CD1F000E9;
	Mon, 29 Jun 2026 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774714;
	bh=lkcgK/QOqsOU1PJp0TwzJZhiunJltFZviceJ6zVLyfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dKERiuyM4bK3V6u8UN9Q5fpoarFwtXvWZ2eXTNsP8/FMGwLNSJrq3Khc/ULwwP9DM
	 39PDNstvvFKxUzIEmqugnMf0rgw665Nju3b1lHMMiGLr7Z3bL6Ah+kwJ1o7VdZmu7/
	 lT8JYctYw7ucCcK+VG8cwmVkp2yD90E4dRCBPEgNoJugIrH0/LWW8GdNUoFFw/SwV6
	 t4z7mCtcW5tJSvkMBwqM2ZoFgVEuU6lkuK1/XF4D2mntsy40zFPwR63MoCmsvownDp
	 hhyEiJiUXTSThYsqDOo13EFvyvShs8kxCcWoE33V9e+Pt3etDhLr2f8hLLUy3eQnYV
	 10QT5LnKs5CvA==
Date: Tue, 30 Jun 2026 00:11:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] iio: adc: ad7779: Remove unused completion field
Message-ID: <20260630001148.215a204b@jic23-huawei>
In-Reply-To: <20260628145734.77191-2-mokshpanicker.7@gmail.com>
References: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
	<20260628145734.77191-2-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 14:57:33 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> struct ad7779_state contains a completion field that is initialized
> in ad7779_setup_without_backend() but never waited on or signaled
> anywhere in the driver. Remove the dead code.
> 
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---
>  drivers/iio/adc/ad7779.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index 695cc79e78da..c1a99b4c1256 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -143,7 +143,6 @@ struct ad7779_state {
>  	const struct ad7779_chip_info *chip_info;
>  	struct clk *mclk;
>  	struct iio_trigger *trig;
> -	struct completion completion;
>  	unsigned int sampling_freq;
>  	enum ad7779_filter filter_enabled;
>  	struct iio_backend *back;
> @@ -852,7 +851,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
>  
>  	indio_dev->trig = iio_trigger_get(st->trig);
>  
> -	init_completion(&st->completion);
This will leave a pair of blank lines. Delete one of those as well.

I'd have fed that back to v1 if I'd gotten to it before you send v2.
(see reply to cover letter about slowing down a little!)

Jonathan

>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      &iio_pollfunc_store_time,

