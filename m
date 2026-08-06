Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67826ED41
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984723; cv=pass; b=SCF+2SZQsB/QIL+eBXttKQ09ohgvnQ63Q+gf9c26oYOaRc3xA/XMmdfJDT+MZvskyucL3ELLod8QFTIVTEiZutZx7SaiM6+8bTQrhce0HrJE34K9s0z+imiof7SEiXoZz1QcKbSfCJ8Hlae4k83p8toYdu63vaDe9XGUdZ3Y+2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984723; c=relaxed/simple;
	bh=BofN+QkBqcBCXaM7Ffk3SnOnc6dFmU5Id2Z8stGZ/CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb37Kxu6GGE/bt9tHtPo/bkfqiWhl3ladAOYdm38ZIRFn59yc6wWP9Vk2nmqMrdMASrDT2GkoZv9cijFhbkHR3cs3vFLGpHcEr9WIer64pVSXr6grLbccic8vcN5xnSStOH69RsrnN7/HOQ5lwvBomZalrjF2zHmvVgIYU9nYEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP9HOzyJ; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP9HOzyJ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39eb257e9fbso11888731fa.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 19:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785984720; cv=none;
        d=google.com; s=arc-20260327;
        b=E+d/Hn3vrm+EnkeoCQgEX7Jei+2BA88IIga5OR2rtOi8LUyGTrBH/mrlBaLadMYHGx
         NtAerF7oV+z36KWLS2MhowbhAKV65QEMh1giyP9FYX3ixjCbknkajnhXM2vTaIcLiN0G
         KqHKF6LspbW0zUdEZkSePsvpOO8CMiz6qJUo0AH7XaiF0gjQrqnReGMOd2GTFrh+fpKA
         TL2q7z0QpJ8KA+OnsLErhJoEukiyCGtNihqPLNekIWCQLmrLyxL/jCKVP6iPNbio14dF
         cxFXXR6XGJj/DPnjicU693sJbJef814d4sKtSzQCByrmGhwQbX9kTM9hEcRAGksLRUdZ
         d7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LH9Hb22G5gTotHoIdzC5eUl1OJHBKnjFRO4+QY5Ci1U=;
        fh=b1VQyZg2414QazJ1tIO+/US14MZuIMCSrop7/6azYgQ=;
        b=OQIR8aP7KVw8UEe9AJ2OrmG9/eIjL+nFEd3B+WFtHZYLMrWN3GTSG4OvFBgtcgJxwI
         Htj0XDxZXMVt+PO8VESkFZ+JkmXPP7Hu5+6R9+Bev70Hba8tb46cTdFRSz4mCDSRmKMx
         Vz9Dn5eRUm/bjfB4ZPywCKea37RZ6fZhXfkYzEFIqGPhTwkJJ4uM01blLXWiH1L2zgrH
         wCVf8ZZji3zlH+hIuxAGwr+TM210JI1Qpo5tMjcWIke1sX743n4QM70ZYBwH6U2qCVZ4
         tXH9rdk0ZO1cPDlESBxI80Y9M6w+94JHBzgkSbnVCpi82LZiq+/pG/tJyKU1SsiVlT4h
         2vhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785984720; x=1786589520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LH9Hb22G5gTotHoIdzC5eUl1OJHBKnjFRO4+QY5Ci1U=;
        b=GP9HOzyJkjXzt2dbcuJG5kY6a1t+fskClpHSqYhiokGzmNXtRKLdGHL4O4KZwMzP71
         ICU16Y+nbJuX7ilIEDlpW6bhGdzxUzQZaRO5bnD0MbnZvcpEjdVlzeTaFX9m6Ip/q4C5
         MHl5FYd6oC0UGG4DZmpJUC/fd5doCzgLkekB/EFxE1zluzLhhQzfdwxb1hGC4iB1mOgK
         5FUbfGiQekZneqmzrSBE+PTWpLk500NsjLgW+MZbPZj21CoWJjNEMasnruGwwMWYubu3
         9/4tE+R21uUAvzif7Tm82tsbdSHKQnBUdok2v8W3H7Ol4w0RlpskRjcgoa0orKPOFmtG
         S+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785984720; x=1786589520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LH9Hb22G5gTotHoIdzC5eUl1OJHBKnjFRO4+QY5Ci1U=;
        b=hYSliaIavqfclF9Hk2woyv+LDXb5P/m3htA3MjP6bLgVgQdq2JkWhXcb/xzzXHNCX4
         8JP/t6tyAefjbzrSFv0OFFI7SaJdKsOpd41O8CEafWE+q5edKlYGe64BPh3LUBNkRO7v
         4L4XGJX0NSMDLW1OU+jwmGEB3GLlXreuZx58qQKEUx2su299aRXZazMpAkvEkrAvQXPR
         DXs0/rJsOKfVna1du/L1/54MwleNcumMUhHYeT3w1nNJYw9T+DO7RUipooRJX+jyDMFH
         z38f5N83ftTKpt0o8j6S7TIcXtbyFsBXc+RnwlqbzNwFIGLAsfOm2PcuM5XyW6NRWMs0
         kJjA==
