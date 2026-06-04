Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91939A04A
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557765; cv=pass; b=mUQbIRqCS89opFYiDJHKnltvtp6v9S27RyC0tQLWA5FK9HN1/w90eJPQKPTapcKBK8rLk/rfJ4/F04eenoXi6cdUuhl831Q3L8QWdzFu8C2oiOgPuRydJmcrivXO4riAOptn8q+sci0jqbthS7Y54ztFuR6tWpCVJgQB8Gd47Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557765; c=relaxed/simple;
	bh=yLGOc0YfV47KnXxnjIX3aT37t7ENrin7/h3VNhPrvEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZgJdsLaMUF3/3bdc3QxdRcLpY+GcWgQUSWOEKk4Dip3gSR6DzYeJpDJiDkWmULIof7nOH8tpCxaPb1IZ3wNcNJsxasjw2kwtKUPcXv4BUzdrOt+vEJfWICPTFT6oPeTuMHmYeLE3+Vbih8u0XCDYxvj6edDPSJsec28PYoOubk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk+4tPTC; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk+4tPTC"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-46019b190b6so255531f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 00:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780557762; cv=none;
        d=google.com; s=arc-20240605;
        b=C1AYK4C6iFqRqKwkPWAw4VU6dSVyurj7vIT/vyNCcGZh02KqMjStkCkdeXf0hEQIbL
         4gsf+ZMMjZtveF9LnIA1+U0U9jilmjKoeKbygedj6e5pRCpg2rvvpa8azSREWZ5ji0F6
         3UPQVkjhNe+T6DXSBx/mqkSRamxWyLrlzrV/Qqlv40w+R979LUb6oP4Xct0o8LkRK1qx
         DPXCmuIaHlFfzg365Gr7bw/UMjoOIh67eXEUXGJQaUOu63ocA9O4KDA8wcwd8JFuBCxq
         rKS3UM0m79o+6KwQkQhUutWmSSrEwvRKwAB/ahLxXTH0WSgzg2Dzob/FcnA/dgRSdNGK
         7cKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ehMvI31xrhVyS0ToRfASjvvmMFuwyXUwfnIilDd8ZzM=;
        fh=C6W+lQm0bPzzzrh42cAgm5MQMSkwmUw/Nuk48ll26/I=;
        b=ZHUAbWkTFUHXEpkD6rYzW/Z0qS2ZI9YB96nYONcJVVKmZDR25xfOApEAAWu0phV4hX
         vOPfcxSDNHF/lN5ai6k74teFZgEcSgdjRvYWb09PPwDn/u12ZPPIiPBTFZ1b9eIB4kz5
         q79980fRJt8msdoZepfWW20CB4EfYv8/R6m+bm00obWYb1gJSjVBguyyvTk24kxjivE8
         +S8MTRdoNzEdRoJVObhT7omGgbyyPGyCHoY2UfygsAk7SZsQZ7ODWPfXFlV2MCwCT/19
         CV+b0fszr1nzZCbQqYYRwlf3oG1rqLJHptibyLHLHks7VbSRqTDmuCceF5dWYep8gHxT
         RDZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780557762; x=1781162562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehMvI31xrhVyS0ToRfASjvvmMFuwyXUwfnIilDd8ZzM=;
        b=Kk+4tPTCtkTARgrM6MoZSQg7u9/R/z6ogtwjXmUD7kF/L8F1ObWic9z4mKuj0jkpkT
         rfwO0GH/X6MrXwR+GDo4OrWCIFw/wD+XyVG5aqNAxyvuREObrmFMI9odBxJTbMFtxXvE
         jmhUZYLJPjsN1wRTTXEeh2kT88BgoV97emTuUc/KTkgEgQ/50BXRncMC+qE9eyRbMXx5
         gYXyBPibe4nmWsVz+/tEARg8i9i+qS/x1ArTtZbLIZiSfDRyBknagHJvQSTfrona6cuv
         EfQulUDfTSZEjTN3OTZZADEnPTKVBi33xVCJKyU9VA5B9aVdJnwfzSpQb63av0dkfF8c
         fjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557762; x=1781162562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehMvI31xrhVyS0ToRfASjvvmMFuwyXUwfnIilDd8ZzM=;
        b=A/F/ppRoYyFAZ7f2Yssmg7BXbrrVe9Y0c3mESrZl7amxEOANrHMjBfyobqMkgpYD+d
         5vL1gVw1riX+cxtyBotBQCB2z+ZebzvqY+EaMheIJERRVtP3sGfRH8D3O/Xmuh9GwqOy
         lgAFLOggt+RaLp4+URzwdky0FhGy8RnDKPrM8UTQRr+J/mWp+jI2zNotTv6LenwMI++/
         yS0x3wJAY7EVoFxT0r6mGCr+rAM0c0tabNOe6ukUymaPtZIyd0Oa5otUqqhlQNY6jxX3
         3MIagJXuP5MwpaSC646HwbcXl7V0CpTAwaXhtDjEYpOT7zmeNNN1hwm78i1X/cCqLDba
         SfPg==
