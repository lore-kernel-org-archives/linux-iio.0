Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AC4A99D1
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374273; cv=none; b=caiyushl9YmBj/KqVynsJWXKTW7vS9es0iWDJaJECG4yHqvTuxYalS3NI/X4/2uBNygCtSSkU+zvbqNs1nVyj6ezYxrSb1c+d5zH6Lyw8W+ScN+IGp35tCT1dew8q37kZEavmSnFmcW56YsUZTbDnBD5gXvVR+gc9U6wY2R/MLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374273; c=relaxed/simple;
	bh=uofRsaC+6uLSQZE9L0Az8+9rDxsZupmTT6ddwUMu1pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BV8g/ODp6L7OSKh9D+HSE9K0OZ9iqdr/pFG3resNc47cETyzCV4SasK7lYz5tmAF/5sVfnXZHasSXWn9ZDpB4fsPzQ23PYX4kDOO7BKqlKEBzJh3D6AHkAQKRnALZHw5n3wFCx38Gl2mI0yHzok+3hB+8BhyMkL7XK2qUGYjawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hs5HkJSJ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hs5HkJSJ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b354127480so152906eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788374268; x=1788979068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dk3OT6AljFk/kgpHjqstGw/si6tOmIKbjRNHYxcumk4=;
        b=hs5HkJSJEaIX9HFgzn87ukGx5bwTmjRYcRMoI0azTMTo1B0scF0bvFi/jyIG/zGx5v
         tVivLyCqjw1IXrxiyMIXWjgMIjLw+la7uCmpOUd/IR9IL72foyWfivb3oyjDUZPau0Tu
         EHSnEPKCIUMHvzRDJmJ4oHESJRr/MQcAyeZkA2JXUzRS9lx1gV6eXlo2JZBis7teNbAF
         SzQAIYFWHNYnGDgTOPUh8D3ubWBXN6NQrV7F6fztaa6PLyifbF9WC/LT/FCgBTpkAfVb
         K7mM6Rq1S6QymjqK+aPQ99O9zsJjvGW90DB7zkBM5sSr41XuR8akBwYD2E4Nd6LfVjbK
         9UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788374268; x=1788979068;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dk3OT6AljFk/kgpHjqstGw/si6tOmIKbjRNHYxcumk4=;
        b=nZWapKvk+aS3nMss7Z3PpgLK3eAQV4IJpMxRg3GCklhvoyP+f/LU+ah/UdsusHEjp5
         I+N015ZYz6eA6lA5TOPuGF6487NvkuG0d6UvzsCIve42K/DYxo7qPZkUkscSYNIIb15Y
         0UcCML5mouoZJS+2a3VdctGMMII+88d+xX1ime7ywfAnxGzCnbyQnJLux3eRPOMh816y
         q7BCBWfgFqOsbPyngoI45WvqWxXw3MZitJF4OLh+7i8Lw/qLcvmL5E9pPQ4J1zKaobeS
         DL+0Re+eqC5zhzUPsQWiFF+u8aQUQpvKSdq/McW6oh0Au4q+BihgBuD2w9acHW4fGURA
         9Pyg==
X-Forwarded-Encrypted: i=1; AHgh+RofPASwvvuQGEJKhuvDrgxEIi8olwL87B1yOLVsjsyAH0SG0q+Fz3ZZx9gi2ZPHeBRFObXGdn+fmIE=@vger.kernel.org
X-Gm-Message-State: AFuF++lji9NqykbIaT7kltnc/cmqrietGOChLeJchw6VDfaIdtkSVnNI
	fC8RyU3eesIcfh+M2c0ME/RCwkpyU7XxjHxv1diRlb3nrrLk+tN1u5mQTLrf1fIF/xI=
