Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689656;
	b=MMLWLJHGvmUOr4PkEfowPPi4LWJhh7z4EbKyO4gma8oPiSYsqTarSlN5Xrh7+IS02xny
	 BLMUQj/9jTf9Xx+xqS6K13ofgPzJDeeuK7JuhZfaVZy9ayn+SSlfmL5GCTqxAddPnRyTg
	 pU42z1+83CSght73aQHLvJ36/8DP/BBliuJFJ8bPhPGO141v69dl8kjQwM3dH57/31bXk
	 GbCKxjGLqaqNMze12nipz/6/EWQ+L+lCTFnNCNQ/ueYhsqkPcCfAHbL3+0oV7INZGEVKJ
	 B5pqub5ny/sYYmgF6VLfbihpn/4d+XuqpaYnYGYOlRhtLBdgNa4YW+VM81IFFOUkkqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689656;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=2tQek1qiZL4Js2GpnQFztu1faM+c6GSagpIcxNr7m9g=;
	b=Z94wG/TUuoQIoaW7dKDjs+C5094Bc/sKq86cyUd02xHyvLROxkJFUkYYKfDEET3qKJzr
	 nl7GRIT3GpoR4WogsWfFAxc8Ju67NaIgChFpuqJ0ODxdTx+AGxdAFu3lVdU9guTHGAEm0
	 XIfU+m4JF7rJFVLMV2gZqW3TsM4l4AiUi3bZpcP66fCH3l186f3Yt/VUfQ6QwYyd+wxpW
	 +RCYZh8cLIc3aCfYdsjBvVuCNbhMREoW1WZIjAJa9TUnwtSXm16AdrI6NFcn/Iy0uSced
	 oI57kz3N5kZU2N0VwH+m4LZaDlDq/eGeqkVBRqiH3m9HKXKo4+181bhXvu5ywNIbRjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qkfKMdYn;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81B606A329;
	Tue,  3 Nov 2026 07:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E81B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qkfKMdYn
Received: from [192.168.1.10] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A57D20B7166;
	Mon,  2 Nov 2026 23:07:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A57D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793689640;
	bh=2tQek1qiZL4Js2GpnQFztu1faM+c6GSagpIcxNr7m9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qkfKMdYn8BRvJp96+mIGOJodjPZo3QsLvaXaw0dXTIn9JjgXjWi0M9nKW9YQUP/7E
	 BT/KjK7OBsK18zBgSiniHBuKfANsYwwSLjbiZFjokV2R/o5Apl8vwyLVrS6i1gWmEM
	 0htMk9PnxumShIpq8GGOgt1lmI9EHfFxyVZoHOwQ=
Message-ID: <4f330292-0fda-472b-8302-75ed5f6725eb@linux.microsoft.com>
Date: Tue, 3 Nov 2026 12:37:29 +0530
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
Subject: Re: [PATCH 3/6] iio: adc: versal-sysmon: disable interrupts on
 shutdown
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amitrkcian2002@gmail.com
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Amit,

On 02-11-2026 17:51, Amit Kumar Mahapatra wrote:
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
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>   drivers/iio/adc/versal-sysmon-core.c | 19 +++++++++++++++++++
>   drivers/iio/adc/versal-sysmon.c      |  6 ++++++
>   drivers/iio/adc/versal-sysmon.h      |  1 +
>   3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 6595d07038c1..d39aaba9a8b6 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -1000,6 +1000,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>   	if (!indio_dev)
>   		return -ENOMEM;
>   
> +	dev_set_drvdata(dev, indio_dev);
> +
>   	sysmon = iio_priv(indio_dev);
>   	sysmon->regmap = regmap;
>   	sysmon->temp_oversampling = 1;
> @@ -1050,6 +1052,23 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_versal_sysmon_core_probe, "VERSAL_SYSMON");
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
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("AMD Versal SysMon Core Driver");
>   MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
> diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
> index 529d0486c9f9..4d5e3d14cf15 100644
> --- a/drivers/iio/adc/versal-sysmon.c
> +++ b/drivers/iio/adc/versal-sysmon.c
> @@ -71,6 +71,11 @@ static int sysmon_platform_probe(struct platform_device *pdev)
>   	return devm_versal_sysmon_core_probe(dev, regmap);
>   }
>   
> +static void sysmon_platform_shutdown(struct platform_device *pdev)
> +{
> +	versal_sysmon_shutdown(&pdev->dev);
> +}
> +
>   static const struct of_device_id sysmon_of_match_table[] = {
>   	{ .compatible = "xlnx,versal-sysmon" },
>   	{ }
> @@ -79,6 +84,7 @@ MODULE_DEVICE_TABLE(of, sysmon_of_match_table);
>   
>   static struct platform_driver sysmon_platform_driver = {
>   	.probe = sysmon_platform_probe,
> +	.shutdown = sysmon_platform_shutdown,
>   	.driver = {
>   		.name = "versal-sysmon",
>   		.of_match_table = sysmon_of_match_table,
> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
> index a1ac3289719c..a21dacc13471 100644
> --- a/drivers/iio/adc/versal-sysmon.h
> +++ b/drivers/iio/adc/versal-sysmon.h
> @@ -122,5 +122,6 @@ struct sysmon {
>   };
>   
>   int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap);
> +void versal_sysmon_shutdown(struct device *dev);
>   
>   #endif /* _VERSAL_SYSMON_H_ */

Change looks good to me.

Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

Regards,
Prasanna Kumar
