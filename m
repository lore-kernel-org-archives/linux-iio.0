Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9D3C3795
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600423; cv=pass; b=jnDdhILwgp2vLtcFVAgUlJDwo1SClJN0RRCRQe0BFu1S7SpbSxkEg09Iv+DoRtbLeqGdmGwiXHRpYPv5avBwCmeCxyC5A2Pb1WH/TbacQTAuI1e5YExvnRbg22WdG+kaZhZiTGOp5QSx+A4MWH0dDYRdofxQuQsnuC7Ie71sESk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600423; c=relaxed/simple;
	bh=4AQME4L6sewjhVAMWECxdH8sk5OjMicXFne3MvxcTps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tR9954XJ3V3eqiLMjZwvYRcrS/U8oewfMD+NPQh9LPIm1Px+hvc7tfln7r9AwqcosCaogXtAKr3yS/vVfZLNom1KMIQw3GwoUDkggjKOBv+1wMidlzAh58Ao6eGtAE1pGlHK3fMuqe7cDb6ExFpTHMd8GVdoMSWVqwy+U4aq2PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=FwKBtGA1; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="FwKBtGA1"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67e2498f3a7so9365935a12.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778600417; cv=none;
        d=google.com; s=arc-20240605;
        b=Nf9zNjpn68u71ES1N5nNPPl2SdHexzAQWCH5OHr/u611GeQHTH8vVuvGlMbD716Q9Z
         4J4duirB0q9tNTWXT1N+YNJvaIow0G3RmlrW+W0zmQhfbdsm8iB7jn01ogGiBjCzCzdE
         s+lOaQiaPYl/xcCkatF5I5DGtsqO5JQ8kZnuZyHm5fJxusjYf6qcJhynnUwFNsSfbcty
         GCyBg2X48Sucy2V96q+pHYMD50SzHL0NPmnhPz6j8Vk0BcasuLmPVJquMNCmEF+6lSeN
         F50wOFdn04ZxNZemHBWVtWW94pr8A4Ew57v4I3S7G0CeMxcYoNKMj5GX2JY3bU/TNUUo
         wOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=opDVr+s1DFu5L5mMJ7uUsTv5OPxr0sn3kMdro9J0vTg=;
        fh=A1/R/t9us2vrnJFSxFrGCOZEEHAjsxMTTcXiAePh27I=;
        b=EkZltKmAK9mOI9D82MI8HpqDi4eysCCFDtDob/vYeta7w5kXbrUn/7FEU3spyPi/UY
         Oj97ikrEQWuwwEXy6k93kVTSG3/OwjD0j9GRO565uRgt9w7pXhfL1L9Q5zotsUsIqefq
         7D0nlKQzOx6MNnAqsMqDuirJLaSTRu8iEXJ3mr4ZoL4WoDHn2FSsgX3VJhXPwknCnMLA
         cYt1+HCj03Ehn8gPpbTlHXNeJg1zBGd0SJlPRkQc3a7Aqmb9q8QY2EatAa0ZdAmWRHPA
         cKZGFErP66do66oS0UeiejcBGRmdG25JsNWY7bYSLeQH2zDbp3f2nCok+TZpj9iEzT5G
         2opQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778600417; x=1779205217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opDVr+s1DFu5L5mMJ7uUsTv5OPxr0sn3kMdro9J0vTg=;
        b=FwKBtGA1TSQQR8aWWamFaojZpyX8+jB0iD2fHOr42dHfhrEdlEOqdRgLm9jHHPl6Bm
         R9lt1Jezs2HUpp/YZRv3dzUoBDgN6eAnNXgU4LqIcozcWAdDXbTiIgYumslsjDIQKyEa
         wEWXzXGsLHBTREaPNNodvB/vLfN2QE7PzBr/Vt9Cel9DqMB8nveFCCMP1niq3STgGNdy
         SM4JfjiKsjpFcurh4clF6PvWY6NpJ+9dY5ktGrxfSgQGg6RJ8gkMvE6JXLrrrhK6yyaf
         2nuMo8qIdNm7+rPlO2edlXegiV521lUy0TxVvEIUdAUIOYg6dV4YGl+tXGeepQ4tyzDj
         /lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600417; x=1779205217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opDVr+s1DFu5L5mMJ7uUsTv5OPxr0sn3kMdro9J0vTg=;
        b=pYpxQqca6QRDKkH5eMoM+bqLQQr1ap2v5DV7unMzPr6autjJ0pRPShxxIJcFfu7Eqm
         LZWnpUyY3NCx6wgiMszmIzK++tnCnk51ps2Npvm5fWzyGQ1azF2YmvQ1tGuDHMZeJyi8
         s9YZnPidVNlBcBv8MnjEpJgcL8LtEmRbsuEW8nL/TsU4djdcROZTvl+6OuUy1MST2HIA
         B3OKEeCicuiYs7uxjKuOrqPzW2QMD/DNsC4QKMpD3V5HC67cmoyWYm927CAmi0qVnJdS
         zWg7pmPPOHO8mbpUce9qCQ64OcBJr0CWb7m2hycjDkXsnX3jTIBbj74I1FgA4aDPDkhb
         JEUw==
