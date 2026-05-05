Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B4448BD5C
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000724; cv=pass; b=CsdUNRuoaqkBih25dIBV2FDBv3WuuKlq45z0ueyPISotH2eD3Jt4bddZkcEdTvaLF3cfY4cNSqeUtw2EyWPvBiX9JRfkphoOmrRGqx7CREEdS4CwKr0mCrC6V3s1MROM/fKYcsQ2GIxvYsjwTfZabFA1Z/SwxAxK3Bhs+85hgCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000724; c=relaxed/simple;
	bh=umLHefmqfWv1YPQmxlC+5usBAdKC+vjQhm5P70dwzFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyvRGry/O0Q0Pg6e9w1T7y7l9A7CF3bi3R8mOCdjT9OD4KKi6AALdLoV1rXZliHzx+TyLDgfN4iO0K1FfnnJOz+sCxhVsCZwDBaHkSvb06sloFksWmKCTho8X/FkQWijf6r8DyaxBKKYSClD/sMWYy1/SlsKnuONwMniKFfriM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loWtqzbl; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loWtqzbl"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so51917937b3.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778000722; cv=none;
        d=google.com; s=arc-20240605;
        b=TCh+UDoajN1eXFiEDq2rtgtTloKnvd15SY4A6fycuiVrWWRyIQtOdfPg8R6ogZUt7c
         qOJ3Zr79Ncd5gz7F5L3gPlghl+b+ZHIh/kfQZnf0KWlM4cq/+Fw9fZLaEA9isXRS9fqB
         vhrJwdTI6KrjCXkcQuN4EOi1h2GRpaLAziizYS58JQM2RvGh9CmNTyv2gHtavma8wK6t
         GI4qchyBK9ZvULOp0aY19GYy/lDr0fRgAOqiGlg7iAVIBIq3/8tmXrUTxCIKJHLzUb/4
         yADhz6r1etXFnbO63c+HJQbZUglRWL6DpAJI44krXHlQJSid3xF9OvoSAQ3GsvVSeHHe
         8T4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=umLHefmqfWv1YPQmxlC+5usBAdKC+vjQhm5P70dwzFw=;
        fh=FHyZ0aw8u9dB6O+Rg1S1AhRjXVDcAMsg47pJc+xDal8=;
        b=NL5LySMcrK/C2+5X8/94YXrfYbpM3MhLUkxIfb5x2Mg7c9JtVD2G/nDeQSgbwgtOLq
         NptJV9fE9YSuPDtSSMAJsJTdOaP8tce12X4BrE0j3gp27lq7J8jj0nzlryieG/98b1A+
         s962LhuTnPC0Ff6IQhg5P4/oy9QHVEIeyi4+fz9EyKfoBKJq7nYuc8N4CilgFEWRg2di
         ZvSFXgkYaibA44lNMox6OJZeu6wM/Qq+b9hnn3OUxXvEHYqlj6KmOP1cg7H+0Ax2WqFl
         36BdSV+MtgHFrbg9x3HC6E8gL50WuLVJ2lLNo5Q47rQrvC2g7CS5Bq66iKeOWJJVsign
         CvBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778000722; x=1778605522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umLHefmqfWv1YPQmxlC+5usBAdKC+vjQhm5P70dwzFw=;
        b=loWtqzblpewjEKYUf4cpJLKe6SA+h03xnPtWxLOKsYU/4sHmFw+m9sflgkp3CFzjQO
         31X68MwLm/cIN3ikb5Vg1NuFrYfba1eynKy3CJb1alYO3dLB7ncG7DQWCvbpbGZXv79Y
         IT689NdkPSdfiqhsW8gQXB4iYZGoenJAU4Qf92YTKqkiGnJxQl+0bfxylbDdv6JYSOXc
         AdQBXAACArz7n5NpDx/D6u8aROH5eHFoKRIXssnxeM/RCnCzEf3mx+vcyvvm0/eOxgKs
         ow/Tt4+FL5LE5rV5Owg20P4VrQNcPvXw6L/3nB8zPC9n8sGJ/Rlqf0mnQ3+mm4DpFy0K
         IM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000722; x=1778605522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umLHefmqfWv1YPQmxlC+5usBAdKC+vjQhm5P70dwzFw=;
        b=lFxtP3ipkCa0lr2fUQplyapEVwF3hlylXMDZBf1LzqyvXeyE8T87efpkBNtS42zzxG
         9c/qYA7exP40cyBwDUCR6NeZH3P9/cx0QqYoyYmUAaHutc2R5WUjw1xB9pBE8MYwlm0P
         rVnm+1Cgdo7xajd4zifvJF9uwtK9wD1ALpuh0ym7SPzlIajfTyBe2ju3eErj6TmE3DKQ
         rPNw7/UYjUQnZLqAoIssXp56rP8IBcLle0IF+auLKrGbcx/qOA2XZa/zMMw4rq3HBse7
         bzeWrS+SwjEuXrrQMIrGBMGT30H54+6NLefpN+1AXDeESSyb9zpC/QkHPj2ILTmWytCF
         k3TQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qJV7Z4QPRoqL9C5jNRq5ajL0c0gqHr0pP6hZ2ZaLrs+lIH9UCDbEVEOS2LZxnQlynsRwtBdtwBew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Bvfh/t26kFeYAns7qWndC0aVEs5Tx25Y8WrjhZE/Sn2zeEC+
	Bmo3FP97VaxnJoNjKefHk0wrYRuZ2kD5usUNkq80ALK5mDEgl/rUxJXfgzFJVnys5HR2KQ9yTOj
	G7XtwZjrTa5ajV/X4Y63pKPBcpJtUOfk=
