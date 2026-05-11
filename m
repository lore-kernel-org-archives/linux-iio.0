Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FC36D4EF
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468424; cv=pass; b=ex17SlyzgtCQsBcIPAw4t5ZtC2fWHA+z2yoagoe+JbJUlUZKkM9HvKnFel6RpZ4iYq9zugz+CISBZeX522LR+QS5u1PMiQOupsYbxOlodQqfvEbYFqmYDD0wrtKjChAhXn2Iy7xwM1zbg3ggDVJX9xgLFjWkn44pmlW/zESvPjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468424; c=relaxed/simple;
	bh=wnYjSkPEZQyv80cNHSsJv3e31CuX6BxVqPS6Cj5wfU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBvYbeNApiVD8WjVNPpqrwMiY+B/P2vEBBa4X4Ag6eN9VkaiCjWK+7SNvHmvrlbuwTkKFrkLfPFQ/WaaXgb1uFdOfrL1ggkYsozEZqmvedR59AUidTyfBpS6uzD70MpgpdG2TeiAwlWRI5kSESNc8lHKamlVvxiYNUMQYKP0FFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rbx+uCAW; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbx+uCAW"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651c7ddf514so4040524d50.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 20:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778468421; cv=none;
        d=google.com; s=arc-20240605;
        b=Sr9GXLNjiuWx4q2aBUuUsdCT1XrcVzrVoV8m1X2dkhZZzlTrCq969gYPEjHEhY9tSD
         noBmsbHVeL0sOohobBb9iGhIACHrbkLAZmjZcLb2Rfi80sim6xJtQCUV6hOJ8cLTlUFc
         aQLzqYDpzTaGTRVUm6wDfGCpYV6SxtST2+fXTJ2uV8Lkx7JcC7LY6+36QXU0HYA9u+fA
         cS6MfSznnR3ZRTjiOC7G01AmLxnSNcxBeg+IhOp1jRhB6NnRQ9ftSgDnY15Kr7IYPFup
         CSqwnaB2Y1kIZmAtBmBcUYB2o9G+ZW7i+y/uWOP9Z0OGbgFPJdQLIGSNt+VbMBttMWAQ
         dVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xbEMPqybMxS5k6emiP8oE78P9zf/hCdjeiCvMvcaJ/E=;
        fh=AEc+aTt9+Gt7sSD7f7Z3fwKKFwDoTXCngZT1vXu16lE=;
        b=C7qYfb812ilVGc6AqCGveEpQvnum+ilQeCjouPTJDL7naMo6Vc9tUsPXATUSc1QSWV
         HW8j05p3+CeQhwVTKIf/Ovmolp3TGlzJ3dskfZDUqdyjxBGMjyCE17XADfNT3gXx9fq6
         A1plS0H9KxFXYyRXW97jKMbAbu2HlVALI+NndUdjpLqU1EJInRgAuqqtlhwTMFhbjj0y
         XkRlprhVz8psEVgHyOKtImU1uuTP4YmFxGbFK9PN8PGrnaJL++848K28URyRiScnvDNS
         WgwNb0njbGJVuhM8YSF6Od1loAQLmyEVwIjOzy79ZE0jx4Ovu2Gyvcf6HgGiic/AkXnu
         OXvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778468421; x=1779073221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbEMPqybMxS5k6emiP8oE78P9zf/hCdjeiCvMvcaJ/E=;
        b=Rbx+uCAWJaSOK+rQEWvTfL5wgxcvjwxPuPHUvDADThTRUg3G4P0Ty2s91ulx3XusTx
         UQqqfMHRF47fjcxaBC6mKKadFOD1m9aS7V3sQjABVISS1+wDi9xLowcyLIIJ3Kh31Aom
         llM8FQUPem9w0rjHdILJFAJpIb7gqOtxAbMPQWLdLd+/P3ghxYIAsPLEtt2wth0m5lle
         xbIPalwXrOqXgOK3SZJwOxgPHkDr0zJ2DJ4LYmL+0vdydsEjoT6LR2U7TUdil59lYAW0
         EVoEz3fJoSpzl5jjdjj0NkqgIpy5S1RsJEGKoKZFQnLuPpN0R/ezPbW1sWLN0tbAtU6s
         63Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778468421; x=1779073221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbEMPqybMxS5k6emiP8oE78P9zf/hCdjeiCvMvcaJ/E=;
        b=qgBOivRRi+ZdkwPh+2Qq5GwHK6mgs6uiR3HmvkV5f5jRlHZBl/ekuW9dQQEB5vNjhh
         OYWjk9WWs/35ViTLnQ3rtSGjlq4Sgi/hWUJZu1chCqRGpvTHEHmLw4qRK4+TnAmCBO4c
         4G3o1qqd3VMi9o4Xmj2TqMGmN4Fx2bDhklV/UK+nAuBsNGXqOqOsslmAypmDqDrXy7Mg
         XhTesrrTQRKLQGH66FS+Z0e0j5O9X5JURXTC1xOcogECdNBux1se9tvYkdc6jCD5mJzv
         u6nnaTebtprcKjyPDQw27oWX5inejZoQGSOPVgMn2GwCHDDWvlrh5DdTffGbJ0KH7Suu
         2gaA==
