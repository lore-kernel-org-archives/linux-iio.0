Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA537FF75;
	Tue,  1 Sep 2026 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232456; cv=none; b=hHDBVO/VLjhA9v1Dt+SeIzKyqWq8nksJHR1PWPHXG5G3S03asNPKEKHP9xyyhHgoI+I/R6mYd1iIgA0KleV04MH4+gg277rZtnaTSG4I0PKTnRpR/fnfBJikJQo4ClWFNuPWNuQjrHqtik9C9AaJhoJevXD3pZwvvrjmLf0WmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232456; c=relaxed/simple;
	bh=oY/ukphlPJsURIssq+vozSKvhjlA3sxbRaRiMtynKRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYmITYK8IbDNJfeF8QAKtJdFVskAkuIIOx2ReSUs4qH8ixdJLCYq5LoM3tcJtSGfsb8WF7bfiMJdG4eUxCwgN3W4PsYmZmUFPBfTWVXjsUZnTETZwpN1s0TJ1z/8jJqmrMTBEw604X25M9frlvYt5/Va8ZmhLb/l0vyYtXIdC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzvqJwYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzvqJwYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2091F00A3D;
	Tue,  1 Sep 2026 03:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232455;
	bh=dvfWGLzb8Pdt8TTkF8zZwPxENDKjrWspo4VG/ViH9+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DzvqJwYPDYKYXxyMKozyxoRRuUhXVwc7HEDtHV6pqt8DoxNdkvGffD3qFpnbUfOd5
	 N1jqFTYdXr58mYPvYMwCbs670glcJQN6DTfJWE9As5wu0LraqWhYDDnLMCL0Z/7nhR
	 RR1ERDlpwrMliLeozQg+vQBpqROfpAEEQwtUtx/QuSXMA1wJCbKqPUo3wBQgIs2esS
	 5Ib/KAVCIsr96eYedYDOltr8xIYe3ry+T2XH6Q7nrYGpPw+PRpNXvVsNAWTict8O/M
	 hIai2LG4iSYRMBe+CmKO6ulvJpsXB+Xguy0IubJo8BFUduLrKwLf1PxlXQgOUfde4C
	 +ZkuE5FyPXfTg==
Date: Tue, 1 Sep 2026 04:14:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260901041408.06d3f7ac@jic23-huawei>
In-Reply-To: <20260831-singer-reimburse-defba31848bc@spud>
References: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
	<20260829-iio-ad5710r-upstream-v4-2-8af3121c7d21@analog.com>
	<20260831-singer-reimburse-defba31848bc@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Conor,

> > +  adi,range-double:
> > +    description:
> > +      Configure the output range for all channels. If the property is present,
> > +      the output will range from 0V to 2 x Vref. If the property is not present,
> > +      the output will range from 0V to Vref.  
> 
> What was the rationale provided for this not being a userspace control?
> 
Jumping in as I happen to read this...

For DACs we often do it in kernel as potentially there is a circuit dependent aspect.
In extreme case leading to the bad kind of smoke. Normally it is covered by an
output-range pair, but can't do that here as it is relative to vref (which
we have no way of knowing in the binding). 

For input devices it is always a userspace thing to control.

> > +    type: boolean
