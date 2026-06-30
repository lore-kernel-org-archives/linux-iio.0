Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E543D890F
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796340; cv=pass; b=IfBo4Q+Pf9NeF/Ww3rdkjhL3XXqoYWkl6MFWONsC+uFpZ6iLjf8dI2+wN3M4P6odVHczj6cwQqDWNYUYucklNJokyt/onxZ5DCgcHvi4hySIfFVE/JoOs6GX3Z1VTa21bBbdhKVOhuV+4xNj71octl+8D3GsJcN7rXH6yEH9wlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796340; c=relaxed/simple;
	bh=Jg2KFnUPXXVh2w7pTC0cl0+cUJGWiqwyAJlmxHSLgmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hI88figrJKgNxHiKUoFRLSEyO9gfEBZjiMDif2zQTtZKizk5L+mDHfl+DV+yqbO2gbVEOgRrWvkVo+yljFfNL8uXBCZtXCd3sbGNu8t+IbM4PUw9hlmRoLlcfl4ka2+/WyWifmaQ9FkPfnIlm88yRHdRUvP/9TngPou+ZSN9KhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV8ju92r; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV8ju92r"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30e7eb50b83so2756656eec.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 22:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782796338; cv=none;
        d=google.com; s=arc-20260327;
        b=DEp/DzGJ+2gdiFHHeFRSLArd829xfHNyDxs/zH8/zyOnCnZvCr+wS/1jpTC7f3mxRk
         Me732lLTE61gxGwsPfQOJ9Szq4qxrzTUCNpPR02EB4auV8uyCMz08vsSajPccTp/b7cy
         mitwb8Fpl/wzzmIaf+/FkJdYPBD1hPDebLXSOiZ2/AuJQCEKDCYr/iKmx6K9pPMAynv5
         OaxS1Ekh/mzwJGjr1zUVbaggi5f51xfUh9oC2WGw41tGr1XhIQUtbwMXUMHAPyPBpufk
         q9lDKEk+V1lG2TyEGd/pvuMjuFJmQl2QnHZ0HBaNRvZEVbdqpYV0JeunEHr5gbrSpmr3
         vrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nK415PdI5kDIUChilJR/Nj79A+EUwz7TNDqGP9JEC+o=;
        fh=vlxeur+TI/Ck8ReLc5sN9Xrs0dSG7w3qStmI1kssMI0=;
        b=OaIP1bK2/8AGUQVSZybaFYDIMCDwdioR8zM921W+MHCuAPXd+TfamoNRBVZMfPDBmj
         yBSFm2It939+5j/n3l1koWcg9APh4N3q88Z/WnnTSD31+rxB2JV2pwQXtcYZh0NidKFM
         tabzmeCGDS3JcIiHdvet09VgOlNpk/kZBmKwS5UWRF4WnZRSvTZwGeDllmRY8DfUT86P
         Pxtz178MeIVAYGseYQgKqIznCohPU5YDZyB7vSzmuJypTTcwtYt/Nza/wZb64rhZFcSv
         sZ2A3+lOuyNIv01qRV0C1y5W7YpssotNild03/pgVNm2IAen1rZssxgWbWizMbWHMPi0
         G/wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782796338; x=1783401138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK415PdI5kDIUChilJR/Nj79A+EUwz7TNDqGP9JEC+o=;
        b=mV8ju92r7uOn2Vc5X3KF/aO35sAnvxGpHAEEtkEwxYqBpoRIC0O8HGBLhigIazDu5C
         CMz9Tky6dBMv+y1GWeiKmZ9I4WZJMSRswHIrJvBxWuXPD6RZBVMgZbK5A1dBObS+/mTi
         50EBpFSpf28gbnuCnUj3xiC/nAajU1slP01IqJnu4s+tUEtDJMS37gB5R751kNdkd9u6
         0Rl+F/wCIL8cCVyCVPqVCjrqS/iCoyFnWeBUfBI8eM/i4+kdmVpCRCCv+AGBK2OQc5eH
         QVbRS5M2jgNEEnPoYzRm5WwmgopdZNamqhhW2Ud/XzJl+fRjoJakmL2h0LJeFKXVkrQu
         jKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782796338; x=1783401138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nK415PdI5kDIUChilJR/Nj79A+EUwz7TNDqGP9JEC+o=;
        b=CiiraMlLm48Rijk/LWPW0JxViVzaU5Xz4G9HCi7X7Lgt3oo1Xn3ofw9hI0KPulFfOO
         4swG/ThN7iTtTOk9zeQ5HPglNlMNM3GWvjG8M2mXrzrGoXec7hLuwZixdLpKUU2p+Q6E
         J/pUxP3zitDl/LI5s7PNgQcnNS9QTUaGfvj2PYSZ2xfVjZdrHAwE7+LVTwR0+mmnfywT
         zAunlPn4OvKvE+DbJtvIo0+laNB97AVu1u4OWBB7D4G9G/3b/T+Urmtuxw+rimrVWSgb
         0d1WN+K+Z4xKXiIpjd+HHyLtF2PrzZXWTzDgJuG482UGlC9jfb7FoajxDPvJhTRtrmVJ
         j6gQ==
X-Forwarded-Encrypted: i=1; AHgh+Roib+ZNIdNdE+w1GP4OGrfBo8IodcL7cfFT8OZJN9Ojk9rniYRkTKHb3/hxVAzibLsqpAXuTLAtEdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcu1dglLbGftt+MNEdJn3fMZbOPqUNePpoXubIBgRVKuaOqnKM
	3MOv3lnTVm0ZSBgflIYvgzMQ34c2KuYTJlObDTd/K0JvQpfEFDA00j0TQZzfZ672cbBldf3bba6
	Q0YDRCn2rT1st21rWdlyP7kTzSOwjqgU=
