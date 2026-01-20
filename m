Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746D421F0C
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911820; cv=none; b=SQnYyHoGY9pYCfIayxulLzo86YrcpQIdNjJnrWSbB6DI8cvhawSzvW0koJZ+7h7+nHkwmXCwMcVqlPOqyIIowyJje96Guz5R5Gd/ZrIOV50pAPCQFDOVcrspp80cVkYNbutlQvrrwtjZ5ADHRqi9YmESBVOGU1FoldDa+HODWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911820; c=relaxed/simple;
	bh=Wp+KvgDU4dP2sLaBe2K81N8hG6nzyINffWCa6w3MgaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxaptK57Dmux5vzfKKgbm8TnNhqo43YhGSpBDM4v2C350R9meNkMM44oStOkBqNItXG06DkR3W6yup+vMaRrKSLnWyIu4mb+KF72pKg5I6fnwiRgov2Ryk5iq7LFm7JdmUDwB0efGLKamF/+l97dTiV6pZhQf54tv+R7BqSBqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bJGCzAlJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bJGCzAlJ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b870732cce2so807558766b.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 04:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768911817; x=1769516617; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp+KvgDU4dP2sLaBe2K81N8hG6nzyINffWCa6w3MgaY=;
        b=bJGCzAlJHg+ITMgv28Hm2MpgCIJ99iw4VX1cKA8vsFDma6CntADoqC2Jv99q3SIezR
         wPLZ1SBD0oiBIdSk+VDmMmfMqGZ7Bmm0pZm5yFf9pC0BRv4kN/qilIuzrvmgmYNBX95n
         qMgDV4/DdkjtqcrhpSjXXrUIpIiixD/qATNBjaBM47c7Lh2bD59rfkARboVsQ6XF+k75
         +1abavXeaS4koZxLewHS0ZmUkxdj9sC3dG16DdCq6fapQ0qcKPV1odKXf4UQMBxOpBKB
         /zUk7vOMdBLwtb4eXLqZeYxycONYOzIs3JBvzAMjwL8y/ZoeSJImNQwxULganfZJIjkT
         5S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768911817; x=1769516617;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp+KvgDU4dP2sLaBe2K81N8hG6nzyINffWCa6w3MgaY=;
        b=w+/Y30N1IQB8RCGTljmudBO03x9XajRtpPy8J9FYZ//MMtPDxpVqIRU0xylclR9t1W
         QRJErrDwLexrHttePNGzCHoiNrDUIKxzP58kO/mhYkQwDeVpdkiXzepUyRLSBOMqSX+A
         KCikrITrc/nyVnKSCxZ7uIuQjL5E+ZKzE47vgOpIjmR71bzRFyHpZqkeUACJfyX6Uaus
         6QauiZSsF9nAfC5PyWU9XCtT9jwaMH5UwPoJrlt0bWR81NmkhgX3MMDjJr9PbL6z1RoM
         ebzBgw27EOKBetCFzccPugWo7/x4SE7Rv3NXqDwK/52dpccuVPx14oORFG4jrDMWdydB
         zZDg==
X-Forwarded-Encrypted: i=1; AJvYcCVYqXc85ksnxSM21N8l0FvMAxglH9NTwYnUTXxlu4LLdqc7VybwB1YsGWDl/UCDvsbg1EVdwcXrkEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYd+KTdgNqV0YuenlTvaJ+uo11bDFOxBmiGSukexwHv9PWA+YO
	BNr8w6YKUSDMNQVAan1QLxnBTkfFDWk2iL0TdKp0qfELM+wcD1DmaHYouNNUq9i4cFU=
X-Gm-Gg: AZuq6aKRjYP6pxB/aBxd5z+mxv5g5VX+fECW/CIx35RgZVUAJz9WjHe0he/LneUTRQR
	VPmoGf0W7PwG3+ltw3JrMdInyR+ONOTaV3LyOtSqP1sBas8aChvBWFLeGuxjYV7NCNq3BbHADDM
	tZ5mt4Jg4BRcAlWWiKWx1w5DM29NeZN6N2NnIkxP6fivQdOWgfaZE3eygWoxlT1HXgBYa26fmlM
	zi7mP1tXjcq7HfrQSXflgCNcjKgg5NHphUyl5/hqGHV2ljMOl4BXX/dr0/VgNLXfKUX/JRYK6By
	q4EqnRLNjgcfoTSVpZ3xOcrjX3O+jZ3RsMJwVIOIX0epNQT1wijT0TcQydb2nOwkOVGF4AIOqcj
	qhF/OOmYkbTp56PBm7lydSHPMw1vzZcpuWzkOQjv+TfFMKxMYcc2Y+Mbc8GCex8VR1EB5Mus=
X-Received: by 2002:a17:907:3f93:b0:b87:2780:1b29 with SMTP id a640c23a62f3a-b8796afd7cfmr1282712266b.37.1768911816895;
        Tue, 20 Jan 2026 04:23:36 -0800 (PST)
