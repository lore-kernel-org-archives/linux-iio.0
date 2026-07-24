Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2613D503
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852525; cv=pass; b=rZIhFrVpr8invcOxNy4Ef1G4SECAsWJckB24wNfEaVJ9p6fbk3imqPFzbVyQ49wvRGNd3KulAARDJJmEgMMR3r1ZYcEoGhv68wgdqs4zumB3U0HkbdDympy3JYAVnYcPVUMaLT2E6RVAlsmDcWG2/Qv5XdQouH5CBuSyRj87NqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852525; c=relaxed/simple;
	bh=CvYiPvUHs25JATfiRWoh2MDCkKkqEc7EU42mJlzPsTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlXp7HkjVqFA1DIdsOB8O3Xyx4DDr5qdO9xHXd8esXCUcPNnFvax0Bgwsd0PpvRlYduN64Nlb0X1fTFBAoYqGJHC5xEC2sjW91xSROavj7kt+2LT8zOW0K4VLAxcnPTmrmD+JvHFBAT24+Fzsy6GYdsKnUp2aK7RAqhgE50XcX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APeScHbs; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APeScHbs"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aec201b582so1241642e87.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 17:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784852522; cv=none;
        d=google.com; s=arc-20260327;
        b=R2/sBakBCdWG9oG9rw7uAByRjWBF98TQIfbc5vo/8CrKm1E2zdenDj7knC87riqA+U
         58E1TsF0yH7hYmNfdopHEH26hai5K0uqDeqSrcV1zPGmLA9NMJovsxOgLnO7JfDpFPxy
         hYHGiQ2436xrs4P+43agKviDsbJ49AEvfLVlTWBk2qOVGOGX8uPVhejntVH36Q8CEd9y
         yMad0s6fvddeUIPG4JTe+As2duj9lMAEmDJqUilAmiRQxFoc59ack4ncFsafxeTu+hXI
         fmLAt4N3TXENsJaw1teQg7Q9ufzxhYzWWeAZsNm0LrWFy2yjpGWmm4CT3noudrskPde6
         DFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0prRSNduz+Ji/XS8wepAJVI1GnsS0uEtqzgw4W1wWvM=;
        fh=MsF+l15KGj8/fhwdZ/tZ5PVsAsdNmfxyXvXHzd9oUhM=;
        b=mHfBpKv1BYU7eqPVYdL0JADsX5i1ZKIwVEeto7ksqLq7w0vvtkqFw0IwWsElNW9D6a
         HxyBilvJ+YJyQ4NS8AFbW5owjJTbw1J3d92Y0GzDr1opT3K5J00aCfReOX2MbbkW3rhx
         8YD4RIhAlJ7Wcq8oNSViJULC9rYaAlMBSjlGX4YL1tSHoYQE9amcEoIQxwGQ+R0yOyLC
         WtwHUGHLGNLdHsBCn96CMO63q+sVXA3AmbHUfBG0l70Dn8T6rg7XyKnJyjP/n4tlk3Go
         znqwLjMUS8p74/TrzCVIPzLi0oEj+Ye9BYczTtZljXBLfN46QvWq9JZcY1xtobSo/VfG
         VNYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784852522; x=1785457322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0prRSNduz+Ji/XS8wepAJVI1GnsS0uEtqzgw4W1wWvM=;
        b=APeScHbsEKQOFimEAHrZgM5bv63M44UTq/0HttSxA/+b8AgC76NzEplVT4Wz3q22Nh
         XhGSBdgakSKTck5aOsoFU6GZ/zR7zj7CPo3Erpnc6cqq9UZk+m9N9Hf3xcFC3fuPidEm
         pUAX4dlQCa37tN+KlB1Ti+8A1bEeSgdGK8jv8BrT4ELauGKesXcUQ/NvIl8GPIvtjHUa
         dlq6LGKfwJPDKc1hqxTTexImV3ooa60AkLAwty//TU1Aud+zlDsWoYwc1GJMMw5GrPD1
         i6YTUxWoKGJI6VvLUwVYNe4J93ja8dWxABQC6msHr0VITudSr/EZbiQ57L7f+pXfINUu
         5yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784852522; x=1785457322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0prRSNduz+Ji/XS8wepAJVI1GnsS0uEtqzgw4W1wWvM=;
        b=eNV06rhLbB16zOdFfS6s3YuQPRvCX/1uTeuEwfPsBJO9SsSIWDSlUnFVPpxAojn6vK
         ArCA89hZ6Z+nYLXS1PODRazIfd5dCLPu6QFeCb18G4zmKkxiPpeHNd8xtWk9wTyqN+uD
         9Y6PwFpPmCboyAv0pdAhyaN8uqJ50TJl8pDPHlCoCfT0Fwi/R6IVhdLl4+apZDpw9YSb
         VIFlGTXZQAXFa+0qraxXVhhF+OpcTCpqbeGPGxTf08J2DFcIzZzLXNoU8RlSNCVE2f4D
         Pxm+gyfYQYGwLuyM+SCsAxLP3/bS4UvPkkoTHCEdCm8ILtgBUcOiftRou+tDgaSICLge
         hEbA==
