Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6942317A
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912191; cv=pass; b=NzajStAGnn/rITyE0S6pVbnxqQ8z6pkK1BRXQaSj9yttu7eZhpn9wpvM/e7L29ZImYFImexvNLyZ8F9RQWUx0S4dUe2fML3Ul/WvMvCRYqJWPpG0gFJSsyy+E1pAY5NX21ynv2RlftkRJ3evdygrEtJgXzKsztnhGp8pxj430BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912191; c=relaxed/simple;
	bh=O0i96OpANw3CXu1SNOXu9UFtNT6w0rWxfJPJ++UUqYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYGxIESaxSf6RmA5WI8ORXjJgAzTFC7Aw6DxZJvbccU3L9QxQ8z0zzWYR9fCTxZ+9ziSe/ksTjsB6P8rel05HBrGJ0wOqqwtDGSD8zFgMHHrNItkU5yZbz9zEf0SwBjySA7FrgbeisYs4NoQHl7hoDysEFKd1+MgnpvStDEICMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axoCpsP2; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axoCpsP2"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b876f3f603eso888093766b.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 04:29:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768912187; cv=none;
        d=google.com; s=arc-20240605;
        b=lAnHUGxy6S7JZUzfWNLE99T/7nQHvzGX0Ax3Nv7wftoVdzO6f0n2RoCK84ZK5x+hml
         5LO2W6szeWL1XkpWCa3q97XqPtusiuUoeOXhFNdrpCz1EbAmFWVRZWAuaGugxdPVwrG0
         /x6CiCZ1ku5B/1Ru7B8wH/cJtCsPBfV5nyt2uad8u8nHCGvc3RJc6x2lp4yEFkOWuHXU
         nugeLn3/oE3c6iAeEVGspyQ6t+NN++3Lyxr5Kclu4WNzyV+wy8Y3Or7gOoaeTMOyBAtN
         2h7mDj9/UPM/0zQ/GQYaaATvXerkyS9nlyIJyC5BPRxAaVpGIEUUUHlsMqp0a/GjnJ2o
         rX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NXLkG+2QgW7SCZ/lFDXv657xHuBMBoa5Zruz4wBq/W0=;
        fh=t5DVcehS+uhIYal6NcFZLrcOfTX877x61IS5MNqx6Mc=;
        b=OzUeLfiYjmqJJrXLVIAJBnSKOjCFCzwtOJ81xUD3+WEZb82wBDKs09Pslvh6suzQ/V
         BS4GBCm7Rx0bF5ym9kb/yq+5YId77ll2m9DA1F/fOoN6mfwXcXD3qnpcNqL7dnd4Po+o
         viMz1Hdn8ecGFoWO1SrcprEXx621ATXpol0aM/DTnQFi5wxhBgsGIv7piMm/5ywCbAVG
         QZVvG0vQnLKtnAmRuI14QR3HK5B7Jo820A59Wz55OYyTV/sthRFCsFKpnstIHR5l+KlQ
         5SjY7BNbNcAllu1f/1+P6LyB7pxdLxjwc4GyJUIQ6hhwQH7e4VgT18FTDWeBCOE301CF
         5mDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768912187; x=1769516987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXLkG+2QgW7SCZ/lFDXv657xHuBMBoa5Zruz4wBq/W0=;
        b=axoCpsP2b+9pxfYbdwu1H+FT6oGgL1XnEEIlzINiJmAwrF7JZDjrXru3qE10VPbqHW
         1mRN/JDp4v1JjRY1DOzhggegQ8mv9XE1Q6xTM6UbCNAnVPZUgXNaV6W22qroI+kCYwMx
         jC7AtELD6RNbAF+2226MN/VO1EjTa+3nrCB7hghnMzsmm1K30Wom++Sauyu2qsGWEcVu
         suNHtg9ey6EOOMFUogfsTu7nPoIRAVq7vm2UK5CU70EOQU+3NpSaGocf++dWt5QY+VWC
         LnKNIm+vu4Bn3UC+PBu3IO9GqQEfbBu1eBqOtBhVHBAtnOIl4CYx/Vn46XndfjPx8Ctl
         mJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912187; x=1769516987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXLkG+2QgW7SCZ/lFDXv657xHuBMBoa5Zruz4wBq/W0=;
        b=IRz2HowIJbdZJUIe03kkgI6FUt0G4dAYeON44f/NIuwoOc31TGs0EESjmpr7P5Dbzz
         i9gAaQqfoOpTKebEq6YHtenU2LmrIcd83YBMDEubatsDzVBKZC/Un7oJTkssyPeF7tbx
         eNGEhAqPemTC6v6irTDqQa7FdbRvPGgnhiQGUJvE+YWRzyFZ6oK59bWlp2yA34faOV+R
         5WPoSYYVdT8ywlTMuOMi3+6QKf5vrg3OVMvC8E8EzHreSWaYvKoqFJUR0HUm9zKd4sZL
         vd6u7FRmsKIXu939QAKVj3n2oTqiBMKhQukDvnjhW5m9EnV3zC8UOrVp0KBHNxZE+tQQ
         hs5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjB6tmx+uUWxaB+XSWSW2fLWIvHx87kGIVvG485b9nW+Gxpes19EH1x93cMTFtLFkwsb+7yReOOmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0sOtxl8fynVLpom2okfmEVIGvo2QlS8Uge79hAQ9Byrw7Ao2B
	XSZL5Fi9igY43bxMj2HHapT1rB4Jec+/Kp4C5GU2GGvNvdeUw5VEwHzUJKp1GZSxFq94g//snwq
	l8N1eOMjDSoSWw1NC7akV10kgajfv0jY=
