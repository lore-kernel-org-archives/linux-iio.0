Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7B1CFBA
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180737; cv=none; b=fsOfN2CBDpVoxsIoa7V0bWnQLHWvUOL645tvi6YYmG97hBcM6oaTPmvs1bzVM8pZCaYm97FXdaFVXqKU/m4ZaQdixlN5ejcjmakTOb41Co3GZhs4pBdCc6sp+Uy0Td+LIzJe6lansROjV9yVCZjTFTjvX5SFU5qP0115ZLhsNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180737; c=relaxed/simple;
	bh=OQ+eXQvqCuDPxHODJT+Q6fjlW9w8/UDEMBGuCq6gucE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdoMosMfICh1FzWlrKMVIaTw2OkNGQ6zQMRiyGZ0CIz052r+TIfI9vbb9Ygq+2NZi50IKJFI1RvItPvEcPPmXYtOtTnfn3U2YU8QTkRIcjxhhk/OCpdjbzERfez9RXNUisl1286UCzpodid1DqSyueHzKs4sLRVuO8rNlm5Q3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=JsN8omjW; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="JsN8omjW"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d9bba96f7dso3066891a34.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776180733; x=1776785533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8h+U/XNJDl6Z0eQIGD2q0/7suGmBSMAEqPDhKbc0pQ=;
        b=JsN8omjWFYIoScSUgYSIXbKvYW/2mgsYk/4pOT1TpK4wz/1+LviHF8B/2fdDPu6B+O
         d2y+19Mv0TYi2k1m4GqHNgS8bc6QzVfnzAaC/JFE8jCmOeWgIGoE1uiqngYx6kl2FgBx
         A9w/WyCmyVkIPmSHx30pNpviDhaNE/7ogIbUPi+5c2u+wrA9pyeSQKfqXEkc/rY1+zB0
         mbtgCkW8rEy2J+t2KGekxptU8G6/UmKX09Gj0fyoDyrnqS4PXG7u5fW8iLmjSkqm8eZU
         lcQzhHnRKeEr24g5NQh9uSe0vKdCLZI+cQIjO4Ymx0R+X9trHE71ul3qbWPO/n3ZBaz6
         +1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180733; x=1776785533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8h+U/XNJDl6Z0eQIGD2q0/7suGmBSMAEqPDhKbc0pQ=;
        b=Cm6sr8xwoLeyS8s8kus43vxgfhLq3j2wTP8XXdZNVGzGG58hgQ3wmAVKhk9SqfU2iI
         Ik6Ywwi/gthJcG/RC79w5lcb1o6zyexdET5xMl+UTe3GdguFP1b9i4byHkujk5ciqI/+
         n9CUgjPO2h4bBYIw/7VGFcwYvcEw5W+I0DdNpjz8J5AlWEMrH7He2jxGtYWSDVP2x9Mb
         Id7n8WXaJJ4nMG6Qf3rhJpwcjxdNzP7Q1akWaFUOnqLJWahd+J58fQmaRJv+IzVzvorl
         9X+xBrkb88TChPcDqCLLiNvT4AKPXlkCRihb1Jp4GoxgytdKccOhcYJYSDOmos/Euswf
         l4DA==
X-Forwarded-Encrypted: i=1; AFNElJ9rVTT1sJI4UP0wHWOBp78gFFKRkf/uoJInPC+NlmLqju4CsTTqhLXePw2sxFuqHbhjRYoIamtcKpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLC5pylosQXpvzjaVXi7eAfs+5B1Y9D5hkuxgaLxssORCepz4
	J8Cye5QWO960W7J3/nPtlylhxMhsVRl7KwuzlWe7+j30XRXg6BkNUpyruL/Zh+aji9g=
X-Gm-Gg: AeBDiesM1eJ9AK+YhkTsF5vHgbeJpwx9h3m9WeYRzQ4vQA/yyNeu1jYTCtsUU0mgpdg
	+64WuSgfEbFnikRct46/VEypKysui8F/DHvzKi9Md4B7vqqteRVOZmI5U0dsuNGyTau4THQZltf
	dVmiqASjP25J6/jw+uxUPedejLBatwWjrETywskFEc+h84P1O+rtg/hKpqKNjm3K2ngQB2axgka
	H/SQW+zNSvdbG9p9D/i8WVzYHZ+bx6D/zQJtt4+gAWIOFJQj45Xji8CN2guhjwe0PpSTnUkYynl
	cTiOyn/IA0XQTwjm1EA0hzXM5zNa7aGySrHcvdRF2RhbapmVphwShT5oN0pApKuuQcIPryNZEnD
	HN8qA/pOk3S9/q6Oe36bvgdM2gNTAVOegiMVQAdr8XD/YHDWYCc0Yx1ozQWza6LzBypPYknMgWF
	8GTnilXfo1JWiGYr5KUu6+3HM6PnDJkzfW+2MkywWfuAppiQzlRS2eAf2Uwen8uNkRMyEiAnPPO
	A==
X-Received: by 2002:a05:6820:290f:b0:692:a19b:af6b with SMTP id 006d021491bc7-692a1aafa3cmr300102eaf.13.1776180733266;
        Tue, 14 Apr 2026 08:32:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc7dfd5f1sm7219108eaf.1.2026.04.14.08.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 08:32:12 -0700 (PDT)
Message-ID: <bcd23f9f-0754-44ae-b921-e312d0185394@baylibre.com>
Date: Tue, 14 Apr 2026 10:32:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no Vref1
 case
To: Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 7:33 AM, Ariana Lazar wrote:
> Initialize vref1_uV variable to 0 before calling
> mcp47feb02_init_ch_scales() in mcp47feb02_probe() to avoid passing an
> uninitialized value when have_ext_vref1 is false.
> 
> Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] case")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  drivers/iio/dac/mcp47feb02.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index faccb804a5ed548088aaf83266b16ed45a92916c..efd4847913e46a4fa1b671aa9c5bd3e1430406b7 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -1095,9 +1095,10 @@ static int mcp47feb02_probe(struct i2c_client *client)
>  {
>  	const struct mcp47feb02_features *chip_features;
>  	struct device *dev = &client->dev;
> +	int vdd_uV, vref_uV, vref1_uV;
>  	struct mcp47feb02_data *data;
>  	struct iio_dev *indio_dev;
> -	int vref1_uV, vref_uV, vdd_uV, ret;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -1146,13 +1147,13 @@ static int mcp47feb02_probe(struct i2c_client *client)
>  		dev_dbg(dev, "Vref is unavailable.\n");
>  	}
>  
> +	vref1_uV = 0;
>  	if (chip_features->have_ext_vref1) {
>  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");

I don't think ignoring all errors here is a good idea. For example, what
if it returned -EPROBE_DEFER? Then we could end up with the wrong reference
voltage instead of trying again later.

So probably something like this would be better (also fixes uninitialized
variable):

	if (chip_features->have_ext_vref1 &&
	    device_property_present(dev, "vref1")) {
		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
		if (ret < 0)
			return ret;

		vref1_uV = ret;
		data->use_vref1 = true;
	} else {
		vref1_uV = 0;
		dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
	}


>  		if (ret > 0) {
>  			vref1_uV = ret;
>  			data->use_vref1 = true;
>  		} else {
> -			vref1_uV = 0;
>  			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
>  			dev_dbg(dev, "Vref1 is unavailable.\n");
>  		}
> 
> ---
> base-commit: 51e7665ab81f02adc80a1219c260ee678e9c6eb8
> change-id: 20260414-mcp47feb02-fix4-614de9334f22
> 
> Best regards,

