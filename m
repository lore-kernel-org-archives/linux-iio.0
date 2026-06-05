Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1E40E8FB;
	Fri,  5 Jun 2026 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667112; cv=none; b=AFVoYRRtONiYEchKcACKLfiXaB4AToraQ5qHO+9ArE30fsBAGEZjSyyoY8D/FLACfmqtd0A03rM/c0GvqcfNUOpHy+TuMNWup5ZIsJDQxTHCEPG2ITxg81CN1OgOKih2/cOOz2ZpMYhQ1Cl/mxbipjcLHnqhoqOK1JpUphSn9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667112; c=relaxed/simple;
	bh=K615r8p5T+VxyNtM/Uwx1bKUJzaYPttsa98MAat8NPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UPY103wB+vvlmjJwt/MREZxMz1HwUn/pKDyC+msb8hWVHE6I/wXtsE5RMUXYan2/oCqjE/s8B1G7cg4sJjwVGnA/27bx2bg86+6WMygQJ++fTyZI314gwU8BEioY/b0U77R6svEHvufk6ZZArv4bSS5auvPRHdjKIGJFTyrOJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 5 Jun
 2026 15:44:59 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Fri, 5 Jun 2026 15:44:59 +0200
From: Andreas Kempe <andreas.kempe@actia.se>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Topic: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Index: AQHc9CXmt5PDPY90VUWMABLjTdSxxbYuTrCAgAADbYCAAAMsAIAADqyAgAAMk4CAAAKXgIABTP8AgAAZD4A=
Date: Fri, 5 Jun 2026 13:44:59 +0000
Message-ID: <aiLS232YzmDvXhsN@w570anl.actianordic.se>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
 <aiGH7x531jwzOVxF@lore-desk> <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
 <aiGNeKTzOR30w-Qf@lore-desk> <aiGZxzz8DF-E-tux@w570anl.actianordic.se>
 <CAMknhBG+u__qiLv0aRLYnUW3iYXkYDLHveQ-bs2gGZfBAD6Viw@mail.gmail.com>
 <aiGmfzaSj3bNyXkM@w570anl.actianordic.se>
 <20260605131518.072dad20@jic23-huawei>
In-Reply-To: <20260605131518.072dad20@jic23-huawei>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2956B1445F637664
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C2085891A7BBFA4A87880C4F2B17F380@actia.se>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Jun 05, 2026 at 01:15:18PM +0100, Jonathan Cameron wrote:
> On Thu, 4 Jun 2026 16:23:27 +0000
> Andreas Kempe <andreas.kempe@actia.se> wrote:
> > On Thu, Jun 04, 2026 at 06:14:11PM +0200, David Lechner wrote:
> > >
> > > How about setting the SW_RESET bit in the CTRL3_C register during
> > > probe too to ensure the rest of the registers are in a known state?
> > >
> >
> > While the shub register file is selected, the reset register is
> > shadowed so it can't be written without first selecting the normal
> > register file. A reset is already called from probe in
> > st_lsm6dsx_init_device() after the whoami check has passed.
>=20
> The fix is fine, but I think it shouldn't be buried in the whoami
> check as it's a bit of a weird side effect.  I'd like a top level
> function that we can see in probe(). That can do the read + write
> if necessary sequence you have in this patch.
>=20
> This driver currently hard rejects unknown wai values (which it probably
> should not given fallback compatibles should work). Lets assume that will
> get resolved at somepoint and so the wai gate is advisory only. That
> means that the dance to avoid writing to a device that doesn't match will
> no be useful anyway.
>=20
> As such, I'd prefer this 'reset of the register file mux selector' was
> part of the reset function and that was simply called before checking
> WAI.  It fits more logically there than in the whoami check function
> which is just the first place the unexpected setting causes problems.
> That is put it in st_lsm6dsx_reset_device() and call that before
> st_lsm6dsx_check_whoami().  Maybe with a comment to justify that.
>=20

I agree fully that its current placement in st_lsm6dsx_check_whoami()
is not optimal.

The reason I put the fix where it is, is because=20
st_lsm6dsx_check_whoami() is what assigns hw->settings needed for
st_lsm6dsx_set_page() to work. I moved that assignment to before the
whoami check for that very reason.

As I see it, moving my fix to a more reasonable place would mean a
larger restructuring of the driver or making the whoami check advisory
per your suggestion.

Best regards,
Andreas Kempe=
