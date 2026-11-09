Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254881;
	b=Iree/XJjq2AAkDneU+PECllqADAU4rHOGV3GhI304aM+Pdrmtvo1/Qe0LNmljtLXWM4E
	 QRraF6hvoqMN1BKA2ukDdiAryyLYxXRMXIH2xtqwe664cW88Tsn8rotEOW9VgXZIZvmg3
	 Dx8Kagg6E746N/HRuuQK9/Bn09Nlu5ylR5NLRh6S1JZW/dNm84ZRnuyONLZwrn64EikiB
	 5ruZdbSpyg9jKyeVbrBVrcnm602M5DxWKKXR1OeBrz4Ma2AkGfW3zPZ6qX6OFppUkbjTb
	 5yT+skhpkKqIqfkm+4HyK+WGQdVXuinz3D21vdrsJl0xy9+GWMTptcoJA4DU7WB4POA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yeH43vPcTrmxtvR5EDQeUYlZILsKnLUoD+qsoobC8Ks=;
	b=cjyb/oy2fjUDJ8Aod2EyxTiQXwc3yCbaBjBGNeq8tVkpQ8a9HxBhuPdmngdXacIh/QJF
	 fNv5B/UStRokVSs1KNgc14muYo40PlDzHTiCdMll4uinUNKp46jRb6Rqx2TWJkZdsgkAN
	 ykTVoQvyKrJ/tiqYxSI+toZrVycOyPwIhFBK99F7D5uJioR0NwH9thWPECjMxPTKJktPN
	 //JXTQFkvxMRjdvrHEJI1TPp7JjtF23c9LYP/diid40QN9RDYJUZpw2vD5YpUAHrNnS1E
	 g5n3dXlTox63KxuQ6wUmn3Ur3fpA7upd0/vlKJZSpED3ez/vG/rope7rXbIs1FH3UrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzS5K1aj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76D606A326
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 20:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E76D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzS5K1aj
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2526406eec.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 12:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254880; cv=none;
        d=google.com; s=arc-20260327;
        b=nxg+jopZ7bX/2OL/mp2y27GMCTihPm58fj1VnXZjqjCcMfyhXETNsAS03ZyKIlTL+D
         noU3OEB9Mx0L/QrAyNpBN6YYALY3uLDAx5UyX6AGge4vjg2MRzGqxGSHZWDHB8KEFNcV
         m+vOfKrSHx1TQ5FkElh6siZr+HmRlHyvpfHyyzJq/8+5MvjDqQ58IXfqlRfwZYZ+gDId
         nGR0xbPyS0nbEfc9708xoXF9XtrSgInkH8WhtizLk6WSnJGa7IulTiJseoTSm07Fm6wU
         oefToncfcZS3VKv50QZhbnxlYxHY6lRGHbfxKUn3IN1RGI7EXd6n3A5TnUSrG/pBoEsd
         LxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yeH43vPcTrmxtvR5EDQeUYlZILsKnLUoD+qsoobC8Ks=;
        fh=kfjbYqgahMLRvmL0hJrdZGeBZ9tEOs+ivcE+rXxAS4Y=;
        b=NwjNDJFqSQhtCe6d/SY5GE9NnUpalM9yYf4vMGBV3q+Jc7M5mk5sSRG8WgWGz/YsUU
         CDJoTh2C+WlGiCXTVVPU/kYR5Dwr7UEpCwlumcp3aNG51pFxTchrqR3nbp1uyUOX6+ck
         d0DdaL2sEOsOsvaqwtBFAo2yPnPMxgollAneMX8h6QBu+lGq3Ug2Myqqouvf1WIPCYTZ
         ZXXEBHwTVWcxu3aPDldSaqhW2M4TZa86gZbOZjnFjBNCQ3rMzyH2b3e1heniDm6IcCKl
         ypgmSZUYLDUtMimu4ixzLQZWtOHYSPUdLTQG3IxEKrBXpbCQT8OLbiI9dVTf72hsMkiH
         xZ8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794254880; x=1794859680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yeH43vPcTrmxtvR5EDQeUYlZILsKnLUoD+qsoobC8Ks=;
        b=pzS5K1ajLL/ysho4dWDbqN799r7BUPcJItNm2WKd6HE8UbQZGQjHIWxpYuIVy4jY8J
         deWaSjucO5x/RPlLk0GuknYJI3UJrKe1/NgsXSy4p3PsNNGUm7H+98ywcrlse/vl0VKx
         YgOIaeKyw/ZUq4vwO3OnVq6kCpx0LxNb/nKpSEdf31x2ktnyCD3PmcNscntsjmbY0wKE
         r3GWBcb+0VNzwuGVD6wNzdwTPDvf2nB6Anu1yIrUhC2qbjxq7YnjTr4yBQtDexFxsqVB
         PovRMTFdH+7hCci+7SyYYWMnne0bVOb+4XrJ9pKpKbIQgRrUeMWMBf1v5eyS6EEwy2bA
         KNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254880; x=1794859680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yeH43vPcTrmxtvR5EDQeUYlZILsKnLUoD+qsoobC8Ks=;
        b=sZOAYEPzD3Cm8D2w31lHYXz4tY8rYIQxAgvi/VzCxQnbFhAKuEZ3YkLnLN4eR3pFW3
         xBGMdvJJP2nN6n4mLzotYShCPqRub2ar0ipVjL+ZgPjzfVFVJwP/QxZ+uIYcxf0RGygY
         DAzzopRToLdugBSqTAonurf2zTifdBqmjUEHO88ZPSY4XZsGGCZozu13WySwRElEx+jz
         PpZ4dWekTVirCIJQccgx8LRLEBn6bOPqQmguebtkLZU42hTCCFXhsIf/u9SJAxrDRD7h
         ETDYy5edc+GE5lrsXMSR+OParOC0hN3mPyAwgOFslvTo3xd3K1zhPys58O/96e/8BiIn
         jVUQ==
