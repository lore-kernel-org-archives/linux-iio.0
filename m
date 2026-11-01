Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575638;
	b=hKIKHs0Uvx10/Z5+/t05aMl+RCECo8zVuBV4Lxew6rYSnzgcg6BDg0gjuK1ZGEwyn9Tn
	 xwPFYeH2W0YbOnAIE0ACDcQ+eQHVRDwzsoLyVZGBXgZaYDIxxkAOTJg+eKhR21bAmyFAX
	 RXXvJsDRFW5f75uQNPHDBMHJ5I33pWjxuq/6TEK52NGUKzWSPVOGvacHO0Qpf8QLVjtr1
	 mav6tpQHSzJ7ySEaVSZa4vcUv8aCGh+/sLQPiKTVVeGEqGMJXbTCUn7FfhskJqAOkNg9q
	 IOUzp4KFYohSTH38eF0GMtif3/iJhIT0TGcZypUeFtrMJrFCG4f0yIVEE63OcOmYZ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575638;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cm3uXWgrh+92bQkz7qUT8W8VdHKB20HvDylJRJySF3o=;
	b=lHCJgyo4QkYmvPLzgtPrFB7WqyVYz4IxqU/WjkPgeqVnZGP2hWkOqgYY/Nb8XeRxG/0C
	 6tvSV1H22EV2qn5XlIxqErtxU7U2d5ZhnR46y6SgCZS7UmtPto85ROdQTkYE0iPEfV09N
	 5xkWQRAbBbyzI9a0wNcMvsJHT/iLadP+6aJebl6KuDUaUNk2OmYuGVR+SiJsC/dkMqOMm
	 evPWX8uE8EIBANDWlLWCd+1pv1KDR6rbnrEvBTTYiWFfJm49ZskjLOsxo3kW8miEhCxId
	 1lzW2CawHOeJtt2clWBILTaV/tlz2uNK4QjFoLB0sdsv0FFax4HwlHQEzBbjHmqO7Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jvo7KyGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0DC606A334;
	Sun,  1 Nov 2026 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jvo7KyGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1FC1F00A15;
	Sun,  1 Nov 2026 23:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793575637;
	bh=Cm3uXWgrh+92bQkz7qUT8W8VdHKB20HvDylJRJySF3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jvo7KyGDT+AEXA8d5RM/RWgHWIlzVEloK5ubaBai/CVET2r75W4/riaahHjEUPjPS
	 VQqC+vqnNwUuRcQjcdDW/bzGtQaGgQ9HrgZ2JdIaKYHJpVUL0S1ob1W80456/4vydp
	 qrn7gSKcdZx75mjK/qPzlqOvLWuruIzH0TGuodEukzr0rxmeVcaHm5z1gvGzI0PCX8
	 H+XQoybSAa9LLyB1IPdEPVLHOY0Qc4woQANA023Qn1ggaGpX8D6ZZrbdK/MI+ckDe6
	 kffjeABhiHeHKn9Qm1F7UWRJKoZ6eDeXTKWl9msNCkLTZCqxjvR6jIRk9z9+0CLe2v
	 XQ8MdEv3XeFgQ==
Date: Sun, 1 Nov 2026 23:27:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Jonathan Santos
 <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux@analog.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com,
 andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 1/9] spi: dt-bindings: Add spi-cs-composite property
Message-ID: <20261101232707.4c08cc7a@jic23-hlaptop>
In-Reply-To: <auWIqpIaegH+AWV4@JSANTO12-L01.ad.analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
	<e9308680e7b45ecf9ef2b6b2a752ffdd4d23b80c.1792435248.git.Jonathan.Santos@analog.com>
	<20261026020003.3f3fbe86@jic23-hlaptop>
	<20261027-colonize-primer-f994b88171a6@spud>
	<auWIqpIaegH+AWV4@JSANTO12-L01.ad.analog.com>
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

