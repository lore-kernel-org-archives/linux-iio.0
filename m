Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D9414A2F;
	Sun, 18 Oct 2026 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347722; cv=none; b=EAS/ns0w2I9B456lsQxRltVJgc2/NcQNQsoDgzP4dyDPm5TEU0Cjc5CtS4xnpnVrPJaeEW7N9RbQv2voH3uafoVPpfTdsRFgOuSu7jCNR2QNvTZ8+uk3LKJzibWzNLsBlN5s150uff38JSAF0NxseN0r7Jar1sQitGQpyyQQGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347722; c=relaxed/simple;
	bh=xKWI8VHYlBY/HTmh+M8x6260lLCjIcPCV0ddDwMCfQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqdGgxj8PTngdOr5MTynvd4UIHaw8Y+ZnL89SekBWmFc4/yOIigYTnhz0403BX6tWi6TXpr/78zOq86ZxkekYcASDFiH/XkxZj6ejNlSm9p6v096ycTn3wDCAUb83AsJuMDQgLqv9YtTfxa4WZBwv8z5p/956jpMTyK4r0o8qL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmzX3MEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmzX3MEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D519C1F000C4;
	Sun, 18 Oct 2026 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792347719;
	bh=XBs2FXCA6qnCpb4CayYP/c3nAPMcY0TUyFp21jMm66w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NmzX3MEpZIqBgelyzK3oZOmsCnNovPpyEXrbkMmncB0Cr3ncA4BO4LjzADF6fjR3d
	 JT0xbPkYjRh6EB5m60owfgrTFGxw7T8s1Jl3RURC1yajufbYpG58Vcw/greBh/zatT
	 /aNLzy42xuoW30vODYC+RvUg//aLEdZDolZsyXkZhK5CzMZe5oMRphimRYiW58jnNj
	 htrltR9Pnyu57FZxxSVGJY6C33L1XmaWOt19p08gKBJ6AJPti0qBwbJ1U0+3pgJbrj
	 x0XJ8xB/GFmV4HJ08ZdgdQbDh50lWXz8S7NdW6MDVcFFkbV4rpO8ADKexmbeIwgIoA
	 EhMEItVIrv+8A==
Date: Sun, 18 Oct 2026 19:21:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Dan
 Carpenter <error27@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM
 aux device IDs
Message-ID: <20261018192151.1115a40a@jic23-hlaptop>
In-Reply-To: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
References: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Oct 2026 11:11:54 +0800
Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:

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

Fixes tag?  Just replying to this thread is fine rather than sending
a v2 just for that.

> 
> Allocate the id from a driver-wide IDA and release it from the
> auxiliary device release callback. The ADC_TM driver matches on the
> device name only, so the instance number does not affect binding.
> 
> Assisted-by: LLM
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index c68c6c5f6aca..f0b2544c1632 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -15,6 +15,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/idr.h>
>  #include <linux/iio/adc/qcom-adc5-gen3-common.h>
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
> @@ -608,7 +609,14 @@ static void adc5_gen3_delete_aux(void *data)
>  	auxiliary_device_delete(data);
>  }
>  
> -static void adc5_gen3_aux_device_release(struct device *dev) {}
> +static DEFINE_IDA(adc5_gen3_aux_ida);
> +
> +static void adc5_gen3_aux_device_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	ida_free(&adc5_gen3_aux_ida, adev->id);
> +}
>  
>  static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>  {
> @@ -642,9 +650,16 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>  
>  	aux_device->n_tm_channels = adc->n_tm_channels;
>  
> -	ret = auxiliary_device_init(&aux_device->aux_dev);
> -	if (ret)
> +	ret = ida_alloc(&adc5_gen3_aux_ida, GFP_KERNEL);
> +	if (ret < 0)
>  		return ret;
> +	aux_device->aux_dev.id = ret;
> +
> +	ret = auxiliary_device_init(&aux_device->aux_dev);
> +	if (ret) {
> +		ida_free(&adc5_gen3_aux_ida, aux_device->aux_dev.id);
> +		return ret;
> +	}
>  
>  	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
>  				       &aux_device->aux_dev);

