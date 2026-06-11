Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67E30C158
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185319; cv=pass; b=ZpfzAUtECcBZZAIFePDko/1KMc/BIn8m0myUUwtgHwEMogWeHi0PiWUPEuueUIO4lUUuXWYnAIMpTH7NmEJabFV/GN5SjCyvWuroLEPABaAPUioY3vDiBtpFghObS2HPmVqEE+UMEheskdPi0+i3RSoXT7fMbTDyNB6lRBJ+qCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185319; c=relaxed/simple;
	bh=la9v2EJSyOmFNWumJ+PlbtP/IdcZezWwHW0dgAWzupQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9peL4Sp80SnooAewYzh68tT4X8WFsMXNRdtmokxHaGYk2n0NT6Y4kz2tkQoCTyvRH4BSKciUD/bjbSVTwPnUAICQyvQ0g6JXTsyZnDB1BIZAPROSvEa1F0Nw+Zd58g7vqGzovBhHmT5y3BE86uZoBErYgVSAAgjTszwlI6bVIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEguZo1f; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEguZo1f"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1383e116edfso2431317c88.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 06:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781185317; cv=none;
        d=google.com; s=arc-20240605;
        b=QpqbGT/L/RZtFTOoXAWdCIzShdM5DZkKpOAAOpt9yHDNFQ0HsLWrPUD5avBX6BUM6r
         IXugTHQcOXf4zGk0EudQff5OeR4//hzk/NedQjpdFXWQ471zPFPJg4xshHPoyVvspD9W
         mUvxM8x3acNapfg8HJLP1DIRaT+Bm+Em6umsP7kzdlvjaTqrvKVp2aon4Qn/XHN87cOm
         dE1P+H8wr5cDGDMi9RFcBGl07ZVFZG35RLa6AH586LWRb2Lb95naPanOor63stu9tAVd
         A+b5BVltXcvPvqxrkIYl0vns9j4DYS+YL80ved3p5n4q8QDXO1mb2Pep2HXIAYsd5ETP
         klGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=la9v2EJSyOmFNWumJ+PlbtP/IdcZezWwHW0dgAWzupQ=;
        fh=OvKRO9fQK5VsIE4DUdleA5HyjmRiC3LRj3dzx8fzy7E=;
        b=GdM12I8UX3DppLUdbTM9+VpsrqBUqMqjXwJA9nuIuzHmGzuWFAMqyVNAVoBi7EWrzK
         JmFs75qCVaZX4zsu9I+A9/5u4jBaOzjfbfFtulK/E/s+Pi0wg+ai4uALu5viZQajBq4A
         QHHiu8EHJ5RpqOERpHFIOraqwWNVgXHX3Trqa1cHDxHyhKy8qBAROld30lTzIS73YhlD
         FI06Um38V0b0qJ4Y43LLOq9AVCtt5tsIzJqMG3dLzGyO6d2eJ9OVU0XGYhHpmJJQI6ya
         G321FeLcCdJlffUT35Mnacf96aspaSYzZsE0PxulOnIXg2Kxl60G02797PY7No87qHTH
         incg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781185317; x=1781790117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la9v2EJSyOmFNWumJ+PlbtP/IdcZezWwHW0dgAWzupQ=;
        b=LEguZo1fQ3/bwaepYacQHMHqZdqAId2RRsBgTvdMmvnhTIvgykgfHMbAqDvA67JqbW
         y71nJKahuEK7Sxu36R8oNwix8j5AswZYJ85CoGwofl8jcTU34NpBpSZLNE+vmtAvxZd+
         ih0Uf9gaGZ7ryBk7shnfltlQ+JSkCF9MoGqyCyP1eBCqId25oLKfE1cjT5AwnLC+KTj5
         vtjyh0Pe3aM3AQMYuT8tXkvvQDVmKfHO8G2gMNo0ysNuuFV0fLngROmL7S3rMCJ/4eGA
         xNNg+8qi84aULoL/TaXotWMhaHs3HzeQX2bampCLkoVm+/KRTS+ULbxCmC1cU7+HGGzi
         AdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781185317; x=1781790117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=la9v2EJSyOmFNWumJ+PlbtP/IdcZezWwHW0dgAWzupQ=;
        b=bHdLtXdIiuLqpOV7xkb6Z/aosKzjxAeiuKmlf4zhyq8ncrBpdiusVAT33AiXwuLkG1
         vHf7/gLvJm/UO/2F/3nPrHKHifGR+HacxSn//LFXuV82aejk1vfBfWZz57BPxyR8I4+R
         AoosWfzHgbz2w13VXJLIZu+3y9cQicBCQXmtAyq9rPz0PN3RUTEiJYisuPh25pyZu6/N
         hWq79LieTdOYBaANU2VIG8GTwUYyL0mkBKhrUzaL4/2nmSooL13hpNmjtThkLr1P1O/B
         JV6iXUkOY53SeIntEYZkrQSmUEnLhQarftaouWUv/E1uh7BS0ckOUiS7PQlbcUDiTx19
         +g8w==
