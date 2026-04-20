Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8FC72631
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776725563; cv=pass; b=Qy1uYzoEeqeg+bk7fnhKy5sKUq6bW7BbYDUM9P0COfXKyA0GVDvfsZorY/nXwjyvwmm85Vi5TRHfisXErjNp5JnQ2clH4C7BIJ58CA0I5OuB+OwMJjGy1peZ9NlBceWLc58UJR6d8gEKcf4z7At1a2aO/yqY0jJJA7KZMEG9D7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776725563; c=relaxed/simple;
	bh=t7a/DUNbJq1Ui6JElOjTLyt00rL4QuhQhy3V/SY2/Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lffp/4UyfgOg8MPDCABU4x3YCIpnduUo4sWh/pAnfWIG6bqPrZ0V39hnTbnRhFC+1EWFqMKN7dbd/jVAGmLc9OQojRJAuspVizMSuJEuuoXBwUiGwUUJvhVpDXKoDFmyg3N3KL8FhDqhRVTkuI18lRBbyvpF4d8T+RQ7ow6Ud44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=v6quMqZQ; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="v6quMqZQ"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2c500750dso3950817e87.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 15:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776725557; cv=none;
        d=google.com; s=arc-20240605;
        b=gPFzHhQaa8V3cJIyDCu+1KSAHEjXMk1lzH0hjNbOuq5MZ9vtrh5n7cdzB8VrWFDUxn
         hqaNNFBD1WKatdwG/M6Cn2lDICYcQTOHDD6GYbwyd/r1Wxjbnx7B34gzFLabOudGdPq7
         BIABmdPdIjSkIah+o5K+mx9IZ72xa8igD33bjo37wRaYgrZ8+j/nE76FLvUzptBFHszX
         qW+LP9kzVfRIdpUxmAqCrVrqVonSowrsB706SShhQhSW42RfI6hrHbUp0augzjHoXq6O
         W/qKdoirsHsvEiVZ5M3wu6gDsc6qEeNoKBHd2gED5GT6JCYByJkKpRJZh5w+BsqBMNia
         1CgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t7a/DUNbJq1Ui6JElOjTLyt00rL4QuhQhy3V/SY2/Mw=;
        fh=JsxsTvz9sqD3PlfzqDOuzTbuaqLCzwMiMzAaOIeyHPA=;
        b=CJ6E8ur+lrC6ahlz8LtxRv5OPr7tKIKNSam+jxhxUx7wUUbXHq9w2mAOFWXmJ1hYcq
         P84Nuw8qAI15Y85oLeMl9M+5m0C50HldliRA9kFZBBadoD3LoNkUFtyhCnotIbs3vJHa
         YTBoPkAkgVRhpJGAA9INfTaJfiv9davdO2CQ1UdWbcToZG3Sw5RH+etRl5C/Kdv2lOco
         ztP+suAsLw5bWipD8DVHZI1LKPY0+QWSOKISvrGbwag/c+d1baYUkrziTo6FLL1ltUrP
         5b+wBW1Dy31S7klUUYfaJg440Pf8XKTY3T63bMm9+m8qQhshz451udzSDdAkXhHQm21K
         p7MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776725557; x=1777330357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7a/DUNbJq1Ui6JElOjTLyt00rL4QuhQhy3V/SY2/Mw=;
        b=v6quMqZQjrpHiF32/l+1SigB8EdKXbXzxVinLJxaR6WKk9zS7cIKgQYhdq8f4SNoPP
         NsQoR6qiaK/DCNsSEQREtprZm3M03J93aWOkk3kfMJUtn3OD4WyXQ1v7e0NyrtObPSZo
         wk5jh/MXcSOYw/wqTNWsuHDKEdZarE//jpWSdg8PRvSE9aAB1Qgr67IbfOl8YjU2eOtI
         VZq94FSWStfxTGJlzwmSRncWm8y8azqNTwKlWAgKaPmsvWo6fm6aKh/6cBnVMxu3nHOM
         c6d1ecpi8/z17rnTr+BaDgpumE21s0OM261xdXFZLBE6RL0PsPG6WvYiTRyel0in0Ten
         M1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776725557; x=1777330357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7a/DUNbJq1Ui6JElOjTLyt00rL4QuhQhy3V/SY2/Mw=;
        b=jvBa9sEFSTY9Af8jBI1Z4ypMo+3tyU3sQe0ic2NSf6hgHlPs3+YtiQJ+49C4P6+cuN
         LC4hXeF+gcVr9Ykh6eewmb7G4vH6VqrPmWNnl4Ksh1ONdq67cWMxAzr4848PHrAQ8TD7
         DDMNvbl3fipsQ3yja1jo2XNwEw2lWnTKn+zPD2ek/y8nE6MY9BYbu6Ea9gOJRBEHEL+R
         RYF/q8ZKQ1m2uy0JecILP1wYfgSM6X+boiJ62oMrfia+BNYzjoYvZB4AnOZkgZi8rGDq
         mDN2XEjiJhzEvURxzhII5ZorexbwfPp8YKtvjYu0MFv2ni/z4OHq4j2oD9lMPWQ5PrXT
         6Zsg==
