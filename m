Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044CD3E4C62
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700010; cv=pass; b=OAkYzTbmMlzN5d5gicdIZBL/2VOuv/YlA/ElJUFsHUChUuIerVa7mpRtFYVNiwfslXHrq5toanWnWrvkrjLxUSpDlIpwwokQN1fpp3yZPSRjmVB6361PtztgxcJ+sQCFRfd81fw9zvfrJyUKQxxWzzYwN6whMCSguEbjEPq51II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700010; c=relaxed/simple;
	bh=/UHBo0fnduWPxkyJYyD+8XBQHolCm9R+HAAl9QOOw0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrNLQ2Mcr4AHkw+jvzf/i5fXqEi31NhVI/xu/f101ve58IlDrk72RT/v+uzxETGDPaUmIUO8pWNeg10S78QUPPDDBT4QGZEZ6hQXAc8IloccQCeitaoRz0M0pHUb/HT8D9+DEhZbEB65Z69+ROxc2HKzxgjTVteFZWh4bLaG4bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzWeZ0gK; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzWeZ0gK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43eb05b1875so4979589f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 02:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779700007; cv=none;
        d=google.com; s=arc-20240605;
        b=cZ2U1Y3/1Z1KZsSMuJEL4UOd75JLEo988FSqyDpRzQbtyT0Yn13I5AaiZVXI4jGY5C
         lI4ZsfQaC/eGRL4L846Eg84FZhz/m7u5klrgMJ7icEUZ+cOGBhrHJKTsY1Dv0u7JHj2C
         lWTmoDCtwB1JVsX2HDvyS/HNCAm/7khvUR7dpJdpPVFZwxfc2mACIzcQcduaXK42muMW
         vAoq1SRPVI35LIRfofFk5cjiohOPmQMG/6b9wbH3jIaEgPd9qrsfkjxvTmTSl+qwuxG9
         JpWw62WWQyozGiaDpztM9oSg/cZujvvK7n+JjSsIiOyGD7jgiotuRRJPZ2NseS2vBpNJ
         wabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P+4VKkbBg6EegDZVB1EPwiHK8rzkeIMJ3wnfY2EKAH4=;
        fh=5Ryo44QX4XTfOALJ5B1KCdvRXIEvyHA1TRUHZP18rdo=;
        b=B0S/BCFbktpr19lPRzsEPHOmd3n/hJrlWY2y4E31ef8RU4j3Rs2Jp2Y8XZCjSFd+7o
         gZuOJ+sS1R+GCS9pCGKvHue3P6oqtO/1aAU3NAtfTpWyH11yqBfhJ+5nmoSUAQG+TfW5
         MzAkNuq3c8kgwJ11xjVvFPwIgs+Onx9w7QJim1cQtcWfmrmMKzqPV5Nm1Z5HFRj5BdeR
         DSiBn6SKynjAXWvJKRlT3xBZrKYVI5X1K02c64KzO9lvDwEMUk0QVTfZAS+daaEo6Ffg
         upcTL17bWJDE+q4stj8il08lOBZSxVD2fABZeI6huFxY5cgzA9EcTcFe3KdtolsCV4Jr
         ge8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779700007; x=1780304807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P+4VKkbBg6EegDZVB1EPwiHK8rzkeIMJ3wnfY2EKAH4=;
        b=WzWeZ0gK770llsTEtsoBm0vs6eLblIfojcsFwZzghn8gh6IGacCka1b+ukakLz8iIq
         8b8XLZaMT7d++c5VyCJCJOFvO1dHLNwfiMw+cwdpwZHsoSfHB7iyvrz1Wt8CxKYQaWog
         TNNwh5LZgePD2abL+t03pC1GqU48tm32pAUdAijFIlQlwQlnxUu0c/jzMhI2i5FOlTw/
         sxvAhcCmv14RlAg+/v3hRhCJh0ZLihb2G9NZG8UG5y3cok1ta7Kj5+OyjxC20ARyLyHH
         2QRCpKEoMcVtaxJmrxmHYt3NPzZozdL5xtu1BMvaxtfIBEBB8+5byJ5NnjNi+AM4z0lV
         oLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700007; x=1780304807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+4VKkbBg6EegDZVB1EPwiHK8rzkeIMJ3wnfY2EKAH4=;
        b=U2ZmYv7b3TLwC7l032i7zb7VNna+XZtaCGHu5QoyvIl3jEyyjF/ouSxO/JTi07l/j6
         Bq0M7RmOXOLHrnT3ztEhb3LIEuHTQXQwDnAMSAhbPLZ0CGyDzEnGnH+tgOWpwOLXMShk
         p84ZYb/rlc0updDxayNPplcji1SM65LRCSkYixBSn4nlRVc9uqKLBryNOY13ESY17Lao
         nb1Wat31f+aubZkebMt5x5MYqwhweR6gLccGb+MyzOKD+23M1Tmmuzns+juZn9tSfyEV
         8cIXI/pxywZBGe8iHBiGHnL28JspQSRrdh0aywIHLJswEkwxlXqiklg9dg+c0CvtaVBs
         pJVw==
