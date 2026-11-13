Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559024;
	b=AHy1vSG4a2yyvKF5yv2x7jCs0KCcnnolF/5XcCiLXbvRMmoD/3Ls4+xlvHN1gm7UoGdo
	 9fhEtAK/LYz14K713RKoPXMV1L/vJb11p2BMCOFnAbkfFKK/Mwo+8qMNcitlIsMW229bp
	 0HE1umJwhubQ9pbQA1Owe4i1Ajcss6wgdYJpBA1OOo5N5iSRv6kGA3HZyq7VGayu4DkSC
	 TItecyvRm5wsI/HSNVXHMGleTzbIr6WSPBmg/B3Qvjt6C119wgGptE9rXQtE/I4Hk/Cnm
	 TFROnaZnz/VoyJwbs9w24X61GpDnx4W6SrpWMQgIfk24Fk1xbxkcyfMkG/TWnNBXqQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TOlR5TLM959EjV+Tl1kFJWd+Kt4GG1AJI6ZYw3eVYKM=;
	b=bUeaxFpfjkeQuhUdHK0lOCgYl2lWeul4O9FC3oZlQ1q248h3tWHDAwKqlQWj84jPrPyN
	 5ghh7rlDu9ooXnm50WDXq38CffmciFWrVNOmcQVIPfo1yjz8q4DtBMdLq4Rj/WeahwHHq
	 DOKQV+w5zhZ4Y6XPXk0MlUQgJmHTyR6+/Z2CUxUNIm0/28FtJFJzA25YzpmJfiy5KboU/
	 6jMGt37Y9khk7O9ZnmpDww2I7x1XWnHrVCD3OUd0FzUNYS1FJ/uLMtgEoNY0QyiaW9qp1
	 5a6VAX2UgD57ECTXzx86THAht4wJc6B0BNLrEjoocEfkqnQaKHKwDe0CLUHGsJP4fXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vn9MROCv;
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52E606A31C
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C52E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vn9MROCv
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c08539c827so688043e87.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559022; x=1795163822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOlR5TLM959EjV+Tl1kFJWd+Kt4GG1AJI6ZYw3eVYKM=;
        b=vn9MROCvuEiH+7iw29UiR47jK9n08u9V9/N6OsGS8apFoILOW8SavY5S0ROJCq56s+
         Y1fxtDVPR954ZwhMYkjHeqxYl6g15XGdHYRvidhx5zOYfHWfChfJ0p/7YBCwiKyCgVjN
         WdE6tgme7pnMEfr39/LMCoxg7z++liRKwiW8jWO67wo8YwLbme0gdXzyClI9++hOGUjd
         GVCTnEqerhjIHgbGvZzsMVKDtYacVJ3nuQE0voYdgDhPHjJeLgO3Oajey7BVh7Kzr5TX
         UwOOS86URPDNVPwYv9qS61iBzA/dFOxZiC4JeHr1nCoPbHmODKVq1tP/yAhsQZ9V78YR
         +kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559022; x=1795163822;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOlR5TLM959EjV+Tl1kFJWd+Kt4GG1AJI6ZYw3eVYKM=;
        b=RgXQWAddMAPJ8a0oKwVu/XghEyuNMevznv9szb2RxIgrNgRYhnnmE25JR/xeqIiL9U
         zSWnW2/VMnBdYdkQ76NY8PRM5nSedaQQKjFgBsL51M6ndCodWBwqauZRUUiFz2NQCU2M
         cp67M2U60s2FNvUSM3KAocxHM6nIQ//2iSqLMiOqK+0Cp/bs/IBEHr2QMi/ZP+ogbLdd
         pPreIk3GmAcDN+PdVmMVIV/3Fe/xZMLVvtyiVC5w3BMXV0ZVB3nCfWY9++c/Ya6Lmyti
         Mx1U/UUJLle9WQPIfBoWh+ZDGF3Iegyw0J98EfO3w2cudA0VGqJQAex2prI3wx5lCDuj
         qhAQ==
X-Gm-Message-State: APuU4Z/C0lUHnNkzJUrMh8M+LppnpV7J1hAe8p4/5rn2zySN02BUNKDf
	m7p82iAzXlxfh5e4Ruaq4mKIWS/Gj7cpVAJWONjCkd9j9SYCDRitm70O4WGxNu7y
