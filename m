Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DF39B94B
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756510; cv=pass; b=BVrOuq+erCBsJ5b8x4uG2ooCLtaiDAfQ7Oz+kyeqPLQw7eoM2KGlVjNnKaDxy6s/LdYRG2z75hFl8S8o+anc5rqDqWxbMwJwfZ4lpcXp9CahlqISEybfUi554YORWWOPfpsRYquwbzul4B5SeclkScmyF+7B5PItwxwtfPuQuzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756510; c=relaxed/simple;
	bh=R8FmuO9ytE7ii9dxdPkU5C9agt3DuPWhWQL1X9mtYmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWQtHUH27V5eFkbBKX5pb6a2u7ptpVQS/3ML8wQVYjbg9vtoTMo/Q+KjXKVYGz7uJlpcokOOfNTLWMJL8CooYeo70SIH3q0WzLLH7B6DgwsyszpNzVYYhvBYcG4Lvm99pNa45xzFKJGXofMZc1qrvsttpAM2ahixQZMYX/WP94A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j07Gsd7A; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j07Gsd7A"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bcc2b199c17so725916566b.3
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 04:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778756508; cv=none;
        d=google.com; s=arc-20240605;
        b=I+HYTTkF0H+6N8V2PGZETnWJgM3T3rVgOxQVOODX9U4rxb9hBke6Fpzm45m2jWIiKU
         TQ0fVFP8GePqKZqYJwyyVSIUaooNXNtTtlja/DncRz18RbKqqtKHZA4CmM7ZHWg0+02Y
         JV+OtmNrNUzkr9ixtA0ZC8z+hrION9zhmAmEoYf83oVVwKd2piI6y7aX7WxOy3XraZEH
         bTuv6LVKxj9ZOf4Q8Y7zCG/1bxdqPn0N9sFIH0ouMX0SjklV+lGHkyBSCquu7pkdJpwx
         5A30PLtC0Q4FqmbXxs3uYwJ2sFjVdETpZuQCLeeyel+qCmvBBkeA1Hz2lEahlQn9FLWB
         XThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R8FmuO9ytE7ii9dxdPkU5C9agt3DuPWhWQL1X9mtYmo=;
        fh=m3iW9RCHIyXbhhDynpEjUtCaDAQ/Yspx7kkdLMT1M8I=;
        b=RbZZwB94n7JONZp56+rhgvILW5mCecZFFpemnpS4JbP+toI5INBlmO2n4wWXATNx4M
         wIZKlqyfcxt/j70kHDmON6c80khVRRpwWVulUUFo9VavhR1r2dLIrKH3YkPCaiKGpasj
         jRkCQnad7YCwEtrTg5HeFBPh8THa5+UaoBVIFhFS6nL9JcW1LYoJ0CEp3iQ7gk5qyjnN
         M2COZON9H+1TTJplU8JnmGgdTYFP86rv3ThYqzHAh8u0ocnXoOjORY1GFN1zsdZ6deWr
         uYghK/6sp2PkoQ895k16/FpgOHcnwVXwxZ1XOFqU9wokuWO7AYj4KKQMyl6gCMXeM8ex
         EHnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778756508; x=1779361308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R8FmuO9ytE7ii9dxdPkU5C9agt3DuPWhWQL1X9mtYmo=;
        b=j07Gsd7A465c8sOgkF45bwFTCUVvYtOU0op1Ff3RJ/PJIlmzYkfOx10wufv5uz0SOS
         lQa/yNQ6fRxuQ6JpdNBkfb/E/AqW2uLqq3YWhhWCvZLwvzrD3NylPW8iAg70fcl2TUNC
         CtpfLCev2T7IsaUAbtTClaOBDy8RyGCRKHIk/SvnYHEis493wSRXT27avw4+pcKXWQki
         33JN2VKcOWDPWIJ0ehPMI5l13pA/czvw7su6Y2OBNhoZxpCPOMI3+DmvcdFol4J8evnH
         eJVzJ/uTzwt6hQrH1xWM6SIlFscxahXykVjIPe8fUdB5TsnTphfXEzoM3lGv+bOnfHhU
         GP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778756508; x=1779361308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8FmuO9ytE7ii9dxdPkU5C9agt3DuPWhWQL1X9mtYmo=;
        b=Kap2PgjZp+v9/nhG6yZGfTfawVyFuF/jfm43u5siUwRCGykKkreB3tJaPmjMbYwu6B
         0PGB1QafwmG/mz392hpK2cW3iRHTuV+dDAGlFceLwb8DvBdgouiawBzZYZAOAmCO8sUr
         1Eh4Sf0YJFJJm/ced767/+GDgiYkgiFSy8ykZxahp7O/DXecoCE8o5tVlYRq4MsDWxXt
         CvvTF2LaZFYy4EbUoMtyZ0YdC4g9/8QCHESkdDpowsV0CsnDHmFjQzaCYcgYcHlriunu
         SHL0ca05JiW1akNdrdbitwXXKTg6i/EtBzm5/qKqckIOIzBjIxwon5ePoxDNAXpzo1NZ
         CaMw==
