Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB1481656
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311229; cv=none; b=mcEVQiJH9eTYY3BTrt7OcotGEV2v1OIxuAzdB5pOqBkLBD5BiyFKS8tHuG9nnLR7Xj8iI/onB2BeaVc2p9kqUZf88jCA2iurmxUsBGpVmqq4t/Po16lBxdoO7QVeC7r49PQU6A528BNxn+jGQwa3c1ZA5kgU8q04BBQP+ypuei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311229; c=relaxed/simple;
	bh=zl+lcKVUwTw2hdXwH5M71fIohjQYAkHgT2vGYk8sVcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzd+bsR4kHGrmJSWImh5yihNSrLHNoRw3X+75uwGT6H7E/qDEj/sp7eJWxAPosCnzzgcUj17+2ZPl4PQCEP0z1MmZj0tabViMnyLaZmQyyviAT8eeA92NPP6Z8ZzvEhIkcf3KHGkIcZoDAZsiQAmAyKUdrh73lkJa+YTPHll4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQWQ6tUB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQWQ6tUB"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso1721302a12.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787311225; x=1787916025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/G4kA1oa42FAHTTSOZ1rtStYiGFk+bZCYLupm5QyS4=;
        b=kQWQ6tUBcIJF+jcb8qBZ4bN8IhgFxCytsHiQhSFZ6JQl9diuPrQMs0AkPOqXf1+Bre
         f0lCpasDgnu9OJHvG3a7u1lhbAXTMUahPAkbfKCJrL6mbvrjligoFL0fLY9E5usjvPgN
         XoLFfecTEVAhDjYf7LciWsJ4ViKEjRkYbQEvFESoU2Vv+pCARd2MW3xM1iDUUhtqwf43
         eJK2J/CfdlpaAFuhAJVRk7g9bpDa5B2J7UmSZ30hqTerMMXmPmj9e1+dZ5SMmkGsgCrm
         /dKOSVtbvMAGwsEDNSsnqrHjHGTMLJhy5+0llLqgHMeuajHJ/msruKh8P9JX2ITXlXIf
         4bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787311225; x=1787916025;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/G4kA1oa42FAHTTSOZ1rtStYiGFk+bZCYLupm5QyS4=;
        b=XkWY81XSGCOrUpsgDwGr1Wg920Ftj3eEE/RIjwiX/bLlpBd5ZvS3aSle1LOfebgqjH
         dMLzbzGuu6ZlMhz+JAV7sjSzH2jHgh8zJDswakYsQDrELpCciStCnxyQUlew7C+bvN74
         QEtAptReQJIuCPNl30axiqyMX78RW3n+h3New+2cihM5fiLooc07Qg87mqnMelh1Rw0H
         vWP1xyiT88qgy5BndSeqPzqpILzfvf1gxkWge8clcvHMmPZl+MWQJCTdlT27LGV8GiDW
         cUMFpvgKCOoTpT1ZWr8JetpoZT/cVYg+b5lqxhj1zRP7i0P43gk8+9+BOLvcjzjmRKjj
         f8DQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSO6yzwUMsP6iwxR0aXZ+sosCJwGFfHUMJKZKuQsAmS37pxXRwDs8WZD2Arc92piN7obN2V94Q/lc=@vger.kernel.org
X-Gm-Message-State: AFuF++mb9lh2SN6shi0ADSLao/O5RGXmLsOUpchsAOxkAIRc+MbL5EAq
	FXhXDkoUFDvcDvyLeHbXeqBADsFhx3Cb/DR+M395GpqJWSqvL+/6zzhRWbU9FJv8hqI=
X-Gm-Gg: AR+sD12vXgeUjXtFiKOFXGfW+QuNst8Wm0Qvj2vVgm0LNSpvLiBfd2U+fPtahY9SGok
	3ALSef0dwsqYYvT6fc6Zi2FRC01IujheKjbEkXtCa5RQqf74oXooTi8ClYodAIZYk8vHTTuhkW1
	gRbj+n1xyQzh44+4hnCJm3LlzM866s7xJHPuV0+Ozdu0eL0OAV1zpJFb/SHnX+skJz/2r8rIZKe
	2Ct12DaYganuAvF+oX6J2hDCs85zLImwLF9yvY8lrpX1VhmjRmz44zRigQ9txS/4xOUVZ2st1lG
	GIB7oE5r6dN0KoLph8lTk5G22ptFu8tgYDl5uvrnYk9B4sNK+5AeZ/N9MXbTiZdfQAAb6O3cet7
	ktg6fZ78eNl1FkILf5KF5qky+rce+5rKLZK8m+T4oEQ9PNCdryoHZVqYwQPP/RCw4EoX54ino96
	fheSBPdgR4xEP2LtcvftAbCfSvVvLF3uBCi562a+xdwQitdWelhcnS+auFg/JUzhc/mEeUT2kf0
	2mB9PDsmujS9rG74o//ajb35/B5U9lIiJpSb7EdU/JtZCOzHYIm7ht12h8UIDnoLm0rU5J8tA7Q
	/UuD2x6IVX6fXogg4ukPe7PvEbZAC9hCTLEvjZ1amhEIAsm6SfpZJf6HXbOEvrfhuHNrYwI/CYk
	PNHraCVJtlpZaFqXH5aJOIQ6oZotKvuspihInfq9CSKorJA00JcSf6yMljJhEXk4qdR5jvaI3iU
	fKXpTk6w==
X-Received: by 2002:a05:6402:380f:b0:6a3:9e00:8ed2 with SMTP id 4fb4d7f45d1cf-6a42f27795amr6505598a12.16.1787311225089;
        Fri, 21 Aug 2026 04:20:25 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff1780c9sm5978930a12.28.2026.08.21.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:20:24 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:20:21 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 skhan@linuxfoundation.org, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] iio: dac: ad5504: separate ACPI and DT paths
Message-ID: <20260821132021.00000d2c@gmail.com>
In-Reply-To: <20260821102452.37407-4-0rayn.dev@gmail.com>
References: <20260821102452.37407-1-0rayn.dev@gmail.com>
	<20260821102452.37407-4-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 06:24:45 -0400
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:
> @@ -285,16 +292,20 @@ static int ad5504_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> -	if (ret < 0 && ret != -ENODEV)
> -		return ret;
> -	if (ret == -ENODEV) {
> -		if (pdata->vref_mv)
> -			st->vref_mv = pdata->vref_mv;
> -		else
> -			dev_warn(dev, "reference voltage unspecified\n");
> +	if (is_acpi_device_node(dev_fwnode(dev))) {
> +		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
>  	} else {
> -		st->vref_mv = ret / 1000;
> +		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> +		if (ret < 0 && ret != -ENODEV)
> +			return ret;
> +		if (ret == -ENODEV) {
> +			if (pdata->vref_mv)
> +				st->vref_mv = pdata->vref_mv;
> +			else
> +				dev_warn(dev, "reference voltage unspecified\n");
> +		} else {
> +			st->vref_mv = ret / 1000;

ret / (MICRO / MILLI)

-- 
Kind regards,
Joshua Crofts
