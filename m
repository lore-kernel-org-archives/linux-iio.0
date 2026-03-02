Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9A3630A3
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452213; cv=pass; b=WELcymQd3j2+eD33WaDILl6jrzd1osb5WW32a+S6oNYEEMOqxdjRc5N6d15asZQP/zPAw/lrZCwMBtS45tcUTgllN42C9cI0FTiaa0hvYX0bPCBBoW00Pr9Ionsab32oodd0c7tTdKOk15Ai3ZCgNmjqzdkt5y39cxIkU17j7+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452213; c=relaxed/simple;
	bh=5qAHqn3E4KqdIyv4rJj7K5venbc/uUWQxC4/jFfSWpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWuMs7dkYxoGl6g2Fq1LQWvFLdUYm/IiiHimlYc0LekE3LD9u752kTLy+pMeN8kHZB/u8gCpoJXZplGXft5P/BikBCbI35Iu8wL4zW8NjvM0C003jrzK9ZaC6qf8KteHSxfavRP9TwG+aI4JKlkgd4TqLl+LpbK/ximmwMPrtv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SEW7j9L6; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SEW7j9L6"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70b4a0cda5so1599768a12.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 03:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772452212; cv=none;
        d=google.com; s=arc-20240605;
        b=YFXwYlmDgXND9DvDrSX5sc/3eIK6/HnmuOpCGqgs45AG8iOLZbm2P1/Om6csKRDa0n
         XhaTv2X+nr1zZ1cj5W546qx5mwACdXgCeFWnv1o6YEkME2JN5IMLSbTIsYCz5pWxh/fy
         qRrsudiKayPAaYStUsByjXt2P6gwTPUzu96FTI1eVgKiiG1pm8bOOXFSfGslI6g/OpAU
         2/RA+Ruu+XUz/Ze2MMZrdUDNsI7GfpLOLoi0xMGIgJ1YlYNvGyux4kD/ghkDV0N4eW0z
         aIo4noWD0nNCmXIGvMahioU0Zk0xbO/QcNTfvTN7W98SpAxUw+aKIsOB5+foPcPe/Nw7
         HoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qAHqn3E4KqdIyv4rJj7K5venbc/uUWQxC4/jFfSWpw=;
        fh=VCgH4okx/42CN+vbWAx3r7cztgZaodUfa93hOR2WQIQ=;
        b=GkOfopQ4iYyf0+QqP2Xg0bgHErVhqcy8R2Psb9jieQtasetdu0pnQhdmht1HAR5SBJ
         an7KpNS5SEjuhDHrG/6U8bGpHJfWDZX4k2IjJQEu2vXmKzfutVU9tgvKmO96rI4bcXQr
         kdX/XK1s2k3Yz3S+oumn0q/V0sfIVXIAnz+eb4ffBY0d+byf73T7GZSXmqVeI9pMOJTR
         BFkhYVIY+tog/w+xfK3axzJQ+4lAsHZ6RAoF6QGaqBl2W2KjXzGh2sk3IwuhBhF9AS+/
         OC+ibhtHxifyT6MtFw2j9Vbo7B4npjypiA4AD9DFCSHjSs1WGOc68VPPBo+ZsDgDJfjR
         hGZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772452212; x=1773057012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qAHqn3E4KqdIyv4rJj7K5venbc/uUWQxC4/jFfSWpw=;
        b=SEW7j9L62DP2IAKlQEucR4jx8A4RUHE222T+bYBt+F2Dl2sbYr+gpgAnRd5B285e2v
         M+PZ+mPBGhvqmZuOL4+IkA5wFAYopyfIrUDtMFyRTLgdLQn17iLSK853QLJxsLf39AhL
         yb81PAW1vXpHHsbEOq/nwmHQJ5OO5KzN2iM2LpIH7LBohzoyjZh88SXA+m/1KmTPgPga
         A41NNKVEdFg4GZdM9hO4pZXmvRxLCb5jYg3ICP+KDXlqcBpD6WQq1nj/+d7u+cLfs2c4
         wkupT0fZAG+FW9n2MDR0urKAt4d2dSbRkEfRczbe5eI67sDbGT8WW3Lbcr/yMSgWJPSz
         CTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452212; x=1773057012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5qAHqn3E4KqdIyv4rJj7K5venbc/uUWQxC4/jFfSWpw=;
        b=aAn5+B9qn95pU43KC3gMKRQyzousUVFpSpBof4QQVKNowxpDrwzYAGnAFjyPBGIRPM
         zS0V8kv8hrCqFUVHxHtGlwgZ7ZT7dvGet6izXKW7Usxu9LzkwgzRf+poXZxsR09vSWzM
         xHGbe7umXES+DVsuo+4DnWJfTbjqgYYw+slu0eCTx3LRIuZgg+Qsq48X+mRvs2ksfDYh
         vlbyCEPYz0Vj+yEnw8ws3Z3Dazq4CY6uV4qxH3VsCjO2GwNzW20isJWWbYVHIMun6qUW
         Xdlgbb8HD+xOhvIY0wY156xIGMvjjuBjCiSpoFTzq2+X1SF2QhjvlRaK5AKu7FoZtoiH
         4pQg==
