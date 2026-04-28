Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA13BD629
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388965; cv=none; b=jGxtzLtN9z/w1t8wP05+/MInBRYYaK8KQDsRzteq0YLMOURCbV2Lz5/CInzGSRfc4DnG3RlKrb2wI8kbZocKjZxmf1Ki/o5MhPjHbnsfnJtPLPHFyANifpjQSO4DNHo1dDq5Osdu04UsIteV75df/Jg/MQ+X2l5FhONfzj7VIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388965; c=relaxed/simple;
	bh=2Rro+hrcRSxtA1Hfy+V4CelFaprEexxctFjvdrKYduQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLc7XGIxvCe9l64q5lO4j/8XNDkovbj+ZN7tFgsjbd8/caqYuOlwsajG76AovTwhpiv1JdkOarmoXMFc5ghqnr8k6znHlK0Wr93cEEH5pbjW4N3wkmfkdd4EVr1OXClAucbBvplhE488wQ5biPTr9KRuQRF8LKHJEddGbRRcTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=GplZwtQ0; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GplZwtQ0"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479ef2b7979so5400353b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777388963; x=1777993763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg7jclWUBdkcF9TMPmlkH1m3gUXCyVDg8YBU8lVWmQc=;
        b=GplZwtQ0Zw/McDR+AIi/zHOGNHzp1agCRb2OC1mRdkdHwABJluuhcKCzulZ5NTl5D/
         1Et3irmVsYYTnFYK9RrygYUKF52PlWcyhs2uYp3POSGs7Qq5VqZlIyGWHCn6d6wUwBWl
         noTqXAfK/M2vbriOih46nV25HiJNm0bNk2d+TInRJyy/3XlKuDI7pn1j+WShsIJL+Dhd
         tE77JtL5nk4bKCuA6zCD/ugCjOae2DcEV+QHmvLPhvXxkhHeE2jqg0SM9ng4HTUBXREE
         VwBgpmkUm2GvHt07YJOPBxfQujdVloTvxXYWNrX6xq7I3iUhVWTFk9TVjtcjY6SQNAcu
         iwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388963; x=1777993763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eg7jclWUBdkcF9TMPmlkH1m3gUXCyVDg8YBU8lVWmQc=;
        b=VsE+EUC4pDpRNdF4KUeM3/f63hCPeEs6sTUsXCfGNWMHDqelV4xUI5j28cW0JC1Ync
         sTFP151vGUvcop2SL72cWbUj+DFLmGFN4cZhHt+nV2WCiZD1rUZvJsnqx/otTESOCl4Q
         ho3I5E1AS8CxEIgfnDbPVo6o7TYYPj+xgGVKB0ze7OdccJkA6BS1QbVZzxv77PJIL5Lt
         TuS4nHh3/AD6H+za5fbKq0gw1BlMhvaCIK5IH3mSbF7Qw4dZ/2zsOMGStl7M9/3Sf/2S
         7jP5DSkC8kUoocDHD1C/GTqqPNhG1sexOjbY9afw4NLLJ+5hOkN41Uh/H/MJSP9rgNJr
         lpbA==
X-Forwarded-Encrypted: i=1; AFNElJ8njMElqc9KaGjLlkdmE0Tchm4ulkQxyK86Tm1vrXMbIXm7GPkZFQcpomBWHL/pVCxzqf+NWckGJgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiTFerbAe+AOA8NGvIVaBGgBSZjP6xtJQMshb3WN8RIiJo08+
	/Tx0RMzkp4NtqB7I8f+p2YCCuJ9LPy1ad7ows9wVsj5fhJE+6/RLnG15840fuvUXsDc=
X-Gm-Gg: AeBDietnNKfPfBy4Kxyh1SXr82nePR7DjAKL5FQJjyhtItGLbDG404wT6baPcb3q9jv
	+v9R7qB2c27ksCLhLMwOWZEX4C7ZQW9/CWJ2+ZPoBZp8m+ScX93bEIDtsoHnMIcb4bMT8jfQnEU
	f5j37CY2S0sGZFzts2i3g36aUKkXBekiYwAZWLNgRcjtUO9B0nuDZ18npfnLmHnrlP5evRd85h2
	+Z6y75OPOUXi2bACm7qPVnJziVkIj2CSLDhEMi9xmxd/Yf435olXc8J9dtH1MIoqye3O5otjg4f
	nhhNw5VgXifbj1KJh135mvDhmPEIdDzKzo6UZhDMbNsQ5s5PTbzmXfD4M8RWjcOldnPdvRgjX6q
	21QR5vyJrzvrgW227jg4CFiSqnW7GWG/Qlh7Cv0sjjYxzkLk6bu1zE9lSTPts4wcQZLRwieeflR
	p10x3KDjM2960+CvxWS1wCdhZn3a8gXZEVzcCz0VOxONu63c6rQM7PvCZ/dMUJCxwQjtMhtagLe
	ReWnI3psLDa
