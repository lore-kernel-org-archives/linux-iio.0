Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4281359A6B
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971633; cv=none; b=PpHrUrjiTp0WgfVMlSZAmYJL5KsHamDwBChicRDiMtXmUs2Mj5YbWinu2IyAM1QUGWXJH7GogIghV6sZoCqUsPEtFHlqqJdLT0HasYjf8MLIKRdCgdM2/hcrTa04TDuFnhDnO6WLzPYWglEe2+g1YQhAT5z/oXjTaKTyhssCWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971633; c=relaxed/simple;
	bh=OzNlGnYi9Q21pWLQDCHdgjEM5JLFkymdE6BoRXE4Svo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rx0J+MV/q0/muU5+ROUgrrAS5Yctq+m15hULef9es1KUBnFfwulmfKj3lqzAaFn4Hp65XjYoV3ed/UDOXfX+9bChusnFY4kUHK1Wi9PyfNcALM8rSfnqYGRxu1N2KVVjV99ZQ9A3m7DCIj8wBPNBbo7IH22bI8eQDcjN1AAlLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZUEuJUZW; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZUEuJUZW"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb61bbeb25so164935a34.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783971630; x=1784576430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YzkRgDINkoy1AhrvZYmCykpgao/Mcghq5LHWpOQp6yw=;
        b=ZUEuJUZWQUzblZNkOdz64PLXhQGw5g5RLbOzvnruxFNMSbc/cf14VeLfixWEhD2JkD
         EZD6C9SPLzlDt/F7se6xqWwwLIQUBhChmx4lIx4p1K84HcWOSk398L/GhWqMGDxR54KX
         qfX8qtsirEdeQtiJ3iq6nVByOZ9tpab2wAdCJmhj0AJgUQfbpSMmlxCXFR89o7L7Acrw
         PIoshaq1VVHo22HyY15O++xRJDqGqLp0v82LZn8DB2AuiVYSzLj88GBo7rCAFkmgqlF8
         GM2L8c7hyY358BmsDknq1eybNsLtDntdFEcshfczpEnEPP+Kf4yvX/AD2JxA+KLFGAY/
         WApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971630; x=1784576430;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzkRgDINkoy1AhrvZYmCykpgao/Mcghq5LHWpOQp6yw=;
        b=KVEyWpGy50kI8Fy3cBzrsiGaKEEdd38PFYBDIPo2Xw3Fa1s4paOjscPMc0dY3DlsmI
         MNTYGkskyDCTBBS0Go0HzH/yoD/gm+H42VYC1xsKWq/QTUN58At4VBaEX871RvdtFSCl
         qZ5Jb5A6nN6aEDJ0+FIS/teLvJyWpONz8G4xUR+GbTKtjmm3lo4X8KodTPXAjQBldhTI
         PkSXK87gxICgCKMwU3Y6r5qGqGR1WEy4iMe3qwksNPO8xQZBR8QVDVBWVU5Ne96KUn6Y
         c/4e3RX/foprwn8v11ib48X+AHvjeZJCZJCjmxj1zJIybXdsUmnrpkmlBeRkC2Q+2z7G
         dzZg==
X-Forwarded-Encrypted: i=1; AFNElJ8l6qq+6mx4NlAexvE1TXNzDF9phbPMk7yJGTZcvo+JAyi24mTmBCj4RFET43L3hjXiMsQ4kwxdteY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Z+2511hFE9+7VQ017Pk+p7bWig/n2pW+KuzJkLlFQVlv45WA
	TfiaNrr4fNpCAvtL0WHUmdCpZboFCTXPw2xp8ZIiO31Pdu2yea67Wx9F2SZ4XjueyZU=
