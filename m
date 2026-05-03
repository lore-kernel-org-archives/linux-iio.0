Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A48175A7B
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798426; cv=pass; b=Xu6aa1EW9QvowfsqcU9dv96rumDJ5WZWD9CLS8FUUM8rJv527Giji/BgSCyFtw9iFtay8FusXZnTHJ+JMoUvmRVuLjti4ZxT+jQoDfjGsOvIL5QMwzp7EyaKyvMLyke8JA9Jd68RTWcvECGBeoi844JZ6gD5yqMpnFHAc/vU6D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798426; c=relaxed/simple;
	bh=TN38G3GI/HX4MCUlFvl6FUE6KgcFjBtEqV/pHZDos5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2nKasBJcZFW1/CJbyQZTQtaGYBT/6jytIBYFdppLVponUd/O/0QvXl8AqxP3YyFZjqYlY0ios/xfXLISI8I0VOpbLsgk+8n1ehAPjswmI5+/o7CX5GLF49dn7E3WY0Pm5lrgkE/Bo4CQQVNMpuRdqpGn4TXajn9jxFcFGI4De8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltm92OCf; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltm92OCf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso24451395e9.2
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 01:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777798423; cv=none;
        d=google.com; s=arc-20240605;
        b=WTNEapT3RnG9bDxsJF3aRuq1Qa3QLv5plkPhQeiUB7Z6s5QIXyN5Sr4+Djz5139JlG
         SlmIaLXz6JXRD5wgad8VhRTYrY22e4y7lnBwJF7otYPlhUDLb3L/UtDwVvmbHzQtiZex
         KeOAjN8hO8j7keVOEqI7ifmZFRHDslhyXfk8ZG58mA0+SIEZNwUW2Hw8MSqMfXr4yTJL
         nyOVkpkKhWuxc+Z+6Z2DifylG6Bfqte3ApRHWXuJPvuRtwVUeUBDS9noQxuX0+a0sKD+
         wSAyzXusgtbzJpEGaOSbdCOOTPgqDt6cFcXbWPAHaZzuXXEHvFA6FnwVHHJUEgG/zejs
         I9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DuzbqSf46naLhH5+skcD+oKWabUFj8WqimsDijuWm78=;
        fh=YFnsBjz8wBjBdAQa5D1ezS3P5m37DSOZBhcdz6/uOE8=;
        b=G+dPKuzfeFTDlXLO76VYAOENERIYXtu4P5rLH189zkf/XJoFiOm9DoT4IEkAKLdJxX
         PFfxoCucws53FIEx236AmyuU3RXwpQMSz8JesLDbL7zOiCf0+wrunWBAj8DmUuYHBINq
         ShVdoYZldAkDhwkhRGiCcNNwCcEsq7aAmcd3X/9F4CfK7sbl2hyAruVCFybBzZyOHmXJ
         ZNwOGzEj8a2l5a0SBTq+NHkEMRrlgcksm+qU9DKRt7CF8dg2lvwP7F1YvWGeWH436z2X
         cQ1i6x/iltax+5PILMWGaU88bVsvs4DBIzcnt3Kkgrat+Y2j/39m1chmzKFJHoUfA5sL
         Nt8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777798423; x=1778403223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DuzbqSf46naLhH5+skcD+oKWabUFj8WqimsDijuWm78=;
        b=ltm92OCf3TvBVt+w6xyiSLC4AEZKdtE5KPlPRGJMATFQefgTpaA9RhVhxUj8cbh5kU
         gq6ymabNpH+HPHWdn+c3f7kJlVe3OkiiLd0GGPgmdi0OOupuuwdC9drUMpEf18T0aSdq
         iFMIz4szEYblmI4wt5NJIRRziXJ5MgSULhTfWQOkVucjjTVwuiupThSLaa/FNX9sbb1v
         9VRjqdvtE1oC3CLQOPLndzg07cpTwO2pT7RYEJg+1tLfFFklgSYigP0u7lfyTuYKpwP1
         kfVQqaCB/zh8azRQbv9aATjIgtAoA8tMPI8Qwic2SHc7BCVFYV23R32obLsJVfE8thzn
         QgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798423; x=1778403223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuzbqSf46naLhH5+skcD+oKWabUFj8WqimsDijuWm78=;
        b=AjRHeGlcW59hwHY6Ac29a4h2rk+9xeKnTEH1ZUHHJB9cv+a/XBDbUBozKzarfMuZWs
         Xdfo/J/a3mWMGRLQdRJELB5nHRqJKD7XL8uG+Fqj8wBAOw0ydDu71RooQQD4d5n1jXE4
         D6cvfKUSgbwATgjp5nwVt2XNORCoYEOU6aAhmEK/DMiUqzG22nOYckw7WH+aynj1ahGz
         0m1hC/TsAoRUwRQ+sfYkyOx1H4mGH4VNNBAPSl0k/Y4RDT976KPe9fIf/91CUF0pBZMQ
         d4ksPuYh+c+h2mBERyS3ofA8AHuAi3MVSD9TGmpgvVUyH6U2GvV+XaYzwf8whb4Nd/UO
         S3GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fD4DAyIlQU6n+L3WEEgltjkCKeNrG2i7ZMdv8+MfrD56YywrkwuvuN4/AvrfqzW4w9D4TvHo/nPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqb/vnzZXocBWJqpWq6jy05Dz2Si+tpZCxUuztsHTn7ePiM0P
	nx8gvmfF5aEoIdq8fzgONp+9pHdYvJEDBZYZJ6dBUzBsuqoUe7jmNUHNs7I61FY8d6JbaEpazP4
	wHU7zHhOmpjDZS3Bn94vHx+LmPZRgbFY=
