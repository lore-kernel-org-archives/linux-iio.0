Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE473EF0CD
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048646; cv=pass; b=aKuXOT9d0qC9fpFxE/tg3anMOSlbxRiJsq5aShHq/HiWOVgdCLgit3k1V8h8SenDNM1rGo6tPPECmq9nwH35oJPXOeq6xO6n2oEf8kbVBg09RDEO6L23sOt3X6uIAe+lohpuvqVo3FNhzfqi3HzoJbEPa1TJHGhRPrm4YKxoIQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048646; c=relaxed/simple;
	bh=SKOSjsvH33aKBTK3IdGRLtExJpwuipYT4oUjT3BcsUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIzhVv8uCcBxojw/rbUyR0b/t0831g54OMBGfAcCRU6Np0wg7kw/XAkaDbU9fYX57X4qFcleGPV3G3dpzURDjh2oFmW8JDxvviY5tvC5XQg30YVi+0/NMIrFLotFg+g13kO2b1wyslTsQBv9ht/qPCW/zgHzpRUL1+Ih1KlXJDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYr7nf6J; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYr7nf6J"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65f9763e8d1so314593a12.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772048643; cv=none;
        d=google.com; s=arc-20240605;
        b=dd4JzfJXQrOUfS/YmH8hc6vBn3eCQwVZNpcKbJyQVZQsTgELBHlG+K++21Hl0MxSbG
         hWzDSnuTGOafP0n//0i0ET22I09sxo63B2rQMaE797SV7HW6OGLo6EnWIStc4F2YH9IH
         SA8voQigNtMDHNfbbWIdrW3RG09xIIgUQioz3tjMGfErKfNM6/umjQAILx86MWOC6a/f
         zrPw5LXL0hnjWHd46HiopdgPMtmddWMMyGXq4aMt+PMlcg2X2PqcNpy8VCtI7B0FsVsG
         zhQDeJAulrFZvve0s6HvYBM2l65QnNnts4dZfKsAg6wmE0QUYj6uhTpzslgnw3/FxE0j
         PgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKOSjsvH33aKBTK3IdGRLtExJpwuipYT4oUjT3BcsUo=;
        fh=I5fA6SLmot0zHM6xBl72xrxnP65PEq8kl571dwCpvr0=;
        b=JGTKNQXaS1IQ9jsOGz/4Gvabyef6caN6r+5JkoIGtV0OIuXmuBN2Xe1dQ94L0XDDM7
         GUCg8yWjEIATDyqezDr9692lxgGrWCu4SeebYwp2h1sLm9tvTEmNZKv6/XGphES2aqr+
         q2yn3SBJQSCutmHDwp7aaLFWqSpkGSzZZHmYVE0WQuw8DX+fR7+jRYuJdHE92WAcZ8a0
         OC38qoEkqpYqOAyJK+7BOlm6rP4evF6qNv+02yFt523H3hhPNUfGD2J8IkUMImUJFqeB
         Ym9dHRl0ZmQT4WCxgmARRSgWCAG2bNRA0bzQhwHgOy/yfIvLGDpc/AOkj5r4wytlnFDq
         Oh+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048643; x=1772653443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKOSjsvH33aKBTK3IdGRLtExJpwuipYT4oUjT3BcsUo=;
        b=LYr7nf6JZ53qoQ/7YrwdRN97q2aNMZZd/0TPUFCXVe1kg8cg2rq1BnA3bZB53Kbbj6
         n+Ka0iJiXQLWStk44zVmkuaaR5HjAjKhI8wIfO32Ux9+hlUKn+bWcb4mePIz1MdIUkuy
         zEFnirIpk4x13iUAOVLHTeeYJfitHahZw+Gmmi9SW26lV2pByiB3VntkCbgaBiUMLZ61
         WGiMk8m9Angx3fRX3MJM66v914fpvJMTFfdicq7zDsXy3gGRxNUrWMW9TUZUPGqXM3Xs
         N0Y9TvyOjQoWyADWOBd7Zw/Yab2UkWmYMw9z4CLQ4Al3I+1NlKINyj1Z1c9M1K4RUcml
         uVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048643; x=1772653443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKOSjsvH33aKBTK3IdGRLtExJpwuipYT4oUjT3BcsUo=;
        b=G/fLlqrG3vXyAYg/Zh1aKCDw0f1uxw5Xmxe5xvb0GCaWVZHcWy6Ps8WJ3gt6IVuRse
         qaOD039J/O8bPmtsZHHzBnRbF5227tG4ktN5m9gv01QTye/3IWrFaJeaM7XSs8DO5CL7
         NVJGfMgeNmX18mtbVYabZW4Eqqlq90z6N+Yhnv8fLGL98QvEv/8GUniWsbpGf3u2/oib
         eXj7LBUjMmtenWlo0m0HOMJ5onjTqEzr7vkiDGZJmTZmhYWU2IuCXrTRlv+XjYHm8dG+
         i56+jlv80/FolFFCpYPVsfZRMdov/nfZ7r8Hq6pSfI9fjiOJywHHL+a4RA8ZxmyCfVsb
         El3w==
