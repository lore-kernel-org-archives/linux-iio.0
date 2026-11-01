Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554384;
	b=J4SCUrBbvBarVlNIV7YHAoMdAlv3y3tKPfZxOkQVgMKIExZ0K6cK3XUYiIJ3dVMH7CE3
	 52S+yTR8HIYK6Op0Y9eyr5dlwfl3pHRaBY4oVEmVqxU1VF5FxLVkJmEBLyYq/XHlboTFQ
	 0o0BY8QJ4F9mAJUrK8eB1ThYrcnZM0MfKKE7YVekuZ3Dr2+2jYDtheTKjWlr+aDuDVX68
	 Jsf0jZkhF4kFoB2ShD9xHL58b0IvzWdIPHYLaQUJfMceLurvj8pRRxFokHzz9TGxONJA8
	 qbvGkQImzDyQGYP1D1+J9CE0GlRO5u4KQIKpPH5pKeozFfsiCFuPdS8mcrTt49TNQWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554384;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rKDKdqiuP8JwhfiJEYWPe4NEvJLoTWkNtFeXAkjaCNM=;
	b=g3L9UQqWD29SHAF+0P0QhSIdiYHscuGEUFRrH8GbQM/rlqT4I8JZKqEZ4gVtDYdYMbZk
	 joMFV0N4JOlJ2d21c9/QgqLuRF1r0XNm0w/bJDcRRSfopT8htsvnF5qQQZvBGQ36fJaEw
	 Ew5+sNiMWOPAqfwSbZMto6TnR+CKxVYq+d0g5k3rVtEtfPy+kUwzXGkOekohr2zlGjgBs
	 5EofMfnwaPREh0/KTXOTgVMLokqEg2rCCKOVfL/Yp9D8o9WMqjXd58J59Epy5SB1BS0yG
	 l8MMziHti+jXmI62/qyg4xMvU9KK/AAk46eD7YczkZQv4wZiv9x67cTf++bt/AfAb1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7U6xdHO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801E606A324;
	Sun,  1 Nov 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7U6xdHO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC2C1F000C1;
	Sun,  1 Nov 2026 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554383;
	bh=rKDKdqiuP8JwhfiJEYWPe4NEvJLoTWkNtFeXAkjaCNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L7U6xdHOUxXY434uAfd4bXemYytCddkoNHy1G4jVJgMeDfK0QGTM0KbdxvHtD/YO1
	 mcroG/MWCvxM7bBKHQ1AvAAqIVhibibqEO8F2+N7dF0snCvk8RxhG51vmqhjt1rmm5
	 dJ6tHWqc8+1c1zUJ8mi2QaVayA5i7A9z8r2cF4DuL8K9EQ6plYRlZTJ4C9CTx7aCxl
	 N8JkuNwUogi27tdn0+p/GuRvZYVpuTZNFnnrPdLXT9etYzGA/tU0VcdssNvAczISIS
	 9dHuo3InUzkFYbVNBFH0xjs2HSCUrOTnTX48rnB911wHB3UId9cmYKUMP80YSmHTXa
	 ljZc0jeARr5YA==
Date: Sun, 1 Nov 2026 17:32:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Reuse IIO device ID for
 ADC_TM aux device
Message-ID: <20261101173256.5ad42925@jic23-hlaptop>
In-Reply-To: <20261101030902.1387122-1-shengchao.guo@oss.qualcomm.com>
References: <20261101030902.1387122-1-shengchao.guo@oss.qualcomm.com>
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

On Sun,  1 Nov 2026 11:09:02 +0800
Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:

> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
> every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
> to register the same device name. With ADC_TM channels on more than
> one PMIC, the second instance to probe fails:
> 
>   sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_spmi_adc5_gen3.adc5_tm_gen3.0'
>   ...
>   auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device failed!: -17
>   qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Failed to add auxiliary TM device
> 
> The ADC probe then fails as a whole, so that PMIC loses both its IIO
> channels and its thermal zones. This shows up on Nord, which has
> thermistor channels on two PMAU0102 PMICs.
> 
> Each ADC instance already has a unique IIO device ID. Use it as the
> auxiliary device id instead of allocating one from a separate driver-wide
> IDA, which removes the custom ID allocation and release handling. The
> ADC_TM driver matches on the device name only, so the instance number
> does not affect binding.
> 
> Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Applied.  Given the slightly odd nature of this series, Loic can you confirm
you are fine with having the authorship + Sign off.   Given alternative
would have been Shawn having that and Shawn sent this, the attribution
seems fine to me - but best to check!

Thanks,

Jonathan

> ---
> This is the squashed version as requsted by Jonathan at:
> https://lore.kernel.org/all/20261101020047.66034613@jic23-hlaptop/
> 
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index c68c6c5f6aca..a23eb5c9096d 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -610,7 +610,7 @@ static void adc5_gen3_delete_aux(void *data)
>  
>  static void adc5_gen3_aux_device_release(struct device *dev) {}
>  
> -static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
>  {
>  	struct tm5_aux_dev_wrapper *aux_device;
>  	int i, ret, i_tm = 0;
> @@ -620,6 +620,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>  		return -ENOMEM;
>  
>  	aux_device->aux_dev.name = "adc5_tm_gen3";
> +	aux_device->aux_dev.id = id;
>  	aux_device->aux_dev.dev.parent = adc->dev;
>  	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
>  
> @@ -799,7 +800,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	if (adc->n_tm_channels > 0) {
> -		ret = adc5_gen3_add_aux_tm_device(adc);
> +		ret = adc5_gen3_add_aux_tm_device(adc, iio_device_id(indio_dev));
>  		if (ret)
>  			dev_err_probe(dev, ret,
>  				      "Failed to add auxiliary TM device\n");

