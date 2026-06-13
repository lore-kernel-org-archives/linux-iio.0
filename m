Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF764CA45
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781361887; cv=pass; b=kz2MR+a6nEg/vuWoEh45oVCRID9HSjL8xz+EMB2EwqB6S3BIoNKbl6bJEpg/qxLyZc97n0mAit2oCEFw5tEI+5LZTXkRGG2soya4ui0LI/nlSKHMgXtdg0u+2c4Mb1wUPGG1xgIyNtCpJSyV46S0qVaVrZLERigDSjdBYTh4ovs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781361887; c=relaxed/simple;
	bh=86NTdW+NbCek4cKjhKk7s51TwDhFn7gWhVdpadA+bzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7fM9qJKF95siLK/tqvHgx8TRJuLDKgaWpnFcDkFkta/PBqhv4UIT+75/queVEW0FsJvAtk9MtkDLdoCxusbKiMw2j8lV5o2nJyJZtV6VZtWhVh7AJlZJrADIWQ9P8FThvC95Vc/ZE5JlueOxjFps1HH+d32Bl75q7VqMX5cOAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYsN6kKy; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYsN6kKy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf22d29dabso12755935ad.2
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 07:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781361886; cv=none;
        d=google.com; s=arc-20240605;
        b=Ahr8jph/ap2qPiIDcECtAP9b/wJCM0AQ9Xu/WjhZVPKPOD1o4xo5OxC9T06E4RhYdh
         nxQ18iC5RuZzPKUWkHFaRrzCGnLuoF7jTv1QsvU5tcCyQnWLOLiYiFkEJhzc+RQO+8va
         dxhZkkwm1RVI1SwQ3Yh/Z9jHR5d9qwiHkpvGfQakWqSBwF9AzFz0ZkO79KSINYXz2dCd
         7j8bM6SiDbIWk8qIofMYxHzIbJ1U+BgRA6sQcEmltz8bUWafL325TJfEVoEYlJ0eZ0mJ
         eEKQs2uQT1LzPlWa19RGvO9IztjmHkMD0cXr5jQ8RUFXt7DSAF5iHrAa2o/9aJqZVVU8
         5trA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LfIK2PZtJmuHODCnzyUxEkui098rwuKHvISY9CTcfoM=;
        fh=rOYnmlHOvLoDyWrAI6Actstz/ATQSH0dxGlcbpnjI40=;
        b=WA+6ddljIq5Sks6nU6YSqpQ6ZRL2hGz98x8FImfIm6Vv6jm/AXD+bu0ppqP2HWHBaj
         i+AGf7+HjSBK4OCOhAIUJPC7db0gjMamHQT+564bc3u37m+pzoxw1yFrqq7tLP7TRRzl
         5SRPt9pRyHrYYvA17P+bZ8d/A3um8+iJQUXPVu55G0foPZDlY5HWH82N+geBWNn+wvFS
         pvtlzv9w+65HyGZWVpv7wwfa4IwMltAQC1aN+DBRLYvkhOEGRmkhrO6qTNpBogb7Q0TT
         akRVMcUSOoYrzdIdcJp91lyOAo7YYXeTmfxaY6aLq2TUm3QmfEL8FduB0Cx8ySUOASFp
         ZyKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781361886; x=1781966686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfIK2PZtJmuHODCnzyUxEkui098rwuKHvISY9CTcfoM=;
        b=AYsN6kKyNrN7vxTJgLueVqWQX3CAC00mOrdj4ckMej7K/fd7TFpA6/wBrvAk8rVrRy
         0ti9Zr56X5na+JI4hp+71RPUu1mdkh0AFQf2DLk6QJhR3KNCySoXDQH/fqAou9qXob0L
         fOVJX6f49As6mlSf9a4q8Sp86qVB/fmdHnffzF3KhkHJ9fX2rKSS8iRXtWKOmHfTVIyk
         ppcxt5Fgr+BLFOvOsBnoGWccvycPqc5oBB16J4goI1NyGQU/Zyyfg4MfONGDvv8h5F/J
         EX5jS1hSEU2UtU8P7hOTKeRbed/lEp2nzrmohAwcgjkBV5+kXyXWHXBFVTfAbA0KXQF4
         El/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781361886; x=1781966686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfIK2PZtJmuHODCnzyUxEkui098rwuKHvISY9CTcfoM=;
        b=Mt1O0t/g9y18/Yy+MKzUbzM++s/OLFYRfPiACnfpYs1QJXhH2csTy49qRAh+ilUvrQ
         ilwuwfoZJ5BQgf5Wc4HkoeCllhFOJbphsxo9K8azhiso22mIIJlDlZlDQG4hSjLJ3LqR
         gJAj+BbH37wgjBhDO59Dp7+8LFqIi7mjHnraM/Ge4L7rMshZw6BiO6rEYLF5HXLZoEGI
         GhPPPZcM/GN0MYfJrbq/OwwpcgzStB5JezYHirl+7K4oADrBocTy0240fsMm/RqNBFJY
         1gAQclFwlBzkBKyOMRrrYxT9qJHZZ6BEcx+lPQl9H5lGqRfZKEKtBGYGhXDAwgZoiDj3
         2KRQ==
