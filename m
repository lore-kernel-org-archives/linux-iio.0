Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C41313E34
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777199605; cv=none; b=pc3VIDZON+4HRQ9tRLyYM+hR88ofxqqhEcyJNIRn/b3eizJ6UQyRN2XABr+fO30/x4f1Pk3/qPuQm0wHAZYcrs1/7/zOrSIpIuavwjMWySZ+j4d1OTbbzvM0aRjG1AJAPPpngO0BebBRmJQooS8dWGLMj7pd8wgDcxFObffWz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777199605; c=relaxed/simple;
	bh=xW2ijtlf0VR5muT9UCJIs0GsN3u6g6ZaOyKZUZ6ffEk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FtGv4PqZe2O9n46OFSP3p/LjpMtnLf8drUxsmi9XJ2ggj9y6SHMT8ab88psGSOf0SUv/2MtNURgoyyV5I2hk80plb7U9PWg3WbkXwEmVwtX8EjjZug5y6QK7oFH3wdjee9ilKP4r0Aie1pHIwFNu3lSYpGQ3A4zTH3XGUBd3fBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRqimsYt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRqimsYt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36146ae9dd4so7635571a91.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777199602; x=1777804402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IGRu5Pk2/TeuZdr6t850LttmKThNTXKspGnPxa81ohY=;
        b=iRqimsYtJvGc5l0EWlb+P5JqWjsgfpyUfTs27tLqJwAHkff642YDaEs8WWVrrL8ak5
         c3ESJKMSxJy0powk/gnW8gcE0oggssjLnYSE0ag0jLHolExk7iSamtSvTLOZ6i82WGAk
         Fx+0T8smJT5VKd4GCJDYn/zOPuLeIKEGb3TqYIoDO10wA+PD0fGY3b99ObkATUdrAFiw
         7kwvA77/OEft9yVSsG0ysEwBe/sApfqb13WP2/5bNXIxcgTZooGQKf6scO8km/SZGHQ/
         WhFV1tdrbc0AmrRjwC8Q3ODxg+Xa0IQFCHZH4zlhJM/BkjqEtjLah6QY8qrcd3aWS3xB
         lHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777199602; x=1777804402;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGRu5Pk2/TeuZdr6t850LttmKThNTXKspGnPxa81ohY=;
        b=RpC04c9RJbMlPxJUnjF012wipekLUbsitLELRVTXQ9Zqnj7VQi2zXAIaRITFUFF20X
         dufmT5sREyq86kp8uu/0wR6zIQI7Vflt+jcMGa9xd9Ie/axzR1QzNJEvYn2az6A1rGrk
         CWwMp7oRJqfVGIYMsSGC6mjc7Xs/lJ9zb9k8e8OrVrjBQWT/6+CbguGFXuSmTSIBjT5E
         kuQuuLjtdgiWhcxSjN9YowD+ly0EM+s+sdjDoSyDYiygkK0oNmzxHn1BqotJMnMrC9eA
         MvebBbUZnY5eFivioDouZCx6cWHRkI/mXdhZcP/yJR5VmEVg44f6e8UZl2QpcheQ2XoA
         9HxA==
X-Forwarded-Encrypted: i=1; AFNElJ8RxQuu2fF7S1+3d4QqdhzK4ZgzAsxUOywNK53kJHEyKdEYmoH84oaQwamVrkndPM00HXsDOppdugY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm86U4EFuEyAG17EB+wOmtH4J7rUQEj/1f1Kk/FQMEr3buflbt
	DcbhWMyNlzkuNyJMWSvJe/pImcEmQeZl1ZqDJN6DMjaysIl8vXJ/jZTS
X-Gm-Gg: AeBDietmD3/DMbP18922XkL/Ajnl9E9LaW9xqV19xK2WHRmpS5rw4gBCjAJ+DmpjEJy
	JjiD/k6OsInxbiY2a/YyAyaUbdN+906pcUQL+zK2NC6Ffs6SEILGczLEv5c//48otW0RuL35+qB
	DsJRd35Geljsu+pLmVyV1vHBKiOrbwvKowSworTffDvS+xl//2ek+vb4YJva4VC+GiPMXYyoCYf
	hWMTAWmcdsdQMfl93pryXgHMHZkMmQqius6/lAe8/Ahqye270iydB9GCM2Elq8Owu4YtfI5s8S/
	doABoPwcKtUnw6tEFoNRpjvdEjyeJBhk1B011NyZ6xcMjufI2rD4D2BMaiLB+J1zx/YjEna6r9W
	t81P2oDMj2y2L9s4ls6RHAh08a2q7oNKZNqlgzAgCrCX2NEX16/qKJAk2BpzP1NrRXhu1lCYl0x
	OsPsr/h8zaYUM6F4AoOdMIbkElk1v2st+pI+56OiRTsa1rhA==
X-Received: by 2002:a17:90b:2e41:b0:35d:aeb2:25b2 with SMTP id 98e67ed59e1d1-361404aeddcmr43098425a91.27.1777199602507;
        Sun, 26 Apr 2026 03:33:22 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:aac1:83b3::639a:3255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa8068csm10854027a91.2.2026.04.26.03.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 03:33:22 -0700 (PDT)
