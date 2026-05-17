Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE630566A
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014085; cv=pass; b=Kp+c5iUAD9kew020l/81DSwFwAc+vqWDu0L8OxQx5bQ5eLEC6Cor0qjPvQJD9LFLq/FMtsuuqMJoZhiRtBiR+3EN+Jgqy8SQdKZUZ1P4bYIQNTd9kSDOzKwSwZ4qzLMK/WBdyu+9G5qynJw+XdpzzRowjgbctu/5bHa5iV2hqjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014085; c=relaxed/simple;
	bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPgiYhxCtdWg9AkUeU6Ctf2rs2umALFYdNVZBcbcNT012QvndE8TohDdv65qzk7EfuhOMc6UwbTlm/xMRWPsjsetkgwkeu0IBGssC4LN8pv+m/CQdsPdIto1empODSxHVL2hyy9Cq7P+rXVMz8F6yHZ68ydUsgX647sGS25R9SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcJJW2TY; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcJJW2TY"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso1249206eec.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 03:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779014083; cv=none;
        d=google.com; s=arc-20240605;
        b=E2TeTbtoQGmPaYwSimBIi/+3JTUaTYH99RSS6UJG6lb/2EUSB+6DohLo00Bc0bNpzM
         4UoTHSYVz5/jBWzUumPKaVQz8j/G1+/sB33bi9ZBZxdlBD9R8AhOIeQEefN1MBv11JTJ
         bBXDPCQBVz0phPBU2GKK2bIQkt7x2ob46qd8OqBvlaEZGLCJKQ935sCmCUgY1Kn1ymk1
         FiNu3nemy0/7uY0LNoOgs0Ze6DEOKPyMR47AnOKMjIl9F2wm24VenZJwG1DCB+Me0jRE
         nQAxBapfSaQAYdq4hSG7yF9k01++JlRRulYY1PdpAp649Jt8EkwExKodYsTfaYy2ygFp
         chMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
        fh=dbngMjDcuDsmdupk6wRLvyxPIJMKQJocfGqQuju/pC4=;
        b=ESl+QNSwFITFu+4qBbD0f+U3X00hCWga9Gy4qz7q2FRt7zsRMeiZ/DigwSrFuc1dHa
         nonk7qaAdpzVE4WY/m/Exs5s47VvnFn1M/ym83yFK5Ot/qvSfpw64w1Z46mcqNGT1/Oh
         wUOkXl4Q9no3yECkNfmz+qfOboq1ZK0hoSlkzxY2LKV+ihmfKR1omyy8rPvhgPtlyo8f
         oGxGTD2976PweC1S+F8xeZ9EHouUQNC/gA1ZpKbxkEesf4y9yL8Tyl3zm1oSjf2zcgNq
         +gIzgVOqh0HfS6yZYRB8A3M7i54G7WFsgwMbQyLER5RqsAE4hm6QkGS3LDP2o6mjNxM4
         6nWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779014083; x=1779618883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
        b=NcJJW2TYmk9QsK4GzkxjqOBIQ7SsvqUYeBfbkpTrUHcbjLIxIUNtdkTIECFVixcjAr
         RsbRx2qlJRCuvt6/lnOjF1W1e9Kh36ZvRDOZcID+7XF469K6XV97DVe2yCqfNGAS9Bnp
         x09bP5L7iMYHWb2JYhoRRxVCkkWME1Y6WQR4hGOB8gnaexhCLJKz3F7/YFH2iuRX3XkO
         aT9gPuCbMiHGojqQJA03TQoLw2KuM+FUHy+2nTMp5L/opA44BDn4IYWOMciGESFemCuI
         6lT2S4qw4bSj+BnhUI1Z4U8qQXj0NH1ygxxi6PnE1Kb29SxliQNyxvytn5escOHKtHjj
         4j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779014083; x=1779618883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
        b=IjAGL9iMGGmkKJHWCkHAUd3WtmWdOsyDp9ZyAwbh6mfL5gyZmyzDGjS+Vke1t2Gsjc
         h4QZq27dQTz5jNjuNMoWJrCBvnJkuPbQPppieWYBt92aJPcAhxbvlBuUNh2UBw1Bs2YR
         pp4yK4XcXBBjEYuhfQrj213xcHR8RboDI/BK+h723EkUdPatfSkDXYe/5ThLgdoNZ2DX
         +f5ViZf4YY7GiIKbgwK7UXQhxsDuzUYK1YkOtXd3UFUY4uSryj3eGlI0zf5kngDlXOuP
         Od5ikPJbmeaJdS3mEsOneEcHwsHV7QZarTFW5Iv+4VjDMtN8p2Ptqdk8dHVfDApx9wFn
         YuXw==
