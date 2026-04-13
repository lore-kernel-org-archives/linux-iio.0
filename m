Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D93B38B8
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091595; cv=none; b=JLQADtEyQDLlaG9EG6Em6dPN9s6rEG0+gqlSrHPhEqrTlcqAG1g0YRwsWeXHtDt1uPCvmQizXcubeE+j/QUhMnC0fcaZvjLT2yvPAsBVCq6uKoRNaOHdixExKoGLL/ah/4xlQ8xG1VWmL5PEDmQ2uYZAnuhOLHYbnbUDIXLsa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091595; c=relaxed/simple;
	bh=USv73My1kIre6jx+QK+97PHC/vGtmVRorHe2GijXOwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8zpEIPdhyu1S9jWHcZ2NGlaZadXYd3nNZQTr06OJMYm9MNYLHHQjNEjtr3BIvcr1Mku+VB+Gif6KhFak8hG8duKfKGsBEpK5JqmRKfQZcwuhzwfiVy31EdFPSDMHtlJLEZRNEELeCfJLYzZDG/s61mMJ2u+IG8j8E948VMpRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=S1P/u+O1; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="S1P/u+O1"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d55b97f358so2649320a34.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776091592; x=1776696392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdpVrhZa6a+vl2BmbR7xizi71fAKE9Cvxh2ARaOoj+I=;
        b=S1P/u+O1vXhwzPn1kvgHEk2YP82z21MzQRBL7ijV9n6nRHJJRygzRi2wYpIryHBKdH
         l8VTK1+jO3yYX/nAybvVz4AIEV9AsLrmkqE+m4P6HWsliEZXGOFF1/gJ2ZxaUFiOi3/b
         UUI4p4la6OhyD7JNC84wUIga/rgkY8v/lsaX0E3qAWJCmb8fJlX3xVpKfaIjOBa/U2RR
         0ynVabos38VHODt5PDlZ9tGGFjJG6IFCQjtprJuLL/YPAjVurXdHTC2RgQX28JUNRrc8
         Rme8JN7AzkVnmcDFcW3VY7o5ENnPNGRGjndk7XKKOJkXM2JnttHh98NnHECQed4R0oKN
         ajlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776091592; x=1776696392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdpVrhZa6a+vl2BmbR7xizi71fAKE9Cvxh2ARaOoj+I=;
        b=F+G/UJ6u7CmD3q7PWlF7NdOg5rUJocJ7rqAEHaZu3qqq07yZw+BZsgGgXvTuLolYQt
         69RzO2Te/AvbZHZXfAdT6RjJ+ct+JcxtXB5C2LvZYZ6G0Dq5qSjyNyI6mP+emHVek3Ap
         Rz00Lh4Pub8kfsMpLmZFVHkHRbvrS+OYcK7IXRey9JQV+nz639sQE244SA+kUAcWUBvA
         MtluAA357HrU4bULXW9WCEU9YABl+qBU6cZ+1owlTQkvqPWGvgBrGdCT0VSaSs3j4xvz
         88crwESuqasSxzO2IydjNDhTajzeqPTGCEYJ9PvocBXUcYabAuaA7rTwxQ7p5ywS7zFx
         vUIA==
X-Forwarded-Encrypted: i=1; AFNElJ+i83ZbramHs9jBFUXEM9ytPX+uGFETqLitIQebpRHev1Xki8QUK58douCqq0g8UWR4hKOl7xe5bz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy07kEoJfgzwGEuDUKePdmsemR1czRTVlyiOIXdkSi7E9z4/Ec
	/T+vIQuEIicGs4UdNeTNChKhdjNrzhwaeGqMG+LXqxwfE5xJovIjLo9TP01bf6IRD+y0UB02Nsd
	tPK/E
