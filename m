Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF433F7AB5
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823399; cv=pass; b=NDM1ASPvc5yqZMTuQfw6C1qAXRaWi8IKqrEO0/QnqUnLYWvEMwnq7zZu2D70XRLg4KdLBFkGZL/ZXruFmlO/Xulodepm1tMgQJq1Iy5pZpfcGC47aJUDbDPY2AQvPNmP3wolVYY+/XOIuNl9wzZBsWU10Cgozn+0R6XccBcJBs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823399; c=relaxed/simple;
	bh=c/OzRnFnSDwgsxcIoKD2sp86D9sGpoarDFy3UUW9+Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZqRzQnBrzezgLeT46VBmbmCbO34f5+6fbZJG62gkChd97QWUROzm5ubK62CBbx4ALrPhxLQYDks/AeEl0HYB/XapjjbWNOb3YD955R01OA4HSd3GiQFjodocpF9mb+CXSMGlSU+R/lWjDdsHcrn/BvWdlVf3W4zKEFR0UQj704=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaC+9UHB; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaC+9UHB"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so8721804a12.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 05:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782823397; cv=none;
        d=google.com; s=arc-20260327;
        b=lx+aNGMiQpuGtAz25VxpP1ZUiHWFit28V4XNZYNPQ5HqweK9SuHqnnb3cTgoDeaXRA
         g6bCZveo193vbTx17D0CFTv28XjnuESgDVSE62yezbdcwGUiP1+xcjo3T0e+o83Fn8Bs
         hUWeCylAk/GB3SvIUu9g2BCN+bj8eeYgWqwqERUosQjfcEMlgRlFmhA/eSbY3kjS44Bm
         Bmo1LfzjfzI/WWZYEFUHjYAYFEitWvBvglbKAgGnkNZV9gTK+qp9upU1/5Jr8FuMGuHa
         0dhqf39IuLaj0bg9NocfcdvcjXiM9/itWUXFqAvyO54v2aynnCApS5xEf+RLvatRsUY2
         CK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2w6RdhFgOocB1TutabIZazKxV2cTsnO4J8H2xYsf700=;
        fh=AFQ+CpBJwUOZ61+LfidE1yXzni+TNna3x17/MiTfEDY=;
        b=SJAR8aRBGkW9lRrYGws0aLVlnvg16+9FwU3JnducFU0QtOW/hdiSwNfob6J4fuS6FG
         2HxqsbaaxUrcAYGhvPSUDat6v9JmPa36FjUxP/G2DD4Ayd9RUqPzxfWXg56PG9cbdM6Q
         cyZ0LDsg5Ia0Hpqhf5AxaTHccHzhHZdBCDOXGgZtXRZv1gQIPsUNeN83yoi+L3h7ulXh
         pDcTO36DxvGCUq1bGh8IcAwhAbxOb0ohEhFXHtwKu6rx+BuLh6rPokiP2rcLywmimfPM
         wvjsF+YYp0bowu7uJRszeScbVipwpVVNlPr8BKFZlBM9BGpHmkhX00kMezOxoJPa/B31
         s7Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782823397; x=1783428197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w6RdhFgOocB1TutabIZazKxV2cTsnO4J8H2xYsf700=;
        b=gaC+9UHBpeJyZuc+ohXdyDm0aw9cZNyxfdDpI5poTzlASsnDLTARIM7nNUhPXWVawQ
         7EbNv8DatIvLMY52iFrLrJpCK/DzVnC9vKfPLDnDnEnYkjEJbepSj1feLsKwtOxpbeN2
         zunKv4IkryecWADRazpWjQ+mgHuJr5F1wDOZ7YXmY397GOWLPX4VeoGTnZSDpHsoFo7Z
         1VLZpuOu9bm/w6voPoDiQOA7F4MVKQ6ONKUp3pVQP4ThvKuWtk6yxKhZk4YrLmNkdyhB
         17MJQTAK748WxGp30dr5mGPqEAP9si9shJj7c743nGx6LseGfVhN5P1bBGtn+RVZHtBd
         THuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823397; x=1783428197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2w6RdhFgOocB1TutabIZazKxV2cTsnO4J8H2xYsf700=;
        b=VeEPlJGeivESJ6IcP9fEaN/A/P3Mbd3sSt6IzD6RMGwtFUO/6Sf43PGcNlxwGpTR/C
         Rn0C4scuxliYQsu/yYuNggvEV92hnxeQ9vwG3ldS9EBiBIN6dwm/XBdVOywMFokgx+Gl
         IG40vEwV/Nm98tJCpIqDawuprwrQ1Sj2ktDQ8ginbeRJ3oDFDh6iSUQiBqyi9j6aH1Sn
         ByMK59z3e3ayqyETtJ5o9FBP9DxkBDFN4iplyWExJSCz2eU/AbNjnlJEtZt7U7e4NNhj
         9erwLxq3eOF/0HoOBRQL9lyIJWxtxZJAnMNqdD+Wcds2DeEcnypxTJrPt/oAIPxDkPbR
         Vlkg==
