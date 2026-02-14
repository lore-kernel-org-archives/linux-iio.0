Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921D26A1B9;
	Sat, 14 Feb 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771080303; cv=none; b=bFVk7cRY2cou3H4SMbA28NfmYn3KQs8bh1pn0eOW9Q3TSL0gXIRNJZwzPq1Y0pxRXU+vDk1hdygIJ+6UMCY9SSqTeGuOOILIZWHK8nFc9C3ztY4HG0Iqr7JQWw4AbMrABlb0cIaJbgAHpRADiZtKtgIXPFwFKOrHX6ostw387T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771080303; c=relaxed/simple;
	bh=CF/5eeY/NhfYqnkk8kJ44dO3asGUtj6TD0iFxk+uyWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=js8FXHy0fugqZAyTU7hXnrG3s21585XKyyNuuW9jNZrUdvf0+RtZWGEJ5mz2TfUduhEGtK02G7z2wcECgNmhnl6rJKCyNne0laZHBbMtMt0U/TeeHTfhkpteOvKYDf1eMzNU7RBJLew6c9DOucMR/i0lGdn4qqYRE6MBSiyuYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5KxUf0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5KxUf0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7483C16AAE;
	Sat, 14 Feb 2026 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771080303;
	bh=CF/5eeY/NhfYqnkk8kJ44dO3asGUtj6TD0iFxk+uyWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A5KxUf0ML4z3JkNGrRcVZ41xkM5ipCBbT2GgmGVESB/UuXAeNiIM2abnqpZdr1J4c
	 71OVZztJcJAUe1tLxdhr9dw5lSrgtFnB86SkPznK1RX7bTNUly7RJ3fHUNJZWvwQZf
	 21PSowU4duZwGXDVsdkr2Of9FtZhjRkAtuIcO87KeNCxNBwtYxKBhKb1TntykoZfX9
	 0OrYIvqyftE9iVv6qDgkHFtvtc8pea6SvY9JuPpSTL2LPxh7wIOycp2Ht+pWJhFW7Q
	 3xGrsg2dhZOHCPMEmZZYIOrZR9DWpfjSwhIw5t/dEBn2M8klutGuYeCk1Q/aHjDOff
	 1DQ7RO/w3yUtA==
Date: Sat, 14 Feb 2026 14:44:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 8/8] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Message-ID: <20260214144453.349fc0a1@jic23-huawei>
In-Reply-To: <ecfpri6dr4kidvecyulzip7m2bmuw5refocls7vdtruqinrklc@dzm5vmk7ul5r>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
	<20260130-adf41513-iio-driver-v6-8-cf46239026bc@analog.com>
	<20260207172458.7f2cca90@jic23-huawei>
	<ecfpri6dr4kidvecyulzip7m2bmuw5refocls7vdtruqinrklc@dzm5vmk7ul5r>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 13:52:18 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/02/07 05:24PM, Jonathan Cameron wrote:
> > On Fri, 30 Jan 2026 10:06:49 +0000
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add ABI documentation file for PLL/DDS devices with frequency_resolution
> > > sysfs entry attribute used by ADF4350 and ADF41513.  
> 
> Here it mentions that this would also work for ADF4350.
> 
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio-frequency | 11 +++++++++++
> > >  MAINTAINERS                                       |  1 +
> > >  2 files changed, 12 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> > > new file mode 100644
> > > index 000000000000..1ce8ae578fd6
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> > > @@ -0,0 +1,11 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> > > +KernelVersion:	6.20
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Stores channel Y frequency resolution/channel spacing in Hz for PLL
> > > +		devices. The given value directly influences the operating mode when
> > > +		fractional-N synthesis is required, as it derives values for
> > > +		configurable modulus parameters used in the calculation of the output
> > > +		frequency. It is assumed that the algorithm that is used to compute
> > > +		the various dividers, is able to generate proper values for multiples
> > > +		of channel spacing.
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 0d9b7cf86aec..748eeb6f5bd2 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1639,6 +1639,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >  L:	linux-iio@vger.kernel.org
> > >  S:	Supported
> > >  W:	https://ez.analog.com/linux-software-drivers
> > > +F:	Documentation/ABI/testing/sysfs-bus-iio-frequency  
> > I wouldn't add this here. Whilst for now we only use the defined
> > ABI in this one driver, I'd not expect it to stay that way.
> > 
> > If we do think it is very drive specific move the file to
> > sysfs-bus-iio-frequency-adf41513  
> 
> The file Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> contains the same ABI description, should that be removed there
> in favor or this one? If so, in MAINTAINERS, what is the best place
> for this ABI file?

For sysfs ABI we can't have repeats in multiple files (it breaks the
docs generation IIRC).  So if we have it used in multiple drivers
then it needs to go in the more generic files as you have it.

For maintainers, either don't bother with an explicit entry  (the subsystem
ones will catch it) or add I suppose we could have one for
drivers/iio/frequency/ that calls out this specific file + all the drivers
in that directory.   I'm not sure that's worthwhile - so I'd go with just
not listing it (ignore the checkpatch warning).

Jonathan


> If not, for simplicity, I may just rename the file to
> sysfs-bus-iio-frequency-adf41513, as you suggested.
>  

