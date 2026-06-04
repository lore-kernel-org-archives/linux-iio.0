Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71072477E35
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581022; cv=pass; b=bjN9JiZAiWOYJf96MF3pn+qo2EhOWBz9YiBBJtTet/0wT6fgFp1eXgSj0MJPbkBq3tYmHjRAFlLbMSdBZBKCooQ2G8rcV5P/FoLwsgeNiW7xobwTePunKXgFxpv+ePc78bNwgaVgwKqaHPouMk08wK/2gtHgQhZNI6+JKiiYAT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581022; c=relaxed/simple;
	bh=d/5dUNabAsXCDmbP2xfwdAfwW/lDowl9jPw88rwcVFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hU3oWyYBsRu5uogA7xIeoMGCUeQSu119LxS9FFE51oVK4nDijJRvTqK9I6hs/x4XOZDSzTyjLpFdX9YeS0oQfFOvKyJU17aMRjHHp35QtkIHMbjQq3pODYV3Rbvtw+gRt8Dli7ISGdtfv8MnbeyOiOBcGzFr2n5qs74WKR7ayzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeuqTZYL; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeuqTZYL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so621010f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 06:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780581020; cv=none;
        d=google.com; s=arc-20240605;
        b=X7RZiC4ulSe1PUr8sKD1kNFC+cHwiZMoM3mkcIDOWsZXuiyOsQHiWL+XL1FZKh3n/Z
         lBKDarwIHYpxXxrBoYrqq5vnvSbKsAsSmbhVzYgltRSAcXeD8Ny8wR0dUx7vIYPVr3G1
         CHNiq+BUTsqIqN+tL7lYmK1kEvv7GicHj0Ptttu1zWjuQ7ySCAfD+drJZg0ZwQqglGFK
         eGFSWARvfcfU4OfQynN18YG4kzXyPxA/mUT4u8Hex7171A+unGovraAEb5KbrzKI6Orb
         uOvecH9y+IppAKB9ynTeTSEoh7wPo9j4Qag9wMMKB1zyGY3H/wuvO3FVGj/YTBtni7gE
         3zLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d/5dUNabAsXCDmbP2xfwdAfwW/lDowl9jPw88rwcVFA=;
        fh=0czmGqUn5cktjvHS9xUSVueQGa+YVFDbRi1THMUu6Sg=;
        b=jkRAa1PFJCGm5Mjd7Mc+FTlXRixLJKwpXJRRxEx9EU9JIN5CPCLLc68IgHnvmnmCXD
         WX2vKhJY8Ynjl3fLAAgmz6AxQL/xbLxBHH/ks7WUCfozcupm2xtwCrnOX9NyHkV8lApG
         6PPA36wLQ3OCtfplTyBgnfX0PoQ7KhZkYiwZ0xj9O/rOrQlsaaKC4t8bj+SfSrmMzlPV
         Ar+m/0pSgYfKW/wy5cp74vIeA+zJoy3Icgxxk0ETB+BU10kXUvcvsd70y4c2sQniLaqG
         DuS2oPI2hH/tTEHNn2ZhMvkQ0Kz2zrYulufzhapc34AjqMr5j8t/vp79CYtiG823A2nO
         S9+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581020; x=1781185820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d/5dUNabAsXCDmbP2xfwdAfwW/lDowl9jPw88rwcVFA=;
        b=GeuqTZYLaPnrkf/0xJ8xHKScxn5O3iKDzjkHYVILW9nn+FrHNnNw1FBHSLU3j68nrv
         +Y0xqe5VGZfVqqNDRRSypTdgXQb5HpsJoUk5+OTmDVkRgTijbRPEAx+7ZJmGOmfyKqD3
         f39D3r7H4r4ZEHAO5BUPCx05ZXIBSo9YC2hv5zd12T6BI00I8rkyU0O4vNH5yWaYfKhG
         cjWLsU3zHjLcTPo4gm938iVcmGY8p4HnjkIyJ78HP/U35q4HEw+lEioac+D7F96ftPaB
         WT14+Ew6J84i2djxbxYI1KB38xBwqotOl7RwhOHQq9jwUiWKOMGM5MpxlUtHPFib9cJI
         d6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581020; x=1781185820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/5dUNabAsXCDmbP2xfwdAfwW/lDowl9jPw88rwcVFA=;
        b=SvjxvYo0oMgtJLC6YYzSgVqFKQq2lorVsO/xaw3kGRYrCKyx/mQ9gtjV3y3REcfaDj
         4u9ahWHg9/3jdpbqBFFjBmtpxNdcbMQhhdZqLn36erGQofo8xv6NeW/yOs0xkrZy7bM3
         ijR8vHNE/d8uC35RHDhDvr7+gEfhCHC5qU3JBqpF8CAyFS113sUQ0PpxX/Mr+yc5ftza
         ks/dt9GWpM2LnBed3Xq1aq8h3m8V+BranDXF0FC6loB4YKkLE/djK8lPTBUYSB9hvaKV
         5ba7L0OEZN2Qye0BlKmZPLEb3LKfpbFHUXRYiuQW620IE9KoyTP+nhPh4nq0ZHDsrZIH
         Is4w==
