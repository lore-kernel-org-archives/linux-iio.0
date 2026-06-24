Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F33ACA7E;
	Wed, 24 Jun 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289820; cv=none; b=j9mmGJTCc95htfl+ny/LhdtfbvCoDpyT2p+vp8Sx5MsiuZyL34wUEScRznUfnt9S5z5RSx018WZ3l/8Kn262R1tnfXFoBbbud2bSRnlzS6siSell97J7QI1sz77vjF5/8Wo1yy5ARDjyUC2wL3wtnGXNQPj1iJ0COO8eAdMRBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289820; c=relaxed/simple;
	bh=lvDUZCfr4f2STf+KSp0j6wmb5XbtmFh2Ct+4mpEshyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6v2CfPt0dy0h+KUrIRhTY673GuRsJV1qwZDQHM14ydb1ZZs+1/RjYu6dY/H7pnaJbC8EtKZXcs+muuq4GLukgAbxJh4diJPoM1k3La2aLyLwwz/cSwLIHKz8dRMUfN9ORmRQqhpFj0jTdtXmYIsQLNzwKPP84jN2xRfXYdPxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=QT0YZvzv; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="QT0YZvzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1782289809; x=1782894609; i=lukas.metz@gmx.net;
	bh=Qotsfy0JUbJ7h16pbUYE8Kweywkb4VDO8ju/ytDk0YE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QT0YZvzvSpml4P889NqBK7bhuSLo0DpAF0XxGTxZRQKH1rHsOls91IENsolK/T4k
	 sWUugF7YEnXdAeAH6zjNkDPEdV9uAXUey7fLSYbzY5M+wDDoaDVtT4v0HttHIlkpe
	 9yD5F++NZYm3kxLWxI9Cf85wgUnoEyo8zreYgRe/q2tZku3T7mz+ry4eMbCJ3Slw9
	 jDkU1rEsek+K2/T2D2GgHjfl3UO7EVj1A4povSRbbdXjM9WPeJIqv1Y2mB1D+jEqi
	 8eTSs94jnfdlgOoCxh+wsyoaW+EP9+ZOv1AYkPO1PEuVhxGzb2h7WeFyXxvZsIpUg
	 WF8zRbBt/XFXL57YQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1wSAWr37D3-000IXy; Wed, 24
 Jun 2026 10:30:08 +0200
Date: Wed, 24 Jun 2026 10:30:06 +0200
From: Lukas <lukas.metz@gmx.net>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com, robh@kernel.org
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <ajuVjk-lw-DqUVnl@berta-MS-7693>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
 <36ffe80feb5a521c28b1a6d10bf1338dc39ddef1.camel@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ffe80feb5a521c28b1a6d10bf1338dc39ddef1.camel@linux.dev>
X-Provags-ID: V03:K1:z7HuKGzlgN77VbjyezRavpExlbAF5GUfob8U6AYuJEvJdenFJaU
 nCMXSuojnUSTBhJ0puMhv/IJIOqIGOmexcEl1sDrmOMAqAbTXzukIGpoHlforpN8JNPG9PN
 u/Juq9hH8EVCZy0ln5Q9jm7TvFHyXvGZGs46X4hVYfKl1JWYSi+raNSjwmKds0lduQtI0sO
 EGiIUz1WkjsUL+dAqOIDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MQqsW8uTH/U=;fcMUuUhPD0M22la2vYSb48Rlg2K
 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
 d0yvedNJqp5fYiA==

Thanks for the review. As i said this is my first time submitting a
patch. I have looked at already existing spi dac drivers for reference
but i seemed to have missed quite a lot. But the comments are greatly
appreciated.

On Wed, Jun 24, 2026 at 12:56:15AM +0600, Siratul Islam wrote:
> A link to the datasheet here would be nice.

I will try to add all the small suggestions i dont mention explicitly,
like style issues or using guard instead of manual lock/unlock to v2.

> > +
> > +	if (st->internal_ref) {
> > +		st->vref_uv = 2500000; /* 2.5V internal reference */
> A note on where this value came from or why this was chosen, or a reference to datasheet would be better.

I think i would add the suggestion from David Lechner to remove the
internal_ref property completly and add "the way of doing optional
voltage references". This includes using the macro
DAC8163_INTERNAL_REF_mV. Would this be acceptable?

> You have a CMD_SOFT_RST defined but not used. Should this be used to reset before doing any configuration?

Yes this is a command which isnt used at this point. But maybe it makes
sense to reset the DAC first when probing.

Best regards
Lukas