X-Gm-Gg: AeBDies8Eo6pKzWMnNcd289sxfJzcBAGENODdDoEHydfAFYpFnmw6g8ozun/9Rm1HAj
	jM9PS0anKYy8I8zK9kOkHtlfbMcfntDXYrWWlfAXDxq8EQnPNTvlzSoNffCfGMpp2u4OQRX8vG5
	efymNLUeagEQITxFJreOXPi2K2PxTaIExpiKAwLsB74Awlso9Qz9LYPbi1SIbv94VCAOC5UjtDR
	lwMVTq6OLiaoGMxVjxngHWpEs4bv524P+tVN5hqp6gyQGFw0GXLaQfKHTLCb/3R08RagMrHRhvx
	Y1GrmMbPkaSJt9RacPLfmR51FTdAozwuHAZp+YmhG9xEmU+WUL5pna59nPB7QGu5BZU/M28WjXo
	8IcUlyC4Of3XcpB3/qHH4XpdFRpdsqmGu4CHGfjpffFsaYbnm5ZcQLxpqeldP1QT9Qtdik+XXy+
	OoXShDKbyu6q6rd998vfvZisKeZmrXWF0rY99NfqdUSpKYRMVy
X-Received: by 2002:a05:600c:3f06:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-48a9852cc0bmr90855945e9.4.1777798423150; Sun, 03 May 2026
 01:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502021815.3953423-1-angusg778@gmail.com> <DI8GD8RZU94B.Q3VZJO6EIP3N@gmail.com>
In-Reply-To: <DI8GD8RZU94B.Q3VZJO6EIP3N@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 3 May 2026 10:53:31 +0200
X-Gm-Features: AVHnY4Kx_9zs4n__h8hqrjEXG6h1AeEpvFH-nAh2fqyqyHGXdzMFxFLYPbhHe_A
Message-ID: <CALoEA-xEv9T4tv5fOYEh8ts=3rGOQMsW1ZrHVBbK8TVPuFvGFA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad9834: fix probe error handling and
 comment typo
To: Maxwell Doose <m32285159@gmail.com>
Cc: Angus Gardner <angusg778@gmail.com>, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 May 2026 at 21:54, Maxwell Doose <m32285159@gmail.com> wrote:
>
> Hi Angus,
>
> On Fri May 1, 2026 at 9:18 PM CDT, Angus Gardner <angusg778@gmail.com> wrote:
> > Use dev_err_probe() for the master clock error path instead of open-coding
> > dev_err() + PTR_ERR(), consistent with the avdd regulator error path above
> > it and with the equivalent driver ad9832.c.

I found another dev_err() call in the same function, maybe change this one also?
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/staging/iio/frequency/ad9834.c#L452

> > Simplify the -ENOMEM return after devm_iio_device_alloc() to a direct
> > return rather than bouncing through a local variable.
> >
> > Fix a copy-paste typo in two comments that referred to 'AD9843' instead
> > of the correct chip name 'AD9834'.
> >
> > Signed-off-by: Angus Gardner <angusg778@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9834.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
>
> Patch itself looks good but maybe rephrase subject to say "Use probe
> error handling and fix comment typo" instead? "Fix" seems a bit generic
> for my tastes, and we're not really fixing anything anyways.
>
> I'm not the final authority on naming so its at the discretion of
> either Andy or Jonathan, and maybe Greg. So either way,
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>

You're mixing different logical changes into one patch, therefore it's
harder to review and harder to keep track of the changes after merging
(e.g. running git blame). Instead, you should have a series (named
something like "ad9834: driver cleanup") and three patches under it:
1. simplify -ENOMEM errno return
2. use dev_err_probe()
3. fix typos in comments

-- 
Kind regards

CJD
