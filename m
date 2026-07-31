Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847442F6ED;
	Fri, 31 Jul 2026 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509017; cv=none; b=NFg812UcGzMAySrDUsO22Plzve1MpIRKEgfg4u47WuBayj8yfB6h6PpseGk/88jXwYrCI6r+go93w8Bw4pLrJbYGT4RbnxdvNExdqgZ4DZkrozTY2v07dOGdIAvZsdo0vahXZlfEVjIdGnVcUcnkKJWhOz+WkZMcM7MZFB/AmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509017; c=relaxed/simple;
	bh=KS1e1a+U+sb99UzCmbBACw9ymiMSvnKnefigVOuL5IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou9Lbbu8VKT1uMmOwGd1Q8DlZG7nCZC6jYflPqu/JPFfz5K7grn8QvdAYcwrzuErNz3nf3xcocDk8HV4pXkp0U7iWxt9a7qxEFCg0fmDa9LWIb4Vv3ObAMtjGXFhUNOpdY2m72HTn/Q98ciVCFcdTlNz7UeP2Kjy2Gp6JnFeX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlY9V6Z6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlY9V6Z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722C01F00A3A;
	Fri, 31 Jul 2026 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785509015;
	bh=GNY36rin3dwLur+0LRzxKLX3kZHncZvjakN/xZMe7+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YlY9V6Z6kU1oDHrFwCbqNs5bVFZkOKRc5FU8HOVMEQz47vfb2XZ/Dx2ZHik8o5VJC
	 U+TpIt/MiJHYMnhSKHK/rATf6ZGsO87Wfm86Dw1Tk42/Dlm3aASAYP0FERPL98OOUs
	 fI8HiF1AD8GsHmwAklfoyFjydG43UJ5b+8P1Gh7Ma0hN9XZypyfmORKpIfvez2M6AY
	 xxtIIT/I9fTkgW2o6EU1hE2PTI0NRWhGXE6YZquWg1cT0LQDXXbBTTB3PGAFoKVDYl
	 MrDeXGL2fYMPfWFYJDIDnghs4O/Z56haE4GrzTg/4GG6N/VnR8SEAa8Em74w2/kSV1
	 +ZNKw1+nHusAg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wpoST-00000000XdU-17IA;
	Fri, 31 Jul 2026 16:43:33 +0200
Date: Fri, 31 Jul 2026 16:43:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Message-ID: <amy0lU289vvQzslO@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-5-clamor95@gmail.com>
 <akeF_VrijPbebz3I@hovoldconsulting.com>
 <CAPVz0n1+wrq+g3p3UTc3hzHcsz8k02=QsvmseBD45d+SoSFsBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1+wrq+g3p3UTc3hzHcsz8k02=QsvmseBD45d+SoSFsBw@mail.gmail.com>

On Tue, Jul 14, 2026 at 04:28:24PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:50 Johan Hovold <johan@kernel.org> пише:
> >
> > On Wed, Jun 17, 2026 at 11:00:21AM +0300, Svyatoslav Ryhel wrote:
> > > Instead of passing the entire lm3533 core data structure, only pass the
> > > regmap and the light sensor presence flag to child devices.
> >
> > Again, why?
> >
> 
> Because none of the child cells needs entire parents private
> structure, regmap is all that is used.

Just because you can do something doesn't necessarily mean you should.

Johan
