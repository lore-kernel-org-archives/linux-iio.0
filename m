Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A83D4105
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657106; cv=pass; b=In7Yw1ka4Li88dXal8zV8dJ9XEhcr2FYedxQAUNL1vyl0Ae9hkix/sVIMM20akP66wJBlRXgA7dTzamXbAtDJPSKraMuaZnLvfF+y6qUbioFJWXouKOHfYUh3BmGHB4ACFvUwfhqgnm1mlf2k+/vNIptQvfdtflQ50I/YdTBrww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657106; c=relaxed/simple;
	bh=XGuG27J3v37ZHxwOAImhqn3ug4/YcO+/2fFHRMOAmAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjhm4SeSYhD1MY+olrsbB41DR7VPnh0vO88cz02q3ImOc5qNqs/Y/X/sZQ6M7VVUo4kP5Ofh9oC8ZNmd1eaetR36u6f0vyC5FsfIMdmuIzK0HzQl6XSVTx4aP1/Dy+8AKaBPZOlQ8wsVF/Xa6pKrY17VbBOyG9EiD9rGew4KoCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzv4lrIa; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzv4lrIa"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so5474697f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 00:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778657103; cv=none;
        d=google.com; s=arc-20240605;
        b=Lhac7bAnZTEDeIPwNpLObcFD5B/4wNgkJtp+VjhZHYSXUb3yqZ5rWeB3LkwtgHadBy
         dDRaU3BzuXDMmnk/S72LlppUPO/awe9e6gRnNnzwTlZmpLrkZ3nNY7hsWK/3fJR8f0MR
         xNISqJtY6nm5hsa4IfgV8OmPwA2knzqzoQOgwVuBkRK6T/fQvg1QkofORowssvh2JtyK
         zD9BIxyDwJtOd2/Q/ywa+ogHDT1g07o4A+AIqAeg7N3tJj+kAzgQyUkz9bdsghUkfW9C
         9MojxlwmeT9wHzYHUJRe2SXT9FAjwSYqp/VbbDeGS7ROJ2rKMIyVtJflanuxSADYRllE
         kGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zw3iy68c6pKhl8mHUbMeoXF91Rwx4b68Iaooq/Otd9g=;
        fh=/bMIbmm1w02rv1unzOkMKGTEylhos9htMwdjlkryaDs=;
        b=PRLvw8Jlg/fdzg//uRNJtN091BXf1eKdJzis1CwyxXiWUqjQFqIjF/2RbbULzEkPXN
         NIyc9SWTGL85sjaXISRUthdXjqNmbtzt2estx4eZEuvkm7bqPjYVvtvg0faRDPD4S5bo
         zc6SjFg5d8JYYQTp71NKo/niT0i0UmH/JD9+54ycz6hUNIuyTS8d28eDoXBsKaw7HxWX
         dtUmVOgCgnwWyEYbjf8uixJ+VzcQ8gJgs/bC47l0Z3zJE4+aoElRKbCfiSPpvNbyFtRN
         BIxWDbpcTxqjmzYIL9qTLJU2+x9MN1p2k/KkMBz0WnimTaHlSXcIwTcNhxb0hzabTBHA
         jQiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778657103; x=1779261903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zw3iy68c6pKhl8mHUbMeoXF91Rwx4b68Iaooq/Otd9g=;
        b=Wzv4lrIanmys5+vhvNtu9bPDPbNUVC3u8hSIAx+jiugmwk1fc08jm9dB6OD1X5P1H1
         QvB6rWRCLykgrF8WppxetquBCpfo1AeAv75skIco8v/FGgyX+0RF+NnRkwMA54zJfS/U
         ug7XjLkmeF+w6n8ZXMbkoaXmO1VlGgY1+ZCJABkEhd1eWx5P4obcvn7XI4gIKdQig2CG
         nGEZvKwaCgUkPD6zPWUZKd6SNFWdaUUukkVB6/302nPBR+H4XpFSE/8IURdCw3YUEg7d
         F/OC9Dkz5rvWOHDJuI4jkwwf5+L7J32Eb3aNOGk/9cWlin7ZtAMNRbFkPsU12n5djGa+
         lX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778657103; x=1779261903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zw3iy68c6pKhl8mHUbMeoXF91Rwx4b68Iaooq/Otd9g=;
        b=avBXTF3KLsTs+rOFQ3FUEILfGpUzc4ZY58duYNDoK9XEORKPiDzJofqn033nYkAjDu
         Y7ONGU51zdU4qjjtoCfHrS4gf9PpiD48DMwex5oBahSgY+kEcUngdMoEBy3MdZLALYJI
         if975q9kh+SA2yXRUln9rrZPO6O4wVgOXmxSRbPXgj8P6l97EdPFXRhCqgLvydys0j8A
         fmw6XxhjOt4Qw1aD+AvY4qC+OIZxOBrsTBSde/bBmPA2vaFF5ROj7qfm/dcec6sO/2C0
         NhCbmKQsb4v0vR28Z4zkbOLcCPyxAZynl1MDBHJFmPQoDRvPk4c0lQ750WrhgtQHY0hr
         6w7w==
