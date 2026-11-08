Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096242;
	b=xHtMLy36hKrRI9gOnFg8SToT9Jrlv5x9PG0ILBG9xfZ1DGa2rWTeXCagjVt2LWHNDHyw
	 6o5cvW8Ls0zXy8VyBCidZSLHOe6f4WrJsJiJIav1p05EAYggM6o7rxgXutsitTEJoA9Tw
	 8yORqPhyBEg2DVAqjR4H4+LlEcJb5/xw4yopBaQpEClX7yBdaSj2NckHM6qSiJf+ZgvF7
	 xqlOz+1pgG4gnEa8OqTCAznwEJstG+cH1/vdt7UhdTpMy41XAW0AEJdWlnqiCG4R8xsPG
	 dSw40uTy2aUugDZRtVuFAllFYI14m4TkiejJEHoglORO0AqPWd+gsogKtn88STXbXfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096242;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/s3GtWBn4vO81epFmrbwaz60Z3/jK514SYAfdbFW67A=;
	b=XvI+yeRxIfRauT6ExTqwbAlWt5Jnu2ghpwDiqdKZB+mD1ljbAWgAD/2/4SmsVTbQ41TU
	 IThV1nC23drIGyU5nITylpa2qZ7LHNKGuBm5/4xjwvjNx7o52X5V8KTDIyefVMUPbmANs
	 Dra56B8kdoXCatukFEWVcJMHdLNvzSg03gVHJFIUN8m9z4+pRVW459KsZJrVpYLb8VnCS
	 OkUZ9qJRrlKJJBdPYpb2qhDJkxK/x3ahtNBAYEUWp4wGasqpaWFSEG4D8Z+5ddD+rKatC
	 04GoHRrz5Hhbuoc9ZcX3iLjy0tSjj/iRoer6NBkQAU546ocLZs2zD2EQffY95i+4qGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csHQCDHR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3B606A326;
	Sun,  8 Nov 2026 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csHQCDHR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4975D1F0089F;
	Sun,  8 Nov 2026 00:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096241;
	bh=/s3GtWBn4vO81epFmrbwaz60Z3/jK514SYAfdbFW67A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=csHQCDHRlsMm9RFiLLSzdI5o8EMfD5mn0L6Ty4LrQ7+GpV5bQ8u/YvM220pGy4kYz
	 oILAOxIvHgU1vBeaLBQa6fNSb01SohdFSe7l0s7DpG7PrE0vX2wCj/o9W9/udGcz5e
	 KF595AIa9I/hUAEBEcDj0xFKKotGjdfpAV8k5tpaN6hFDCXrXuALlvx6TAjW6UNvsD
	 diWtAILoGakaBxetkuI3UDZlD4Wz21jOO3ZDP0k6ITlIK0UbEFc406S7DE1xVWF+Kf
	 JHH5bL8P/GeUuN72CLC6J9SRWdqeS03SWKXwEH/2ysrZYqWDiJhjZi1s0kv/Es+7Zo
	 W3G/ppNS/4TyA==
Date: Sun, 8 Nov 2026 00:03:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kyungmin Park
 <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: light: gp2ap020a00f: Enable the core and I/O
 supplies
Message-ID: <20261108000354.2e673da9@jic23-hlaptop>
In-Reply-To: <20261108-gp2ap030-v1-3-55314eb7055b@kernel.org>
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
	<20261108-gp2ap030-v1-3-55314eb7055b@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 08 Nov 2026 00:31:35 +0100
Linus Walleij <linusw@kernel.org> wrote:

> Enable the optional vdd and vio supplies before accessing the device.
> Use managed helpers so both supplies are disabled on probe failure and
> removal. Continue probing when an optional supply is absent, while
> propagating other errors, including deferred probe.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/iio/light/gp2ap020a00f.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index b435dc5e8706..62c4beb20cce 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1414,6 +1414,14 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
>  
>  	data = iio_priv(indio_dev);
>  
> +	err = devm_regulator_get_enable_optional(dev, "vdd");
> +	if (err && err != -ENODEV)
> +		return dev_err_probe(dev, err, "Failed to enable core supply\n");
> +
> +	err = devm_regulator_get_enable_optional(dev, "vio");
> +	if (err && err != -ENODEV)
> +		return dev_err_probe(dev, err, "Failed to enable I/O supply\n");

Just use devm_regulator_get_enable() and the regulator
framework should supply stub regulators if they aren't
specified.  The optional bit here is for when we do
something different if they aren't wired (usually for IIO that
means using an internal reference rather than an external one).

Jonathan

> +
>  	data->vled_reg = devm_regulator_get(dev, "vled");
>  	if (IS_ERR(data->vled_reg))
>  		return PTR_ERR(data->vled_reg);
> 