X-Forwarded-Encrypted: i=1; AFNElJ8hPklbwzE0zU9SRL/oyR9RfqK0SIX0LJ+KgplEk3m0m5WiBBgkrw87IOctqHUkckREezYFskjzNG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeaF7xIZYSxu89fhLnHApsE1L1QXm8xo5as75B7QcwSgGAhBQs
	FkPY+iZjjObNT+uVcqkmmmdb8k0n0/rinGeyrx0+bcy9MCg+xGAJ4dl/gUZg8UM3lUdCtcOrW2G
	Mos2EOmytlIf+84VeTG2PBCZucjt1hqQ=
X-Gm-Gg: Acq92OGzIXnIR3q2TRDAgQiBisaG0BDHfNLXHEWa4vaA/gLGwmB8MuIGxBBFh1WoE/b
	9yeaxtmrR5c8VEmN3stBW8xb1SIyO1WUxtOrPc4Dhl8+pOumJF2gFAfhPME4W6N9rgLxMN4w4EJ
	e9edwiGYejKcWs99NnGdBFc/0BBueMiYZkXFuUjX4OhmlJMIV4CFX5c4XaEo9/84md3zLInrZgH
	pyGk30/FOBL8fZ+CfMIagmHwycBUstpkhGOUV/o6RJoThYj6EU922N0VjNdFpoPjB6vDLv+o1r3
	3Fz2
X-Received: by 2002:a05:690c:ed5:b0:79a:6249:a046 with SMTP id
 00721157ae682-7bdf5d98b5cmr230355457b3.9.1778468420966; Sun, 10 May 2026
 20:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511023127.86113-1-dennylin0707@gmail.com>
In-Reply-To: <20260511023127.86113-1-dennylin0707@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 10 May 2026 22:00:10 -0500
X-Gm-Features: AVHnY4ItALizYXQfDO8oKAdbFa7ZxLNbEt0uRHNyscwB74f03CvaVSJUZ7IqBrU
Message-ID: <CAKqfh0GVDCQzjTj7Hcejx3fgEPYeuT7cv7PWNgxOBWG3wEyUng@mail.gmail.com>
Subject: Re: [PATCH v3] staging: iio: addac: adt7316: document SPI interface
 switching sequence
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 9:31=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> The device powers up in I2C mode. Switching to SPI mode
> requires sending a sequence of SPI writes as described in
> the datasheet.
>
> During this sequence, the device may still be in I2C mode,
> so SPI transactions may not be recognized and can fail.
> Such errors are expected and are ignored.
>
> Add a comment to clarify this behavior.
>
> Datasheet: https://www.analog.com/en/products/adt7316.html
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
> Changes in v3:
> - Add Datasheet tag
> - Use datasheet name in code comment
>
> Changes in v2:
> - Add datasheet reference
> - Add TL;DR note
>
>  drivers/staging/iio/addac/adt7316-spi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
[snip]

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
