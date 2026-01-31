Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F836A003
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888933; cv=none; b=s7A8Ly56DYceq0Elc+dGHISZ54rLfTVmzA65V0a1IhC9ZWuggn8ddhPhVeGYaIg+430j5tqQlDbElFCHQvYWU+xcTWqdEi0M2ERuE4hwiRwlpV2D/YQZuXZd8O0blPNmwvMShHHgqNioJ6tZLuT3Ug6DJGQq6UvEAxAiK3XsCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888933; c=relaxed/simple;
	bh=dPpm3l3WPw7+UtDy3mOZiDg1GUUhyRC4lyTEv3mW62I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISzfBol5u2AdH2jhAp1j2bLw9jyYuOkkQorlFQSYyQnu2L+FBYOTzOhpmYBue1hszUItqptw9ygzy+aC17G5h/K2Y8+lNTzNZIZHdSAHnUt20/5qBBnd76R3eRHiyzbwQ1pXhzq7rwgampRK5YZ95svRaJ90sVpqV8csFkQo+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E0yl4gOO; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E0yl4gOO"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-45f0dbe7dafso1271996b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 11:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769888931; x=1770493731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQ+TaOsJS1d5at3UMn582LZcj7u6OHzNvDSFQmdpmyc=;
        b=E0yl4gOOFJpyySVsDmn/hpM5PSAkXhwDmN9vu9ibhwoX3SIpxHFAmf2pflTYaKtDtm
         AYu4l00lCHJz1k7nAYHzHA58SXe6YDVPOgq3+K6ygl84RCCfWQNYwj1fCbmIVYcJ6QG6
         urTM6ZT+706m23jvUGoDLMc2HgpxbbwWVqQpNXevw0ffTzxpQPaI5lqJK7qvVf3F8iYJ
         T9ZDnE1wyUl96tjA1xkw26atNQphlfRMD9+EyoMYas37+ojq0jc3ZB2px2e90PpVQ2d+
         J/2ClZEYAFJZjDkVIFqR40XT6+zEsnciAbNGJUVcJV3ZYTh2RveYHNroMvyjhaA4EgB1
         qegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769888931; x=1770493731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ+TaOsJS1d5at3UMn582LZcj7u6OHzNvDSFQmdpmyc=;
        b=X8NDBEhHuyZPBd569RaQS+2WV6tCeIA+nE6dZtysXDB7Dwfrvj7/GG4ZO4/tksg08M
         ABsg9gkRHX1QxHHnysdJPf5knjMnTmx/41QoQz32fcfoXbv1a3AubvtrqeeMqXdkYJXd
         oUEa4McYLVOhyJJf/DeQYZgv+/TMhH4PZvdNn9y459FjH6nkepIdheoOoEacRcDu1Sds
         3jXBqLUjAoevc4qsHpsW9QGQx3/2zsDgk7M5BzTcpJMqP6cfdjZukjz5pBM4it7DNWNw
         3WkKATvb0/ViGDC+0D7Bl6/gFHA5JRpGPzBnKCki9laNy/W8UQRU+zJEuvVTuAPYFs81
         kE5w==
X-Gm-Message-State: AOJu0Yxzua4niQ2YSRv14EuI4WnH2EZVGd+Jg4YL+y+3+rBL4Dgq15oB
	9a2gBybkV1Mm5LEW9O4InROvt7N+0TiBNvt9DXaYCaKips8uJ5oi6wvTBxx0jniQi7Y=
X-Gm-Gg: AZuq6aLjh4xJJGaFFbfbIicVIx8etV1FD5jdlGxonl7Q5ugphMTHMJp3YNADDWY0In9
	h/rQUn0ZYO+0oY91LzLcsS2MkicDrmnGPloWAf52yMd90k4nxrUKct+Rn2mYmS1/RDYyStCx62d
	ISC4S/IAXYgdn1voZXYHb5a/8U68ilShUtOOV+sWJRB31Ng0mKzxzDYkBleT4iK4RZUmiPFfwoo
	WaDcLafR96IuNp6meMdk9uXqdTLDDtO0duQERlwr7kES6bs3wujFptNshcKpMitCmlllKh+fm6g
	YjxebnZmTcofwXU8o2h7mYrLYdLHhMKc7vr5hDnlCbz33fQ/q37MaKJ9jup8uOQPg4TE/OSr04d
	FvYLDR4Go4AhPzLceVOLFuMN7UEyzgjgjPQNK7yoLkNWdScXXzD3ofRrGGuiB+pg0FGzNOJND51
	ubzCXu4hGUBrpFc5nM+HUJNo7lSOZOz7we0FNDvCk5+qRE+TE5arWW0A3hEsaq
X-Received: by 2002:a05:6830:82a7:b0:7d1:91c9:9e5a with SMTP id 46e09a7af769-7d1a5232569mr4532126a34.8.1769888931469;
        Sat, 31 Jan 2026 11:48:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm7778648a34.6.2026.01.31.11.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:48:50 -0800 (PST)
Message-ID: <92858c73-1e11-4283-8ab6-1188e8bae0df@baylibre.com>
Date: Sat, 31 Jan 2026 13:48:49 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] dt-bindings: iio: adc: cpcap-adc: document Mot
 ADC
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-4-clamor95@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260125134302.45958-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> Add compatible for ADC used in Mot board. Separate compatible is required
> since ADC in the Mot board uses a unique set of configurations.
> 
Logically, it makes more sense to readers to put the DT binding patch
before the driver change in the series.
