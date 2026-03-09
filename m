Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22853AEF3F
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062030; cv=none; b=TfSpTY4OIKdUOQj7Z+3fnGR7vU0xQGSw0QYor7MKt/CLtUMOSmkaSDfyoxAWDxFmGeeruVjE0nHvairlCYfoQPdSLaORljwXG78tQ7HRPaiSLu8SBAOzn3uiLo3tZwdAzj5l80VtiQ8bWovjdeRvVL8gF2nM6hSu2RxD8Khmm0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062030; c=relaxed/simple;
	bh=AgOW8pH7Ol8ZGI6Yh7st14HP8hC+hmPcH0PJN9F9gpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sOw1JTk6rr0WXTHJlyyBKFU8i+MHY8gzTXr9YdlgyV0DqU1u+DWbejq7LTnUBsa2W5ISDvGeqPNhjcLNfSXi1nM1QBtBzSN5BplSZeUKVRiXgoKuLREksES1qj2cZiK0uRzUjtG3PKiBgNIN4EGxgsUMF/l2Fsik5pVmVrDzvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGGu7wvE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGGu7wvE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so6443065e9.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773062025; x=1773666825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XULHpVakZ5dTlDAXLZlY07cTrjqMFhuraRf1z35D1qU=;
        b=dGGu7wvEPtcdfElWI9frlRNb4MRzqq5Xpr8JadqUAycxQIOG1IKeeFEyl8XCVdVnQp
         DLy6vN/F6hsLKkr56e/ZoGQuYX8ZxIrOvN7XCIj67YKTnW54kpUEjAu2owrvs9u5s6Na
         kR9hdV6kVU4lG2+h0DxyCYnd4lzuMbF08XgVZ9WCZBYt1mcqG0FvMY1iYK7Gi2u1Qv0H
         vMloivp5wAqPs6F5/rhLpHIrYVGTJHwdSiihK5VGk8nVJ//s/fT/nIzFIPXqWf0soe0f
         nZmNsyaeFcT27TuRJ7PLqGPoN1cz3zOu5CVmjegWWciYmhgNqb/H4eKrb+UNWiU7h6Yj
         Xe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062025; x=1773666825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XULHpVakZ5dTlDAXLZlY07cTrjqMFhuraRf1z35D1qU=;
        b=jXsDrde/vJHMKYVEUozW0E9tpBqRheqm2c6D6xwjEDaYFvKpZCkAaAHlDoeEyNay9F
         Jr7s8ZeUVV5EX5rDXtDVuJFR2TN/sjVVfjigUuPWKXeOvXgfhechdqqmL9mNDpwhAUpn
         kh3Jq0hJ7qEax1YGC18myCmMXTcnTchhPRH7iEL6n9SNthhoPNFmWdy0refTZK75CaRa
         1q3fb9/cATJMB4tA+ZqFHHGwT9dp+VFXEirZ2+ihyuovW6xVlLWQ/v9NNwMdiXNPIchH
         n4EVoLfIrDreUX6B8AOAtrxDQUzQUUuD+DhCMklYDYfSLTm2PcmPBiv9YtaqT3JdY8u6
         RTKw==
X-Forwarded-Encrypted: i=1; AJvYcCX8T/7rM6kilnrPTkPaFb0GB1UqXV4MzyN/dtw2Be0JO0AuyvzgLbbx5iERg3Mr2sl5k99jjz7C3yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxY3dTlEnOMBITD0LBOGnZPbhF5Vmk2/wCvWueET0NJTyheC+9
	XFNetdFBvUhgfYosmQuQL5fyCSC2LlDwaJlYYUtZPp6xSLn/bwOY6ewdUytruxc1
