Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910924679C
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284019; cv=pass; b=Ve/7SSZc9mz+oFNB/+zzjrPcRtgFM0R/UAJqK2RQ8Mwtnftpm3t34E2U3wNlJfr6MGQe2qh0bk/fEdN7UWkAGTqRoTK/ZooQgOFZXyq6aJzEt84VR9kQ6kZ0Z/6RlK84BOGhMjdeHXQ2DsYVTi1x4HvWBB15aibMsDS9S+F/iRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284019; c=relaxed/simple;
	bh=GHRsiwa6Afk+mfpRVU7jC962/tYubtntCt+0odS/xks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyXyTb24jOYn6cHnYfQhrWyeMxE0mYWVDdq40lFOmIzou1dysgP5ELjyKnYP0nSYLqC5uUlEUAIkxV4oVHRI4g+l6g51vgnBt5nWZ2Y5lETuW4gzXe54B9BRsKHHWiNcRx0YA/Qow9UEjjwWjF/sVhLVoAPHnA/iUG6T0UbA3NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmDPWMW7; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmDPWMW7"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so6175471f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 03:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777284016; cv=none;
        d=google.com; s=arc-20240605;
        b=erdX3KSNFHje06i8A7ZuF4eN8iDrHQru0url2PuvEbUpoL+G9wZhxkM1PCRzymJ794
         qJ1AqJoLU4TUcwOVdaHeeg6p6XJ58jYq9truAsRuAsnIgmQZjt1Yz/edwLvxcxPivXtg
         sHHfJP6Ac2wgnZzV1s41Tm4ooJEayScAjtk4oUqDPs4QSW5Ikvev32LWszJy7Pk1wpXr
         a27NbD7MncNbe537mlCNFLZ8Jr+7DjWGm8iWey1/vFqJMAwN+EuROOeMwa1wRGgu2Uwz
         VIIolO61tY5cA9+YTqaEzxCweAJX4vCtZYxK/A/A5tybYFr+879KrI4jHuwSfnbCcRQt
         Zang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eWeO98Nt9yPBFV9mUTW4xZfhM/Yh8rc/7tXj3PKgVVc=;
        fh=tcOSOmh3gphPbhIU1CBI4NrAbVytGTt0B/CrcsatJX4=;
        b=LH7Zn2aSw3+CjEfFXSecjKfMNF5NyWx5asf6t4yyaVx8NXCHJMOXFtt63CDloanC4J
         vik5MeeQHrsZYeI6MK2zcgeP7xrZhzwsqN7AgZLSc4Rn8wEu9BygCp8tVHfTg9sfI0IB
         ogUfpU8MJtWf9GmAGEfMclYs2RZ2BpD5MGbW4ddjiiW3X32dJXB9VhBCm+bNEChVIjiY
         uQyqc6rnG6YpLLf4iG6diHQ6/jL3+QRx24fFel+OUePr+C7+b0dGLbx1ti9WD7keBNP1
         c9gW6nLMnzcul9iurWCzXlAVFaPzjFWvxCJcaMRit93X0sUJ78XK7PX94ASXmoePuhJ1
         ZhNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284016; x=1777888816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWeO98Nt9yPBFV9mUTW4xZfhM/Yh8rc/7tXj3PKgVVc=;
        b=fmDPWMW75y4hPsJU8S9Y5jiPBBnzmFvSksyYvUbAv8sP/mNTPHlL2A9dQROhHRSYxl
         nSVMvLAQMisMdC58SyXtVXwNzMWz+2Gg8ddTiQcJu9mNucaDtZ5iMBuii2SDwyRdO/LA
         WDmtMhuxfWVxa5Fi1gSWeCgmAtAMSNGCujZPWcRzq4QFURu/g/q4yA9hRuk93IJPT0FS
         NUaOePGGsHTFZIYZ3wvBvDYkPHQVnjW5xGIqjI/JCfpQjDK89sR742SdWYf/BJ/mGMkf
         EUoY48Pfw+aNiv6iaflFe+CpZi2HhODP0UO4iEtgQT3bXl9/po/qX3xpe0olBM1l5gPn
         9wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284016; x=1777888816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWeO98Nt9yPBFV9mUTW4xZfhM/Yh8rc/7tXj3PKgVVc=;
        b=FJ1YdyoM/AVPZLbcMs1kqGeDQ3jzScu8wVtdxr0Afx0uzAvY+Z7dZpXfUfwYfY3HdT
         JMKfhMNz2nghwKFGvG32Q2pjnKN2KDdcqwhL1c9wLVnCmSyQIezaTQvSodN15wPuXoC9
         69H50Ob3xaSoPtLl31FTrECYI557pN7zyQjGX3FjwMb6NX3yQqJfqgAJo702nMlexkyX
         wvBgtUrEFpHzaijy1OD55CRVceHigBwL5HdK8bMcES8ASCf/wt62HgZma1RnJGbKwAJT
         ydWW+b3wHzhNPiUnBTbdn5xK5wtlhGrO/RQk/CvttplhwmlPq2dOiWdbHZuxH3Oc9aJB
         UKFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/giLvFRosICA529jL7r1XFbzlgLP/DGduxRAM9eyndqj+nK01HSnWbc4uBFD3+fzMW3f5lOIHnhT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9W0K5e6CQbkZfsdYA+zFT/cELQOHFzaQrkEJo3ujUickJybwd
	d7DftZdyFuGxrpixVfBp9kd0UwLk6Os0vi2HH3k0KUjcJB/qUSnnGPZ999pdgMKpSvvJ/q5GQhu
	Di5JcA5TzjRV1lYUttR7C1u8cLKg6BGg=
