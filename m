Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CDC3C5853
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600795; cv=pass; b=aY23vkByRsBMhsBX39ANLmxIh/NRBVNfQ/L9dj81eSE/RCiUa2imjin7jeDTHyGtLYymcLSCUIZJodFhpmlruZkKG4vno/AsEWmQOUAhQTGYeZ7GLf1KsgaQUqtesC4yiD3bcP5tJ+HK/zZMbi3WiLW2lFbosHnJFLL2xbWuKYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600795; c=relaxed/simple;
	bh=MlqmcRfcwklEFYZj4ORXJCCotePm2Hc+RRIBORt8cgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQliiFSv+IXTXnP9RHBYwI5NI9f8+eSkzy2gHs61wCFjhFZCl3ChPaH4Q/Bvc3QhM4TppQOH9K2ljPFzmY6RptvB/fpqugiJWFdIV6fM9l8F+yJ91wygXaDu4J63wI0in7OhaJ66naRMBaaBn5ygLXyxi21lp88gpyVwNIEIdR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ekSFSDKj; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ekSFSDKj"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6804e24803bso3719188a12.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778600792; cv=none;
        d=google.com; s=arc-20240605;
        b=igwaYnx6dYWRS6v90qyypoFitNx6eXu7IUaQimBUxZyx4+K98YUVEOBlEujWbIVOa1
         PziA0ErYrnH3v5Zmx4/REJpSeEraNfgkeCTb6LCL2H165UL1xr0Ni5TNa1I+dXHMIRbu
         NY2IfGmVKqSSOOlFulaLUIRlR2wtHiC4WofpU3E6gDpV5HLB1txwBsB956UngV1vF3IS
         9MXhOeWd7wTLnAQl5dq5W4otp+ksturvGFioHZWAfsB0RwhGjXKx/zduU6DhK8Ku32KF
         O2r/fCABL+ExV+njH3DAZRakZ2PV2gk4wqXgOweTSPM0sqLUk5XaudH0uGGVmm32pZRC
         I1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75qBxmQOIEAlKUJsCU6kHkks8y+FZFXi5YOHbTzTprU=;
        fh=GQqTEiSJe2P8bAk/mf6QSq4puMtQJBkMuWqugSt0v6o=;
        b=YKrtz/VSzJHPjKkLZU216qOmTvOhXOLYZCLc9UdbOxjKtMFqRv6fUCUR1c0EWBNkQJ
         uoMh8S6Tw+AL/51RyxWB7PkXKup4THDUXR1SGHIL+G3RZ1PQ4BCSE77LtC0zdfrQyXDv
         /K1CViG5Gnimn/VPdmUYgLj7FgDtjVRMqOS83/qrOC2vUTHhaPOSvALcBGeNRtCuOXEi
         pDNHCDTsRleG5gsrUnedoVi9/vvYfg3xuWcybjLHjttG4qk5llycYX+rnodspsYSIS+4
         6tMVShYb9me/jFSh9iDHdeHEntz1hHQGINmOjEYTwdEwsk2XnT37XqVrluN4cH3RC6jN
         KMkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778600792; x=1779205592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75qBxmQOIEAlKUJsCU6kHkks8y+FZFXi5YOHbTzTprU=;
        b=ekSFSDKjbsF0IfYbY0rnMbCptM+sVsJzrUxI7gVAX3ISB8XHIPjH9hmMluWbfAGMbc
         dBpjdODCPPCxqywIeMgFiv/epiMSIW/mWl76zFdXVpf+LS4WGtHVS1BUIgTBuvHoJ7Ie
         I6QVNoIhZBuuCfI52OcX3ZZJsWl9YaAbcoPC/4DaRCig/tdKj44aIeoFZPZO3kxyh8dH
         IQ5kBRfkV7GF3SLiyF8s685AZSDROlMNq4xmh3rEp2bgkrgmEuiQS4YEhYC5uLLcALbI
         gN1VDfZIuA8Bc2A6AAYAxgOrxIcSVS5CPnFI/hWbc4Ml1YwvxLPkOel/N06YfhqSBqXo
         bxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600792; x=1779205592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75qBxmQOIEAlKUJsCU6kHkks8y+FZFXi5YOHbTzTprU=;
        b=k3zj4BKpN8yDqdG4Y6UY2MLi2wkaY84aO8U4muenbeza4kJYDH3PnQDPaG6vwMTCJY
         Mm4rrJHFDLQJnLH3s6YFK4JBvbtxf0W4/sL6ddkWvt9IpeyB3FIsvGoHWmq36/y25ILv
         K7sXcMErELyBPGYNBbHm/sydM4D1pUxd1kCtSX5JYFxlnKzwnRLE/5yK0HELrQadCvgA
         NJ0Xo9AbstG8q4e47XHh9RlOiV8gx7y/xkroc3jEBTwnShboOvDnN/qwK0SR0wCFpNdb
         ELHEIUXV6XEVwFh6qmmSiWbS2NQYCiwn7y+Fpa2nj0TyVKwckLtZh2QaJ2HIPox/DuGu
         lDrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JHRK09gzXYPHb9R4s+SLZ3XNkilH+euqooRYY49CQSvCUvLi+hWisTTJe/WFou8mJK6akzO1Iu08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nknNYwJEzfm2iRPDFp6b7Eov0nkfORJ+kQV7BLSj5UU4crrK
	fYy3oCtmajvpfIjFdzpuxaLhGL9l3J5GGuVFcKkdPg9kSW4UWkknBLV67eATjgUPSBVK1e/7N3f
	J7WEx4LnDYEAbgAQRWAPylR8cEREgIaacU9dUX9kE3g==
