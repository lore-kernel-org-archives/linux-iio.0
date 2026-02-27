Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB93E8C43
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189578; cv=pass; b=CvgkVnkdVOJZwtNKZlTVdL5x7UjrBvgj9Y79Z5h7oB1S9UtvnKk7n7FbqHE1n5/eNKaIDnqjc0kqtnfcY7UoYo37PHu1VRzSsSTuYS1BgDFHWLsNLgind6D+ZVsuEp+ajct9583NB9nb55wPCBTndMVfV6KKL4WqpbAr/2Vx/GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189578; c=relaxed/simple;
	bh=YT0h4j9+jUlnD8Oi+4CTm7F9jy252j4d5AVAYCDeXFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USAwuiECcwFx+7Ej1k4b2pyD4O7309639LZ1vVezdf6OYSFx3ypo+vHSDxbgT7zJ2MnWFg9zi6UmIAWxHzRQUb7r3IRk67M8sH6LzYM+rFTEuptuNWxyYy9JQOG/pmPimtLOIeAhpYqVA9bMy7grZ6iHbOpli8iAE9aXtRicNbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6qYeQX6; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6qYeQX6"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64caae0eb68so203732d50.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 02:52:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772189576; cv=none;
        d=google.com; s=arc-20240605;
        b=HjPC0IYHfhjXm/g3L1pHmy9k4Ku2JThKS6iTfqN0zVQHzTPWwf7R39G2A/1LKP7KOW
         vNeZOvitfy8Ayk9kRJxAGTZORPYLnucoA/85zMt2Ra2hkVcOByzE6zoB4YXaPxi5/O5j
         cDQkh3RqjkiiuRqMPhXukQS832Z7MpLhRfVtR4e92CvFtoo3DvFXBoG/dXXGcc0No4fo
         8Hrn1lJcNhWD1cef5dOZhJCV6STRsokTcUWTB8D9Ew3iFl4KDkMn9Dtbw49it+Wf36W0
         BXKcFjyoJaWL6P806IqF9dao5nwCGQHuQFN8+SmW3quLOXVND6H1RHHGHIFSd1Jh9cwk
         vw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YT0h4j9+jUlnD8Oi+4CTm7F9jy252j4d5AVAYCDeXFM=;
        fh=pY0sXCDylx3q5k/n2smTiX7ekqLdGnJCFXNUtpVhWwQ=;
        b=O3raH81Y40z9ebFmRXsdj0fT+WE7LVBScNpTn225ZduDvFO2JJeq67PApIy5qHJ0mN
         h/essU1rIQcWw24GBWSZXHD/j06cv2OhIur/1O2SjEsEog1qqPygQ1DCWTYMQAZVTczd
         pIO1KBPz9r0TJhHKMKkWtvn2iXPe3dQxf+VSvDkqYmUhfdMryu1Z18lrmEG7I5wbfxtG
         RUoVGfUp+3ebx3LsHYRO6zcAZRFjyl9AODe3A0Tweh4Pv3mXr5IAipvDwWwlpa69XynK
         HI0EMVMEKbasMk+hge82ju+KzjShFntZRMPbr5IBgL2RIs9jPhtkqqAUABqDIuk2J5jf
         yRVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772189576; x=1772794376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT0h4j9+jUlnD8Oi+4CTm7F9jy252j4d5AVAYCDeXFM=;
        b=h6qYeQX6fEUGkoW/qjGpxOCmdj4dHk+EExotXW/Gp4Al8qFSQO1B8STOTVlmlpA1Rd
         Jx/AbVHrJTSBGA9em3i3IWSCdNp8/R+z8OfasSbxOXVJXtgs88R0FJITbw44aaMbBtme
         PxjQCHPLRnlS94oUolpTmrlz1yrIwPQra3nJgpwZCaWVrlTohKoynltRJuEEL7ey+BDJ
         Irk3I9kvvEc+B9HMhbRJdEGpnLtWJGJTjP0BcQRouWfYqJ5MxkDJUAuUCr7lgsVx1qd/
         oUTxB1j9R4l/Hn0w/wNAwNdkacDd65bQ+xRlnibSDGKrO+3S5TLTeyKk3Z9iHaylbkDk
         yB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772189576; x=1772794376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YT0h4j9+jUlnD8Oi+4CTm7F9jy252j4d5AVAYCDeXFM=;
        b=YKXKRo/KpIO2MsuU7fGYJ2rEnoFwL57TSgXk79Tf8Exu1N9zgXANV0ck/Hvi+YOVXo
         DNyx3gYAqYrTiDmyOYnhsHZ0JRtFJjzS4AQivenknuZeR7+ULHAZNk/OrLH4dCLFO3Yq
         ofkHAac0PJ2JrgpwsWU9PRCMbDsD37cTnTD2HbQXzsGWkVnFaIxiPoq0D4AWd6u+pVNb
         FROfNkcVyd/RYtrt7M27FCuXL2brtGZkwZoUfEuD8XYX112PsIH+3GWKConEM+eZhknJ
         lPOmR60s+dzVj6Yc61oWvedJ5vUa1zzebQWBciIoHelZyExDQgAE9VVq8dtfpsaFCbiZ
         8zTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfCxrxgRq/SOMTIGWrSp/sCs9Di8MFwbNYBy4ZcZ7pu9MLZI7yDXeNlvu/92M/ptEDZGtL+PbvAKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bUgZ1XPv2zM03PxKe0ZIxsy6fBbCuejISEUl0q/ObTFJCaTQ
	CH0+/LOJpKERxeEYqOURNaecuGMo/I+GZjkaLP7QZJJRPeSdQq+PQhjRb9bHfpL8HTkXNI8oRrF
	4RDqeHCnNrGa7r3YRKEoCqCvZTS3j+MM=
