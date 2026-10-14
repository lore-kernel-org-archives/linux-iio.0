Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D03C2790
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972249; cv=none; b=d0Akxjzbt3XBd8vzzLSgBWb0VbAcVmydCHtzd2239I/BeYr5AjgOt3xLr6NmReYcQY3YSb4vb9waXsusRmgBNWWq0enNnjJDWkNOd+vkA93tFm0pWhHgq+KmVv24dc0to5A9wz++i2h7qprj2VxDA5T4bU57uFG5drdXEQ1kR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972249; c=relaxed/simple;
	bh=060y4h6BCREz2veKTYINyjEgllxgh/Lbne16CwjQutU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Noow9Wj2FQK60WsgJo5a2Rc4lkKx4olEs8HEk+h9rTl0yXQF0G5DHJHcZTYnSopk63U10/LwSVr2xPqerfGb61CC8zx54WssbkNyKhYhz9rLWVlpaX6HPTm3EuueE23Lc47y4sH1a80DtJ+OLiDLcGIo1z9ugF/7JDEkCFVL3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHnxk6Eb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHnxk6Eb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-486e70f2457so131821f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791972246; x=1792577046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83nMmOQIZqdWD9+WEuaPAFERa9gPcu3uwdWyfDhUP2Q=;
        b=mHnxk6EbYJlf6fLatNM4UPH1WDJ3fMtpt3XgDSsLTXMxEO+oU2SBGgkzoUVV8HngSe
         qrxpvxl+uUdBoMOkyGpDMSAfEsRZ+frn1CkYtkfgz5/XsiYTB18zhAkrLjnJ18IFWKSe
         Yifli9xhiFQGe6jrznu0OScJeTSEnb7ffDwqK8xXqO1NyfI7Xhwg7USZzr/zlnvPWK8C
         BGpUmzh3wF8jWgxxxy4wh7mG6goe/qEU16d6UjKuxXbgMY6TvayptBJzuZI/XBh8gfX4
         BzUHoah7tEqnyk89lxMefu6s1Ayf9LgDYfwlhRA7jpFF/kLcsDpF8XGKMGex0ktG9LOc
         jGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791972246; x=1792577046;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=83nMmOQIZqdWD9+WEuaPAFERa9gPcu3uwdWyfDhUP2Q=;
        b=J9h9bV47aEZqMohi1c7wkAz6lnSj3fSk2rE1Yo/lpVmLsF2X+y/Wj/8aWCq03PJ/aJ
         xqYrbJvhMQJCzm/vHvaGSpHJYe0GgWx944CRQUCA7uGOIolyEb6AWbNHGe4X2NqKn6ZR
         NfuxiRvnJiaqG2+I43y0up9vRBnSyfwDgS4H5VTisZQhuAbaj6N8g/VhrEXpr6krJv8k
         a5uss/ge9Q8Qaxki04etdQcbTm3/MRGDeoMQp+RHoAKFFynfMlU++IEA7NbUH496iDJh
         2jfLjevNbnd5BHoy9RZTKTQ/TSy33qZx0MUNwkjlX7Zk2rJr3fvxQhTNBnofT+sn6mSe
         pC9w==
X-Forwarded-Encrypted: i=1; AKwUvBxJYdigTl5Ym/VU80yfB7NpNhaxWL+69PYcHlbbxs+Tm6lcyg+L8vH9zVpTYTqQPn/FLRP7zQymE3g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpA5Y4IxTI8lVSoBqLcEuIQ8gBZ3/If1ascX1cC0QJwYpOCmQ6
	yiVk1lPALlbfs4eDOAkENnu/D4vMm5udLunAKXJbzXyuktSL/5aDmgPJ
X-Gm-Gg: AYBFou2oHOQMTiktuFc/iPcv41OWQxhcw+rh77l0zjl+KaQdC0b6GZdFy4KH6ZOqZTd
	M/K9Y7xJji3+EWWmfGd/DsfRMd7vayRkp3Z++Qe10AUCcIsLsX7dXSA3As6gr91uGBXegCSJfH5
	bEhBvVrn6JdW9Bbs9dep1XGmm9isPk/yyLx2MrpDBq8aCXm4XIcnsSNy0XEQ4oyeEy/D7k1s93m
	tlctMIIYXoZ175XP35BoAT1ZIeGIngJGJVqgVBpPE9zQGfas4UNxdZMAzRN9AseESceTcLOvUqx
	mMoot8n5sXMvugcNVYQ4ocfs4Acz6BGbWJ0p9WK3ITDtUPvIMo6d19X2vwIFq+bDdp7XnTm4pHM
	MUVXVUGM01agh2gW3sqRYLCw5GQ24ICoOXQ4dFLPRhHa15yp0X7qAkVvEeFlLxQQiD2MxDPQ5jI
	8pTueQJz8H9XWStDG9p/44yVkYRJ5wCfWjliDpbZUdl19hx0d1Ta5JybIUyDvG8lHd1rmwk+dwV
	xGa
X-Received: by 2002:a05:6000:2481:b0:48a:f318:ac02 with SMTP id ffacd0b85a97d-48dba9bdbaemr32888695f8f.19.1791972245977;
        Wed, 14 Oct 2026 03:04:05 -0700 (PDT)
Received: from [192.168.1.18] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa5dbsm11296208f8f.12.2026.10.14.03.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 03:04:05 -0700 (PDT)
Message-ID: <528bad54-d862-461a-897e-0fd6734fd8d9@gmail.com>
Date: Wed, 14 Oct 2026 12:04:03 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
To: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Shi Hao <i.shihao.999@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
 <20261013115639.167433-3-marcus.yu.56@gmail.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261013115639.167433-3-marcus.yu.56@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 1:56 PM, Chang Yu wrote:

found a few things before I can give a tag, correct me if I'm wrong.

> The driver exposes 12 spectral channels (11 visible light and 1
> near-infrared) via sysfs. Runtime PM is implemented to stop
> measurements when the device is suspended or torn down. Power is
> never cut (PON=1 always) to preserve register values.

PON=0 is SLEEP, not power off. per the datasheet, entering SLEEP doesn't
change register settings. idle is 40 uA vs 0.7 uA in sleep. worth
clearing PON in the teardown action, and probably runtime suspend too.

if this goes in as v6, Jonathan, could you drop the "to preserve
register values" part of the commit message when applying?

[snip]

> +/* AS7343 channel indices. MUST match data register order above. */

nothing depends on this. drop the MUST, just say it follows the DATA
register order for auto_smux = 3.

[snip]

> +static inline int as7343_atime_steps(unsigned int step, u8 *atime)

no inline in .c files. same for the other helper.

[snip]

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		/* Wait until integration time passes for all 3 cycles. */
> +		msleep(160);

derive this from the ATIME/ASTEP defaults, or spell out the math.

> +
> +		/*
> +		 * Reading ASTATUS latches all data registers to this read.
> +		 * We don't care about the returned saturation/gain status for
> +		 * now.
> +		 */
> +		guard(mutex)(&data->mutex);
> +
> +		ret = regmap_read(map, AS7343_ASTATUS_REG, &unused);

ASAT_STATUS (bit 7) is thrown away, so saturated counts get returned as
valid, while the datasheet says to discard them. ideally fixed before
this hits a release, since changing what read_raw returns after that is
user-visible. Jonathan, any preference on what it should return then?

[snip]

> +	/*
> +	 * Setting a 600 * 2.78us * 30 = 50ms integration time as the default
> +	 * for now.
> +	 */

cite the datasheet's typical config, that also answers Andy's "magic 600".

-- 
cheers,
jose a. p-a
