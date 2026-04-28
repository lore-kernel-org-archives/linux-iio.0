Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351335B137
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403387; cv=pass; b=fhT42GS3MHrwHIB1tR3QR6cKkq4EGJBxAGxp7KRRRTzkopGPM5aoxAjN7BpRMiFnpVjXfsN7KDv0R+/tdgDfvuWLSnsBXI22dcAGyV5DZvZ4eL9UAACkAuQbHDtXc3MA+pciJt2nCwiWRq3UnQn+tOB1BFDk/ukqVzbNKFWJB44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403387; c=relaxed/simple;
	bh=KXLmTtMN7WSGAsaO66/LbcxMgrs/NIrZZ/tdJm75EC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXmV7YGtW3fjB7EczvGEpVmWbeWtzumptS9hiNjUEttEzuYJSSED8mUFZ9pukWBaYl4XS5GG84ek3TGbKeTEyqzz4f5NRm5V9SuwQZvDNqKiG9aUWtNQRWwH3WDuIUagkl9CY3MDC7wSnYeqROHJ7Llecjw+PrsG1XMgYon/kdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAKooZLZ; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAKooZLZ"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64937edbc9eso10405298d50.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 12:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777403385; cv=none;
        d=google.com; s=arc-20240605;
        b=MqYCScAjzw0bVbCgqn/2QL73ghPMh0GifQCAe7BgCDdWjjsNYA6mepaTn64b/Z7ack
         S4sTvtUBX+DloVivBd1H3/bgNTxvki+yh7IfAZ076YpAXnHsIXuPV4OjgvlvSfle1WrA
         d/uDCWcAuOrm6qAjNgC1SGUY0OY+oSGzZmnz36s+qB0gxtbG45147xD6L1OnNbr83PqC
         EWgdLBtkIhxK8FyiG/4aocFI4duv7+qjIkBEo6l8uejDC1BkBz3S6rKDlO3M/+srGdSg
         lYh8hPf4ZmOR9vsokszHEx8RczrNqHwNHvHJSqoD3tjn/RPdhXltL0rWKCsDPequ8q9a
         nwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BduNbugcs0FpPZxFySHRz7RD5LWTZdKWSdnkPgt6CG8=;
        fh=/qndgPBbGKq6b7a8G7oHgnaD+ZIqbx7kl/47zKC8yv0=;
        b=SmNE4/WxcIM6E+TiojfaGK5yQd49Bdam3a5CiQcubg6Wu7JH+FsPq4z/yfIQmN6BMa
         SgGvi3Wm8tSNoJUyDzCovGOOy5jqYp1RBULFIp8yXunMvVb0Fc1xH30Pw9eBIB4LZ6mZ
         NKa+Eya+ptV5lVNF+MYmeKO5gmMYXYy8h9/J/IKydFWE2szvr7S05VUTPycaY4BlMwMI
         a+cRUVFe4nr8xQWqfJgt6j1BSV0ic5tZe3y5StVvWpIhHmkZ9wgWGCLfge2kTkjeTWER
         kP4YAsBFBef+1pm7ezkpppjJ432A/4IkgLORzLdiLfM0Xsy7Hk2CMPErjh9gdKRxwwpz
         t78g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777403385; x=1778008185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BduNbugcs0FpPZxFySHRz7RD5LWTZdKWSdnkPgt6CG8=;
        b=QAKooZLZTcIuGav5SCYbEatJ1jG0qRPxuAAbPzg9D0bVjty3o2blXO8H7vHedlwRmt
         TqPT77nWFIrLr/QQcxzjAIHkGMC+i+jHeAcwLjed8kPB41lpJjc8bBfiqsjXlH40Z+G8
         qJpJGDJHrC2YcdUzXEEJZhec0Yly3BnK9rS8w2pbSe8MnsXw7H1NzWi8zWMSN5S+bTUD
         ky93lstGVvdZ77DCDEJdDy/eFSJ0JMs0cmRHuvqjqZHZ0rlh0gWVPsMmLaULDGO15614
         qKhlBcHJh9x9UaT6NfKFE6Uu/xCmNi024UD5M7z1hJEHWXaR1QkbBl1YqbNztymPZDUJ
         BdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777403385; x=1778008185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BduNbugcs0FpPZxFySHRz7RD5LWTZdKWSdnkPgt6CG8=;
        b=oIDzTQn7tovnCVXktpHVWC7bhHg4AYTL/2XDVeZeu+TTEyibU13RdJYdvZk91Iz+Js
         qRYKpqO8f/BkG6b0oUCZqhHWodzvCITzgOIS3NNXfXFCHeerkE5V/Zjy8dHQqAfm0gpW
         VHYKEP14jgRm3Vc26d0j8HM9s0PzX6d0HHIgnObLpo06PqSVZtLZrug8KUDg9sft0+JR
         Ay2++q65DU+f5mCuZ/Fz056woYrBV5Z3B5RZCDJdfshovrrMAm+4M7RxLqSkZLmhhMch
         3HxEEm2lp00RFvqvx2uXM/bj3gFddDOa2p9VN0SK+0LI8oZGvmyp/qDrIKczsLDxGEfB
         Rlgw==
