Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D732F8E82
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037775; cv=none; b=o3gDGJRgsDe2EU9B1s5EWXo/jwvkOgutgzwl7KydQ+i6eH61iLKcqJdc7+u+tXfWUc4Dq0O/8VjoJqKCQrOBOhThRcJaKFQEKqpw9AOvfT4a03fdLDJeKYBGxx8z2olOFhAtceHOXFTPRoMwKB4AdvIVNicN7sJTkrJPeZrknl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037775; c=relaxed/simple;
	bh=NMmCASi+YcbAUsvQEOoHJR1ejq8y1LA0sWgEQLZ1jlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSL54P8VlYvYZm7vvaLPLgHGZ3Ig/4uarS57NoQu95wUbK/8AEyUqI1QHCfM0TGBFIuv5tpn86uBhX17KYK0/Ff4JXQNm0KjjDVC+4wtN2+PM7Sh8/zV8Uw/03Qjkb1IeRdoTMxr/ftu4myNndoGRAkHwR61ON8uhokAjtT8mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX8EqFDi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX8EqFDi"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so40129575e9.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787037772; x=1787642572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NMmCASi+YcbAUsvQEOoHJR1ejq8y1LA0sWgEQLZ1jlM=;
        b=KX8EqFDi/aLe5ySddIx3EM+cQj8eEXEkWetiWvZ2SzAG0S8uIj51qvaMERtzIX9u/7
         My/vzGx88gXkgt+r1TJHIIeHW331b5GN9vQvsSDw/LqLf4+E+5nbHrs7YbqKmmDZcbS/
         MYASVfMQ+Qya5fBPNWXng1vhH5Je8vLDpMyYXREpYkiOtTAX2LUaed/n5x+kxDWj/JeV
         ZkhNr6MQuCkY1C0CJmW8mbpU3CKrW54nRp7wbSUEZuHS9bXYvQwbvb2vcXGeNOhhpxMs
         0Q3M1HQNj3oVFD+FMT7ZXoHPHQTm0UTCKA6W+8IPiRkjLzk1JXpXEb/53SvbL04CHnB0
         lWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787037772; x=1787642572;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NMmCASi+YcbAUsvQEOoHJR1ejq8y1LA0sWgEQLZ1jlM=;
        b=OaXH589iSalcb+ZXARPzr3vQF2xV4HilQOJdXhHKOvPZb+vHla5Pe4yvm785Lbjm2y
         ugCF3q80Iw2ehvlZduQMOXe40eCQ8L9HlWGQZ4aidXFOiEfqW3cGZjukFUgxf8mARGLm
         X7v+PV3i3XCdB6Cl85wx++ZcaaUuAtNELptsQnMl0u24rzcc3PLgXvzOMElXEgvLgFdt
         /JasitouFDk0kYkpNL3rO9QC+8t4VowEHO7pHl12q8KMbkoy+UXImvobgcVSfuIrQCFU
         lHobfnnLevyTSAKRqA/qHMOcUguRUSuLsvH5lvjiJ12SDdhXP/GFKmSnEmMtOiae2uEM
         Pj5A==
X-Gm-Message-State: AOJu0Yyrn4aozDiC9Hcw1Wg1qRBgADePNcNtI9P+aa1BsHrsC+1NnFWX
	QMMTLb9ybIeb9h+3K2NIQul4qUSWXVuWNfCjjAmZ+V9ADrrttN3iqKoBHjhzPPyYdx0kQQ==
