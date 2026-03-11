Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9BB38D018
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260677; cv=pass; b=cct50n4THqGBFcwyuXTNuDeUdKxjfk7dnXus7Oe5u0XBLuTXsw9+Enw04YLyZhPAUjJOs+0gzP3cNGYkNqjKm8lIxgRb7ri6KMYPc3+QtULfKTVHZLxWw1iLdNyoipVk6hW/IwtMkRmqiP0ifEWZQmMwRQVJ/3GC4wI23okrFKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260677; c=relaxed/simple;
	bh=4OjedLiimJy5IdiZtoxq990M6IlujjzSG8lg3IHIZ7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA6AD5uhocDlNmW/MSRoXUNEfTmw5rUZqFFJMiAdyT08CoKwRveJD+afFy0quLDDneXycoMowJj7Ok1n2d6tmJB3bouxqaf+sPX4ZjUb1ZkZ8i+ypFUykOeHzgUdKR68AOuJwlbcgMN3lHZvmnvxTx8KiByQu60iY+a/P6smAHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU5r8jIC; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU5r8jIC"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b96e9c59339so34297166b.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 13:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773260675; cv=none;
        d=google.com; s=arc-20240605;
        b=Xgr55i4mbH+zSUX/ZnQQXVo9Jjd+iUC1iLPmHgKBrFG+UgbzD3ARtplxo2ZyJj0Fz0
         1ZHwKapPSW5XxGAnpoHOvarpPBxeOoUAlThKpjtj9/wGvNZPaufZ4II6X5YqHFSSIw0r
         VZabecGhPcCLc1CC6955WgU8ggWEkUIze/KWOi3EvssH1xc8wq2zHe5gTcg61Ve0iRf3
         TNRyIAYyGyC+IW8uE8vVgvAVbXEiFp5pPt5Dqth4ehi21VbNR8iy4T9VHkA6QMH4rBHE
         aR6gSUVdIVpxF8zAQ9Z4UTj74rvVQethMGSBd03miTY2iLD4JbNrzUPtjmCj8XiqdWYs
         Ms6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4OjedLiimJy5IdiZtoxq990M6IlujjzSG8lg3IHIZ7I=;
        fh=MHx9rFdsCwDG1S0MylwlvxTzZDCTQzjKYkovc0uWphk=;
        b=Iq6P8RMn6f5Pn2W1+ZmX4eDJt1yGqrqIPHXj889io1NbDe4DR+3uTU1BX8GlzBwlU9
         kB1nWhLpNlfHq/NkdRtaTCeOAYFWODCHr8+GEq4aNhceO92xf8OuZBZuZpESB+70r/Rc
         +ScqKj1iBibRqiI3DJQBQJy82u8kz3+VVo811upGg8nAuBte8DwfsYGd83BLm1GTcfmu
         EfN6XEG+wCiToI+1R9mFMuo3cHJ1f9mzUrz71Yypk4XsfR4zvk00mQ15EcDQuVNLJWE0
         Z3yp9zZov4yORp8MvxCM0Ap7c+V/R2Rkd+rtezvQHhvQ0SYgYgWA1WClfeyX4DeYVSd8
         6u2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260675; x=1773865475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OjedLiimJy5IdiZtoxq990M6IlujjzSG8lg3IHIZ7I=;
        b=EU5r8jICAgHGeSNIz7rK619KWLeIuUYr5tAGE0LOkaZ6RQV908hZ/oyQ5Iy7WxlmZM
         H4+RimEJmJZGTze7gFXjYmrfgql0alFfPIaPXhKDe+ZD2xQQtdcFXUR7gLrWR3FDbHQt
         GWh7FmiMXRquCeqHkNeKZPhSFj8uu9UiYoorVX1olNAkK4Ha6nxQmnaDIUbN5Mm8doVW
         QZTeaOEqAvP9Q4bin6wPb1+8qzObt3FNLX0cDOke2DSaiIhPeNNhviPscPtnxytLdG1O
         Up9Xh8xkmZKdEcCQ/VJOPpBMbS+XTE+aCkWUWRHtBJK7hJuw6LBsZ7W+FItRkeYMyF8g
         x6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260675; x=1773865475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4OjedLiimJy5IdiZtoxq990M6IlujjzSG8lg3IHIZ7I=;
        b=YqjccsNRJXo3NuQSR+SiBpEZDiZ7/wzh4uN8QEeRWNu7kMwy/wFPErpoay+bVvoC4q
         u6EfxMld4XPVMTqZwlhzKR0wkUzSUGELhpQUYV4iJ+KpVHEMR96zy4yMhohzVnEdnwvp
         QYzzIs6VlPC16xKhO/j0Ilsma2gX0npC+to/qUHyTrP+zIqiOJT7HGpxGdvzsTWgwewY
         OSXEFWXzIOggmRTWCQsZGej5Tk+/08IM7afgYxLoUUs7ljU71OuQaxbr7mWN/nWZIQZo
         ddCKoNGhcXOPqz9KtszLJlUftHd7hssMKK0Nukkz9bkMOBEHWNcZaJ8dINF4pZETdJKQ
         psbA==