X-Forwarded-Encrypted: i=1; AJvYcCU49r84dFqlChnklXaLDlrt7QmVOiDveYVu3Wsk4AUxRRVS/Vd0WQbfw9dQfULgiuHaYyNEoDqrhIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCIctzhdgj9LsTX1S/9B2ReVS6ajdtDTtJjAJcu7eur6GsFqs
	CFRAb3cKHkdgrEdHrOh6gFZ5rUTckTSUp2LZI8WFvAQifHtl1d128NZzHY6KRa/BiJBMoC9d0of
	B0AGVP5aoJTvEFYQQ7SgJDjZaQtob50U=
X-Gm-Gg: ATEYQzwFaTS4alezD04M0dIfo8SHM1DWgSP0Rg92kVggyApkyWPi4ceQNpvOcTPGho5
	4wdUedlV+Awez4Qnto+5QHX5KAv7nCiyo9FgqLDwdV5CB6New+IxCMKSwk3MHveQd63TSWoN10S
	OBNKL0Lk3FIzS6seHVCJgzriHH91EQ5Embrq6yJLFx47TfOZ9Am12z8l9Z5EBhT0Wt4J3AgSutX
	xTptsYSxbkXQK5X9k31UauFn+TY9Uutc+NcHkES9zOTrZhFE0XQg/TXzgEwPwlqGdJW7y8Cmc18
	Yzu4Y7Q38GL338A++ZQtdV8GKY24CXqXv4yu4gXY
X-Received: by 2002:a17:902:a508:b0:2ad:da28:8c7a with SMTP id
 d9443c01a7336-2ae2b6500c4mr72503075ad.8.1772452212244; Mon, 02 Mar 2026
 03:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228065840.702651-1-nick@khadas.com> <20260228065840.702651-3-nick@khadas.com>
In-Reply-To: <20260228065840.702651-3-nick@khadas.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 2 Mar 2026 12:50:01 +0100
X-Gm-Features: AaiRm533eCqYaaq7O8tndrUfX53W9xWv3UJ4VGBrO0ObYcu87bP8ebrDMdBbpZs
Message-ID: <CAFBinCATMbC_Q85QHv_=v1cdiNjD-+X1eR=eZB_0Yvj7DC4LoA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] iio: adc: meson-saradc: add support for Meson S4
To: Nick Xie <nick@khadas.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieqinick@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 7:59=E2=80=AFAM Nick Xie <nick@khadas.com> wrote:
>
> Add support for the SARADC found on the Amlogic Meson S4 SoC.
> According to the documentation and current testing, it is fully
> compatible with the G12A parameter set, so we reuse
> `meson_sar_adc_g12a_data` for this new compatible string.
>
> Signed-off-by: Nick Xie <nick@khadas.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