X-Forwarded-Encrypted: i=1; AFNElJ9TvZAGpTsa6R/ou4ZclCffN7W63sHw9qhQUqkThf4MvFEzlPUcgFnqUGhPNXpG98PvgRjBYIpgLc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzshRKZsemRPYbvLllGGMX8JmNzV7dk54nA87yFd/gR4vxYIcFd
	nEHr8oBXsFxU1xfHHTb42UsQqOBYlsiQhrEssQ5SXYftAny8blR+fwrRwTiF3RmC73oitugrQ52
	i6tym87n/Qv1V1cEzdRI2tYi4AxNcXxY=
X-Gm-Gg: Acq92OEGmZ9f+v7csAGrCd7w9+NMXPVQFZk6FqiNFIK5vCAGu9bPzlxe9K2Zvre7DcM
	kxGcWyaOMO2HGqiMkdaUM+BpidMragYYbaVViEZzrHdCkp+ZeEGnK4q/Z3OZRXzKwwtJ1XGnHrR
	rFs5R7wMO2Jhk2ZlnPlftE7Ias6PVYD7aXT52fqIIVc5y0mRTtCMVLBWEEdX7VAc+f8nfihK9KT
	H1zFSx/1lSL+++lsWKAm6Blijt15erGg6YFAEedbR17qUQ/sPEhP0/hyAqde+Q7Z9Eo5HHoIJ6M
	x16twjP80KNPzRhcxBUka89CmBivkh7O3GAlEf5917CcdxgU67qSq7D9QonVJ7wopKDd4GTnJJ3
	3+tPbMuwz4ly/rZMzmKmAUzmhOq1iJ8sHPlXQ01yiBhNJneWrT52GBpA1xDkFSwe0f6s8L9sHX5
	v83zJWnA==
X-Received: by 2002:a17:906:4790:b0:bd1:ba58:17ae with SMTP id
 a640c23a62f3a-bd3e2eb962amr461411666b.43.1778756507200; Thu, 14 May 2026
 04:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com>
In-Reply-To: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 14 May 2026 13:01:35 +0200
X-Gm-Features: AVHnY4LlRUsfL0Fm8kkHF7WQTlEZOXvMse9kaAAxyMARFOjw0tXhQ-j2YVKGiTE
Message-ID: <CALoEA-zd_hBEK=tjqKmtZvpwoEhDWKW2a9ZN-Ltu1r09Y7zMbg@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: ensure device is awake for
 buffered capture
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 May 2026 at 16:35, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Currently, the ak8975_start_read_axis() can be called while the device
> is autosuspended, causing two issues:
>
> 1. I2C transfers in the aforementioned function will fail or timeout
> because ak8975_runtime_suspend() disables the device regulators.
> 2. Since ak8975_fill_buffer() does not hold runtime references,
> ak8975_runtime_suspend() can run concurrently, and since PM callbacks
> do not use a locking mechanism, it may cause a race accessing the
> control register via the I2C bus.
>
> Fix this issue by adding struct iio_buffer_setup_ops that contains
> preenable and postdisable functions to ensure correct that device is
> powered on when running a buffered capture.
>
> Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6%40gmail.com
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

FYI, Sashiko reported an additional issue concerning the leaking
of uninitialized kernel stack memory.

https://sashiko.dev/#/patchset/20260513-ak8975-fix-v1-1-104ea605dd54%40gmail.com