X-Gm-Gg: AfdE7cmk+nMKsT1HsTSWJ2bUj4NsyRZjRb5a3zVix4bSrJKaiQMVtR+9KElSWNQZR+5
	tADqhNHFEpnIsXz6UC0HgGl6jW6MRt+oN7WT2kuZ1wfvwbqqJsCx7OfKbvvB6pmssqChUQSVyOr
	IUDNgm8tgRv1rp4rOqgE3kpICe7+qo8zMPyHQ8qQ6zAzfiSjUX5HcfKzqEs+yG3jDEZIz3WDymS
	PVXqDCfsJX+sOSm+q1cNdNPa+pGntIQKd7wtIqVXdKL45+MJoiQZrC9++5csC+eFs0EuHKkIEqt
	79KbBJC8PcZLojFXOV1fWiidC6ZhkNgcrcttZXow/Y8GeTqxLie5TugQJ2/7kD8R29mvnQ0=
X-Received: by 2002:a05:7300:fd10:b0:30c:b4c2:e46f with SMTP id
 5a478bee46e88-30ee13a132cmr1443873eec.36.1782796338376; Mon, 29 Jun 2026
 22:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628191337.937-1-kimjinseob88@gmail.com> <20260628191337.937-5-kimjinseob88@gmail.com>
 <akJ818gkVzLN7HqU@ashevche-desk.local> <20260630000623.0c030d5f@jic23-huawei>
In-Reply-To: <20260630000623.0c030d5f@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Tue, 30 Jun 2026 14:12:06 +0900
X-Gm-Features: AVVi8CdocNxkcjtLkEqmDLkN2xM35fTtk5KMTfZs6X8uWqKmDEmufDHm8OnrplU
Message-ID: <CALMSewJo-tnQL9KRyvABHpAf0-k=yOd1N=JzgK91rk0R0j_CBA@mail.gmail.com>
Subject: Re: [PATCH RFC v6 4/5] iio: osf: add authenticated stream parser
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood. I missed applying the earlier style feedback consistently
across this file, and I should have explicitly replied where a previous
comment was not addressed.

I will these:
- reuse the existing OSF magic definition instead of duplicating a byte arr=
ay
  in the stream parser;
- use loop-local variables where the variable is not used outside the loop;
- rework the stream error handling so authenticated and unauthenticated
  failures are handled deliberately;
- either update partial_frames where appropriate or remove the unused
  statistic.

I will also check lore for the previous versions and track the earlier revi=
ew
comments before posting another revision, making sure each one is either
addressed in code or explicitly answered.

Thanks,
Jinseob

2026=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:06, J=
onathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, 29 Jun 2026 17:10:31 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Mon, Jun 29, 2026 at 04:13:36AM +0900, Jinseob Kim wrote:
> > > Add a UART byte-stream parser for Open Sensor Fusion frames.
> > >
> > > The parser searches for the OSF0 wire magic, keeps partial frames
> > > buffered, checks header length and payload bounds, and passes complet=
e
> > > candidate frames to the core decoder.
> > >
> > > Rejected candidate frames drop only the current head byte before
> > > resynchronizing, so a corrupted unauthenticated payload length cannot
> > > make the parser skip later valid frames.
> >
> > ...
> >
> > > +#define OSF_STREAM_MAGIC_LEN       4
> > > +#define OSF_STREAM_MAX_PAYLOAD_LEN                         \
> > > +   (OSF_STREAM_MAX_FRAME_LEN - OSF_FRAME_HEADER_LEN - OSF_FRAME_CRC_=
LEN)
> > > +
> > > +static const u8 osf_stream_magic[OSF_STREAM_MAGIC_LEN] =3D {
> > > +   'O', 'S', 'F', '0',
> > > +};
> >
> > You have already this in the header (as FourCC), use that.
> >
> > ...
> >
> > > +static size_t osf_stream_discard_to_magic(struct osf_stream *stream)
> > > +{
> > > +   size_t old_len =3D stream->len;
> > > +   size_t match_len;
> >
> > > +   size_t i;
> > > +
> > > +   for (i =3D 0; i < stream->len; i++) {
> >
> >       for (size_t i =3D 0; i < stream->len; i++) {
> >
> > > +           match_len =3D stream->len - i;
> > > +           if (match_len > OSF_STREAM_MAGIC_LEN)
> > > +                   match_len =3D OSF_STREAM_MAGIC_LEN;
> > > +
> > > +           if (osf_stream_magic_match(stream->buf + i, match_len)) {
> > > +                   if (i)
> > > +                           osf_stream_discard(stream, i);
> > > +                   return i;
> > > +           }
> > > +   }
> > > +
> > > +   stream->len =3D 0;
> > > +   return old_len;
> > > +}
> >
> > ...
> >
> > I stop here, because it's obvious that you neglected and ignored my pre=
vious
> > reviews. No explanation given, nothing. This is not how you should inte=
ract
> > with the community.
> >
> > Come again when each of the given comment will be either addressed or a=
rgued.
> >
> Likewise.  Please make sure to address every comment either through
> changes or through reply to the earlier thread.  Perhaps some emails
> have gone astray (it happens!). It can be a good idea to take a quick
> look at lore.kernel.org to make sure you aren't missing any feedback
> on a previous version.
>
> Thanks,
>
> Jonathan
>
>
