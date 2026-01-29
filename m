Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D92D3220
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726618; cv=none; b=DC+I84OPTmhtFGYiOONfoE5EgzKohc0vMbyvcQbZ+W2g0NmLD1eOj25yUvVuNKJwltnj1n5lrB5b/sJ1edjeJz5Kv2/Ssmf+1dLd1yjNsNAbkxMdH6FU3ZlCew8sp06HjuoFbnQ6Kufsz5fkJ64ULR8Sf3MLxDTAkSrlIjmOBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726618; c=relaxed/simple;
	bh=LIB00bUAoerLdXeJWLhrXEYUlzQPtKzBcxUlvilE8Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgxpyR1zN1yIcT0r89GieaCfgJ057Kbg3PRH52p9+9QgX1UGGmicV7drnkCZRdVrWGLsO/EnHqeVq4GcV3o3SZCT78LDimUNIpyjTQx93ofrUZN0vOVjryoTCosStdeiFneee0gDqGfZttVsoPoqKQ089VHGjZCjfkUgs4e6bm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=LO+VB33Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="LO+VB33Q"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a09d981507so10727065ad.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 14:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1769726615; x=1770331415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMV0KqjJJ4efWRwE6u2/R0QBSdZg5nnnOxNCNUeOyNA=;
        b=LO+VB33QJD+/7i0517F8qNgJc2kI3oQtSc2gpNZ5ApeseKkBJsF5nIH6Y1VI4POB1g
         BVK2YVTMhLztW8qx6T3OF2bfw2tvNqgR5OYBPO5O4hA1sN1Wlx9MwE/ACoyfYYOwqh72
         DOHHOfoZ1mqvc42M+qsQyG3YCkTz1p+pPKXy/TU+mb5OtoQUkfaegbxXEwDxZnyB8nEq
         khLbR9Uv7jWsIV/Y7uE994Og9zsVYk71GKyIGoZKJhJogp/zVnXzlWoXjVPh+utthXk2
         kXztETwj36nt4qZILnoXf5t006kcmYF4jWV08AwhBuxS2qDjIPb3c5btdyL097D12eV7
         pPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726615; x=1770331415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMV0KqjJJ4efWRwE6u2/R0QBSdZg5nnnOxNCNUeOyNA=;
        b=SklcrgsvRvNNMrM+oijr5t4T9E/fN9wgEBXdFjRW/9Fh4CquAU0XhGls6VQ1dYzQPx
         ZV3adJyG7KPOm7y+jNGlfkPjds0cNZlRWfcyweqwktO6wQE1b+vnsidrJVfi5PTkhyAx
         7YwoUh2e3QIvawCQ23PGJ9+kIkj3PGnV+MPURdI5K9UyVkuJQOJHqV/YeA4kXjRuHgli
         7pJjpn30Y5nhw+8uNuIbXw+gYgi7sAMc2kjx+2LmYHMCkyRGwnNPRzZYseVllwt3Cdx5
         fc6WcPyQmnzRWG3vYEcOHnwtv9sV1b43XvQY6tF2bH9ELW2VqXMM7E9A9mYg454eFBYp
         XtAA==
X-Forwarded-Encrypted: i=1; AJvYcCXfYi1OWiZAK2QzERXd6o7URQ3/oUy63Glki9yU4oyMFfDFj/mLX7FztFhqxFp1COBh3+5pJVsQOFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uu7cC1QMYKu132GiuWB+nixzv3SlK+EeMJTvmyQqlth5oKBq
	NlMyCMLWlbY9j2oYpd3OVUL2I9D9h7779p74lblBzvJIIqUYoTyXmV4IDLjlSCtGIUU=
X-Gm-Gg: AZuq6aJNKe2XEQphF9x9T0y65aIV2yUdNYeIuhVhu0OrewtHlOzkJMvygFxlWrTNIgf
	i5SRslQwD4W01WPWnN+06+oCONlSwo2IaCrD4o5i3cq6LjJ9fW3DHgXybxJxu5KbChQCBcQreuh
	3XzwnFgXixq/J9sriWmtHV/ANxkYNUip6xhhCQtznM9bGkuZX3YDkvbFAiJPi8FKVUzgMWLDrw1
	mtG4wmgWo2VZfeoQYjjgrX6v3Cq8e+cjGZwwi1Q13y/veftiUGh3avlpaGp0K1wXxwW5ira+o2c
	T3QKx0vRSmWDxShfYidEfdp7X2XIXxWdq9fOQC6/INJGlUVnHB+tNAe2uFgyMDLyv1EvF2aNQTN
	C5+kP+MkwcVIOkHN5d2OtNSfAcfgvxjVdmWAjkSzWOHfsLoCTYkARkQbkoraeDlLK2VK0Q5woE5
	PE346wcbX/wXdRCxlJ0aGXNxYcZrYjgnMEPFg4wyS79OfYUUJ5XIAL0/pQW1tP1hGNHmVO7uRWe
	mjrXw==
X-Received: by 2002:a17:903:2306:b0:2a7:b412:6cc8 with SMTP id d9443c01a7336-2a8bd3ec01dmr38596795ad.1.1769726615432;
        Thu, 29 Jan 2026 14:43:35 -0800 (PST)
Received: from [192.168.50.161] (61-245-156-102.3df59c.adl.nbn.aussiebb.net. [61.245.156.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4163b5sm57250495ad.41.2026.01.29.14.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 14:43:34 -0800 (PST)
Message-ID: <531a0877-53a3-46b0-b365-93e0511bbe2e@tweaklogic.com>
Date: Fri, 30 Jan 2026 09:14:41 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: remove redundant explicit pointer
 cast
To: SAJJA EASWAR SAI <eshwarsajja20@gmail.com>, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, iryuken@duck.com
References: <20260129210431.654266-1-eshwarsajja20@gmail.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20260129210431.654266-1-eshwarsajja20@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/1/26 07:34, SAJJA EASWAR SAI wrote:
> C allows implicit conversion from void * to struct apds9306_data *, so the
> explicit cast on 'ptr' is unnecessary. Removing it improves readability.
> 
> Signed-off-by: SAJJA EASWAR SAI <eshwarsajja20@gmail.com>
> ---
>   drivers/iio/light/apds9306.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 7e68cca0e..5d18eabd9 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -1176,7 +1176,7 @@ static int apds9306_init_iio_gts(struct apds9306_data *data)
>   
>   static void apds9306_powerdown(void *ptr)
>   {
> -	struct apds9306_data *data = (struct apds9306_data *)ptr;
> +	struct apds9306_data *data = ptr;
>   	struct apds9306_regfields *rf = &data->rf;
>   	int ret;
>
Looks good. Thank you.

Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh
