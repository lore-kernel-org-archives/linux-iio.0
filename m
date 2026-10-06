Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB233B3BFE
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287091; cv=none; b=W2NxMZAhGOLiqpIVFp3pm3LnT+VrG5XCrF3emEXzyHdVkSRkxe084uiIg0Ge/6HbWQopN2TqL1vO7KdwiXW67xMXKH67XLvQ+JnuWoLbizcfhZvnrvWpN6R2Etwo3e+8c99fROR/5n4Xy8j2WGH8YTz8dkbczlJGtfuBC50RGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287091; c=relaxed/simple;
	bh=wmkZFvkKj0Cb7oXf/na4MzUt3wLDgMZFlXMmUmW46n8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhMWKnzAIHT25Ti70g0eEvh2d5hWq2AoY9yio08tas98/eVz/cjYXE+zi/DPUV5qAZu//yO6mtnuq0Aq6H7R44X9IB378BKj5liQwxjvoDrapHrxsL1lvk+yLH4uhjT49zgltzV6wjXO91/t4m0c+t/87rekLCKKbhZU8I1M+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcpBpZf/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcpBpZf/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso26981435e9.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791287087; x=1791891887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIH9oNewGm+iiK+DqVLwv9vwseXKMTyaRTgq2ccesyI=;
        b=pcpBpZf/3lMRRRlr2JD5m+ozqtjCowNvaWXgytkfdY5AR7DPo/8lS7HktyDefe3kCp
         hpBRSa7x4jDPDcO7kO6SNSZ8GjTeUGo7GhFyCJxfTEYzCs77pBU3POfmiQ1UqAU/+ZCJ
         1NnkPXp5+QkZd25aFL6wJKhzoytsSdpL71j3XzSXBueG2/YPECYuMWpNCyRxH05YQo/J
         nOGb7AUeD+oOOfbMx7uJCnK5JTOIuzpcmpWDZOiEOJCjfj9N7740nQNm6HNHrEIhG9qk
         QlL8Kz4fCZM2U8HGjU5ZEcDtgq/L3/R1OGg5o2S+YtFuhuQDKWFtw81mdDPjLqrAhIoP
         F/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287087; x=1791891887;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIH9oNewGm+iiK+DqVLwv9vwseXKMTyaRTgq2ccesyI=;
        b=1K90iN1KgB6dCtUNW7Jp/LLPR3tcoL0G2mOc88JVP4Py24kiddanMI6XIKdNQJLsUg
         inl/PjDW5aLxjQWSybUIvkYlbt+iJhoUb1lapiJowHHqCXHCm6dU7aXV2QT9Fts32SxP
         d2CHNZIZ3AN5B1S1XfVHnpEEDh9j0rvpbSEhnaBeYWHU2RMwkVC9qT8gDpo7aX1Yr/Jv
         OJPWIBP0en7OgbJZ7uZx2c3l6TeY1kvWjXf7Fs+cj7XaSmq+wB+oyE6HCj8QM/dUe5Jv
         PWNezA5WRBb5bS2CJlNlVTsh6v9pXZiAh/L2gOJD8BNg6BxJfUnaZY0AgvAuyI/1szlg
         h06Q==
X-Forwarded-Encrypted: i=1; AKwUvBz21Z8LNQ9u/7/PpEElE9dTexB3H2JYoDb6YjAZCG6GEPQ3wWJA3hDomeYBahT6uHXwXajPCeA+TW0=@vger.kernel.org
X-Gm-Message-State: AFuF++kd27k1rETzmOx+d3R5PpSpbcyw9vLRWnXu2Y8OOTSa7zYkkyvU
	gsYcQ0fMwh160KBWGcgNsA2SII6r0C2tq+60qwZ20XAdKR2mxmJVc55F
X-Gm-Gg: AYBFou3rsO8GZFj8KyegXeYOZr+mVi06T/dc+8in3oYzeJMSgUKxEGN0IOLnbUVZ67d
	XzdLQJ0bdijrXilPd/zXAB7v7vf/HwpBzMZFp1I7yoa9VFkyFDEVUY0ZUO9KeHsh7z8GUSz2nYf
	nh1PvXwx26BmPgG8CtfrlqXVOTkUDu9H8DdJOOWwmawr6KjD5j+tsSCty+vQVqJMKGvZfCqrxMR
	cEl1N5at1dhPia7QNYqfrrMtbc+g3xTVYAA8Q0adIH2dyRia8hBpex0LlubPsGneyeDXLQUvFcR
	bQ7LuRna3I7p7Gd64zHl66QwaZw+RomSph+qo5oYrCeA/SAYELHQM190tNOb2XiCdNFLVfo7HJz
	QVU7qE0rtcgKw0Oijma/Jeic+FOvIEWM+4UGpAKKBli0Mquhl/xSA7Z7nXEXUdyi8lBBVgxhjUn
	py8DOM65KgYFxf8Kqv9X8zfLqP8GxChn/eiqUve4iJAo9kO2pYntk7TGJdIvuCdtNpc4SL7BX/H
	BZ4OYZdbozxvnqfedwGch98iE1LS/tot7ia+q+GuM+QU4nbBRFVgu3Vmm1t+fIEp9lCwP4t2Y93
	giAYL3sgSFAb+EKYB+imiRL3acUum5GK9KoVDTrJpEVM8SwFYFy9kC1q8c9kK/YUBzuSw6TbGt7
	WwUT6CmHXDsJOMaq4tcQL+NUdChDy/l3oK1WsxVvMPNDj/sDWBBgFuF31qJsZyRTr1REcl9E4d+
	YlwInD
X-Received: by 2002:a05:600c:1c16:b0:4a1:7832:dfd6 with SMTP id 5b1f17b1804b1-4a17b5340c8mr22006265e9.5.1791287086922;
        Tue, 06 Oct 2026 04:44:46 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17c7b7f00sm19805495e9.13.2026.10.06.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:44:46 -0700 (PDT)
Date: Tue, 6 Oct 2026 13:44:43 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: proximity: Add driver for Vishay VCNL36829
Message-ID: <20261006134443.00000bc9@gmail.com>
In-Reply-To: <20261006100943.78971-3-lyf98405@gmail.com>
References: <20261006100943.78971-1-lyf98405@gmail.com>
	<20261006100943.78971-3-lyf98405@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 18:09:43 +0800
Liu Yufei <lyf98405@gmail.com> wrote:

> From: Liu Yufei <lyf98405@gmail.com>
> 
> Add an IIO driver for the Vishay VCNL36829 proximity sensor with
> integrated VCSEL, connected over I2C.
> 
> At probe the driver enables the vdd and vddio supplies, waits for the
> sensor to power up, checks the device ID, configures the VCSEL current
> and photodiodes, and turns the proximity engine on. The sensor is put
> back into shutdown when the device is removed.
> 
> The following attributes are exposed:
>   - in_proximity0_raw
>   - in_proximity_integration_time
>   - in_proximity_integration_time_available
> 
> Datasheet: https://www.vishay.com/docs/80580/vcnl36829um.pdf
> Assisted-by: LLM
> Signed-off-by: Liu Yufei <lyf98405@gmail.com>
> ---

...

> +static int vcnl36829_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct vcnl36829_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	unsigned int reg;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &vcnl36829_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Regmap setup failed\n");
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;
> +
> +	indio_dev->name = "vcnl36829";
> +	indio_dev->info = &vcnl36829_info;
> +	indio_dev->channels = vcnl36829_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vcnl36829_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vdd\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vddio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vddio\n");
> +
> +	/*
> +	 * The datasheet does not specify a power-up settling time.
> +	 * Wait 3 ms after enabling the supplies before accessing the
> +	 * device, as a conservative value.
> +	 */
> +	fsleep(3 * USEC_PER_MSEC);
> +
> +	ret = regmap_read(regmap, VCNL36829_DEV_ID, &reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read device ID\n");
> +	if ((reg & 0xFF) != VCNL36829_DEV_ID_VAL)
> +		dev_warn(dev, "Unknown device ID 0x%x\n", reg & 0xFF);

I'd rather be soft and do dev_info() instead (perhaps this could
be tweaked when applying).

Otherwise this looks good to me!

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
