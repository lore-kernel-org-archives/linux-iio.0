Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565538837C;
	Sun, 13 Sep 2026 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337457; cv=none; b=V8hI61yPBGynQTGiZupQt4f+AVwk5xsugOB8MFpG/W/1oqaxFBOuzqRyv5H6KN/5gH331BzaWtsVeiylnn6AX2H/OrEQnd34b8s3m+/rISgKPOFZQBEbQLM3VKaWFdHfWFfBew2TBabU0/htkwmPCnlaHvdh9uOj5CCzczhy6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337457; c=relaxed/simple;
	bh=Ik1oAWO+LEQW5hAYn6THdvAhPDsjhIInNH2IpIoeGf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZBeTallsj3eo12sC2Q3+2gM7Mhgm1T4Cp8DS19ALV3dMnnYxQo5lTD4YX5+CNHNPJ/0XAP6O6065UlvaOXQrpyriXLu+WLqOYNwfZhPgz3FdU6qljRWdoLUiSKAxYEs/lBWmR1Vwn6U3Ecj5LCJgoFsJw8z0fTkgGZ0s2jg0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMPUrjA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMPUrjA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4A61F000FF;
	Sun, 13 Sep 2026 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789337454;
	bh=cCOCGlV8Zf241K68TIZffDD/kdoJXxZwD6SdPDJSoPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NMPUrjA0Fzx02J7MxegCVNOrhmaZxRHP1w18LSUikVL0Pksjeja0OCOly3n5ReJnC
	 SJfKG4o0AfD/TZQ5kAFeL/JkF+UsdKbiMNZ926pSHRON4+SK2RJg9evEqOmW0ZXEQI
	 OgX71wTLJGWCGsFnKxNDzL88r0Vm5uGgTdY1pmfeymtWkGb8W6K6SQo1TMKZi8RTNK
	 jXdr4AT3sau18C6XkbpipwdmeM+bVMgaLjY02Er3zCYNY7HIhi345JNWQtTU4dSmO1
	 CoI6pRiS98WG4RMISnIiWFCCCnpCIxCxNY4EQBnHZI/hCVMVwbG7RY+636CkTbn51b
	 LVY3RZhVa+cgQ==
Date: Sun, 13 Sep 2026 23:10:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Salah Triki
 <salah.triki@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys02d: Fix state desynchronization
 on resolution write error
Message-ID: <20260913231049.5e09a355@jic23-hlaptop>
In-Reply-To: <ap_kTDGgJq1S8rVr@ashevche-desk.local>
References: <20260907085353.54477-1-salah.triki@gmail.com>
	<20260907165009.0000035c@gmail.com>
	<ap_kTDGgJq1S8rVr@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Sep 2026 13:32:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Sep 07, 2026 at 04:50:09PM +0200, Joshua Crofts wrote:
> > On Mon,  7 Sep 2026 09:53:53 +0100
> > Salah Triki <salah.triki@gmail.com> wrote: =20
>=20
> ...
>=20
> > >  		ret =3D ms_sensors_write_resolution(dev_data, i);
> > > +		if (!ret)
> > > +			dev_data->res_index =3D i; =20
> >=20
> > + blank line
> >  =20
> > >  		mutex_unlock(&dev_data->lock);
> > > =20
> > >  		return ret; =20
> >=20
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com> =20
>=20
> Actually we prefer usual pattern =E2=80=94 "check for error first".
> This 'if (!ret)' is confusing.
>=20

I'd use a guard so we can just return when the error is seen.
