Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD603DA5B7
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522429; cv=pass; b=otmIi+Rwfv72C9KrqHZup2dGzZ2THBIt9j1Pl9xJ4uceHt/bYMwEmozd+Qqb2zle4rf11JhynjRMDkZqte26hkQ1uzAsZ+96NrN7zKaVHbXHYC46qwgih9wBmvUHzXaD3IwoqI7pc6breh22psBcNzt57CENKjdU0Rzf+e4dL5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522429; c=relaxed/simple;
	bh=6mqHKqlBvXA+4paxQcgIh7H4kij3XKYmw9YFuF/cKw8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOfAP0yZO+SJRikRqrJ6/5iIIEZ3o+jWqE6mbLo4ZaKQzXBZ11aH8y15Qvfaj8tJwSDJWQHT+KMuvzGjU5Owgo9YIEcv1+6wlJnkC2ELoWh0RSZgn6Ri2QjdXOdzSqMQhZhWQDi/MjRoOhIpN3tJBIxYfh/BQQBFQ5jjoy6wAHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fz46ShLH; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fz46ShLH"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6930f7e83b1so5404863a12.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 04:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781522424; cv=none;
        d=google.com; s=arc-20240605;
        b=ExQPSGvEswHCAsZ268fiOmV7msmJ2jN7gabxw7YwX0+N11fgI9J1qd7mH4/twTp9GM
         UJsP6b6pNJ3a85iGIZFS/D+RH7/4xop5bjhrsRefvo1idDK3SoKYp/wBMaCI3hMIX0M6
         pMAqmCeEtlozgqqkm9mKF/VR8mLenZlZGtGcX2AZpt6okUm8Ok6i2r5+B5XTrjEUxXm/
         GQhanjJ/C9LqQZVN8U2C+o4hEusJjhmNS8gxlTL9m/vsHOQNLu1HId2m9SXaXhHJdKeE
         dm4rtRYfPSCVGMWXZZ06mS/tGB6Db+41tvK1G4kP3/1nPWibZOiEC7Op6M0dPXoOIK4j
         PgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:dkim-signature;
        bh=6mqHKqlBvXA+4paxQcgIh7H4kij3XKYmw9YFuF/cKw8=;
        fh=asBLdDbbDpiZcO1QngnUpyrgYyGJlnGmhqdsL2Bu4hI=;
        b=PGQEg66LWwFTPKfTdM0M3bxQvOSxjl1W0XRDd8zMojgy4f8FsLnJdCHZIefCRQEs6l
         Cl6eY7EI8ceYlihMnrFv4ywWCsG4jqq5IpQGR43FPhnI357bdo/DlTjeylnGJcR+BfWW
         khEc4Qcb8WdgmbCfRrfHz4IKxWABg66MtX6Tqug4yRIAzn1D9zMFmTpbFj4uxc6ymuLT
         hB+j+HTMNE6lPIBPx6pS9AJ/YGAwynBCMQARDlfTAySYyvA3rwaBdzfvKmyTWYqUCSFL
         LtESDCApgGMjUWxhiur/VEuu5H5kf4WsJaLsYJNTQLWNxsGddDnDWck4U9akBhMQLSy6
         OOOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781522424; x=1782127224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6mqHKqlBvXA+4paxQcgIh7H4kij3XKYmw9YFuF/cKw8=;
        b=fz46ShLHelBOIcOXMaxrq2z8mNr4Z1uvUjkO0BHd4XhH9EH34r4KBRQVNd4PerjLSU
         s8C03reZzS9zJ7F9DyecRjfBltY8XVP1WFA93piIw2jdqyMAI9oPbAo8dPVtfGunsKcJ
         oGMiIjG1rfY2hikqaRBhmOcY2O/+aH4MNilzyINR0z2wdsWZxqsHPfFr2uKGat+BAght
         zEzAomYpmGCjujlC2XeLN9veAJcmpojzHwoZ/UxWJU4jU69p++/9rqic4AriJJ8Og2P0
         r4ud+jUrgWkd7gd4/AtZDzyRnLZyIdCS3CJX/d1Ib/0O2Aek3xbum6s6gbeDKCNnlt/O
         3gSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781522424; x=1782127224;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6mqHKqlBvXA+4paxQcgIh7H4kij3XKYmw9YFuF/cKw8=;
        b=hqqbZ9dMX6UpzYsB1ALyntYJIOhm+FPg0fdr1N8cW9jdfWU2BXBo3dwdbMAw5pl5nf
         UtlfK8TION5rxRdMUQj+nnuDJiOJhj0TbldiW5SXteRVQGkjLVMO/QrB+98tmpQeUpwD
         RkAmLfhHHHZEGJha5JyKSId4QU/B73a0Fg7gAHZQSdpqPaQiGI7ZTg3x3M4Qh+CeTv5q
         J1207pPvkBGThNNMgBwEMV7nvpF2X9Mxu+y9FiMJwMSV32/qAHPzbf3cYM0oaaHHon6W
         he9KU+otEtoSzILdLwK+QEEanSVaQJchiFtrb2JXFGuWUFs9vy8LUYOOvilztsh9B8cz
         FSGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fV4laI96YDoZgZBfBtNpy0QVFfxW9UpxvE2y+pW3WBNC0uXNqnxlBWpAiq40gZ4s5FdltEvBSzlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZseRHffpl/3LfxZTlau1PcsENtsMeVA2KYwTJP01jChy9wlP
	Bk8IJUSDo/W4u+aWQDiujvuiSaL6XGPgDUA3WVULVOxUMyJPyU1O39ETDD6RdupQQUlv0CrDjM8
	tkOZ/XMTBEDciSGKzOii9LmV3Ltwy0FFNa4qBS/YDvQ==
