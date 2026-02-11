Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144F34EF1C
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770782064; cv=pass; b=Tt3Kt8NgEUPWOJssM4w6qiDms5tGYUYPwQhVE/vgX4voanemJDmRaAAHtCsSV8CweFwMBYt2BsI8uKaqF8m3h6ratBxTwu0yESJQjUc2k/WBnvtF8zB0NaKgTaJuZCWiuJn0f39FoJlYzCKEtT9jz/5yBFiGhVIjYfHDop08NMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770782064; c=relaxed/simple;
	bh=Kpndn7Ynt5Mhcbb3tZDmKrDZBVRVefJzjnWU6cq9rh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXt/0HOGRLVOQLh7ipLo0ROTsFdotbpA55Ol/TlvjILoI9A7NbsOkdBs7XynjAPQ2nQyLYLxpwMhB4wutnhEP95nqJbIypo6PGp5T2iXRhBcYgn5jYMTmPQYfwGeQ0RcQ0X4trV1hIVh5obCbIBQ7zgaGj4S5y+0/IxXYlJeY9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX88eyc1; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX88eyc1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50333ade4b8so4540101cf.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 19:54:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770782062; cv=none;
        d=google.com; s=arc-20240605;
        b=EFuwfgiFnvaQMWYkomcaoB1ie5prjwe5BKorIqTtk7t21v4w0XvIxjp1XtrnqfeMV1
         bUupsNfRLymCZ3Dph8vcWzSXuLnu2hNf9933pdaq5vpTv7V8jd8lEh1NQDCnp5jYLBn+
         EKpbv2rAA54gS7I5ENLylJq9sXLDLeMkB0w72gJISrU+zVjMde9k41HCMhPfKWaH148x
         qkYwBCv1bAAGW/jiF8fHIWDiCw5CD6LxhwDJOpG9LYW3oeh3VZQ7zmYzmUN8JS0kmNpl
         m6zrCV9nRBIEwLURUP+i14CJU+OjE4h7xUocIWnH4qO0dgPg6I0PXKk7idu/3SMuoUNN
         zGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qibh9Xb+pnsV0G7G7GmqkDCjhdOrXcRx1DU23MEWVA8=;
        fh=tFtcJG7Pf9bMuMOx9jkGOSbSNIj2pAxKqambjT4NaGM=;
        b=HIxIXQ07+WtGiaPCFv8zx97B1TpunZxZmAqDDgLPol+3aU50LgkYLhYLRib1VfA+yy
         dtEJOo7Hhx/o066Q0fzOuYM26yL+s38DW4TMIpFtzaCD2XrcCdPlZazFSA/tiBGn6QPw
         XnrYI49VPke5DV0+ML3EFTKjtAsMKAVoWqQIfCCcdQKdOGKiqnlrtKqa+iKSBioOXLnr
         9kb0Z/6kS9yxBl9Qykw6RCe0wzRjnuR4v+soXo0FWp1DIKAb3mc1Y4VTEBclP+Pq9zFr
         cf0DTlEyjF/MBGx3WYLryr20Mn0uxLttfyDpxxgfKoVxnw+NckgKK+5YUVqw2EfuzF+0
         ewDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770782062; x=1771386862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qibh9Xb+pnsV0G7G7GmqkDCjhdOrXcRx1DU23MEWVA8=;
        b=WX88eyc1c9ppZkoB+QHkqgiG7SLfrljDOLKxdmBJaRlVFILkgbuYVgUlZAlTRJjQD0
         yo48pH44vvsUFlz3yqgSlB2Fhu5jtHgL3ov6bLuFOTYnJ3v/7oQwfrmFLjkDohoaPeca
         C9c4+11M9hOkOypWo1cDHG1G/Xu1tUZ6hPQkWYKMiNdri6MllOj8FdBeF8zOxT+OGLFV
         HiuYU+uCN1Axrkv8YQjltPxFrlqbwcYwgmWfQyMke3iKfjEkxaY6sBB0f7ugLS2FFvKZ
         ZxoYtLOrehZUQh9LXkT45R5HjyEoyRjZL9EkY/rbkukde8Vq8QK3VHTz7qdWwttIR9tB
         2HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770782062; x=1771386862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qibh9Xb+pnsV0G7G7GmqkDCjhdOrXcRx1DU23MEWVA8=;
        b=jqR05/uf4oMZbZ/Op96ifpD999TMPEViWciFDYkip5N0LXgZouWI+2M39qnXP6DIrb
         mIHuZljotej7khrpn1nFTDjXLZ7A8EZzwVXlWXYzAilMLHo7DYOz20Xr64u69wRqDfL7
         07wfQaXaZiCdAYSP0nasR1ayT68tK+XnNAtLLNpnnSq2rYC2XF320EIkTEEMr01BFab/
         hIcu1rvAYhpaGrG1RQmZlPWFsJ9YM/QWOkvFc1O8+DQQFXp2xLG7ZcEoBfQw3/ni7ZJj
         sNGLS/UFEyyprwExCE/hDvHri8YRYKKCEDkmr7RZuPXtGeThnpp3um6tCpOfWOMdnMzS
         kqyw==