X-Gm-Gg: AYBFou0ZXhLeE7G6SFSAowbRQ5/6Fab5XK8Z2C8XIdEY0nIowPpDO3zO63S0CEJWXvK
	K0IW6vz+o94Glz1/mwDphnbL16tJ6rt3Uxnak1QrfCnhfUpOu+2EzrTtoTYaeOSRodlM2xywj8c
	6cQrl4WiInYGVCmu3CC8IccdqjYcgW8pl1NR24aLvOxFTOzeHMZ4/RVihqsGpduV+2cR9brutvt
	mpoaUuAJiM0Rk2LECinq9Wsf2snyLIPeHVZsv1vvR4Xos6hdUcPSP/MLGdqbOi8eWkO56s6pz5N
	/9x7Ni7nvnyyXcwNTJszYjDWPrSFcOOZ9sEl26iR0vXybwdfpR0J8JV8nQ/hqc9Jx9I/cka1NsI
	luXTjgMozpyCIWlM5zlAq6+C7osWPjfrpJuXa+TRe3ioy1L2pacQzVEJSJd8ORMU9EeTQg7i7lW
	vlyjjowLtIJKct/E51wWcGY7cNPz42EbV+C6a2nKaydQzHeStr9XutBZUu+dNPkXN6LxxJuHied
	GqYBpOyBF398+WVjIKkJobn/btN1FUfUw4JAUArDFOv5/dMtCegAtuwyU0zyvR2RuBWW4DqZbfR
	rA3bZLcGXK4Ok/xO+JHOQU7hwr10ZFTgn4DEXBNNYIj00aPrD/OuPlczmSYorIo4TwJ9nzIy12+
	u5hsDlNCW1Q==
X-Received: by 2002:a05:6512:250d:b0:5c1:4e6b:6491 with SMTP id 2adb3069b0e04-5c17099fe45mr922206e87.59.1794559022260;
        Fri, 13 Nov 2026 00:37:02 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133e1bdsm526954e87.43.2026.11.13.00.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 00:37:01 -0800 (PST)
Message-ID: <d12ee272-8dc3-46f2-997a-5de019ed6baa@gmail.com>
Date: Fri, 13 Nov 2026 10:37:00 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: gts-helper: fix duplicate NOTE section in struct
 iio_itime_sel_mul
To: =?UTF-8?Q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
 <20261112-iio-kernel-doc-v1-2-e382fc9a47c2@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261112-iio-kernel-doc-v1-2-e382fc9a47c2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2026 07:25, Oscar Alejandro Sánchez Lucero wrote:
> Replace the repeated 'NOTE:' prefixes in struct iio_itime_sel_mul
> kernel-doc comments with plain sentences to avoid the duplicate section
> name warning.
> 
> Verified with ./scripts/kernel-doc, checkpatch.pl --strict, and a W=1
> build of drivers/iio/industrialio-gts-helper.o.
> 
> Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
> ---
>   include/linux/iio/iio-gts-helper.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> index 0c4b2e9fbe1e..3f07a46ddff2 100644
> --- a/include/linux/iio/iio-gts-helper.h
> +++ b/include/linux/iio/iio-gts-helper.h
> @@ -47,9 +47,9 @@ struct iio_gain_sel_pair {
>    * @time_us:	Integration time in microseconds. Time values must be positive,
>    *		negative values are reserved for error handling.
>    * @sel:	Selector (usually register value) used to indicate this time
> - *		NOTE: Only selectors >= 0 supported.
> + *		Note that only selectors >= 0 are supported.
>    * @mul:	Multiplication to the values caused by this time.
> - *		NOTE: Only multipliers > 0 supported.
> + *		Note that only multipliers > 0 are supported.
>    */
>   struct iio_itime_sel_mul {
>   	int time_us;
> 

I am unsure the "Note that..." serves any real value. Might as well be 
short and concise:
"NOTE: Only multipliers > 0 supported." => "Only multipliers > 0 supported."

Well, "Note that only multipliers > 0 are supported." isn't much longer 
so it works well enough for me unless you respin this for some other reason.

Thanks for the fix!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
