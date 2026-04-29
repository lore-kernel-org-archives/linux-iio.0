Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32AE2C158E
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489104; cv=pass; b=KNoVLRUcMtCg3BZFsiYCtulZ3Mo97zVl7PiiBPsu/cOi1h/iLWrFVXNfpEiiZFbIuxBMKOEpoBvLVBBL4VpF9Lv5VIMzNfG5RYstfWujxrRWiKw2yJTr3sLmn+mxJrxmAFYIMbTHW0JixTxD1aL7RqoGjH4bpGFt6YYfMLaGKHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489104; c=relaxed/simple;
	bh=oaJQXhM6Blo1vkgF0jcp8sJ4TxnIEpdXrLAqXt84P3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qk7n2ZieSP07tVKzkwnCQ4fFhluoF+9CqOswiHrE2Bx1JPw2XMN/P2++bpQHWbNbpJw8xHusnCAnFxkMpEkwuf5BRVkCAv1gHvPWhQTkIfiwli+2nmbAQcQ0wCRVeb//6/x8AriNbTD2lOpgw2IcknofY9nzbnvvDFGrK/eNbjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlXI2dOQ; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlXI2dOQ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79495b1aaa7so1212117b3.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 11:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777489103; cv=none;
        d=google.com; s=arc-20240605;
        b=LH82feAjyv5ehoB4zcjYRgB4OOvxOkFngB/cVZbbeSfX9hvvnecQTnKSM0pak+yyrx
         RCBqbcKOtd9PlYWpdE+GzKCTvFePZ2fn7E5vNh64trm+1A33/6R5Ofj4NN/7LJst4tRL
         pBRZ/dKnpRWoP+OaQkvQsUy3lZGNj0okebkhqfJEdByJc6td7DQpknXElUilqHT9DqGu
         mX/5x0h+fJhpmwSoa5SN5YVORRxW01eEoreEx1vWoBgbrBVkHZpt+rpJZs01pKBjalNx
         EYow2bGm962YIk7WLnrEoLGKQMh7fmvkQXqEUv6jHfQG69qgqioVfhUzA533WCJRDfKF
         zqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oaJQXhM6Blo1vkgF0jcp8sJ4TxnIEpdXrLAqXt84P3M=;
        fh=LUahiRvmmpYoXq+HWBSxWgvOHaGe/lK0++rkaTzRv3Y=;
        b=MXU9Po1RzdjaMX6Ct6yztuptVGnPvPe1wpy/8Orp/d1+ZHOQK1FDCqTK/MHefsA1+R
         C5vAnm80YZsMNtsYuKDEM1izyVoDPudYS/0n7TpRoOnKT22N8aHymciPiILLKgpRyyhi
         Ig7u/IwgxKZO524v5xttn3QvZI62UwHF4KHyW1CHkrqOCVqb16t2UD/3+OMZFu/84YGI
         8PfweOECjg1lbatOy/zBAgmdMT1jR9Nx8y+FmQdmgLu7JGUvnthSvrqNaCvu7R55u14y
         y6/VaAWLVhEnApY4VTGK8w/Lrh8VhhIGEMU4TRp0DNXCAoK47aBw30+tvFdElnetJ3+s
         gWcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777489103; x=1778093903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaJQXhM6Blo1vkgF0jcp8sJ4TxnIEpdXrLAqXt84P3M=;
        b=qlXI2dOQEbEnUXLFIe+En6FHjmJvrIQGAFG5mWrDVRD5rrJmEOouY8/fjN8CLndjbP
         8w4l24+V8/nKjTPT+dDGKzl7HlTu5FaI+TrW8XNBcpYOe7KgOkeiGILXHevFSNqvTC06
         DaIKSD7fKJj7Fu6v6zYXVHNGbzHXMNx2Jsyo6wxDwx8WU0MLNyEKKduMwK83iiG/h7yo
         ISK6TqprrzJdi4ja0O78DS7gjkqY2FaSU3Can5Zmb9m+/YturY6ViMkeuNpInnodUQjo
         57RB64qAl9t6X5byRZZ4mCN0beil4Ucl2uLcs+8ToyceZ9nOLFqDBwCYmX6aZ7mNsTEp
         fAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489103; x=1778093903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaJQXhM6Blo1vkgF0jcp8sJ4TxnIEpdXrLAqXt84P3M=;
        b=kygMmvreb3hRGZsvXNjyqQllVTJvOlk6et7slEq2s4FzW43JTo+syO6LP3Nf2+4Uia
         LtYlZ4gHFgfbdDTwn3egTlbrfQCkN1GeWBeBqkqkJQ1rkt/RnbBjlSQlIrdEhXewom0P
         MA/7fkkK+kDkadfC6e9OA+Cwpzx7jJX3cY5ReMoyzys9VVpS5Wog+Vzn8b/1qHYv0jvf
         XEftxOx+no92HmmpsX8SEbYZEgy5Cm1RtbX7J2JLOugGslLDMqrCUMFJxv+qEjQZuEM5
         6bMgLgFS4rnPrRU7qrYb5iUls7pmYf8b9f1jSKlRdcobrqE5w/e5HWIDu17NNfbeoQyf
         1HlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jSh1jwY5A0X7rGX/qgWOYcDnMj80d9Yvfhv91DNwZxhQ0DmveANdbfrCVspj0OjLcLBbMd3N63ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzioJrT1kmNiCqszFUu007BdjFRgl8aOuCG7+z8OiDmKU15Z7K
	937DJQq2r6Qjqsq31ZwQg5G8WiIv+8peRcxw1AoHOtkQe8X23hoSXN8cE3SjAo1J+gjXMNAJS8n
	rGt2Z1wiztetR45I1G6oKQKQU1k7dKqg=