X-Forwarded-Encrypted: i=1; AFNElJ8tNAEDx0i4x6sfMOkZvXWdt93Hm8gEgYxn6CZEGIyCC9H5ulIpGN+nW6jOcIpDp/aEIzbNF5uTEYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBLMpR10J6A8VSlgGYdK+ASWUqqNNfjE2UXHovrM3OrNDO4iK
	RQQ0XllXsYu7wyPRHX96rQGv94QMYN3L0o1JHBy2NyxaFjb9gcf4cQbbiK93M4YZr5vPOBkzrl1
	CYoDAP+hLHH2E0E+Gpxu6NhpSokSwwIw=
X-Gm-Gg: Acq92OFFzMu9/wrXYyXKWxefzigAjEXcOIdclOel3qrg8Zdy30DwWnloQucqYVkZLiU
	Z8JBSSyKCCYu8Xr8S4dPsQcTo1ZCTorO8/gEtxWDjLRfLsvCGmRw+FSE0nlXU55rtIdtJlHmNHm
	nl+aMsUH4fEosG+BIyLtkNbUeLZO35QOyhoCFO+kVAUHqWfSN9bDuU8gAcn2wxY2uH+AwHPpz9u
	RhiWG1GxvlCAtB1Bl+9pEt1GceJwrZdde+TzpwAhAx8KXDKx802KwHIR2vn200x1jaKiJUDADdT
	Fh/qznbCR2fLU9rUYdR8W9MOyT1+nKEgA16KkJbKQobjwxvVSxI8VeseHLYffDBB8sBb3C+gC9a
	19jO7FIu27q6kkrjcLm+LolwUsofTPm6sDIW9dRJMqMDRlKM4broVLNOTqixojBw6/Qi/uyqFGG
	iSeX8AvA==
X-Received: by 2002:a05:6000:178c:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-45eb38b86demr23662179f8f.31.1779700007134; Mon, 25 May 2026
 02:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com> <20260525-opt3001-cleanup-v4-1-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-1-65b36a174f78@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 25 May 2026 11:06:35 +0200
X-Gm-Features: AVHnY4IJARKSvJ3at4T4v1IfKxiKa58jsQc28Z-kzUlfgj_0nNMlLix841BQunk
Message-ID: <CALoEA-wSRKbX5k6k6dTGCd3=ugbO=XjbSkpCDiW+xWEaSHfdKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iio: light: opt3001: move device registration to
 end of probe()
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 May 2026 at 10:20, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Move IIO device registration to the end of the probe() function to
> follow standard driver teardown/setup ordering and improve driver
> logic. Additionally, switch devm_iio_device_register() to its
> unmanaged counterpart as current driver implementation mixes managed
> and unmanaged resources, causing potential resource leaks.
>
> Also, add iio_device_unregister() to remove() function to correctly
> handle teardown.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Unrelated to this patch, Sashiko did find an issue where get_processed()
is returning an error code directly instead of jumping to the err label.

https://sashiko.dev/#/message/20260525-opt3001-cleanup-v4-1-65b36a174f78%40gmail.com

-- 
Kind regards

CJD