X-Gm-Gg: Acq92OHe1rN/1I2E2+c1GOKubkhJQC5wV5g1fkPRR+W0zxhmXshd/F+4/Dt1t1s6DO5
	Cj740vCcQQ+rNsD2w20QW26/prOGoBwEQEVxQxV5dpLvLPTIXL6cZowQLfH0X2PbhXJqmeY8AZq
	3a1q9WniBR1dxqMZke6ojgRw7AVPoF1PWUo+yd9fcpw0sk20Jv51JcfphLAsDM0rAq0n5iIe053
	015P33oAqEVhZPVsHsa/glLKlDmkhrGO52gBTFUTEt2TcL3EpOoaxWrSb0nAvF7fudPeEHqfOnf
	bocNqkQyXDyIkpbHfLFrMVeouWWSRa9p+qUuj46+cIcSzWzmdL1Z9tzCuPpyvg6rynGL4Q9vwdW
	4rVtVBKc5vVhhtOm3EMvJavGz
X-Received: by 2002:a17:907:6d10:b0:bca:4861:65d5 with SMTP id
 a640c23a62f3a-bcaac35f762mr1082691066b.29.1778600791859; Tue, 12 May 2026
 08:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414224245.8493-1-guilherme.bozi@usp.br> <20260414224245.8493-4-guilherme.bozi@usp.br>
 <e84d98dd-c81c-418d-8cbe-5867f8bdd4c3@amd.com>
In-Reply-To: <e84d98dd-c81c-418d-8cbe-5867f8bdd4c3@amd.com>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Tue, 12 May 2026 12:46:20 -0300
X-Gm-Features: AVHnY4K46d1uZa3D0VTlOTLicMN_W7masSFd8TRMYjScY4EWQs5rQm5x0V1Tk8Q
Message-ID: <CAJgF-xt5UFzPsBXX-MUNOmqBTjZrZC8Wj4DTtqHehWCjUfYfFQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: xilinx-ams: refactor alarm mapping to
 table-driven approach
To: Salih Erim <salih.erim@amd.com>
Cc: "Conall O'Griofa" <conall.ogriofa@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Salih,

On Tue, May 12, 2026 at 11:34=E2=80=AFAM Salih Erim <salih.erim@amd.com> wr=
ote:
>
> Hi,
>
> On 4/14/2026 11:40 PM, Guilherme Ivo Bozi wrote:
> > Replace multiple open-coded switch statements that map between
> > scan_index, alarm bits, and register offsets with a centralized
> > table-driven approach.
> >
> > Introduce a struct-based alarm_map to describe the relationship
> > between scan indices and alarm offsets, and add a helper to
> > translate scan_index to event IDs. This removes duplicated logic
> > across ams_get_alarm_offset(), ams_event_to_channel(), and
> > ams_get_alarm_mask().
> >
> > The new approach improves maintainability, reduces code size,
> > and makes it easier to extend or modify alarm mappings in the
> > future, while preserving existing behavior.
> >
> > Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
> > ---
> >   drivers/iio/adc/xilinx-ams.c | 161 +++++++++++++---------------------=
-
> >   1 file changed, 58 insertions(+), 103 deletions(-)
>
> Two issues:
>
> 1) Same tabs-vs-spaces indentation problem as patches 1 and 2.
>
> 2) In ams_event_to_channel():
>
> > +       if (event < 0 || event >=3D ARRAY_SIZE(alarm_map))
> > +               return NULL;
>
> The 'event' parameter is u32, so 'event < 0' is always false.
> Either drop the < 0 check or change the parameter type to int
> if you intend to handle negative values.
You are correct regarding the u32 type -- the event < 0 check is
unnecessary. I will remove it in the next revision.

>
> Salih

--
Guilherme Ivo
