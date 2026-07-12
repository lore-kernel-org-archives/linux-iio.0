Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85429ACCD
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783880308; cv=pass; b=H4T54c+h7gpS4/r0zWMif2hBfS3TYWxSnjHdLmp8J45o0JIMrDKA25DhMhwGebwngVRb9/UXZ5GlY0d0S2pJjrQ333e3CsJKIZJqaPE6bhNP11hzDSePdlrY4Cw/NZpAou5e/atbSdlcKzg4jHk/oGuUmy0ySVkZcb5/NM2lveY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783880308; c=relaxed/simple;
	bh=91+lE/PvB9B2UGZxGIis6HRoNFRehg8WShZjO83ddZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6bYW42YAE+U/Bf67TYLB6+uOkgmnYJGyjX4Ayxk8xV2RzKoLv4cF3iAWRuJrjIYrNiVMs5p4N3NR2XKICVo8wqN2ThO6BXNVxH13IbEvKsqzJRAXj5hdyeTeQLYsggKQ+eQw8pz12pwc+XaKSdu90dcQRr2CeoSEGBFRp4Fgos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7MFkZ71; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7MFkZ71"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc6dd436c6so28880865ad.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 11:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783880306; cv=none;
        d=google.com; s=arc-20260327;
        b=LKzZjsrrFiKgNWxMoQoOkn4PcuDzyLMDg4BbkJva+KmiV7kbZbvwngskKUIMvkxC/Q
         9VmLYRaiL4Rc5RTsYbBH/am8y9QDudGwDZ+pqENxlB1Q354hsg9IV/X5du6Sz8hB4oEM
         XBh2lBlyfiwJ51GQDbB8LjM1qBwmkr9gGtwlhzwPy27I857lrwD2RUxqhRtAJoYkqxN/
         JfXXMnQhGjD+9RZe5jRjU2KE29QbijzCUxn3HNjMjHnYvKL2AC/KvATQKvMX50JmLrPp
         nq0p06Q0nZrh+LTTtRdxfa4mYqlUu9Rn1oCCfzC+gaB2NfxEHQcF87iwzzEZUM7ug0p0
         Mmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8HaB870+24Cf6zUZiVILKcFMSQLuP/PfnGLlMLKw6fw=;
        fh=n4tTtE8LeJQ0x4DEs5rWT2h/JLN4EDOLFlO0TjvOBGw=;
        b=XabLM2LLROpCOCh1jGfaSum1S5j8xj/WHRfWD0JMjNoGOAmTsbEIcMzesfdTpP0KQF
         lG4heen3Yu9YaHudbmMm8ApO7rHKbeCFvdHoMweLON0oytU0/+892tmhNu98xDY7MNj9
         ti4xSk6qP+yNGI00UioWcKoPqAyz0oSyM/varqd8us0U8RvbRhrRtDhV//v0cA6B6bIF
         GHHtdc7k8cmS7Oje8xQT8POjuzKmzzKi3CIm080oWC+NfjjXZHWreeEpKaxhiS1nkE0+
         nh+JQ0M5FjApxhG7ZlQ4bt2vIphxlDefG86FaTPsDGl6agcnvGQPhTkcT/pmoVTKzWmE
         GUlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783880306; x=1784485106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8HaB870+24Cf6zUZiVILKcFMSQLuP/PfnGLlMLKw6fw=;
        b=P7MFkZ713MbLYgCar4wCRzS9WV4MldzKztgeN5o/W/d6MCvV4V4w96JluSedO7ZmIp
         rH7Lv0FDHrmEEsDJeb6DQkeJLmo2dj7JLdEQsOjfyMlNCzAXX6qB6SNhmw46+Lkc0uKh
         MHF8wK2WzH0V4GkJ3Wj2//ZDUBJQkrcgqA6Mqe/RJjvHT/OJxUdljY7HXBzjweWAl6x6
         obyeNrYFV2ZRQfsBCWuhyNRoLy8rdVSIZ8yIUg0DjF1AZOl+EakK+QKDMMlJ0BWFU//Z
         zQYKxsLa0bctfGSNRXohyumsaUuBtqmfjCCU9JesCpZteV19a8nubStm5BME2DfWcSEL
         w+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783880306; x=1784485106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8HaB870+24Cf6zUZiVILKcFMSQLuP/PfnGLlMLKw6fw=;
        b=DDg+ljrP3KvlEibUyymYBGsN/ny/GeFWSSzu7OdQY3GgcwziQP5wmLScDsCP6CdVM5
         YReUkF3AkrQpHYKRvNrXNAk0+Y+8NmW+xPu27Fk5j0VIwuJrb4QWh1H6bh7L73KxDu7s
         UkEEz9vhI+e3iRZ3ST76UXDrjSk2S8JRxd1aTgGWvSITBWYgVQn7qmLvOeWjyvm1rWT8
         LRCtBm8tZwiOpQh+666Ow0W5mSvnYb9iHzPBxJCsK5EP8RznqspKnPJF4z+ehl/Kib2c
         RANp3x2W9fklqEXrbkPy+dXOcpdsgWQajNe1lr1189UO5yj9P5a/PzPIH9e5LIoCnFbb
         A/eA==
X-Forwarded-Encrypted: i=1; AHgh+RokaqIiRdKb1TmAtu22XL1wOv/It4q6y4kOUt6MZ03xRTR6E7NxRqvTSCeVRiSgcWgRBij8ORDBiYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjT9shTEJlTOWMDFe+pQKuhQtJoiZvabTzbJCSpo6HHhSm3Af1
	5JAr7GosXp9YBtU/ic3HJMyatJpSWUi2nxqF8dlTL04M7BmCwFQuAueHpEWR0gtZpZ1CzSSnV/J
	OE4M5Y1IwXwB8DCrfrVfc5upLDuPaIGM=
