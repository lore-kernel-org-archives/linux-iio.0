Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C847F77A
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052781; cv=pass; b=f3nRgVtuO1FESS9GjEFZUuyeeBkQ0+C6C+5fPeWL3S/zF+LqAdd1dABblwYYB09rFTU0fwawlsDuhzqai84TSPauji2Cfsop1lZ2PQ+5vEjqyK9377duGwCMQbfD7nBIL8D21bYSjiv1uPTi3vOHnQaglR/hfK/5UXtzK+5j9I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052781; c=relaxed/simple;
	bh=Wfr8L3wblvcW0Bq2ZrAPzo+EmjIsw9i/NV/YDRHbPvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bu/IbL9FPgW7BBeCINeN5yTJiFBPcglAidzcktW87+vn+SboMbseL0jn8Gn2W7U3RErJPYMSo3pTMs2i+ktqL/HCplz0x7+ZYjppnKcbyUJb3JlmVxqkF+WhbwZXbEG6JABYJBQqXTGVmWVdAgZe/A2ZQEwvxDtAH78rby7J+nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcjFzpLO; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcjFzpLO"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cb057311bso1601901fac.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 14:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786052778; cv=none;
        d=google.com; s=arc-20260327;
        b=H5bq9B50VA7SBVCeRY+SvwlHbZVKjdPKNKoD/u3DhzCY5Jhwr69IhHI6XKNr9Y62hr
         tljMZgB8JCkzQXQ2F5sVefNksND0VWwKYqPJBpbkXs7WgwMOepgcJ4EixJKAWJuitmO5
         SlaTYVELEoB4gIiaE4lzfUqdAq1EzEPp7u6at18kwRTgNRR+xrCZijQoo0Gt8MqxKT2R
         8hrMw9vMzEldBCwicLRxWIr03Q0/NDyfaeLZxgbo7kjSinDTKsIL0efZJd9xk94gcLVz
         R2SAdcU/1Pki1KOAEAkFs/77MRA15TTMVsT0kTHVAwi5SxfsH8PoqKPPcbm3jWfEXPFS
         CXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/LqB88POXPCUrm0OGXikTnU+sodKuQSJ3LtNfIU66ao=;
        fh=b0kBp5wo9Xscczft2muVNkPUGcWZZdhfVzWF7Ruksps=;
        b=d9XdOPBmoLGbsPnUF4+cND9RAMcl146fSfrBR4p17UjfI0lQfd8vXbUwFkAOZ3wFhJ
         gfkQyRsqKN52WJ7TywP0xM8dfAp7QlmniLMzzPxmPKGVGDBZTfgwTuUyZePOP5lbBcEm
         7qwnl43eN6zFoa3nJ/004lT9P2K0Kx+22g5TTq6XQ5TknGZtcS7XYqfiY1MJthwhiuzy
         vggTd9lRXfkNABroZb62+RJ+pXB2VPk8B0K3vw17T4TlaSnow/L7jA48jOCnq0LiESxd
         DNji73J/jIP/g2EYjy8F1ERDZxfklp8FJ13rzsC3YsKrkC1WntEyXdjhF0lXLFmYfvGl
         LsqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052778; x=1786657578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/LqB88POXPCUrm0OGXikTnU+sodKuQSJ3LtNfIU66ao=;
        b=CcjFzpLO7nzyZRZ5O3XYGz94WXBTtMethOjeQRSgXLPS2FULMMXeq3JeL9F9kUjFw9
         hO6qlG18NAanl6dHJARQk9LUg69ghpw0riM8bAqh8+s9exo/6OqcTMPVBuvYBiRVpxvo
         UlOfqSHBiIew+NaxvYGQdAOFhBvkt5C6PtIZmJqZKQdsNduau2na0Wuts3uBI+DI8RD6
         wxA0yyNCU4BXgOGM3JtXUL/GlqrEdTcxf5dTPM6O5XgTWxm9mBcU4xmDbv7K9N/BtfRL
         9Lfr9Am+HnnG5C9ase5Df32rczeV35QtB1zhyDSdWl8vbERFJnY7Y2CUhhc4VqJ18jBm
         I9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052778; x=1786657578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LqB88POXPCUrm0OGXikTnU+sodKuQSJ3LtNfIU66ao=;
        b=Kden70zO0ai9pZenk3EcC0Bsa4dFYKm1wrnTDv4O3z/S/M9zm6cpdXOWz+XMvv0NmU
         veIYMI1KJ3UjfJZSfmHoyaazAlCSqjP2ce2fLtPh19abR0omiCAyS4nQNbQ/pmvndfUL
         VP//HmuTHHFGAf2oApL3DUTVICxGQwf8W5RvVrH+67awB3/GOM9GxcxQLrNORa3ZEhRC
         H025qbrcUyMkLdRTG5Vm6t9jZRpBK5Th8eUOCz57PuN7bTo+vOI1BRt6n1DocRQ9QcWp
         mIlRZh9iDC4Pzc+IsjOdRvrp2B859lXPrU4EpX80vi2iCRzDT3pzckRaGv4rSeVHvoy6
         uDvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDhED062sqcw7ZNF/c7rZ+56A9tVob45OqntflqzfBqWF7y4T9Z4k3cZni4SYPrUJYAI+rbaCuIWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8L4T1Xi+fMD29ogKfo1OFxjAqh6G85q0oXKD475yDO/X5L/oL
	boGhBcIIW5uYolsgbmT6NMFgkuc12nRc9+v+NLXaV5WZ9Tgv7mVUQRCXL7wJuFnM4mZEOV5NeOQ
	et2dIkR74PWdnRtQntHLnaLdoU0KMb0A=