X-Gm-Gg: ATEYQzyfrbBkOaT1obIxWZrCRqj3X3u48OLEnmrs/rb1yvpqSzdeoxNV6nGB1p+5F95
	w0OawUxt6sa0BgSM/uvPMR2c5KUfdLJJ4PzQMydzRdyiadWUDdX97wEUAh8ssL87dIRZLU5QhDK
	FGSe5LNgjS680geV6uKuPPzbbkBQYpUqxBvGD9SE9raCDDSuuVgfhxDgRl+lFn4DQYH1jjgw9Ki
	xYhGgi8rHNzefS9YLeNHnidxGkrig07PQrEdBQqRbbC6RAHkFZqLIvdxCtYAYkphCe8KRyf+Cyu
	Iv/pOkwpGSb1pUpGfN46GOLUeAIoBSLnYWkYtmP79p+RBswldtj4yviu476OmH4RlpZ32Q1MoPp
	YCjDTwcjVJmMAYLmdQ0LCOw==
X-Received: by 2002:a53:ac81:0:b0:64a:eda9:8ea7 with SMTP id
 956f58d0204a3-64cc22acb98mr1916392d50.4.1772189576649; Fri, 27 Feb 2026
 02:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100900.72980-2-giorgitchankvetadze1997@gmail.com> <aaFy3JVVL_nvSGsZ@smile.fi.intel.com>
In-Reply-To: <aaFy3JVVL_nvSGsZ@smile.fi.intel.com>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Fri, 27 Feb 2026 14:52:45 +0400
X-Gm-Features: AaiRm52xcBgnZoStceU-Zcf95R4Ntky_uDliQArneW1O6FZF14eIHppKUJXWwms
Message-ID: <CAE7dp2qN4mxJfSYXxFQY9sdLR3eQemwDOEur3QxcMU2TNBZTig@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ade9000: fix wrong macro names in ADE9000_ST_ERROR
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> What about the current code that uses it? Is it even in use currently?
>Please, elaborate more in the commit message that we clearly understand
>that you spent time and investigated code and/or datasheet before crafting
>this change.

Hi Andy. Thanks for the feedback !
The macro is currently unused in the driver, so this does not cause
a build failure.

Reference: ADE9000 datasheet (Rev. B, Page 61), STATUS1 register (0x403),
bits 28-31 define ERROR0 through ERROR3 status flags.