X-Gm-Gg: AfdE7clouup+qL9d4IYwc20taQMUwbjJVu7qNfvBWrpgQ1sia/OAGaWRt60YqIyxUs0
	D9USMV1uhVZktkk2cSjIBaIPfx7DGnumBe5rMaSDWTWJAMvYGGjWrX7jNuVE+xL/h8HBoKMUMoK
	uc22DmwJVwuUnV4isUPMt7UaHFgqyK/Dkt3LJrQQHdQWavw09XZnnE/JXRD2VBFSMaA5WO/b0e3
	dc0nJvH+NEHURlzoEr0krLUSHclipFa1iNfKZKYeOS52jbILL9lHXcHEcxXi7ZcJrBXjoKTPBHN
	2qOFqK+Aw6A1UEwC3bor6HG/+FKp2Nw=
X-Received: by 2002:a05:6a21:4d8f:b0:3c0:9c1a:894f with SMTP id
 adf61e73a8af0-3c110b33403mr6952066637.71.1783880306527; Sun, 12 Jul 2026
 11:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
 <agAvydze87mMLaVC@ashevche-desk.local> <20260608085754.32def4cd@linuxescape>
 <20260609140712.2e5d1640@jic23-huawei> <20260609102159.14c68a8e@linuxescape>
 <20260610103651.00007a64@gmail.com> <a2b1acbb-f8f2-4d6f-9681-986f42feddfa@gmail.com>
 <09dea87f-d2e2-4bbf-a948-3092a2dae29a@gmail.com> <806c72a7-8c29-4308-b226-c347bcde7b0d@gmail.com>
 <CAObtm8z5CGvNrPHk6fw+ibsQkqsMzK3CQBpmQFNCUj3jFzartw@mail.gmail.com>
In-Reply-To: <CAObtm8z5CGvNrPHk6fw+ibsQkqsMzK3CQBpmQFNCUj3jFzartw@mail.gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Sun, 12 Jul 2026 21:18:14 +0300
X-Gm-Features: AVVi8CfGkFSjpVAlOjqO4TPNW_vpW2mZtxEUmXohvrsCQlkb3lnCndBf0YN9BNc
Message-ID: <CANhJrGMZEve5ktQyL43Y_TegbE6uCUK-VVnJdF36AVB-Ob66aw@mail.gmail.com>
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
To: =?UTF-8?Q?Tomasz_Duszy=C5=84ski?= <tduszyns@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Maxwell Doose <m32285159@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	open list <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	heikki.haikola@fi.rohmeurope.com, antti.sakkinen@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

I re-ordered some of the messaging below so I stay on track what has
been discussed. Let's keep the (necessary) old context on top.

pe 10.7.2026 klo 18.07 Tomasz Duszy=C5=84ski (tduszyns@gmail.com) kirjoitti=
:
> On Mon, Jun 29, 2026 at 8:20=E2=80=AFAM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> >
> > On 25/06/2026 08:11, Matti Vaittinen wrote:
> > > On 10/06/2026 12:46, Matti Vaittinen wrote:
> > >> On 10/06/2026 11:36, Joshua Crofts wrote:
> > >>> On Tue, 9 Jun 2026 10:21:59 -0500
> > >>> Maxwell Doose <m32285159@gmail.com> wrote:
> > >>>> Alrighty then. I'll probably take his chemical/ drivers since I've
> > >>>> been spending some time in there. Regarding his light/ driver (ROH=
M
> > >>>> BH1750 AMBIENT LIGHT SENSOR DRIVER) I can take it but I want to se=
e if
> > >>>> anyone else wants to first.
> > >>>>
> > >>>
> > >>> I believe that there are a few ROHM folk in IIO, perhaps they would=
 take
> > >>> interest in maintaining the driver.
> > >>>
> > >>
> > >> Thanks for pinging me. I need to see if we have any of the:BH1710,
> > >> BH1715, BH1721, BH1750 or BH1751 here - and if we don't, then I need
> > >> to ask from the HQ.
> > >
> > > The HQ promised to provide me BH1721 and BH1751 so I am fine maintain=
ing
> > > (S:) this driver.
> > >
> >
> > Oh, I noticed from another mail-chain that Tomasz was found :)
> >
> > Tomasz, are you still actively maintaining the ROHM ND1750 driver? If
> > yes, then I'm not jumping in. If not, then I'll send a MAINTAINERS patc=
h.
> >

> just add yourself as a co-maintainer. What changes are you planning preci=
sely?

I have no planned changes. As far as I understand, I was pinged as it
seemed this driver was orphaned. I suppose I was pinged because I am
working for the ROHM and maintaining a few drivers for ROHM ICs.

ROHM likes to have it's ICs working, so HQ promised to send me couple
of sensors supported by this driver and won't kill me if I
occasionally spend some of my work-time with this driver. My
maintenance would mean responding to people. Reviewing, occasional
bug-hunting/fixes (if problems are reported) and some very limited
testing. The usual driver maintainer stuff aiming to keep contributors
and users happy. This is what I expect a maintainer to do.

I have no particular interest towards this specific driver so if you
are here to stay active and handle all the above - then I definitely
have no interest in being listed in MAINTAINERS for this driver.

Yours,
  -- Matti

--=20

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
