Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DC37475D;
	Sun, 15 Mar 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773599290; cv=none; b=ilHsVDl0b/rjzIUA0jigic0R4ZbWx5c/Hl60Ha7Ef6jVN3Jxkbn+fb872PLH3GTZ04xxUBC2eFvBKgWLn+fzKW744w17WPq7UYKjehWfkchh3JoxXOvgRuK0tDoHWeWSfdspkptj9UYdXVa4zSPA/thvAwCxf76vN7RHYpvJAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773599290; c=relaxed/simple;
	bh=KUrBhZ4glBlWaXxuJvL9Wcc826Blop4AJQQzEUbgSSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=podmT44qO13W4rJpxakMtLU4VktRoMs8SC1mvZiuMEPOZVDRngNT0UbhXAv3sj0xbWDG4HvnVcxNcf1LbnPTbfA0ENUx4WKW1r+PM+glK1GyOpn3GMNkJmYGWkn2esuuJw4MgIR5mo+WwNrLQwGxEvoQLkjzr/tFEV7+eKJsPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG5DsG4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG5DsG4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA1EC4CEF7;
	Sun, 15 Mar 2026 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773599289;
	bh=KUrBhZ4glBlWaXxuJvL9Wcc826Blop4AJQQzEUbgSSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bG5DsG4mcRwJWJJr87YkqrYMj3De2xH1JnycFnSnQ75/sgggOALCLKy189ZQPikuP
	 t9D5KWCarts7rfzU3sOhP32ZFYdJpQHKlYdjswomlwrxF61RfKw3C0fV14a0pg8UKB
	 892NGpQltX8fsgd37sy+6AIo7ymZ8T/iVDR4nPUb36mN/vHOCpro1YhrT1SLXYAAYK
	 4zTtO8QdFDGEk8kh6nlJ5NGPHfhui79xd15Yf/vTMcpfS0Ud4vLq9xMXpJH/qjGvWU
	 n8NZe8YwROLM2zuqgH5y79p4Shi7Xr4H0fTl7xXTCUt4aDJRbVNeu6vjZcDyLdL/Nk
	 +qnf4zhwPEZSg==
Date: Sun, 15 Mar 2026 18:27:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Raymond Hackley
 <raymondhackley@protonmail.com>
Subject: Re: [PATCH v3 4/6] iio: light: vcnl4000: add support for regulators
Message-ID: <20260315182759.58fdc57c@jic23-huawei>
In-Reply-To: <20260314-vcnl4000-regulators-v3-4-3c4a48d30676@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
	<20260314-vcnl4000-regulators-v3-4-3c4a48d30676@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 18:06:33 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> Add supply, I2C and cathode voltage regulators to the sensor and enable
> them. This keeps the sensor powered on even after its only supply shared
> by another device shuts down.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> Reported-by: Raymond Hackley <raymondhackley@protonmail.com>

Mixing new features and cleanup through the series isn't ideal.
Can we move this one to the end?  So do all the cleanup first
then add this new handling?

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 0ee307fc5ab7..e501db7249d7 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -24,6 +24,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/units.h>
>  
>  #include <linux/iio/buffer.h>
> @@ -1991,6 +1992,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
>  static int vcnl4000_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	const char * const regulator_names[] = { "vdd", "vddio", "vled" };
>  	struct vcnl4000_data *data;
>  	struct iio_dev *indio_dev;
>  	struct device *dev = &client->dev;
> @@ -2006,6 +2008,12 @@ static int vcnl4000_probe(struct i2c_client *client)
>  	data->id = id->driver_data;
>  	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
>  
> +	ret = devm_regulator_bulk_get_enable(dev,
> +				      ARRAY_SIZE(regulator_names),
> +				      regulator_names);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
>  	if (ret < 0)
>  		return ret;
> 

