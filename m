Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEE418A58
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158866; cv=none; b=tJh0K26qngMLw2294bOSErggFUL5gL7hmksOaQ4uiEFiTzrG9K/C0tUBWU2ofIdJ2xnLjiHZPz7I4vAwoxgpTa33h8nL7EnlEUxFm7YlPuHia/zzIcYoEBhBaf8dDh4hCsKzZ/uGr5JBRIxwgsF77CJaf6pjP26FjGsj59rbMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158866; c=relaxed/simple;
	bh=qMh3iMW7LAK2gw7id80SDhhXwFYFcOQeuiXlRrdCxL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kthzBPgieuEwlJDpWG/mA6QNsyEwiQIH7F00++cZAa7tFLyePwhmXHV21kOacMjNPFtCh37pbqLSXx4w3+oWfOTPzb/l6d14i/W5ZfUJrV1EAI6xvgjHZ5W5brHdjHg7gPLvxy9WcirxVfyl2/QJRGWvFxykN1jdAKtODagzfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RbQLOnkg; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RbQLOnkg"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb64085c45so1104655a34.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785158857; x=1785763657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=862duEuJG7xgtpJCUOI3pjr65DD4q6n4TnDbBPD48MA=;
        b=RbQLOnkglwzKzgr0Kjl6K3aMlyy4V7xnvV3gk9yr5ucJNTQl9e2AGSBibuDqt+hrxD
         6AUTzZEdggf1kbiCjhf01cZAut/+Hp3tBbEVPxWnOwzG16hm9hg70OEAyb9y0H6ILZU4
         LI8widvgk2gR2xNTNQfpvJ/37qZmm0oDouPiB22rd6A0IpPlirLDOYOiaa+8kL4d1PdI
         aONa3Kujb0xdgjBs2jFBx7FCR9nopRhCq2UzB40ZVxQ+2jI3aPcJUVEZM0s5LBUO54eT
         GcRLHKjiKdlLJzXietwpC2WwoQcGnP+5+ze+++20mKnra3hl+g2aZxSkuMwlEqmqWl6j
         TkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785158857; x=1785763657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=862duEuJG7xgtpJCUOI3pjr65DD4q6n4TnDbBPD48MA=;
        b=dCRWy5Wb9rtJXe57d5K6CWztL6JSanYNAHGkjzLtxlBefj66p2zNvf64Ftxvv2r+DZ
         JyBq+sCck99Z6C6GeaDMx1gRxDM5t/D1HbpQMnXkHXZAGaCQfrAQVHdmKgaMq2SSVIKz
         fxY/hP+0A9c5s55dDu3sxlskVuhVfkUyEIDVW5Y71m3COZNc3aIyv9RA2poa4I+N/Mm/
         nGO3ySrzudo0lBYcnAM6lfBnV4hsbUPQkNhsRJBBuKAmiHZO6FmmmOjANrRrjYZq4+2t
         Nw0uEzMwtxQzrVBhpmJ+kiE3RpX253/pZ2bH3N34mEtCGcXlUdkCpzGwsFEKb5ARYC+2
         DB2g==
X-Forwarded-Encrypted: i=1; AHgh+RrUPs0N7saGhFcyXb0pX6lt/QkWTaFPZGCXt2GIb9EjciOgla7EEYEarWuCU/T6y+7BKqSz0ZemmdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHSRu6bE+9QzZiiBKpO8Q3yqe7VM/ORjQ0xcHyeWaVTy8qS1AH
	91yNYuFiS9ClAg2Zn2DS9xOPVdotb+VEKBCT7jbzb9aPf72lwTW5044A3EoKrk+zox0=
X-Gm-Gg: AR+sD128K9o+noo6Uef6o3xXkjcR7DQbXsFB5w45YBhxZQXmx+SYlZ08MGe8vH/miA8
	NLIMrQBOvriRT3CC+MLf7VoyRk7pbPcE8KUo7AxacGDS28c8q0qQx0rCR+SgGjdr3uhOGwNTWvW
	IqYWI22EQure3WkaeCsLx+L6SAsXgDz7tYIkceAa1N5ZCGVpcmxADJxK/C1DiAjEhzKUZtXBnpo
	CfA6xKr2FpT7v7IYGwMS9jZ6aT1Ew1gtRHiRzEde/hgfpXrzK6f6xBqXX2mAJZI1uQTiFRenhxU
	IXNlLWs306H/Rx/zwv18Ac/e8hHQIN2tWcoHgn4Tckc3J30Z60pu9aiRYsQM7ffLEoWQ3XL/7Ys
	gsZGs54nH5k+lfzDM52axeOpGo7EBbIA9qG8g97G8Sai2T7bbrbvb0K+VVjGg3QGJblYABYPSE2
	uIdo3rRpyMSDilYLfpxp4M5T8IEF4MAI19kYBHh+HHFrGWOYURvwmP
