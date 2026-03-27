Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CD22F01
	for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575128; cv=pass; b=LYCCOwt15yP/3UvRYoYgwmvu0Ut8JUzGd8F+QaUmORb05xY63sZveuOiOIUxOXY6M/XDfntJeui9Ont/pLRUSCUSLtDaF55bgWsqL4SAodvJfp6r7rouOo5XwHLV0iRxT0nfhFVmwHOZxUHewi+jER7CL/+LwNCZNVGE/dHyrks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575128; c=relaxed/simple;
	bh=mVoLuPJ1O6BigcIiOJ20w52lDDWVLFFV/buiA+WdMgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFvtxvLq1WsbchYduQhzHecEloZEJYArG7ePkL46vLtlLqP+ov9gxcKY0qHE/aNed2hsYTfYR2zLeUhdM4JSdmqgnc+mPFHPItbBGnnlADCqeRA35iqq7YqpNa1IVI3Bx1ixkm4/+g3p67QqqzKgdF36hvF3pY3pDQqzv9biKb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxLEOebG; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxLEOebG"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56ce54c8c82so623615e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 18:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774575126; cv=none;
        d=google.com; s=arc-20240605;
        b=gQ3oeuQ1/6kgBggGxgZVNMxjdTnfWUmBVomTv+8AxDn/QtqRVs/bnym4oOyiJr4cWa
         fcZz9y2njTxtbMJlObzlBXM74KJJ1S3bk2VQNxwFQWdmXzGq+vmpbQI+afBbIPDMee4Q
         D4oDnd+5magjSKItRIAxj36O/a3UXbYtfiGgiAVRzu47/KV//Bye8TqrQ0rploHWT28x
         q0RbRL7ZntzhEigomO/FUtF5vhkBniWRbg8mef5lrR02omKqvuIaixZDA8xacXvTVzDp
         cmaI8NVSPGurrI8CcwNS0mZfgn9BXMt8/EEP27eCuSIl5ZnmwoF9w7Yz7mRE2P1MiRTR
         Koow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4ISWJvawyYrf0eol2kK5qa/w2tRsNn2IJRT3vP70nUc=;
        fh=Hb9zbXmIA5wsmrdruhOIRcLphgARXhE5KBO5RMQVxnU=;
        b=LWBCdo8VpuV9oUDHOfEhyEi+6AMOvcUmBgOu2fGuUvIf+Mysy8LddNyzqoIPj/Q62t
         P/rIt6eTAcsToX7KzDKVnIVho6VPfaml0Ck08MIH1VdMvFLuRwFefG7n8R/Qp4kVhXD4
         wtvuRTvkje2A3s0dnk6S5Fjvrwuf9IbTaw3hooKtcuxV94aguOBSlNUFdqDtrGuPlXUP
         QCGpaCx2ouVznQW8uwbfl3Ve6TXoy+eCQnmqYGoAsnkZPrxrmro4umRM4tPMEUFwSoId
         OZMI18WBAomX6jZG8UqK60loyGsWzM2OPS+lLm85L9hOLiWMjQfe/gF831UZcbEPM/lZ
         /fhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774575126; x=1775179926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ISWJvawyYrf0eol2kK5qa/w2tRsNn2IJRT3vP70nUc=;
        b=JxLEOebGO0yXozaju2sXt6r5bBa4sBquigjsCLV6vhcjhiS4HOArS65YDN99Bop1JN
         +djy5IewStGyG9V/6+FZz6qdG9ERWFkunWSTBcIQw+0MVWlaXM8s8zPYDTO4PH0yHTIL
         nagx6XWA3tNAED1RLdgq2FIOH0iAcByiSFpXDUqX3QW/oWFzV7xGJ5nKrywNeUcu8HWD
         7cBYZrj+0kLedl5q96goXLO3stRZhO5eQ+r+37kOOhYQCLRpOTBoz8Gf3xO7W4BgjJAL
         EKliVRmVbYF+tMBquj/O5JIMDAFsN3DOLzon49BeNTTodSAc+799r0FxI9JeDznj7We1
         d1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774575126; x=1775179926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ISWJvawyYrf0eol2kK5qa/w2tRsNn2IJRT3vP70nUc=;
        b=GXdW13azJ73aJea5rQkI9r/qnj1cmgYClcM2NfuIl/ciu4fqmX1naa37WVpfVpzIVC
         P58TNeHI0Mm9MfCU00XVLEWNdeU91ZOzH+hFl1ZP717jZUHgxBEUKqTP3zyC4/RAe1Gt
         WTU7vq8976fipq+04Vw93ovjT61Fuob0KncpN3FMPJ5la1HazC9PdiZaxLBxAIevOqhS
         Yetrv8VfweC+jI+j7BOUKJzX0/ZJdqtDdka80G9BjcpE27X5HfpbqpofRI5l0pmV9KqB
         9EOucnjfyDDf2wQQD1L9t86aL39H0O/sW0EsxrA4rCzQvsllEi+8rJn5OAOlqVsI3g4V
         7+xA==