Date: Sun, 26 Apr 2026 15:21:47 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>
CC: nuno.sa@analog.com, linux-iio@vger.kernel.org, demonsingur@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
User-Agent: Thunderbird for Android
In-Reply-To: <20260424202727.1b880766@jic23-huawei>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com> <aenU2WZnVJ-esibn@nsa> <8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com> <aeskNzhWtKPNYb4R@nsa> <20260424202727.1b880766@jic23-huawei>
Message-ID: <DEE9F0E2-7759-4C58-BF53-2FA8732050B5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25 April 2026 12:57:27=E2=80=AFam IST, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>On Fri, 24 Apr 2026 09:08:37 +0100
>Nuno S=C3=A1 <noname=2Enuno@gmail=2Ecom> wrote:
>
>> On Fri, Apr 24, 2026 at 07:22:37AM +0530, Sanjay Chitroda wrote:
>> >=20
>> >=20
>> > On 23 April 2026 1:46:32=E2=80=AFpm IST, "Nuno S=C3=A1" <noname=2Enun=
o@gmail=2Ecom> wrote: =20
>> > >On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote: =20
>> > >> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> > >>=20
>> > >> The listed maintainer analog domain email for Cosmin Tanislav is n=
o
>> > >> longer valid, and he would no longer maintain this driver(s)=2E
>> > >>=20
>> > >> Replacing email maintainer with list, to keep it valid all the tim=
e=2E
>> > >>=20
>> > >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> > >> ---
>> > >> Changes in v3:
>> > >> - Following input from Nuno and confirmation from Jonathan,
>> > >>   replacing domain specific maintainer with mailing list=2E
>> > >> - Link to v1: https://lore=2Ekernel=2Eorg/all/20260418211336=2E180=
0221-1-sanjayembedded@gmail=2Ecom/
>> > >> --- =20
>> > >
>> > >While you're doing this, could you take the opportunity and also upd=
ate
>> > >this entry?
>> > >
>> > >https://elixir=2Ebootlin=2Ecom/linux/v7=2E0/source/MAINTAINERS#L1837
>> > >
>> > >Thanks!
>> > >- Nuno S=C3=A1
>> > > =20
>> > Hi Nuno S=C3=A1,
>> >=20
>> > Are you suggesting to have separate change to add mailing list in ana=
log devices and iio driver which you pointed ?=20
>> >=20
>> > This change is specific to email debounce due to Cosmin analog domain=
 account=2E =20
>>=20
>> Yes, it makes more sense for it to be a separate patch=2E I also sugges=
ted
>> that one because it's an entry covering a lot of driver's and
>> includes Lars which has been silent for some time now so maybe it's bet=
ter no
>> to "spam" him like that :)
>
>If we are adding the entry to the catch all, do these individual entries
>bring any benefit=2E Maybe we should just drop them?
>

Hi Nuno and Jonathan,

Here is my view on this,

Lars-peter is maintainer of drivers falls in different subsystem, so If we=
 can plan to drop/replace would need ack from Lars-peter and also mutual ag=
reement from all respective subsystem owner as it won't be advisable just t=
o update analog devices IIO drivers maintainer=2E

Regarding analog mailing list, we can plan to add list across MAINTAINERS =
where analog devices ownership is there as maintainer or reviewer=2E

Also, this change would be separate from both above points so we shall tak=
e it further=2E

Kindly share your thoughts, valuable input and guidance on how should we p=
roceed further for this change and other two topics=2E

Thanks,
Sanjay Chitroda=20

>>=20
>> >=20
>> > Also, I had take a glance on MAINTAINERS, it looks there are good amo=
unt of drivers which are maintained by you and Michael Hennerich from analo=
g=2E If you suggest I can plan to add analog mailing list in all respective=
 places in separate change=2E
>> >=20
>> > This way all analog device maintained drivers will have mailing list =
of analog=2Ecom =20
>>=20
>> Yeah, I'm not sure if it makes sense to go change all of those=2E I wou=
ld
>> focus on bouncing emails and we (ADI) need to make sure to also include
>> that list from now on=2E
>>=20
>> - Nuno S=C3=A1
>>=20
>> >=20
>> > Kindly share your thoughts on the same=2E
>> >=20
>> > Thanks,
>> > Sanjay Chitroda=20
>> >=20
>> >=20
>> >  =20
>> > >>  MAINTAINERS | 8 ++++----
>> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
>> > >>=20
>> > >> diff --git a/MAINTAINERS b/MAINTAINERS
>> > >> index c981cbdff500=2E=2E6498f0aed1ff 100644
>> > >> --- a/MAINTAINERS
>> > >> +++ b/MAINTAINERS
>> > >> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c=2Ec
>> > >>  F:	drivers/iio/accel/adxl355_spi=2Ec
>> > >> =20
>> > >>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>> > >> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> > >> +L:	linux@analog=2Ecom
>> > >>  L:	linux-iio@vger=2Ekernel=2Eorg
>> > >>  S:	Supported
>> > >>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> > >> @@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/adc=
/adi,ad4080=2Eyaml
>> > >>  F:	drivers/iio/adc/ad4080=2Ec
>> > >> =20
>> > >>  ANALOG DEVICES INC AD4130 DRIVER
>> > >> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> > >> +L:	linux@analog=2Ecom
>> > >>  L:	linux-iio@vger=2Ekernel=2Eorg
>> > >>  S:	Supported
>> > >>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> > >> @@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/dac=
/adi,ad7293=2Eyaml
>> > >>  F:	drivers/iio/dac/ad7293=2Ec
>> > >> =20
>> > >>  ANALOG DEVICES INC AD74115 DRIVER
>> > >> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> > >> +L:	linux@analog=2Ecom
>> > >>  L:	linux-iio@vger=2Ekernel=2Eorg
>> > >>  S:	Supported
>> > >>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> > >> @@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/add=
ac/adi,ad74115=2Eyaml
>> > >>  F:	drivers/iio/addac/ad74115=2Ec
>> > >> =20
>> > >>  ANALOG DEVICES INC AD74413R DRIVER
>> > >> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> > >> +L:	linux@analog=2Ecom
>> > >>  L:	linux-iio@vger=2Ekernel=2Eorg
>> > >>  S:	Supported
>> > >>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> > >> --=20
>> > >> 2=2E34=2E1
>> > >>  =20
>
