Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BD36D4FC;
	Fri, 25 Sep 2026 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790304611; cv=none; b=dT/GnAJJNx2Umie4sX7w36jSJSygrCvGbFTtYy2PgHkNxcYxxNV1gNr9Qi4kIGux/kgoo5/hy7zDkDBep09U/Jp0FeFvtGO7Mne8iWrBBJNd+u+Nxr+dubne5q2rQIssYfQl0VfVE36E8KbTnipUAori79iInPUPsDS0kUBc2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790304611; c=relaxed/simple;
	bh=5+LAXh2Zu0aIyyh/agNgYt+tnjG04U4Na5mf4RbKTRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrY3kRVq3/3TLAnV83iwME4cVnN9w+BMQ9cbFtM9mZHtIujiKIz4bhtUTZHrF3Oz+ofQXiGhDpsRIJMo6Rc535h8U35ousbL3wLCo++5Y72dCNPGZzji/S390+LaDBK5ZxHNGGw2lrUHod1gNeWiYumwm4dAWynnsM4xIjXvPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuMIhDwo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuMIhDwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C431F000FF;
	Fri, 25 Sep 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790304608;
	bh=YCJXK4j+WiQL4DwjbcZBi6O1Y4BXeNcg7/wSdJq+rh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NuMIhDwolUbtxKV360A2fsaezlxdrLNbKPlAAmf89Ixyu2BgXIw7QPVsYrCtFbYxs
	 ralDx1EidHMI4dfkOcGzw90JWnuR7rujcAbaHd3hBnRgx2q9zjouMX8Y+UpemVCmXM
	 XAMeVHlAR7UpS6qPhX5KCTKjm/hbQETNgJFvySf5lypeVTHLmPYyvHVkMP5Z4QGUZU
	 JlBVD/CbIyYPxHPYI3cu07ab4eqtH4oIzRx25umzRDXi9dH2mXGLI+9+rXozvOky/e
	 Oe1vUyLuodgy4GPmKfo9t0Rr3Jvknw4y85C/emabMvLg7n79gt/ZRcIXz3SXw9Csjm
	 T6iTADaMbvFjg==
Date: Fri, 25 Sep 2026 03:50:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Liviu Stan <liviu.stan@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: temperature: adi,ltc2983: Add ADT7604
 datasheet link
Message-ID: <20260925035005.469942b1@jic23-hlaptop>
In-Reply-To: <20260922165606.00002b73@gmail.com>
References: <20260922143950.176910-1-liviu.stan@analog.com>
	<20260922165606.00002b73@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:56:06 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 22 Sep 2026 17:39:49 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
> 
> > Add the ADT7604 datasheet URL to the binding description alongside the
> > existing LTC2983/LTC2984/LTC2986/LTM2985 datasheet links.
> > 
> > Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> > ---
> >  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml         | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > index 13e5f29f0588..09b809f01550 100644
> > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > @@ -17,6 +17,7 @@ description: |
> >      - LTC2986
> >      - LTM2985
> >  
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/adt7604.pdf
> >    https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
> >    https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
> >    https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf  
> 
> This probably doesn't even need an Rb, but anyway,
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Save me clicking on the link :)  Applied.