X-Forwarded-Encrypted: i=1; AJvYcCXH9NyI0ntBXJd4cJ/9IBqhCv99Mm9pAeXJmaAahMQ47S5J6gPDXvrpd+LFQ3sGt1MEhy67wWHDSH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbZ81IZb+KUSGHxi4i8N9ir2WWEU0R9bz+/CAFeOr7dt3qWuI
	8Uj67kwDk8xlflx/I/jK9noClr4jPjiz4kApxyCbnKcJuC5loTIeDmvq0JaULAQYJVO2qcZd5/V
	S5erCQLzlEGlSuCrjZ9sp9mDQkQNGyZg=
X-Gm-Gg: ATEYQzzEnancCtVVQn+oUXPK9T8YVX+n3qxdSCVQV/7fXFd/YrsEDPSUjk29MgH6uIo
	gvSLriIBJplujtnun4zbpBtEoMPBJJ2svuS8PbeGPPNndeS65En3TnZbZPzB/tBAWGu/BnjOfev
	ij+M4DsRjxUTxeQSeBkf8jCZeeRPmBvbJ/GjMMbySWxZPuLvPK1XrnENc2PEm6yP14gwTaxobei
	3dCn9B7XUlaTU0RDc8yudhHx19NLiTnTeD8YUII28pz9FKhGWxN70I5UHqmaEXQI84nOX3a10e6
	IbPqykXH
X-Received: by 2002:a05:6122:65aa:b0:56b:a6b4:5902 with SMTP id
 71dfb90a1353d-56d4a6652f0mr245265e0c.16.1774575126237; Thu, 26 Mar 2026
 18:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-add_ltc2305_driver-v5-0-e0d29daa54f9@gmail.com> <20260325195035.26214c91@jic23-huawei>
In-Reply-To: <20260325195035.26214c91@jic23-huawei>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 27 Mar 2026 09:32:12 +0800
X-Gm-Features: AQROBzAMpP8EO7zamzL4N_PxD-CdDvwjunjhym0UU5cYXupjmr5rhQVUyJR94y8
Message-ID: <CAF7HswPMTQDmtX--5CNAS-GSyToXftkb4soP-hOzP11Hg2pj+w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] iio: adc: ltc2309: add support driver for ltc2305
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:50=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 25 Mar 2026 10:24:19 +0800
> Kyle Hsieh <kylehsieh1995@gmail.com> wrote:
>
> > The series add support for ltc2305 controller from
> > Linear Technology Corporation(lltc).
> > This is low noise, low power, 2 channels 12-bit successive
> > approximation ADCs.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> Applied to the togreg branch of iio.git.
>
> To hussle things along a touch I skipped the normal pushing
> it out as testing first (what could possibly go wrong ;)
>
> Jonathan
Hi Jonathan,

I'm glad to see this series moving forward.
Thanks for your help!

Best regards,
Kyle
>
> > ---
> > Changes in v5:
> > - Split the patch series to refactor LTC2309 channel enums first.
> > - Explicitly assign hex values to channel enums based on datasheet.
> > - Add support for LTC2305 on top of the refactored driver.
> > - Link to v4: https://lore.kernel.org/r/20260311-add_ltc2305_driver-v4-=
0-bc350d347f33@gmail.com
> >
> > Changes in v4:
> > - Fix build warning in ltc2309_probe(): initialize 'chip_info'.
> > - Link to v3: https://lore.kernel.org/r/20260126-add_ltc2305_driver-v3-=
0-951349a87f97@gmail.com
> >
> > Changes in v3:
> > - Modify ltc2305 channel mask to compatible ltc2309.
> > - Link to v2: https://lore.kernel.org/r/20251224-add_ltc2305_driver-v2-=
0-061f78cf45a3@gmail.com
> >
> > Changes in v2:
> > - Reordered chip descriptions and code from low to high order.
> > - Renamed chip info structure to use ltc2309 driver prefix.
> > - Switched to i2c_get_match_data().
> > - Removed unused variables.
> > - Added chip info to i2c_device_id table.
> > - Link to v1: https://lore.kernel.org/r/20251223-add_ltc2305_driver-v1-=
0-dfa0827fd620@gmail.com
> >
> > ---
> > Kyle Hsieh (3):
> >       dt-bindings: adc: ltc2497: add support for ltc2305
> >       iio: adc: ltc2309: explicitly assign hex values to channel enums
> >       iio: adc: ltc2309: add support for ltc2305
> >
> >  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  7 ++
> >  drivers/iio/adc/ltc2309.c                          | 81 ++++++++++++++=
++------
> >  2 files changed, 67 insertions(+), 21 deletions(-)
> > ---
> > base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> > change-id: 20251223-add_ltc2305_driver-728fa9161bc7
> >
> > Best regards,
>