X-Gm-Gg: AeBDievkBJyrfLDX/eWZ+Clnc5ozceCLCCwfdwaqq2M7GL1od1r79HNIShNweSs1V4x
	WFkPXreychzXqJIZsY/BkrReM9hdcRc/lahHpLni4p68bI09anJpr5NkKPukSuLl5IWzTwvgjvY
	v3aBSF6vb3TSEzEDppOFWWY1lA8C0/x76IxOxEaT/9IqS/xrCOEycRRuPnBi8FAyahxFfdWfkXo
	qz924/F1FWIdyTTMqSLg9fALEB2Gseom5Hdp8r4Uw2ikoOtuHloVsaaUdI2GiCgBOKqCIgVHRFI
	dJq1O8k9BsLi7VhgqZck
X-Received: by 2002:a05:690c:a01c:b0:7b4:b591:e77f with SMTP id
 00721157ae682-7bcf558d887mr70411427b3.32.1777489102717; Wed, 29 Apr 2026
 11:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428222600.91322-1-m32285159@gmail.com> <afHLYbjUjE-kQGer@ashevche-desk.local>
 <CAKqfh0EXYOjzyLcXfRB7RdBVfcNOkjpoL8H+7t124H0n17UKXg@mail.gmail.com> <afJMVuDFzziD4PYu@ashevche-desk.local>
In-Reply-To: <afJMVuDFzziD4PYu@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 29 Apr 2026 13:58:10 -0500
X-Gm-Features: AVHnY4LfdShXTpQJ-QynbXzgy1Tb9kzDkltcrJyN0aCcoBRsUNL4bmKZy_X85pY
Message-ID: <CAKqfh0H-TeXfQbPBLgvm91p4G-S8FnaHh19z+xGCqfzE8uJ6FA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 1:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 29, 2026 at 09:26:53AM -0500, Maxwell Doose wrote:
> > On Wed, Apr 29, 2026 at 4:12=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
>
> ...
>
> > > > + * rm3100_guarded_regmap_bulk_read() - Wrapper around regmap_bulk_=
read() with a mutex
>
> And perhaps make the name shorter
>
> rm3100_regmap_bulk_read_locked() // also use more standard pattern with s=
uffix(es).
>

Understood, that will come in the v4 as well.

best regards,
maxwell




> --
> With Best Regards,
> Andy Shevchenko
>
>
