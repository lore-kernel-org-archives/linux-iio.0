Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959035;
	b=LRb0TRMyhxPK9gM+pVshDi0p+VpLNWl1cPzgkfYodbSiOHjo31/LRV4sAdJATaHjx43K
	 ObDjt5ac1r2YM92We5M+lgsiYXPBWPEsdKqg5x18lIJgyf2XAxGk1TwkaRPNiJMN/BTEg
	 ZOo5Wq3LuBEb7wYVQx6ng3MQqGsIHvMLGpzf1wYcQjkv4dtih3drsQ9BRk/UQ6zTTmkxB
	 YS1KwoJCV7vubN/r53jnqUiiLh3D3Cui5IZ/9dogKm06f1ylh4dUzB4K9MSqdS/FxtkWn
	 ZEliulYDpb8BDo5Rb56c6KEHdWTn78Vv1oB4FlHOQKAp1l1TDTCsaRi1MBov6FSSP/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nfuxDUd17BdkkholAC0E5iZ6FczMfNtszUIXAcM/J/4=;
	b=MtiuCWpXi9qCDthwaB1qUwatBNpobHAAl7IuUN7iLrVks8z1xC6pGVasSYa7Aah1Vqc2
	 xr51UsWdnuisHqYRX0kAnzaBG5tQoj7LQjdeup+hOcksCkbtRldbIHDP8kZiDDa2kQq8j
	 lN03cEw5eo7MtJKqJIr1pppYMEEhMphQaC1sx56qxDKMX6QivhLeyyAAhclQWDyxGbt5f
	 3H4e4pwr3gV2CRWjpMXgOapEaLpwfH8TqQ26YfVDh1Qw8dN8hjwGU45hOUprHcUK2g2/x
	 NoO0H0FPvKnd0UlTjw/RPKPgtCH/cllv9h15Oc+DeXPRuDxkWIClFlmImFjGb43Rzew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xIbPSHG9;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB87606A31A;
	Sun, 25 Oct 2026 20:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xIbPSHG9
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jCSYQ2rpdzlfvpM;
	Sun, 25 Oct 2026 20:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792959029; x=1795551030; bh=nfuxDUd17BdkkholAC0E5iZ6
	FczMfNtszUIXAcM/J/4=; b=xIbPSHG9E/ShBMSpMR7/MCIc5yF6CJvMRbZ+75QX
	TJ7blH0H/jORRmw6sB1iF5m3Y8DQxQ9i6sDKhu/Mnywp4iPywwl/lsBZDO5F2oT9
	jFRc/eLosbMCBNPd9aBhBjv8+zWi4iY7aJjGmG2QH6X+eI22nb1lQUzPk4rSraIA
	2QazKqnF2itsHjqbDh4CxQ/3pdnX5t6obUXtAVdLy4Wxn3PPQ8Fc8dFHzn3vncyT
	RnrLIo8wfXAzBXiljOyQwg178p+T7ofDCGfj/LtI265+MaSJgzYTMtBUCoC8dW7o
	6LJC/Hg/0X84UO9Zga8qAoZLivGnK9LpUX+mzzGJWqDwNw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EBJM-FDfAURl; Sun, 25 Oct 2026 20:10:29 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jCSYK095DzlfvpK;
	Sun, 25 Oct 2026 20:10:28 +0000 (UTC)
Message-ID: <76bbebb4-7337-486d-8f21-a39bcb6dca93@acm.org>
Date: Sun, 25 Oct 2026 13:10:26 -0700
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on
 mutex helpers
To: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
References: <20261025191510.22261-1-zoone.rupert@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261025191510.22261-1-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 12:15 PM, Rupesh Majhi wrote:
> Found by building with CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y

Please include the CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y change in
your patch.

> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index c68c6c5f6aca..6a3cabedf4e8 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -663,7 +663,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>   }
>   
>   void adc5_gen3_mutex_lock(struct device *dev)
> -	__acquires(&adc->lock)
> +	__context_unsafe(/* returns with adc->lock held */)
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>   	struct adc5_chip *adc = iio_priv(indio_dev);
> @@ -673,7 +673,7 @@ void adc5_gen3_mutex_lock(struct device *dev)
>   EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
>   
>   void adc5_gen3_mutex_unlock(struct device *dev)
> -	__releases(&adc->lock)
> +	__context_unsafe(/* releases adc->lock */)
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>   	struct adc5_chip *adc = iio_priv(indio_dev);
> 
> base-commit: c9dbe2a47f635465c9985b7af74d2ae310e98125

Please consider replacing the above with the patch below:

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c 
b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c68c6c5f6aca..09013c6e44a0 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -663,7 +663,7 @@ static int adc5_gen3_add_aux_tm_device(struct 
adc5_chip *adc)
  }

  void adc5_gen3_mutex_lock(struct device *dev)
-       __acquires(&adc->lock)
+       __acquires(&((struct adc5_chip 
*)iio_priv(dev_get_drvdata(dev->parent)))->lock)
  {
         struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
         struct adc5_chip *adc = iio_priv(indio_dev);
@@ -673,7 +673,7 @@ void adc5_gen3_mutex_lock(struct device *dev)
  EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");

  void adc5_gen3_mutex_unlock(struct device *dev)
-       __releases(&adc->lock)
+       __releases(&((struct adc5_chip 
*)iio_priv(dev_get_drvdata(dev->parent)))->lock)
  {
         struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
         struct adc5_chip *adc = iio_priv(indio_dev);

Thanks,

Bart.