X-Forwarded-Encrypted: i=1; AFNElJ8KivRhwixK+jdl0/6Hj2+K7HhSpIW7TzIiy7hOppDd8rKPiEvsepUmBobORmBoEnrAQaN6EotKRxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tMG3psSGEtPyv6ZPqPaDER8nTus0nmaUOjjRNWe0VOEVJC2L
	0IBa/6JFFXtSTmgUJqyOnw1LsuXkGgAEyx260Desw44bfuasS+rPBVXsKVeChfapq7w36reox/k
	5bTF3CbVBOa5l6q53mIDpeO6XzfavfG/bew==
X-Gm-Gg: AeBDietcwWMiqho791aL3rhuf6SymGSb/TIUS0a7C81o7YXfMv3nk/xoLNx7R9kgoLj
	Rh88eM0XbaZjMWF/6FpTBSJFX2U3GdrOwnyHhGYuei4fY8j34ncOwevKpB8094fls4ja+hg7ISJ
	M20M1twpSSDNfsFPMR/24653RucQWfxJ2EPBmcKAaXIwec3pfJCFUbPNctLwRx37yGigaDpEfpo
	wx/7eF7RtPY+qwfbuksfShonaEAuRwq0N9eVl3RIx0y6qz/sZt2rlBDZ5sR4hLszkFY+rZJZ6PE
	0Mgjs1HGF4VL1D/YJHNu
X-Received: by 2002:a05:690c:e3ed:b0:7b8:4438:f005 with SMTP id
 00721157ae682-7bcf547ee4amr43834247b3.23.1777403385116; Tue, 28 Apr 2026
 12:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428124644.49707-1-m32285159@gmail.com> <20260428124644.49707-5-m32285159@gmail.com>
 <20260428163247.4511aa5b@jic23-huawei> <CAKqfh0HbPJN-L9ji9=Oq=g0UnEk0FES8iQE_mfTpyXdcB5j0Jw@mail.gmail.com>
 <20260428183935.29af0f41@jic23-huawei>
In-Reply-To: <20260428183935.29af0f41@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 28 Apr 2026 14:09:33 -0500
X-Gm-Features: AVHnY4K7SZDfN1brSXK5kjT5borxMXDs4WzBls7_YUUucpnbzoWSOB2DJYhpbKg
Message-ID: <CAKqfh0F0mKyxw+=ht_X5m+w77STBmmtcqdKy7dtsebaFbOjm=g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_trigger_handler()
To: Jonathan Cameron <jic23@kernel.org>
Cc: songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 12:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> I'd prefer a helper function with straight forward guard() + returns.
> Then you can have a single exit point from the outer function.
>
> ret =3D helper()
> if (ret)
>         return ret;
>
> other stuff.
>

Sounds like a great idea, I'm eager to start when I've got time.

best regards,
maxwell
