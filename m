Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06B46AF06
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846800; cv=pass; b=T8eQyxpXyXsFzMcCCm+umejE9et709Hjr8Erb6RmCp8t24qt4n22VaDvB4gpSBDFhmafWeUF2gKzPOnA4avnFu65oKqMKqKVMMlVXfyvF0ukjAvORyhN2/UWtZUfUDyJ8PEQWhM42KP01LKN9fzXEMBReVFPXme1/GOgAF5s0HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846800; c=relaxed/simple;
	bh=+UBsqowdXjrxyXaGO8gZjA/lfuCfrMGbalFkQPi3Dsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttjvjk9oRd8OLJ4dsv/IBWA97kT5NLfRonDCe6fC39aFRCpkppH0fMmtuWy2A6TCsOQJmRRYV4eYRTiIMQDi8c9c/UoROjuWk0TrHWSlmwJuV3PRKWaHkKKF2PfP/pst4GgQC4rOeyAQM57tOQc9t8SToLf4+Nlc0i8usr/907k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsvmY9SH; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsvmY9SH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso53145425e9.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 05:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778846797; cv=none;
        d=google.com; s=arc-20240605;
        b=XxXS9WyD/vQ6Pj9f9mljlCin4aGod2RuJZ04yRStmKchczVk2yOP08cGaAIKGE5uh6
         vaofKGwshHWt8DKwDR89Q5mnB4tpKYBKDgwGUg29ImseFP87KOILtnyGimEqIPcHe2a+
         mDduq+NX75RNhUoWsY6N48Rz18G3PLdegX/vw5hIacbQhRgYm5poVCSSEPA70fBok8bA
         vFWeZfHE40Zp7i6Oj6J1QOXLMYgjsYfv0UPJFesj3lEO8sGRpuxg5KI1oJOei7zrw4A+
         y7jbFRdU3kWsODVEp+IZuvjhFOY8jy5GwM8hgwRwO45qjpkgLPMMFvzTSf5QLIGPqdQX
         tUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/SUkniN/IDzm6P77YkiurnQsEpxZspfg+vEHC7oOaB0=;
        fh=rxiFPsSfeHrua0fnr3ryLHLdIrQgUY1TzU8haUwALNU=;
        b=V12J2VGDGnqRbOR66rA2Bib2fG206nGvUiChzlP4959a3u+KhFkV613rAz6KeTDMiP
         HvC2T0+yE8PGZfz5vW/YoYwihlN/V1YiyoSX6iofeEMCfUp+EKdagBPw+eK6I/+9AUCg
         SpOm3642Q0Asln+bq/GbZrer6F7qzcQVegKfGauKM1KJF+3T7nWt2l6bI2975Imk3l9C
         4wXJDov3bFRkWkmOOOYl3FlFPdmGCS6rt1itpF410FZWUoq+XcNEejH7dPST4X1ZCsPz
         wweFckQUNS2PiGdz3O11XutpADw2oEwbuR1VhygcYpI7/PxdhR55gmCIUQsSmdhK7AI6
         0sYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778846797; x=1779451597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/SUkniN/IDzm6P77YkiurnQsEpxZspfg+vEHC7oOaB0=;
        b=gsvmY9SHvoLyBf9hkaWYkKqgYXGr4s0ohDNqY81+lz21ai39rcY/r5iyeYXfSCYz7g
         WTfDXRJ9IBn7CWeo4WOPlo9J3rEOAfjX/RphgpQEakBavghxwzHmcu3FUOKEsPuFxbTr
         H+xqZDUwVgLL2LZQHC/9/zd6T23zJCeFL1ueEw4oyhnwOja3YG++OkshKX6YrATOlVuy
         TSUPQO92PIudP0eM7oVG1hNU3q9WfboOqVdLR16tL01RjapAto7tk0ffhjjYLffg5OtG
         OK3tprtTUeEw2nVTeuTCAsxjc6RocOrbVouEPRiocyva2k8QN7qQcYnvRANsdLFKtPTS
         vcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846797; x=1779451597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SUkniN/IDzm6P77YkiurnQsEpxZspfg+vEHC7oOaB0=;
        b=mreOZpPcIxd1pwQWG0QHkX0+YNwDz2W9B9MjJ37NuS1/CdtLdmhpe5ZsTfpHTtw4Iv
         XfT8nlA1sJt43hlYsmYTuwzzzUKTQ0aoNTfgecgyH8UIFY1uYMrhRvlZbLTcu6uh+AJC
         JQJyEeSh1gygmLSNg+GLAEmDFNRm6JSkFjqb9CSMOG4gzDaa7+UKAF9VxhTjZamiARVx
         d/H48BqOBuxyBCNXNwZGGOhX0lO6cz5Tqi1mpJEdZoI9ARVcXLPeyv1ONTBMzXhA44XX
         pPTIJzYox7nrI5u4vHiU2ViL6LNEnlPQmRkEI70TyHWArLwg9nkAByOLog5d/KOHQcNM
         Huew==
