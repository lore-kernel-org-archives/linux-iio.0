Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C418191
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778940888; cv=pass; b=KB3WdOybiiZIVC4isqCmINUSiwCwK5IlThfGMQBBCiESAoaL9Fe7mjiXSt8UTj6e8evHYe9sqq81j5ujPVAaV6LOIkHZo0ljQqfd2wed4qnZQd1rpd997k7EAx9PKp8UbkUlKa6ZWXMmTXQdyF7nIfpv7AfiIDxTUL6rZrNTNvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778940888; c=relaxed/simple;
	bh=9L7uSDfYqWpbZbIF7kf11hJJ/d4tbmWtlB4hpNY3gc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5c4ovlZQu81LEIV72gJW5WUl9GF3rlyrULWDTZQ3pqA5wBWQKQOc2+/NMhXJ+F1s1X6aDR7QIlgR95WnIVMDSghbFqJMJngQ7x/Z6hRja2RiXQMJ/cHoy0hjKn5Vr7viwNAMWr1xi/iQ53ZVD71Lj87TM19wieMVtEyPTYYQQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxAEZKtZ; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxAEZKtZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d7c12e48eso10157631cf.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 07:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778940886; cv=none;
        d=google.com; s=arc-20240605;
        b=QyEfXkonezEqpTAorHWukg/7G1evjBVd11SONk7nGAptxc6jXOPBwnvDxIuTm7l1FP
         Go4cC2dJawcv69uDRC0U58EnaPdWo8JtpHQ2hDhO14dGFZtVRuOhtVuzZ0nsTyQYZpXd
         mwP8chOSITrXTriKxiV7EE0aJfcP7Df9ulvfNKmeB+agKcJmc7sJXqFsMo5e8pfdLgtq
         7BiNvY7+i2SDf3JfrwyRGn24h6ambL/iY7tf/Q0cEAaeBIeSz9CYJgqKSnB7+XjU67bQ
         5CJMTJyykTr/6YkRfDRlvBlVP8cy2fnd2v1efWqjr1AuY90yti6X+r96gFeH1WrcITD2
         kdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNixrMOrBDr2U45lZ0XT+QexEjSwj35RNi4qTyD9BG4=;
        fh=heeu3FyepDrgUJ21Fpu/VfdFEj0KXadC2aY7KDQHQyI=;
        b=S5vEK1BDou8ACnkHCSI+L6Pjk57m94WLNBnKpxz9hAy19VClZpzrTBoZ+IS3Q2BVCA
         0df3C09Ow25EvO1m4GookHxj63NA/h32xQOX+X8u0JUU2dPWLQYZ9LBIdsuqg34ntakm
         V0hw8ME0Et8+2iy5qKIrRAxf55A8veidO4s+RWJz5xpREVb6z3YpTdWijN817UATAxMA
         wOpHoPnGVwto5+ihczIPGOcVkWXKctbJ978Tz67ZWQzsvmJTs8i23YgQWvo4ouS0biEb
         r+t2LDTVpL9nUrkw8kN1SgHAUejnj/r583EDaA6alKQpn5V1XLL92aw8zB7pkKC2dwil
         GYmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778940886; x=1779545686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNixrMOrBDr2U45lZ0XT+QexEjSwj35RNi4qTyD9BG4=;
        b=KxAEZKtZguKo3geBrVphjFcKqMlw9CB3tjTkwlPYMM+Oa1wZhAqz/zzZz7A4pJdke0
         sSBbbciQBXUWxJ1VkBPKICc+BRWs8+W5QrH+5ZiziRCDaqvSPIDg4X9kqCmpA7Bw2vgp
         XEiFj2nQM7lEGmV2HkT9rxAdV7AuYeoLIVe9D03zzEWOA4IxnOsGZlCJwgaMVP388AOS
         3WvuwPp5nb89HDJukuJ3KPb4ucSZVvXOX+MJTuoOjeFUlxnJim8mkTzdwPSUKBj8i2oq
         tB5OO5UNWteYbBJ3XeV0aVQ08Vvw+CdfhZwPYSpv3R9y0xUZM+zU6xVuP0p8LUnLtlUH
         MzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778940886; x=1779545686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNixrMOrBDr2U45lZ0XT+QexEjSwj35RNi4qTyD9BG4=;
        b=H6rObuWltEraCOGpyaCDgpaWYcwXTRBbPBtD2hjkJhJzXxnDdvOhfp0YxZr3J5GBHf
         orqkyGNKBuEFQmQJtRpP1F7nO6uYPWAP8BLWOqN00S0ChoNra6IqQfpvt9jDVqeFDjYm
         botM+y2FezaZfS5zDJBgL41vWIo67X8OXjmmfwZE7fhN0t7RCqJC8HexPBhozNy838H1
         8E4WABxsPorpCduq5mooL/YFMea/w0Qq+gGpzksdSgzV2cvLgtG6+PpuPbIRzKP69hdb
         fGtXTV2z0smmeRaRg6RzMuEmMcpgy5IZLu951CVWRXqP7kt/8v7pKPJdY7l/Tz7/2eNM
         0oyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/t/IZ1V+RZUEzbzEyw/KBfz8asIn1mSOT5vtpuid51SVQZDakr1Xyyt00qpktGc7nAOOnHXI1PeBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI0AaZEm/c3vvKcFubvk5dXYTeFGAt4v1iwOuK26TnhPJMOvK2
	xo+niBH3SQc2u2HA7xysCGH3p35pQjyy6ZTtwyFeHKbIDhWPvhsl1gkVa45i7MuVEs7+nAQenQK
	3KCF4AnMreERDGkPXcii8POr8Hg4Qqgs=
