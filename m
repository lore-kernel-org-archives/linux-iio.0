Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AA2EA754;
	Sun, 12 Apr 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775987763; cv=none; b=Xc3QccljOgD2MkxOKEpNq0aZFWlb/9Y4IkTwK6B+i4igCjd5hhAC+iyZ6KOVJGfq3NxW3DDNMma8/ztSr9e6pyxlDKDMGnH0v6RRoqFMOLQCDvzxtaNSVhncosxhme3TgJFjF51wuDuzd3aDgJ6G/6FNigkInwCM1jjiz70rbc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775987763; c=relaxed/simple;
	bh=aquEatClFG1c+RO+VcGRoMUrcTV1hLthOdF/aergRJc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zuyj42V8yrGDh9m9PWPJX4FvjEQpBIGGHUzw2NmEqfHGY3JxmK6xs2kEKl46CdoXQ6MU+K7QvimODF35EcLHb1GGmQB5UliUM+9NDEc1wtXNBtamXJqqbwAwxxbRiEMgVq/JyGO9AR9U1H3Ly3XtPN7+4lj2QsyLVbL9dIKEP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VB3TVmY6; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VB3TVmY6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775987753; x=1776246953;
	bh=Sm0vVvnrQuoTqKEjS+gzACIIVwF8965LHRvsTVHod5E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VB3TVmY6+xTahTaKulVnVSbsMg/3KPjlfMhbvKQsis3yKBS/5vSEtFJqJYzs0n2Tj
	 32njBpjK+sI0WJPxf43KjxKisdob9aBw2h0Kf6uRjWW0KyiZGtA1g3N7qjzPkPsWMv
	 3hPI29O6qy3P46AqUNB0NMirjp+ThFZkUePQIvqWTZELkUAdR3QWcBQ5fNsB8EeOTB
	 4XE4SNw8GH8A5fHf/c20RJSA2w0bFmU+CDbPFB1DOgBvyNiynUKPzowdiY5xOMHkBR
	 EzOf/z/MzUkjLoUTWPNteeGFaluukuXBXTbg7XqjzrsHnCxa2Kqr54XNQftO2f7Y6T
	 LYOZrWcfurGIg==
Date: Sun, 12 Apr 2026 09:55:49 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hardik Phalet <hardik.phalet@pm.me>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 3/4] staging: iio: magnetometer: Add QST QMC5883P driver
Message-ID: <DHR341TEQOIJ.34OOTLFMBN3VS@pm.me>
In-Reply-To: <2026041027-hatless-swinger-eae1@gregkh>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <20260409210639.3197576-4-hardik.phalet@pm.me> <2026041027-hatless-swinger-eae1@gregkh>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 19d674c330ae1901d8529c024224529aadf14c02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 10, 2026 at 10:58 AM IST, Greg Kroah-Hartman wrote:
> On Thu, Apr 09, 2026 at 09:07:41PM +0000, Hardik Phalet wrote:
>> Add an IIO driver for the QST QMC5883P, a 3-axis anisotropic
>> magneto-resistive (AMR) magnetometer with a 16-bit ADC, communicating
>> over I2C. There is no existing upstream driver for this device.
>
> Sorry, but no new iio drivers should be added to staging.  Take the time
> to do it right and put it into drivers/iio/ from the beginning.
> Otherwise this will just take more time and effort to get it into that
> location in the end (i.e. doing it right is simpler/faster.)
>
> thanks,
>
> greg k-h

Noted Greg, I will move it to /drivers/iio in the next version.
Thanks for the review. I appreciate your time.

Regards,
Hardik


