Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF029D291;
	Sun, 18 Oct 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792346185; cv=none; b=Ay0SBNSmt3OEuKl4B88giKgBkRbFxxYxUxD2D4D7snnBS8lZHDP0O0iXoTemdl+nY58eLeMn8GkyzAceFfzGyXBqXjnn/ozyiMsci8OnoAPHPZeUvLVOJLzgLDhSxgcFwQzYLAcFmtN3TnOP6XvEnl44299uZpjKGZHvZrDUTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792346185; c=relaxed/simple;
	bh=7IgQgvCYxNvVaE+ueZonl8NCpJ9gvuDv8VYcY2+iM9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZH4PUUz+8g1NP/P+pKcQ6ft1LB8qCe/Ua8D6XJp15uUcEaBr7Il53JIFQW5kYANo6cEcbUYHWJ9CPsHEnqiVFM4DzaKiqBwQOJjdsdLYlUkZSV+XZ32acs4ShhMKrv1CdNByWSfZxYu482kW2qyqEJTgyiLUNyX1qKxcpSbeTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2PiBFOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2PiBFOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0A71F000C4;
	Sun, 18 Oct 2026 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792346184;
	bh=liB8BgC1Ml46m5qJ2Km0vMLjnxc3Pun60AgSOQRsiBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m2PiBFOKh3/PBfkF09d5G2Pwrq2k/hNmmokceGySQIEf70CsesetjNFDxkLk+w9hR
	 hu8j0pugh6irna+V40Dhr1NAeECfOrC0YtW8Dr+2iPWkHHvglwsywMy+HNz6MTQ92t
	 Y4o5uCiPCdEeOatLDZFikNOtuhZiRy74n97SFe2Ty0eFJFor8S564Y5Sip3sbxZcQT
	 yG04jSBwIXkOfWiJ0rNPYbcatwzm9CBpg0rqQVYFPIVzTzya1dRjNnOSEOBeOsHbkT
	 aJRjs8TL7+7xhp/SPRvrMj/0n19BVMn7CMc5Qp7hYLzzpEJ6SYXwh61MnEyT/fFp0M
	 WaacBoD5v00bQ==
Date: Sun, 18 Oct 2026 18:56:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "chr[]" <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: gp2ap002: add led power supply
Message-ID: <20261018185619.2aa694da@jic23-hlaptop>
In-Reply-To: <d06d51cf-a53d-4bef-881e-cdcb4925a316@rudorff.com>
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
	<20261017-iio-light-gp2ap002-v2-2-d6879767a446@rudorff.com>
	<20261017190006.224b73e7@jic23-hlaptop>
	<d06d51cf-a53d-4bef-881e-cdcb4925a316@rudorff.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 16:41:48 +0200
"chr[]" <chris@rudorff.com> wrote:

> Hi,
> 
> In preparation of v3:
> 
> Am 17.10.26 um 20:00 schrieb Jonathan Cameron:
> > On Sat, 17 Oct 2026 19:27:42 +0200
> > Christoph Rudorff <chris@rudorff.com> wrote:
> >   
> >>   	/* VIO should be between 1.65V and VDD */
> >> -	ret = regulator_get_voltage(gp2ap002->vdd);
> >> +	ret = regulator_get_voltage(gp2ap002->supplies[SUPPLY_VDD].consumer);  
> > 
> > Ah. I'd failed to register the voltages were being manually set (generally
> > we leave that to firmware in more modern drivers).
> > That rather reduces the advantage in using bulk regulators.  Probably
> > still just about worth doing.
> >  
> 
> Yes, this is why I didn't made it in v1.
> 
> >   
> >>   	if (ret < 0) {
> >>   		dev_err(dev, "failed to get VDD voltage\n");
> >>   		return ret;
> >>   	}
> >> -	ret = regulator_set_voltage(gp2ap002->vio, 1650000, ret);
> >> +	ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VIO].consumer, 1650000, ret);
> >>   	if (ret) {
> >>   		dev_err(dev, "failed to set VIO voltage\n");
> >>   		return ret;
> >>   	}
> >> +	/* LED voltage 2.4V .. 3.6V according to datasheet */
> >> +	/* We need to check this, as dummy or fixed controllers trigger an error. */  
> > I'd make that a multiline comment and say what 'this' is.
> > 	/*
> > 	 * LED voltage 2.4V .. 3.6V according to datasheet
> > 	 * We need to check control is supported, as controlling dummy or fixed
> > 	 * controllers results in an error.
> > 	 */
> > 
> > Do you actually need to control this for your board?  I'm not that
> > keen to replicate the controlling of voltages if we don't have
> > to.  We can't drop existing code as maybe a board is relying on it
> > but we can avoid adding new examples!
> >   
> 
> So we don't want to drop all the set_voltage code in general.
> My board does not need that at all, all voltages are already set
> to valid values in DT, ... I hope ... I check downstream ...
Unfortunately it would be a bit of a gamble to remove the in
driver voltage control on existing supplies. Given it works
for yours though let us not do it for the new one! 
> 
> So I skip the "example" for set_voltage(vled)?!

Exactly.

Jonathan

> 
> And thanks for the advice to pretty up the code!
> 
> chr[]
> 
> >> @@ -632,9 +650,8 @@ static void gp2ap002_remove(struct i2c_client 
> *client)>>   	pm_runtime_get_sync(dev);
> >>   	pm_runtime_put_noidle(dev);
> >>   	pm_runtime_disable(dev);
> >> +	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);  
> > 
> > Why at that point in sequence?  You are turning the power off
> > before removing the userspace interfaces which seems unlikely to
> > be race free. More generally it is no longer reverse of probe
> > order. If that is necessary for some reason I'd expect a comment
> > to say why.
> >  
> 
> Sorry, just a stupid mistake.
> 
> >>   	iio_device_unregister(indio_dev);
> >> -	regulator_disable(gp2ap002->vio);
> >> -	regulator_disable(gp2ap002->vdd);
> >>   }  
> > 
> >   
> 