X-Forwarded-Encrypted: i=1; AFNElJ/e7rYXpyXW0YXSSuUPPnanar2pTqxyg0NtQHsvfNL7/K3LWJAaluOkZJkDunHHva08rPVtnXYHT0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmz7BKa+KXAfU+KiHHyvrZ+3OizgXGeyya/bgnp9kVJtyXANPZ
	/+Sb9oXhlr6OSbQh0ZHcHTmrhPn0FvvbgoUT51VXELcXvL9/yV+uZ8m0EAXcRftG62KIld3nolR
	pzhDYUmy6CVgzjbw5hekLW5khny8yPgI=
X-Gm-Gg: Acq92OHI7MRZsv17OMy8TXvPcPgC1oVNvUB/3w1AGKUA9aNrsxIVMHAQAZU/Ahw/969
	FJ8Glmdp5n+hKAdvSs3ev7a7K2foFzxj3VE51rJxwqQZkgL6/9B8lkiFlOQAAryGi/3TJ5SfrU/
	r2n9UGRdniXdW7u+8u8VmIm32Kyu4tBUYYmhgrSrUiW5hTDosg/PU7czp6DrVbPb1+J9VkKa+s4
	YSyrBJ/mdb/oBhasKx/ozjpEI0M10L1Dpt9yYnWf2BIBq4LoStso+x9+EYjtwwBRTKETtZpOJRS
	OYIT/sUjL3X384nqNYno/GZ9nz1PlPS1iaAdywAf8yAucc8CTE9lhUWOG3PXm1LAqeqSgF2zuX5
	h1SwWGsYqBLFHr2/pB0Ha8w==
X-Received: by 2002:a05:7022:1b08:b0:137:ed4b:c9b4 with SMTP id
 a92af1059eb24-138421ce4edmr1528004c88.28.1781185317088; Thu, 11 Jun 2026
 06:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609160326.45123-1-m32285159@gmail.com> <20260609160326.45123-3-m32285159@gmail.com>
 <20260610-pastoral-dark-ostrich-5ca3f6@quoll> <CAKqfh0Hi8EkShh3s4dUqAJRDExQLR0NVOvd4An+bY5hat4-Lhw@mail.gmail.com>
 <e00caff5-55e4-428f-bc57-3885699b221c@kernel.org> <aipatjyVcltbspRJ@ashevche-desk.local>
 <6c5a657b-f316-4982-8cb8-8c09f1b1669a@kernel.org> <aipfPwT4RJGdA4TT@ashevche-desk.local>
 <aipfxL3ttO1-7W1T@ashevche-desk.local> <CAKqfh0FQb6tSZrrTHGWcoQqPe-OwD-mW02GOOn9y+ysstRPVzA@mail.gmail.com>