X-Gm-Message-State: AOJu0YxUMuEvWHmG7XzMkereN89eSY1WIwQPu3vY16hKAwwJosz6ExcM
	PFZlRNxnJ5mgnpRyB7v4U4KzEUW4UEsARvTqo1OGuXCRzQi9NWaC+DoGe/QZsY48ZNOXvNYAbkj
	xXEHo3hdcZVuUKTj6y2Rc6jsteMhNZ5g=
X-Gm-Gg: AR+sD11Fd0q2LhMFM9W1iUROoBvkEgGG+IOWPYFfPeHiZxEqS0CpJbs+nHz8ZqTfhk1
	V9rJ1rfmPsi/c7vAmDqMWieKMIF733i5axCZTdGQK4Na1eocnQxJtjf7BnkbYSq2LnBb1IJOZKM
	Azwydj/Dp+AcSHmTCuTY2Yy4Vk51ZSulbXFqlneomYlff6v7cbv/hoGBEYjHdxDN5lRw5V0Hnl0
	81/PqKT2BWiPdccMsqSdWTqFAdMb+nb1oOgpX2DNfa5wtbLYBF7COL9I1PqWJhSS04oQSAMG0bB
	J81yFE0am5RJ+cdqI9cFKioA88RlpSN1oJhscbVKFosrnR/Jkw==
X-Received: by 2002:ac2:5b1a:0:b0:5ae:b9fb:1582 with SMTP id
 2adb3069b0e04-5b2b2f6dd1amr699298e87.40.1784852521800; Thu, 23 Jul 2026
 17:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603184859.89693-1-piyushpatle228@gmail.com> <20260614220400.106dd636@jic23-huawei>
