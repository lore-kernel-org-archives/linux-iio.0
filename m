Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975196;
	b=Aq3gF3Zwz5l1rc90+t3hLATwIOqMIXTylxdeL/lGdQisLxp1DO7Apwu7GGm5ZRXvCr9v
	 A/QIXDTHejk0CfBJjMRX9iRPKsL2xmW2Jz/z8d6ym+potbkJr4pLjay+eZN9WyQlnl46Q
	 deeHtXeeUhDIF2PpKwpyQ8nXYNhnJ9xiX2TfbpLiymbEQutO+OAf9hFgg49rP6+vdhUDW
	 V68oH6qWy/Q0Js2hJkx8Q64Y16p+mG4K3MMUl+24zi5xVD5xAHcy5dxD6Rl7P0h2oHltG
	 c82dAa0TfzIXNRyWMcRZLEz8tYrB3ibevPa05MXKkl/CQQvF4bOQ/RMcCZ+tIDpHGhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975196;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4ogPoZF/lqkn698dMqetdlvhWbLkdpcLeii08xRYCdQ=;
	b=gNns46gzCqsi8znJFDMlLlLpMuToEneIahyffjvBd0jwZI8RrRTRj8yGf58AYjVwIaij
	 e8xaW2v3ZqnFizB2W83gL4kl0Xkwszw1QO71qY8Ha6C8M7R2Y/k1lPwWSmmyq+Upfa9Q6
	 8E33nofJASZ12DOmzBTmt8wf1QQivYDBEgi8RP8aH36BgHyMWau0xIP1SBpIvRioO4oYL
	 b6LowADm9xgOAtsQ7NNlHplVDqQYs2kjUCL3PekFBmURZZrQ9H7in1r+Y+N+3VOQcO/wl
	 8Y/6cQvNj8yGcloz29syy0CjAuq5d9HLkqtVNPrPm9AfLqu1eKAGSACFopG66O/kGfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9BAGhcq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169E606A31B;
	Mon, 26 Oct 2026 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9BAGhcq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A1C1F01825;
	Mon, 26 Oct 2026 00:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792975196;
	bh=4ogPoZF/lqkn698dMqetdlvhWbLkdpcLeii08xRYCdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m9BAGhcqmnmidYPeLRdveFJcgl30BaMU7/u07/i3r03R56tZ5ICmgh3fqtcCkY5x8
	 uQMQAPTRz5Hmaj9gTaN5hfYOcBxu5LVkC49cwcUMLXJ7K8JjdAlcNY/1m3cSdc+MBO
	 RWrlY5HbQPzce3f/TSr3Gyhrjw4ZkAZCWljvkrfqyZEWjmmBDHGjq6Q4egKPlTwTXW
	 7jyokoM4HlX/ntiQGImvipInX9w0YtQVQP6frzWP8yvCXVT/tEEhewwDYS7p1kbweo
	 7pO0mQUJpOjtI2Q7D8oZKGSgx3oVJrzgL73aXHYPBfHuqMtfZ/P8YDRzaJAZbK3eTq
	 lgvJEbINmqTRQ==
Date: Mon, 26 Oct 2026 00:39:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Radu Sabau <radu.sabau@analog.com>, "Janani
 Sunil" <janani.sunil@analog.com>, Salih Erim <salih.erim@amd.com>, "Jishnu
 Prakash" <jishnu.prakash@oss.qualcomm.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9039
Message-ID: <20261026003950.3a5b2e40@jic23-hlaptop>
In-Reply-To: <20261022111759.6019-1-antoniu.miclaus@analog.com>
References: <20261022111759.6019-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Thu, 22 Oct 2026 14:17:53 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the ADE9039, a polyphase energy monitoring device in the
> ADE9000 family. It is register compatible with the ADE9000 for every
> register the driver touches. The differences that matter here are:
> 
>  - full-scale codes match the ADE9078, not the ADE9000;
>  - dip/swell detection and the digital integrator are both present;
>  - there is no total reactive power: no AVAR at 0x211, no AVAROS at
>    0x010, only the fundamental AFVAR and AFVAROS;
>  - maximum SPI clock is 10 MHz, as on the ADE9078.
Other than missing Nuno's tag as given for v1 (I added that by hand),
this looks good to me.

Applied to the testing branch of iio.git

thanks,

Jonathan
