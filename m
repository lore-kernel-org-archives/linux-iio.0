Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD03ACF0F;
	Tue, 12 May 2026 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587698; cv=none; b=GD8GsVu0rUkzAk5tjp3yERNMG0ukhmABHn6ECla8GyS7G50Hd0y1jGHe1JEGAFmtJp3VIBX2QlY5s6e8toJ+g7OuRCD54NszruCdS6CLh4dHEFAAhM3pRdp6NMUHtyxiULmiThxKvHEKuzwE5HL9J2QwQTd+aUeJt4s+N+n45fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587698; c=relaxed/simple;
	bh=TAFsA+GYopwP739qiGnxIQALOcn8hUpFS3cE3fTrSKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auXRuzcHNp28B2pfgvnAL71OO4BR3Woby5O5mkCzAx4Jjr9XZCYX8y3z2/hjM7h4i/6mm+GNH1S7K6+E1pZkwCPrfR+9kgy906P79IzlqsoZ8qIhh8AJgU/1PyAH9tCP2QK79CtwNsqeTLXtdYOVvrEhryzvwx0m//mxXnFWyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1TId/7y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1TId/7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E67C2BCB0;
	Tue, 12 May 2026 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778587698;
	bh=TAFsA+GYopwP739qiGnxIQALOcn8hUpFS3cE3fTrSKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1TId/7yMn2ZOKKgpSsx40CcgMC8pW2zV9MFD0xKHy1yCG5NI/1l+HusTgdKY252U
	 qBNyQztaFzZoCctGShl89dwsNh0hfVrVQWXrDyYNqoZcqa2yAi0VSirTL9yXyzM0OI
	 cUUUWA8SpqEHAH/copdVB4oKCSWo73fUt64fw0zNN7gc9SX6FwhQz2NRanKXIpRVTV
	 lIEVn/v8tLges10htCJ5x9k3eK00aFeiAQqUH02ZoKP7Syvk1eEJmFa70G71hVnTNK
	 d0NwXN2ArrtF2CQJc9cgKZGoDVK+vZs4ip3fkGhyUzCKmqDwkHCoRCRHRY9HABDkiC
	 9kohE9NgihVNw==
Date: Tue, 12 May 2026 13:08:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 v8 02/11] dt-bindings: iio: adc: hx711: add VSUP
 supply property
Message-ID: <20260512130809.5ab5eb90@jic23-huawei>
In-Reply-To: <20260512130622.1f3f4d08@jic23-huawei>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
	<20260511174342.123820-3-piyushpatle228@gmail.com>
	<20260512130622.1f3f4d08@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 13:06:22 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 11 May 2026 23:13:27 +0530
> Piyush Patle <piyushpatle228@gmail.com> wrote:
> 
> > Document the optional VSUP supply used by the HX711 on-chip regulator.
> > 
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---  
> 
> I got curious given the driver doesn't yet turn this on and wanted
> to just sanity check it via a datasheet.
> 
> Why are we including this one but not dvdd-supply?  The suggested
> wiring does connect them to the same supply but it's external to the
> chip so in theory they might not be.  Curiously dvdd supply is allowed
> to be 0.1 V lower than vsup-supply.

I should have said, given there is nothing wrong with what you have here
and the above is a possible additional change - applied to the testing
branch of iio.git.

Thanks,

Jonathan

> 
> >  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > index 1ea60dff98d5..a8eaa1f18de5 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > @@ -33,6 +33,10 @@ properties:
> >      description:
> >        Analog supply voltage (AVDD).
> >  
> > +  vsup-supply:
> > +    description:
> > +      Supply voltage for the on-chip regulator (VSUP).
> > +
> >    clock-frequency:
> >      description:
> >        Controls the SCK bit-bang timing. The value is used to derive the  
> 