X-Received: by 2002:a05:6830:8385:b0:7e9:c481:ff8a with SMTP id 46e09a7af769-7ee78c25effmr7740900a34.11.1785158857019;
        Mon, 27 Jul 2026 06:27:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:41b4:f2ef:8a0a:2104? ([2600:8803:e7e4:500:41b4:f2ef:8a0a:2104])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a03d30asm12348470a34.18.2026.07.27.06.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 06:27:36 -0700 (PDT)
Message-ID: <bb74b15e-6a95-4eaa-82bf-7c256b554c45@baylibre.com>
Date: Mon, 27 Jul 2026 08:27:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: dps310: fix pressure result shift bit
 definition
To: Rupesh Majhi <zoone.rupert@gmail.com>, Eddie James
 <eajames@linux.ibm.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: stable@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727070547.649074-1-zoone.rupert@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260727070547.649074-1-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 2:05 AM, Rupesh Majhi wrote:
> DPS310_PRS_SHIFT_EN is defined as BIT(4), but P_SHIFT is bit 2 of
> CFG_REG. Bit 4 is INT_PRS, which enables the pressure measurement ready
> interrupt on the SDO pin.
> 
> The datasheet requires the pressure result bit-shift to be enabled when
> the oversampling rate is higher than 8 times, so
> dps310_set_pres_precision() sets it for oversampling ratios of 16 and
> above. With the wrong definition it leaves P_SHIFT clear and toggles the
> pressure ready interrupt instead, so the result register is never shifted
> and the pressure values read at those oversampling ratios are wrong.
> 
> Define the bit at its documented position. Temperature is not affected,
> T_SHIFT is bit 3 and DPS310_TMP_SHIFT_EN already matches it.
> 
> Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> Found by inspection while working on FIFO support, and checked against the
> DPS310 datasheet V1.1 (2019-07-11), section 8.6 "Interrupt and FIFO
> configuration (CFG_REG)", where the bit table reads INT_HL, INT_FIFO,
> INT_TMP, INT_PRS, T_SHIFT, P_SHIFT, FIFO_EN, SPI_MODE for bits 7 down to 0.
> 
> Not tested on hardware yet: the driver probes and reads correctly under
> qemu-system-arm -M rainier-bmc, but QEMU's DPS310 model does not implement
> the shift bits, so it cannot show the difference. I have a DPS310 breakout
> on order and can confirm the raw pressure values at oversampling >= 16 once
> it arrives, if you would rather wait for that.
> 
>  drivers/iio/pressure/dps310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 45bdb8c7670f..473973dd0694 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -50,7 +50,7 @@
>  #define DPS310_CFG_REG		0x09
>  #define  DPS310_INT_HL		BIT(7)
>  #define  DPS310_TMP_SHIFT_EN	BIT(3)
> -#define  DPS310_PRS_SHIFT_EN	BIT(4)
> +#define  DPS310_PRS_SHIFT_EN	BIT(2)
>  #define  DPS310_FIFO_EN		BIT(5)
>  #define  DPS310_SPI_EN		BIT(6)
>  #define DPS310_RESET		0x0c

In your followup work, it would be nice to start with a patch to
sort these in a logical order.

Right now, there is a mix of GENMASK being sorted from high to low
while bits are low to high (with DPS310_INT_HL being out of order).
Normally, we go from low to high on everything because that is how
datasheets usually list things.

Ideally, would end up something like:

#define DPS310_PRS_B0		0x00
#define DPS310_PRS_B1		0x01
#define DPS310_PRS_B2		0x02
#define DPS310_TMP_B0		0x03
#define DPS310_TMP_B1		0x04
#define DPS310_TMP_B2		0x05
#define DPS310_PRS_CFG		0x06
#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
#define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
#define DPS310_TMP_CFG		0x07
#define  DPS310_TMP_EXT		BIT(7)
#define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
#define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
#define DPS310_MEAS_CFG		0x08
#define  DPS310_COEF_RDY	BIT(7)
#define  DPS310_SENSOR_RDY	BIT(6)
#define  DPS310_TMP_RDY		BIT(5)
#define  DPS310_PRS_RDY		BIT(4)
#define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
#define   DPS310_BACKGROUND	 BIT(2)
#define   DPS310_TEMP_EN	 BIT(1)
#define   DPS310_PRS_EN		 BIT(0)
#define DPS310_CFG_REG		0x09
#define  DPS310_INT_HL		BIT(7)
#define  DPS310_SPI_EN		BIT(6)
#define  DPS310_FIFO_EN		BIT(5)
#define  DPS310_TMP_SHIFT_EN	BIT(3)
#define  DPS310_PRS_SHIFT_EN	BIT(2)
#define DPS310_RESET		0x0c
#define  DPS310_RESET_MAGIC	0x09
#define DPS310_COEF_BASE	0x10