X-Gm-Message-State: AOJu0YyRRE3Zadfh4P51aumXz4RPsgDvXcxMbuvjGbfRjU8gtBerQa67
	29A6mSqa0bd2FYaZg4Vy3VvnxXX+rUEqbCo78N0UNBeSd9N37jsxu5T8tbJVGpqsNPGaps3qC88
	shR6fQ02ad5O9r4ltTscyaqM3CEo/2fA=
X-Gm-Gg: Acq92OGUVyyWt6II9cYcHbnFc1Mtb+llkAcpE/v27dQxprLp4D8IbuIbxLnc156nc0T
	T+ZItYva9rvnvKeLoUFUqeFVS1RRgTUkVGfDQlJDfeT97Grpu+lsKW6oNYVfaiy0EPUiOmZNRKu
	wKsnN4J4r9LHk1e+yNyDwHeeNuznC7ZEKii3QTj8WVDr5smSA6jrMoSuaII994aWL2fFu6I4nW0
	YgQFpSuZJ+OxupqmWBpfIoxWnuwd8pMp9deZ6nIIec4RD9orZbORjRRKR17WPyLhxg3q6iG2Fr/
	R1ZTOqmRGYFSkhGXN4QYKT3AHSo8vEuqSsS6Pumo9A==
X-Received: by 2002:a17:902:cecd:b0:2c2:27be:39a5 with SMTP id
 d9443c01a7336-2c412749c19mr77866635ad.33.1781361886080; Sat, 13 Jun 2026
 07:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com> <6305149b-d334-491f-85c2-085fe42cae98@baylibre.com>
In-Reply-To: <6305149b-d334-491f-85c2-085fe42cae98@baylibre.com>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Sat, 13 Jun 2026 16:44:35 +0200
X-Gm-Features: AVVi8Cfz4IX_TpeH5YZd6zac6lnjft1zg9LNtxbE1kCwNta9wqCoKYgUnsgN4x8
Message-ID: <CA+gq5Jifvz-cvcB4hS++W0_ELY7rPbO-u33M9f7ngAtgVgUUoA@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: Extend ti-ads1100 driver
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, marcelo.schmitt@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jorge.marques@analog.com, antoniu.miclaus@analog.com, 
	mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com, 
	duje@dujemihanovic.xyz, wens@kernel.org, sakari.ailus@linux.intel.com, 
	linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 9 cze 2026 o 18:10 David Lechner <dlechner@baylibre.com> napisa=C5=82(=
a):
>
> On 6/7/26 1:35 PM, Jakub Szczudlo wrote:
> > Extend ADS 1100 driver to support ADS1110, which is a pin-to-pin
> > compatible device with higher resolution. This patch also updates the
> > device tree bindings and Kconfig description to reflect the new
> > supported device.
> >
> > Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
> > ---
> > jszczudlo (3):
> >   dt-bindings: iio: adc: Update title and enum
> >   iio: adc: Update Kconfig description for TI_ADS1100
> >   iio: adc: Add ti-ads1110 support to ti-ads1100 driver
> >
> >  .../bindings/iio/adc/ti,ads1100.yaml          |   3 +-
> >  drivers/iio/adc/Kconfig                       |   6 +-
> >  drivers/iio/adc/ti-ads1100.c                  | 165 +++++++++++++-----
> >  3 files changed, 131 insertions(+), 43 deletions(-)
> >
>
> I assume this is v2 of [1]? the subject should include [PATCH v2] and the
> cover letter should include a changelog. See [2].
>
> [1]: https://lore.kernel.org/linux-iio/20260527164312.355729-1-jakubszczu=
dlo40@gmail.com/
> [2]: https://www.kernel.org/doc/html/latest/process/submitting-patches.ht=
ml


Thanks for all reviews, I will work on implementing those
