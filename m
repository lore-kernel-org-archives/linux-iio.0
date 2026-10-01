Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CC4825DB
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838773; cv=none; b=ov3VSA9F484XIz0ZM+0tPI5qoHEUWRE0RBpAutDc1ZvI4Fhrz0oLBco+LtQq73nWCUyiOTH9y2debLGjbqiCOr+V/BNfUejUHWMk8JfLV5fahfoQL1XFj9xrH4lkrRwVgCIF3uGc8B2FiEWaypB7RYeeTAS+du0nvJj/U0OZFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838773; c=relaxed/simple;
	bh=pYWtNKCEIADez2nraxJLiPh9vUf2EF3j8+4MBsskwq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SipMO9figvQqSwK3Tmr+8xggiEWyxoxNohgAjhc6D5e3L7K7MdByTarZayhMcuSO2yAc7xMm9jnZAmoDWw1E9Peh/yzUS9MUwvCq+IrvNYjwe7wiBEAEFvA1VqUhvUkS5z2GEkc2Qi2M9mTucgA3NoMnl5hy+DrHb3YU9xmouqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvvAq98H; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvvAq98H"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so46319915e9.2
        for <linux-iio@vger.kernel.org>; Thu, 01 Oct 2026 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790838766; x=1791443566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZp7N3gR+8r2ILusI/guKJp40S5QXhy02pTeE4zBRNk=;
        b=nvvAq98HcLZsbqovBW4daMhJdmQa3RzDT0whKjQiddAA4z1VnxjQMqcWI92CrY7TRo
         VRVeQ6+BG036B3s0+wB9wSewSUGAyBMTyvxPIBFiuNiAGy1ZNrbND1GLPkou2j2BjooR
         pchEo7khLRu8jBheDM/TYzqUpoTFaCCAoIwUerCaU4whECPPWrLIMaiO1rNkGmUdq2m5
         W+oS1DUU9G9uP2wtS3HCwrh4qGmAH3VN3hu2NvWwFPCIRTYrV3ZxYUVY/rRQA9R8ExUj
         0flh6CE6WKqIf610PiFcqXECZ8WjpkMI5PSRVWAMNbxwEnYX6SUGBQmNojB102wFpZkK
         6i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790838766; x=1791443566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZp7N3gR+8r2ILusI/guKJp40S5QXhy02pTeE4zBRNk=;
        b=QP52KDmqiXTUDCehMQBOiBeeui6uI3KAABWAaP+rbMvzIl1d47TGMNDx7wdpzpobUm
         YF/+bAMwJq05NshwL/G1nnP0CebpWryjC9VWTTv8tWiuVTk0cyW1cGGPLW05yAh5gfda
         Z61N6HMGkTLksJKdSt0x+fpBZQXp+mppXi9Rdc3yFytQfIxHZ4b1sU5Xb5aYEkCOCTh5
         CmHqE6ljx+9112CwJFjxI5gwIEtsF+GeThOU9UUuwNrhV3lyNLn8DS5Q2vGdfMM9aAe5
         dowXSygrZoVcMd412zjiMoOCL7ugf3ut9yKDoI/VZPOYJPy//q5FWS1XYS6YE4Xnr95Y
         +BKQ==
X-Forwarded-Encrypted: i=1; AKwUvByqBxR6VNW/OZot0/ICJDaPwbJPet/OGX2GNkib+pyn77VdiH1Qv8Ld2a3cFhEPDuNN0t2QL03u13Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n6VIJXtjjrMnnRc1MtsYFIn8YgK0oEXzNRko+2RpcNFseeFKax
	Vf00YAhMiEFhxzAr7UdmTaqIK2CsVu/fXdpAzsnW+8pvP7fn/MR0mxA8