Received: from [10.203.83.229] ([151.57.250.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a31322sm1411184566b.63.2026.01.20.04.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:23:36 -0800 (PST)
Message-ID: <693c13bcdda7cf871022075aa784a9d15de0a8ba.camel@baylibre.com>
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lorenzo Bianconi
	 <lorenzo@kernel.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner
	 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
	Andy Shevchenko
	 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 13:23:31 +0100
In-Reply-To: <CAHp75VfacR7+cu88=+GMi6BEQxC=HLQbxEQkEnC9mWtFRC-YFw@mail.gmail.com>
References: <20260119100449.1559624-1-flavra@baylibre.com>
	 <20260119100449.1559624-4-flavra@baylibre.com>
	 <aW4Ic5bUId3MG4em@smile.fi.intel.com>
	 <851180c6f41f8c9cc79d6412eb97f381f0312f00.camel@baylibre.com>
	 <aW9MhYO_xhlQXFn2@smile.fi.intel.com>
	 <9149f9c75c9f961da29829577ba4476681f4e82c.camel@baylibre.com>
	 <CAHp75VfacR7+cu88=+GMi6BEQxC=HLQbxEQkEnC9mWtFRC-YFw@mail.gmail.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-J4ckU8zOa/6x1s6tn/Ln"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-J4ckU8zOa/6x1s6tn/Ln
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 12:25 +0200, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 12:03=E2=80=AFPM Francesco Lavra <flavra@baylibre=
.com>
> wrote:
> > On Tue, 2026-01-20 at 11:36 +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 20, 2026 at 10:28:15AM +0100, Francesco Lavra wrote:
> > > > On Mon, 2026-01-19 at 12:33 +0200, Andy Shevchenko wrote:
> > > > > On Mon, Jan 19, 2026 at 11:04:49AM +0100, Francesco Lavra wrote:
>=20
> ...
>=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(sensor->name, si=
zeof(sensor->name), "%s_sf",
> > > > > > name);
> > > > >=20
> > > > > Does GCC complain on this (`make W=3D1` build)?
> > > > > Since this can cut the string and we don't check the return
> > > > > value,
> > > > > the Q
> > > > > is:
> > > > > is this okay to have a reduced string?
> > > >=20
> > > > gcc does not complain with W=3D1. sensor->name is appropriately siz=
ed
> > > > to
> > > > accommodate the longest possible name; if it wasn't, the string
> > > > would
> > > > be
> > > > cut in the accel and gyro IIO devices too (which use a longer
> > > > suffix
> > > > than
> > > > "_sf").
> > >=20
> > > Right, the question is if compiler can prove that or not.
> > >=20
> > > We have several patches in input subsystem to hide the warning by
> > > switching
> > > to scnprintf(), which I consider not the best approach, but still it
> > > depends
> > > if we care about cut or not. If we do, we should check for overflow.
> >=20
> > A truncated string would result in a corrupted value in
> > /sys/bus/iio/devices/iio:deviceX/name, so I would say we do care if
> > it's
> > truncated. But I think the most appropriate check we could add in the
> > code
> > is a BUG_ON(); would that be acceptable?
>=20
> No. BUG_ON() =3D=3D panic =3D=3D reboot (with "reboot_on_panic" or so). M=
ere
> drivers like this one should (almost) never use BUG() nor WARN(). Just
> add an appropriate check.

I'm struggling to find a suitable error code to be returned in case of
failure. What do you suggest? -ENOSPC? -EOVERFLOW?

--=-J4ckU8zOa/6x1s6tn/Ln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlvc8MACgkQ7fE7c86U
Nl/u/QwAqHXH1oYt7RnwzkDNyW6chRsF7DPYYroRzlHKdvteHf2sZEjdy0/woWug
kRl3JQZ7yV2fyDlbeQg93N2tbtcuMPt+ZspfaO/ucy6OcMZmIDMZwam/kG9d21aD
nQPQODAdAnQBxTxnzHS4rAF2V1uIRg0qyRzP1HLQnPAFvZxhqKQqJTQrKNyWSjVB
UzSO/Bx/o4+ocO72+Y/xITRr2Pb+gOxAy9+vhpMr9ry8cozGGR3EiL3bY0UbRBSW
bYWnBWns3XjGM2TWXbjiPQAEXZ95/p3/Aiz+vfDeqfl6W9XhpOzoOkrREJ0wANWp
IEyjV2XVEw3f0fHW60onLvhpiIdYBQX2dreDqktqp4jIPYwAmVuc2Wg0NiKyuANU
M1j0P6rnOi6v1UMZdxFMSYkc8shEe3QUnoOqQar5Xrz0rYu3CzccS4F5NNqkWMe2
zrH4bus+8WfKIzj7gs3Pvw1+Oj30qeBH+HyLlB7sBMEA8YnMoOcDXKWFBMd5oWa7
ZwE1SAfI
=nBw1
-----END PGP SIGNATURE-----

--=-J4ckU8zOa/6x1s6tn/Ln--
