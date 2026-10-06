Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0A3A1A35
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791268493; cv=none; b=setOkNnY6TLguJJZqEkY1/5KDOvBHsLCqeX7WCtJFMqTPSI7zqk8e0y1/Wg1l6k8uiuONerAURSYIzyNUJkyY7oJIu0KDa4pj7cdAUnZIAGDIvl4jLJjkL9+cM9wHHrhChxJ8SebYmBrqdXneVh5cdciVhLtZCJRZtEkKG+FD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791268493; c=relaxed/simple;
	bh=UaY9A50IkfjZSwbaSW9VeHjuhU6oNjPjtrqhFeQJ4Wo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOi6Dg1DdN6pVH2p6eIMbVRvqVGeWcTD914kkESdA796WScy/57HBrmA3IkctuUAJeMTGm9kwdrJ+AcCVlJmvS0m250Qijir/2S1cUUgWrjE+mqw+mW0a+d0zc4ko6ygQndVq8LbZYWkemB4JysAx8aY8NiMv+jgte5jNlZbjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfX858IR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfX858IR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48afbd2c386so235031f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 23:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791268478; x=1791873278; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UaY9A50IkfjZSwbaSW9VeHjuhU6oNjPjtrqhFeQJ4Wo=;
        b=qfX858IRfuhYNb5MBJaec9403LcW/EZi4CHSbVkzvk7JRIQGxbiaaZ+EqIzM8Plciu
         JQcu4NALC8uoFSRMLHWVoGlJNa/t9Zb2JZaDlJqsz/n15kJnXNgr3xfolToZ2K80MkhA
         4fbO15JFIBSWTXBRHAVMjnb8fTZLB4BRURlOOOMDd6eUQUtynGfdhjdE6lHv6RCGtocb
         sVmgfcbtDs7e6rs05Xhk/Tbt/Unh6xofNTXsYGp7OoGtNZ+pUoLHdOtEhfzZBXSuG8pY
         a/Y00o3noUa9bjV3wcy6ni8hsW9WJQWHBnxrz+Q4fVt1djcqNoXO/z+pBbVgFajoxNQl
         OWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791268478; x=1791873278;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaY9A50IkfjZSwbaSW9VeHjuhU6oNjPjtrqhFeQJ4Wo=;
        b=j/syjx9cRMepobJPwFmSrefsXmDjYVgG8yzXcjWSn7+/byxfWXFW4ssjmw/SPrTtEe
         QvV6j3ouQWM+/exQCdSWNyKmTdQvz8ufiV9Is8jtq9v5bQ0S1CmEiZIdk67gsoH/fdh1
         pLMlzITxpZFOzH/8Q8oNLR3uqAvQq3nLBSWKt6r8cxPEQLvmQ+xFbbILKgoXQfQfocjC
         BfVAMOK6a4ABUDeaEYLA70rrMxNesZ7KGxYMRIZVcfv0DS/yIy3TCY/S0zPb7hAdHnti
         5ipDynFrAufhxxHtG08bmxi8fAK6VoTMujylFZH8wg5SpoSg6Y5uSrFO539zOrovDYUJ
         dHgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzR4UAYcofmVu4NW547ZEVv2jOPe+QK3YXkRAKAHnPaee/TZTSHr8VgsOM5Ps8MWNSkSSkoM7qTu3w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLddN9qbuZvEmoh5WzYV1Qw47UvkinBEvjIGIO3nzZf/iiWeGOX
	NqWJdQFqdv+aqRLIqJZMYxWcfX+srotzwpKR/iMBhOYktNO0enjWvXA5
X-Gm-Gg: AYBFou0OWKgLbs3bl4w4WE2AHSEThk8NSN92FrdEWSVRvp74ZD3tCb80/52dJJyfr6G
	YM5Xad6Lm6Zz1mrI/Gu74yE0odXcWrzmCzNaq0l6dK1Z+cuIJS8EesNlhxRXdggC+DHviPo2bAe
	mqY8Y2IVJVcA7Dk2Q7lv1rHExQPZ1Mr8nP2R7U3At+rGCC1MDi62OTYLrEtytriRSc70NKClrgT
	LwzbuNQDooKhlYoWEc+EsVPpPbyolEAZI7nCj20aqUhMj/ug3Jv4+QOwpJDxYO3oQ9G7FxK1wpv
	ynA2R3h+g2f3rfJNijEH71uRkj/Q/dz+F2WhW7njQFyRc5KnzTTVT5dxX5HIqjpAsX7HmAZeONI
	3+rKzKNIcaMTe/u8xcJDZmQboO/E1fXEyu+1pKyimdOUL4sj0FdEECT20MOWAK1HP65m25lizdF
	4xIrqoyFMzsCsqGbPMxh4oUwEFhKjIJ/t7R1w6TDbzmskk1u9KLumfkkGHlC7GWu1qqlwPXH/Yv
	kU9IsYP8UsDXDiptqFuzI6n5ed+Dbvqi+3/sgWN80SqOnH32Moj8iN8g2FX9Ir8SPTBrFVX6WtI
	BwGADT0XFIGKrsFS
