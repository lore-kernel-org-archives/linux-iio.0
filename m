Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614516;
	b=i24EddeFI0509m55/ymif8RYgVKco+9cXSvJcXDzzaIN43aBzCR3/tVkVSqETqgkR4Iz
	 YhGwgcc+ghCXHii+WtrI3H+R2ztrLTzx4AQxGpEphmyYGvM1O9si0Vv0u01BkmoDy/l8/
	 rTRHwHxP9JJnwM/+NF/JlHiInLKnCXkddcDIMH+YvWIVbXSSOD8UTpDyN/cORzgE6xpQd
	 FeKeFmR3EhrbZz9LfmVevV7cbmHGNhA7uE/nNSbM+H/QlclM3Cl6YW4mPlycDNBLouVUj
	 up+ApJmT6PT0B+8Mwouv3hAvDhaLCmIpuIVgSfhNd9WzVu1C2NArB8eVkm0dsVj8qNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614516;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TcE1lzRstwloJsqmEE00Egrk9Ryl3qjzIWZnUVNIPmg=;
	b=ZRw0qJ6+FTpJ02HqmHOwXIbzJWCNhn+PtuRg/mX5WIHa4vuQyLBNcjSRnCpfdLNB2H4G
	 dT+Bn4dAGbbLQnjgwJI6o+AlrXYx2yhN1gC+b8rwxqYLGaL29tFxHbcGtmvlVhnPfY60+
	 fMppxObq3kaZTZJ6T31x31V6oPwWfEAskhsgNVCAD6qTEZGzg2wM4hPxopbXeFCupbJc6
	 LcpZJ/lJ38OX8Vt7jEtT2k/9AM2eKm+e8l6bbVqgcy7uLBz0JRYlWB9MpqiM4sDtcxnyP
	 Fy1LoKKRo3Bz1ZuqRVjxq4+8TgVys5d53tnUDO/jJTqT2fl2DnYBmuNsCgUGgOGLl+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mke91yiG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE48606A329;
	Sat, 14 Nov 2026 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mke91yiG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211711F000C4;
	Sat, 14 Nov 2026 00:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614516;
	bh=TcE1lzRstwloJsqmEE00Egrk9Ryl3qjzIWZnUVNIPmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mke91yiGfT3RLRiwlm56Xuq4Ya8wX+nP7tnk796KpJGSy+ncrTgGKr2udXQv4gJdv
	 cXhvnbQD4eqPnYYh859sfCZ8+06F6TeAbpLK96f3lTcLO0TH4P9hdfmhgL6g4NrEWn
	 cDymXnrhxtItOUQbDvTDfA2Opc7vj8C91Tq4OE3aoVNRI+4K6/QV2ZGTkXAGIiB62r
	 dQp9030CQ/yxNzBhLRVJGpSrv1ebryvlyNyMZo8k4DqtitLg9DBAqQawZbGvAHQvif
	 IpnE85lTm0d8TKjZ0fm6cxtT/k0pDfLYg8/1aPOX803hbLsy6yvE6kf8eNT0rdwlQf
	 3FBZykMz/KdRw==
Date: Sat, 14 Nov 2026 00:01:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Akhilesh Patil <akhilesh.patil@linux.dev>, andy@kernel.org,
 krzk+dt@kernel.org, dlechner@baylibre.com, robh@kernel.org,
 crofts@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org, akhileshpatilvnit@gmail.com,
 akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v4] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261114000150.10237279@jic23-hlaptop>
In-Reply-To: <202611130735579e063959@mail.local>
References: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
	<20261113011957.5d8836ff@jic23-hlaptop>
	<202611130735579e063959@mail.local>
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