In-Reply-To: <CAKqfh0FQb6tSZrrTHGWcoQqPe-OwD-mW02GOOn9y+ysstRPVzA@mail.gmail.com>
From: =?UTF-8?Q?Tomasz_Duszy=C5=84ski?= <tduszyns@gmail.com>
Date: Thu, 11 Jun 2026 15:41:44 +0200
X-Gm-Features: AVVi8CfhUaARykIMlSMbTlDYV_vPSaWBjYTJqbjRWcQjYhC2kclj-nRdmp-pwgQ
Message-ID: <CAObtm8zDk4s3+pmGSxRoVHq7ef1y=_cHdC8YRH6ycRNbjzaNkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I've been trying to catch up on the recent discussion. A few things I
want to address:

1. My email is active and I do read patches (when CCd), but by the
time I have a proper slot to sit down and review something, it's
usually already gone through several rounds.
Chiming in at that point just for the sake of it doesn't add much value imo=
.

2. I get the impression you're thinking that since I'm not actively
maintaining these drivers, you can step in and take ownership. I'm
broadly fine with that, but I'd want to see more work and patches
coming from you first. If that happens, we can revisit the ownership
question. That said, do you actually have these sensors on hand to
test more invasive changes? If you've already answered that just skip
it as I'll probably stumble upon it whilst going through overdue
mails.

3. I've managed to carve out some extra time lately, so I'm happy to
be more involved with reviews going forward if that's useful.

In the meantime I'll go through the remaining emails to get better context.

On Thu, Jun 11, 2026 at 2:23=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> On Thu, Jun 11, 2026 at 2:12=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 10:09:57AM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 11, 2026 at 08:58:47AM +0200, Krzysztof Kozlowski wrote:
> > > > On 11/06/2026 08:50, Andy Shevchenko wrote:
> > > > > On Thu, Jun 11, 2026 at 08:37:33AM +0200, Krzysztof Kozlowski wro=
te:
> > > > >> On 11/06/2026 00:24, Maxwell Doose wrote:
> > > > >>> On Wed, Jun 10, 2026 at 4:09=E2=80=AFAM Krzysztof Kozlowski <kr=
zk@kernel.org> wrote:
> > > > >>>> On Tue, Jun 09, 2026 at 11:03:26AM -0500, Maxwell Doose wrote:
> > > > >>>>> Tomasz's entry is no longer valid, as he is not active anymor=
e. Add
> > > > >>>>
> > > > >>>> Why is not longer valid? I see activity in Feb...
> > > > >>>
> > > > >>> Strange. According to git log --author=3D"Tomasz Duszynski" las=
t commit
> > > > >>> I have from him is 2023. We also did have an RFC open for a mon=
th on
> > > > >>> linux-iio with Tomasz Cced with no response.
> > > > >>
> > > > >> So you did not check enough... and no one needs to read RFC :/
> > > > >
> > > > > Hmm... lore.kernel.org shows last activity November last year (07=
-11-2025).
> > > > > What other sources do you suggest to check?
> > > >
> > > > No, only lore.
> > >
> > > I used this request:
> > > https://lore.kernel.org/all/?q=3Df%3A%22Tomasz+Duszynski%22
> > >
> > > > As I said, February this year.
> > > >
> > > > https://lore.kernel.org/all/CAObtm8zKUAWNS23nRMhc9ZR-zn7xeVOFPiV4ai=
_x7Bkd5puiyA@mail.gmail.com/
> > >
> > > Okay, you used UTF-8 name, Where did you get it from? MAINTAINERS has=
 no
> > > diacritics.
> >
> > OTOH, you may have used simply email approach. With
> > https://lore.kernel.org/all/?q=3Df%3Atduszyns%40gmail.com
> > I got it as well.
>
> Ok, now I see it. I will say though that we've emailed Tomasz at least
> 10 times at this point for various things and hasn't responded to even
> one :/ if we need to we can allow Jonathan to chime in.



--=20
Tomasz Duszy=C5=84ski
