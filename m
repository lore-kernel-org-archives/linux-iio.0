Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100944;
	b=eNL5G4ZSN9nHGFYZdJ1dRpataItr4lRFbFPOSyhEijVP2Q7sKEU67ZwYrN7xrzsefKgQ
	 5clIQfO3A0TKYqeUPfELNuvPBezs6K+u/MFE8ykQ9RUIX8eveYFXr1eQmqUSnW0P3cRyp
	 F0l320cUDY/o/Jz7kWDBs7uVS/a+r1wkJU8boVX+kVfIi824q7IO67JFYfvspvvm8Q9xn
	 2mDj+y9yj46/2O/zt99nkrILT81XnPIZHRdObErzIm/+PmH7aQKuh8AqTW2rDF8vYL7u9
	 /lG68zSVLNiD2X6d0t4cjosYWl/bxFcm/ZA52NCQ73K0YRxwBDgDp8yo7PilBRo4WOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OsBxFOq7AXJhA+UmV56oiMWfcD4dV2CjI68wMbv34tQ=;
	b=MtCpXmhN1mmE4WZpCFWdQ++OOoxNI9TFwvuIGA65rflVltn8AphPJSMo9U2tQj9SdBLB
	 clMtlyA1QoaXEjg1WzI6CioxY0l1e5GSQu7ruLaqqmibxVvRF1WHHk/LzZUuFJ3sDjkdE
	 3jxgmtGPGvsvqDk3er5XBOzDNoBs1+IUPGPRb47SAXiiDDW10GDGri+iAO+D0UnFm7GjJ
	 YMMlHQ3YvqY8vI5bJYZPfmR4qR35q0bA5nBgHfq8ub/44jFUssG1lDc0PDDmoEwkEK7Zb
	 S7ZV9+t/psx/6Go6OR/vPvkqabED57fl2urgVPGnCK2JFbZqVj9OYU13vJokU+zxqdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmAQIV9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59A606A326;
	Sun,  8 Nov 2026 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmAQIV9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392551F0089F;
	Sun,  8 Nov 2026 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794100943;
	bh=OsBxFOq7AXJhA+UmV56oiMWfcD4dV2CjI68wMbv34tQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DmAQIV9C8J5x+Q8w4O77t+6kudks0f0glrxhQJ5XSsFuyhuVFg4hGiYSYyca6yXK5
	 o514zLLIu8lbE3sKlfiWWcU6q9AwHaZSvEaldcIpYpFnEUK7RcZV017vC46/Vh1Tei
	 c1RLjpf4osf3kF7YgL6nPX9GMaarHyWoULMCdqIAdxOdoNMp+/AbIvmsvAqK2aGwU2
	 s0O3jUc/sIJid2rAgoBcAIzZLLSxrCH95wT12jtiy1OKMrLO7Nnphg+wgGvsFLk+kA
	 RxlkjTb3oyUvIriHmQJ9zEBPGdB1blcJXhUaiHTQ06Lp6OXfcmxnWx0c988brYrLeX
	 J+Ih1rWhvD7qA==
Date: Sun, 8 Nov 2026 01:22:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Eddie James
 <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: pressure: dps310: fix input checks and resets
Message-ID: <20261108012220.3d09aae3@jic23-hlaptop>
In-Reply-To: <20261104091351.710582-1-paulius.zaleckas@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
	<20261103223008.12675-1-zoone.rupert@gmail.com>
	<20261104091351.710582-1-paulius.zaleckas@gmail.com>
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

On Wed,  4 Nov 2026 11:13:50 +0200
Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:

> On Tue, Nov 03, 2026, Rupesh Majhi wrote:
> > Jonathan is holding this series for your Tested-by. Could you give it a
> > run on the ZTS8032 when you have time?  
> 
> Tested on a ZTS8032, on iio testing backported to 6.12:
> 
> - 0 and 0.5 are rejected for both rates and ratios.
> - 64x at 4 Hz survives a timeout reset forced by putting the chip in
>   standby behind the driver's back.
> - A warm reboot during a FIFO capture: FIFO_EN is clear after probe
>   and reads work.
> 
> Tested-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>

I'm going to take this the slow way mostly so other work
can easily be applied on top.  

Applied to the testing branch of iio.git which I'll push out
as togreg for linux-next to pick up on sometime in next few days.

Thanks to both Rupesh for the patch and Paulius for the testing!

Jonathan

> 
> Paulius

