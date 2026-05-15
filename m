Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7093E3DBF
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834308; cv=none; b=nxSMigi+dzro3Qfby/YdSPpqY1365aLU1JhMA2VGiNKEHekw3arC07dUdTQ2eMzSMk/XJ2sTQ96D1y7wuwdGrGyJ0OWuF5iQZHmU18C4jMi1gTc3zBgi7JGwlsPD5yJgZyrvuYMVmagjZj2kpNQLdr8e6xrpjqiqH0ZxfkipgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834308; c=relaxed/simple;
	bh=MsUJBDLFj30krvCb97q3qO1jJ5/R4gqH6OLypTiMYnM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1bx9x5Bgzh4QaLgPPSVb28fgr10zqjYi2Qp/7VXT1VpPSGVklk1SlgHTA87kMNy/rEvPrW0p7YM2PE94Bq0g1NTbaKPbu0N0LNxGuNKQ1dVe/cRSdeHV12hTZ+tBxPoltgIDk0b1iJUUqemZ6Wy39S5SETk2gxDsh9x/YnVosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=fNQVuthh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="fNQVuthh"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso8503615a12.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778834303; x=1779439103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsUJBDLFj30krvCb97q3qO1jJ5/R4gqH6OLypTiMYnM=;
        b=fNQVuthhkMOL5HGyt6FU0uci58PbQeiBKdzvL4FkdxhJ/ZRiR5muHDgpdkLt9SUC8P
         bq5vQIrvZE15jxAvCXeIyIMJUEy57hoguChyKlmsYUSDVCLQGcfzZfVYbPPDdhcabbcn
         kPCTcsZ9zVNLryULZAYRJniBM0mn0gt5rjNTW/FK9BNGrINq7sqs8WFooBnIMrnNUYyg
         y1uYAh1PYK2pkqsthpZO1BpcE2NbUiHMlmsHRWWWudc48fyYPffVb5f2MCg4dGxLKhWI
         T6EWmkemRWlix3v8/QIZpG/lGrW2ulR7e0UGnH2JDmjqwFHFZhBpxWIlebo9yZH28S8t
         ZpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834303; x=1779439103;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsUJBDLFj30krvCb97q3qO1jJ5/R4gqH6OLypTiMYnM=;
        b=J4Swdsu7i/IJNkfS/PcSwjqt83qHjcn7MEumg8GJp9iVtLL5Izu4YAqp+2d7Zsz2Gk
         BBiRbRK6MytdGEq98Zu0EgW5RGPQujFj8OLZ+RYhpLB1deeVwKiOzevAnfp1cxmiCDRe
         1x61SP6I0Psp+xB64YkGcqv4u2aZM1vOi3XpeqKy1CCh4Gg7H3r1KCu3loFl/y1WQx91
         zoig6mI9hc4tbExxJV0KUQmoSMD8PpYuhwOR37bDCW73WVj8D8RxDVDSFxr2aCmbz4y9
         yAWGzzTOVFnwl+ek9u+HkMdh44lCaajQ6Ijp2tv6kYbmZdnnQIZqusOK1HtOBsA8yigu
         w0Mg==
X-Forwarded-Encrypted: i=1; AFNElJ8iniqIyNv8jewkM1p1p/p+Aqxmn0nsfVaqCnD9/w/GflMYCsEza6L7g4+Vipz9jjjHNTTUMB60zb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3ry0l4L06dMBoOyaSR0jDA+DStKA004B0pVIigc7KRzPRpC1
	lWSYORQeJEPNnDTqqrhuBsiMOm+Q0plCuhy5Rux7q39IRoAL8jxOZq+JMTPTncjy8cE=
X-Gm-Gg: Acq92OEK6pHf8CG3M38h8R/2wvUePZvDFg7Gtft4eveOXBNFfWp5bHDmZsi6awlRA8l
	baWY2Ir+AfUlbFCtbE47lQEekALGkWb3/YMI6E8AT8KV7VeBhqgWqibxYf9bo5vwLax96b2TIgW
	EPFzYjOFg6TTFAodaV/5uc4K4EVTzPbTmoK8DpzhLKrvTSvbDp8AGXaKJ/dVM63GvieQl7s/Z0Z
	ru3vHb8q6N5tgCLkmrlwbO1RYi06bL/0/zELmaR29q+/JSsbbl0QjDlIvbbu6hBsSvs4GHJv2R1
	ia3N4fYW+1XHWEHCJKqHhavJeYDOgx2pTMSpsw0qvaZYkLHBe2raSDslO85ZhoQIoUSB39bZPP6
	2pAqtG8bHGNXzQLGASBL3CjbWPi+Is8EJLA6COtS95c9QCBo7dedyhmbwtxNkZX7j6lIho4IXlW
	u3FrwPvFOPDm1JFZ+iMcSFsYqfzA==
X-Received: by 2002:a17:907:c714:b0:bcf:9dd2:f79e with SMTP id a640c23a62f3a-bd517964d82mr164496766b.29.1778834302554;
        Fri, 15 May 2026 01:38:22 -0700 (PDT)
Received: from [10.169.209.7] ([151.19.40.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c3150dsm195094666b.24.2026.05.15.01.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:38:22 -0700 (PDT)
Message-ID: <f77e96bbf0a85cacd3ec300bac3bf4ed6b8605b0.camel@baylibre.com>
Subject: Re: [PATCH v2 5/7] iio: core: Add IIO_COVERAGE_PERCENT channel type
From: Francesco Lavra <flavra@baylibre.com>
To: Liviu Stan <liviu.stan@analog.com>, Jonathan Cameron <jic23@kernel.org>,
  David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com,  devicetree@vger.kernel.org
Date: Fri, 15 May 2026 10:38:20 +0200
In-Reply-To: <20260514144712.64374-6-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
	 <20260514144712.64374-6-liviu.stan@analog.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-14 at 17:46 +0300, Liviu Stan wrote:
> Add a new channel type for sensors that report fractional coverage as
> a percentage. The first user is the ADT7604 leak detector, where the
> value represents the portion of the sensing element that is wetted.
>=20
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> ---
> Changes in v2:
> - New patch.
>=20
> =C2=A0Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
> =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/uapi/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/iio/iio_event_monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A04 files changed, 13 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> b/Documentation/ABI/testing/sysfs-bus-iio
> index 925a33fd309a..0570e8b8f5e5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1980,6 +1980,16 @@ Description:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Raw (unscaled no offset etc.) resistance reading.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Units after application of scale and offset are ohm=
s.
> =C2=A0
> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/sys/bu=
s/iio/devices/iio:deviceX/in_coveragepercentX_raw
> +KernelVersion:=C2=A06.15

This should be 7.2 (at least).

