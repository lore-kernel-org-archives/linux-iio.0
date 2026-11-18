Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005467;
	b=rttkXgQcDawnfodp9uQcdrybkHejMM7pholsEOUWqD8SmW4ooI5uP0WvrSGz8o03QNJT
	 AcvU93nPsSEdK+Uglz513PZOe8u140wy5p1bfDH+n032cvAWYQVGeC8K6Nl6T5iIgumHp
	 7gz55wSWf0PaEwwIM+JXvSJydw6v8LML9SNA4MUfAUDQyVr9jySrNQzcjxTrZ58l1acHd
	 phDhGICoaSNBk99IlL1XWwmrmD5pycuSrKxxDizhnXqojKhDdkmWH8EkKlhZLFwN9MAeE
	 DDLXu0bUQqHIWcv3g4Wu9pmV1cWXLflC7HoqVzGD6kCM1knbPX5W2JnEBynaknTiklw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005467;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=N5CGwXkDYC7ZHZF12AdVjIxEK6seoaUVe8eVp3p/csI=;
	b=j7fVlcpVl2rsLrupQaqlOiHCtpOu3eQu7SXmEqQxkLEns6EKf41dEGd5zFxRnd7rTA9j
	 Cq8X473EuqP4RQTKlIafDPCz8Avco6N95xJbwEYeWQUBWZ1kAzcWrf7u4G3z/5t+dXdbB
	 w+zjF+nnuvcvbHmFLMheJ5d13R9x2Qk9Ysxa37MW0CgJxemzZVxwx0R52I6n7AeGWOgsP
	 Jjy3DKMWb/mu9yHEmfRnkiPcRmtkyYZMe2R2Pc6WlqakeY6EUdTK+CrAF9RoWXLRpw02j
	 9kDbYF7N/R5QCDfM92OIGxRTUlZDDY+LEHGm9XFkGjmsDrCnMRHqxXt5doLbrEaHijw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzqS5r0S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6626606A320;
	Wed, 18 Nov 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzqS5r0S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD621F000C4;
	Wed, 18 Nov 2026 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005467;
	bh=N5CGwXkDYC7ZHZF12AdVjIxEK6seoaUVe8eVp3p/csI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YzqS5r0SUs/wsxWZsq5PkMXx1btPUd6pNUmdAZRrxFjDvPs4/67ZtV+EplWQsoJQh
	 Y0ekpMB//ArEyiOCEoFEBRDQIi6vqSsYSqiJab6aKIRxu+k25YlrSCUkSy5drmC2c9
	 0EU44tZPQFYmLg7aq3PKtDmO6t8K7Cq4Lfvg8STljzUYNtaAUGpVBzpy/bMv6sW2eO
	 zgUIftfyqoSCSZo1z+ooOwmg+eDs5+zbl6Kowxcata+cfPfXGOW+s96GBlvRHkU2OW
	 yWT5PlPwY5uOd1KDJ3D97celi7EyezXs8A7KNu/mtHliFixfv5BwqVEUpsJcHxt8Vv
	 l6IQUNu7DVkzQ==
Message-ID: <f3d38cc6-112a-4d48-b0e6-f26d7819aa1b@kernel.org>
Date: Wed, 18 Nov 2026 13:37:40 +0100
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
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: proximity: semtech: add myself
 as maintainer
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
 Daniel Campello <campello@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261117172612.25535-1-kapoorarnav43@gmail.com>
 <20261117172612.25535-2-kapoorarnav43@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261117172612.25535-2-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2026 18:26, Arnav Kapoor wrote:
> I'm adding a reviewer entry for the Semtech SX9xxx proximity drivers to
> MAINTAINERS. Add myself to the maintainers of their bindings as well,
> so changes to them reach me.
> 

Why? Same comments as for cover letter. Looks premature, you were just a
few months ago sending multiple same patches, clearly not even checking
what you are about to send:

https://lore.kernel.org/all/20260624044610.69708-1-kapoorarnav43@gmail.com/

https://lore.kernel.org/all/20260624042543.38925-1-kapoorarnav43@gmail.com/

Your patches were never even built by you:

https://lore.kernel.org/all/20260621045340.65872-1-kapoorarnav43@gmail.com/

Building code is... well, we do not have to even discuss that. You were
simply sending LLM slop.

LLM slop senders are not maintainers. It's doing everything opposite to
maintainers.

Best regards,
Krzysztof