X-Gm-Gg: Acq92OHKkksLlcrTh5JLzMm/OtzvIX3tQUsxNG2zuSJSouwhB+MZjaMUmBVE7Uf84C0
	UAVigYu+/l4gtzbq6G9sAO/mOfa0Tfw0jRXkzZYlw+SGM8Hej4vRNpJ0xi/9vC8jZ9l6DGDDvf3
	wO10koowU6E1fcFStdVexJwZOgqqbVjChGup4Yc/d4ehBFw1p0dUTwIR+KKwygIeJzmLvcwpnQW
	y17tV6vhtxyhSv9zRZhReilH8nBuRTILs7dTEzIBfUbcMhIAZQ0kQaXWnDEGcsipD+4L3rCLO3C
	3+nDqE2wD0poR3RB
X-Received: by 2002:a05:622a:550e:b0:50b:29da:ec58 with SMTP id
 d75a77b69052e-516596ed043mr105211611cf.8.1778940886177; Sat, 16 May 2026
 07:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511191135.36691-1-vlad.kulikov.c@gmail.com> <20260516124055.4b7e0c43@jic23-huawei>
In-Reply-To: <20260516124055.4b7e0c43@jic23-huawei>
From: Vlad <vlad.kulikov.c@gmail.com>
Date: Sat, 16 May 2026 17:14:35 +0300
X-Gm-Features: AVHnY4JbFfksTAwPYgQfc6zBWXSa4ledaSY2ewxTiKF1bZtGidjLDgiclZF197o
Message-ID: <CAMY8kpQPg9jc7cnY_jJ3sFR7+G_JNxQKkuyRF90guc9jJP02jQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iio: magnetometer: add MEMSIC MMC5983MA driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	andriy.shevchenko@intel.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Great, thank you!

And David, thank you for the review and the kind words. I really
appreciate it.

Best Regards,
Vladi


On Sat, May 16, 2026 at 2:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 11 May 2026 19:11:33 +0000
> Vladislav Kulikov <vlad.kulikov.c@gmail.com> wrote:
>
> > Add an IIO driver for the MEMSIC MMC5983MA 3-axis magnetometer over
> > I2C. The driver provides raw magnetic field readings with
> > per-measurement SET/RESET offset cancellation, giving 18-bit output
> > with a full-scale range of +/-8 Gauss.
> >
> Applied to the testing branch of iio.git.  Once the build bots are happy
> (and I catch up with backlog of other review!) I'll push that out as
> togreg and it will get picked up for linux-next etc.
>
> Thanks,
>
> Jonathan