X-Forwarded-Encrypted: i=1; AL+hErH32wUzAhvhCQtWkd8l43sQTaBKcGbYQ6y5DAvjXd3+qktqHI4/xbRdAb5+oJT7cyVzpqrSWYJXyaw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OTYqEMue9AqfDCjJh/OHH3Dbh4IyPODA0YecaGRlZz/+TOyTF
	FGzmyhAp3s/hXdvCr/RZnHDPRXLOWDqtjIOV+75uufh8fdLkauvMbryJBW7Y5zTbIjmEBdxIIg9
	etFC4bxV0go2yQ28oDxX6DUwnipKbYG8=
X-Gm-Gg: AYBFou22bpu65gg9QvxtyMhBST4cde85Py4DBbkA6CfRARUXSDlq7AD4taQw8JF81P7
	qj4i/3OmtPG865n7EhmijLgDnHS13OyeKIxxsw7JASlWkB8ZL9Fl0gzH57Bvhmf1SV0qaOpHzN/
	lnI6xPW8YA01uEdAq24ejtTYwRVDfXI8wE9h+Yv7BLTPj6VZC+hGVyCfiY76GmsqkrYtBY+hvnw
	OjLQ1EyUB//6IfqW40oUCw3a0tGP0V4GLsr8lp66X8A2YxOodj1YtX4WUysDTrwSSFDJqwyIcuc
	rHWZKfxWN2q6IhCaxwYOGttlJIOtrSREl77d0nBl8Ykx6+MsNsPVGgaSdlU1LgqLh3DMM0/SB9N
	j/mNi0jYlI/J+TiDG2LbvlWmSL7aSu8uCWs0DzkkNor6mlYeifNZridj5QRzR1US+OrU/Acmwp9
	9E6RyYXCjXMtkZf50Hrqi1QIWuRoFEAYg7Q3GxLnxBxmLIAGn4rB8=
X-Received: by 2002:a05:693c:639b:20b0:369:ef92:bd7b with SMTP id
 5a478bee46e88-3752021a4b3mr405313eec.41.1794254879591; Mon, 09 Nov 2026
 12:07:59 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108094253.83899-5-clamor95@gmail.com> <202611090518.mm6yt2nO-lkp@intel.com>
 <avInQ08dVrsc-Rbo@ashevche-desk.local>
In-Reply-To: <avInQ08dVrsc-Rbo@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 9 Nov 2026 22:07:47 +0200
X-Gm-Features: AclHuK-uW4-VZbHI3Cd7Hqy4mW6DNnwVcXugR9i4sn8vPx7NjzrQMM_Kf1jGWpY
Message-ID: <CAPVz0n1FqXV-XXyBJpnp1ivd+uk6+zGvngobQZfUXMNBBPyORA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Pan Chuang <panchuang@vivo.com>, Hemanth Selam <hemanth.selam@gmail.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>, 
	oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:04=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Nov 09, 2026 at 05:48:09AM +0800, kernel test robot wrote:
> >
> > kernel test robot noticed the following build errors:
>
> ...
>
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > WARNING: modpost: vmlinux: section mismatch in reference: trace_initcal=
l_level+0x28 (section: .text.unlikely) -> initcall_level_names (section: .i=
nit.data)
> > WARNING: modpost: vmlinux: section mismatch in reference: __arch_xprod_=
64+0xac (section: .text.unlikely) -> initcall_level_names (section: .init.d=
ata)
> > >> ERROR: modpost: drivers/iio/light/ltr501.ko: symbol 'iio_find_channe=
l_from_si' undefined!
>
> Forgot to import namespace?
>

It is not exported in the core

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/dr=
ivers/iio/industrialio-core.c?h=3Dnext-20261109#n319

> --
> With Best Regards,
> Andy Shevchenko
>
>
