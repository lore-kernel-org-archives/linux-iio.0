Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B41ADC7E
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339030; cv=none; b=PLcP1+3p2xs9DVuuShmpemrlmVMXaTSjTu+wWMDLQe6chgOZ/4NRZU0YNwSNAB3ilOE/R9RRwVswIU+RDT0HTMmEwTyigCxB0kQfMkrYspo3KLMJzyCefBVZgdbPFRg19btfI8TqbyNq8kbeX7KJIyISL+Pd4DXg9PKKsJmc7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339030; c=relaxed/simple;
	bh=NUIZ6pC/b2bQO5+6bqewnWzScC2X+LnBZB+TCuVRjq8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rt5FfokG3a6szuYJSm7xyjVd3/pWV0W9XsCkmxb//R8eIZsKsnBSrKC5zKmIb07PwfsqOYP9cnFrqlc8E/FQlKn4OnIvxzZiR9xoF67NHZh0WWPeljvAKdRA6DHA9shXZoBbzZpVUJPj//xZyMdYLtWQTJymSgRQEY1zG9t1olY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck+Xo+u4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck+Xo+u4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so5133503a91.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777339028; x=1777943828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P4ONYO33K7xIEV9uS/npwPZ26D3bm1ArQ4RfepaV4rg=;
        b=ck+Xo+u4IcHpvua8SAiTvXwsirw7IeNx2bkL+UwFJXVH1sl+G93RHkIeK6NiyUneff
         7mv2bnmuHdM9vqtsy/to24AcUqERfhuLy63G242KVlyN/gExQ3J9bUVtXykqO0PTt8P6
         Wco0kO4wtpbseeG8pKwCGHffiMyfPTVfghtIOGaG9HlWjc8cr36BZs9BXtn262OqQNao
         gnbI5JVzM6gei3VnroA6I3IKroDYfV+YS24LURAZ7IVRxCXsePku5uIy7s4AtHx4iSE6
         Ty/n2Iw6tl1SefnjOxyp0KC0l1YSauZeMklSdNi7b7K40+XHxyG+Ynhkyzch7yNc8I96
         Eo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777339028; x=1777943828;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4ONYO33K7xIEV9uS/npwPZ26D3bm1ArQ4RfepaV4rg=;
        b=HU4rZM0f5KiFbArqPTjExgLkPUpQQs2X6lxfWVQyAkuD9gsy5zHxIomJs4hfOvPlJm
         AfOEC86nOCmfG6e52k4RhAnPNOuAPKxjlhf7pfFPtTRr/GAGFHVewMLzbnmMGwQ+Ludz
         kandB8bCS2u7pAwP19YisczngT7i6tPHequRTdPiiQuhLhacF/Dh9YW+qP63yI4wTurY
         44BqH0HWI3NYMMm0+HFSCXWQGxRpHcv9O5iVJtsIzZiSavSXg5M1MT+jQWtpahaH9v1x
         0G2Q4DzpPlYXAVyyAd4WEGH2gq3a4qOk5Jd7lUD64hb/sx9FTEbyFAcxDjVULy53zrhK
         DcWw==
X-Forwarded-Encrypted: i=1; AFNElJ/6Sf7Eft5YXfKJjQqaXZoMt0IRfSQJM6ySii9Om8Y2Umf/ksSMklhifHraz3r0TxbCFwoUSlbcz3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMcsfpuAwymw5Gc4gcZyoaQEa57ZKA/BK0ckgWWIwn2vowi3H
	hDp98ETzjPcyCjaLA/Rp4fkByT/wkC/pMYHhOBXp52jY3z0vLbig1lyv
X-Gm-Gg: AeBDiev03DuUaEC1QiOf2FchpBWvgwMxzML3UYrKH3SMOvI0v6EoNpWegppliaIXDhO
	1K13iUQ8ZTPqmpDFH8feUaYfru2Ee99Nx5pdhwixIyacSac6Ppi3IVsS9rHdCFUWiG0FMtIXZxd
	vrQ1r81u3N7/odPhDknF8zoty9TpBtwZkQfUjRxxk93BfaMkZFG1vk3bM0iP/M3bVqIqwQhW4n6
	1+ng4HptXRtmE7aHDWHdPNn4SsHWViiI1aY82ZixW6UFWdl5xS89HvTtdWzkAUT87i1Syt8b/ce
	RWS6OZFRjUveh/PtXujNfA9Q+C6Vfbuq0i+r9DFx/Yrc1gEbgM9nBiK1DW6BN7MBLWgJNJwIwrP
	Ap93TMQu6yYqub6OCJof0MZQyOHcEtMk8kKXg5NdWDWCULxenPjda2C7k2P8bBXn/EQv6US57oW
	BNYWUg5F9sihJc9LAVVIVXCoY+DEf2IpUqiLEfM0qDM0f6fkfWPA==