X-Gm-Gg: ATEYQzyNHmu34QGmQ6hm0XagD6zEWH3AloV8Wmk+KdH0Qp/MdGUqXL+UDNTSjeDP/Pl
	gBEG+OwY5U9UMTNTfqLfVtNUlHxXark3Vjercp1K7coQDeK/YcHDyROc2IvhcOjiHX+CxVmO2oU
	KpDGcmLY++W/cu1eYj9Acs7bESJrLMy/fc8gO13CVLmeyn3Bgo7Q1sjWbHelrjt9maURbGQQxgp
	poT96+Q5w6S+nm1x95uoti8HT7ky/4ST6q0XNTSuQVsY53DjtU5ohj3tdu9qyFcUQGpKifo10Tf
	1doFXFwo8d4IhM+MP5vGySumILU2fuyosG1halOHk9VG0Gb+eiQVxMYapEdHKOYzb0EFx7t+ygC
	xZ8F8SjVqYVQrvnv3OclmE/IUUZv2+CjVk9k2eiLsXFfwtW3MX6KJw5WVl2opXIRLkqCj+yeDlX
	WFwh0UigbcIlpg2NavUdbtFDnpq+X0dEI=
X-Received: by 2002:a05:600c:4fc3:b0:485:3692:e906 with SMTP id 5b1f17b1804b1-4853692eacemr85848555e9.13.1773062024541;
        Mon, 09 Mar 2026 06:13:44 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852e38c013sm367606925e9.8.2026.03.09.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:13:44 -0700 (PDT)
Message-ID: <0b8b484575bb106ebabb1519073a416cd2e152c8.camel@gmail.com>
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen	 <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 09 Mar 2026 13:14:29 +0000
In-Reply-To: <ii3gz6t4ufaiznypykneeqrc2hgrrrea26pvyffhbr5ryx2u73@zar3awo4mvxh>
References: <bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
	 <9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
	 <20260301133806.5e706756@jic23-huawei>
	 <pohirub7gjqu7xtq5qakkmr3wlek2rgj6kdgltjvir6g4jwgbr@hmjflsplni4o>
	 <20260307140953.46db3c19@jic23-huawei>
	 <7cc67826-3a8a-4190-9447-62b7d68e4445@baylibre.com>
	 <20260307165816.46a98d34@jic23-huawei>
	 <zurbjiq5nqbcid5h6kfworkmhczigirkzsqqsczfkatpg3bbe3@t7ssv76d3t4a>
	 <42fe94df-ff8c-49d2-9a03-7d00e48eb22b@baylibre.com>
	 <20260308181234.2e7ac4b9@jic23-huawei>
	 <ii3gz6t4ufaiznypykneeqrc2hgrrrea26pvyffhbr5ryx2u73@zar3awo4mvxh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-09 at 09:52 +0000, Rodrigo Alencar wrote:
> On 26/03/08 06:12PM, Jonathan Cameron wrote:
> > On Sat, 7 Mar 2026 14:01:14 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >=20
> > > On 3/7/26 12:54 PM, Rodrigo Alencar wrote:
> > > > On 26/03/07 04:58PM, Jonathan Cameron wrote:=C2=A0=20
> > > > > On Sat, 7 Mar 2026 10:50:14 -0600
> > > > > David Lechner <dlechner@baylibre.com> wrote:
> > > > > =C2=A0
> > > > > > On 3/7/26 8:09 AM, Jonathan Cameron wrote:=C2=A0=20
> > > > > > > On Mon, 2 Mar 2026 10:22:47 +0000
> > > > > > > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > > On 26/03/01 01:38PM, Jonathan Cameron wrote:=C2=A0=C2=A0=C2=
=A0=20
> > > > > > > > > On Mon, 23 Feb 2026 10:02:00 +0000
> > > > > > > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > On Sun, 2026-02-22 at 14:32 -0600, David Lechner wrote:=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > On 2/22/26 4:01 AM, Rodrigo Alencar wrote:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > On 26/02/21 02:16PM, David Lechner wrote:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > > On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay=
 wrote:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > > > This patch series adds support for the Analog D=
evices AD9910 DDS.
> > > > > > > > > > > > > > This is an RFC so that we can agree/discuss on =
the design that follows:
>=20
> ...
>=20
> > > > > > > > > > > > > > represents a distinct signal path into the DDS =
accumulator, so the
> > > > > > > > > > > > > > driver
> > > > > > > > > > > > > > models them as separate IIO output channels (al=
l IIO_ALTVOLTAGE
> > > > > > > > > > > > > > type).=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Generally IIO channels represent the physical inp=
ut/output, not the
> > > > > > > > > > > > > internal channels.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > That is part of the reason for this RFC. Dividing t=
hose top-level modes
> > > > > > > > > > > > into channels allows for better organization, as th=
ey can operate together,
> > > > > > > > > > > > i.e., phase or scale can be provided by single-tone=
 profile, while