X-Gm-Gg: AeBDietFt0tr5ShWmhKUcPmosCDLfLDVT09cPht2I/HjRm+Fnc5px+aKCN3JneGRVzl
	dXg2UeXHM4XJdcoyYGG+Tv3LiuP4qfin7Gw+/3F/LlXvLDEyByEVmed1okua6x5R/NGqnOq3DXJ
	/GyKTHJ7IcvbvsEI9i0KnmSYsYRvQoDMPTYBd5zIal8Z7cy8FdGMEHpPSvgoK+SAy+Z0N/DCj68
	XVy7YymeLk7wAtDTpGsK4Dk+x8n6Mg9TjQE0/YQWwHep3odHJP/5BfGE/kwizHpMSO1VgjSof71
	Q7fBZT/gMTydEbmQCpDwRWcIoiLDHOhvxSmTdIkMXFaYI3fCwX7AA1bulkl71S1shuw2sC8pLxI
	yGlH+GavUO/7Cl9+ncs6BLrOeYdoHMMZ4zkVjSOAkoEjG6Hn8v2Q5h77+W2wHaytGIFrlGPy/XZ
	1yxvpKaIj3Z3Un1Npi
X-Received: by 2002:a5d:588f:0:b0:43d:1c7a:8b5b with SMTP id
 ffacd0b85a97d-43fe3e11665mr63059205f8f.40.1777284014766; Mon, 27 Apr 2026
 03:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426211834.3318306-1-caiomorais@usp.br> <20260426211834.3318306-2-caiomorais@usp.br>
 <CALoEA-zz-2cG7SJr1iKNQ0H81TVMXLQh3omkxJc9YRW673Kqqw@mail.gmail.com> <ae8xeI8VVUWn6OqQ@ashevche-desk.local>
In-Reply-To: <ae8xeI8VVUWn6OqQ@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 27 Apr 2026 12:00:02 +0200
X-Gm-Features: AVHnY4JjJ-1A0lty0OYBjPLv7IfMOB6XONqilcNpgy-xtOBrXG3SycZpHUetd8M
Message-ID: <CALoEA-zgYuPM667fm4XPcxqbsXkQ8G5t09aj=ZHmsx89UFYKSw@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: xilinx-xadc: remove unnecessary includes
 and add missing ones
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Caio Morais <caiomorais@usp.br>, andy@kernel.org, dlechner@baylibre.com, 
	jic23@kernel.org, michal.simek@amd.com, nuno.sa@analog.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 11:50, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> Dunno if it's your first review (congrats in that case!), but I fully agree with.

Yes, this is my first review :)

> We do not accept patches with the empty commit message bodies.
> (*Yes, it used to be okay twenty ears ago, but now.)

I maybe also take issue with the fact that the series (although they are
the same logical change) is composed of changes in different iio
subsystems (adc, buffer and common). Shouldn't these be sent
separately?

-- 
Kind regards

CJD
