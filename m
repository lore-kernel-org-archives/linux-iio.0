Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B01C84BC
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646977; cv=none; b=M21E0Fg+UkoFM1HG0t7GszTbLtw2deAwY+y7TR20SMlwidIYuCbAhFYxClo4Ep+CYG/Zy7evSiXXcwErp8XdRfmVq1y5/UB0yGMlHZJG0wAOGjmhSJmZzVLHSPMBtV4Y+RMulzF6DS4ei4UcIP4hFrfL3mO3vJYcNPDrCkieM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646977; c=relaxed/simple;
	bh=Jw3pESkNAEOGIG4o1TaT+h1cxgcA9KYjc88eN+F/PqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2l7Lb2ecf19XpVsY78PSKtA8J2f4dsMgv+RDJXdW0GWUaLJlsJrFSn45qfyYShYG1bPeN2u3/aLmyTewjgScxMzTh+tBKyNNLxPCVoKdcuuFKrCC/P4JT70RkIf0afBPyTZbe3h3AFOBaNen6Y8CU3XPyAq2ooyXuBOFY9T4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqSqQfo2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqSqQfo2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4624a44e152so2139529f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646975; x=1783251775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FUqIipueMGQU2MfTCKk6tyYRgE6BZZIjr50NYi+6Oo=;
        b=mqSqQfo2yg4jwMesg9gFIsVOouug2cIPzpycniYzmZfl+fIQcKchA9a6fapOz4IXsK
         sQ05uP3SesVxiJ+wKO0kF4BWO7Ta1Z5lrPeyeB1Tf/5E66zMZPjrZ341tMWTIBbcyd5M
         i11qRHTcImyQ19ZBAoBxs+mWSbmOyjlbA54TCy46UiQ3B816cJaIubnylPI7YVa2lBXA
         qtRzbPxpNvEeHSFySFZlyi4gASH2w2qVk+ElQceDVwuUZMRwRVTJphyfmNxUMqqFWLnN
         7ddI92AOZsQiquvvXq1d2rTDjSXrGEPqlK1sR2oG6n2FLK/5oyOCMlug4dbA8ve4XEEL
         PL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646975; x=1783251775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8FUqIipueMGQU2MfTCKk6tyYRgE6BZZIjr50NYi+6Oo=;
        b=UlBjliHjxD/JtXWiyDsIR19RZode8JhMvdO/F3lBhyO8P82tj4xQC+CjMkhx0zqnSO
         fbOZ8ClxSdX6g89DWrPKrUgla6TJOGpsrtJC3c/WCRnuO60UfmvkpMWm/LWwWlqVxDfy
         d2+4XFkdPFcKKN1NgVmkOPu1ai6g1ImqoTN/8JoUKl2aP93qGv3RO6/1rYCnuRLzYwoh
         ByRa0+8/Q1e3WgpkRTIIwioQueeTy/PdXqCoWRYegHsO/EQY+aVs0qkLBCH9ldeIu44H
         skwGQOC93WU8d4ppRToXvNY1ZXt/0cschcpNKqzap6TNSSijGGtlEx14CAxHXAdGCzSc
         OMeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9i05M3r0gYzEmvjbc/fuJHbxCEWLfXUChOTULaVd4d/D976ilzwuS5z6TuNnwYyGVZugWs/xEMYe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmzCltAI7icbZxre5SjOdUzOenhELQ9I841HdqUNXXoVmqrBhR
	aTbmPpQeX3G91Gghli8ymAHkanE3ZRqiFp8CpTTFNciqOJ9gw7abHoJ6
X-Gm-Gg: AfdE7clHHU9n9I3GdMBdptjk8fPKdC9iXPdGth3cdBVcJHEoFToP9EUo7vjuMwSKJ9j
	7uJhJ//PN62WzNutKLiyYSlbtESQ6GQPlMnzetayYgpQXxafONZmeeqJ+okcT9lZbz4oNH+NvT8
	j8UUBp6DNVz25jJ6K6Ytfvz3wC3lmnVC36ObknUvk1OZyWlbF82vlEtNit2YInhQGHrc35XBaHH
	QB0wHrrG3SIHhNKUFKKgrOqsUpng0k54iuIYqY7ionvwu9DXR2M9+yzS8Coo93zpFcxD5+0WY/H
	2YkqMFa2pvbh5pd3aue7tfsasNWG5bmFtyB/NLK8ndJfbmxLtP8x2Fkkk1jSwPipRitQk+gMYc6
	qmtk/Ik2lEsMXeMdaAaZ+ju4/EqBfh89J4ahvcuUiK9h9uSatC3/RPmx0r9mtklslmA2FNvVa+f
	9dH6M0TYGGhR/em9uZvnrIFttuSQs3pevznJi0WA0iC12zT9ExepuUWqfuuVroSUKUpOfb+R6QN
	dt5Q7kYQfao0M3t1tKqCGwhncaRkUG8r8cMGzYPaqmMPraxblFLoAYlZVcEo8PeuuQ9ceyxxvPV
	FHBmjw==
X-Received: by 2002:a05:600c:579a:b0:490:e913:656a with SMTP id 5b1f17b1804b1-4926689fea0mr152123545e9.27.1782646974544;
        Sun, 28 Jun 2026 04:42:54 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fd9f2esm205093615e9.5.2026.06.28.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 04:42:54 -0700 (PDT)
Date: Sun, 28 Jun 2026 13:42:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2] iio: adc: ad7779: Remove redundant dev_err_probe()
 after devm_request_irq()
Message-ID: <20260628134252.3f52216a@systembl0wer>
In-Reply-To: <20260628071405.51030-2-mokshpanicker.7@gmail.com>
References: <20260627192638.5623df0e@systembl0wer>
	<20260628071405.51030-1-mokshpanicker.7@gmail.com>
	<20260628071405.51030-2-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 07:14:05 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> devm_request_irq() already prints an error message on failure via the
> IRQ core, so wrapping its return value in dev_err_probe() results in a
> duplicate error message. Return the error directly instead.
> 
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
