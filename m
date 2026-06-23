Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890426BB5B;
	Tue, 23 Jun 2026 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228614; cv=none; b=HQYvfXYtP5GBYBSm0uKA97w/pyevrT+aSPWKaJ1x4ob6QiYJKvCqY9GjZGGwjWjAyOekb7eSslfFeb4/2fNVmznqhn8+XRdwCNGMlAHZeTCzh1Wd5C69M7bOKhLnCYkQLFEx9HC37WOUrD93dLjwOStyDt3ZeeqKyQIT3R3w2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228614; c=relaxed/simple;
	bh=ym+CGHg4rV/HzoFX45Nnzz7TrhI3xZ1CKvN/CSiGcLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqXd1lnWJ5xMteZtBdl3/xutKNKz5RlopNambtl5x0FppTKlvWjSnPUDhxqHV3K42dNFRaQSSOHYNnUvaYhaBXx5uJ6B/ShKLoRm4estv3NeUs9zCjTZvrRneuD2loTQwFPiEzw4xkLWaHmDvJ+e959+p/4J73nhM+fxwubLLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 23 Jun
 2026 17:15:00 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Tue, 23 Jun 2026 17:15:00 +0200
From: Andreas Kempe <andreas.kempe@actia.se>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Topic: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Index: AQHc9CXmt5PDPY90VUWMABLjTdSxxbYuTrCAgAADbYCAAAMsAIAADqyAgAAMk4CAAAKXgIABTP8AgAAZD4CAAAfsAIAcWzCA
Date: Tue, 23 Jun 2026 15:15:00 +0000
Message-ID: <ajqi8yvesZqK74-9@w570anl.actianordic.se>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
 <aiGH7x531jwzOVxF@lore-desk> <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
 <aiGNeKTzOR30w-Qf@lore-desk> <aiGZxzz8DF-E-tux@w570anl.actianordic.se>
 <CAMknhBG+u__qiLv0aRLYnUW3iYXkYDLHveQ-bs2gGZfBAD6Viw@mail.gmail.com>
 <aiGmfzaSj3bNyXkM@w570anl.actianordic.se>
 <20260605131518.072dad20@jic23-huawei>
 <aiLS232YzmDvXhsN@w570anl.actianordic.se>
 <20260605151320.415cc432@jic23-huawei>
In-Reply-To: <20260605151320.415cc432@jic23-huawei>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2956B1445F6D776A
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5CE1D2B0C7781542911C3B01BADD743D@actia.se>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Den Fri, Jun 05, 2026 at 03:13:20PM +0100, skrev Jonathan Cameron:
> On Fri, 5 Jun 2026 13:44:59 +0000
> Andreas Kempe <andreas.kempe@actia.se> wrote:
> >
> > The reason I put the fix where it is, is because
> > st_lsm6dsx_check_whoami() is what assigns hw->settings needed for
> > st_lsm6dsx_set_page() to work. I moved that assignment to before the
> > whoami check for that very reason.
> >
> > As I see it, moving my fix to a more reasonable place would mean a
> > larger restructuring of the driver or making the whoami check advisory
> > per your suggestion.
>=20
> That feels unwise (even though it would work) as a fix for this issue.
> People would get very confused at the informational print.
>=20
> Ok. I guess maybe this is the best we can do.
>=20
> Lets see if Lorenzo is happy with earlier part of this thread
>=20

A friendly ping to Lorenzo on this topic.

Best regards,
Andreas Kempe=
