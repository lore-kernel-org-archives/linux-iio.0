Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA5236453;
	Sat, 14 Feb 2026 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771091094; cv=none; b=XC3thc2wZrxnXvcMndBKZrAFg4OlBTRmMdLnwdquy9jXOiuKmpNYN91dMf9jif3yttqapks52iHAJO+6/N/o54G7phJz1V6c6TcYWBO14NoO1LPIcZRdTuDV2IdOGg+had/76FFt1ZPOv/Vxys6hLmib+LhS95wEbXYP4DYWcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771091094; c=relaxed/simple;
	bh=eefEOVlmmdXmUyQfqRBW4XcAzkISHcfESW9IR+ttmUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjewCK5OULmrt6KV+jwsyOOK8MZwns6hKtZov11ZNoWUfQDObwiTl64Hnk8+YiYabwJnT5FkHHM9DD/HVJ0pKf+kOMvz9ANRHiCZVeqgXCQ/cnKtSDijy4+281nXt5VCbNf3GYVSQEJR4ja1OwhyuolhGDQW7ORMXjWf9EuPR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGgn2CEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGgn2CEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B86EC16AAE;
	Sat, 14 Feb 2026 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771091094;
	bh=eefEOVlmmdXmUyQfqRBW4XcAzkISHcfESW9IR+ttmUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gGgn2CEMz/zWmxYkDgecSUlOy8/RF1LGUESHDHjHjUbUXm/jIYpT2zWEAlJyh8AkN
	 SqrAykRQPcQ+l7qdR7953C9n4f73Joiy8TkIk9UpVu1dbD9q7GIs4vkvMDnlgYjiL5
	 93MjcYV0aNsxP1Xa64LTg23FIopwxMUvy25WnyrQVYkmGYMb0YsUDRS6NLhSj8+/6T
	 zZgQCDDPsjh1euDFjMWP9Zy5sNsm6ku90qZHKm2TlEZMXswlWWIlk023/YpAs1iaEh
	 7nWEB3Va17XwAEr8aJBYHosdqDaOFuomkuTUivdf56J2eRRRJ4IitTdqlI8FdgZgiE
	 UBRX4TyqmOByw==
Date: Sat, 14 Feb 2026 17:44:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, yasin.lee.x@outlook.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 4/4] iio: proximity: hx9023s: support firmware-name
 property
Message-ID: <20260214174446.1d850785@jic23-huawei>
In-Reply-To: <20260213-upstream-20260219-v3-4-df9371d29f5c@gmail.com>
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
	<20260213-upstream-20260219-v3-4-df9371d29f5c@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 23:14:46 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> Add an optional firmware-name property to specify the firmware file.
> If not provided, the driver falls back to the default firmware name.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
Applied 3-4 to the testing branch of iio.git. I'll be rebasing once rc1
once it's available.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/hx9023s.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index 17e00ee2b6f8..9efaa5b6b5bd 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -1088,6 +1088,7 @@ static int hx9023s_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct hx9023s_data *data;
> +	const char *fw_name;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -1125,7 +1126,9 @@ static int hx9023s_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "channel config failed\n");
>  
> -	ret = request_firmware_nowait(THIS_MODULE, true, "hx9023s.bin", dev,
> +	fw_name = "hx9023s.bin";
> +	device_property_read_string(dev, "firmware-name", &fw_name);
> +	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, dev,
>  				      GFP_KERNEL, data, hx9023s_cfg_update);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "reg config failed\n");
> 

