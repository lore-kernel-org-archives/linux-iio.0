Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794094376;
	b=QNDQeu49ek8FQan2OPJ+j2ZI3gE0dX4OhJGMtDdGOlIacyJzpkyMFzX2G+Yry1XJQyMq
	 yjKBVA7wgGEyWx3e2C9s1mLt61rlJiw/qCw/qMfxwePP22fcOrartH4M7sGTt8hnOsAkj
	 Prs+C92nUsmA1wTZUFuO8allMuYmQzufzNkfh/D96zQbUXk15X93eSde3K4sfFsYf8wCW
	 4wO+NdQYXnj6A4nZXrKlWSSWXoV9Kow0gMeB9hpKdpOVic4zdn/35r79hmkuXBrQQb9Dg
	 r4CQkawi9Yupmwu/rX1txYHT+/lC8upDocIPAxFboLkiXQ4ia1mnITJxHsYAEDtxQ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794094376;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k8f1Lml+DnNVCoJKZ2XRF0PGrEc1W5WYomf+X5t1Lfs=;
	b=g3qVqcCBPHJaHh7v3sefI7QkjqwlWI+QcCxEIDXJ3cL2BhmfqQVeUoqfzRnMxO/6tP8T
	 2qNgm5xTKVIsJ97rpc79srCy68YETii2X1vmBlgggUTu/vsPtm/d4UkapbPeB78/Ui1u8
	 caIhO9vpDzBg5QF2ZpQo0j4g38w7I2xxOiHfjBVrwTYUwUfxCnvbHaAvdjjXlgUT+4Epm
	 htrbZW4pROw2b9eKmIu8DUTL/7ZX7tqNGCcldOK8m3onoiXKKc8KXOEaMMPV+A7XVSk+J
	 ay8PQljikEqEdsVILTJAn08bf3ng2ACd62qpwOMG5Qe1Gh11wWS+V2wPkUUQL9x37fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hy8Wind9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F15606A32E;
	Sat,  7 Nov 2026 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hy8Wind9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF2B1F0089F;
	Sat,  7 Nov 2026 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794094375;
	bh=k8f1Lml+DnNVCoJKZ2XRF0PGrEc1W5WYomf+X5t1Lfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hy8Wind9uYXovSHKjGGJN9mum9JxtEuw2d1Fp1AkS3GD9uhNNMRbKh81VZxL19mdN
	 6Lp8fWLax+Quzq7zXpUxF/acLnvRksiTY623w5vvlOSlWru/X+/YEQCpjHc8PsqDSR
	 1GGoeVFzXt5l3QfP0myyHbgw+p2gYf0vc8J7jZyYZ5SwoDQCJVmv3flmCWuEgxW2SH
	 waqWAaxKjAaBVdOANUTsBM89gcKQdHVkrWuCPo/AUA1Lz7NJ74xbVy7KfUMKIYbwVe
	 TJ5RHnM2OR84hm1NEF85gwya6mjlTxPYUqhXB2S7dDX87VqWaf+XHv13ktO44smYne
	 H+yEh0F1IcsBg==
Date: Sat, 7 Nov 2026 23:32:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: Michal Simek <michal.simek@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <amitrkcian2002@gmail.com>
Subject: Re: [PATCH 3/6] iio: adc: versal-sysmon: disable interrupts on
 shutdown
Message-ID: <20261107233244.63c35375@jic23-hlaptop>
In-Reply-To: <20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
	<20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
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

On Mon, 2 Nov 2026 17:51:09 +0530
Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com> wrote:

> Interrupt teardown is registered with devm_add_action_or_reset(), so
> sysmon_disable_interrupts() runs when the driver is unbound but not when
> the system shuts down: device_shutdown() invokes only the driver's
> .shutdown callback, which this driver does not implement.
> 
> The device is therefore left with its alarm interrupts enabled in
> hardware once Linux has stopped servicing them.
> 
> Add a .shutdown callback performing the same teardown, so the device is
> quiesced before control is handed on. The helper lives in the core
> module, so it is exported for the platform front-end. It skips a
> device described without an interrupt, which never set up interrupt
> handling.
> 
> Disabling the interrupts at shutdown is safe to have and not a must have
> requirement for shutdown.

So what is disadvantage of not doing it?  Otherwise, why have the complexity
of doing so?

J
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  drivers/iio/adc/versal-sysmon-core.c | 19 +++++++++++++++++++
>  drivers/iio/adc/versal-sysmon.c      |  6 ++++++
>  drivers/iio/adc/versal-sysmon.h      |  1 +
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 6595d07038c1..d39aaba9a8b6 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -1000,6 +1000,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	dev_set_drvdata(dev, indio_dev);
> +
>  	sysmon = iio_priv(indio_dev);
>  	sysmon->regmap = regmap;
>  	sysmon->temp_oversampling = 1;
> @@ -1050,6 +1052,23 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_versal_sysmon_core_probe, "VERSAL_SYSMON");
>  
> +/**
> + * versal_sysmon_shutdown() - Disable SysMon interrupts on system shutdown
> + * @dev: SysMon device
> + *
> + * Interrupt teardown is a devm action, which runs on driver unbind but not
> + * on system shutdown, so disable the interrupts here as well.
> + */
> +void versal_sysmon_shutdown(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +
> +	if (sysmon->irq > 0)
> +		sysmon_disable_interrupts(sysmon);
> +}
> +EXPORT_SYMBOL_NS_GPL(versal_sysmon_shutdown, "VERSAL_SYSMON");
> +
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("AMD Versal SysMon Core Driver");
>  MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
> diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
> index 529d0486c9f9..4d5e3d14cf15 100644
> --- a/drivers/iio/adc/versal-sysmon.c
> +++ b/drivers/iio/adc/versal-sysmon.c
> @@ -71,6 +71,11 @@ static int sysmon_platform_probe(struct platform_device *pdev)
>  	return devm_versal_sysmon_core_probe(dev, regmap);
>  }
>  
> +static void sysmon_platform_shutdown(struct platform_device *pdev)
> +{
> +	versal_sysmon_shutdown(&pdev->dev);
> +}
> +
>  static const struct of_device_id sysmon_of_match_table[] = {
>  	{ .compatible = "xlnx,versal-sysmon" },
>  	{ }
> @@ -79,6 +84,7 @@ MODULE_DEVICE_TABLE(of, sysmon_of_match_table);
>  
>  static struct platform_driver sysmon_platform_driver = {
>  	.probe = sysmon_platform_probe,
> +	.shutdown = sysmon_platform_shutdown,
>  	.driver = {
>  		.name = "versal-sysmon",
>  		.of_match_table = sysmon_of_match_table,
> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
> index a1ac3289719c..a21dacc13471 100644
> --- a/drivers/iio/adc/versal-sysmon.h
> +++ b/drivers/iio/adc/versal-sysmon.h
> @@ -122,5 +122,6 @@ struct sysmon {
>  };
>  
>  int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap);
> +void versal_sysmon_shutdown(struct device *dev);
>  
>  #endif /* _VERSAL_SYSMON_H_ */

