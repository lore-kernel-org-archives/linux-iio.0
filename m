Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688B3FF8BE;
	Wed, 13 May 2026 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673237; cv=none; b=gNXk/xr3ePWD4gikFQs4az50YAjoZsIgjWT7EHRZEPZAizIx5X52hew3ET/zMe4dKm1gU+1p06H7A/socYFxKSj4fyp8mgE6PoxIp+scTB7HXnYdL5yMsChqqWLII+bM3iE5BGZwHTWQKAkrJMunUocOR+UVTqGry+osmXYZ2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673237; c=relaxed/simple;
	bh=dE7oXpK/R8zVWQ4MQZ3hfXSes/zwUvFmkUxfmE1/DBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BN2YQfYYhTR6fc9uBf8Zz9wMm0H/p4AlWh4Tm2VzrQcgIT6yIxqzJYHDuRKxWbogmffjYYuF7m16oxpvqw2yPOIrWbWvX51F2+36zBTflqe3N1fL9Co1fgRtuHP1JF6SMpZ2If9Eb8UbP27nZWSSTA3gvrMIjkK02jL3cTdDXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MhXolWLC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MhXolWLC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42516165C;
	Wed, 13 May 2026 04:53:49 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DDDA3F836;
	Wed, 13 May 2026 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778673234; bh=dE7oXpK/R8zVWQ4MQZ3hfXSes/zwUvFmkUxfmE1/DBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MhXolWLC/PPYbdZnrarpww/SaQyugJrY6kZn10zt/uGqVMabQTaZqeojEOq74RcdZ
	 FmvbE8mcVwZ0U9WntP0tnCw5UdOIXDl9nQ9gl+Jpkxfwe4Nr+ztkFmqvoy8aqMbf2S
	 YMwjy1rl/28TUVJKbt7jb0syBzOmYO0aVkRzAIYc=
Message-ID: <4248ac7e-3cce-4db8-a2c1-710f2c903490@arm.com>
Date: Wed, 13 May 2026 13:53:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>,
 Michal Piekos <michal.piekos@mmpsystems.pl>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maksim Kiselev <bigunclemax@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl>
 <20260513-sunxi-a523-gpadc-v2-2-d5efde151dac@mmpsystems.pl>
 <A7772824-E704-4BFD-A796-BCD81197E5A2@gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <A7772824-E704-4BFD-A796-BCD81197E5A2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sanjay,

thanks for having a look!

On 5/13/26 13:44, Sanjay Chitroda wrote:
> 
> 
> On 13 May 2026 10:29:43 am IST, Michal Piekos <michal.piekos@mmpsystems.pl> wrote:
>> A523 differs from existing sun20i-gpadc-iio by having two clocks; bus
>> clock and module clock.
>>
>> Change driver to enable all clocks.
>>
>> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
>> ---
>> drivers/iio/adc/sun20i-gpadc-iio.c | 11 +++++++----
>> 1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
>> index 861c14da75ad..3f1f07b3a385 100644
>> --- a/drivers/iio/adc/sun20i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
>> @@ -180,7 +180,7 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
>> 	struct iio_dev *indio_dev;
>> 	struct sun20i_gpadc_iio *info;
>> 	struct reset_control *rst;
>> -	struct clk *clk;
>> +	struct clk_bulk_data *clks;
>> 	int irq;
>> 	int ret;
>>
>> @@ -205,9 +205,11 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
>> 	if (IS_ERR(info->regs))
>> 		return PTR_ERR(info->regs);
>>
>> -	clk = devm_clk_get_enabled(dev, NULL);
>> -	if (IS_ERR(clk))
>> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clock\n");
>> +	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
>> +	if (ret <= 0)
> 
> Thank you Michal for the change.
> 
> Have you validated the changes ?
> It looks while success ret would be 0 and it would give return error.

But devm_clk_bulk_get_all_enabled() returns the number of clocks found 
and enabled. And since we need at least one, I think this is correct, 
and the error message below reflects that.

To me that change looks good:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre


> 
> Thanks, Sanjay
> 
> 
>> +		return dev_err_probe(
>> +			dev, ret,
>> +			"failed to enable clocks or no clocks defined\n");
>>
>> 	rst = devm_reset_control_get_exclusive(dev, NULL);
>> 	if (IS_ERR(rst))
>> @@ -243,6 +245,7 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
>>
>> static const struct of_device_id sun20i_gpadc_of_id[] = {
>> 	{ .compatible = "allwinner,sun20i-d1-gpadc" },
>> +	{ .compatible = "allwinner,sun55i-a523-gpadc" },
>> 	{ }
>> };
>> MODULE_DEVICE_TABLE(of, sun20i_gpadc_of_id);
>>
> 