X-Received: by 2002:a17:90b:28cc:b0:35b:e529:2d60 with SMTP id 98e67ed59e1d1-36491fb991dmr919666a91.8.1777339027854;
        Mon, 27 Apr 2026 18:17:07 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:50a8:e3ee:1:0:e0aa:c237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm931046a91.8.2026.04.27.18.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 18:17:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:50:26 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?ISO-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, demonsingur@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
User-Agent: Thunderbird for Android
In-Reply-To: <20260426141645.5fb8406a@jic23-huawei>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com> <aenU2WZnVJ-esibn@nsa> <8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com> <aeskNzhWtKPNYb4R@nsa> <20260424202727.1b880766@jic23-huawei> <DEE9F0E2-7759-4C58-BF53-2FA8732050B5@gmail.com> <20260426141645.5fb8406a@jic23-huawei>
Message-ID: <577DD2DD-76ED-4A7D-AB13-6008FE2AFCF4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 April 2026 6:46:45=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Sun, 26 Apr 2026 15:21:47 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> On 25 April 2026 12:57:27=E2=80=AFam IST, Jonathan Cameron <jic23@kerne=
l=2Eorg> wrote:
>> >On Fri, 24 Apr 2026 09:08:37 +0100
>> >Nuno S=C3=A1 <noname=2Enuno@gmail=2Ecom> wrote:
>> > =20
>> >> On Fri, Apr 24, 2026 at 07:22:37AM +0530, Sanjay Chitroda wrote: =20
>> >> >=20
>> >> >=20
>> >> > On 23 April 2026 1:46:32=E2=80=AFpm IST, "Nuno S=C3=A1" <noname=2E=
nuno@gmail=2Ecom> wrote:   =20
>> >> > >On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote: =
  =20
>> >> > >> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> >> > >>=20
>> >> > >> The listed maintainer analog domain email for Cosmin Tanislav i=
s no
>> >> > >> longer valid, and he would no longer maintain this driver(s)=2E
>> >> > >>=20
>> >> > >> Replacing email maintainer with list, to keep it valid all the =
time=2E
>> >> > >>=20
>> >> > >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> >> > >> ---
>> >> > >> Changes in v3:
>> >> > >> - Following input from Nuno and confirmation from Jonathan,
>> >> > >>   replacing domain specific maintainer with mailing list=2E
>> >> > >> - Link to v1: https://lore=2Ekernel=2Eorg/all/20260418211336=2E=
1800221-1-sanjayembedded@gmail=2Ecom/
>> >> > >> ---   =20
>> >> > >
>> >> > >While you're doing this, could you take the opportunity and also =
update
>> >> > >this entry?
>> >> > >
>> >> > >https://elixir=2Ebootlin=2Ecom/linux/v7=2E0/source/MAINTAINERS#L1=
837
>> >> > >
>> >> > >Thanks!
>> >> > >- Nuno S=C3=A1
>> >> > >   =20
>> >> > Hi Nuno S=C3=A1,
>> >> >=20
>> >> > Are you suggesting to have separate change to add mailing list in =
analog devices and iio driver which you pointed ?=20
>> >> >=20
>> >> > This change is specific to email debounce due to Cosmin analog dom=
ain account=2E   =20
>> >>=20
>> >> Yes, it makes more sense for it to be a separate patch=2E I also sug=
gested
>> >> that one because it's an entry covering a lot of driver's and
>> >> includes Lars which has been silent for some time now so maybe it's =
better no
>> >> to "spam" him like that :) =20
>> >
>> >If we are adding the entry to the catch all, do these individual entri=
es
>> >bring any benefit=2E Maybe we should just drop them?
>> > =20
>>=20
>> Hi Nuno and Jonathan,
>>=20
>> Here is my view on this,
>>=20
>> Lars-peter is maintainer of drivers falls in different subsystem, so
>> If we can plan to drop/replace would need ack from Lars-peter and
>> also mutual agreement from all respective subsystem owner as it won't
>> be advisable just to update analog devices IIO drivers maintainer=2E
>
>Definitely good to get Lars' view on this - though that can be on the
>final patch=2E  He is indeed busy with other thing these days so
>for IIO at least, if Lars doesn't respond for a while I can take
>a patch dropping him as the maintainer (and move to Credits) anyway=2E
>
>>=20
>> Regarding analog mailing list, we can plan to add list across
>> MAINTAINERS where analog devices ownership is there as maintainer or
>> reviewer=2E
>No=2E I'm proposing we add it to
>
>ANALOG DEVICES INC IIO DRIVERS
>M:	Lars-Peter Clausen <lars@metafoo=2Ede>
>M:	Michael Hennerich <Michael=2EHennerich@analog=2Ecom>
>S:	Supported
>W:	http://wiki=2Eanalog=2Ecom/
>W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>F:	Documentation/devicetree/bindings/iio/*/adi,*
>F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496=2Eyaml
>F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497=2Eyaml
>F:	Documentation/iio/ad7606=2Erst
>F:	drivers/iio/*/ad*
>F:	drivers/iio/adc/ltc249*
>F:	drivers/iio/amplifiers/hmc425a=2Ec
>F:	drivers/staging/iio/*/ad*
>X:	drivers/iio/*/adjd*
>
>Only and for entries that match those wildcards and where there is not
>other info (such as the ones here post modification) just delete the
>more specific entry=2E
>
Hi Jonathan,