X-Received: by 2002:a05:6808:1590:b0:479:d57b:838a with SMTP id 5614622812f47-47c2902fb60mr1817804b6e.35.1777388962643;
        Tue, 28 Apr 2026 08:09:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:efba:bc47:a81b:dd0f? ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c28f50286sm1611696b6e.1.2026.04.28.08.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 08:09:22 -0700 (PDT)
Message-ID: <6347ce16-bf5c-4da4-91ba-fe6c88713b51@baylibre.com>
Date: Tue, 28 Apr 2026 10:09:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 6/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, jic23@kernel.org,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-7-macroalpha82@gmail.com>
 <f1ae57fe-1ad5-46ee-9f0c-245f4deec7ce@baylibre.com>
 <PH0PR19MB997338EE6A13BD08879C4B9B2BA5372@PH0PR19MB997338.namprd19.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <PH0PR19MB997338EE6A13BD08879C4B9B2BA5372@PH0PR19MB997338.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/26 9:01 AM, Chris Morgan wrote:
> On Fri, Apr 10, 2026 at 05:59:05PM -0500, David Lechner wrote:
>> On 3/30/26 2:58 PM, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Add icm42607 accelerometer sensor for icm42607.
>>>
>>

...

>>
>> Usually we make these 2-D arrays for readability and then cast to int * if needed.
>>
>>> +static const int inv_icm42607_accel_scale[] = {
>>> +	/* +/- 16G => 0.004788403 m/s-2 */
>>> +	[2 * INV_ICM42607_ACCEL_FS_16G] = 0,
>>> +	[2 * INV_ICM42607_ACCEL_FS_16G + 1] = 4788403,
>>> +	/* +/- 8G => 0.002394202 m/s-2 */
>>> +	[2 * INV_ICM42607_ACCEL_FS_8G] = 0,
>>> +	[2 * INV_ICM42607_ACCEL_FS_8G + 1] = 2394202,
>>> +	/* +/- 4G => 0.001197101 m/s-2 */
>>> +	[2 * INV_ICM42607_ACCEL_FS_4G] = 0,
>>> +	[2 * INV_ICM42607_ACCEL_FS_4G + 1] = 1197101,
>>> +	/* +/- 2G => 0.000598550 m/s-2 */
>>> +	[2 * INV_ICM42607_ACCEL_FS_2G] = 0,
>>> +	[2 * INV_ICM42607_ACCEL_FS_2G + 1] = 598550,
>>> +};
>>> +
> 
> I've gone through and implemented all of the changes everyone suggested, though
> this is one of the few on which I had a question. Obviously this driver was
> cobbled together from 2 different sources and checked to the best of my ability
> and tested/validated against the data sheet, but there are a few bits I'm not
> fully clear on such as this.
> 
> What's the correct way to represent this data? Since it looks like one of the
> values is always 0, should I just assume it's always 0 and only represent the
> values that change in this scale?
> 

Picking a random driver, bma220 has the most usual way of doing it.

static const int bma220_scale_table[][2] = {
	{ 0, 623000 }, { 1, 248000 }, { 2, 491000 }, { 4, 983000 },
};

I do like using the enum to make it self documenting though (no
comments needed), so for this driver...

static const int inv_icm42607_accel_scale_nano[][2] = {
	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
	...
};


Then the read_avail callback in bma220 does:

	case IIO_CHAN_INFO_SCALE:
		*vals = (int *)bma220_scale_table;
		*type = IIO_VAL_INT_PLUS_MICRO;
		*length = ARRAY_SIZE(bma220_scale_table) * 2;
		return IIO_AVAIL_LIST;

Although the cast would be better as `(const int *)` and I assume
you would want to use NANO instead of MICRO.



>>
>>> +int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
>>> +				struct inv_icm42607_sensor_conf *conf,
>>> +				unsigned int *sleep_ms)
>>> +{
>>> +	struct inv_icm42607_sensor_conf *oldconf = &st->conf.accel;
>>> +	unsigned int val;
>>> +	int ret;
>>> +
>>> +	if (conf->mode < 0)
>>> +		conf->mode = oldconf->mode;
>>> +	if (conf->fs < 0)
>>> +		conf->fs = oldconf->fs;
>>> +	if (conf->odr < 0)
>>> +		conf->odr = oldconf->odr;
>>> +	if (conf->filter < 0)
>>> +		conf->filter = oldconf->filter;
>>> +
>>> +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
>>
>> We could use the regmap cache feature to avoid having to manual keep
>> track of old values. Or just always write the same values anyway. I
>> find that is nice when debugging hardware with a logic analyzer. Unless
>> there is some measureable performance improvlment here?
> 
> This is another one I had a question on. I'm not entirely clear from the
> datasheet which reg values are volatile and which ones are safe to cache.
> Performance wise the 42607 series appears to be the *least* performant
> in their lineup, so I don't imagine we care much either way. Should I just
> not worry about the old values and always write? Do you think that would
> work?
> 
My personal preference is to always do extra SPI writes for anything
that is not performance critical. This makes debugging with a logic
analyzer much easier.

In cases where using caching makes sense, generally, "status" registers
are volatile because the chip can change the value when status changes.
"config" registers are not volatile because they don't change unless
written to.