X-Gm-Gg: AeBDieuDt60ev1cskV7yQIzbNCAbem5XOHc1z9k8X0Js+zugcRJ2ptUJstlk8yH26mW
	7wLEYFwVLiXyRV+s4OQxqJ0PT7/G1RJqL3o4mVEfUgCJV2Sv86psH62IuQZ/gaPaYkJPHVpnk5q
	wkedRZVJ4/R5YrXU1FOHPD6y+8Ibf0K6Ec5k/tYDesUwVyCkMrVPeZltEJ2iKWBml6MY26hxw9Z
	k97V1uGXUieS2nIK/99iisAAgn9QiiGx67VWwMWJ9GpgO6zUtEOwQyY1/+z7HoKR7bRAZCxnymm
	UTFYOyquSruyzxQ5Rz3y+UwoDydEI1H9RinxykNUhv25LD+0XTQKdFzIGP2lZIcSHS3rhql3vwF
	0xwzkIZhiYRcExQfanVMzlj+dL7Q+7KxQDf6+5S0gASj0lohnbMcyhd3uZF121/+/birVl0lx10
	G/LuXtLsLiNgEnpvj2dPkjwc4tV/ZJjoP0JJiSEq0HT01JeEwxaZFAjOR8AUOqBqvlm9CyLHDCh
	36kwcE1VA==
X-Received: by 2002:a05:6830:2116:b0:7d7:cea3:6d89 with SMTP id 46e09a7af769-7dc27c63d65mr8962027a34.4.1776091592050;
        Mon, 13 Apr 2026 07:46:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1963:d48d:f7b2:862? ([2600:8803:e7e4:500:1963:d48d:f7b2:862])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26576d30sm9503642a34.4.2026.04.13.07.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:46:30 -0700 (PDT)
Message-ID: <03fa0593-851d-4ba1-98fb-ad0c53cd78bb@baylibre.com>
Date: Mon, 13 Apr 2026 09:46:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iio: dac: mcp4821: add configurable gain and fix
 scale handling
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org
References: <20260413094449.18837-1-nikhilgtr@gmail.com>
 <20260413094449.18837-4-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260413094449.18837-4-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Subject sounds like two changes in one patch.

If we really are fixing the existing scale handling, it should be
a separate patch. Or if we are not, the subject line shouldn't 
say that.

On 4/13/26 4:44 AM, Nikhil Gautam wrote:
> Add support for configuring the DAC gain using the GA bit and
> update scale handling to follow the IIO ABI.
> 
> The MCP4821 supports two gain settings:
> - 1x gain → 2.048V full-scale
> - 2x gain → 4.096V full-scale
> 
> Scale is now exposed via IIO_CHAN_INFO_SCALE and reflects the

The driver already implemented the scale attribute, so this doesn't
sound right. Maybe you mean scale_available?

> selected gain. The driver returns scale using
> IIO_VAL_FRACTIONAL_LOG2 and provides scale_available with the
> corresponding values.

It already did this.

> 
> Writes to the scale attribute are validated and mapped to the

Writing wasn't supported before, so would be more clear to say
that we added support for writing to the scale attribute.

> appropriate gain setting. Only supported scale values are accepted,
> ensuring consistency between scale and scale_available.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---

Code looks mostly good now, just one thing...

> @@ -140,34 +162,72 @@ static int mcp4821_write_raw(struct iio_dev *indio_dev,
>  	__be16 write_buffer;
>  	int ret;
>  
> -	if (val2 != 0)
> -		return -EINVAL;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
>  
> -	if (val < 0 || val >= BIT(chan->scan_type.realbits))
> -		return -EINVAL;
> +		if (val2 != 0)
> +			return -EINVAL;
>  
> -	if (mask != IIO_CHAN_INFO_RAW)
> -		return -EINVAL;
> +		if (val < 0 || val >= BIT(chan->scan_type.realbits))
> +			return -EINVAL;
> +
> +		write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> +		if (chan->channel)
> +			write_val |= MCP4802_SECOND_CHAN;
>  
> -	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> -	if (chan->channel)
> -		write_val |= MCP4802_SECOND_CHAN;
> +		/* GA bit = 1 -> 1x gain */
> +		if (state->gain == 1)
> +			write_val |= MCP4821_GAIN_ENABLE;
>  
> -	write_buffer = cpu_to_be16(write_val);
> -	ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
> -	if (ret) {
> -		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
> -		return ret;
> +		write_buffer = cpu_to_be16(write_val);
> +		ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
> +		if (ret) {
> +			dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
> +			return ret;
> +		}
> +
> +		state->dac_value[chan->channel] = val;
> +		return 0;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +
> +		if (val == 0 && val2 == 500000)

This only works when realbits == 12. We need to make this more
general so it works for all supported chips in this driver. There
are also 8 and 10-bit chips.

> +			state->gain = 1;
> +		else if (val == 1 && val2 == 0)
> +			state->gain = 2;
> +		else
> +			return -EINVAL;
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
>  	}
> +}
>  
