Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AC332EC8;
	Thu, 25 Jun 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417018; cv=none; b=kxK5KByVoh2cBBkPSM+Z1V/tHpV4q6TvQ27JmEC6mHYoaoxTBh17bewqyEj4vSfZdNEnCvZ0YWYESF5GMYggImSiwfBJEvb06FHd9/J9LJ4+JutQMQ/u9ujsA/sjtlygfs9Ke40Uqeodj32bBQMDe7xIN9CU+bo71NVfFSs5RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417018; c=relaxed/simple;
	bh=nxQyIGtT2c9gYrAYS7gyZajjwGwFuK92BMB8QlM4c2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPknV3iSMr9Id0fkaWz+9fp9k6lZFqQALs31TCvzcqdYhM9gSUJEqugvj5kRlSC8L9rbEg0mjzH7DNXHUNCf0BFShcnja0ihEAmqei1xQ+UDBiWc5ho7WcgIZv0NIC2ETPwXiwTyOjds+DW+pjU2R7qJFsa3P/kzf1VU/QWea0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=hAID3mdw; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="hAID3mdw"
Received: from [10.0.0.200] (unknown [10.88.125.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id E07545340CBA;
	Thu, 25 Jun 2026 21:50:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1782417014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LFMl4W8oSUtZwX4KTCGMtmd8C3tSfZnKyUezZq/vzis=;
	b=hAID3mdwl3/9AHEiOp6WV4mFLsib7C7JX93yXSqQUxc2iamuHhHxuaM8QdRYmXhrS+UJNI
	P0IgSjerjZzI8WCaNhLIQ9HpBNzT6/JjbsrGQ0YIc0FcrhAqFVfNTfdeeDEWxTIr69UaYG
	9YtvPDyt8udesNg4RWfTa4jDcwzsm2s=
Message-ID: <b1facbbc-a0f4-4ef5-915a-89c52bc31738@ixit.cz>
Date: Thu, 25 Jun 2026 21:50:13 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/06/2026 21:38, Joshua Crofts wrote:
> This series adds REGMAP_I2C support to three AL3xxx ambient light
> sensors that were previously missing this dependency, causing build
> failures.
> 
> To reproduce the build failure, run `make allnoconfig` and `make menuconfig`
> in which you select IIO, I2C and any AL3xxx sensor and `make .` will
> fail with errors such as:
> 
> drivers/iio/light/al3010.c: In function ‘al3010_probe’:
> drivers/iio/light/al3010.c:185:24: error: implicit declaration of function ‘devm_regmap_init_i2c’ [-Wimplicit-function-declaration]
>    185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
>        |                        ^~~~~~~~~~~~~~~~~~~~
> drivers/iio/light/al3010.c:185:22: error: assignment to ‘struct regmap *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>    185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
>        |                      ^
> drivers/iio/light/al3010.c: At top level:
> drivers/iio/light/al3010.c:48:35: error: storage size of ‘al3010_regmap_config’ isn’t known
>     48 | static const struct regmap_config al3010_regmap_config = {
>        |                                   ^~~~~~~~~~~~~~~~~~~~
> 
> I made a separate commit for each driver, to ensure a proper Fixes:
> tag is appended for easy backporting. Let me know if you prefer
> squashing!
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> Changes in v2:
> - Change select keyword in commit message to lowercase
> - Add example steps to reproduce build failure
> - Link to v1: https://lore.kernel.org/r/20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com
> 
> ---
> Joshua Crofts (3):
>        iio: light: al3000a: add missing REGMAP_I2C to Kconfig
>        iio: light: al3010: add missing REGMAP_I2C to Kconfig
>        iio: light: al3320a: add missing REGMAP_I2C to Kconfig
> 
>   drivers/iio/light/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> ---
> base-commit: 7667a80340e99fd45357d0c90ae05813b01bbfef
> change-id: 20260625-fix-al3xxx-kconfig-ddb1f00a2615
> 
> Best regards,

Whole series,

Reviewed-by: David Heidelberg <david@ixit.cz>

Thank you