X-Forwarded-Encrypted: i=1; AFNElJ/yBbZEs4ASL/Oz5PocIKTCSGmUnLGBBr/5AN3c6vY5M6E8VUQ8ny+FOPSqDBsBnQWBG83WjME2VDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuyHiaRfH5G7CPzQvFrsevEK/Zr5Ytaii2W01EZ1SrKuk+YY9
	wWWrkdaIyS7yM0oa7/7/+PS0ZGXVW+Cpesv0bh8ksFrGI5Pf3b+Wxa5svR3CGYGBcN7XQ25MVMl
	eBoKnxrk50QEj5atEwwApG0jFtkrIT8n2qQzZC9ucuIka0eAAnQX6k86iV6l6
X-Gm-Gg: AeBDievvVxHz1cGbucuD2KrtEutks9M0KRlPa9oBuT/vTaX2C1P9soq/JPLlrZB96Vc
	VXjw5mQLBqOnHG+ECHec6JKLdPDTUyGJVULNmvRb9yIrD/aUudYDdP0xkEijKZ40dqBN8B7564x
	RwVx0OWEUD0xCSm4jQjE2x/R79V3xUyq9IOAFiH+X71dMz7lYlXoWqs9lhyfdU8qNtLIIX9zlGH
	zHZ1Vl1xIV6WzaWoCn5SUpyXkDLGh6M25b5nd3Zp/VjQCFmXU5igN5tIGC5KiGPnZAUvRm38C+z
	ZF8bh0yDVPZRmT1Jc9a7G9camt+A3B8Y
X-Received: by 2002:a05:6512:3b9d:b0:5a3:ffd1:2d79 with SMTP id
 2adb3069b0e04-5a4172b7348mr4519889e87.2.1776725557448; Mon, 20 Apr 2026
 15:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416032351.224072-1-giovannaluisahirata@usp.br> <aeHv0DEEc2bS4YB8@ashevche-desk.local>
In-Reply-To: <aeHv0DEEc2bS4YB8@ashevche-desk.local>
From: Giovanna Luisa Hirata dos Anjos <giovannaluisahirata@usp.br>
Date: Mon, 20 Apr 2026 19:52:25 -0300
X-Gm-Features: AQROBzB-d_PaxDvjKOoDoRqK1Fzo4hBsBerVQ_8YCPuv3hrH4lEb0EMoFQzbiEc
Message-ID: <CANhRbNwOtJo1BBj2gP7yYD=Tmy3EeGmwGET5ggeSSNBSLrb1gg@mail.gmail.com>
Subject: Re: [PATCH] iio: common: ms_sensors: use guard(mutex) helper
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, Naili Lucia Marques <naahmarque345@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for the feedback.

Regarding the other changes, we believe there might be a
misunderstanding, as this is our first submission to the list. We've
checked lore and only found this specific thread:
https://lore.kernel.org/all/?q=3Df%3Agiovanna+luisa+hirata

As newcomers, we appreciate the guidance and will follow your
suggestion to slow down and refine our style before further
submissions.

I have already reordered the includes alphabetically and will send a
v2 once the current discussion settles.

Best regards,
Giovanna


Em sex., 17 de abr. de 2026 =C3=A0s 05:31, Andy Shevchenko
<andriy.shevchenko@intel.com> escreveu:
>
> On Thu, Apr 16, 2026 at 12:23:45AM -0300, Giovanna Luisa Hirata dos Anjos=
 wrote:
> > The guard(mutex) macro helps to simplify the code by automatically
> > releasing the mutex when the dev_data->lock variable goes out of scope.
> > This reduces the risk of forgetting to call mutex_unlock in error paths=
.
> >
> > Refactor all functions in this driver to use this modern cleanup helper=
.
>
> Please, read my comments to your other changes. Slow down with the submis=
sions
> of a new one until we settle on the rest, you will develop the style that=
 will
> be accepted in the future without comments.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
