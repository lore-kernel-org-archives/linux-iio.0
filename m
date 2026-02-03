Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5A39901B
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112263; cv=none; b=kqvWdPb3gY0Z6UmaUhtCZUV+nUhPFsFx9chvnHLNzVA/C9skQ5KCL0oIs7wXpOLpuyypHA1saUSwqBqovqCMtan6oSthCh+5VnDowxhWbtwkAJD6/qHqDmzmhelgA8ekhIe2utdX/FwJ6bvTDE3g1MgguJ5RqqxSzG6i2ABseRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112263; c=relaxed/simple;
	bh=DkSIKgWyIDG29wgSRrFPvcMAS6V7iLUJ2uWER05h1MM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qx9rJxDLIjXF7OR4PHB79ql1EktrImI7SNM/zTNvKe1tB74ous557FBbzlnDawjqevLrb+l8NaTDMjmJRqKWeB9UxDjC8YhWVpvREDj6KJm7vbk+/hzfLtxGhhBgd8yF4YZI9q+OmXBXW8GzBLsNK/qQrlFk9u/G8PEDklmYHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5Fh3S58; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5Fh3S58"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso25494095e9.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 01:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112260; x=1770717060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o6gokshVw0Ds9gKDXGs/xmtEdohipnM6SCAVUEq4GjY=;
        b=G5Fh3S581YFpDjdafl8JlUMAH7e9nZmxrkHFVOiA+u0z1KLBo/CF6sYIYNScjcs2TP
         ty6v6Dg+YG1LaVRa52LTsFPa1jVt3pOtSm/ehnA08wQ5ltA4qYwDe3SqyDtPBCrJ6gDQ
         v648eoV2u52TiR/hHDVGKdlCYrvxcpJjuM2LVj2EuQP0ZCyPYENvQtTByOf0xK6aW2n2
         bW//UVB3E+lC0ofWn0Khefqq3J/4PoxnzLGK5ydWenASH7KCYU5VOjUmnVnf1D/qSSZ4
         a4Jm6Xzi7JhaSxu1XwUzzCXpYiHYGd+GM/sKjfMfzuyxKrtgwjeUS9aU5evqWnjE8KFr
         H9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112260; x=1770717060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6gokshVw0Ds9gKDXGs/xmtEdohipnM6SCAVUEq4GjY=;
        b=OcH9cClIsQHGN3500ndfs3dcUaMZl7wKkeiikI6AU4bhVMA9Yo94nmMzYzU7UkueSn
         tGuMTCej+AoOmivADaSIZeWxsaO4qITT+PEM6UXuNRVBM3CGN/yBCgQvvstfxI0r4dGk
         /oy/QpAhAuX+H1noO+R6GKNjdM8CbAIcVUBDdUIU0HO2B9EW8oC1UDfxBX6Me//incwu
         EpqkiOys6AG0fz3W5XkvDdNwudctFuM/5C7hkn2OMJLW5zlZUnAxAyimPd3RQ//yTVgA
         c8ZANbmVNKwiAP5+2htRLYaLbpiE82uuOA9seFy9+YeXA7QjbofTEVwkSsN8X0myiPeC
         cG0A==
X-Gm-Message-State: AOJu0Yxlz6gAJ6abGlmQYRtCylGTYet5TtLWLC5fGA2/+Tpx462FMIGH
	4HMw3nrL42i5hKqIhIyjDsYfgDh5dRfdVZc5NO5oduGJPONbD2AY+/Gt