X-Forwarded-Encrypted: i=1; AFNElJ/QMXUlRF6dBmp9R/+4qzG7xPme3ZTPDd0bTvObAS15lNWnoUy/uw2hs/2hBDI5c3Q+Iw713Ih+MoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1h3MHVhu+xjsI985Gvx1Oc9MagprSUKbgilAgYxzfPL9EPSzG
	oF7HRVYjjKN52somLBXCvxPnzdudWdbt8A4dxT5ivgpmwn2b72/pR1KNcKqyp1wl/nD0OxPY78j
	hNVsJ4yFMxjZpg+RL2fdg0WJWIWjbLtZh+YPFI7aepw==
X-Gm-Gg: Acq92OHhq6HxD3gcvq78HnxUAjWgJG3a7NDjeK2rpj1agKtrLTJp5lw9kIE7j/H561M
	Ta23NJnIEB7saXfueRtacdmtj9/tCupnJeAUjVJZ8x3hyABYb3V4XR6eJRpCZ9cqns+ySXDky4Z
	GB4p9VopvQjZuy/xCslVQvOMB2zEqme1CRS9tu//HQLhZEguxH1r0p+dv5wx9HrxAFbB8tA4XSy
	TYRxDRoP9IjaAjVuUleXpEOYGQKMGwGGlFkIaakj9qL8YVjPHtwIhMRC+3kBtM9S5rnlp9juO/b
	wUhU3LWX7JUHlld6+nb9cwIqt7HBwiG/GAWrQ3Ehduew+7axHdTrNZvbxTAo3XSJ+OQ/FR96YwC
	dBHCqoYVa9Jp5nOYIzKUmdZjW
X-Received: by 2002:a05:6402:4287:b0:67c:5745:ba25 with SMTP id
 4fb4d7f45d1cf-67f6f92dfb1mr7850023a12.0.1778600416902; Tue, 12 May 2026
 08:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414224245.8493-1-guilherme.bozi@usp.br> <20260414224245.8493-2-guilherme.bozi@usp.br>
 <46bcd2ce-bfb4-4fc3-b840-dba657f39a7f@amd.com>
In-Reply-To: <46bcd2ce-bfb4-4fc3-b840-dba657f39a7f@amd.com>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Tue, 12 May 2026 12:40:05 -0300
X-Gm-Features: AVHnY4LuD_JM6fJqTdYObcsdA2nHp5oI4cLiHc8_spvCDFozbdqw82SA1SS2kjY
Message-ID: <CAJgF-xum3OQ36keRW5gCnTTbnUhsHZUzL41xKn0hjJ3GqgyOZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel
 lookup in event handling
To: Salih Erim <salih.erim@amd.com>, "Conall O'Griofa" <conall.ogriofa@amd.com>, 
	Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Salih,

Replies are inline.

On Tue, May 12, 2026 at 11:22=E2=80=AFAM Salih Erim <salih.erim@amd.com> wr=
ote:
>
> Hi Guilherme,
>
> Replies are inline.
>
> On 4/14/2026 11:40 PM, Guilherme Ivo Bozi wrote:
> > ams_event_to_channel() may return a pointer past the end of
> > dev->channels when no matching scan_index is found. This can lead
> > to invalid memory access in ams_handle_event().
> >
> > Add a bounds check in ams_event_to_channel() and return NULL when
> > no channel is found. Also guard the caller to safely handle this
> > case.
> >
> > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
> > ---
> >   drivers/iio/adc/xilinx-ams.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.=
c
> > index 124470c92529..6191cd1b29a5 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -871,6 +871,9 @@ static const struct iio_chan_spec *ams_event_to_cha=
nnel(struct iio_dev *dev,
> >                  if (dev->channels[i].scan_index =3D=3D scan_index)
> >                          break;
> >
> > +       if (i =3D=3D dev->num_channels)
> > +               return NULL;
> > +
> The added lines use spaces for indentation instead of tabs.
I checked both locally and the raw mbox from lore.kernel.org, and the
indentation uses TAB characters consistently (^I in the diff).

To verify, I inspected the relevant hunk using cat -A:

^I^Iif (dev->channels[i].scan_index =3D=3D scan_index)
^I^I^Ibreak;

+^Iif (i =3D=3D dev->num_channels)
+^I^Ireturn NULL;

^Ireturn &dev->channels[i];

I could not observe any indentation issues locally or from the raw mbox.

>
> Salih
>

--
Guilherme Ivo
