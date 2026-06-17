Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6F37880B
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704778; cv=none; b=UrE03YiJjSt3WNSzc+frOUEAAlK4tV1v+F/tt7dacuQK3RkPvy8znLvJM4R5V81RxDOk3x9gW7k0JNUPOPDgXE0FiQ89Xf6YD8SxdM+1ureWgY3QgkTATO4NOGVCh/QTe07pS4inYqYSRSfo69ApVdsAPrYnHpYWuoNVHP1IFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704778; c=relaxed/simple;
	bh=dCBd6QOWdSfna80tO7lgRPNepVJ8z4/9yjwTGHpHQIE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=maFQACwotDHSMkaFzBg5TPTfJcD/IaXAXYfS53D2TvMGONChqZ9YWF9VAUT4WVpr2k/Ps7CdPD6S00Wh81LiX/QV4YXu+0QCb/Dx/ffu53LgGpm8LGc/64bJqmDjd8GVtP4+1YqjlOC3Eas7X0xNqWSwzkAnK8YyzwHWh3LvnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgDg2q8A; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgDg2q8A"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781704765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0esiTjT2bh6BlTAeIet0hO+XCKrhmouZR2UAUKmVqSI=;
	b=AgDg2q8A1u5L9oBFy6syZlCFggXZH38jJ724tm/ppHkiXyWaJ2MmVPmNq18UTPtUP1cCKL
	j6IXeRvOw6xb1qT8ev2gadePk2HNs3M9/RioLy7VeLldQs553IUnCC7EiTYOiffrht2bqx
	MAjTDXQLkjdGIejA3KF/fOEBNxwQq68=
Date: Wed, 17 Jun 2026 13:59:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <8016d51ceb01974ae6d47185717d8e42dcc499bc@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 3/3] iio: magnetometer: add driver for QST QMC5883L
 Sensor
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ajJI_KK0eLXeHK0A@ashevche-desk.local>
References: <20260616114942.37241-1-siratul.islam@linux.dev>
 <20260616114942.37241-4-siratul.islam@linux.dev>
 <ajJI_KK0eLXeHK0A@ashevche-desk.local>
X-Migadu-Flow: FLOW_OUT

June 17, 2026 at 1:13 PM, "Andy Shevchenko" <andriy.shevchenko@intel.com =
mailto:andriy.shevchenko@intel.com?to=3D%22Andy%20Shevchenko%22%20%3Candr=
iy.shevchenko%40intel.com%3E > wrote:


>=20
>=20On Tue, Jun 16, 2026 at 05:49:39PM +0600, Siratul Islam wrote:
>=20
>=20>=20
>=20> Add driver for the QST QMC5883L 3-Axis Magnetic Sensor
> >  connected via i2c.
> >=20
>=20...
>=20
>=20>=20
>=20> +enum qmc5883l_chan {
> >  + QMC5883L_AXIS_X,
> >  + QMC5883L_AXIS_Y,
> >  + QMC5883L_AXIS_Z
> >=20
>=20Leave trailing comma, it's not a dedicated terminator.
>=20
>=20>=20
>=20> +};
I generally have a habit of not adding a comma at the end as it reminds m=
e of javascript/json. But sometimes I add it to help clang-format. Jonath=
an suggested me to remove the commas at "terminating" entries. So I took =
the opportunity to remove them everywhere. Apparently it was a wrong deci=
sion. Thnaks for pointing this out, I'll make it a new habit. As always I=
'm learning a lot from these reviews.
> ...
>=20
>=20>=20
>=20> +
> >  + return 0;
> >  +}
> >=20
>=20...
> Ideally this should have a comment with a reference to the datasheet wh=
ere this
> delay is specified. Otherwise a comment why this exact value has been c=
hosen.
>=20
I=20have a comment where I define this, about this value being from the d=
atasheet. I'll update it to specify where though.
> >=20
>=20> + fsleep(QMC5883L_PORT_US);
...
>=20
>=20>=20
>=20> +};
> >=20
>=20--=20
>=20With Best Regards,
> Andy Shevchenko
>

Thanks
Sirat
