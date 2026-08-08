Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9192378D70
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786229100; cv=none; b=nv6BcpcyTQ0iXzuWZFYzjghpLyYT4x2otTfJwmQBOiTyAFYqMEkU154Y8CebXHaaw3G/YyPgE6WM78V04rge0E1uB4jnRYTdQJ1fdlLp497TPBZr1BBGX6EE+X+cjJqnZlk59H4mmL/yJ9GEvxlrXdXjOfSOufl+DNcDLrYZr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786229100; c=relaxed/simple;
	bh=BumHtW1PoIoUN94RKThzrTA0PcLi8hrHEifW1Se1TDE=;
	h=Message-Id:To:From:Subject:Content-Type:References:In-Reply-To:
	 Content-Disposition:Mime-Version:Cc:Date; b=sZ6DM4KmsRQCYPQp7dAAJ+qfgycSPUq6L1GeVvu4MWlL3by1NRciebeMIcH6NO1ICFO7aHFSsn6f/H7DxHg13b8umU9fLfFMeNu/w//Tyg6NDGfRH8ocOuzuXY4hrtnihJPWcFBkgHFi1/A4TeaA01mUWN794kQVqbGaqTvpwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=kwk9ZBSW; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="kwk9ZBSW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786229091; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BumHtW1PoIoUN94RKThzrTA0PcLi8hrHEifW1Se1TDE=;
 b=kwk9ZBSWxntvTugbcPkfv3LRBXTFN7lw+zfJWUuWGOmPoOMmVh9+DESxtl9L8fhijz+vcr
 ft0aAPWqLY0ppwv0Y+VgxcDjDMs6MeKGwV4WZPRCDLp6OWYV29to8fFUyLZdsEpcjpQHb2
 gmTth1kUFV7EQdaZtxw4nSEmuTNoEIVEBYgpkki2PiX0U0u03vYAg3hw+9B/4emoidoyvu
 f9hrg+mviKLvB2QIgICNnLfXINJ8zg7dA7WySuivD2lXluFZ65vMKu1BigW2lJZhCLG+9A
 pk1MECJ1sJdqiSD+mi0MEzyuc8xFXDd2fudBNR0iOoJmIxy+ljjDF/9RiPRgGw==
Message-Id: <anexXU9DHIr8T0JJ@pve>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a77b161+89ff9b+vger.kernel.org+me@cherr.cc>
To: "David Lechner" <dlechner@baylibre.com>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: Re: [PATCH RESEND v2] iio: accel: fxls8962af: clamp FIFO sample count
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
References: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc> <f35f30e7-15c4-46f5-8aca-8a4a79c740ab@baylibre.com>
In-Reply-To: <f35f30e7-15c4-46f5-8aca-8a4a79c740ab@baylibre.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from pve ([111.42.148.195]) by smtp.feishu.cn with ESMTPS; Sun, 09 Aug 2026 06:44:48 +0800
Cc: "Shengzhuo Wei" <me@cherr.cc>, "Jonathan Cameron" <jic23@kernel.org>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>, 
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Joshua Crofts" <joshua.crofts1@gmail.com>
Date: Sun, 9 Aug 2026 06:44:45 +0800

On 2026-08-08 17:39, David Lechner wrote:

> When you do a RESEND, please say here why, otherwise we don't know.
> Did something change?

Hi David,

Nothing changed =E2=80=94 this is an identical resend of v2. The original v=
2
bounced off the mailing list and never made it to lore, so I resent it
unchanged to make sure it reached the list and the maintainers.

You're right that I should have noted the reason in the changelog; I'll
do that for any future resends.

Best regards,
Shengzhuo Wei

> > Changes in v2:
> > - Use min() instead of min_t() as suggested by Andy Shevchenko.
> > - Link to v1: https://lore.kernel.org/r/20260806-fxls8962af-fifo-v1-1-b=
d9d27047fee@cherr.cc
