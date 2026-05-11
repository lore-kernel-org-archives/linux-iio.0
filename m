Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61943A4524
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505021; cv=pass; b=Rr+wv+D9lWXwcWaQiT6Pb5P8melLzEq0VG0ww99w5gFlv6DmlacSR1eDxAzaPdtSqbCg0miM1oSJ3Ey1xI3HrCuRJjpyp3ehV3BIMWrstREDpVWWPALaH9+bCK067hGd/qxh0BrCiFdL1TQuWvypzQB0GYmx/xBlA29gOCm/RQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505021; c=relaxed/simple;
	bh=9I8sW1yK+1uF9zmqUjtnhC2S2QxfHvvouTgT1eiyjzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gy2cfIDhzG7bV7nAUDaNX69J4sIxRJq/IK3ddYXN1vdluqTBn8F97qgdcfxJf9Bo1Vx0nCvRChp++liTYLmN97f/1O5ab3d89q3JU+rp4mRkURQotF8BfZfQmJCv9W5ec46sxBN/QpMmn6XUxQp5VwHc9h2wwMaMITAVIr07UaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7LE38Oh; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7LE38Oh"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65d071aac6eso3757183d50.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505020; cv=none;
        d=google.com; s=arc-20240605;
        b=F3VMHASQxe4Tx878+lCjX++UnVutx4l4Of96T/td+XAoEbTsW37Nrfcy7OWqVM2Xmg
         0k0/ga6DyOHDD3E7sD0e7j7tUU2pQmaqcfl0qraWz2ToZORbmXv3GY2G2GtXp9zDniKW
         sDil2xSspAfOCSWrHJI3kEBnro4Wt2qlloLoFhKXXC2AUNWRZnl2tuq0SN/xzbthMR3E
         Rhi9d5Xa/jDfVWSZNndHZ0eYS415+DtN26Yc4pjV+20sb4i+1K17NrclPRQ8EWZt1xvJ
         6c4LfImSW701L8phKI+ZwlJVDLMDgw4eAUz5bQfvfb4ZWHIwDJKzGydvYSsoheMvaiYr
         CJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EMlQ7Lcxo2gsa3Lli7NaTUBt5TanTRF2EnHPAACroY4=;
        fh=jUlpkVVodXq5mCeYQYaTG0hIXu3lvOvkHo5qaVvWk44=;
        b=Vs1PteQ0wsfVLR7PQVq7lmaqgdW1lozayqgH0R8qw0yVHcKQ4nPSrej0Plec7rO/2U
         pskf6eLTMhS4h6x1QnCrXbFC64qed9VMe+3viV2pkhHuI2QLDMyZEQidEAGGMHtykF8G
         5/40BHSyIjVMMOXFNUWIqWQqyuAV+9QS0f26LOtbEwznfoRW73fXGd78ztLqiqvmISv8
         +pleFZOICZTrIrHbo2tUuwxijX38DWRHwRO2fJmf42v0qX5+T88ck0B4l3Uv5JmCsTCt
         o28WpYFiYKUtqaSwbtLbkpdl7da7vNEe8QTaO+2RkrXS1EIjDF+JNEegA5QgYXfnE8dw
         7Ucw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778505020; x=1779109820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMlQ7Lcxo2gsa3Lli7NaTUBt5TanTRF2EnHPAACroY4=;
        b=j7LE38Ohz16Zo3MLibRDZsXmAJye7pl1Qoy3ZYwsCXPZ1kJWLgVb4nxORwAglUJ7+9
         b9V6+0JefRnF1wITYHFvOjfpjnXC6YLTlLmrIGGTsQawcmnusA1UvMj589W6KTeWcckK
         C4ijZFbcbWWo+p/Y+x7Odp/+B7OVgfrTxGP2z9ohAJaJz0+8+ccsMcMwSkdk7ZMDkkcp
         PjopJFHi8MqPyqc0eO/FULHMfc6HIrUgA+FxtWmpbM7ki/GvSUpPv2aaLEOCplK4I9C+
         oQcKX/oxWeYOAfMea15+FNhFyDmNDzRatuaH2+lGPT+aGz6KD72iqmIU4rWqR4DyIkYZ
         HZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505020; x=1779109820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EMlQ7Lcxo2gsa3Lli7NaTUBt5TanTRF2EnHPAACroY4=;
        b=IVPw+H+9MtcdNVcE0o+EuQNqWRMgXNq771FErXKY4CKqqICA8Ne8YWgGYR8wsts+mC
         iUyzoiJJL0dIawfODiUfhS8pnP/FasLV64dO8kSrXVb0iddep79jPSrPAnTJMtfhXDrO
         WQzxxW+wPU+FRCtqVflmBKilI/ULBhrZVP9m4uXbaRAW+2Ww2dFr5vHqFDXFLry2068d
         GgERq8mbYxa65KNpqh0fDzOOwfDvzsnHncgI0wI7x8W+0Ymb0mebVVUf8OVKZBNoj7re
         Gykz7GnehPJScVKApB5X2f7XaiPQW4oAbdXs1ZhjTR1YDy3TRFWXVC2voZxKtRiIPYgC
         k/9Q==
