Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6F20CCDC
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033367; cv=none; b=vGVpVG7DkUH39UTx0eR8tuRjTYhSUbycEpVyMC50DIODQVECowOR7OHIj+SBdLjBO7KCXY+G02+FrScoQfs53+U94pl4zeFur539rKppRGcNEOjYq2S0AkIggn2g8NaC406o7Z1/1Gy3OnubUQ7swA7/jy0vWwj4XYL/fjKpkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033367; c=relaxed/simple;
	bh=OQKxrKEjYBsb1I5LBASed7sDXpUrcPxvN9Wpj4lZdJM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ecs/s6qmXi+ox0OBhLqq2wR/mO4Xa88B8XN+4l6fVnX4jBH9EHrQBePyWHcZYHN2q8tHo0j/yBynAUCM51IBzJgkGLoFEQ+H4Sc+8jbIm7R8nA8def2i12fOgiECvziholmy0AWsBEsP7tUxrF6e1cmY7O0ekb5/QL/pI0zl8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8GrvJcQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8GrvJcQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba0714574fso17119465ad.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 19:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778033365; x=1778638165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iXEOtXroN0yFcsSwaWOo1dKqzjOlwBVp+xN9WpOWZHc=;
        b=F8GrvJcQ9+7TBYN8/pYx0jpm4tCD/X2tF9X5e3Ra6JEPizfbfzcAxIv7PAXOZ4LszX
         TdLJbnOfWC34RUhphAdnbOS8Et3h0UjN+jRO2aOaNMvIj9Nk1SMa7lJsmZNgpyd3bTYR
         6VzosE89AASgpKPvY4mn41pkc7wcZgA2afMYnoEK5HDH/7tnt+9oa2+TDch+Ye+krUEM
         B/VEROrqkQ5bHEMnOfcovtAC6GFFK2DF/o8ZkWP7Y4JxwE6lSY4gdnkjss445CoCJMXK
         +W6LQl2aRczxcT6v44x1AmvMPo0J/kawMrPugZkiWcAj7iRv7yJDX3v4tpwGE8VCsM3d
         MRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033365; x=1778638165;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXEOtXroN0yFcsSwaWOo1dKqzjOlwBVp+xN9WpOWZHc=;
        b=DqfQnC/tjdS3YRRSyOnb42rZiOl6oi64FBXy/nKYP3y5pMNQq6vlKSzVZgs6F/zuXD
         41javRFmEZnhpawk/hw7kwMc+jWBtOz/WhoEnM0gh6spocjVCurc8ktXszHF2tSaktHQ
         Vpgktxj+DFDu2UGL1bc3JButthxcUe8Gll5oIEDyi9MXkAvsAbAXoVkBMvP+nrqC2fnG
         HK0nx4UkkjLfD9NVLGd4vOL8R7RQD0AWGdogOc60keT7qidGG09YtHOLWs7IvrRImYsZ
         tTSSN/hI7YzOM2/Jn1RM5mDD+9QUpj721tPR7sZbogkIM0RmqKvfCGC52UjQ/VmWXmgp
         ksYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gxo8IYDmcHz+4BaM+FQtPOAb5wpGhIef8k5avvZ3gPdNYCTu/++SpzyhJj97huRXdqSWgGa3Maik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxP0bs4qzktAwYDQnap1+Kn2iGSsZlzWYxrQpdTRaa1BNVkP2f
	+IrME/p9+KLZebWnnynIfe51CUEHVUFuTNXEG5bqpOc5lCSPm8FlraTIkSpQpg==
X-Gm-Gg: AeBDieuU70qe95hEGgKGmL1lzaPkFf0Su/fBvXjhCykN2dIF/+3ERSCduJNhRU1kjvz
	eIKIRhjLWcqETr0irPef7akvZ3rPHJ0jXeYV3HM8KZ/AsTfK4Fnro0/MYySHvjH+6tuZpRGV9k1
	eUMwYJPhlXKHfpmkidop/F/jXv17/DCE2gGnUQ55gMjllo4OPlVLi95oHMGIj8XLGJGR+VUiSwh
	ZKYVvjR1p1TnYYYO5H+vGsSDC2cdtySoBbF44IKfSStKO5t4+3XakFv/YPnJiZSDqnxnhidgvGY
	8EzJkjIyIkspHhJM264a3/q/kaaGJw3oMoS5I7BkPVg4Doltt3Fa8VjMfplMebSntfM4lUWLZQD
	tRBBIp44o7USzX9jHct0DCBrsQPOMaKzQBCpLWgDOliMAwzXzW9I7n4doAgVuwuNLzQWMQcMcJw
	G0asyuJg/PHCGR2HkXpGDZvCadaN1fIzERmcpKS4perrG73xtlZ7yC1bsQ3Q==
X-Received: by 2002:a17:903:3b41:b0:2b4:5e7e:34ce with SMTP id d9443c01a7336-2ba7a1fdca6mr8551375ad.39.1778033365084;
        Tue, 05 May 2026 19:09:25 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ae42:4c5c:fe35:ac0b:2573:1e81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1adfsm6235875ad.51.2026.05.05.19.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 19:09:24 -0700 (PDT)
