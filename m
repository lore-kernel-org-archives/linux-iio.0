Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBB1862A
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776593752; cv=none; b=G/8BJyV7EL0iKn8AFsSV1L+P5u1Rb5JSYk8MPfgiklCvD6Fm8IMChe0XorV0HkKxbITHScRVweaykTJkZBWivAD2hSTPEziWo8hdN3MNokB+uTQyD87N8+Kvczn/Q2s037JXb5poeo1KoTXCl3XEvR+ZtAfCaWfS/9tc9NjHUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776593752; c=relaxed/simple;
	bh=hT1EZXs3z+i/JZdVZGVJXZMspOZcXHgmmawdkaXagL4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NZsGNw2jitnpBJWPsNRGMbOnT/UEmicKDYkOJzc9QwjienZP495xvBQgLl10Ym/zVNNhHHPtQl8ZA6S7eTExKLuiRq2xd9PzZhm+FD5LmskBonltHw7nz5L4FKRvldbHAve9e2eqBrMqBns5+upf8b5bUwm6QLlxhwmXW65+HAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msgXgZt2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msgXgZt2"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1197017a91.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776593751; x=1777198551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hT1EZXs3z+i/JZdVZGVJXZMspOZcXHgmmawdkaXagL4=;
        b=msgXgZt2v91ZMtGxxheXo1Hlxx0cJZQSysSC+8RNe4EuG1wiqpqNUM2J3Py2cVNOx5
         sa+yJqidvOmYN93WlhCjIzUI68JU9GI+nIofWZoDwkIJen5BwMZfcoWpkJpcTih1ZKU8
         8x0SEQlBrw6R7kwySrd6viMNX3zt0i08XXGjJK5R4+hOcBxFoI1imS5ZVHDytLiT7Auw
         lr9L3bDencyKkzY3mwAocokZkTSFnpLekCJbm+yBJ52+FyoR3lCp2ssohCnJ9mO1bz3+
         8dAWJpzJDUO7f8EggbCeP2yMR8bBi8Y5G93iNvqp0GDsBwRiMLvdy0EY6eezPQjewsbk
         D8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776593751; x=1777198551;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hT1EZXs3z+i/JZdVZGVJXZMspOZcXHgmmawdkaXagL4=;
        b=fxDWmpLOLm7EgUQIitExlIaQOfjd2OECTOBuh06ZfBcueF5LYVaKJM16r3mfYXtjjk
         JvvX8cUag7g++l1RjWFvyHpiCDugNTaGsWM59CYUdFl5DJGPJoZtRSsmkBhZE8F0r1N+
         t9Q7n6RoZG463AD296cQAGHL+8iCb9NyA4oFs2gyjOpl3gdyq3ZTyvp0qpnO3/9ql48g
         VmWES0Of+UY4PkOrSCiJo8SB29SchcEQqb+vg4Cb7oOm+bTN5O53OAqJ7tqyoisM5VZF
         PYFb5cxL3OowQwI86d48uXo2MtqsWINxmQupSTcLbt64waV6Jr2kfkZZGnlhGd5XeYtu
         QBwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+r+9LNg6r9+toCS9WSPeiCdFUZYrflV6wP5bQdXmbAFDtm7rioL9QkwqNZBBo/IZ2u4M39dYWvNBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDB/Y4fZMOd7AASgfHj/PYVrWU2vGlmdZuk1qL14Liojvot16
	ILqRaaIubZ4sW7FcPAIGe0/KYTFY2vIeqgsbKSdaXlWwjJz7t2g+R1EY
X-Gm-Gg: AeBDiesjcIPsysEQKwDg0TVs0N0i7+FSUe8u5FA/QeFnT2KtYQV1d/lk+gUEk5gSoP1
	ILVNkvTH4Q8PHSUJniVKL7QwNev+Ed7cPP3EwQTLzyj2rZZLebCfGS408kwn3BOclccMwgen4l/
	HtN7j1+n6ypTyOjtuiV/JpGNIAaQbT/x6DgC+wFBfWSAI2jLfMf3ZLg/NTnbNfBXjYRbNqu4C1a
	XDI6Z6Efr+9AO10kAuwrvRfb6QW37t1Wp9FtmGzAqKZQVonjMPXLczefCqSlqrhnCKM42Iqv0qt
	n2RrwrVS36e3ozLwWTQ2RCG/oihE0tjtg2KqTpcJ2ugYyWiWaLAIEwkIl4yRuUtUktfykfxrp3R
	SKhADWv6j/Ey6fNKQJhyN2Ti1SeEaGwnd8aVR/au7KKs5xo6cISH274NVqQAT02BHjBY43amfXH
	QvnVlBp8L2KHUeX179ikxoVW3rU5NLGTkY5UzsBMlIizelwbBYEm395g==
X-Received: by 2002:a17:90b:3b4a:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-361403d61camr9767456a91.3.1776593750904;
        Sun, 19 Apr 2026 03:15:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac16:b3b:3927:d65:a5c:bf50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm7165010a91.0.2026.04.19.03.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 03:15:50 -0700 (PDT)
Date: Sun, 19 Apr 2026 15:45:46 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>
CC: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: ad7173: codestyle cleanup
User-Agent: Thunderbird for Android
In-Reply-To: <ad3zB7nqgJ2BDS9w@ashevche-desk.local>
References: <20260413134223.2331911-1-sanjayembedded@gmail.com> <43c5cae7-9689-4dad-ace8-e8165e5fe6e2@baylibre.com> <ad3zB7nqgJ2BDS9w@ashevche-desk.local>
Message-ID: <22A130DC-4980-453B-88DC-69998E79D511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 14 April 2026 1:25:51=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Mon, Apr 13, 2026 at 09:09:15AM -0500, David Lechner wrote:
>> On 4/13/26 8:42 AM, Sanjay Chitroda wrote:
>
>> > This patch series clean up error, warning(s) and a check reported
>> > with checkpatch and no functional behavior changes are intended=2E
>>=20
>> I'm pretty sure someone sent a series just like this already=2E
>>=20
>> Patches 2 and 3 were rejected=2E Patch 1 is probably OK=2E
>
>Seconded=2E NAK for patches 2 & 3 from me here=2E
>Patch 1 is OK, though=2E
>

Thank you David and Andy for the input=2E
Yes, similar changes is already available in iio/testing=2E

I have dropped this series=2E
