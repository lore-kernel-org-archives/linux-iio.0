Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793778865;
	b=l2xbMlv+FLWUz+b9wFGZF8t6w9Juk/gSklqRXgN+Xjqkhl6a+JoIhsLCrP3QLleSVzrj
	 3uiutkQQMH4tL5AWCjJ5PrGg5JmR34sW4LcaXAn6S+DKwlCORmclBIRvUYnmNeT/oQJoa
	 m3jrGiiEOwkJZSIJx3VJMgeuvVwbSb/QTQZs+BmWoPM6wkpq9IEkZoFuST1qzQcdqnevp
	 /K7dssqzwd2DAByYyDe8PVGSnZiQRovWU12eIydWJN4Z6H9fHLORKfISUjtdG8yqZPsbn
	 +lJ/FbZqVb/Rh1EVljhVY+Ska72K305r8SkQCn1feSz1ToeE8BD7NXuiSSJwWvTlFOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778865;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Of08z6Vz8zX3aCMA4M/zY4MdFGWoIDjVyq3Rd8DU6CE=;
	b=hMKF5RdfmwexrlyR7z4W//Fo3PhnNUYO+jIwNMXeKJxxTIP4uiRV/FvaGYMV6urA1AX4
	 cRYPnqZ/4oNBRXoan4v7FWf9ONpiftqiEjGGg/DbxNqpivqqSeuPoFWDsuJoBxnJP/2+G
	 BNos/48fIoT3iBGGVqHmWmfxXlJKNHGXYQc8pzpH019ifxkVNi2Esr8eQvGYmUwnOUWDn
	 JtLtvwbLacw1443MBJR8Ai4TF7d0rQ421bYb3ToZa50qe9+Ez6m/SWQE68SJH5z5WV3hT
	 xTTeBnbv0j/lI2aLpapf31jOJx6qSsZLdkBwxIKFpSZL1+k2S4THPbrd15r6CyTsZYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLB5jRJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F7606A333;
	Wed,  4 Nov 2026 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLB5jRJH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793778865;
	b=MK7NojtCwLDROdzNkc/0U/bWQY3FElUlCc8J/W1e1OJieQO/KVHE4+2BvxL8CVB8mWYV
	 jFL1tJmqDJ2x7l2Bv2kjw114fT2Q1Sbh/ZcWcsrbpFaRULCyib8UdW8/z6fw/eknfK3SL
	 BXxImKaLijcDxDw4JMYhZqOOTdrQooEhh/GCaJxnqAOTmAfNKnH9/kLGVj3R1VpEcNqrS
	 EwSVVSggcJbRGwM0h+COB8zo0Ey4o7d1XId8eHIGMshag4yVrnIXFTfvnd94nQFHjWoiK
	 0Ef2d4N+fgWYHzm9GwrmZUwWxGO+lVCutprAiTzykzgsJWHfeZsUobZ9EW4xeVQqD1A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793778865;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Of08z6Vz8zX3aCMA4M/zY4MdFGWoIDjVyq3Rd8DU6CE=;
	b=JBXAM0niG15zTG8o9WWoQ5AJBuyIVub2pCkmzitq+Xf6IWfmOU7iLhbOO2AoJzbnnYhR
	 NVPBdxAaewdupEqTppru26seLgMMM8Hj16/lNXFGhNiyRq4JShZX6MnleIUK/cGvIEZ4p
	 O6Ri8LQHQHjjqbUPYfmEAlqZCWe+0ePLrRZIc7LN//JfyGQg9bS6Pf26dBXicUvsdhwul
	 Lv14uMI5J8x7nBx94ZA+P2tr8gLpPsWh9TSfzheezkdDompOsRQwvbF4h7rt4SbfqMwLv
	 fZe3urQXVAmrHpHbXKdXFolq6gvOBEGThx/9FZ2X5jLdADpsvaxOhCEs+jqtef28MRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id C8C791F00919;
	Wed,  4 Nov 2026 07:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778865;
	bh=Of08z6Vz8zX3aCMA4M/zY4MdFGWoIDjVyq3Rd8DU6CE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VLB5jRJH6ANTcDNh/MxCplOqJlp/+2F/W778/hWLNovUE6myojf/A/3vrHDBbjQHj
	 7EpPLarmxGnsWEpRjF5Q280Drj8sY/6SV0YF1MHc4jaFGkSwomoiKZsAlLw4rBve2S
	 dnt0IP7jxJk03xYjatd0yNTUOv1op3bcZJ2TwTSLENJaNnWmRoZm42PAW3wZa6S1Bj
	 yX4rtC6BrEdz4mkU+yCw5kZ/1NpcwMDPcYoE8rrA+7yCoCaCAm0y2B9csuX2vg0TRa
	 /F+HtguXqxKXoerOWjE1NcE8ZyzyvlxLauc8zNYJ15XJySIJqvX4EWd9Aro95xk2UJ
	 6f92BkDTdPjWw==
Date: Wed, 4 Nov 2026 08:54:16 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-hwmon@vger.kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marius Cristea <marius.cristea@microchip.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 1/5] unaligned: introduce be56 unaligned accessors
Message-ID: <20261104085416.00004b55@kernel.org>
In-Reply-To: <20261103-pac1711-v5-1-71c20101a52e@microchip.com>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
	<20261103-pac1711-v5-1-71c20101a52e@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Nov 2026 16:37:11 +0200
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> The MAX34417, IIO driver, is using some unaligned 56 bit registers.
> Provide some helper accessors in preparation for the new driver.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> [narmstrong: update commit message and move to include/linux/unaligned.h]
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

This patch is missing your Signed-off-by tag. Even if you're just
carrying someone's patch, the SOB serves as proof that you have the
right to do so.

-- 
Kind regards,
Joshua Crofts
