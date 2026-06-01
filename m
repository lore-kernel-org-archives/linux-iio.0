Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486536A036;
	Mon,  1 Jun 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306883; cv=none; b=jTAPPRHepq4s+h+Fy3ebY2RIqFcLNnmUxX6fRc1nYdrSQ+sLt8CpTRVgDUKhnLXEQTY3IjQfsVRgym675fAeazzvlq/fk+QqviH77ydh6uCaCVbfewp8uBy7YjkTzVJRqecndLclU22+3ZvV6XRr0L+u0WTyTSJ9H+5GsUQ05Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306883; c=relaxed/simple;
	bh=5GrrB4F528V9ouBOXTXg8FaUpWrvbwejN2f+K4aSIyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwWJet267WLg1DapVfAN99WcopczMzbsChOXk0Lr8hUdN8g9cFOo64tC7GJZE+7zWpA8vnJjd0AbrL4a7hE6+xmMGqWNco48As2yfdW6zL2xyzXFoKTqFs7gR/qoPt719Zv1FTTe/StJHSbrSHmIseRNl0JSyJbJUSpMcZUj86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hahJjLUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hahJjLUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5731F00893;
	Mon,  1 Jun 2026 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780306882;
	bh=p0qb6j3OuOG1ECo2q3SnL3hsyYw384KOW0Q7gS9kVps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hahJjLUFZ5laOq9AKDSHupBXVey7pPoCCqcK9SydOrSoceOgiSKHJXwGjqOXDmHEv
	 ZknaoUx76vm9wouFzx1lruxmKGsrh4qBD0qN2pybjkQbkNSJ8AQebQ5Jp4U6EMmK9K
	 louhYPVad/DjgEpB/E689jUX7XtMU8aiNANjwSHFVrqjwLlgJ/72VXs+C/MTwNIrow
	 AC1d3nQdSA4F2yhc3oWr7+qk3NiJ5OPyKoNaJWdZO79zWKpO18WgPt+xOCpPkH8Bd5
	 GTBdgCj5W97kTn3vOaTTF9rujOTfXhqCugAEPtApZwjKUUOHCI5xF4NIN7owGT8oTn
	 ayJUb/AP7OfIQ==
Date: Mon, 1 Jun 2026 10:41:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Wadim Mueller <wafgo01@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxwell Doose <m32285159@gmail.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260601104113.77f47c58@jic23-huawei>
In-Reply-To: <ahzWI-bQwnQ8ogFL@debian-BULLSEYE-live-builder-AMD64>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-4-wafgo01@gmail.com>
	<ahzWI-bQwnQ8ogFL@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Just picking one thing to add to from the set of good points from Marcelo.

> ...
> > +static const struct iio_chan_spec_ext_info slf3s_ext_info[] = {
> > +	IIO_ENUM("medium", IIO_SHARED_BY_TYPE, &slf3s_medium_enum),
> > +	IIO_ENUM_AVAILABLE("medium", IIO_SHARED_BY_TYPE, &slf3s_medium_enum),  
> We should probably document the new 'medium' ABI.
> For consolidated ABI, we document it in Documentation/ABI/testing/sysfs-bus-iio.
> Since this is new stuf, maybe start with a separate ABI doc
> (e.g. Documentation/ABI/testing/sysfs-bus-iio-slf3s) ?

Definitely needs docs but maybe go one up sysfs-bus-iio-flow.
This is intended to be a generic ABI but one specific to flow sensors.


> 
> > +	{ }
> > +};  
> 
> With best regards,
> Marcelo