X-Forwarded-Encrypted: i=1; AFNElJ914weL6oCi+q2Ptgoz0wIMuUcnkh4QxjU3L+MG1ZA7XikazLAUYkXfNqO3QCeKh0tLFFwyggPDEfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn88qebIZiR2qabXcdhrxcuObTbJnEvxstlGMcYyEXih7ulgDF
	nbvVRq+itFussRTecnO03euHpoqI0WVpWuTfTxWf5Xrytry/N4Oj2TuIF3TCcPBggt7lJIV7/IB
	acay6zV+9u2vhRoneSIo+NAbn36twM8s=
X-Gm-Gg: Acq92OG0IuqugwApLoKy+KVw77RPrLfom3Y33H5W3wbU5rcZVNO7V2gN85+1Nc2DIeX
	SsxZHwnh7tk/hQsBObTt1mJMqjEkOCgu5PgAnKY0eZTtDaSR3qOseUmaRYyUgOUYRrpHnjMcjr4
	3rfP5Tjz1dotL+oQ4PFMiQCqZvRYD730HgqEVs6HCsVWXqdTZL+9P2PAaT7q1+R5euV+rhoxb/2
	o5VJbYM2hfYSBp5v+XJrIjD/8Xa7A3GgGX86mtRlkmeELUnc1O1nMsYZpoo4XwMyCDPebgHkC1e
	QHueeSTqtIs5I8GBB0RwFOD/P5kqJb7BMSX3ieKXtyTwc9mqE0xp
X-Received: by 2002:a05:690e:1906:b0:651:b53e:4acf with SMTP id
 956f58d0204a3-65c79c4e1bcmr23389872d50.26.1778505019585; Mon, 11 May 2026
 06:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510020758.233721-1-m32285159@gmail.com> <20260511130959.7cea81ff@jic23-huawei>
In-Reply-To: <20260511130959.7cea81ff@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 11 May 2026 08:10:07 -0500
X-Gm-Features: AVHnY4JVwVt74p8AFne9jPgsWzoREMqufrpvP7IUlPyPsKSVfN07JtRhDihE-4w
Message-ID: <CAKqfh0EOAie4bjCPaOcocw_N5KpzXoG7hxrT7s-dKpairPUYzg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: chemical: sensiron,scd30: Update
 maintainers field
To: Jonathan Cameron <jic23@kernel.org>
Cc: tomasz.duszynski@octakon.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 7:10=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat,  9 May 2026 21:07:58 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > Tomasz Duszynski is no longer the maintainer of the SCD30 driver.
> > Replace his entry with mine.
> >
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/com=
mit/?h=3Dtogreg
>
> That link is not stable given it's whatever is head of my tree rather tha=
n
> what I suspect you were aiming for.  Use a link to the email on lore inst=
ead.
>

Ah (right, git might rehash the commit). Will switch it over to lore.

best regards,
max



> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml       | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,s=
cd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.=
yaml
> > index 40d87346ff4c..a5b0debe85b1 100644
> > --- a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.ya=
ml
> > +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.ya=
ml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Sensirion SCD30 carbon dioxide sensor
> >
> >  maintainers:
> > -  - Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > +  - Maxwell Doose <m32285159@gmail.com>
> >
> >  description: |
> >    Air quality sensor capable of measuring co2 concentration, temperatu=
re
>