In-Reply-To: <20260614220400.106dd636@jic23-huawei>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Fri, 24 Jul 2026 05:51:25 +0530
X-Gm-Features: AUfX_mxzNJZ3fgQIe67qr4_QzOSjCjon-5KcXoIL4PiIg6XtabyfXedcfWFcXYg
Message-ID: <CAMB+xkbpgDxv1Lt=qxqKyeEhXyxRpZ3Y1v7ZDaMGKUqAa1hDxg@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] iio: adc: Add support for AVIA HX710B ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ak@it-klinger.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 2:34=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu,  4 Jun 2026 00:18:48 +0530
> Piyush Patle <piyushpatle228@gmail.com> wrote:
>
> > The HX710B is a 24-bit ADC from AVIA Semiconductor, related to the
> > HX711 already supported in this driver.  Unlike the HX711 (which has
> > selectable gain and two input channels), the HX710B has a fixed gain
> > of 128 and two operating modes selected by the trailing PD_SCK pulse
> > count after each conversion:
> >
> >   25 pulses (1 trailing): differential input at 10 SPS
> >   26 pulses (2 trailing): DVDD-AVDD supply monitor at 40 SPS
> >   27 pulses (3 trailing): differential input at 40 SPS
> >
> > This series first extends the existing HX711 binding and driver with
> > preparatory refactoring, then adds HX710B support on top.
> >
> > The differential input is exposed as a single IIO channel with
> > IIO_CHAN_INFO_SAMP_FREQ, allowing userspace to select 10 or 40 SPS
> > without needing two separate channels for the same physical input.
> > The supply monitor is a second channel at fixed 40 SPS.
> >
> > This revision is rebased onto current mainline.  Note that
> > iio_device_claim_direct_mode() / iio_device_release_direct_mode() were
> > removed from the IIO core since v10, so 11/11 now uses the replacement
> > iio_device_claim_direct() / iio_device_release_direct() API.
> >
> > Tested on a PocketBeagle2 (TI AM625): the avia,hx710b node probes and
> > the driver registers its two IIO channels.
> >
> > Changes from v10:
> >   - 02/11: Retitled to "add VSUP and DVDD supply properties"; the
> >     commit message now documents both supplies (the patch already
> >     added both; only the title/text were out of sync). [Jonathan]
> >   - 04/11: Reworded commit message so DVDD is no longer described as
> >     HX710B-specific (it is added for both parts in 02/11). The
> >     compatible match now uses "contains: const: avia,hx710b" so the
> >     constraints still apply if the compatible is later used as a
> >     fallback. dvdd-supply is now required for HX710B (in the HX710B
> >     branch only, so existing HX711 device trees are unaffected) and
> >     added to the HX710B example. [Jonathan, Conor, Sashiko]
> >   - 11/11: Kconfig title and file header use "similar" instead of
> >     "compatible". Simplified the tail of hx711_set_hx710b_channel()
> >     to "return hx711_wait_for_ready()". Dropped an unrelated
> >     reindentation of the iio_push_to_buffers_with_timestamp() call.
> >     Converted hx710b_write_raw() to the new
> >     iio_device_claim_direct() API (see above). [Jonathan]
> >
> > The Reviewed-by (Andy Shevchenko) and Acked-by (Conor Dooley) tags on
> > 02/11 and 04/11 are carried over although those patches changed; please
> > re-confirm if you disagree with the reworked constraints.
> As the only comments I had (well mostly sashiko) were on the 710b patch
> at the end and some patches were queued from previous patches, I now have
> patches 1-3 and 5-10 applied to the testing branch of iio.git.

Thanks a lot for picking those up, and for the reviews through the
series.

Two questions, mostly to make sure I do the right thing next:

Looking at mainline I currently only see 01/11 ("dt-bindings: iio: adc:
hx711: clean up existing binding text") and 05/11 ("iio: adc: hx711:
move scale computation to per-device storage") under my name.  I assume
the rest are still sitting in testing/togreg and will flow in at the
next merge window rather than anything having gone missing, is that
right?  Just checking I'm reading the tree correctly, no rush from my
side.

For the two that weren't applied, 04/11 (dt-bindings HX710B) and 11/11
(driver HX710B support): would you prefer I resend just those two as a
standalone v12 based on the testing branch, once I've worked through
the remaining comments from you and Sashiko?  That seemed cleaner than
reposting all eleven, but happy to send the full series again if you'd
rather have it that way.

If there is anything still outstanding on 04/11 or 11/11 beyond what
was raised on v11, please do point me at it and I'll fold it in.

Thanks,
Piyush
>
> Thanks,
>
> Jonathan
>
> >
> > Patches 01/11, 03/11, and 05/11 are unchanged from v10.
> >
> > Piyush Patle (11):
> >   dt-bindings: iio: adc: hx711: clean up existing binding text
> >   dt-bindings: iio: adc: hx711: add VSUP and DVDD supply properties
> >   dt-bindings: iio: adc: hx711: add RATE GPIO property
> >   dt-bindings: iio: adc: hx711: add HX710B support
> >   iio: adc: hx711: move scale computation to per-device storage
> >   iio: adc: hx711: introduce hx711_chip_info structure
> >   iio: adc: hx711: pass trailing pulse count into hx711_read
> >   iio: adc: hx711: split variable assignments in hx711_read and
> >     hx711_reset
> >   iio: adc: hx711: localize loop iterators in hx711_read
> >   iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
> >   iio: adc: hx711: add support for HX710B
> >
> >  .../bindings/iio/adc/avia-hx711.yaml          |  82 ++++-
> >  drivers/iio/adc/Kconfig                       |   8 +-
> >  drivers/iio/adc/hx711.c                       | 343 +++++++++++++++---
> >  3 files changed, 359 insertions(+), 74 deletions(-)
> >
>