X-Forwarded-Encrypted: i=1; AFNElJ/V10UNPCeAD5UzNpyc3I0zxpWTV1gdETCL7lwCFX62j5WK+szyKct2xJE82DLKXzs5Uav920xru4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CbPrRAok2RwfjPzJCPz3YCFNZCi7ccbYMK9NNgT8H2Kkdokc
	uTbanHbhbMURLUKpsTLpriPmc7GnLoEnzy9qiIgIcr8ZcexltJhNRI31mBcIhJusF/n4uRAAL3G
	8B8FOcPzeLHArxNHQkffLtzpKigbOncs=
X-Gm-Gg: Acq92OFZQg4pfA/9rKEWf+CumY1bHkQwdK4s1IOrikYDLNd3F47eOeQ1w9caH5m6Boy
	we2tUzBvFe6GUF9nV6RoJMVdNKYRfjdHNjRrA+rEfOpdaOwciE2hC9YqT/BZMZXyv+4ZpvkRZa2
	w1IDTKhy6XyMYbpLWUWHGrQdOfJrZiszRD0drTULkYfnwq1ZPecDDtGW+XLxYilsPvgnSjDlGoc
	ACVmtTH5p+sXVW/0IMfIIUR1gPW/mr7ff5F/m1D2X+/nfzfYeTyATFwv/9OTPRrZAz1MftdoBYc
	Ze8yTA7zFNJRcfYvAjs8fDBoO45CqhlAi0SngPqn/fgpC7K5C9ig6o0Ob9lEbBhUiCewPuBsA3n
	evrv5nJlL7VbUjQY5pPhHN95eU7Nd/FokkLOaA70Qn1NtZqQrHHT8szNWPuK+UtrMEmMqwkLF+P
	5cny8GIsjYM3OpsxMT
X-Received: by 2002:a05:6000:2086:b0:460:e00:121b with SMTP id
 ffacd0b85a97d-460218f8df7mr12464602f8f.15.1780581019740; Thu, 04 Jun 2026
 06:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604131518.27323-2-m32285159@gmail.com>
In-Reply-To: <20260604131518.27323-2-m32285159@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 4 Jun 2026 15:50:08 +0200
X-Gm-Features: AVVi8Cc9JuIs9bozMx0mTl7jKsnsKnqsn1yI6f5Rg_vGVdtWO7nBa1Q9Kci0Rb0
Message-ID: <CALoEA-w-HxyVXnfhmw9FRqS-DZkZ4=Twe3h4dpcZ3jj058kZCw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 15:27, Maxwell Doose <m32285159@gmail.com> wrote:
>
> The current code uses mutex_init() instead of devm_mutex_init(), which
> is incorrect as the rest of the file uses the devm automatic resource
> management API. Fix this so that the mutex is set up in the same way as
> the rest of the device data structure.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