X-Gm-Gg: Acq92OEKmsCxHoSVkAxat/V12WpCfvEM4F4r1nostzj4V8sOgu7ClfyLER8TGKkT75F
	juk3MZRlRMcLORnuONbH1yIqN27mNCE+gwwTQS5tf/Aq2JYaxbFqF5v/LEpSJFV6+SHl/iJRKLk
	mlOiT0lzALITvcUdAX3xNwahqdpxSgcvaLL0cYmh2lLO4Qg6hF40BQ7y6RjirErXMvgNOBOgVbi
	928ieKwuEx8zpVuCMQMAQ3SuTDI2EcpZ3KayMX2u4szYs3/3vvdII7C1P/1xa1W4bK/aWVSy4rY
	dV+727/em6nKhtCatO6PfE69JM/jcDSmKZ4m
X-Received: by 2002:a17:907:7342:b0:bf2:6d61:3268 with SMTP id
 a640c23a62f3a-bfe2a713a05mr372243766b.23.1781522424173; Mon, 15 Jun 2026
 04:20:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 20:20:21 +0900
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 20:20:21 +0900
From: Angelo Dureghello <adureghello@baylibre.com>
Mail-Followup-To: Jonathan Cameron <jic23@kernel.org>, 
	Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>
References: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
 <20260610-wip-stmark2-dac-v5-9-b76b83366d5c@baylibre.com> <20260611114800.009d9797@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260611114800.009d9797@jic23-huawei>
Date: Mon, 15 Jun 2026 20:20:21 +0900
X-Gm-Features: AVVi8CcVAgC1MKZdgPIabfG_bEsJqD-RTAVk9pERfc6y7h_8h9norD6F9V9jiEU
Message-ID: <CALSJ-wC9Rsq6WJ_=X87R74jPrg2Y+=L8m0wRRp=1zvN5vSOw6A@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] iio: dac: add mcf54415 DAC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

On Thu, Jun 11, 2026 at 11:48:00AM +0100, Jonathan Cameron wrote:
> On Wed, 10 Jun 2026 22:35:14 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >
> > Add basic version of mcf54415 DAC driver. DAC is embedded in the SoC and
> > DAC configuration registers are mapped in the internal IO address space.
> >
> > The DAC accepts a 12-bit digital signal and creates a monotonic 12-bit
> > analog output varying from DAC_VREFL to DAC_VREFH. The DAC module
> > consists of a conversion unit, an output amplifier, and the associated
> > digital control blocks. Default register values for DAC_VREFL and DAC_VREFH
> > are respectively 0 and 0xfff, left untouched in this initial version.
> >
> > This initial version of the driver is minimalistic, "output raw" only, to
> > be extended in the future. DMA and external sync are disabled, default mode
> > is high speed, default format is right-justified 12-bit on 16-bit word.
> >
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> I'm lazy so didn't check earlier versions but assume the two bits
> of feedback from Sashiko are false positives:
> https://sashiko.dev/#/patchset/20260610-wip-stmark2-dac-v5-0-b76b83366d5c%40baylibre.com
>
> The one about clock underflow if resume fails, and then devm cleanup happens later
> is a bit nasty.
>
> I did a bit of digging and maybe it is better to just leave the clock on?
> The status dev.power.is_suspended is set to false whether or not resume succeeded
> and I believe a following suspend will not take into account that resume failed.
>
> I'm not set up to poke the combinations but it might be worth trying that.
> +CC common clk people who may immediately know what the right answer is.
>

was about testing this, there are no bus faults on read/write of registers
with clock disabled, nor warnings in dmesg on double disable.

Anyway, i see now from arch Kconfig that is not possible to have CONFIG_PM
for this specifig CPU (with MMU, PM is force-disabled), so would remove pm_ops.
Ok ?

Will fix all other things you pointyed out in v6.

> Otherwise just a few minor style comments inline.
>
> Thanks,
>
> Jonathan
>

thanks,
regards,
angelo
