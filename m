Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DE95519AE
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872600; cv=none; b=I0jAlBQC+NxWOz0NmjC7k6d1LDBOlELxDXm+CMUUNkHfmajY4IkemSkjlgK82SQiPR5ZPUVkdPUbbNFeTPmS5BWifsLvRr5Bx5OKqY2R94pYMsrSXQZ/+xty+1O9KXQO3JuabJ2XK4P+Nj5fUAOxEQ4Y0h5RrS1znNehqZmC1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872600; c=relaxed/simple;
	bh=/litBUCmykqlKIXM9mqB+Ix6fkKAHYidvnz5JeC4/bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Koq1Q+I7UbyolE0qpk5r5vQDtag0aTGJxetXt30PTFfgaO8iJNaUXKH2LnyDwYmpzRq5eZj0Yq7c4dfevTbkFTY7GOa8FwIXTiBovH/KsWlxcSw3jjQlw6zRtzGFdEQGVF28EiOR3YTyRpcB9zCeMRqU1VAgBVGDj+6cLfO2Cck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqvrTgpA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqvrTgpA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso50096115e9.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788872595; x=1789477395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/litBUCmykqlKIXM9mqB+Ix6fkKAHYidvnz5JeC4/bk=;
        b=aqvrTgpAcqZ0INMXVDRhgGYj+qryYPu19QHumQ7VoA/AnJJCIkux8bo5WzOgY9enYg
         savjeiDfENMq9D3z903FnLln7adYaM04WUK3ecbYK7ewTpH9EKmgtSUW2MiHXRCtWUMN
         MWfjqy7tp59ENjsGAWWuNAQDO6/E7IFCaK4WcQeXic9cGHLqMGUsfe2pIcEx7cY6Uq7N
         /w8SiR9nDAR0cTDIiaY//+GHenOnT31lFwXunNoc1OstiqYgJGKJzf+Ku7pJrhkuTp/j
         CzC2xobdBWOPpfiBQv+kyNnos53AtmO0Iex7NRFRm0tl0VLGdG4m0o2SGcjAMgMBv4ve
         cihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788872595; x=1789477395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/litBUCmykqlKIXM9mqB+Ix6fkKAHYidvnz5JeC4/bk=;
        b=f+p0oK/lcb94R4xSqbn/gkykNPAsoKc695eZzgXyOF2kTtST5fdIJW5zVdT6U2dRWL
         WrBuPOHjxdSlR8FOa5xOA2vHvfFtl5zxPJugq/ZZVwT+/PJNTOnu3iueAqsiGmWTno40
         DTR6+hPejXJJzVAFG+QZxGGeVuEbZzb846kH+29eN8DWkHvLF3pAXwa6wIvoH9X7XaY2
         9MmjyaRzhKooJ1CuBl3sWRy5pllsAGUQmfNRU7P+lbB5Gujn/7Wj82flIUrnE1I4WWIk
         zCjjjtbD6hlEmbTJxpJbyXmRzc0lqpIfwz7EAUH2/oUfjf+U/WaoGDHc7r4e3/9bFQ54
         FIlA==
X-Forwarded-Encrypted: i=1; AKwUvBwy/+7kvbffdQ2l+0ViJ87I+DtcfGUz4GbX+eF7uSNNSeHgBDswzp+PV/lWH/0KraWiCuwhnJhzP0U=@vger.kernel.org
X-Gm-Message-State: AFuF++mJm09RVRz6TLwxo0n/ZU2JtSMj/2NXf/mmf1hLHV++Ed2FmZBK
	ibx21ehcGJEFZwOvGTI147Wjg+4J+n3SAVokPmBGJWtONBzC6pyDip3+5DhjaT+wOwg=
X-Gm-Gg: AYBFou0iXntbc2gZauvUkFvEtdtth6uSuibXxtjMurw8TYse87QZccCDRjMqFuYp9zC
	jpINP9GrBb30xy4gt63YPBQAzszVoV1bpxFN8cxA1O57xuKRXE4RznDjAzOOoq5Ia5HQlXeL06T
	TjFa7lREYQ+acCQlKbxc0x5is3j0oe0MdTwsG2NNG7V9wuO+w7sTMUlSgyScwnoxMgsUihE2rmj
	BuLhDfgtSEyzqJtVlCJx3wKnAHbqg1xCxqCPSDbCU+Nv+uMo6c+itrY+E9dGEQShQGXGIOLG6Sh
	L4O6H+GQWh8umSt1CeAexGbeZED5dI4xnHr+b7XqyYzJTCuZIo88kWs5m8dmsE/mLFvzkLi2nqv
	hDo2+r6NFzERWPycwkks/I++UTJIEI2rRgwxI58rg47m+Gcei/bfJFZNjLAD3s9i1Vivl2As736
	yD8M7cBB5KsxSARzItdUattswJhvRAMWyP57I//DQBrsRIg8KX84atGZkTO1PhzbhI3NEaJz0tz
	KrT84XuzAbTAZNsmHGdFQuQW+GU88TOUyesfq2sSJ+LOg1lOB0jenYO7o9wc2F3lGaERy31/9i3
	6YdTvdKcJ6VArp/a1rT+wrcrfNHnhihjGGMxTQFNdRyxatqFWUQ3iQUYWgilDBiCwA7T3dmWVFW
	pGAbXrFGcipUKuzMv7zdbPIHkkhsCr/RdRp/OHe+9boSodm7CjMVLDdz1D4QCOwmGpNpfZw==
X-Received: by 2002:a05:600c:6087:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49cf81e3454mr614754605e9.4.1788872594406;
        Tue, 08 Sep 2026 06:03:14 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm255179095e9.8.2026.09.08.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:03:14 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:03:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE
 macro
Message-ID: <20260908150311.00000da6@gmail.com>
In-Reply-To: <CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
References: <20260908114047.1360-1-joshua.crofts1@gmail.com>
	<CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Sep 2026 15:41:23 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Sep 8, 2026 at 2:41=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmai=
l.com> wrote:
> >
> > The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TABLE()
> > macro. =20
>=20
> Is this a problem?
>=20

For systems using devicetree, no. For legacy systems using spi_board_info a=
nd
this stuff, yes.

If you're referring to the mark for stable then I'm fine with removing it.

--=20
Kind regards,
Joshua Crofts
