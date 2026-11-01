Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498456;
	b=GJA2vLjdw1c1f5pjIFy4zL4FiN3J6u+xshkOLBcw8Bow++M1G6RO11h2aNVNi1qoJSO2
	 oM5D1BGSLvgf7EwUPyqicUZht7s1HMFNxbOwPZKcPwYZ7sxWt/oS6q9tugL4sJ8p7xz7s
	 lzETzno7iFApGaFuiH8MtHRJgJXgt/pUWiZ+TjIeSCjMez3lAq9TFlwKqASyWMQznoUVg
	 pF61k9pX4QYf1scH8oDnGzvnaAPDvyqLMvC/srEg5TSymigZcd4usOso9Cm+3ktDY6+Vs
	 SZk1/bAZchEYGS725dWsFzEI2O26RzWTLLEO8a4VVImpg5iEAtldoxUTTikKMlirIxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498456;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=55EAfDGPUHZz7T0vufY3UxzR1Z8zYzzLlpJPntYQtP4=;
	b=yktke9189GqvABfosYMcEZQbqP9qIpCRyd7fWP/wOTmId7eZFh9uYO9tgs4Vrz65Eqwf
	 xdccvlIfDCxQ1OE/WbdDlNeGJ8w8kMtL890WNzZ58jHHRi5x2P0n4CtN6jO9nKscN6KxO
	 Ql7FeggvVYKWCo32zw/lZiAyKJlDz6dg5OVsOKUbV2BApX1tkAbpqvuRPE3LxJe7jB+eJ
	 CosFZgJlg5cwAH8kpwhvUwiLfBqZE4ALGtNZGevQiY7fqEZiBKcOHXnnNOnfEdF3nvTHP
	 ILndpGHTR5x5IpUHQ3JAkpqToHSQpsGVEX3zBEo5axpNtmE53exX7yq5IM+rn4R4MuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGJioGUB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3A606A324;
	Sun,  1 Nov 2026 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGJioGUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E551F000C1;
	Sun,  1 Nov 2026 02:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793498455;
	bh=55EAfDGPUHZz7T0vufY3UxzR1Z8zYzzLlpJPntYQtP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JGJioGUBgGf7C6p4yUcDFwJpgekjIxoAt297KuWOZyQ7tL3c6V63cMaZ/AoA8XInS
	 fw4bPvGl5YEiVuM1l0SL2pMXpz5VfCuY7MOGzdemsK3SC21i1g87jQg180fralhX9y
	 Yt2+/mCyTPqU/R0NTQbxtGfp2WH2I0hyz9U/Uj2xR2AXamvGQLTM58J3ndv0fBppz1
	 CaZSKzobrtRkseOA0gr+bMp4BzBNi/qIgLBrI476OQn065U0UWZvMvjHbP1c80FYhV
	 HZQ29ehPe90C7qewihm6oJBBZBC55nme3UHSYrw5eLSlDyqXKV3TXFqQlUsM/g+tlV
	 PhWGFHXLbuPKQ==
Date: Sun, 1 Nov 2026 02:00:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Reuse IIO device ID for
 ADC_TM auxiliary device
Message-ID: <20261101020047.66034613@jic23-hlaptop>
In-Reply-To: <20261028-fix-adc5-tm-v1-1-0018aabc06c5@oss.qualcomm.com>
References: <20261028-fix-adc5-tm-v1-1-0018aabc06c5@oss.qualcomm.com>
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

On Wed, 28 Oct 2026 15:09:47 +0100
Loic Poulain <loic.poulain@oss.qualcomm.com> wrote:

Hi Loic,

> A recent fix in ADC5 Gen3 driver allocates a dedicated auxiliary-device
> ID through an IDA to ensure that ADC_TM auxiliary devices receive unique
> names on the auxiliary bus.
When talking about another patch I'd refer to it by name and ideally
also add a Link tag to the lore.kernel.org for it to the tags block.
I think you mean:

iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM aux device IDs
Link: https://lore.kernel.org/all/20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com/

> 
> However, each ADC instance is already assigned a unique IIO device ID.
> Reuse that existing identifier when registering the ADC_TM auxiliary
> device instead of maintaining a separate IDA solely for auxiliary device
> naming.
> 
> This removes the custom ID allocation and release handling while
> preserving unique auxiliary device names across multiple ADC instances.

> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


The fix hasn't gone upstream yet (assuming it is the patch I think
it is!).  Would it be better to just squash this onto that patch
and avoid having to care about a version of the intermediate code?

+CC Shawn. 

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index f0b2544c16322374644ac3a2eda63322f318e25f..a23eb5c9096d765af7d76ad66b50ed895782b256 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -15,7 +15,6 @@
>  #include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> -#include <linux/idr.h>
>  #include <linux/iio/adc/qcom-adc5-gen3-common.h>
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
> @@ -609,16 +608,9 @@ static void adc5_gen3_delete_aux(void *data)
>  	auxiliary_device_delete(data);
>  }
>  
> -static DEFINE_IDA(adc5_gen3_aux_ida);
> +static void adc5_gen3_aux_device_release(struct device *dev) {}
>  
> -static void adc5_gen3_aux_device_release(struct device *dev)
> -{
> -	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> -
> -	ida_free(&adc5_gen3_aux_ida, adev->id);n
> -}
> -
> -static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
>  {
>  	struct tm5_aux_dev_wrapper *aux_device;
>  	int i, ret, i_tm = 0;
> @@ -628,6 +620,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>  		return -ENOMEM;
>  
>  	aux_device->aux_dev.name = "adc5_tm_gen3";
> +	aux_device->aux_dev.id = id;
>  	aux_device->aux_dev.dev.parent = adc->dev;
>  	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
>  
> @@ -650,16 +643,9 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>  
>  	aux_device->n_tm_channels = adc->n_tm_channels;
>  
> -	ret = ida_alloc(&adc5_gen3_aux_ida, GFP_KERNEL);
> -	if (ret < 0)
> -		return ret;
> -	aux_device->aux_dev.id = ret;
> -
>  	ret = auxiliary_device_init(&aux_device->aux_dev);
> -	if (ret) {
> -		ida_free(&adc5_gen3_aux_ida, aux_device->aux_dev.id);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
>  				       &aux_device->aux_dev);
> @@ -814,7 +800,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	if (adc->n_tm_channels > 0) {
> -		ret = adc5_gen3_add_aux_tm_device(adc);
> +		ret = adc5_gen3_add_aux_tm_device(adc, iio_device_id(indio_dev));
>  		if (ret)
>  			dev_err_probe(dev, ret,
>  				      "Failed to add auxiliary TM device\n");
> 
> ---
> base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
> change-id: 20261028-fix-adc5-tm-c96b13a4f442
> 
> Best regards,

