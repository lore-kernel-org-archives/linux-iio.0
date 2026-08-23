Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216F1DFF0
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787443572; cv=none; b=MLVxiaPGdoDZGIOgibU9t8fLVVPR/rsmnFS8xZtTUiTMKW6jLaftLSfTqkhif5dgDrZS4NxW8KRSoMyTmnx/pPCqoLf9WXgckMIou+UUFOORRrITa8qyFgMuL+xguZsr7q9843UJ4idiJzgzMGza0Lj4LtNj8UpGd2T2ZH5BKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787443572; c=relaxed/simple;
	bh=hMUtzbQ/rbYUAnm2d4IyxCBoXWNCdFwKKOOb6WzqX7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0a9PLv8RyCJ+NpX8JcnzOCW6JCRkVDaBYEvFVU78dLcSTjXNxgWtVwU06zPGCzKynQFAqWfUdBGd1BYgbY4CODQWRVrnNQejeUzIXvTkI2SXSU85V7B+Gv8IQnCdpSZzdUA6szqJsVJJejN2nc098mjBlFlEJ2n49dGPfNYl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cg4qdTlA; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cg4qdTlA"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448b69cfc6dso2153657fac.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787443568; x=1788048368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7sEtYo5SjbZ2yoLbudIWXFLOzKlgfbvUciYXGTISHo=;
        b=cg4qdTlAmorswVm5Wxmy2FcMur74z4KrKL1QNO0x14K2S80X85U1KYzDuT+krKBHXG
         cpzlhD/usytkvevw0dJ9Le2dkaZK1h3DXTukNf1KpCg+HZ+X7qVQezTrd9M7OOaNLZYW
         gsErODNLu3raJkC7QgkfTy8gWHqAlRiU2Dsd4jCP/XDz/skTpO/hBMm4k5gvJgYyyrvz
         iH8HtKqHsxDBCTYp0wf+/C1bXa6plQkfCpmaChQe4FFgFlxlfgjFkuxHNnKz9r4JGMDs
         MxyCyjmuAtSiqb0TuZKBFxjh7LpumsVHSLafX8c7UTowlUt7n4xHuCbDYKWLeMdIEHGD
         gpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787443568; x=1788048368;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q7sEtYo5SjbZ2yoLbudIWXFLOzKlgfbvUciYXGTISHo=;
        b=GnOGl3JhBDBgVJ2+CU8hjwRTPKpwLpK6QO24lx1+0Q4xqdVpzG6sdt6yR95FmOeyvw
         Yg9nhwQQCeywVeSxV2EIgKfUcz2aeS5QxfaWAdDAEd1pscsoODTmLT5LuPB4F1nCHuqL
         bU6OCKcuiTm6vWGPVGsn/GnSsRSR9r24L0bK0fx7VLJPrkTCffNIR5RkZIck9hwJMR+Z
         SYAMSGAb6iovu3+/+OKQvqifemjUMD87pAPh6TDwA/zBoeRytHkiE4WcFCV7K6WVEESN
         jXksTsHu9yCSPo8vmEjADolKF9ZvmEIx4EBknhxAGf/vGeNyQTpjXX4qGz4C3GKbk2L8
         Kp7A==
X-Gm-Message-State: AFuF++lMXfnpDIkHc3SwqqPzNZ5eb15qaL2nGmnuz5bkmxFJvoWfghvX
	J/xv6I0+XgxJdHhf66VxZhY9ZC8b0k9+gv1Vw3/Ixb7Lhl/JPmYcwHRQ9KbTPI+QEDA=
X-Gm-Gg: AR+sD132Fc4W+Z5Zm/9/pkemoOpdEp/dMxKSzNt69Zf1mcC8N58wLObDvmJaZnOgdgc
	zGedc/FqrsGvp8vYCCGm0nKc0C/INJBcmSxmVqpfVgIxFPJfrEnpvG/mm9LdgNg5JCB/Xo0IV6l
	pfJPLqC8GREwGqCysu+UbGDkRe8vtQGCVNsl9k+UdevMfxFVB129A3KkqNl7Q8lJLEy22DkroZ5
	aGcx2mdhQY/SpENLLjSZiS/hcC+LLDTRQf6alu4ICIhv/j1ou8Y92sNk7+hGeJy/y/uZVfGecF4
	H9bErASLQ/Sv/IKYlvTHkyeIlfwkF+Ekbk4up0mHcTm1oaHQ5glhg6OcLX80jzxdBgux1NO5Fln
	WBq5AvGq9Yt3tJLFNvmwrB+E8JPGDJojLUGStP8+AkL16zmtWdIlLMUpepXPVgFSIC8Pvf54odS
	Fg3Lu4czh/a5ScD41KjogTHMEuV9cAzGvyN6BkHkNdr88M9hS8n+wy42TkHVmS3rjF4Fl7pb9p6
	9cje9IU8jVaYkUGn34qbq0fG1GmSP4Xwwu1GOs=