X-Gm-Gg: AR+sD13Bp79oqHQxS32hiYrzyE53w+HNyQf097Rt8LwlCnTaYvre7RhYv+/L2S3imz6
	ZfjnHoOVs9R3Po5xfZGfh7YqmugWD0ZIvZySpxUKAsoQKkcqajrfU4/CmUPd9IPken8wTq9coH/
	eCtkKkx7v2kPxl0VSCg96ZjfJiUx+LgWVC0zpK/jHvFd+56OnM2zbjlX8Sd26+hymrFbxMvbgJh
	okct6dqGYFPIcjFBhGWIOffgC3fgOS5lTZQhA1sb5oYUrWHc2LVqJADt6vnoXGFc1OEeHw1GaPk
	6L5lZ9D+5z+wlfIJ9zE9+qQOiJxGCugjekl7nKRvSw9MYJbQcTiB4Bue1C8Nbt7KTvuVEtr39wb
	pJUwD/L9/loGH1XWmWc47jPFBH+w6ucceQC0GLhre9plsnOT5PdonqorsUAlOqswvbhH1g0piZH
	5dRoO7jS/wEUkJPh9USLYxckGVH2DINcifrDjpIf10KJ6ik6Isj+D3J5X75CIBXMLEvYf7ZzzUc
	QV61FXjCmRoOA2HpocfkCR36NuNTr2zWd4LTc+l/Ii1cSUe+ZPVKK01uf6oDo0A2OeTaXxIzbtU
	1/KhnyJrF7yjCt+JPWZQxRqJLuos/VGqOB6OLLJ2xbYrpoZ856HxBfOrO0e9WXzisomu3vYBqse
	uQKhgAoYmyhjswQNh0q5t/wHOcYS5pit296xq+tQ+LUxK//TzKg+iM+CXRhK1My/CLfTodA==
X-Received: by 2002:a05:600c:5613:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49987937672mr337181375e9.5.1787037772126;
        Tue, 18 Aug 2026 00:22:52 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b660sm9695455f8f.15.2026.08.18.00.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:22:52 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:22:40 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Maxwell Doose" <maxwell@maxwelld.cc>
Cc: <linux-iio@vger.kernel.org>, <jic23@kernel.org>, <andy@kernel.org>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <20260818092240.000061f2@gmail.com>
In-Reply-To: <DKRG0P23P5NA.171S6RGSLSI3W@maxwelld.cc>
References: <20260817111825.000063f6@gmail.com>
	<DKRG0P23P5NA.171S6RGSLSI3W@maxwelld.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2026 13:50:29 -0500
"Maxwell Doose" <maxwell@maxwelld.cc> wrote:

> On Mon Aug 17, 2026 at 4:18 AM CDT
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>=20
> > Hi all,
> >
> > I was browsing lore and checked out the ksummit mailing list, where the
> > topic about guiding new contributors arose [1]. New contributors tend to
> > make the same mistakes when sending patches, causing reviewers to point
> > these out all the time over and over again. For IIO, this is definitely=
 the
> > case (I myself send an email telling people not to send a v2 in reply t=
o a
> > v1 several times a week). Other subsystems have a "Maintainer entry pro=
file"
> > that contains subsystem-specific process info (DAMON for example [2]) a=
nd=20
> > (sometimes even [3]) a document describing the code style of the subsys=
tem
> > (this would be a great place where to mention things like not using
> > kernel.h in new drivers etc.). I'm happy to create both of the documents
> > but it's always great to hear other people's ideas!=20
> > =20
>=20
> Took a look at [1] and it looks like these are issues across multiple
> mailing lists so maybe we should add these to the main
> submitting-patches documentation? And then for other IIO-specific things
> we can put those in a maintainer entry profile.

Fair, the "don't reply with a v2 to a v1" comment was a bit off considering
I was mainly talking about IIO specific documentation, however having a cen=
tral
document (or documents) of sorts for the IIO code style and process is a ni=
ce
thing to have, I'm sure even the most seasoned reviewers forget stuff occas=
ionally.

>=20
> > Second of all, the idea of having a bot that would automatically detect=
 new
> > contributors (i.e. the email they're submitting the patch with doesn't =
show
> > up in `git log --author`) and send an email reminding them of the basic=
 rules
> > (while also referring to the entry profile mentioned above) sounds like=
 a
> > great idea, but of course hosting and maintaining are pain points.
> > =20
>=20
> Hm...this one is more difficult. I guess a good first question to ask
> would be "can this be hosted on kernel.org infastructure?" But maybe we
> can also ask Greg KH about how he does his automated bot.

=46rom what I gathered, kernel.org doesn't really provide infrastructure for =
this
type of stuff :( If you look at [1] you see that netdev got overloaded with=
 patches
so they made their own bot for this exact purpose. One could just spin up a
Docker container that periodically pulls from lore using lei and runs a git=
 log
with the author's email against mainline/testing/togreg.

I believe it was David who originally proposed an IIO bot [1], primarily fo=
r code
inspection.

[1] https://lore.kernel.org/all/4742ea18-f3df-46dd-aad4-18d1e5f03f7f@baylib=
re.com/

--=20
Kind regards,
Joshua Crofts