X-Gm-Gg: AZuq6aIHUb+jlSvPQ2Ce7GKuqtzNj4+CmkSLvu0X12m5tC/M/i1rIpDnx0XsrJ68hYc
	McZtzI8EfO6FPZjiiMK/jGtrXrnKyTgyLdZUA3exGa7S9x8yyvT+a8hC3rWy3k8IkirL/3QNrRY
	pLHwHtj5A4aMTyuPJveFhavh6me1Cq2/bWyEMG9sdHNqaLf8qYcxlDYzhBi13VPx3M9jNrLx9Xd
	teIWl3K6rMYVAkj/TCKyoJqaRsuv7WPjQIgUJ4Na475grDExeKzCk4wS2u8j+X1nI671uR1eBKj
	GR0AFSG4rqCX1NSGQRdgtaWwEkoEhujTnn7nHBqEKQ3/wUPVDsrBg66w6cHiRelPnsDw0H2GBSy
	HLvjX2zV0xUbK3sjzkBNIeHKjdpyFy1hf/FHy0DpJIxemC1qMg3gtqIkQHBkVFzNn2LfGHSBmBS
	DlabMZopomKeia5A2+8V0=
X-Received: by 2002:a05:600c:8b26:b0:480:426e:9d38 with SMTP id 5b1f17b1804b1-482db4e5cb1mr190522935e9.27.1770112260126;
        Tue, 03 Feb 2026 01:51:00 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830512d634sm79886835e9.8.2026.02.03.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:50:59 -0800 (PST)
Message-ID: <db4978d8a8c46844c6c80580af626e7340b28e1c.camel@gmail.com>
Subject: Re: [PATCH v5 4/4] iio: adc: ad9467: check for backend capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Feb 2026 09:51:42 +0000
In-Reply-To: <353d33f7-995d-459d-aaaf-64bf76df7e14@vaisala.com>
References: 
	<20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
	 <20260130-b4-ad9467-optional-backend-v5-4-7da803ba7326@vaisala.com>
	 <12b0fbc2f4c3a6be86089d9cab73cce1c3face0d.camel@gmail.com>
	 <353d33f7-995d-459d-aaaf-64bf76df7e14@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 14:03 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 02/02/2026 12:42, Nuno S=C3=A1 wrote:
> > On Fri, 2026-01-30 at 09:17 +0000, Tomas Melin wrote:
> > > Add capability checks for operation with backends that do not necessa=
rily
> > > support full set of features, but are otherwise compatible with the d=
evice.
> > > This ensures a fully functional device, but with limited capabilities=
.
> ...
> > > =C2=A0
> > > @@ -1263,8 +1271,10 @@ static void ad9467_debugfs_init(struct iio_dev=
 *indio_dev)
> > > =C2=A0	if (!st->chan_test)
> > > =C2=A0		return;
> > > =C2=A0
> > > -	debugfs_create_file("calibration_table_dump", 0400, d, st,
> > > -			=C2=A0=C2=A0=C2=A0 &ad9467_calib_table_fops);
> > > +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> > > +		debugfs_create_file("calibration_table_dump", 0400, d, st,
> > > +				=C2=A0=C2=A0=C2=A0 &ad9467_calib_table_fops);
> > > +	}
> > > =C2=A0
> > > =C2=A0	for (chan =3D 0; chan < st->info->num_channels; chan++) {
> > > =C2=A0		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mod=
e",
> >=20
> > Change the permissions for in_voltage%u_test_mode so that is WO in case=
 we can't
> > IIO_BACKEND_CAP_CALIBRATION. You can even reuse the above check to twea=
k the permissions
> > accordingly. Then no need to check for the capability in ad9467_chan_te=
st_mode_read()
>=20
> This RO would be then only for cases PN9, PN23. For the other attributes

> RW would still be applicable. But basically I think the test modes in
> the device are still available even if the backend status does not exist?

Yeah, they are. The backend is only validating the pattern to make sure it =
is what's
expected. TBH, I'm not sure what's the utility without the backend but I gu=
ess one might
want to connect the interface somewhere and check the patterns.

> IMHO the current approach is slightly cleaner, as all the test modes the
> device supports are available and no need to think about which ones have
> RW/RO inside this function. Please let me know, in case you insist on
> this kind of approach.
>=20
>=20
Ok, I reviewed the code and I see we still print some running status for al=
l the patterns.
Feel free to leave as-is then

- Nuno S=C3=A1