On Fri, 13 Nov 2026 08:35:57 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hi,
> 
> 
> On 13/11/2026 01:19:57+0000, Jonathan Cameron wrote:
> > On Thu, 12 Nov 2026 09:16:41 +0000
> > Akhilesh Patil <akhilesh.patil@linux.dev> wrote:
> >   
> > > Move to my new linux.dev email address akhilesh.patil@linux.dev
> > > I plan to use this email for kernel development going forward.
> > > Also update email address in few yaml and driver source files.
> > > 
> > > Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>  
> > 
> > I can pick this one up with an rtc ack, or it can go through that
> > tree. I don't mind which.
> >   
> 
> It makes more sense that you take it.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Applied to the testing branch of iio.git (not because this needs
much testing obviously - but other stuff I've queued up does!)

Jonathan

> 
> > Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > 
> > > Changes in v4: 
> > > - No source change.
> > > - Added entire change log for all versions.
> > > - Link to v3: 
> > > https://lore.kernel.org/linux-iio/20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com/
> > > 
> > > Changes in v3: 
> > > - Fixed order of entry in .mailmap
> > > - Link to v2: 
> > > https://lore.kernel.org/all/20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com/ 
> > > 
> > > Changes in v2:
> > > - Updated email ID in relevant device tree source files and driver source files.
> > > - Link to v1: 
> > > https://lore.kernel.org/linux-iio/20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com/
> > > 
> > >  .mailmap                                                      | 1 +
> > >  .../devicetree/bindings/iio/pressure/aosong,adp810.yaml       | 2 +-
> > >  Documentation/devicetree/bindings/rtc/st,m41t93.yaml          | 2 +-
> > >  MAINTAINERS                                                   | 2 +-
> > >  drivers/iio/pressure/adp810.c                                 | 4 ++--
> > >  5 files changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/.mailmap b/.mailmap
> > > index 7fb33babc931..d09fd3708023 100644
> > > --- a/.mailmap
> > > +++ b/.mailmap
> > > @@ -27,6 +27,7 @@ Adrian Bunk <bunk@stusta.de>
> > >  Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
> > >  Akhil P Oommen <akhilpo@oss.qualcomm.com> <akhilpo@codeaurora.org>
> > >  Akhil P Oommen <akhilpo@oss.qualcomm.com> <quic_akhilpo@quicinc.com>
> > > +Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
> > >  Alan Cox <alan@lxorguk.ukuu.org.uk>
> > >  Alan Cox <root@hraefn.swansea.linux.org.uk>
> > >  Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
> > > diff --git a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > > index ad5f26ce5043..ca4d4210f609 100644
> > > --- a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: aosong adp810 differential pressure sensor
> > >  
> > >  maintainers:
> > > -  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > > +  - Akhilesh Patil <akhilesh.patil@linux.dev>
> > >  
> > >  description:
> > >    ADP810 is differential pressure and temperature sensor. It has I2C bus
> > > diff --git a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> > > index bdd995c5c1f4..837679dc01ac 100644
> > > --- a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> > > +++ b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> > > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: ST M41T93 RTC and compatible
> > >  
> > >  maintainers:
> > > -  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > > +  - Akhilesh Patil <akhilesh.patil@linux.dev>
> > >  
> > >  description:
> > >    ST M41T93 is spi based Real Time Clock (RTC) with time, date,
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 222b7fc2c3aa..3aa8fa3c068f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4095,7 +4095,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> > >  F:	drivers/iio/chemical/ags02ma.c
> > >  
> > >  AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
> > > -M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > > +M:	Akhilesh Patil <akhilesh.patil@linux.dev>
> > >  L:	linux-iio@vger.kernel.org
> > >  S:	Maintained
> > >  F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > > diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> > > index 82aa433548d2..832df6ba0ee3 100644
> > > --- a/drivers/iio/pressure/adp810.c
> > > +++ b/drivers/iio/pressure/adp810.c
> > > @@ -1,6 +1,6 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /*
> > > - * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > > + * Copyright (c) 2025 Akhilesh Patil <akhilesh.patil@linux.dev>
> > >   *
> > >   * Driver for adp810 pressure and temperature sensor
> > >   * Datasheet:
> > > @@ -219,6 +219,6 @@ static struct i2c_driver adp810_driver = {
> > >  };
> > >  module_i2c_driver(adp810_driver);
> > >  
> > > -MODULE_AUTHOR("Akhilesh Patil <akhilesh@ee.iitb.ac.in>");
> > > +MODULE_AUTHOR("Akhilesh Patil <akhilesh.patil@linux.dev>");
> > >  MODULE_DESCRIPTION("Driver for Aosong ADP810 sensor");
> > >  MODULE_LICENSE("GPL");  
> >   
> 

