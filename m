Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7B36683F
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726098; cv=none; b=KTXGrLSF2mavI0z1iYfxqqEjcJ1GWRmm4vcX9dW8Tg1N+TeeAL4LJ7wJIMEOCOEv+PhuqLJiMxxZ198EIUfNdv1mHI6qw2l3Kt8K/DucgdUnPn1gbhQ8MSFCvHRR/YIvYN8PlTdePkWXCfuJJJoNsRmPL0JcfDhA06c9Yn+qlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726098; c=relaxed/simple;
	bh=gWCJtzpqFegg3bTcR9rV0Dg3ENEPxM/6Nx3+JN7CUT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kU+TgRQjPUcQwS1kc9d7z2gdMh3cGc8oOfR27HrIEouK4npg4BuSgjYpCTTjMmWfewjZExbhX9S3Z9m+UdBi1cGAD4cpk8cFirZlUnMqa0aUAO3uhr/j54Pod9jWfjinSnpEtcGSUo4h6LVk1DgAwVyxW8ZPCh5EkzV3lID0k8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=cTHlq80L; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="cTHlq80L"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso870750b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 14:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1769726096; x=1770330896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plfwOfjqsYTVMiccvZXjk93JBsBJRHS4e3Q7B76O8gQ=;
        b=cTHlq80LDa14GhaMKbeZk0EuO8WzjgYKtkmG0iXkfwC8GCOurrZuq4/Vj8FHUhiHVI
         mRwz2HVCa0K9wto1XKeWsomzf60LYeE1AYakHAPoaToK15VyZy1nRSlUZiTQiS5/fcdF
         47B9YpXae6CyAEMT/GSax20QlMrrAMUg6dI/8U9yV7ONrIg6j8nr7NR+KfcAXUPwr2uQ
         5yGv6HOZ2KRoQT+NAi9TDVfWQIAlA6l4uHftGAOAS5cHq4Fe3C2FrTMkrPbTnZDmGt69
         1Xb2tvVz9AHnnulWBnBup7BFZ05pbZ+M+1N5xt+chH9/m0RXRAO69vd0YnDi2Qtr8ylH
         dE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726096; x=1770330896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plfwOfjqsYTVMiccvZXjk93JBsBJRHS4e3Q7B76O8gQ=;
        b=RNkeRF7WzeTd8yBajxd+7YAe5QR/xFYYC+LKYOxJW/Mrt48EHOUYfhkpjTz08gdTBv
         rq2W30Yd3Omo28b25wV4GBlH8bokr7ZcJ7E7/P2wFSxgkpfXlXfEmC7LXWMbU5q9QZic
         1TQuzrpNTiVfiZRKWIOgiRGrZ5zwieMg2RKDDTr4ZPmwjFSEi/n6mBBhrRe35RU8bMbe
         367G0waJWeqHJM4UmYo+DIRiiQsX03CUcM9nIpdfy7kPjx0ruSDCMobsTBveC6L86k7T
         Y9JRnjmJMNrq3/A+WmBCgb6qmiCQFaqH2+uq8aqQF7fEAnLDk2T5e+mcrLV4l0z5JWXG
         iEew==
X-Forwarded-Encrypted: i=1; AJvYcCU+vq/tfxz1pXcSe9YoZy89pDEGGEIWuwPLt5PL1sLI0F9Jh54Fgm0Cj1AryLy9DUdwJj/F/JBvwDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVO7aBJA+61XrkO6lDZOqbYW5eVdGqILr7hl0q7oWT34FMTyb
	W6PIL2htoXlulavrDPI0wTUaXLIrDKXHAFBa+OPnmFINJg408WdB2qP4GrRiI7tEbnE=
X-Gm-Gg: AZuq6aIxKOBlKLEMieJqKmKdKRRI9B8f1EgExHswMKJ8zeN6nxNdUORu6TUCpixzzee
	P8KIGanYTryUGSOXEnKHL7WGsyqGvYE2rQEv5EWszDAx6rUTY/I/eRCAcyzO6zmEkdyK5Xi9ofr
	xwxgXH+9hCY5gV5m0bKVr0o1Fan2r2gVR4I28TGRONgqSbj6FFJYdjbUFCaeQXCb2RBirCkYZzn
	VYXGZXW1Xcu73qtOsT9X4wZ8qdBHdmtjwyc0/joGSHSac+4fq8cL5EweqswVjnLjs9zgdCtyGDj
	KGwq+SRJvvZRIAGAPMb3pbGOIB8gk6rGmQ3+pTFMlWmaTS98AtZv/p8JTzfvJ/NSYw1Y4m2bEsR
	GQKsoAGAIRrWw4/g/xk/R/Qxp4lv83ZI+em27NkXp+fr1l8yYT36Dkv779nHOoYsk/S6sQkL0hl
	GmmAWiAeIg+/z3mQjL501TLUFnepDLpzBp6GgsGHIxaNbJ1UH2IsgKhoGgXMlznwwAHsFpbGFPp
	MQiKRPjKqR/C3OY
X-Received: by 2002:a05:6a00:218e:b0:821:80d7:2efa with SMTP id d2e1a72fcca58-823ab75fbc1mr660970b3a.51.1769726095951;
        Thu, 29 Jan 2026 14:34:55 -0800 (PST)
Received: from [192.168.50.161] (61-245-156-102.3df59c.adl.nbn.aussiebb.net. [61.245.156.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54febsm7448830b3a.59.2026.01.29.14.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 14:34:55 -0800 (PST)
Message-ID: <be6e6492-b3f9-4a0b-87b6-3816eff6d395@tweaklogic.com>
Date: Fri, 30 Jan 2026 09:06:00 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: remove unused nlux_per_count
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jagath Jog J <jagathjog1996@gmail.com>,
 Eugene Zaikonnikov <ez@norphonic.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260129174253.39574-1-antoniu.miclaus@analog.com>
 <20260129174253.39574-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20260129174253.39574-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/1/26 04:12, Antoniu Miclaus wrote:
> Remove unused nlux_per_count field from apds9306_data
> struct. The field is declared but never accessed in the
> driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>   drivers/iio/light/apds9306.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 7e68cca0edfa..ef6429bde193 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -168,7 +168,6 @@ struct apds9306_regfields {
>    *         respectively.
>    * @regmap: Regmap structure pointer
>    * @rf: Regmap register fields structure
> - * @nlux_per_count: Nano lux per ADC count for a particular model
>    * @read_data_available: Flag set by IRQ handler for ADC data available
>    */
>   struct apds9306_data {
> @@ -180,7 +179,6 @@ struct apds9306_data {
>   	struct regmap *regmap;
>   	struct apds9306_regfields rf;
>   
> -	int nlux_per_count;
>   	int read_data_available;
>   };
>   
Good find.

Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh
