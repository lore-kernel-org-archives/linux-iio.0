Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1C3382F7
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114152; cv=none; b=K8yEpyrrg4vvF6K3jcBmlYPuby9xwnfiI0JPamYin6vDSjEfItSbCpco3z+YfgNxQ7KfYbNPJVkETHzQbDBBHs/NhpPwYwh1PaeLk8C028uoJ47cvIM5u9dR0gP+1UCO9Cz1lDREZSTsyjf95j93OxPwKaiC/b9cDbi9JDIeNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114152; c=relaxed/simple;
	bh=DY7QohFflKL60IpjkXWMakWOoVSWKHd0LKfHDSCLDeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ojB1GI3XL6qEc0kmW5Ubk95D+pWbuYznIjUYcdnKIgBSKKVrrNDEq7DeGC3jfe0DkiwH5U0dhDySNpDe3GlgPcDlPinoI0D8tcNcx3qEROQ/02mrMAvF1rGb4DKctENaOH3HRjiI01dEstm+p7pUSgVDdC3xHwIwCenTs9TYcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Ss33+I1; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Ss33+I1"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-46808125c65so105466b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774114150; x=1774718950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvvQ8YRlbCDdvSETkeQqlLmhBo8LyYzjyQYtiIPeejM=;
        b=2Ss33+I1x/0B67LpJlGuQASUpWRJdp5Kl37PBj+AVVHyq/STo9c+kc5Oh/gcRJWSz/
         P/pczRmctkVtjyueOungtKW0bXrbw3GOA5pfoNcBKKegz2Kgzq3QfuJDIn1uYxSxaDa0
         uBmSlJc2UfPLim2wiWR/wH9xg74zlOyl99qMcGdrL1uurhBvLXIb9weOh2gzTvOMDCn6
         vt7NkwmM/1UEuqsG1xQoVogHjiW7gDKU59w5fp5d2L+LyLDA8sYltOvskTlRMBCU5Bi2
         IQ7LlHIKEalUOhJHhV5id8fcizYmE6PsfJqFeVPeLiW9E1ARX2MuqqzBQxerN9CrtJza
         einQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774114150; x=1774718950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvvQ8YRlbCDdvSETkeQqlLmhBo8LyYzjyQYtiIPeejM=;
        b=A2zkHaXvYLxbYqFORliQlz46e3C1VBk17ZhxmQgMB1WIWLEGHSesid7nW9N3C0gGNu
         eS9o+weIRhIVnIGmK7tTP13wYlNuY9VMSKIfGlbYeZIPKr9cAk24ip7TL2x+pHiOUVQF
         hjSah3HKwWXRMhj5NpUl4tOApKnWyVnRfWRUSWPdhYhdRymGynf7p51/GVEAP6vvXKzf
         QuOYSWmi1tP3KjDyya6bf2i3pf3iHV84KEBmp70VvAAkdVruy5famrNsxq6URK/qVpJN
         5xv4Z4qsSBdSFMKeghoAOcj+5zBf5rMs3zsT+i9Oc1rW6Tv6gic+GGN/umaYegy1wuj4
         SEGA==
X-Forwarded-Encrypted: i=1; AJvYcCUVGTC2/ZGQpsOk4rXPI1o9qgPDPwXQTbttTsX7jm+WqlDX4dBohY2c5q2L5urXdeHAInVa8vfUZVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPneKN/ZRWAgLQAeaLxJFRenGZlVvmNxySmFs5xOtSpMlW8AyF
	g3Cild/tMeN6VWEfI5BQYwH6TmZgIK3Rp367fKHi/LqptGOq3zd1yvBfPelPiD2vLC0=
X-Gm-Gg: ATEYQzzlYmOJ9bajDIheWsPUShf5TuQr9EJJBKroV9XBVpcraqh+4x1Xp4xiTAMeId1
	2mX6uEZOTUeGDXRbczLipxfOJOyvJqXaqtWdcDbeiuS2w4Lo1AyYijOEKMxrnJbs4VHLYl8OAsK
	j9XkdOif0ohN2/dZ6tM9TZHUaLx+73No8BhZo9Lt/zKJ1zOc28wO9H1M/vpz9Se4DZCjO7BT7jQ
	p165CyA5xyg6FyrDEnDRqFrRm8mXwBgsHw2Z0A/JioynwyfVlJqhLGp1gAuGopMJgKcfg+F+jq2
	NGOEB2Y6Cygz4Uz46Juke0X1e6f4oMQWNI3U3/MTXhFxFHnWcYXBxhxiVYwS0RsQMSUyQVvbEb9
	RvUeYpCD9f/lGy4KzEczAf+xqBakoTIfLrpoDuXZHEde9vMn4lkaRSDIyZ+OdwrxQ/xet4xAYjd
	q3QhQ+EBEI8DrRp1tsr+EmE7FPJ/mvaxFc9wBx75bwYeKGO4UvASj4R+TzY7jDPgELQgxf1m5vr
	w==
X-Received: by 2002:a05:6808:300c:b0:467:1ad3:80e with SMTP id 5614622812f47-467e5df7b4cmr3707535b6e.26.1774114149986;
        Sat, 21 Mar 2026 10:29:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8e89:f58e:e4e6:5567? ([2600:8803:e7e4:500:8e89:f58e:e4e6:5567])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7efa5e2sm3684233b6e.14.2026.03.21.10.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 10:29:08 -0700 (PDT)
Message-ID: <b09d1e1c-885d-4308-87f4-1bd50c76f029@baylibre.com>
Date: Sat, 21 Mar 2026 12:29:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] iio: ABI: Add quaternion axis modifier
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317150316.3878107-1-flavra@baylibre.com>
 <20260317150420.3878400-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260317150420.3878400-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 10:04 AM, Francesco Lavra wrote:
> This modifier applies to the IIO_ROT channel type, and indicates a data
> representation that specifies the {x, y, z} components of the normalized
> quaternion vector.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