X-Forwarded-Encrypted: i=1; AFNElJ90j3bO/1xO2mLmfwsvFsgj53sPz+8jw5mW9gskPtCqwIc2BkarPM+duMKhKTNicjG/0nYd1Snmifg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qXMByyv4bfEGH0RImPqIbvGUlyGpJUEDmzKrgQqm3zyqt24A
	3YH0Rxy/GEjy7NbhXf2IX4ICYzmpxqD2l/m0IwQRXDaCrELl8T8f//qgmDSejRPbgqSg2GwY8+p
	+qkZ6cVWH3Jnw1mgamE6mNyWYrjDbu/k=
X-Gm-Gg: Acq92OFfKYUgUxBi2+82SFmjBreHVuqe7iUB6h6c7OvnmRddMJZ++UeoGMvuSIcFEGj
	pY6Dm8pBk7q9jemd6pNTVrE46/tqVY6ArUIF+i7G/d8CNZxZOloSm4KoP2kvIriS3d2NIJ6EcOP
	EChmdaaBA+3sPmqn2t30kfgHQIrz3ZzCDfUJToag+Rhv1+CaltxaoaZnR3quutK8wsYWZnQ5x2A
	TitxJRqUgOV598VSZYqw3cNZidBRO1iGa9oj90dcnM9mHLhSX2D3So7ZVi+O3uBmY0fJmBHx3Cm
	s9qzqajTOozKr024RcMSWXW6WMLIKXUEJPpb+6UItpB8m29bAMaI4GLMPWPIaRSIumyylPirTSq
	Ae/th4M/hg83Aqrk2OcdzzRvGMpd8MbR8hjjNG9g8fctFX4KC/3FVRLfqIp5hJyQfOHBP8tDzm0
	sNmx7zSA==
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48fe5fda35fmr40441305e9.8.1778846796773; Fri, 15 May 2026
 05:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-magnetometer-kernel-mem-leak-v2-1-320e1ad4843d@gmail.com>
 <20260515125821.520fe56f@jic23-huawei>
In-Reply-To: <20260515125821.520fe56f@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 15 May 2026 14:06:25 +0200
X-Gm-Features: AVHnY4IumS3GgOW93qHfl-GGifMpK5rCnPEeVuFifXrJ4fA1ojTTKUpQcOsrGIo
Message-ID: <CALoEA-xTWUpg86QVSaToroCfvjDX-H_YB1rqhzVW_v=HSeCRDg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 May 2026 at 13:58, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 15 May 2026 12:28:23 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Currently in the AK8975 driver there are four instances where potential
> > uninitialized kernel stack memory leaks can occur. If
> > i2c_smbus_read_i2c_block_data_or_emulated() returns a value less than
> > the size of the buffer, uninitialized bytes are retained in the buffer
> > and later the buffer is passed on to IIO buffers, potentially leaking
> > memory to userspace.
> >
> > Fix this by adding checks whether the return value of the function is
> > equal to the size of the buffer and subsequently if the value is
> > lesser than zero to distinguish from a returned error code.
> >
> > Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260513-ak8975-fix-v1-1-104ea605dd54%40gmail.com
> > Cc: stable@vger.kernel.org
>
> I'm doubtful about a stable marking for the patch.
>
> Personally I've never seen an i2c response that was short (yet correct
> enough not to trigger an error return).  There are specific devices
> that will do this because they are not ready for instance, but not on
> a general read.
>
> Whilst I know in theory they can occur, has anyone else ever seen one?
>
> I don't mind hardening against it but not something I'd rush
> to backport or even necessarily to take as a fix.
>
> Patch looks fine to me and the thing sashiko is moaning about is already
> fixed on my tree.  Note this is going the slow way at least partly because
> of all the other work on the driver!
>
> So picked up by stable tag dropped.  Applied to the togreg branch of iio.git

Hi Jonathan,

Wasn't really sure whether to CC stable, but added it just in case. Yes, short
reads are pretty rare, however I do agree with the hardening angle.

Thanks

--
Kind regards

CJD
