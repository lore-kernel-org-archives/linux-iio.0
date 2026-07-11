Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC12BFC60
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783800098; cv=none; b=DQ/Li0J3dIZ1NX/92frQrExNL0VaBNOtmJkpSxJFkEgw2sLkYB8h1XFEyOvx8KZBRIIQOGbYQOeJWmcBJp5yC+fne5vaYe27afl7KjyHcWPmKySPfvN94OSYENBzgj8pJglXR3SAzIapofZDbMjMbgvCqdGj8Mm7dKhqdSHlO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783800098; c=relaxed/simple;
	bh=JzoMDD2e3Y4x2L1JcFpRtMyDd6mKB7mJBIKd7hy+L4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkOR+kTEAn3DyqthqF3Pu132+aWWPwd6ba+HF9K2jrvxqcrAAYi4/9XR05kjCVI4k+WyvJ/llrodiK0hYKqc2VAVK8Q9BRIx4s2PJx0vU0+f+esBDXbXQonscSL34KsZ7/1aMAPUx4kWfdwo1O2EH9wYYYryoX8gp+KHn8NxIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=W8k6hboz; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="W8k6hboz"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso927344a34.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783800096; x=1784404896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaMlNBgFwvBYNiy0diMEqTdJ9KdbFMiBAP5QZKJLpH8=;
        b=W8k6hbozQCOoqqGJT39fh9HWevpTRRD1U2PWAHW9phCRLW4wI7J/ZO69j++YCyPNEu
         VmUF3ON3566fWLvMlyoRTc/LFpiHIzoJjUwvlqpql12SAmNO3iftrBCaFb7Ov2ZBu4VX
         GYyg3MBR0+s1pH9f4P9l0MobPPJubW1nQIjVtEfF4+M6rW34LGXGjrkO2S2bXnXDybvU
         nu1VcA6TdD99yHU9GAC9DsaQXbXUCvk/hiLX0OtGboX/AuvyApmBCf5GCfzoqeKjHg4M
         F70Df1EWWjFuf6anyUfKAg7e8cKWa/go522CSALi8NGMxiskwdXJyWR8ajf/grleDSKU
         WGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783800096; x=1784404896;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iaMlNBgFwvBYNiy0diMEqTdJ9KdbFMiBAP5QZKJLpH8=;
        b=qTQWP452544sf3uC9xLr88911bgFy+7uJZGymtJSXynJ95pPOLFMAbHBS55ddrWefC
         jfgeISzQKatYPBhine27Vfl5IZPO+sWAZfe9vWLtnGA2IajAFPLA2vayk53Wjh4xsjXc
         yk1o4DNo9VUHrz+hAJG3W4mHd7vK2gzwKrqMCM5w3xNrArxUByQJN9GCSF8XHGHLEWFO
         IkapJsgELr+rgJp2VJBK+eu8DR0FRGuQ0Ku6pbhtH1MfkO16SpVaC6FzGfT5bZH9TuNx
         SX/vP1dyKuQ/aBQu5Tc3qkl4UxgnhOsoyrvJAezEBvac4fG8Y7TqMAsqaDtxXXfLWGLM
         cXQA==
X-Forwarded-Encrypted: i=1; AFNElJ8GGGss1XQROhTEQ65oDZw0BwsDR306b33UDHQDfBCpXZyEoHUUNYRU61l1Y/VoYEDidBWbNX8zDnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvAv0hlAB+ZLNWDY6Cnjo+TXKP8zG7ejKIUvm1ASqtHu5DKSVj
	e4I0NhixRKc2GDXJOpIBPdQLn0g7aJ9p7+sgjFXK2dctbe2bMNwZ5Dt3jBCrxadl0wo=
X-Gm-Gg: AfdE7cn2xm/q1tHqlzg3FNq2cvL3kBsWLPRdMbaWWQgb1lQCequ43qIOt022A6wcore
	VpldtxYeZXHDS0MsDzraX2TTBSMaw4KhvQXxmtDJProjYu2pcyrjx0v6edBKR15YsNjUhbIND8z
	0jFUxQsQfp8b/vAnJfFK7lxkzw8YeZNMlhjUE8Ir8z+Wfaae8tDJ39879bLJzbT8dH2jqi3zlrn
	ar3glkixLCgeqwjMTbKXTcubPOSZB+gquXFXKM1wclWvbQO4Te+BWxSP3U6ms7LxXU+2HIXb/K9
	uz21cboY+jVikbaVtX4or8SGGwBPsjdQFEQK80nz4p78EAJEgvpxbesJGlw9qkAZsrWxwj6uZdO
	SCRkyXrMS6H+B+WjFIftBfV7/ze4nIgH4N5fH7V1dJfxDz3AhKwI/267Ey9FfccJCPAGtgz4sQp
	+Sdv2YP1ur6HCdNNIZTKQ4JLzepQboG5ZYJUn5ZcBvravoEHySOboJlBItWJd5s3M=
X-Received: by 2002:a05:6830:449f:b0:7d7:ea9f:c0f9 with SMTP id 46e09a7af769-7ec0931d959mr2172652a34.0.1783800095775;
        Sat, 11 Jul 2026 13:01:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec2183a28fsm44317a34.24.2026.07.11.13.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 13:01:34 -0700 (PDT)
Message-ID: <35c47ff5-0a8b-4c99-8e5b-d86c04039e17@baylibre.com>
Date: Sat, 11 Jul 2026 15:01:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz, jic23@kernel.org,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
 sakari.ailus@linux.intel.com, wens@kernel.org
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
 <20260711184414.1013686-4-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260711184414.1013686-4-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 1:44 PM, Jakub Szczudlo wrote:
> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.
> 

...

> +static int ads1100_get_vref_milivolts(struct ads1100_data *data)
> +{
> +	int voltage_uV;
> +
> +	if (data->ads_config->has_internal_vref_only)
> +		return ADS1110_INTERNAL_REF_mV;
> +
> +	voltage_uV = regulator_get_voltage(data->reg_vdd);
> +	if (voltage_uV < 0)
> +		return voltage_uV;
> +
> +	return voltage_uV / (MICRO / MILLI);
> +}
> +

...

T;
> @@ -276,6 +310,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>  			    int *val2, long mask)
>  {
>  	int ret;
> +	int data_rate_index;
>  	struct ads1100_data *data = iio_priv(indio_dev);
>  
>  	guard(mutex)(&data->lock);
> @@ -292,12 +327,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* full-scale is the supply voltage in millivolts */
> -		*val = ads1100_get_vdd_millivolts(data);
> +		*val = ads1100_get_vref_milivolts(data);

Obviously, the existing code was getting away without checking for
error here. Since the ads1100_get_vref_milivolts() function handles
the error case now, seems like we should be checking the return value
here as well.

>  		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
> -						   data->config)];
> +		data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
> +		*val = data->ads_config->available_data_rate_hz[data_rate_index];
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