X-Gm-Gg: AeBDievTZGpuXpBWrfBceYR6b2p05pcgwX6NomJUD1foZdTB2mABIAewK21VH3cUvwt
	U88ZDe0ZPWhg05Ur8dXW4+U2DP9wWmsrqTXr6s9zRmAAVSwEsAKzplGLHMJdF3ZrTaJPuLPNrK2
	tRYOrJabGH6KKL5ecLrvNZtUVQZsq6h698ul237tWnJdV4OoO6Pb7ExwogwIxhPBcBjRgH2zHwm
	vLXGsjKk3+qqq2mBcRvxnnLSzyMwwA+MBtZLqXNwvL5HkOB+BQThNOm+1HsUE0Zcg9KzuI14WmZ
	1t7JWT/S0BgcLqATsK4D
X-Received: by 2002:a05:690c:e3c1:b0:7b3:9175:30c5 with SMTP id
 00721157ae682-7bd7712793amr166068497b3.35.1778000721803; Tue, 05 May 2026
 10:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430124148.11572-1-m32285159@gmail.com> <afNR1Apx86FeAcKd@ashevche-desk.local>
 <CAKqfh0FrKeAL7+guUMmsvm3EkjFZjEUXQUMHk=x9adU+ZWv1eQ@mail.gmail.com> <20260505134538.73b5fec5@jic23-huawei>
In-Reply-To: <20260505134538.73b5fec5@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 12:05:11 -0500
X-Gm-Features: AVHnY4ILC9vKjEih9g8DrI2dV_2_uEFic3wwXg4nvUX7pzv_WoHIlF6PwP1H6mE
Message-ID: <CAKqfh0FNGsudG4B_VOv0nVa8qjZe03tzBEFkeebr-VY84syh6g@mail.gmail.com>
Subject: Re: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, songqiang1304521@gmail.com, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 7:45=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> Applied to the testing branch of iio.git with that tweak.
>
> Thanks,
>
> Jonathan
>

Hey Jonathan, I just noticed that I made a mistake in the commit
message, it says "Add new helper-wrapper function
rm3100_guarded_regmap_bulk_read()..." when it really should be "Add
new helper-wrapper function rm3100_regmap_bulk_read_locked()..." I'm
unfortunately not in a position to fix it myself since I'm away, but I
just wanted to point it out so it could be fixed.

best regards,
max