Date: Tue, 05 May 2026 17:25:32 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
CC: dlechner@baylibre.com, nuno.sa@analog.com, lars@metafoo.de, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] MAINTAINERS: iio: adi: consolidate entries
User-Agent: Thunderbird for Android
In-Reply-To: <20260505115409.44245db6@jic23-huawei>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com> <20260430190642.3434650-3-sanjayembedded@gmail.com> <20260504172457.4d7c7390@jic23-huawei> <AB6B7E29-83E2-4BE8-AF74-1DE8358527E6@gmail.com> <afmyqE6-XcT-SRt3@ashevche-desk.local> <20260505115409.44245db6@jic23-huawei>
Message-ID: <5A7BC21E-03BD-40DD-8AB5-0ED6106B51EC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 5 May 2026 4:24:09=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2Eorg=
> wrote:
>On Tue, 5 May 2026 12:04:40 +0300
>Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom> wrote:
>
>> On Tue, May 05, 2026 at 08:00:23AM +0530, Sanjay Chitroda wrote:
>> > On 4 May 2026 9:54:57=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote: =20
>> > >On Fri,  1 May 2026 00:36:39 +0530
>> > >Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote: =20
>>=20
>> =2E=2E=2E
>>=20
>> > >> -AD738X ADC DRIVER (AD7380/1/2/4)
>> > >> -M:	Michael Hennerich <michael=2Ehennerich@analog=2Ecom>
>> > >> -M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom> =20
>> > >Specific maintainer=2E Why is it going? =20
>> >=20
>> > I'm assuming that to avoid de-bounce issues from *@analog=2Ecom domai=
n, we are
>> > adding linux@analog=2Ecom mailing list as primary contact=2E with tha=
t in mind,
>> > this series drops all entries which match the wildcard and have analo=
g domain
>> > maintainer or reviewer while keeping the rest as unchanged=2E =20
>>=20
>> But it's removing people behind their will! You really should do this
>> case-by-case=2E Some of the people who left the company might still wan=
t to
>> follow the driver or even maintain it=2E What you should do is also pay=
 attention
>> on the Supported vs=2E Maintained which makes a huge difference on the
>> responsibility and financial side of the Subject=2E
>
>Some of this was in response to discussion with on specific person=2E
>That one is fine but be very careful beyond that=2E
>Probably best to add a link tag back to that discussion as well=2E
>
>
>>=20
>> Btw, Have you consulted with your Legal department on all this?
>>=20
>> > >> -R:	David Lechner <dlechner@baylibre=2Ecom> =20
>> >=20
>> > Additionally, When David is list as reviewer in individual driver ent=
ries, I
>> > consider as redundant part; All IIO subsystem drivers/iio* already co=
vered by
>> > top level entry, which includes Andy and David as reviewer=2E
>> >=20
>> > Summary of changes in series:
>> > - analog domain specific entries are dropped and catch with linux@ana=
log=2Ecom
>> > under ADI IIO section=2E =20
>>=20
>> No, you should give a good explanation why in each case=2E Yes, you may=
 combine
>> the cases when people left the company, but you also need to
>> - consult with your Legal
>> - consult with those who left on what they wish
>>=20
>> None of them seems done so far=2E So, again BIG NAK from me on this ser=
ies!
>> Rework them and even part that drops the entries that already have the =
same
>> maintainers as current ADI level ones (assuming adding Nuno in a separa=
te
>> prerequisite patch) is good to go=2E
>
>I'm not keen on using the top level reviewers as enough to drop an entry=
=2E
>Where Nuno and David have specific driver entries the lifetime of those
>may well be different to the top level one=2E  So leave those alone=2E
>
>The only ones I don't mind falling back to the top level catch alls are
>those where we are dropping a reviewer / maintainer (and they were asked)
>+ there is nothing else listed - hence the higher level entry is the
>only source of information=2E
>
>A wider scrub is not appropriate=2E

Thank you Andy and Jonathan for review comment=2E

Following current discussion, I will send next series with 2 changes:
- ADI IIO entry to update maintainer and mailing list
- To update or drop entry where we received confirmation from specific mai=
ntainer=20

There should not be any update on specific entry to drop without the conse=
nt of respective reviewer/maintainer=2E
>>=20
>> > - Non analog devices reviewers and maintainer is unchanged for each d=
river entry=2E
>> >=20
>> > Further, I also agree with adding Nuno S=C3=A1 as a maintainer in the=
 top-level
>> > ADI IIO entry, so that all drivers are maintained via the mailing lis=
t with
>> > his oversight=2E
>> >  =20
>> > >> -S:	Supported
>> > >> -W:	https://wiki=2Eanalog=2Ecom/resources/tools-software/linux-dri=
vers/iio-adc/ad738x
>> > >> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> > >> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380=2Eyaml
>> > >> -F:	Documentation/iio/ad7380=2Erst
>> > >> -F:	drivers/iio/adc/ad7380=2Ec =20
>>=20
>