X-Gm-Gg: AR+sD13KVy44JMLjM3BhyJoyam1AzQWBdQyF32Xlr9rwxitEyw571L2BouL7+8MyQkv
	XwoqLb9Kh6EoKE/3LTZtSeM30lX2B1GCBrE+fxU78+jH0w2eDigzRTefnW6Iq1voGdonh9Rzar1
	jK580yDIUUAtC64b7s0ds3xcKZj0qsInLuxWhBQLmpdCR0eeL0IXPAmjxshiWDvHdWk74beK4LE
	QqENlnKQU/8nEl0beL+FxH3QZcqb/yDxN7GUEKzrqVqRSrEvNGMlu9AZsEF4UTR43DKF4WGRNoY
	lvncWoJvx2EEBR4D9rQmvKKiJwuTm5RgxkLeiWRka7X3j2kBJelnTCDK+pbE/d8QDEOd23yCMMG
	uCD9Oiw/zpiXAPlXbme5E78DXPXMOdA8YQ0o52ZIRfJ8xf6fUFSAwXEuxXDmT3NTyNIbhKwI628
	RVSXmArr+efB9ZXJqkqLYEUYzSxOhh+8Zd7CCoL4g/iIsrYs8H5kGRVdDRGieBJomM8DMW92Ww6
	hCLgdSpwtK6VzN/UU2D7jkwdp3sMNUc0AjaYwFpUrcR+gsKJQ==
X-Received: by 2002:a05:6820:1686:b0:6a1:8132:cb27 with SMTP id 006d021491bc7-6b5841dcddcmr843359eaf.9.1788374268598;
        Wed, 02 Sep 2026 11:37:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:518a:9db8:615b:293f? ([2600:8803:e7e4:500:518a:9db8:615b:293f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ec2eb8bsm3128222eaf.11.2026.09.02.11.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 11:37:47 -0700 (PDT)
Message-ID: <cf9a0918-3e06-4532-8e72-ccc4d417e6b2@baylibre.com>
Date: Wed, 2 Sep 2026 13:37:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1015: Add support for label
To: Flaviu Nistor <flaviu.nistor@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260902172230.5234-1-flaviu.nistor@gmail.com>
 <20260902172230.5234-2-flaviu.nistor@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260902172230.5234-2-flaviu.nistor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 12:22 PM, Flaviu Nistor wrote:
> Add support for label sysfs attribute similar to other adc devices. This is
> particularly useful because the label can match the schematic signal name,
> identifying channel voltages easier if label is defined via device tree.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---
> Changes in v2:
> - Implement changes suggested by Andy Shevchenko. 
> - Link to v1: https://lore.kernel.org/all/20260901184302.8127-2-flaviu.nistor@gmail.com/
> 
>  drivers/iio/adc/ti-ads1015.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 0fbfa4e499aa..8be1f0c32ca9 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -233,6 +233,7 @@ static const struct iio_event_spec ads1015_events[] = {
>  struct ads1015_channel_data {
>  	unsigned int pga;
>  	unsigned int data_rate;
> +	const char *label;
>  };
>  
>  struct ads1015_thresh_data {
> @@ -586,6 +587,15 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ads1015_read_label(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, char *label)
> +{
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +	const char *name = data->channel_data[chan->address].label;
> +
> +	return sysfs_emit(label, "%s\n", name);
> +}
> +
>  static int ads1015_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan, int val,
>  			     int val2, long mask)
> @@ -843,6 +853,7 @@ static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
>  static const struct iio_info ads1015_info = {
>  	.read_avail	= ads1015_read_avail,
>  	.read_raw	= ads1015_read_raw,
> +	.read_label	= ads1015_read_label,
>  	.write_raw	= ads1015_write_raw,
>  	.read_event_value = ads1015_read_event,
>  	.write_event_value = ads1015_write_event,
> @@ -853,6 +864,7 @@ static const struct iio_info ads1015_info = {
>  static const struct iio_info tla2024_info = {
>  	.read_avail	= ads1015_read_avail,
>  	.read_raw	= ads1015_read_raw,
> +	.read_label	= ads1015_read_label,
>  	.write_raw	= ads1015_write_raw,
>  };
>  
> @@ -861,7 +873,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  	struct device *dev = &client->dev;
> +	const char *label;
>  	int i = -1;
> +	int ret;
>  
>  	device_for_each_child_node_scoped(dev, node) {
>  		u32 pval;
> @@ -897,6 +911,17 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  			}
>  		}
>  
> +		if (fwnode_property_present(node, "label")) {
> +			ret = fwnode_property_read_string(node, "label", &label);
> +			if (ret) {
> +				dev_err(dev, "invalid label on %pfw\n", node);
> +				return ret;
> +			}
> +			data->channel_data[channel].label = label;
> +		} else {
> +			data->channel_data[channel].label = "";

I think the normal way to do this is to return -EINVAL on channels with no
label rather than an empty string.

> +		}
> +
>  		data->channel_data[channel].pga = pga;
>  		data->channel_data[channel].data_rate = data_rate;
>  