X-Received: by 2002:a5d:6f0a:0:b0:48c:4ca2:6218 with SMTP id ffacd0b85a97d-48c6d177135mr652013f8f.27.1791268477778;
        Mon, 05 Oct 2026 23:34:37 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c69be6b12sm2901829f8f.45.2026.10.05.23.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:34:37 -0700 (PDT)
Message-ID: <6f5dd1c1622adbaf0174a949ca91cb11872087ff.camel@gmail.com>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Vinod Koul	
 <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, 	linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, Frank Li	
 <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Eugeniy
 Paltsev	 <Eugeniy.Paltsev@synopsys.com>, =?ISO-8859-1?Q?Am=E9lie?= Delaunay
	 <amelie.delaunay@foss.st.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Jaroslav Kysela	 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark
 Brown <broonie@kernel.org>
Date: Tue, 06 Oct 2026 07:36:06 +0100
In-Reply-To: <asGk4fj_HQ5HupB4@SMW015318>
References: <aqlwRkNcs_UqKjWs@parshuram> <aql6u3T0nnSVr-FC@SMW015318>
	 <aqws8pN2rfS9-dCC@parshuram> <aqz1-OzFobOROuBw@nsa>
	 <aq18_TMNs4EJzgZO@parshuram> <arDtEB0na9DxDWAS@nsa>
	 <arFXc0LqEpgWSS6m@SMW015318> <ar-Il2qP_Qms3Qw1@nsa>
	 <ar-13p3a7ENGfMOF@SMW015318> <asEWwIfO0LB27wj9@ashevche-desk.local>
	 <asGk4fj_HQ5HupB4@SMW015318>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-10-03 at 19:59 -0500, Frank Li wrote:
> On Sat, Oct 03, 2026 at 05:52:48PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2026 at 08:47:10AM -0500, Frank Li wrote:
> > > On Fri, Oct 02, 2026 at 11:43:17AM +0100, Nuno S=C3=A1 wrote:
> > > > On Mon, Sep 21, 2026 at 11:12:35AM -0500, Frank Li wrote:
> > > > > On Mon, Sep 21, 2026 at 09:53:49AM +0100, Nuno S=C3=A1 wrote:
> > > > > > On Fri, Sep 18, 2026 at 11:33:41PM +0530, Vinod Koul wrote:
> > > > > > > On 18-09-26, 09:39, Nuno S=C3=A1 wrote:
> > > > > > > > On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> > > > > > > > > On 15-09-26, 12:04, Frank Li wrote:
> > > > > > > > > > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wr=
ote:
> > > > > > > > > > > On 15-09-26, 21:22, Vinod Koul wrote:
> >=20
> > ...
> >=20
> > > > > > > > > > > > > Traditional naming would be
> > > > > > > > > > > > > dma/engine/provider.h
> > > > > > > > > > > > > dma/engine/consumer.h
> > > > > > > > > > > >=20
> > > > > > > > > > > > consumer and provider and good names.. I would reta=
in the
> > > > > > > > > > > > full dmaengine
> > > > > > > > > > > > everywhere please. dma causes confusion already!
> > > > > > > > > > >=20
> > > > > > > > > > > Thinking about it again, drivers/dma/dmaengine.h shou=
ld be the
> > > > > > > > > > > provider
> > > > > > > > > >=20
> > > > > > > > > > There some dmaengine code outside drivers/dma directory=
, like
> > > > > > > > > > drivers/crypto/ccp/ccp-dmaengine.c
> > > > > > > > >=20
> > > > > > > > > They chose to be outside, their choice... They need to be=
 updated
> > > > > > > > > as
> > > > > > > > > well to point to ../../dma/dmaengine.h :-)
> > > > > > > >=20
> > > > > > > > I tend to agree with Andy but anyways. I feel this is going=
 a bit out
> > > > > > > > of
> > > > > > > > scope now. So what we have now in the series is:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > - include/linux/dmaengine.h (without enum dma_slave_buswidt=
h)
> > > > > > > > - include/linux/dma/types.h (with enum dma_slave_buswidth a=
nd new
> > > > > > > > =C2=A0 dma_buswidth_t type) - A future one would be dma_cap=
_mask_t and we
> > > > > > > > could
> > > > > > > > =C2=A0 drop bitmap.h from dmaengine.h
> > > > > > > > - include/linux/dma/widthmask.h - The new bitmap based API =
for
> > > > > > > > bus_width
> > > > > > > >=20
> > > > > > > > I kind like the separation (and the whole point was to avoi=
d bitmap.h
> > > > > > > > in
> > > > > > > > the main dmaengine.h API) but tbh I'm not sure if a consume=
r driver
> > > > > > > > will ever use dma/widthmask.h without needing the consumer =
API. But
> > > > > > > > to sum things up, what do you suggest for v=C3=9BE?
> > > > > > > >=20
> > > > > > > > * include/linux/dmaengine.h as the consumer API and include=
s the new
> > > > > > > > the widthmask API
> > > > > > > > * provider/private goes to drivers/dma/dmaengine.h and just=
 includes