X-Gm-Gg: AY/fxX4NGNO9YNEQ26fYp6KXNVPUqHbFKXKzJ8iGJq7u6kuNv/wbhfel+910Of3Tjor
	V/58QDa5pAhgnkt+qcrVMJ5T7O0mKl+ti+u9bE1O5uJW2+qLNvIXkqo113zt2o7PquQ/tPpRHf+
	naUnHJmjAmavA6jJ+v/BdyWhShjlzP0UdzWlW7yZ/IL7ZKX9G9Yq7Ke93Ob7Ti3vpDfdSPjvr0A
	StMVrApbzoGiP4RMQoBkEZG2WbSCR8ds4PwpknGLiF0tbzKB4Jzmqi9rTh+wFBydJiGlTloKmDe
	uwDDlLJs/c9RWGiqRqhnor19kS7oJY1aGw3pBZo+wtZFfR9JlTiMuCygtOpfkJw3drvYAws=
X-Received: by 2002:a17:907:86a6:b0:b87:7e8:e272 with SMTP id
 a640c23a62f3a-b8796b21782mr1394383966b.39.1768912186697; Tue, 20 Jan 2026
 04:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119100449.1559624-1-flavra@baylibre.com> <20260119100449.1559624-4-flavra@baylibre.com>
 <aW4Ic5bUId3MG4em@smile.fi.intel.com> <851180c6f41f8c9cc79d6412eb97f381f0312f00.camel@baylibre.com>
 <aW9MhYO_xhlQXFn2@smile.fi.intel.com> <9149f9c75c9f961da29829577ba4476681f4e82c.camel@baylibre.com>
 <CAHp75VfacR7+cu88=+GMi6BEQxC=HLQbxEQkEnC9mWtFRC-YFw@mail.gmail.com> <693c13bcdda7cf871022075aa784a9d15de0a8ba.camel@baylibre.com>
In-Reply-To: <693c13bcdda7cf871022075aa784a9d15de0a8ba.camel@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Jan 2026 14:29:10 +0200
X-Gm-Features: AZwV_QjnJ71IJdRm_dHnas1mSK6Osu5ELHZVNhJ9l07QQ_JSx2PnIDe8iafPPTM
Message-ID: <CAHp75Vcc4_3RBLnoucVTyUaFHXnZ1fdXjTyY7rzN4rcPEU0mSQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation sensor
To: Francesco Lavra <flavra@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 2:23=E2=80=AFPM Francesco Lavra <flavra@baylibre.co=
m> wrote:
> On Tue, 2026-01-20 at 12:25 +0200, Andy Shevchenko wrote:
> > On Tue, Jan 20, 2026 at 12:03=E2=80=AFPM Francesco Lavra <flavra@baylib=
re.com>
> > wrote:
> > > On Tue, 2026-01-20 at 11:36 +0200, Andy Shevchenko wrote:
> > > > On Tue, Jan 20, 2026 at 10:28:15AM +0100, Francesco Lavra wrote:
> > > > > On Mon, 2026-01-19 at 12:33 +0200, Andy Shevchenko wrote:
> > > > > > On Mon, Jan 19, 2026 at 11:04:49AM +0100, Francesco Lavra wrote=
:

...

> > > > > > > +       snprintf(sensor->name, sizeof(sensor->name), "%s_sf",
> > > > > > > name);
> > > > > >
> > > > > > Does GCC complain on this (`make W=3D1` build)?
> > > > > > Since this can cut the string and we don't check the return
> > > > > > value,
> > > > > > the Q
> > > > > > is:
> > > > > > is this okay to have a reduced string?
> > > > >
> > > > > gcc does not complain with W=3D1. sensor->name is appropriately s=
ized
> > > > > to
> > > > > accommodate the longest possible name; if it wasn't, the string
> > > > > would
> > > > > be
> > > > > cut in the accel and gyro IIO devices too (which use a longer
> > > > > suffix
> > > > > than
> > > > > "_sf").
> > > >
> > > > Right, the question is if compiler can prove that or not.
> > > >
> > > > We have several patches in input subsystem to hide the warning by
> > > > switching
> > > > to scnprintf(), which I consider not the best approach, but still i=
t
> > > > depends
> > > > if we care about cut or not. If we do, we should check for overflow=
.
> > >
> > > A truncated string would result in a corrupted value in
> > > /sys/bus/iio/devices/iio:deviceX/name, so I would say we do care if
> > > it's
> > > truncated. But I think the most appropriate check we could add in the
> > > code
> > > is a BUG_ON(); would that be acceptable?
> >
> > No. BUG_ON() =3D=3D panic =3D=3D reboot (with "reboot_on_panic" or so).=
 Mere
> > drivers like this one should (almost) never use BUG() nor WARN(). Just
> > add an appropriate check.
>
> I'm struggling to find a suitable error code to be returned in case of
> failure. What do you suggest? -ENOSPC? -EOVERFLOW?

Same as strscpy() returns, IIRC -E2BIG.

--=20
With Best Regards,
Andy Shevchenko
