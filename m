Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D018872A
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694447; cv=none; b=Eojz57ws4322xrRMvQB8+Gy17upINLJVdBkyH4k2ymXrPejHIL6yc5HeAwKg2zqlA0oXDxSPXCXY0t/E/Vj52Zd1ocM6SfWNb4md7pxD2p5pz2ZjN3wdb+UwRjYAA9uoK34qZG0B19olkm6tQ5tGjei2PKDrW3V4Q0GS9Ls7rGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694447; c=relaxed/simple;
	bh=XR1dfhSVli1Pid5SiGZLLVjDw59pUdaRkrY0seSKhbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fB7ZXPDXISb/6fCWAqtVRH12MNuiw+9EgEyuZJzBYSXTTXrgAbpsBnLa/FO2P8Y3XY37V2zsx5qdN96xjgC5UnB4xS3648JQ+QV9v3ozwaIQEeEcVtI/i9AGSxYyFLxbl8iYFI6NCcsGQh0B1u1zuPD0LMlwJ036W7qfQp1aXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=djUMbE/T; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="djUMbE/T"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45f015a3259so1033063b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771694445; x=1772299245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1EwBHrT2F5QUtAJqsFuE4k23yzqTehZiQCEqa4Nn1M=;
        b=djUMbE/TVh4H9VWSalEa3NJUaGoKYJdYa1AE2mH+P01K5wy6Kj2Xx5bsQSOr5vorY1
         /UYdvezmio1+o4D0ye66j4fsNlvcpNlBVlhdPL6jsc5WPKV40jjdsHprkvWF1Ma8JH5B
         xmeRqjvXlF3nsTiUCk0tWaBhj2lsVi1OR+TYOtozGDkKjkoxt53rkwEJhPy1dNP9pEta
         /iHQj71HfWot2dyiDzp1JOQMdKDrHRPrZkqZ4R1xy5dkB9t6R9Km57gSog2rGWTRP5pN
         nj8qXUFXCPmrJU5kjQkdWQTz3ORKfjSbQrR0eDPQ7HplH318mXnSUp/l2J1BTEq9zDRM
         6bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771694445; x=1772299245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1EwBHrT2F5QUtAJqsFuE4k23yzqTehZiQCEqa4Nn1M=;
        b=Ygxb7zRyS4QmjWmfWfSE8KnJPr7Cl0rVe7VNxzc0c+tkYuo9IrLW94XOPzTBNd6EJz
         +XxwCOBacblqJw6Y9FBqLNsUtZXFGPTbpWxiXHZS6sMuUAwjg0uR775jpamUmdUxOc9n
         6HJ0sXDecUhdr9GvwzbTO0MQ6VeaqyFY/dNW63hvR/9B2SHGNsmR8y+VQ09/bqLp6ZIz
         HuG0Ch4xLOm12bXR1X5GgdBvoz9YhaiIPMQIEV9xTXgKMMZILhB4E467uJ9GZUemj4Sr
         VzLbqOaJ+SDu2ol5W4Ejss9PvfS+OvBpNPwPgrPSZ2hamvTY6yICYya0ff0TqWoOamx1
         4Jzw==
X-Forwarded-Encrypted: i=1; AJvYcCXpmjnGCFUsg4TpfpGylM33/hLMWrtBGlvW60RbQS46O740hreDkfwil+gd3usYtxhYrFSoQ+n5sfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbLs8yuxDWi/HDFu9MZB4Jz40mjV3V/RJZmBpG5fThKfiA31f
	sdCofeuPkfRycsAryKUbVgI49+e00uH/Aqr/9VYH2kdh8rFO5NfywiNE8Cx5nKMFoAg=
X-Gm-Gg: AZuq6aK0zsHmjbKti1hQaqugvqxABVFY93br32UgPOsHYs02MG/8+Q3BD80oerdKuTr
	zxwusNTPZvuGaNlfESwAvGbmT+KFuT0+V1WFJ8YQRIa0VWmw/GWHUniqa7xGgzayqsMxJSAdU//
	aGg6+Xrbzyf4nxPNubaDdGMe9+v9ms5eSGUIhvdS5+l0fKADvwx9K1yn2R+fUGSp5izIMaU/hLi
	ywAk+9+dT+AdLbsg6ipe0/L5wR6NSyLGfEHkFNpHVnuYPFw9CZMjcshg4nJaQR89CQ20nct4fjo
	go9yB0PKG2p1IzZ/XCpW+mk7l0N9p5kZqnPwIm6d5YsvGUpe0+t5am3wbiOJPjskKTjUfCflu7d
	0d5AyOVkv4xv2dE1L2UxwFvrYIuJGdnKQJFu0mSXi0UawqGCeODhMF1e347fggkXYBSdA6KGq2P
	KdwGySlomzTiYc7E5Fs09rHC8KX/asxetun2d3iRYdZZTt6QMEWf8356JRdx+7wi53TLQr6w==
X-Received: by 2002:a05:6808:6507:b0:45e:a749:81ed with SMTP id 5614622812f47-4644619a0fdmr1930872b6e.25.1771694444784;
        Sat, 21 Feb 2026 09:20:44 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a17aea2sm1847935b6e.12.2026.02.21.09.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 09:20:43 -0800 (PST)
Message-ID: <b36307f9-c4b6-4242-9cf1-838799a926ea@baylibre.com>
Date: Sat, 21 Feb 2026 11:20:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: switch to using guard()
 notation
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
 <aZbBGomQi0l84An_@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZbBGomQi0l84An_@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/26 1:51 AM, Andy Shevchenko wrote:
> On Wed, Feb 18, 2026 at 06:29:27PM -0800, Dmitry Torokhov wrote:
>> guard() notation allows early returns when encountering errors, making
> 
> guard()()
> 
> // strictly speaking
> 
>> control flow more obvious. Use it.
> 
> I like the change, but...
> 
>> Also variables that now only hold error codes (or 0) are renamed to
>> "error" to make their purpose clearer.

Normally I would not give my opinion on this, but since I wrote the driver
originally, I will say please don't rename. I prefer to always use "ret".

> 
> ...this does not belong to the patch. If you wish to rename, better doing
> it separately. This, in particular, adds undesired churn in the change making
> it unclear.
> 


