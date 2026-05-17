Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3A3624B2;
	Sun, 17 May 2026 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023348; cv=none; b=rCOX1GrVb0h+IVjQ3su5LUXTj2o/jVXyLRj7JeoL27Esyt1Az5h92icGntnu41vCHIs+LCeiW3Kb26C4UQK1SkyFARsyS6kiELyy3xHxfG/EPKmVl339l6HgxVGniKR72ud6P7BkcQu5FtojbSX+T8fN3xZCBGl1Wp2t6VS03SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023348; c=relaxed/simple;
	bh=iz4EDq1G8o3X/r7ZNxnLgdF6x/MLHpXvs0W0iysATWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGJo24Pa7mHLv7zyf65NlMDRowNjiX9yUH38qb6iNUYxfQGLZOLsgG1a1WDMsChGdk04E7/xLMNmdcYIoWeKp+Qb+dSz6Z0YiVmhh0D+aT72RAuEU/h4xFfJH3j3fxpjv/bm4WlVDeQhftC8U7cjfIEdaS+wQMTcH4jC0xBuU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLqONTMN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLqONTMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DADC2BCB0;
	Sun, 17 May 2026 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779023347;
	bh=iz4EDq1G8o3X/r7ZNxnLgdF6x/MLHpXvs0W0iysATWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLqONTMNEpA23ymzW7NtSpB88pUx4ec2BHgkbFTji8LHoNhbmCzzYxLAA+yD17Ozq
	 W/hjjYWjawGHb4nGRYiifezD56o3weEG5vCXQ3JdjplHoKq4efe8M0jDCCaN2gXs43
	 XJOdnitCqQsa4ATkzD3SH3Ixns6k+l8i43lXZLJt+Dl2NSd1CNw4DkdqwB1ILkcnPg
	 beub+wkgc61TBeQiSTKcY+lCzVjEK0rUGI02SP1wsb5PcTnkIFIibx5yWc/dLJ4kwA
	 9/wyrwzWtm7Xs2Q6b9Xh26TQybhawGXBbiwXQdD6dpAanFuZUeqtGxATmBInW1tDGR
	 LXZhIUDW9jFHQ==
Date: Sun, 17 May 2026 14:08:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: veml3328: add devicetree binding for
 new sensor
Message-ID: <20260517140858.7db0edcb@jic23-huawei>
In-Reply-To: <CALoEA-xQJ+JyJ0HHpNzed2NTXgnVnP14yVb0FHVCG=tC=DuuqA@mail.gmail.com>
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
	<20260516-veml3328-v1-1-1d4b663e2fe3@gmail.com>
	<4d1d9af9-af4d-4cb9-bcc6-e70d7640b98d@kernel.org>
	<CALoEA-xQJ+JyJ0HHpNzed2NTXgnVnP14yVb0FHVCG=tC=DuuqA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 12:38:40 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 17 May 2026 at 10:38, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On 16/05/2026 23:50, Joshua Crofts wrote:  
> > > Add devicetree binding for the Vishay VEML3328 RGB/IR light sensor
> > > connected via I2C (SMBus compatible).  
> >
> > Please use subject prefixes matching the subsystem. You can get them for
> > example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> > your patch is touching. For bindings, the preferred subjects are
> > explained here:
> > https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> >
> > And then:
> > drop second/last, redundant "devicetree binding for new". The
> > "dt-bindings" prefix is already stating that these are bindings.
> > See also:
> > https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> >  
> > >
> > > Additionally, add an entry in MAINTAINERS.  
> >
> > Drop, no need to describe what you did. We see that in the diff.
> >  
> > >
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > ---  
> >
> > ...
> >
> >  
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        light-sensor@10 {
> > > +            compatible = "vishay,veml3328";
> > > +            reg = <0x10>;
> > > +            vdd-supply = <&vcc_3v3>;
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index d6c3c7d22403..134690aa9866 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -28386,6 +28386,12 @@ S:   Maintained
> > >  F:   Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> > >  F:   drivers/iio/light/veml3235.c
> > >
> > > +VISHAY VEML3328 RGB IR LIGHT SENSOR DRIVER
> > > +M:   Joshua Crofts <joshua.crofts1@gmail.com>
> > > +S:   Maintained
> > > +F:   Documentation/devicetree/bindings/iio/light/vishay,veml3328.yaml
> > > +F:   drivers/iio/light/veml3328.c  
> >
> > There is no such file at this point.  
> 
> Thanks for the review, will address these in v2.
> 
Hi Joshua,

One process thing - don't reply to say you'll address everything.
Just put your thanks under the --- for instance in the change log for v2.

A reply like this is just noise that several people need to open and
scroll down to see if discussion needs to continue!

Note this is one of my most common bits of feedback to contributors who
are moving on to more significant contributions!

Jonathan


