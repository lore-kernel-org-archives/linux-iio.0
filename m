Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795305177;
	b=JhsuPUbHVFc2X8SNfLhpVb7Y45Trz/NLAf+BjC8X1Jj7gf0Lmv6dWkc6MRs6EnnrJf5S
	 zfVUc8dJVI03hYnjaXYVS1cjviL5cr1qlEJ24GH+P+1IHlGoTEdOnrEnza+8EY3dbBrrj
	 Z3uP87/RwhplZTbjhrjzNaBjGbVUm/4jZqwiQwU+jZUr7fN3ZXOz1Ek0oMCbvw/G9lxhZ
	 1DvW7Q5D2JxAlKt/BQipwVs1ZodJvHIWxHoDZ1HQv6XM3Dwop35y+nRhyjEXmCPnBSAOG
	 QB9agCn2WkSkty42ku56odrVPCzlE4YDR+MSqZsDNzrIUuw9XpgLYGZ4scab1neF1lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795305177;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ECBQLhta0sOXFGAAjDcnFO3Djbr/wpG4e+ULm3xvdeE=;
	b=z6lVjPFwY4pWlb0V5qDVAMx+Ob2uqTgNRHxBvDIbMnl9QVUKCcWEEnmFvpaJYTotXyF4
	 65oVvnmDok4stDNSCz+bjuc4XUMjxC+NRGZsd8cIeHPRIk/X0n41bJFtSeovyquwYx27r
	 IPMkTrXkdtnmZ6iAT+quqj4w9OwD8OLE8ajI2oh3y/dvUyAx68wbtCjrcHT0cOYzJOSqU
	 dcQGthugBxSyzNwPinBlr68CGvKgLLj9Jv+Lmv1bDLt1WXvgu8AWeN9jRb9tNqzYHJKzB
	 JiRALxm9KpEjuqIX8025390LBjHatJBAstpt/dAPD4bT5VUqLStebGXsf1aZE3Y+Myw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNKpc+OU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F20606A320;
	Sat, 21 Nov 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNKpc+OU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E8F1F000C0;
	Sat, 21 Nov 2026 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795305176;
	bh=ECBQLhta0sOXFGAAjDcnFO3Djbr/wpG4e+ULm3xvdeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bNKpc+OUvRf7zON9rOWnjHBawK1EjuyLN0PgVEqtqeVVcWBpG1o4OkxKH/kRu40Ul
	 QyGqqUdmR1HS8vtK2E+mfpbeaxf/qy9nz7XtY8D4CBSde0YtQVmjtnhUnlUSd7PASp
	 cFOjKVkqCd22LDWXNqdtLYHKgMADi2tkm99wWhFi//qCGMX4j55RFinhBbmiJYbnIu
	 e0fEIRd1WwMKE6B5N56UOV440PgTqYUTfSEdTUq+EAVqu2HUnDDdqPBRg4676LQkXG
	 4eCtgflxhNt7OHXJ5DQI7QGY8t89A4LVM1BWEQ8GuOIW7k8cZ6AW08Dpq5DR1B90XU
	 bjc8CtgkkvoQg==
Date: Sat, 21 Nov 2026 23:52:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Joshua Crofts <crofts@kernel.org>, Roman Vivchar via B4 Relay
 <devnull+rva333.protonmail.com@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: light: stk3310: add vdd regulator support
Message-ID: <20261121235247.70fc8288@jic23-hlaptop>
In-Reply-To: <e-R4fXmiyMiZY43j027FJGyFhtgfke6qdOAsLOTr7VMAfx8pL5sjDimH44WdZ0tIvoxgb3-ZPWWbZb5DE8gMloPynRLs2ztiBLezfyijQg0=@protonmail.com>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
	<20261117-6768-stk3337-v2-3-92f4c7be3bc6@protonmail.com>
	<20261118110138.000003ab@kernel.org>
	<20261119033238.39bff7a7@jic23-hlaptop>
	<e-R4fXmiyMiZY43j027FJGyFhtgfke6qdOAsLOTr7VMAfx8pL5sjDimH44WdZ0tIvoxgb3-ZPWWbZb5DE8gMloPynRLs2ztiBLezfyijQg0=@protonmail.com>
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

On Thu, 19 Nov 2026 16:33:21 +0000
Roman Vivchar <rva333@protonmail.com> wrote:

> Hi Jonathan, Joshua,
> 
> On Thursday, November 19th, 2026 at 5:32 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed, 18 Nov 2026 11:01:38 +0100
> > Joshua Crofts <crofts@kernel.org> wrote:
> >   
> > > On Tue, 17 Nov 2026 20:08:37 +0200
> > > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:
> > >  
> > > > @@ -745,6 +746,10 @@ static int stk3310_probe(struct i2c_client *client)
> > > >  	device_property_read_u32(&client->dev, "proximity-near-level",
> > > >  				 &data->ps_near_level);
> > > >
> > > > +	ret = devm_regulator_get_enable(dev, "vdd");
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "failed to get vdd supply\n");
> > > > +  
> > >
> > > IMO this should work, but I don't like the mixing of devm_* and non-devm_*
> > > functions, this may cause issues down the road. Consider moving the driver
> > > to all devm_* functions?  
> > 
> > In this particular case I agree with you because the conversion is very
> > simple.  Generally the rule of thumb is that devm from start of probe
> > until you decide to stop, then no more devm.  In that case the unwind
> > order should be correct.  This change doesn't break that, but the
> > driver already breaks this wrt to the interrupt, so if Roman
> > doesn't mind would be great to fix it whilst touching the driver.
> >   
> 
> Sure, I will include one more patch for devm_* API migration before
> adding regulator and new chip support.
> 
> I recently found another STK3337 variant on yet another development device,
> called STK3331. It seems to be exactly the same, except for the chip ID.
> Should I include it in the next revision, or send it as a separate series
> later?
Entirely up to you!  If the change is small can certainly be an addition
to this series.

> 
> Best regards,
> Roman

