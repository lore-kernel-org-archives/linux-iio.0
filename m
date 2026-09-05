Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DAC3101A7;
	Sat,  5 Sep 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573682; cv=none; b=Bqhl/UtY/IiFyRX754dN4t09fhTpefib6tRWKu40zL1/KrD5mwSnm4KBWrvJX3/DaFFVzov8Ln+jdxYoo9Mo/wUR3ugdU1mRSFLWGANwFo6gzo8TcX18vhGfHEXWWZ9xkpg7zBfO3qp8Xs1c18ZaNf1JsHTs/IYY0pK4WVPXJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573682; c=relaxed/simple;
	bh=oRe3BX8f+yoYpj8ShT5n9dzjDFp9LqiX38R5yBd8p58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjjPHcWirhds/JCvO/dgIrwFxlervkjfMbtsbyV1S3/j+hgdj63brtnjWwAXlp06rFHp3v+7afB0jsgYqQtp2bv+7we3QWXT1eSIRpqypn0m1jI0F1xtNx73cqyl64ksVX3lqlwcvDAtLt8He19+8LO/HJh224XPeVeEmgTggWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFCLRa1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFCLRa1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6A31F00A3D;
	Sat,  5 Sep 2026 02:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573680;
	bh=oRe3BX8f+yoYpj8ShT5n9dzjDFp9LqiX38R5yBd8p58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UFCLRa1L+PeHAlsjDf+QED72rcOPr/qlnczKimq/g0fCNvq9LDRlsPc5VLJRIweTW
	 ySzCNAUhTDn6sLmPO7By5f+OO2ALi3IKXE4pdy5mpcbCx+bDxVg3IE4gAS07BpSgDo
	 XZTHAfm+Sblm2JiPWg+0WTdDm1ylJBvntRjo8FZj2khPZFnsr4IdvoF6wbhGXc9paA
	 5oy0cqE29jLVPGLkgHAnAOJnSv5mA7V21t2uEW6oI2x2lWTEbsvRvOX9AfWJV6v4yh
	 6cJ2TUqTU92dv06hXZpbjZUN0XNV+nvfPfld5Gi7ahTL28nYijDqPvdhkns+q1IQxl
	 tFa/vmhXLeg5g==
Date: Sat, 5 Sep 2026 03:01:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Baluta
 <daniel.baluta@nxp.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1015: Add support for label
Message-ID: <20260905030114.21de1faf@jic23-huawei>
In-Reply-To: <apnEm92_E1_Axhvz@ashevche-desk.local>
References: <apkRJ8T-X-HoNiDB@ashevche-desk.local>
	<20260903151627.5011-1-flaviu.nistor@gmail.com>
	<apnEm92_E1_Axhvz@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Sep 2026 22:03:55 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Sep 03, 2026 at 06:16:27PM +0300, Flaviu Nistor wrote:
> > On Thu, Sep 3, 2026 at 9:18 AM, Andy Shevchenko wrote: =20
>=20
> ...
>=20
> > Since the iio core exposes in sysfs the in_volatagex_label
> > for all channels, there are 3 situations: =20
>=20
> > 3. The channel is not defined in the dts (in_voltagex_label is still vi=
sible
> > in the sysfs), and reading the label will cause "(null)\n" to be printe=
d in
> > the console (as indicated also by Sashiko boot), since the default "" v=
alue
> > is not assigned during device_for_each_child_node_scoped(). I think thi=
s is
> > not an issue since is just the way sysfs_emit() handles an NULL string.=
 =20
>=20
> Is this current state of affairs?
>=20
> If so, the patch must not change that =E2=80=94 it's an ABI now and (null=
) is valid
> response from the user space point of view.
>=20
> > What would you prefer? Any further suggestions? =20
>=20
Unfortunately we never defined what should happen this way explicitly.
In practice assumption is that this is a corner case we probably won't
see. People don't tend to want to label just one random pin, they tend
to label the lot. =20

So go with whatever is most common in other drivers,

Jonathan