X-Gm-Gg: AYBFou1vChaRfQxdDe7jTFI3+/yW8AVXzxw5Omvab8xP3L5GtjvxUp9hOaVkd8VWAyp
	vZZBCsYpzcDRsnXLHmnKj3nffQHoTYR6fVAsPgB6Ph9biJVcra6QcUGyxnRs2dbOJHMtUqdkf0M
	ps4rn305AsRa7AwOG9si2mhrbnoZVt20QU3WDTztj83JO51jhu7yu/I3gvhBMtPb7cZ35nwVzWP
	s1iJuOZ2uAaq1S6u2C6oPz8+yutvt3P4PWrUOy5B0SY21XHw5a6Jv7UnJu/1CXTG8x3BISSwCri
	MDue6CcfvuGqL+p26vdAAVza0gHor5v9MqMBEyth4yDawhgfItPPRnwJSFY9o01cACSvmF5RS0u
	KVGisVT9IOAavSufn3GCEECTwEsSdd7Kt7aqIrEfy2n4SvgLOYksdh5v5DhYH2nBCYXH0j7+s+2
	0iTTCjPXXYs8ne4MGZZey1uziWKgpetwXsU9b1odNkhZSvtHpNJd8WRHwkhFUlsB0iWTBnVToQ/
	6gOkX4TLaZEBOnEJ1Az61e5ARCRoc12vlU+3op8aO6iAC2CBsyr0AntNNEFtoU3gGKuuWq+BDQp
	TBVSU5ahJS+cyM0CId5ulpPx+7Qm/UHDBzKcZIN6a3nwtWCGnxanRDd1E99vP5BGr+jsBXsBjHF
	UU9uV8dp1K1m31S1i09oKFC5zb0w1UnfNZC43m2h8CPNk9Pe0oYUbDMhaxrRGeowpGeHMfGeGrs
	5j9d7C
X-Received: by 2002:a05:600c:4f8e:b0:49e:745d:c317 with SMTP id 5b1f17b1804b1-4a01b0087a5mr56943735e9.12.1790838765815;
        Thu, 01 Oct 2026 00:12:45 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f97a0aesm43532655e9.3.2026.10.01.00.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:12:45 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:12:46 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
 nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] iio: adc: ti-ads1015: modernize resource
 management and bitfield logic
Message-ID: <20261001091246.000068a8@gmail.com>
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 22:41:54 +0530
Archit Anant <architanant5@gmail.com> wrote:

> This series modernizes the ti-ads1015 driver by updating its runtime PM
> handling, error handling, resource management, and register bitfield
> operations.
> 
> This series builds on top of Stepan Ionichev's devm error path fix [1] and:
> - Replaces SET_RUNTIME_PM_OPS() with DEFINE_RUNTIME_DEV_PM_OPS().
> - Sorts the driver headers alphabetically.
> - Returns -ENODATA when match data is missing.
> - Uses a local device pointer in probe.
> - Converts suitable error paths to dev_err_probe().
> - Drops unneeded '< 0' error checks for functions returning 0 or error.
> - Converts mutex initialization to devm_mutex_init().
> - Transitions runtime PM setup to devm_pm_runtime_set_active_enabled().
> - Inlines the redundant ads1015_set_conv_mode() helper.
> - Replaces custom shift macros with FIELD_PREP()/FIELD_GET().
> 
> [1] https://lore.kernel.org/all/20260529183708.17819-1-sozdayvek@gmail.com/
> 
> ---
> v5:
> - Reordered patches: inlined ads1015_set_conv_mode() before applying
>   FIELD_PREP() to completely eliminate code churn.
> - Extracted FIELD_PREP() evaluations into local variables for
>   regmap_update_bits() calls to ensure clean line lengths and readability.
> - Added a patch to return -ENODATA when i2c_get_match_data() fails, as
>   requested by Andy Shevchenko.
> - Split devm_mutex_init() into its own patch to decouple it from the
>   runtime PM modernization, as requested by Andy Shevchenko.
> 
> v4: https://lore.kernel.org/linux-iio/20260827172100.39176-1-architanant5@gmail.com/
> 
> Archit Anant (10):
>   iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
>   iio: adc: ti-ads1015: sort headers alphabetically
>   iio: adc: ti-ads1015: return -ENODATA when match data is missing
>   iio: adc: ti-ads1015: use local device pointer in probe
>   iio: adc: ti-ads1015: use dev_err_probe() for error handling
>   iio: adc: ti-ads1015: drop unneeded < 0 error checks
>   iio: adc: ti-ads1015: use devm_mutex_init()
>   iio: adc: ti-ads1015: use managed runtime PM setup
>   iio: adc: ti-ads1015: inline ads1015_set_conv_mode()
>   iio: adc: ti-ads1015: replace custom shift macros with FIELD_PREP/GET
> 
>  drivers/iio/adc/ti-ads1015.c | 160 +++++++++++++++++------------------
>  1 file changed, 76 insertions(+), 84 deletions(-)
> 

I have two *very* tiny nits that can be tweaked when applying. Otherwise
LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
