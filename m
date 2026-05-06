Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1114ADDB1
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084123; cv=pass; b=FFqsM5lbyq1XiNs1aomfTDcl7e9HtILAViJobu88SgGHbXLbXu7k3Uk3HZN0plevp6Hz64idA0MS8BGwrbw5o+SQ+HmL5H30xODdgG16aAQLEn8Hgpnb8UcVZYtm1YRRAp3uRBydPFkxxtYd2rkFPFURNr6Oxv/Z8JFwaJuUEMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084123; c=relaxed/simple;
	bh=6ZtdnSg6PbsWsqfRBYrM+ViyZovy6iMxaTlLfYteg/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhoNpC8tUARctGO2lZhVRsaoOWgcTVFqYInFqCAJ0+fH6thY95/vvMaxqsLiO77JlU+kTupTmzZf2xqoi+JrFln6feFFNNO/AxZG5tN5yccjOH0HQFP33gqUgTAig2oshWLWONxtzUoMbHgD44vS6O0eLiIj8G9BSaS+cwj6rlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AS6huXla; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS6huXla"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c2cd216c9so5589626d50.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 09:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778084113; cv=none;
        d=google.com; s=arc-20240605;
        b=f+Z2OVCnpdX37DSGgPU0MPZTOOVGlmu5emEJBoT0Da9fLjzJQx4gLc9lu8/93BflXv
         R52nLpuKRrOJQQv8zmN67oEtMXGHO/UuhHI7Eciq6WywdI8tA/n2eOMXLJFZam+ldpw5
         w7ckImlqbSP7h8zTOiPFQ2bM3W3pbSlJK/muzZ8xm34jUQQkDux/86csekKhybNXCFlf
         Db77qbQUyEOFPOoaeCPaMg86xsMY04Pf2c3E0zv0IAWyA5HiqmlM4/x4Tqp52TBc59oe
         dEnmXxrAdw2JHuC7PA1c1B69K6aemdKaYyAcgJHjOLvLl0KwoiYk1w+rvnWjGQJgvQcA
         xatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BJMOv/O1aBiuZmzmoKoUVmuRuzbELseC26dfufZxuYY=;
        fh=9KFwLBeHuzbiqDzZqj+nm+FssUCKtgxynnVhLOGbsLc=;
        b=Hh1KsKH/PHd+l9Ne37Rp5STs+C6BbzuV9WetflqRYaf2zIbztpzScQhV1iEd4O8mnk
         QfMb3XSosC7ObBVdKs4frhmCY9vew7sp4sAgrdhB2kkITM3JbVnCFdtM93cTKbgVHKYc
         ISzID/v6rWaj3SNuTmRDK1sNXBseTjhaXa0sHZGxB2W0NmAqkXKdffhdGcaFBwrHKn10
         pw1MJL0Hr8cs06zwKeBGTHIPVcXQwQ6e8LEA1cLojNR3A8RGGutladxIm+IdXLuxau77
         1/Sz7RVr7kQFpmww1nY9arvVsXuVe3otN4IHTOGDfpw3EsMx3gvM12z0hGXYNJSNSsDK
         xyQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778084113; x=1778688913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJMOv/O1aBiuZmzmoKoUVmuRuzbELseC26dfufZxuYY=;
        b=AS6huXla3vZrYpXkyD2KO/fwS40NAR4FjxS+xMHcz3i+SI7Dm+tNWTd3ILiUZDGfY8
         ZvSgLQLPsxOxxW5mraGCIt+2L7Amrg6LB0nAvIfffVV0KM6I7pVpILBzhUbuOv7yRJE5
         RBjdlkkPSRoR58N9wPzhd4eFtqfymXCSbPRwZ4p1iHJISt4/0QEsCWd+bAI7IWq0d0Xt
         u6izm9HuSP7GTzCbrsQwWY2eXBLJgjZTaraWc2fKP8UIxlBj2naoj3m4yltB+LjLQQAM
         O6z1IJ1CdjElKHvhgE+Vxcb2mhkUzPeNeV4WEG19mR1pv2SZJ2EiCb7KTMwNOxibpXKM
         /92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084113; x=1778688913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJMOv/O1aBiuZmzmoKoUVmuRuzbELseC26dfufZxuYY=;
        b=fevXLjau3y4VYvYNp4dnCypizeJoZdpZEG4/QtRMsQFDzaNwvpyb+U2P3Z0QK06iHb
         p4fqLMx+6TJjwKamKHZTeu1JAfCFYPCM22y6Zq8Kkn6K3w5ClQvcH10Mf4bmIkBJymjU
         j+rcCWHqKfOQ6gDeAo6rHcUFEeNuO8re5Ee/C4qV0bxxwiCWoB6twfUMcnYysA5DkQQI
         IVFllW2J3LoUjE4GSvtS+aignBbk2gTSO8kCMWrbdQTvuf60gJbmVckjxYICtOOz08pN
         9WCqLSmGOfsiPN/DCaxEJg2W0F8F+WJpV2CxYNUIZkEf06r/NnokYFLJx77acFm2Wi5C
         b3Nw==
X-Forwarded-Encrypted: i=1; AFNElJ/iCmNxFSXHuIZo1CSaZy3QrpTgCuYZPzd3gZnABRSR2q8ZFNBo5QJc3i1Zz/uLDaMnkWh7dV58Gf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0KkSPddrBvn5cLjEr4IlwOrvb6Yfz6xGlhKfd6pfsxaxCwhU
	f+Umk+omVT2d103kFNPK4fJ3x79oQ/I8LOu0kpsk03F4UaTayarBKMqJrtenoEDn3Y0VMo/1hw9
	U2KaeikQGO/wHCTpS8EGCsBz0shnxlb4=
X-Gm-Gg: AeBDievAV7Rc4BVqciE1LwM7EW+2oktq78IF9WG78ZxSn4fEdOzsuyFdo+uc/WNhoL3
	ZY6ccXbEESfRYlqZF8SbG+kewQrYTIwECx1xUKL/ma8p55U1FFDRSlSG5lg8j9o4bQ72E1uHZeJ
	78UuX1UiirclGzJD2ePlA0owq8jW6lPRz+wyRgZTKY8ExwXsppg47bA7flzV8MH8y3eOjXwsPbI
	5B7iFjN8CuCLkKA0VqBt5zT8PbcWj6mXsEDitMBPgyqSd2abpx52mBonxopaXWPPQ7sp3elEegu
	BygTyCPGMVabAuUgs5LY
X-Received: by 2002:a05:690e:68d:b0:65c:4a30:305f with SMTP id
 956f58d0204a3-65c799d739amr3244253d50.51.1778084112913; Wed, 06 May 2026
 09:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504214613.121283-1-m32285159@gmail.com> <20260506165112.4425c378@jic23-huawei>
In-Reply-To: <20260506165112.4425c378@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 11:15:01 -0500
X-Gm-Features: AVHnY4IuSavlIV275gr_U5thFF__q-qs11Ev6DJHLLnKSIdfl8ffZ-u6PNefrPM
Message-ID: <CAKqfh0EMM3n=jZX4f1xJ4Ks+xg4CvSw_1FF13cFbSiCMLh0eVg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: xilinx-ams: Replace spin_lock() and unlock()
 calls with guard(spinlock*)()
To: Jonathan Cameron <jic23@kernel.org>
Cc: salih.erim@amd.com, conall.ogriofa@amd.com, michal.simek@amd.com, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "open list:XILINX AMS DRIVER" <linux-iio@vger.kernel.org>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 10:51=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon,  4 May 2026 16:46:12 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > Include linux/cleanup.h to take advantage of RAII macros.
> >
> > Replace spin_lock() and unlock() calls with their RAII macro
> > counterparts. This will help modernize the code and increase readabilit=
y.
> >
> > Remove "flags" variables where spin_lock_irqsave() has been replaced
> > with guard(spinlock_irqsave)()
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>
> Hi Maxwell
>
> One thing inline.
>
> Thanks,
>
> Jonathan
>
> >  static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
> > @@ -1060,9 +1058,8 @@ static void ams_unmask_worker(struct work_struct =
*work)
> >  {
> >       struct ams *ams =3D container_of(work, struct ams, ams_unmask_wor=
k.work);
> >
> > -     spin_lock_irq(&ams->intr_lock);
> > +     guard(spinlock_irq)(&ams->intr_lock);
>
> This increases the scope to include scheduling delayed work. Seems unwise
> in general and should definitely be mentioned in the commit message.
> Use a scoped_guard() here probably or leave it alone.
>

Will add tonight.

best regards,
max



> >       ams_unmask(ams);
> > -     spin_unlock_irq(&ams->intr_lock);
> >
> >       /* If still pending some alarm re-trigger the timer */
> >       if (ams->current_masked_alarm)
>
>
