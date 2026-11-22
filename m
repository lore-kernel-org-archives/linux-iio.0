Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376464;
	b=hrUiWVdRMxqjjbIGy5/UzU4kuA/dowgra14g6qsUpLnBg2zEogKAp6AFP7mWUKCLecIx
	 5bo66Gymot89+ambXdEbq/jF72D7IlAbQPhloLmYC4A7ncCzOcZDLgmoxKMW24blBybq0
	 xQiL7TScVomPd9zKVRo8jIHlB/1n7tK84cLViVsI8XkX5WoEnFxalHkj2gFQ6mGsRXIVV
	 6/U9rUkM/SIjSMXWXKNRHRFbIJKeF9oTox9xZcXM6y2/Z8t4IPEWSpHJ/kpIVSa2wDIxz
	 0JL5SoF01nTkfIRLlCe+ZnANzzc9AztPmFi7176q6eY4sQ2KCj2EIROFBo5OlRrIzAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376464;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jc5uTXMGIRFEaP/BVZ1CdVau38GXTAMYPoFncKy+KhQ=;
	b=ef4vqQQeQLER07H6a1mx44slJfVnRqvnIrDi4iUdTvpQWgDMryXBFw2A00aXD1Dojb07
	 /bEB12PcHCWr7oByv9ita7ITqDkCrsnfZ6/q8TBHLSQH0b1dr9R48wblcQLpaaONGEagW
	 TLqxmC1CrFPP4JF8g09ODlUsDu9Q67m+AVmKFUM3j4jZYwxgFkPKrAbiB2Nwr5UJVGO5V
	 qpVZVSW7hpjE+ZHCmf8Mp897wTWxVCQrKIWOOO/9J2SWHyBc/+BKMiZ3UQTk+L2cEi+uY
	 KOZaENtzBDzlsfWFjim/xzyyZ57uK1xYGCEW9OS7lBNVF1ra+SeutgtSz8+KYaZ3hbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNF0qKnV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBC606A31D;
	Sun, 22 Nov 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNF0qKnV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129061F000D1;
	Sun, 22 Nov 2026 19:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795376464;
	bh=jc5uTXMGIRFEaP/BVZ1CdVau38GXTAMYPoFncKy+KhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dNF0qKnVzn82v3Ssu/g3r/pkwtHEgIBKLneiQ+oBZg8PZAeIOZsWOMANd8IsF4sxp
	 X9z/9XTHYELaUvsNvLiZcbIUktnIgYIZn5x0k/d6ThkgnFqQBYfQnAFRC9QL+S5X02
	 GHxxz2aj3SrLMoLoPUgq6KFb67qJuUcQG3YPV+uo0GA/f6drLzCNLgqKH43G/iwi6e
	 zaQbRgGkh5RERUS8+dcO3/kqqwl4f7dt5oPJc8CQ8FfI/jkAZHx81WlouYBdeZHBcR
	 xw80r3k983hO5jp0ukTxGRPDPEPYw15lRN1rtCDbYQ9Njiye4JrMSa/6JwtZzKt+nG
	 3R9SAlqGJZODA==
Date: Sun, 22 Nov 2026 19:40:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, Martin Tuma
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
 Walleij <linusw@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 06/35] iio: adc: ad7768-1: use default_trigger
Message-ID: <20261122194052.5c6f549a@jic23-hlaptop>
In-Reply-To: <20261118094429.00000942@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
	<20261116014823.3132576-7-jic23@kernel.org>
	<20261118094429.00000942@kernel.org>
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

On Wed, 18 Nov 2026 09:44:29 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Mon, 16 Nov 2026 01:47:54 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > Set indio_dev->default_trigger rather than taking a reference to the
> > trigger in probe(). The IIO core now takes the reference during
> > iio_device_register(), so it is not leaked if probe() fails after
> > the trigger is set up.  This avoids fragile ordering requirements
> > in probe().
> > 
> > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")  
> 
> Sashiko points out the Fixes tag is probably incorrect (and I agree). Commit a5f8c7da3dbe 
> set indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED, which guaranteed
> trigger unregistering on driver exit (I checked and it does this by bitwise & with the
> INDIO_ALL_TRIGGERED_MODE). This behaviour was then removed with:
> 
> bca036de0ab2 ("iio: adc: ad778-1: do not explicity set INDIO_BUFFER_TRIGGERED mode")
> 
ah. That is indeed subtle but correct.  The flag should never have been
set but coincidentally was set early enough that the ordering meant
the bug we are fixing here wasn't exposed until after that.

Tweaked whilst applying.