X-Forwarded-Encrypted: i=1; AJvYcCUgToi09v3TYVRvaubt4Il3XOCohTAEr/3/lqTugqkrCCcuaTmkwkKkzc8M71NoCQrz4e9PXrbDjKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9P/M9ktb4JcoCmSYZ7i942v9kpyNE9miaTdCaRg04EYRwVPrF
	325eRuj38E6FpcfR4+EIWppJ40Hk78pTv24GNuRvxKNBjI2SweJkaVLWPSEp05pZ2e0UE3XUKtE
	DVe00ULm0By2Nn49TtPjqfMgpK++2U70=
X-Gm-Gg: ATEYQzzbevXAaCBQYdMOeNTWW7YUllK1QB0XkuQQbkv7veFVglHa2kd+tCHGaG1PoWB
	FF3Uo5nAhY2TGXcsI7vhnjuj32EDYL7i09TM4pBnw+6zNdzZSyycyFkdfxBHL70htq7VlkCdfHV
	s+r6aGuD9KZsXnINU76zF+S5bSOrecjgteGmqWEfGKKoVt6MNQVJz1t1aPAzIyYBkcDIAt4SW2u
	rj2L+w6Lqny06I3x7BHVzc/E1wgNQA9jr+ry0EwWD/1iDd0zVSGzWmiyczN5p6C5UtoC4ptxCSa
	CoeHvajLzcwu45IdGfSbNDV9FgaQY50LFHociHpiI8lMTeKznIVn0tJ7r/TSW7mYgNSbXZ3JoKs
	09htgaF9P9fMRpOIJRw==
X-Received: by 2002:a17:907:980b:b0:b88:5b21:b162 with SMTP id
 a640c23a62f3a-b972e50bb3emr213698766b.28.1773260674602; Wed, 11 Mar 2026
 13:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311174151.3441429-1-sanjayembedded@gmail.com>
In-Reply-To: <20260311174151.3441429-1-sanjayembedded@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Mar 2026 22:23:56 +0200
X-Gm-Features: AaiRm507WZHiF1s3YpvyBPrYLPJbDIpKOTrfvjgdRqhXsOMbq6LkY2AsOBU2pf8
Message-ID: <CAHp75VcDyjKUy7PGnxhUeyFXWndrZt7ZWZG2J37ypCEJHm7zzw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: ssp_sensors: simplify cleanup using __free
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:41=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Replace manual cleanup logic with __free attribute from cleanup.h. This
> removes explicit kfree() calls and simplifies the error handling paths.
>
> No functional change intended for kmalloc().

> ---
> Changes in v2:
> - split series to individual patch
> - address review comment from Andy Shevchenko
> - Link to v1 https://lore.kernel.org/all/20260310200513.2162018-3-sanjaye=
mbedded@gmail.com/

Yeah, but what about other comments?

First of all, consider using guard()() and friends as a prerequisite
to this change. Second, look at the code for the absence of goto:s out
of the scoped blocks. Third, does this driver use some buffer in the
existing structure like ST drivers? Perhaps the same approach can be
applied?


--
With Best Regards,
Andy Shevchenko