I agree with your point=2E
It make sense to drop redundant entry when we are using catch all=2E

Also, with your suggested approach=2E
This change won't make any sense as this entries would also get as driver =
files are included with wildcard=2E

I would prepare and share changes with your suggested approach:

Needs your confirmation/input on two point
1=2E Drop this change and have new with suggested or keep this change and =
on top of this apply your suggestion=20
2=2E Many entries include Documentation and include files, that also requi=
red to in-corporate in ADI entry with specific path or wildcard based on fi=
le paths, correct ?


>Where we have maintainers for specific drivers then we keep the entries=
=2E
>No need to sorry too much about adding this list to all of those ADI
>drivers as this catch all should also match=2E
>
>So end result of the proposed change would be to just remove the entrees
>you are updating here as the catch all will cover them=2E
>
>Thanks,
>
>Jonathan
>
>>=20
>> Also, this change would be separate from both above points so we
>> shall take it further=2E
>>=20
>> Kindly share your thoughts, valuable input and guidance on how should
>> we proceed further for this change and other two topics=2E
>>=20
>> Thanks,
>> Sanjay Chitroda=20
>>=20
>> >>  =20
>> >> >=20
>> >> > Also, I had take a glance on MAINTAINERS, it looks there are
>> >> > good amount of drivers which are maintained by you and Michael
>> >> > Hennerich from analog=2E If you suggest I can plan to add analog
>> >> > mailing list in all respective places in separate change=2E
>> >> >=20
>> >> > This way all analog device maintained drivers will have mailing
>> >> > list of analog=2Ecom   =20
>> >>=20
>> >> Yeah, I'm not sure if it makes sense to go change all of those=2E I
>> >> would focus on bouncing emails and we (ADI) need to make sure to
>> >> also include that list from now on=2E
>> >>=20
>> >> - Nuno S=C3=A1
>> >>  =20
>> >> >=20
>> >> > Kindly share your thoughts on the same=2E
>> >> >=20
>> >> > Thanks,
>> >> > Sanjay Chitroda=20
>> >> >=20
>> >> >=20
>> >> >    =20
>> >> > >>  MAINTAINERS | 8 ++++----
>> >> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
>> >> > >>=20
>> >> > >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> > >> index c981cbdff500=2E=2E6498f0aed1ff 100644
>> >> > >> --- a/MAINTAINERS
>> >> > >> +++ b/MAINTAINERS
>> >> > >> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c=2Ec
>> >> > >>  F:	drivers/iio/accel/adxl355_spi=2Ec
>> >> > >> =20
>> >> > >>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>> >> > >> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> >> > >> +L:	linux@analog=2Ecom
>> >> > >>  L:	linux-iio@vger=2Ekernel=2Eorg
>> >> > >>  S:	Supported
>> >> > >>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> >> > >> @@ -1461,7 +1461,7 @@ F:
>> >> > >> Documentation/devicetree/bindings/iio/adc/adi,ad4080=2Eyaml
>> >> > >> F:	drivers/iio/adc/ad4080=2Ec=20
>> >> > >>  ANALOG DEVICES INC AD4130 DRIVER
>> >> > >> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> >> > >> +L:	linux@analog=2Ecom
>> >> > >>  L:	linux-iio@vger=2Ekernel=2Eorg
>> >> > >>  S:	Supported
>> >> > >>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> >> > >> @@ -1549,7 +1549,7 @@ F:
>> >> > >> Documentation/devicetree/bindings/iio/dac/adi,ad7293=2Eyaml
>> >> > >> F:	drivers/iio/dac/ad7293=2Ec=20
>> >> > >>  ANALOG DEVICES INC AD74115 DRIVER
>> >> > >> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> >> > >> +L:	linux@analog=2Ecom
>> >> > >>  L:	linux-iio@vger=2Ekernel=2Eorg
>> >> > >>  S:	Supported
>> >> > >>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> >> > >> @@ -1557,7 +1557,7 @@ F:
>> >> > >> Documentation/devicetree/bindings/iio/addac/adi,ad74115=2Eyaml
>> >> > >> F:	drivers/iio/addac/ad74115=2Ec=20
>> >> > >>  ANALOG DEVICES INC AD74413R DRIVER
>> >> > >> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> >> > >> +L:	linux@analog=2Ecom
>> >> > >>  L:	linux-iio@vger=2Ekernel=2Eorg
>> >> > >>  S:	Supported
>> >> > >>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> >> > >> --=20
>> >> > >> 2=2E34=2E1
>> >> > >>    =20
>> > =20
>