X-Forwarded-Encrypted: i=1; AFNElJ9hWv5vZw5mv2MyowsGvXD9iuhrof33v8/tnaePRQYe9WMhYZw5MjuRRTX7cV20V6WNZ6F4WbSzkl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SF8S1dDoLuxS6aJazkXZo2O1vqvHal4mR/EPvZoPzW7YOR55
	3+u8zDI19f8+2e8FQ6Cvaae+3Lma4Heujeyc+4ViaT458IyQndN5BqX8Fx9wtPruMEHajZo6Nr6
	dMIvYtF/6lxU6g+fEjVkQlnGqBvn03c4=
X-Gm-Gg: Acq92OH3L0eeBswdoTCmDkNog3NZoy+ZPycyrfPMbfkUFtGNlz2nyzwQzemwVmdvEj5
	6zEb8PpRaiHj7lRNQV03OcisCfBGT/uAMjhG06IiEscgtl0FD51nt9Zc2srjgfvqIHp8cqWVU3O
	PLuREBeaMC8zssNqFapf+CCTadl2KShILtv6jZgRa8F1iyaCFQQUrzWkYum084GVdVnGp1wE8+M
	PnCpFvXKJip5W5PeyzpUFtnOC4r/Zj4e+WvhQv5KF5I5eMfZY2jGwnUqRier8oAGhpv3wzne438
	mbZihDkfVXyWS5HpOIrM1hdff/HKeFKJGVdCZ2PFK94M+AxiVi4NmecSOSNuCWNNBImgfwyTULP
	u4o1U6se4dqKif8yyLb3VxFlgYXuN0ccr+2f1916jZsfSqcrsLevP9cu4/NDQ+x3Jf0kV1Hc0Mo
	BBEHuCi2vuP9NQ7RmG
X-Received: by 2002:a05:6000:2408:b0:43f:dfb6:78e1 with SMTP id
 ffacd0b85a97d-460218aaeb3mr10164289f8f.8.1780557762031; Thu, 04 Jun 2026
 00:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604054723.2983181-1-github.com@herrie.org>
 <20260604054723.2983181-2-github.com@herrie.org> <aiEmplRsQnvlacCD@ashevche-desk.local>
In-Reply-To: <aiEmplRsQnvlacCD@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 4 Jun 2026 09:22:31 +0200
X-Gm-Features: AVHnY4IhhVucgZjHrdZqlT5zKM8hfT3LgftvgX8dZoMNqF3Wn5qgRJ4gYTzaHVw
Message-ID: <CALoEA-zeMaou-n3zWU8bvH+Ae_eHdtjjfFkkzkkBtz74+5zcYA@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: light: isl29018: support cover-glass gain
 compensation via DT
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Herman van Hazendonk <github.com@herrie.org>, linux-iio@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, masneyb@onstation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 09:18, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jun 04, 2026 at 07:47:23AM +0200, Herman van Hazendonk wrote:
> > Boards that mount the sensor under a tinted or coated cover glass need
> > to compensate for the optical loss before downstream consumers can map
> > the reading onto a useful lux range. The driver already exposes a
> > runtime knob through in_illuminance0_calibscale, but every user has to
> > re-apply it after every reboot (or rely on a board-specific udev rule),
> > and a power-of-two cover gain like 100x is a hardware constant of the
> > board rather than a policy choice that belongs in userspace.
> >
> > Add an "isil,cover-comp-gain" device-tree property that seeds calibscale
> > at probe, mirroring the pattern tsl2563.c already uses for the same
> > class of problem (amstaos,cover-comp-gain). The default stays 1 so
> > existing systems are unaffected, and userspace can still re-tune via
> > the sysfs attribute afterwards.
>
> Haven't DT schema patches needed to go separately?

Yes, with the correct subject line/commit message title as well.
(e.g. dt-bindings: iio: light: isl29018: add support cover gain comp)

-- 
Kind regards

CJD