On Sat, 31 Oct 2026 03:20:26 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 10/27, Conor Dooley wrote:
> > On Mon, Oct 26, 2026 at 02:00:03AM +0000, Jonathan Cameron wrote:  
> > > On Tue, 20 Oct 2026 22:56:41 -0300
> > > Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> > >   
> > > > Some setups combine several SPI devices into one logical device, with
> > > > each chip on its own CS line. All of those CS lines must be asserted at
> > > > the same time, so that one transfer reaches every chip.
> > > > 
> > > > Add the 'spi-cs-composite' boolean property. When it is set, every chip
> > > > select listed in 'reg' is asserted together on each transfer.  
> > > 
> > > To me it feels inevitable that we will see a device / combination of
> > > devices that want groups of CS lines together and others independent.
> > > 
> > > Seems less likely we'll see more than one set of composite entrees.
> > > Maybe this should be an array of values that match with specific
> > > entrees in reg?
> > > 
> > > I'm not sure though.  Conor, Kryzsztof or Rob, any thoughts on this
> > > or similar things that have arisen elsewhere?  
> > 
> > Why does the property actually exist in the first place? Does the device
> > driver not know how each CS should be treated?
> >  
> 
> Hi Conor, Jonathan,
> 
> Thanks for the feedback.
> 
> The problem we are addressing now: today the SPI core gives a driver very 
> little control over chip selects. The main spi_device only drives the first
> 'reg' entry and the only way a driver can use the other CS lines is through
> ancillary devices, but for individual access only. For aggregated chips 
> (AD7768-1 in this case) we need all CS lines asserted at the same time, and 
> nothing in the core lets the driver ask for that AFAIK.
> 
> In v1 I added a CS mask to struct spi_transfer, but that also needed a
> lane mask to work, and after the feedback we agreed it was too flexible
> and too easy to get wrong. In v2 and v3 I switched to ancillary devices
> (each with a lane attached) for single-CS access. That covered
> individual access, but there was still no way to assert all the CS lines
> at once. The spi-cs-composite property in v4 was my way around that, 
> letting the main device be the aggregator and using the ancillaries for
> single access.
> 
> David also suggested two alternatives before that don't need any DT changes:
> 
>  a) Add a CS description to struct spi_transfer or spi_message, e.g.
>     passing the ancillary devices whose CS should be asserted. This also
>     allows dynamic CS selection within the main device. And since the
>     ancillary devices are already bound to a lane, this is less prone to
>     errors than the approach on v1.
> 
>  b) Add a new "composite" spi device, so a driver would have the main
>     device, ancillaries for individual access, and a composite device
>     for simultaneous access. The issue I saw is that the ancillary and
>     composite devices are siblings and their CS lines would conflict in
>     the core's CS check, so only one kind could exist for a given
>     device, not both (without some more complex logic in the spi cs check).
> 
> I like the (b) approach, but we would have to bypass that sibling problem.
> The (a) looks less harmful to existing projects, if everyone agrees I can
> implement it on v5. Also with (a) I think we can drop the spi device
> name for now (or not?).

I don't have a strong opinion on the way forward here.
Mark, any thoughts on what is going to work best long term for SPI?

I'm nervous that we might wall ourselves into a corner if not
careful about bindings. That is less of a concern for in kernel
interfaces which probably won't be that widely used.

Jonathan

> 
> Best regards,
> Jonathan Santos
> 
> > > 
> > > The most general case would (subject to it not working) smell like
> > > 
> > > reg = < <0x1 0x4 0x5> <0x2> >
> > > 
> > > Where intent is that 1 4 and 5 are meant to switch together and
> > > 2 is separate.  
> > 
> > I would expect that for this kind of device, the driver should know that
> > the first 3 CS are switched together and the 4th is not. I'm not really
> > sure what the internal representation should be, because if someone can
> > make a device like this, they could surely also make a device where (to
> > borrow your format) it behaves like
> > 
> > | reg = < <0x1 0x4> <0x5 0x2> >
> > 
> > and so on. But if those devices don't actually exist at the moment, and
> > everything is either all together or all seperate, the API for this
> > stuff in the SPI core doesn't have to solve that until a device actually
> > shows up.
> >   
> 
> Yes, this is a bit out of the scope and kind of complex.
> 
> > Worst case is something where there's a variable grouping of chip
> > selects, e.g.
> > 
> > | reg = < <0x1 0x4 0x5> <0x2> >
> > 
> > or
> > 
> > | reg = < <0x1 0x4> <0x2> >
> > 
> > but maybe if that happens the thing to do is permit reg-names for that
> > device, and again store the relationships in the driver rather than
> > try to convey it via DT.
> > 
> > Cheers,
> > Conor.
> >   
> > > 
> > > How to do lookup on something like this is another question.
> > > 
> > > Jonathan
> > > 
> > >   
> > > > 
> > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > ---
> > > > Changes in v4:
> > > > * New patch. This has been included because without an explicit property,
> > > >   every device with more than one 'reg' entry would have all its chip
> > > >   selects asserted together. That breaks devices that use ancillary
> > > >   devices for the extra CS lines, so the composite behavior is now opt-in.
> > > > ---
> > > >  .../devicetree/bindings/spi/spi-peripheral-props.yaml     | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > > index 4894196c8f9c..456cb9095632 100644
> > > > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > > @@ -60,6 +60,14 @@ properties:
> > > >        Delay in nanoseconds to be introduced by the controller after CS is
> > > >        de-asserted.
> > > >  
> > > > +  spi-cs-composite:
> > > > +    description: Some SPI devices can be aggregated into a single logical
> > > > +      device by asserting all their chip selects simultaneously. When this
> > > > +      property is present, all chip selects listed in the 'reg' property are
> > > > +      asserted together on every transfer, treating the group as one composite
> > > > +      device.
> > > > +    type: boolean
> > > > +
> > > >    spi-rx-bus-width:
> > > >      description:
> > > >        Bus width to the SPI bus used for read transfers.  
> > >   
> 
> 