X-Gm-Gg: AR+sD12SmdoNHD2N3EotF/GoQc64dWFn1Daku8Quc1an8fjE5ZYhr5WEFklhgLX+wm3
	wD7AH4AszA8UKbdvPn/vLV30UsaZt5khcl3MHK+/66waWgIbF8gvh+mFHWGndPVF5QMYzj+jXkt
	MXtSaGD6c9ThIrFVGvKwLNIgYBVZEO4DGWBlBMEN/BTdj6Bk8qkmJwk3AzI/uI5Z/wZKbU43NOf
	wauxT0GVwrR3OOEK/f6Br5/dTBDxiGzGwKLJto/+ZoXorMYzIbkV4P/YLTBkM+MwC3Wb/MN8D4F
	tkK2ZC3eWimucYAS6OGkiIr5WVAKuOn9ofPUF41dTsM=
X-Received: by 2002:a05:6870:e136:b0:451:ffac:5643 with SMTP id
 586e51a60fabf-4599eda4d93mr9510272fac.10.1786052778574; Thu, 06 Aug 2026
 14:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802020614.19732-1-adinata.softwareengineer@gmail.com>
 <20260802173852.32b4bc52@systembl0wer> <20260802181233.535eeb12@jic23-huawei>
In-Reply-To: <20260802181233.535eeb12@jic23-huawei>
From: Adi <adinata.softwareengineer@gmail.com>
Date: Fri, 7 Aug 2026 05:46:06 +0800
X-Gm-Features: AUfX_mxV5h_WhCX6rdYpCZC3Qyu8dhQpGeTB5wv3UFz4WE0D31WUAnv1Muga6Ow
Message-ID: <CABZ6vuBOECSgu=OpnKmk6jsrE-xQd9-nZO_VUftve73AtOEJtA@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hts221: Fix checkpatch blank line warning
To: Jonathan Cameron <jic23@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 1:12=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun, 2 Aug 2026 17:38:52 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
>
> True.  This highlights a broader point.  When making
> a number of cleanups to a driver (and I am generally more willing
> to take those than many maintainers) please group them into
> a little patch series with a cover letter.
>
> If this is one of a set and overall the seem worthwhile I might
> pick them up.  Plus this driver is pretty aged so there are other
> quality of code / modernization things that will make much more
> of an impact than just this blank line.  Take a look at some
> of the other similar cleanup series on the IIO list and see what
> makes sense here. To give you a starter, dev_err_probe() and
> checking which prints are actually useful + stopping the driver
> rejecting Device tree falllback compatibles because of the hard
> fail on a device ID mismatch.
>
> >
> > Also, I feel like just putting checkpatch warnings directly into the
> > commit message is bad practice. Much better if it were "Add a blank lin=
e
> > after variable declarations per checkpatch warning."
>
> Fully agree with this.  We really don't care what the print is, just
> what is being improved and why.
>
> Thanks
>
> Jonathan
>

Hi Jonathan and Joshua,

Thank you for the advice. I will create a new patch series with a cover let=
ter
for this hts221 driver accordingly based on your feedback.

Regards,
Adi Nata