X-Gm-Gg: AfdE7ckGvGxLIhR6GZy38ILMWEdCpplJpQp9Vx7AvWkv/0xt/ZQawItLgZ3I6idJeS7
	bSbK3yQ+H0iqgKHa8NaSeAuRMlkLQMfNwOWOydScqHJOVZcPTjIO5R9WjJSj/Gh3l/9UvSqFftX
	YDqjCP9KUddIhiRfEzcLTHPp4I0IEXxSQit3WjG3bkPRWoEz+Wi/t8r8Rq3T/5RUKk3l+lumn/j
	9Z2SFOmVuCEJwtmjY2pBO+ZMcQl4webyk11qounMFNUYTHKYsegmTd8noaWwhASU3Z4Hdyyjfim
	mKb/SEfvHM24V8d+RbgIZfjH+8OscO5u8Akz2C7YpLE9jBJyKzYTIx948aOwyGctEMu6K3fVeA/
	tdZbWbXRPcs87yB/eVOSRSP3mrtBJUiZ1zgdj9Ibw0KumprP0xk0i8IAuVaeUyJJOTVr5998dSp
	fkPkeQ7TnxmZzQTaqDut2erpyY27Ncen88CASKOKF9F1RghMEJ5R02Rd//xpAYuK8=
X-Received: by 2002:a05:6830:67e3:b0:7e9:f1f2:720c with SMTP id 46e09a7af769-7ec098b0a19mr6684100a34.32.1783971629759;
        Mon, 13 Jul 2026 12:40:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:610b:e45c:5e0c:e14b? ([2600:8803:e7e4:500:610b:e45c:5e0c:e14b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf73c87sm14018192a34.7.2026.07.13.12.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 12:40:28 -0700 (PDT)
Message-ID: <f8bb35a6-a898-497a-96eb-7a76a1fba16c@baylibre.com>
Date: Mon, 13 Jul 2026 14:40:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-8-746d52cbf1d0@baylibre.com>
 <alI-a6nkGvXp6sDo@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <alI-a6nkGvXp6sDo@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 8:00 AM, Andy Shevchenko wrote:
> On Fri, Jul 10, 2026 at 05:50:41PM -0500, David Lechner (TI) wrote:
>> Add support for parsing devicetree properties for measurement channels
>> and doing direct reads on these.
>>
>> There are quite a lot of conditions that have to be met for each
>> measurement to be made, so quite a bit of state and algorithms are
>> required to handle it.
>>
>> Channels are created dynamically since the number of possibilities is
>> unreasonably large.
> 
> ...
> 
>> +struct ads112c14_measurement {
>> +	const char *label;
>> +	u32 vref_source;
>> +	u8 iunit;
>> +	u8 idac1_mag;
>> +	u8 idac2_mag;
>> +	u8 idac1_mux;
>> +	u8 idac2_mux;
> 
> I would group this slightly differently:
> 
> 	u8 idac1_mag;
> 	u8 idac2_mag;
> 	u8 idac1_mux;
> 	u8 idac2_mux;
> 	u8 iunit;
> 
> I haven't seen the code, but names suggest that most likely one would read
> *[12] together or close enough, and less probably mixed with 'iunit' reads.
> Current layout might lead to interesting code generation complications on
> the unaligned-intolerable architectures.

iunit is scaling factor for *_mag, so logically gets grouped with
those. (These are all datasheet register field names.)

> 
>> +	u8 iadc_count;
>> +	u8 gain_val;
>> +	u8 burnout;
>> +	bool global_chop;
>> +	bool bipolar;
> 
>> +	s64 scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)];
> 
> Also this can be moved upper, but I think it won't save any bytes in this
> layout.
> 
>> +};
> 
> ...
> 
>>  struct ads112c14_data {
>>  	const struct ads112c14_chip_info *chip_info;
>>  	struct regmap *regmap;
>> +	u32 avdd_uV;
>> +	u32 ext_ref_uV;
> 
>> +	bool refp_is_avdd;
>> +	bool refn_is_gnd;
> 
> Here is a definite gain in memory if booleans combined with u8 below
> 
>> +	u32 ext_ref_ohms;
>> +	struct ads112c14_measurement *measurements;
>> +	u32 num_measurements;
> 
> Something like
> 
> 	struct ads112c14_measurement *measurements;
> 	u32 num_measurements;
> 	u32 avdd_uV;
> 	u32 ext_ref_uV;
> 	u32 ext_ref_ohms;
> 	bool refp_is_avdd;
> 	bool refn_is_gnd;
> 
> ? (Don't forget to run `pahole`.)

We've had the discussion before [1]. I don't think it is worth the effort for
structs that only get used once and doesn't have performance implications.

[1]: https://lore.kernel.org/linux-iio/20240318124041.0000032d@Huawei.com/

> 
>>  	u8 sys_mon_chan_short_gain_val;
>>  	s64 sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)];
>>  };
> 
