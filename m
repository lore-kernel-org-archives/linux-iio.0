Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376740;
	b=HLjT92RR2j3gLXoliWdukA5kFAmq0GzPpiLQK0wF6RvwubJjPqANpDQ+NM0iAOUwoMcZ
	 DFOB8HAqlkj4lOqpK9DSVTUueJqzGANVBa3MamWu0M/xjmn4/B4d2Teu75yA1RXrCHY96
	 V+TeJxecuYcjdA5k99avYm9PcYwH6L+iVThXH5JpJ7lSrfzpFF6JY06dYKq4RyKK1d+k2
	 /CqosulPuC02eijIYwyNqWBJZr9l+uH/peIUJoAqGWtGWqf7bpYQGTRzCzCCu7bYemo+2
	 3VMvN1Px4C0PScqIhDfLMMgaQBWto/ROPtg/zXQVNPHftM54UCHs6XFydQHxlfcyLjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376740;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iysj/fYIz1BFtLOM851aEV818YFpOLyMJgjQRbv6eCA=;
	b=MIOLVBH3jO9gycuQcHEm8pM/jlHNXR/KLaupRhsqc0DaUvWcrnTXH/DK7V5xzvmkyQGW
	 EUYveD9/UZbLQj/yAZvVUY5geizN6s7f8RKpkYBGoJa4Gb+X+npgkl0w5Xv+U6U7waFsO
	 DwAmAU7jWlz13OjjIhOO5HHkAY6HaDJrpI8OsMa9BNY9OlTeT385KU6+bp+H+yn4kqqJC
	 tneP5cZNan3A9jlmHoUGFlmjc41Mnq5sf3iLA9tTRZRtRnYHbOChnMSBibxAuz969X/4B
	 NoL5wB/CvJsvObJf9aoCsWVQfaBQWJevmrf+H0fFK9OB3Cy0Ibvz6HeedCCkg+w3v9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGYyxyqI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECE606A320;
	Sun, 22 Nov 2026 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGYyxyqI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1D21F000C6;
	Sun, 22 Nov 2026 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795376740;
	bh=iysj/fYIz1BFtLOM851aEV818YFpOLyMJgjQRbv6eCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DGYyxyqIlVZPU6H4DfMVqxaMRBFmvhzDYbe9/SJU7y9w42Rr23ZH1ZWGe6lk198pH
	 el1aHBN88dA2FxnogC6gzHohbjyyCK0qlvYt3yx0g7araISh8CDuOknRrozxufLlmC
	 Tc2ux7lTDKQ4mQVBZJOzb3C3aZKuMsHoe2wNQa6ue4Y09Ib41YD8BueEVzDtScXs6j
	 WcoSdqIUQ1O9HQtKQh9py95RN4JGkP743lUktzPAgDl/mDWUMfufYm4T37wDNfzRT7
	 CiIBZRcBo0+ni6hIpgO32T12uuh6yx4tHukXzncW/YKBCcojqNC/9viCXNGbLx6CyA
	 S3oa8WQP8ok+Q==
Date: Sun, 22 Nov 2026 19:45:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Martin Tuma
 <martin.tuma@digiteqautomotive.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-media@vger.kernel.org, Gustavo Silva
 <gustavograzs@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Tomislav Denis <tomislav.denis@avl.com>, Jorge
 Marques <jorge.marques@analog.com>, Petre Rodan
 <petre.rodan@subdimension.ro>, Dan Robertson <dan@dlrobertson.com>,
 Jianping Shen <Jianping.Shen@de.bosch.com>, Gwendal Grignou
 <gwendal@chromium.org>, Maxwell Doose <maxwell@maxwelld.cc>, Tomasz
 Duszynski <tduszyns@gmail.com>, Esben Haabendal <esben@geanix.com>, Narcisa
 Ana Maria Vasile <narcisaanamaria12@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Vasileios Amoiridis
 <vassilisamir@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Nishant Malpani
 <nish.malpani25@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>
Subject: Re: [PATCH 00/35] iio: closing default trigger handling leaks
Message-ID: <20261122194531.790f279b@jic23-hlaptop>
In-Reply-To: <20261116014823.3132576-1-jic23@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
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

On Mon, 16 Nov 2026 01:47:48 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Note this is compile tested only!  I definitely want a few people
> to test that I didn't break everything.

As this is mostly mechanical and we've had some good review coverage
of the approach, I'm going to queue it up now.  However it is only
on the testing branch of iio.git for at least the next few days
so more feedback is welcome if anyone has time to take a look.

Thanks,

Jonathan