X-Forwarded-Encrypted: i=1; AHgh+RrSr0LaE8hSgeHZVMtx/G/zNljS2rhq+r8EkPkSTAIRmYQ7v5+wUAlejhoHRjyYbrVMedZW76rvxmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14RQrx1M65NPXdCsM/VuDkZNOTIjNMyXOYirgDnL9nykIPVhw
	pyZex4DCuNLDU5DfImiiosDIwc6nCR2BDpVciQjsCd7ABtr/Pyz2Uqcwq4LWurfAy2SsZ5bzIDM
	dmfJ2bM0XiYtDV4gxD72GLr/skKCBJmI=
X-Gm-Gg: AfdE7cmUGysGbtjaEuU3rp8N+IaBHZddvIcEG6OajQk8lqcOaAg5jWJAbwyPFKfhJqy
	zWxxSBaSrmYOfAHBLdTuUb7mXViL2Ik3nLMPEl07Kwvz6kSmvedsDWs5cLM6+iASc90fadihAm3
	Vehegfvp+XaVhI16SbOg2x97I6SwVtJLeAXQ1GNZdE7YB57xvBtnPP7OWwIvKfjLzKsxHn8uZBj
	XkMoyf2I+5K0yaMNrKFYJrZSZcaOVXS0G4PQxbgIOVZ+s6ezXlIBEPAr0Err/x1PpEqRtKiP6pD
	YHriMCQjQ8BZ58btWDLeUP2v6sw=
X-Received: by 2002:a05:6402:158f:b0:698:1504:4cd8 with SMTP id
 4fb4d7f45d1cf-698878ad83dmr339214a12.29.1782823396447; Tue, 30 Jun 2026
 05:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
 <20260628191350.583470a7@systembl0wer> <20260630001156.61ef50d9@jic23-huawei>
In-Reply-To: <20260630001156.61ef50d9@jic23-huawei>
From: Moksh Panicker <mokshpanicker.7@gmail.com>
Date: Tue, 30 Jun 2026 12:43:04 +0000
X-Gm-Features: AVVi8CftmSsXuukCL9aoZRmskzOOhbXQ4OvVloTAMni68K_HZtcDlGotZoCUySM
Message-ID: <CAK0z5Okxj7r_hdB8xzdkVBX9z4xHyfcv4ZKfkumYHiObCc9tfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: adc: ad7779: Remove dead code and redundant
 error message
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, I'll fix the blank line and wait before sending v3=
.


On Mon, Jun 29, 2026 at 11:12=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sun, 28 Jun 2026 19:13:50 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> > On Sun, 28 Jun 2026 14:57:32 +0000
> > Moksh Panicker <mokshpanicker.7@gmail.com> wrote:
> >
> > > These two patches address review feedback from Joshua Crofts on the
> > > ad7779 driver:
> > >
> > > 1. Remove an unused completion field that was initialized but never
> > > waited on or signaled anywhere in the driver.
> > >
> > > 2. Remove a redundant dev_err_probe() wrapper around devm_request_irq=
(),
> > > which already calls dev_err_probe() internally.
> > >
> > > Moksh Panicker (2):
> > >   iio: adc: ad7779: Remove unused completion field
> > >   iio: adc: ad7779: Remove redundant dev_err_probe() after
> > >     devm_request_irq()
> > >
> > >  drivers/iio/adc/ad7779.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> >
> > You forgot to pull my Reviewed-by tags, no need to resend:
> >
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Hi Moksh,
>
> Generally slow down a little.  You may well have gotten
> additional review on v1 if you'd waited longer and
> save both a little of your time and that of reviewers.
>
> For even a simple series like this I'd wait a few days,
> or better still 1 week between early versions.  It gets
> more relaxed if the code is already well reviewed and
> we are just dealing with final tweaks.
>
> Thanks,
>
> Jonathan
>
>