> > > > > > > > > > > > frequency is controlled by the digital ramp generat=
or (see Mode Priority
> > > > > > > > > > > > section in the datasheet). Also, it allows to explo=
re the most of standard
> > > > > > > > > > > > ABIs like, scale, frequency, phase, sampling_freque=
ncy and enable.
> > > > > > > > > > > > Putting everything into a single channel would make=
 things a lot messy
> > > > > > > > > > > > to interface with.
>=20
> ...
>=20
> > > > > > > > > > > Looking at Table 5 in the datasheet really helped me =
understand this better.
> > > > > > > > > > > I think this series could benefit from a documentatio=
n patch that explains
> > > > > > > > > > > more about how the driver works with some diagrams.
> > > > > > > > > > >=20
> > > > > > > > > > > So really what we have here are a bunch of digital da=
ta generators rather
> > > > > > > > > > > than a bunch of altvotlage output channels. And the s=
ame data channels can be
> > > > > > > > > > > mixed and match as the source for up to 3 different c=
omponents of the output
> > > > > > > > > > > (frequency, phase, amplitude) depending on the priori=
ty rules defined in
> > > > > > > > > > > Table 5.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > > > >=20
> > > > > > > > > > More bellow... But note that all of the (or most of it)=
 generators are going to
> > > > > > > > > > be feed into a DAC. Your output is altvoltage but maybe=
 we can treat the
> > > > > > > > > > internals as voltage. Not sure.
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > >=20
> > > > > > > > > > > Digital data sources are really more like a buffer in=
 IIO terms than a
> > > > > > > > > > > channel. And before we added the IIO backend stuff, t=
here wasn't really
> > > > > > > > > > > any other digital data source/sink that I am aware of=
 other than buffers
> > > > > > > > > > > (but there are certainly a lot of odd corners of IIO =
that I haven't explored
> > > > > > > > > > > yet, so maybe I missed some).
> > > > > > > > > > >=20
> > > > > > > > > > > In a recent discussion, the idea of possibly needing =
a way to provide
> > > > > > > > > > > some userspace interface to be able to tweak knobs of=
 an IIO backend
> > > > > > > > > > > was also brought up.
> > > > > > > > > > >=20
> > > > > > > > > > > Putting those ideas together, I'm wondering if we nee=
d some new channel
> > > > > > > > > > > type or even a whole new interface (e.g. a new sysfs =
directory like buffers
> > > > > > > > > > > and events) for managing these digital data sources/s=
inks that are not an
> > > > > > > > > > > IIO buffer.
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > >=20
> > > > > > > > > > But what would be that channel? In the end of the day, =
we typically have voltage
> > > > > > > > > > or
> > > > > > > > > > current DACs and a DDS primary function is indeed to ge=
nerate alternating
> > > > > > > > > > waveforms
> > > > > > > > > > that you then typically feed into a DAC (and in some ca=
ses from the DAC into a
> > > > > > > > > > power amplifier). So the DDS is just part of the data/s=
ignal path. Anyways, not
> > > > > > > > > > sure
> > > > > > > > > > on the new type and I think we already have the "blocks=
" in IIO for dealing with
> > > > > > > > > > this:
> > > > > > > > > >=20
> > > > > > > > > > . frequency
> > > > > > > > > > . phase
> > > > > > > > > > . amplitude (raw + scale + offset)
> > > > > > > > > >=20
> > > > > > > > > > But you're right that maybe it's time to think in a bet=
ter way to fit them
> > > > > > > > > > together.=C2=A0
> > > > > > > > > > Maybe a new type (as buffers or events) can make sense =
where the above are
> > > > > > > > > > treated as, example, scan
> > > > > > > > > > elements. Maybe it's overcomplicating, not sure. It sur=
ely needs=C2=A0 discussion and
> > > > > > > > > > thinking :).
>=20
> ...
>=20
> > > > > > > > > For history buffs, we had a bunch of DDS chips in staging=
 at one point and never