> > > > > > > > include/linux/dmaengine.h as the starting point?
> > > > > > > >=20
> > > > > > > > Let me know how do you want things for v5
> > > > > > >=20
> > > > > > > Yes lets talk about dma_slave_buswidth, it is client type. Th=
is is
> > > > > > > configured by users to set the width of peripheral.
> > > > > > > So this needs to be in the include/linux/dmaengine.h
> > > > > > >=20
> > > > > >=20
> > > > > > Agreed! But providers also need to set the allowed bus mask. An=
d I'm
> > > > > > just not sure they need to include/consume all of the consumer =
API.
> > > > > > Also, it's common to allow the provider API to be widely used t=
hroughout
> > > > > > the kernel (but I agree that could be even harder to get done -=
 if we
> > > > > > want to make some stuff really private - but I guess that could=
 be done
> > > > > > in a second step or more incrementally). We do also have some s=
ubfolders
> > > > > > in `drivers/dma` which means we'll need the odd "../dmaengine.h=
" relative
> > > > > > include which I do not love tbh (on top of the crypto stuff).
> > > > > >=20
> > > > > > I really think something like the below would be more appropria=
te (if we
> > > > > > just want the provider/consumer API without further splitting l=
ike the
> > > > > > types.h and widthmak.h in this version):
> > > > > >=20
> > > > > > include/linux/dmaengine.h - provider API (as of today)
> > > > > > include/linux/dmaengine-consumer.h
> > > > > >=20
> > > > > > But anyways, if you or Frank do not object in the next few days=
, I'll
> > > > > > take the above approach suggested by Vinod:
> > > > > >=20
> > > > > > drivers/dma/dmaengine.h - provider
> > > > > > include/linux/dmaengine.h - consumer
> > > > >=20
> > > > > It think it is fine.
> > > >=20
> > > > So I was aboutto start on this again and I just realized
> > > > drivers/dma/dmaengine.h already exists today so nothing to do on th=
is
> > > > series.
> > >=20
> > > I just find it and start some cleanup/move work.
> > >=20
> > > > I mean I could remove the consumer include on the dmaengine
> > > > drivers that I'm touching but not really on scope and super importa=
nt
> > > > IMO. So, for the consumer side, should I just go to the first appro=
ach
> > > > where all the bus_width API goes into include/linux/dmaengine.h or
> > > > should I keep:
> > > >=20
> > > > include/linux/engine/types.h
> > > > include/linux/engine/widthmask.h
> > > >=20
> > > > And have a better separation on the consumer side? Or maybe changin=
g
> > > > s/engine/consumer/ on the above paths?
> > >=20
> > > I go through v3 thread, Andy just said split to new type.h, but not h=
ave
> > > provided reason.
> > >=20
> > > I am planning move provide API and data structure to driver/dma/dmaen=
gine.h
> > >=20
> > > include/linux/dmaengine.h will keep consume only defination and API.
> > >=20
> > > why still need types.h?
> >=20
> > The idea was to rectify the messed up dependencies. Without split of ty=
pes we
> > will need to have bitmap.h (IIRC the initial idea of the split was that=
) only
>=20
> There are already include bitmap.h, and use
>=20
> typedef struct { DECLARE_BITMAP(bits, DMA_TX_TYPE_END); } dma_cap_mask_t;
>=20
> Suppose all DMA Engine consumer will use it to do some check. So I think
> needn't split it as indivial version.

Are we sure all consumers are making use of dma_cap_mask? In fact the only =
function
depending on bitmap.h is the one clearing the cap_mask. But stepping a bit =
back,
bitmap.h was the original proposal from Andy so the idea was to have the ne=
w
widthmask (this one indeed heavily uses bitmaps) already as a split. And wi=
th it,
came types.h given that the DMA enum needs to be used from both consumers a=
nd
providers. And note that consumers might want the header without actually n=
eeding the
bus width API so the separation kind of made sense to me.
Then, as a follow up the idea was to also split the cap_mask API into it's =
own header
with a backing include in the main consumer header.

So if we all agree with the above, I guess the current series does not real=
ly has to
change. I see 3 ways:

* Just go back some versions before and have all of it in dmaengine.h
* The current form
* s/engine/consumer on the current proposal include/linux/dma/engine/*

- Nuno S=C3=A1

>=20
> Frank
>=20
> > where it's indeed required. Besides bitmap.h there are might be more he=
aders
> > that "include half of the world" which should be avoided in every heade=
r file.
> >=20
> > --
> > With Best Regards,
> > Andy Shevchenko
> >=20
> >=20