X-Forwarded-Encrypted: i=1; AJvYcCW2IrxhHGr5OYzF3H2ksnS2CAGcer0P6cGJt9C0EfJfoDW0Z8PsRviyYXTuMeBxYkvWNCxIEf/gLD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fYg3xPK/TILiCBQ3wWjuVz9FqfABu/MIN8R+MQXdzqbYNl39
	qm868Jgjiq6s6AlmRgIH5wkNqTRgRP82+1HYMhiRnlSl4N42ZdgTMFa0D+jDdzi7aXiywMkbwqd
	zr3VIVBnxjiQAf2eY5Ix+VlZnlLq2b58=
X-Gm-Gg: AZuq6aIf11GOWSSHm6xJPXG46Bz9N3TbBeK1cP2182Ti+jicKWRx8k/0RJZqwLW3Fey
	UsJ/z7ADdeg3rE/Ucgeq8Kq4YE1X14KNm+qWkxnC0QcGqyyom2XwX+P0nY5BZVYpux93xNTtmIs
	pqhviZpnjbprdpjjBSXO+ytzxnkSthiO/NoIiDpIrEKLEbvzhndVIwxgVUNH9lNxA5kq+67PW0w
	vHNNXTa+0+aJ6r6NOhLHcSp3M4w91I1HpQashl02XwLtUp+A6FlBM4Nll91xuBd/Vwy74rfDEif
	H2JFK2vmOf5iNK51QLB5CxGQMXR4HWJofHFNZxpWuVtIvanCf//VXXvqiIFb4rVQRXyIME8Y
X-Received: by 2002:a05:620a:46a4:b0:8c5:3892:a554 with SMTP id
 af79cd13be357-8cb2a2aefe9mr41885485a.3.1770782062644; Tue, 10 Feb 2026
 19:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-5-2b4d74e309d1@gmail.com> <aYmeeWeXRdPHZxRr@smile.fi.intel.com>
In-Reply-To: <aYmeeWeXRdPHZxRr@smile.fi.intel.com>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Wed, 11 Feb 2026 11:54:11 +0800
X-Gm-Features: AZwV_QhSTatCzBkN5UpJ1_YnFGgpQeEWJl9lfNopf4vG4Ke1r5HimKJXRSz0LG0
Message-ID: <CA+NOmzLXv8C-i-dHxdsQ2bCCYxhU4ay2ip6LXK-rcimWSZA-tQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: proximity: hx9023s: add ACPI support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 4:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Feb 09, 2026 at 11:37:06AM +0800, Yasin Lee wrote:
> > Extend the hx9023s driver to support ACPI matching by adding TYHX9023
> > to the ACPI device ID table.
>
> ...
>
> > +#include <linux/acpi.h>
>
> Why?
>

Ack. I Will remove this.

> ...
>
> > +static const struct acpi_device_id hx9023s_acpi_match[] =3D {
> > +     { "TYHX9023", 0 },
>
> No ', 0' part, please.
>

Agreed. Thanks.

> > +     { }
> > +};
>
> ...
>
> And since you added a new ID, please add to the commit message if this is
> in a wild (and hence the vendor and model of the device that it has) and
> also an excerpt from DSDT to the comment block (after '---' line).
>

Hi Andy,

Thanks for your comments.
Regarding the ACPI ID "TYHX9023", it is for a product currently in the
late stages of development. We are in the process of formally
registering the "TYHX" Vendor ID with the UEFI Forum.
To ensure everything is compliant, I will withdraw this ACPI support
patch (5/5) for now. I will resubmit it as a standalone patch once the
ID registration is officially confirmed and I can provide the verified
DSDT evidence.
I will send v2 for the rest of the series (1-4) with your other
suggestions addressed.

Best Regards,
Yasin

> --
> With Best Regards,
> Andy Shevchenko
>
>