X-Received: by 2002:a05:6870:808a:b0:448:d78b:17d0 with SMTP id 586e51a60fabf-4635140d27cmr16499461fac.13.1787443568496;
        Sat, 22 Aug 2026 17:06:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-463834af0absm2460516fac.12.2026.08.22.17.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:06:07 -0700 (PDT)
Message-ID: <1b0af12a-0653-4a14-9c0b-4948eab9a4cf@baylibre.com>
Date: Sat, 22 Aug 2026 19:06:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
 <20260820-ti-ads112c04-driver-v6-2-0e8f0aacce9b@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260820-ti-ads112c04-driver-v6-2-0e8f0aacce9b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 2:51 AM, Kyle Hsieh wrote:
> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 

...

> +static int ads112c04_parse_channels(struct iio_dev *indio_dev,
> +				    bool *need_avdd_ref, bool *need_ext_ref)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *channels;
> +	u32 num_channels, pair[2], channel;
> +	unsigned int i;
> +	int ret;
> +
> +	num_channels = device_get_named_child_node_count(dev, "channel");
> +	if (!num_channels)
> +		return dev_err_probe(dev, -EINVAL, "no channel subnodes found\n");
> +
> +	if (num_channels > ADS112C04_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "num of channel nodes exceeds %d\n",
> +				     ADS112C04_MAX_CHANNELS);
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	st->vref_source = devm_kcalloc(dev, num_channels,
> +				       sizeof(*st->vref_source), GFP_KERNEL);
> +	if (!st->vref_source)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		const char *sp = "single-channel", *dp = "diff-channels";

What does the "p" mean? I would make the names the same as the string,
e.g. sc, dc, or s_chan, d_chan since they are used quite far from here.

> +		struct iio_chan_spec *spec = &channels[i];
> +
> +		if (fwnode_property_present(child, "excitation-channels"))
> +			return dev_err_probe(dev, -EOPNOTSUPP,
> +					     "excitation-channels is not supported yet\n");
> +
> +		st->vref_source[i] = ADS112C04_VREF_SOURCE_INTERNAL;
> +
> +		if (fwnode_property_present(child, "reference-sources")) {

ads112c04_parse_vref_source() already calls fwnode_property_present(child, "reference-sources")
and returns ADS112C04_VREF_SOURCE_INTERNAL as default, so we are duplicating that
logic here. Either drop the helper or drop the extra code here.

> +			ret = ads112c04_parse_vref_source(child);
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
> +						     "invalid reference-sources value\n");
> +
> +			st->vref_source[i] = ret;
> +		}
> +
> +		if (st->vref_source[i] == ADS112C04_VREF_SOURCE_EXTERNAL)
> +			*need_ext_ref = true;

Can just assign these directly:

		*need_ext_ref = st->vref_source[i] == ADS112C04_VREF_SOURCE_EXTERNAL;

> +		if (st->vref_source[i] == ADS112C04_VREF_SOURCE_AVDD)
> +			*need_avdd_ref = true;
> +

...

> +
> +		i++;
> +	}
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = i;
> +
> +	return 0;
> +}
> +
> +static int ads112c04_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads112c04_state *st;
> +	struct reset_control *reset;
> +	bool need_avdd_ref = false, need_ext_ref = false;
> +	int ret;
> +

...

> +	/* Datasheet: POR releases ~500us after supplies are stable */
> +	fsleep(500);
> +
> +	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset), "failed to get reset\n");
> +
> +	if (reset) {

I'm pretty sure devm_reset_control_get_optional_exclusive() already asserts
the reset. So the way this is usally implemented is that we get (assert)
the rest, then wait chip-specific time (usually a few microsonds) then
reset_control_deassert().

I don't see any other IIO drivers that are using reset_control_reset().
(And I think a lot might be calling reset_control_assert() unnecissaraly.)

> +		ret = reset_control_reset(reset);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to reset device\n");
> +	} else {
> +		ret = ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> +		if (ret < 0)
> +			return ret;
> +	}
> +

If it wasn't for the duplicate code, I might have said good enough. :-)
