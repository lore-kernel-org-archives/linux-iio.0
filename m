Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF033122A;
	Sun, 19 Apr 2026 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776577572; cv=none; b=Lu7Vod3+cnHUPbLnB195dsFVp8a+kszA2bf+DZdFs2ooUXQdZxeZT1gHK2X9w21Og8neyNjXUu/gHe6W+BLZH70uslUvnnry3jlg0XsL0yknWJDpaZFnZAvSIzUR0lxWHu47SnYBJ5i3A9HUIqiIsh3MUV6J2WkD/Yo+e5Z5O4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776577572; c=relaxed/simple;
	bh=eSqbLHhgHh/ZJRww73fcoSmu95b67ftPVA72Xee322E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieTZvlbhKe6KTKvsXP4/j+qNDEEweMfxSQ/L/I8Uo5t8SPUCcM7Qkqsusrd2f17Lw6pfvhSBJl/AH1wcV7mXqag0wtqkKeZBed3zHgncR/mBxbdeYaDnJn1eI/Ej9rNg25WEZnp6/uY8QxH+U5ev1ah8dAfm4nfWN5qqHLxiopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=H4wCScQD; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="H4wCScQD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=o+V0Ka/TX2zNmL71sdJ1/xjziRZ4oqntm65AuSQ+qyA=; b=H4wCScQDFecegr7zhqMDh7rTw+
	uJrMjiNkBfZUmRq1PLDEqOqF0lw9IXFGFc1agGATmGGzWhJq90QmtJA+OJOQt+0kTmcR443DbeENu
	JMzK0cMIusqus2Gk62jwQJWc2stOPcJX6aATYyij3r38dsRVzU42lGmd1y509ATBAUXaPAHWCldjr
	zeTpXpbpfYlWu8CSonRFsfw6EUmWB8fzNUPUV0vAtLFepA9kLnpvcP/YrgopJVyghINiK4v2Cn4TR
	ldvXj7pu7JwXn/BkLYwtGxTOJtVxeEDwMrMLRgh5VoVkX9E497VBW8xEu6e2tfhchVEmmFsH+Eh6P
	tyqncSMA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1wEKXY-00019T-1h;
	Sun, 19 Apr 2026 07:17:52 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1wEKXY-000DUY-0z;
	Sun, 19 Apr 2026 07:17:52 +0200
Date: Sun, 19 Apr 2026 07:17:50 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: avia-hx711: add
 avia,hx710b compatible
Message-ID: <aeRlftUuHrTgz9OF@mail.your-server.de>
References: <20260418170549.312446-1-piyushpatle228@gmail.com>
 <23a00548-feac-4ce6-9a71-509b7636b372@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a00548-feac-4ce6-9a71-509b7636b372@baylibre.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27975/Sat Apr 18 08:26:10 2026)

Hi,

David Lechner <dlechner@baylibre.com> schrieb am Sa, 18. Apr 16:46:
> On 4/18/26 12:05 PM, Piyush Patle wrote:

[...]

> >  
> >    Specifications about the driver can be found at:
> >    http://www.aviaic.com/ENProducts.aspx
> > @@ -23,11 +33,12 @@ properties:
> >    compatible:
> >      enum:
> >        - avia,hx711
> > +      - avia,hx710b
> >  
> >    sck-gpios:
> >      description:
> >        Definition of the GPIO for the clock (output). In the datasheet it is
> > -      named PD_SCK
> > +      named PD_SCK.
> 
> Save the cleanups for a separate patch to keep the adding HX710B changes clear.
> 
> I'm guessing the existing binding for HX711 is quite old because it is quite
> incomplete.
> 
> It has avdd-supply, but is missing vsup-supply and dvdd-supply.
> 
> It should probably also have a way to describe how the rate pin is wired.
> 
> And it should have a clocks property instead of clock-frequency.

The real meaning is a wait time until the DOUT is stable. As a submitted the
driver many years ago my suggestion of a wait time property was not accepted
because it would have introduced a new property which didn't exit in those days.
The suggestion was to name it clock-frequency because it already existed. This
clock-frequency made the driver also a little bit more complicated because at
the end we needed a waiting time and not a frequency.

Today i see there is as "wait-delay" property already introduced at other
bindings. This would also simplify the driver a bit.

@robh@kernel.org, @krzk+dt@kernel.org, @conor+dt@kernel.org:
Would this change in the binding be acceptable?

If yes, i could prepare a driver and binding patch separate of this patchset to
clean it up.

> It would make sense to have two clocks, on for XI/XO and one for PD_SCK.
> The second one being optional because of sck-gpios.
> 
> HX710B has many fewer pins, so we will need an:
> 
> allOf:
>   - if:
>       properties:
> 	compatible:
> 	  const: avia,hx710b
> 
> section that sets anything for pins that chip doesn't have to false, like
> vsup-supply.
> 
> HX710B also has a vref-supply that HX711 doesn't have. (Unless these are the
> same thing by a different name?)
> 
> 
> >      maxItems: 1
> >  
> >    dout-gpios:
> > @@ -43,6 +54,9 @@ properties:
> >        Definition of the regulator used as analog supply
> >  
> >    clock-frequency:
> > +    description:
> > +      Bit-bang clock frequency on PD_SCK. Keep the PD_SCK high time below
> > +      the chip power-down threshold.
> 
> I suspect that this was meant to be the crystal frequency (XI/XO), not PD_SCK
> since sck-gpios already exists for PD_SCK

see above

[...]

Best regards,

Andreas

-- 

