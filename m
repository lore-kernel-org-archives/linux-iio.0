Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312613E0091;
	Wed, 27 May 2026 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906250; cv=none; b=kU1x2YQQO1/QDbOgi2A2Znr0gHEYDPLNLleD521og1DAT1Jw3koQhf2kW8zIJ0PEHKDkOJPlg8HO0iG9NQPd857v7RTSSDA0WDBqSlwblZHV5F+v10EQzaFR10JAwaU02MdQrRLnKVWqcXT159t01sxiLFi7YlrAX3v+2i9s3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906250; c=relaxed/simple;
	bh=OC0m2MsQh+gAaGhE5q8J++abu2d9kzMbR0o/jw7w05U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pppY14YSeLhkBShXAyZiElvM4bxR1cCJl0rlBZD8LiZo8t9CE8hmVa3QFjw3MqyG0zC36ZsSUJe9/k5+QlTazaaYS1+JSOVP1zeGsx5GaxWzlgh2bdjvAm145686frforCiINj3Fr9TopQFUWpaw6YNY6dDZIFNfKIT60+u1UHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq5X4EWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq5X4EWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC07F1F000E9;
	Wed, 27 May 2026 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779906248;
	bh=TETtRY5j7iIj+uBLH5AlBsdzFNqMI/2TXUQfmM4J+OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Oq5X4EWAxjP4pwGB72wtEA/kP8ft2J1FJUCR4reD2Zm/lmbEytJJaX33Ar9mbmuwC
	 5yqr6iAaCuULoZUgYc4fWdKD9DWqlo/vgjnC7TYxcvCqixIJw/Z6o/YfoqXEluptEZ
	 +7vZ9DYYMmwScCBf3lCJ3SLp0q2lAVgFdaKOit9Mbnesp05f3RQbPD1kMFCSTn7xRW
	 ENs2OmDCO1lXrnjqGkfbYijsRqvyJMCedhE9DfYNAjySKst0vV1V2XaknGK65QJHUZ
	 1dGpudbanaRJr9M+qbJHH1A8hwFaLO/R2rR1B9JTbIeUS8FyC7IoxVuOwuikvlu576
	 woMeu4qm7ry+g==
Date: Wed, 27 May 2026 19:24:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] iio: light: opt3001: switch driver to managed
 resources
Message-ID: <20260527192400.2defa821@jic23-huawei>
In-Reply-To: <20260525-opt3001-cleanup-v4-7-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
	<20260525-opt3001-cleanup-v4-7-65b36a174f78@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 10:20:21 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Move the driver to use devm_* functions to automate resource
> management and simplify error handling. This also allows removal
> of the opt3001_remove() function.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
One trivial thing in here. If the rest looks good I might just fix it up.

> @@ -836,7 +865,10 @@ static int opt3001_probe(struct i2c_client *client)
>  	opt->client = client;
>  	opt->chip_info = i2c_get_match_data(client);
>  
> -	mutex_init(&opt->lock);
> +	ret = devm_mutex_init(dev, &opt->lock);
> +	if (ret)
> +		return ret;
> +
>  	init_waitqueue_head(&opt->result_ready_queue);
>  	i2c_set_clientdata(client, iio);
Sashiko noted this isn't used any more so can go.