> > > > > > > > > manage to figure out the questions being raised here :(=
=C2=A0 They are complex
> > > > > > > > > beasts.=C2=A0 Clarity of ABI proposal and documentation i=
s going to be key to driving
> > > > > > > > > this series forwards. In a sense the code is the easy par=
t.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > Does that mean that once good documentation is provided, th=
e presented design can
> > > > > > > > be accepted? Even though data generators/sources might not =
be interpreted as
> > > > > > > > altvoltage channels?=C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > I'm not sure yet :(=C2=A0 It's a pretty complex design and we=
 haven't really come to a
> > > > > > > conclusion
> > > > > > > on how to handle this channel 'mixing' case.
> > > > > > >=20
> > > > > > > If we did go this way, we'd need to figure out a way to descr=
ibe the mixing part.
> > > > > > > So either we describe it as one channel (which is going to be=
 really complex)
> > > > > > > or we describe it as multiple channels but add extra ABI to m=
ake it clear they
> > > > > > > are mixed into a single 'physical' channel.
> > > > > > >=20
>=20
> ...
>=20
> > > > > > Some ideas have crossed my mind, like adding new option to the =
in_/out_
> > > > > > prefix for "internal" channels. But I it would take a long time=
 to teach
> > > > > > existing generic userspace libraries/tools about this.
> > > > > >=20
> > > > > > What has popped into my head just now is that perhaps we could =
do like
> > > > > > Rodrigo is proposing here reusing existing channels and standar=
d attributes
> > > > > > as much as possible and add a new "subcomponent_of" attribute t=
o provide
> > > > > > the link, similar to "current_trigger" for triggers.
> > > > > >=20
> > > > > > This way, it would still work with existing userspace tools (ev=
en if it
> > > > > > looks a bit confusing). And userspace tools could eventually be=
 taught
> > > > > > to present the channels as a tree-like structure with the main =
channel
> > > > > > and subcomponents nested under it.
> > > > > >=20
> > > > > > We would want to spell out up front what all of the anticipated=
 ways of
> > > > > > using it are. For example, I suspect eventually someone will wa=
nt this
> > > > > > attribute to be writeable to assign a specific limited resource=
 to a
> > > > > > specific channel. An I expect that we would eventually see some=
thing were
> > > > > > a single subcomponent is shared between multiple physical chann=
els. In
> > > > > > this case, we would want the value of the "subcomponent_of" att=
ribute to
> > > > > > be able to be a list.=C2=A0=20
> > > > >=20
> > > > > Something along those lines might work. I'd not thought about the=
 case
> > > > > of one 'internal' going to multiple 'external'.=C2=A0 Otherwise I=
 was wondering
> > > > > if something informal related to labels would work.=C2=A0 We've d=
one that where
> > > > > we've been associating things like voltage and power measurement =
from a single
> > > > > pin.=C2=A0 It's rather adhoc though.=C2=A0 Possibly we could roll=
 it into a newer
> > > > > more general scheme.=C2=A0=20
> > >=20
> > > Hmm... in this case, it sounds more flat where there isn't a clear ch=
annel
> > > that would be the "root" of a tree relation.
> > >=20
> > > > >=20
> > > > > If the association is done as meta data attributes alongside exis=
ting
> > > > > channels then as you say existing tools will kind of work, just n=
eed some
> > > > > human understanding of what is actually being controlled until th=
ey catch
> > > > > up with the newer schemes.
> > > > >=20
> > > > > Lots of ways we could actually represent the graphs.=C2=A0 Going =
to take some
> > > > > figuring out!=C2=A0=20
> > > >=20
> > > > I like the idea of subchannels to create logical tree-structures. I=
t opens
> > > > up for other possibilities.
> > > >=20
> > > > I wonder if the varying channel index would still confuse a user, e=
ven
> > > > with this metadata attribute, like:
> > > > - out_altvoltage0
> > > > - out_altvoltage1
> > > > 	- out_altvoltage1_subcomponent_of =3D out_altvoltage0
> > > >=20
> > > > would there be a different way to name the full_postfix in
> > > > __iio_device_attr_init() that would allow to keep channel index the=
 same
> > > > (e.g. altvoltage0 for multiple internal sub-channel) and still be
> > > > compatible with userspace tools? I don't know, something like:
> > > > - out_altvoltage0
> > > > - out_altvoltage0_0
> > > > - out_altvoltage0_1
> > > > - out_altvoltage0_2
> > > >=20
> > > > userspace tools would understand out_altvoltage0_0_frequency as:
> > > > - direction: out
> > > > - type: altvoltage
> > > > - channel idx: 0
> > > > - attr name: 0_frequency
> > > >=20
> > > > and that would be a problem?
> > > > =C2=A0=20
> > >=20
> > > I have a feeling that could be problematic for existing attribute
> > > parsers.
> >=20
> > Agreed.=C2=A0 This smells like extend_name and that caused all sorts
> > of annoying problems for the userspace folk.
> >=20
> > >=20
> > > How about using higher numbered channel indexes instead?
> > >=20
> > > out_altvoltage100_* =3D physical channel
> > >=20
> > > out_altvoltage101_* =3D subcomponent
> > > out_altvoltage102_* =3D subcomponent
> > > ...
> > Have to be careful we don't run out of space for events.
> > #define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
> > So we do have 16 bits hence this might work.
> >=20
> > I'm not sure we want to make rules around this though.
>=20
> Ok, I think we are reaching an agreement. With this, I think there
> is room for a small redesign, i.e., having a root channel to represent
> the physical DAC and child channels as follows (* on custom ABI):
> - out_altvoltage100: root/physical channel
> 	- profile*: for profile selection
> 	- sampling_frequency: sysclk frequency value
> 	- out_altvoltage110: single tone channel
> 		- frequency: single tone profile FTW
> 		- phase: single tone profile POW
> 		- scale: single tone profile ASF
> 	- out_altvoltage120: parallel port channel
> 		- en
> 		- frequency_scale* or frequency_gain*: for FM gain=20
> 		- frequency or frequency_offset*
> 		- phase or phase_offset*
> 		- scale or scale_offset*
> 	- out_altvoltage130: drg channel
> 		- en
> 		- destination*
> 		- operating_mode*
> 		- out_altvoltage131: drg upper limit channel
> 			- frequency
> 			- frequency_step*
> 			- phase
> 			- phase_step*
> 			- scale
> 			- scale_step*
> 			- sampling_frequency
> 		- out_altvoltage132: drg lower limit channel
> 			- frequency
> 			- frequency_step*
> 			- phase
> 			- phase_step*
> 			- scale
> 			- scale_step*
> 			- sampling_frequency
> 	- out_altvoltage140: ram channel
> 		- en
> 		- frequency: global FTW
> 		- phase: global POW
> 		- sampling_frequency
> 		- destination*
> 		- operating_mode*
> 		- address_start*
> 		- address_end*
> 	- out_altvoltage150: osk channel
> 		- en
> 		- scale: global ASF
> 		- scale_step*
> 		- sampling_frequency
> 		- pinctrl_en*
>=20
> so I ended up with 8 channels (rather than the initial 5). Breaking up th=
e
> DRG channel, following the tree structure allows to explore more of the
> standard ABI. I suppose that even with this, documentation is no less
> important. How does it look?

FWIW, I kind of like this "child" channel concept and think it might be use=
ful
for other things to. One thing that comes to mind is how do we want to hand=
le this
in terms of scan_elements? Do we have it completely independent or do we wa=
nt to play some
games with it? Like allowing arbitrary sizes (not power of 2) in child chan=
nels as long as the
sum matches what was defined in the parent/physical channel.

One usecase for the above would be the ad4030 ADC where we went with two ch=
annels (for the common
mode voltage) for one physical one and we define two scan elements where th=
e total storage does
not directly map the actual physical size. And while we can get away with i=
t for SW buffers, for HW
buffers it's not "so simple".

Can be a bit tricky to implement but the above concept might open the door =
for it.

- Nuno S=C3=A1