X-Forwarded-Encrypted: i=1; AJvYcCVNa8La+/4lCbxBGYZUr2/fmNcfLp6n9bNipGtymzNwlDzDMn1mum+mGbpHKrpY3aVGqxoDxr/1bDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXiRlKm88hie1NZNnbPSWbBlfodNMham/rHQCobtb1ftqihlg
	h2C+pgqrSlWOe9dfn/4xcyH/+32LUoPt/xhwpnLGJE5Y7eVcaX6HWUwX2ad/a+8dU4hDSorOaTZ
	qSBmPKCcoWLFOi7OAHjrDEi7e/rnb3hc=
X-Gm-Gg: ATEYQzwin3UR2qDpBLmPREu7jlIurpSmb5paVeYR3b5AAbcnE9RTD0eNmNX0tckt9hp
	RMfIeELsxTsUfe1j/VDejW1PWiDcEiIDvSjcm0Ry6oiVYT/B8MPe3pFJQlt8Bp2CJBaPaWYjWDt
	mDatb+Z7KrsW/IuEV/sORkhVbpXTd7RVQm7WmBvLyiXXZK7PS4EGoDO0G2XmLchLIYBrCMwY5xV
	Yn5THvr9HASfvYrfyE2VWBw+0oYaP9HKBneoF4/I0fxPcKONQyODZT+iUYP2453Ma2oG++Jo84T
	8s6JYxLvNqrOb/QUztCIzowW7vHSNbP5w9OYnZEfdtlOrgi1Kl01RauZ6dHxfY0AWNvdBq7qv9K
	fVcbj7+E=
X-Received: by 2002:a17:907:98d:b0:b8f:8660:3caf with SMTP id
 a640c23a62f3a-b908196f4ecmr1250576766b.5.1772048643073; Wed, 25 Feb 2026
 11:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225194051.8614-1-rougueprince47@gmail.com> <20260225194051.8614-2-rougueprince47@gmail.com>
In-Reply-To: <20260225194051.8614-2-rougueprince47@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 25 Feb 2026 21:43:26 +0200
X-Gm-Features: AaiRm50khSOG-H2kSlXQyW9kS28zSgRmZ48fypz3L0d1wC5fXPghvbcaeB_nK8Y
Message-ID: <CAHp75Ve5cC7HU4bXbs3J9-Gr7bwUDr7mPbWJYOt=cMRZM5r8Xw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iio: frequency: ad9523: fix implicit variable
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:41=E2=80=AFPM Bhargav Joshi <rougueprince47@gmail=
.com> wrote:
>
> Macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and AD9523_CLK_DIST_DIV_REV(x)

Too long...

> implicitly relied on variable named 'ret' instead of using passed

on the variable

> argument '(x)'. Update the macros to explicitly use the argument '(x)'
> for their operations.
>
> This also resolves the following checkpatch.pl warning: Argument '(x)'
> is not used in function-like macro

Still missing period.

--=20
With Best Regards,
Andy Shevchenko
