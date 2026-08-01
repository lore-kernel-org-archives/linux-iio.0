Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6427B35B
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785602844; cv=none; b=lvnzUP1dugrDbwo01DMLL9Oqif7l6yR2iHmSk66a0xcCuSCkEMC+fySBBjJTBqEG8JspbAZ7v797kzSlX6VKCNHYNAF7vA5y1s1w31QOBz9BXC2c3Cs61EFEcgJqQGG9ZW0EZb3+lkfVLyvK5q2VeWOvDGl4B26qc3H9gHEJNBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785602844; c=relaxed/simple;
	bh=oWppkXhLPbqrwNkVaHFBrb/8RrYg5L/B6N2thilIp9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loB0bV5T+ql7fSWlbCtZwr/DOviQrsWZqd6/HqAUsW1RnAJ5zX/0DCJpyy9VYVVYPEtCOEMwKYbdNcwWyOJXltfT8vz8TYQdfFAjQUGQ/e0QBQAm2nqcS9G2a9IuyH5drMkOugNx8fR7/MCjVLZ3zjlspH4VK8pmPZ4BCqdl618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YONTVH0T; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YONTVH0T"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so1154951a34.3
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785602842; x=1786207642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIWEG8Ya4E7m7w4a7i1eN4G2oAOrDPnyYXyAS/kJfKE=;
        b=YONTVH0TBXlMF+GjixXGQYuOXXRUBZzRs8543rhv8E/a3cNTIm0qxC/pxASTBjHpGE
         13PvmNeq3YuiIx8eiEWx6KnphM5GcIZdvI5Kimte96H3vvozBLOp71ikYwGy/f3NbHB6
         VCYYrDZWKfIChg542P6uRzQZ321SgbzLyhZ9XG6qZSpjqoC/3mFJ+mEUFlUK3CrOJhY6
         //VAWPK5GE25InzZAVeK1oWnGsJkq0JI7lvNKV8sxc8J0tOP49G/br6Wh/ENYZPmFUYr
         zfy8uRCilqOwJ/KZZlnZlhBb/kgAKoBlY++F36zP8L7Tkg3xMOYjTfOeujvjinhLT2zu
         jOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785602842; x=1786207642;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qIWEG8Ya4E7m7w4a7i1eN4G2oAOrDPnyYXyAS/kJfKE=;
        b=gabQCZ4H0XhS8Mj7trf9CpdhYNtLFeb7lbtX4tDV2I42hjEFQIXAQdVLBL4VcnglYP
         vn/L4hfEXPj16WqXoHebgkGbTb304RKKfcMssfriF/SLu32CYA6wbBIPYgxyRVH7na31
         kFAXVgsKGXQSe3F/7WHSKtv0/ZTpAWFh8Gnx3Eahu4ijZS0Mo006EdK7lEiy1BBiGtKJ
         0iWoqjUHr2Z/mAZ0qRXsy01zxlvk+8i3VO8JooL1UzfqBoFA7oTD3ujNGrZ8OXgIQ5rr
         IQmORyUwBcDUFm4UUpzeofGVdmWftynG3Tu2raLr7UxqNAgMdX8/8o0W1fp8oDIJA62a
         kezg==
X-Gm-Message-State: AOJu0YwhNZZCkd67IxCPcqM6shejxx9vQEQ8cM3XhD2INqZGfIiQDFqZ
	l0k9cJecBK7PN/JeAY6Ig5aoNPN6Omi/SN7zoyWxitKwmNUf26JyWHx1gd5ZBwN+4qGgldtu7Bo
	yYl5IrAI=
X-Gm-Gg: AR+sD12Q2Y80TfA1wg7isBS3qT6vRB0qRR60O8IQ1nYTMhSz0/txQdqgLjZX12V6aV4
	N0KZ92T7NS7g9nLbwK7K/fjzSzC0EuEwfT1UoFndd2ah1x4dfHGVDobd7NjPcFb4nzMVtMREtkf
	GdyhPrBT5+fySwzNhSUHuNhTW0E8Xuq0SyXzVzRsd+MYEHtm6JP/9dT0GPdzYRu6YIWCDIkrqn0
	yXOZUUUlkt/wp0LpkAyCz/USX9Nccq+LViwK4IuuAsDjHafVOYKtnO+7aJiZx66zbTlpL8MJ0uR
	WjD1PBhHKxpp6Gy380NyTkxcynw46aFAkheLE1/wwKzJ94/DRzdNPMUSF8PiswoHBZ/xDxLC7nI
	ljOnFz87F93Ydm2QQPL9IcvKJ29ORMCc2sK3oxzzTbkbxBDTpbtUnp3Sv42who04U0OIIONcbpR
	36SWp97cilvz5LBCwocINMpKOjUiJFADXR9isp/4vGHTPfkev+iHqJPRy78G5Duz4Z80p7wliAY
	1azmPA/GIl7HD8/AWHZflVOcfZRfVU19lRQa9A=