X-Forwarded-Encrypted: i=1; AHgh+RrkJ4NWECQQQSlbOJE3nFeqELxcIS9DeKY6zRsnMY+Xc3EibxuGL22Uzc91QXX9/bjYKLWd/wVpyfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUMFDQPLtlr854QR5C5yulVdxSoLj1FxK9+e3fK3tH6CGIjNT
	K9IUiIQepjlebn1fieGP2BJv5/YUy3+xdX88JKrG3FE7OLPUO18cldzAfx848IZE3M21AqmzQ9+
	fciV6+iFHG0xXYTK8Tpo6NFi3/yjokiA=
X-Gm-Gg: AR+sD10yoeS+//5yhHLKa7+matR1hl+3jhx2h6WvFtHlfyyxJ0MSd4oFSTBHLne1z84
	F3CArxBgcQzWaXp8TbirDjngWubsEx/ERwWyeU2LkPdvQFjUK32NAjdg+nKL27pfkUlVB3HOsqk
	d5gDvjCjfDhhyYJDwHy7OBGbj4Lm1Rckl66OfElhiBMlZjtN6m8hk/TAswsvhnvW3A4k+wcheYJ
	6EYiSCrcDrAcrKRp8QMWuer6v38pG/dqJ18Viu2E36B+ujw0m2iLX1+K4y0BiQ6edBhet7/4chb
	nDKdFNT8aFSs2IW445kJOVXiaoMO9EuI6ysjg3Xgpn6OHkQ=
X-Received: by 2002:a2e:a99d:0:b0:39f:bc94:eba1 with SMTP id
 38308e7fff4ca-39fbc94ecdbmr12993261fa.16.1785984719852; Wed, 05 Aug 2026
 19:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-4-muchamadcoirulanwar@gmail.com> <anH7kbxvS6z5GlPI@nsa>
In-Reply-To: <anH7kbxvS6z5GlPI@nsa>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Thu, 6 Aug 2026 09:51:46 +0700
X-Gm-Features: AUfX_my6-BQjJU5blWOqxW9TqLep4CD_a6rLqYdTK1XAnpRjYthQlcT_QYPHuLc
Message-ID: <CAO26r3Rxe1kVSU_JeZetvTF9Z3ChoxYj5x8rHNFwcdX+mHLuiw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/3] iio: position: add Rust driver for ams AS5600
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 at 21:56, Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> Hi Coirul,
>
> Same as Jonathan on my rust capabilities (maybe now I'll have proper
> motivation to learn it :)).
>
> Just one question below...

Hi Nuno,

Thanks for taking the time to look at this. I'm still learning too,
especially on the kernel side.


> > +impl IioDriver for As5600Priv {
> > +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Re=
sult<IioVal> {
> > +        const INFO_RAW: isize =3D iio_chan_info_enum_IIO_CHAN_INFO_RAW=
 as isize;
> > +        const INFO_SCALE: isize =3D iio_chan_info_enum_IIO_CHAN_INFO_S=
CALE as isize;
>
> Likely stupid question but do we always need the above? Some drivers migh=
t have
> several INFO_* bits sets and we often need to nest the match if multiple =
channels have the
> same bits. For those cases having to define all of them like this and
> then doing the match seems not great to me. I guess we can directly have
> ` iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize` in match but not sure
> if it's also that neat...
>
> So bottom line, it would be nice if we could have something nicely
> readable that we could directly pass to match.

On the const definitions, yes, they are necessary in Rust. Your point
about scalability is well taken though. AS5600 is simple enough that I
didn't notice this, but for a driver with multiple channels and
several INFO bits the const list grows quickly. Brandon Saint-John
raised a related concern in v3 [1] and suggested wrapping the
iio_chan_info_enum_* variants in a Rust #[repr] enum. I didn't get to
it in v4 and I'm planning to address it in a future patch.

> On another topic, I believe mask is present in several drivers for
> historic reasons but note that this parameter is not really a mask. So
> other name like 'info' is more appropriate.
>
> - Nuno S=C3=A1

On mask vs info, you're right that mask implies a bitmask operation
when what arrives is a single enum index. I'll rename it to info for
v5.

Coirul

[1] https://lore.kernel.org/all/20260529053803.3256031-1-branstj@gmail.com/
