Received: from mail.kernel-space.org (v2202511311555398556.powersrv.de [46.38.245.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08323B0AE5;
	Wed,  6 May 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.245.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101673; cv=none; b=cGmsBhl4KcO2q1APv8badJP0eHPQd9pv5yMh8CwYazT94h5qTKKV/8TFEirnM6iGiXCILBWUqwEbeU0kKIi9+NnUp01yE3ERN6DzgSSYAYDh0lR2tflHeTTSc3LgjLxENaav/sLTWuHGv8V3LGYOwQ0qdmsOUu66yP9AVjttVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101673; c=relaxed/simple;
	bh=a/q+d44xQawWjegyh9bRKxMI6jfRop1zwgGnaHrIr1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQptionehRR0iM55FLyKuVzUFc9ijBLcDx6syVl5Jd3E1f6lvuIRteENXYlj3T7EbIu5XJAxtCCO9j5eOe6WLkFFk8NA6LZ2Xf0k0KUogALqd7S4UOO/KZbPrMFSm3+z5MdfaP48MkDnVhcbfWsm4200plT3/31OxXDMalnhx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=xNTXpScV; arc=none smtp.client-ip=46.38.245.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="xNTXpScV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1778101662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P03wL+yRq2fhnonG0hKGi8A1NVc+WdVspICjAGZDnnM=;
	b=xNTXpScVBMmNpq6KjpNcbP5A2luevAYVXAlrWKSUV8m+Y1+kyCpJR4LVof1+DCV7wYm3SD
	L2xqe2tRGpTRdK9f/4q8HcsiPGsjx0F35c2n2kD08AyvGtd0SzvY7epjURQCJWoaz85+A8
	x3Hf0Leg3nNamgr5zgea75Ae9AOZepM=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
	by oreshnik (OpenSMTPD) with ESMTPSA id 15c256de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 May 2026 21:07:42 +0000 (UTC)
Message-ID: <a4b53dc6-e89d-46a5-b4c1-460b0d90ae30@kernel-space.org>
Date: Wed, 6 May 2026 23:07:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] m68k: stmark2: add mcf5441x DAC platform devices
To: Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 Angelo Dureghello <adureghello@baylibre.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
 <20260504-wip-stmark2-dac-v1-8-874c36a4910d@baylibre.com>
 <ef773bbd-1cf2-4cc2-96a8-fccd3355d6b1@app.fastmail.com>
 <20260506155737.6cd625a5@jic23-huawei>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260506155737.6cd625a5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 5/6/26 16:57, Jonathan Cameron wrote:
> On Mon, 04 May 2026 19:28:28 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
>> On Mon, May 4, 2026, at 19:16, Angelo Dureghello wrote:
>>> @@ -94,8 +94,42 @@ static struct platform_device dspi_spi0_device = {  
>> ...
>>> +static struct resource dspi_dac1_resource[] = {
>>> +	[0] = {  
>>
>> This looks like the name has a copy-paste error: this is not
>> related to the 'dspi' controller at all but is just the dac, right?
>>
>>       Arnd
>>
> 
> https://sashiko.dev/#/patchset/20260504-wip-stmark2-dac-v1-0-874c36a4910d%40baylibre.com
> Has noted some more alongside this one.
> Seems unlikely a DAC has a bus number.
> 

that sashiko comment is not clear to me, maybe was related to the comment
i copy/pasted from dspi.

I have now fixed this as:

+static struct resource dac0_resource[] = {
+	DEFINE_RES_MEM(MCFDAC_BASE0, 0x100),
+};
+
+static struct platform_device dac0_device = {
+	.name = "mcf54415_dac",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(dac0_resource),
+	.resource = dac0_resource,
+};
+
+static struct resource dac1_resource[] = {
+	DEFINE_RES_MEM(MCFDAC_BASE1, 0x100),
+};
+
+static struct platform_device dac1_device = {
+	.name = "mcf54415_dac",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(dac1_resource),
+	.resource = dac1_resource,
+};
+
 static struct platform_device *stmark2_devices[] __initdata = {
 	&dspi_spi0_device,
+	&dac0_device,
+	&dac1_device,
 };

It should be fine for sashiko too.

Regards,
angelo

> Jonathan





-- Angelo