X-Received: by 2002:a05:6830:4114:b0:7e9:bd00:c6ad with SMTP id 46e09a7af769-7f196f29291mr7933016a34.16.1785602841748;
        Sat, 01 Aug 2026 09:47:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f11e522sm3400378a34.25.2026.08.01.09.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 09:47:21 -0700 (PDT)
Message-ID: <9d6d0f3f-ca6e-44e0-a280-c07a7d55453b@baylibre.com>
Date: Sat, 1 Aug 2026 11:47:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] iio: adc: xilinx-xadc: Add .setup_channels() to
 struct xadc_ops
To: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
 <20260729125455.95893-5-DileepKumar.Nagavarapu@amd.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260729125455.95893-5-DileepKumar.Nagavarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:54 AM, Dileep Kumar Nagavarapu wrote:
> Add .setup_channels() function pointer to struct xadc_ops to enable
> different interfaces to have custom channel setup logic.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c     | 6 ++++--
>  drivers/iio/adc/xilinx-xadc-platform.c | 3 +++
>  drivers/iio/adc/xilinx-xadc.h          | 2 ++
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index e3b1d5bebe98..d39ff54439ba 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -656,7 +656,7 @@ static const struct iio_info xadc_info = {
>  	.update_scan_mode = &xadc_update_scan_mode,
>  };
>  
> -static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
> +int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>  {
>  	struct device *dev = indio_dev->dev.parent;
>  	struct xadc *xadc = iio_priv(indio_dev);
> @@ -762,6 +762,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");

This function is only used once. Would be better to just move
it to the file that uses it instead of making a public function.

>  
>  static const char *const xadc_type_names[] = {
>  	[XADC_TYPE_S7] = "xadc",
> @@ -789,9 +790,10 @@ EXPORT_SYMBOL_NS_GPL(xadc_device_setup, "IIO_XADC");
>  int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev, int irq,
>  			  unsigned int *conf0, unsigned int *bipolar_mask)
>  {
> +	struct xadc *xadc = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = xadc_parse_dt(indio_dev, conf0, irq);
> +	ret = xadc->ops->setup_channels(indio_dev, conf0, irq);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
> index 38748a38da15..bd033315c72f 100644
> --- a/drivers/iio/adc/xilinx-xadc-platform.c
> +++ b/drivers/iio/adc/xilinx-xadc-platform.c
> @@ -405,6 +405,7 @@ static const struct xadc_ops xadc_zynq_ops = {
>  	.get_dclk_rate = xadc_zynq_get_dclk_rate,
>  	.interrupt_handler = xadc_zynq_interrupt_handler,
>  	.update_alarm = xadc_zynq_update_alarm,
> +	.setup_channels = xadc_parse_dt,
>  	.type = XADC_TYPE_S7,
>  	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
>  	.temp_scale = 503975,
> @@ -509,6 +510,7 @@ static const struct xadc_ops xadc_7s_axi_ops = {
>  	.get_dclk_rate = xadc_axi_get_dclk,
>  	.update_alarm = xadc_axi_update_alarm,
>  	.interrupt_handler = xadc_axi_interrupt_handler,
> +	.setup_channels = xadc_parse_dt,
>  	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
>  	.type = XADC_TYPE_S7,
>  	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
> @@ -523,6 +525,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
>  	.get_dclk_rate = xadc_axi_get_dclk,
>  	.update_alarm = xadc_axi_update_alarm,
>  	.interrupt_handler = xadc_axi_interrupt_handler,
> +	.setup_channels = xadc_parse_dt,
>  	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
>  	.type = XADC_TYPE_US,
>  	/**
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index 3a9cc87c43b5..67efa093157e 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -78,6 +78,7 @@ struct xadc_ops {
>  	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
>  	unsigned long (*get_dclk_rate)(struct xadc *xadc);
>  	irqreturn_t (*interrupt_handler)(int irq, void *devid);
> +	int (*setup_channels)(struct iio_dev *indio_dev, unsigned int *conf, int irq);
>  
>  	unsigned int flags;
>  	enum xadc_type type;
> @@ -223,6 +224,7 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
>  void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val);
>  void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val);
>  struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops);
> +int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);
>  int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
>  			  int irq, unsigned int *conf0, unsigned int *bipolar_mask);
>  int xadc_read_samplerate(struct xadc *xadc);