X-Forwarded-Encrypted: i=1; AFNElJ/WKN0/1R0BfKIp9/I5dEIy9bhKlIyjXURFaD7H7HIR1N2cXyaiAkUog7KHCErPdPiwOHDYszjHHiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbTPBS9Q/HNysWILXUwaP21qFSR6NxFzkZjyrIdg8Qq2Kl+gfg
	FODMuLe9r18wVm9j52futPm01aDzSe0dAWpkijmtpQXDsQFrcpyUVUvuuCrhdQuoDPP57A2dsSe
	NDd25MhyFPjfMltJyXKtj22GxgDDRfA4=
X-Gm-Gg: Acq92OH9G6T58dlb0asIbz4c8OQgdeqyC8AiF2aPwlURx6QQzUhbpMdqVzSJF+hW53i
	oiWE8VcdwbAC/+3IcHHgDv41yD0FgvOPh5wZfEutR0pzdmgBzEp6cHnpt/ighBdEQIgS2OryxPN
	ZQtdgzCMrUV9yib0pJLigLPVgFcvFaPvkFJ7OE4+RbsrFfBepyCJILaYMcFrTh3GiPya/vTwDwM
	APUlOW+VQNEa0gX6CzSO+RF/dPTAWVSu6de4hoBo7YwOMnOgc97GsS/atR6j9zNE56wSrYC4pBM
	9idoNCz4J0t0mzzNptU=
X-Received: by 2002:a05:7300:b586:b0:2e1:e5c0:7992 with SMTP id
 5a478bee46e88-303982ac675mr4634265eec.8.1779014083372; Sun, 17 May 2026
 03:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <agl1T8O6kwP7SFZ1@ashevche-desk.local>
 <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com> <agmWVdi3TkBb2cxV@ashevche-desk.local>
In-Reply-To: <agmWVdi3TkBb2cxV@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:34:32 +0300
X-Gm-Features: AVHnY4L5_rkIuV0CHLrjLCbs5l5KmhnavBVglVDy6x95ohpe8OW3F3iZSgNhyEI
Message-ID: <CAPVz0n3Kn5VVxWxCgq2EcRiOaLWnB85hD+-S2Eou=H1PyycJCQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:2=
0 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 01:13:22PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
10:59 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > > > Convert LM3533 to OF bindings, add missing VIN supply, add support =
for
> > > > setting mapping mode and LED sources based on device tree.
> > >
> > > How is this being different to
> > > https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.c=
om/
> > > ?
> >
> > I have decided to have a fresh look, this is continuation.
>
> Then it should be something like v4?
>

That was more than a year ago, lets start fresh. Those patches are
gone, though I did add many of suggestions from there.

> > > What about this comment
> > > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> > > ? Have you talked to Bjorn A and Johan?
> >
> > No, but since grep -r "lm3533_platform_data" * gives 0 results there
> > are no platform_data users of lm3533.
>
> Johan was against driver removal (while it sounds logical due to above) a=
nd
> referred to some other patches from somebody else. I think you need to
> synchronise with the people to have a clear roadmap that all stakeholders
> are agree with. With that, the split and other technical issues can be so=
lved
> during the normal process.
>

And this discussion was 2 years ago, and

"This device is used in a bunch of Sony phones and Bjorn A posted a
series adding devicetree bindings a few years ago"

They have had more than enough time, don't you think? You would
definitely know if there were any activity since you are IIO reviewer
and would be included, were there any activity?

> --
> With Best Regards,
> Andy Shevchenko
>
>