X-Forwarded-Encrypted: i=1; AFNElJ+HkQWYKBE2nmX36wHKDJj79dFhlL7cNKSRZxZtZLbTUBwgAOu6zgnTG8K/Ur9gGSjBYxKZ57cLVec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlnSECu2VNOTRjwcCaqDvzrKhBNr/+DyyVd3TOBoPxkjWUB/E
	rAyquNeeFProOx1Ls9d45JKVJRhiouy0uElwwdX2xt+kc64HFsKG9+fpKBcmGIezVLm/7kkrfvv
	TenObg1rGV73ILpwbKOuu5zTCtWojlGQ=
X-Gm-Gg: Acq92OFw8i3jGYLOEzFvmXyHsR0zQXU95KckuOz5YOgdwStxN1Kykhg1e0ZAmsOFbPw
	HWKmLPbC7uY0p/ierG1YthrIIy5HT9pAOBMVyCVCI2qJssuvjEddrJg0OfFRAou6RUa2AUL3B/B
	XNDOmQrWw/mNa34gndm0BCdcfOAKlpnxLos3PSc/JVHa6YsqEsUiTq+k5DQU/x0B0zyatkCAM5G
	ZtWlPCJ8Rx2Or2JGvvnyQGF2T9U/vuLDKzMt5x2/u4cnxDtZ93X5muBvayJkqhduMP3gcAkubY0
	llyGFDdJfqKuE0cXE9ObZaPJz/CyE+1a7HBZzojsCftpzDe2YXhX0jhh4fjWxu2lRvyGQ3Vvk4S
	zCPgauwO+M22+mp3ta2zA0QAtHKoqW9tJGAxBxvA8zca2Vf9+DW2tTndDpa8ivRh5dBlGas+YPs
	0h5i/+Qw==
X-Received: by 2002:a05:6000:1acc:b0:449:fb9e:4b4e with SMTP id
 ffacd0b85a97d-45c584a8680mr2854887f8f.15.1778657102887; Wed, 13 May 2026
 00:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512172538.101383-1-aline.nakazawa@ime.usp.br> <agOJhr9lj6hKnX4q@ashevche-desk.local>
In-Reply-To: <agOJhr9lj6hKnX4q@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 13 May 2026 09:24:52 +0200
X-Gm-Features: AVHnY4JJCa6aFOkAmr2FKSKoLC5iQpEr-jyHm17uZHrqhN37uaRJPCw-4dEk-wI
Message-ID: <CALoEA-z_Ags7_orj1LipkU+_eYZ=zBgiq1=iZXzizm9Th3m8ug@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use guard(mutex) and scoped_guard
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Aline Ayumi Nakazawa <aline.nakazawa@ime.usp.br>, jean-baptiste.maneyrol@tdk.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 22:11, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 12, 2026 at 02:25:14PM -0300, Aline Ayumi Nakazawa wrote:
>
> > Replace manual mutex_lock/unlock calls with guard() and scoped_guard()
> > macros.
>
> ...
>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/property.h>
> > +#include <linux/cleanup.h>
>
> Keep it ordered.
>
> ...
>
> Here I finished my review. We have a flood of the patches from the .usp.br.
> You, folks, have to talk to each other and share and study previous reviews.
> You are repeating same mistakes over and over!
>
> Please, come again when you fix all the problems that were flagged in the
> previous reviews for the usp.br contributions *and beyond*, meaning start
> reviewing others' patches and learn from other reviews.

I wonder if USP has a Linux course where one of the assignments is to send
a patch to the mailing list... Too bad my school didn't offer courses like this.

-- 
Kind regards

CJD
