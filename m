Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9DA3CA4A2
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159891; cv=pass; b=LfFjGo3OX3exvebC6VKBFpYGkEkmAWzLPMqcxYKjjjQaswpr344jcxBX9cGVyu4bntZwPATPBUa/lCDd33x4v4wNBMAjAlUTN4EAr/l2tRmGlvYOY6LvB7nioTLGX2D08zH5PIrIr5CtnjwcBkpFqvTfKgrtl6v5eb/bKAd6jp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159891; c=relaxed/simple;
	bh=xGDvPn2uXdqd2XWia7H51IAFBbwGGhKGm2F7xmF6L5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY+sg71SPpifiTL+CbyPqraKM3jLkjfMlQ0VlkrdFjnlq4kK6RoHJ5wP3wXr741VKv/rve/NFuqbc6dyCX6cjP0tH7FeHr5AeJ/3yhmCRyqS81x8CoHeaRiJsYJ7JHbHM8YbiKSfoL2cjqFiai+xj7XG+8+x6anbX858ClVo4q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnSDXewh; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnSDXewh"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so3453371f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776159889; cv=none;
        d=google.com; s=arc-20240605;
        b=B5St+gNc6fljTqaxhp+kxKMGsyd1epfgQP3cAX/V5TsqiuLZcecVg1crrgKZbicpyR
         0sxcb+pz1TfQk9XJEHEL6iVcGzbdVxI+vRbxAzVEQsVwi7P2g4z4CoZcAAVlU4PW5TLb
         JI9QKdV2oTGLV2kzO2/d8wNE1pVg8Ownsg2XiRxgNvZ/lgNhPW382PM10WNhJ7oQFLJz
         GM+ucMGsyryF1AdtXZEqamj/DbDS3kq7bSrs6AVOeHMiiaxRQhg8NN/zj7Icgu3ed15K
         x7Gg2p8TO6MWTrW/pyZRYolk1IUIAjR2siXAVALepQ5u2hvfXBdZeg5suquRrOvL/kK8
         P9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lIaU1p6xw1+dwD4yvli/lO/hcmFigM23e72vtmpeMKw=;
        fh=WnwDITNxT6oXBiMEXQ4CYQnuzrTgUSUofq9C+3KRjYg=;
        b=gAxdO34ieWy3PRdlBdGkHGNxgQpwxBYX8DLQVMw1whnFVFhsadyLCZZn5LGKArOODW
         FvihBxPR4A2vV00WAHtXogMGaomQwjGtswf3RaG+Lpa86II9ABcRcdFzlqFs3s99Y3v1
         Ned1JsduR80Je1nwGoD1WkSLiCScPQnJ75f6OaoD3ys1AwdULWUkpY6TullF4kunXjw/
         uX4ZPFOZ9PsbUgKZLxsR2Yfs/hfbPaMfdVIpf90In0IjljUzKNQ5MnLBG1lNJlW5TuPC
         nV1QM72jISAMWCviYlzsBglfQ6xIJCnhlz7su4uUh9zZ3xsnRbn28Yj6+98J0beefowF
         PEkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776159889; x=1776764689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lIaU1p6xw1+dwD4yvli/lO/hcmFigM23e72vtmpeMKw=;
        b=pnSDXewh7UGa1Q9FSSeR399MNUz5aN/CfEsgLaPdE7hYtN7kqFnLPFrgcw73FVilZ9
         Op4y4kT5kqnoAVJ4ijrJTtXTpeTOBEdUeermtpvYq4wAbQTWWE3ZiqfrYEHHuSKVfGoh
         E4mvXZB5dm0TTuHI9sqvRheZg47PqIppewi221aO/3UxAE8hQvRLv79LtYmTEKH0VpPd
         CxwD+MJCqBPQazx+uP9lAM17pZXDyMqfsmE1IXNccx2Zim3yJN4NP69eiJO6dmUJ5Osw
         L5VmRwthOokY4B1ndgqq6r6+bof+Ars3lyCJ7hvFrzuekBjwzx4+2TSy5uFp526bHIKA
         fotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159889; x=1776764689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIaU1p6xw1+dwD4yvli/lO/hcmFigM23e72vtmpeMKw=;
        b=gGQwNukjRNWJL0o/OhrUJ6hmWxQmyZ9x6IsWSmOofqFm9Cck501uYsyn726fvkzm5Z
         RAL4gtIr2GnXKmQrfmGfejTFNBqFVAon4Ce5ap7m7rQHcgfQYNUsP8sb2kXex665omnP
         GHQi8o2ri7OMyfvKhmVjKunpYcioo332rT3P7nfVlG6v0/1ZX89kduVnUym8JvStVSJj
         Y09TxdGgJzWmKFoNvLisjPh9cykFIRTMg2fXYqNCTu+Dzykkd7OtoPNBX4ZOD6HLRwBK
         qe3jFk1bymHNtIMZ860xUeFiXhk21o7RoGi5bNiHhZ3FmrwAJs6Tfth8IIPeQAI5MGrP
         muCg==
X-Forwarded-Encrypted: i=1; AFNElJ9wMItoUaUD6wOY8E0bDKilFJ/PJb5vYPgIEhaLiAT+g41ndwJ3ESIrxuMHpW1LgVATx6IAClQlwKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycm8cT8kD2o4DchvUh+l2D8XA+PBhibocqdM732araMPFLbijU
	XascYD4nhW37bDyhXQN7H5JiW2lEMWGq6x2hGrAdLrTfNJQ+6666YFX67S3qQNW3WyzFVaPYJmq
	00hVxnU0Ad4q5uF/AAtMBZ/uIbrSM7eM=
X-Gm-Gg: AeBDievU1MzZmEzi1MlrFv/TmiI1oSLC2Wnqn1IZcYdNq0Rbp7B6wWKTD69Yz4O7Va9
	W0ugLGpEyS11hh/MJiswNlYvs4QYJncB+w+M0/KvTQZkHSfXejZlY8BELcA3F7O8E9NPAjZTfw3
	JbvlhqQ4Wu0gYNo/FZPIlbpM0b7ox3RDhDPDmyF/j4+eJY7pLFKGxwN0zXIo1yL/X+iP/rjdyRf
	eIqSneAG7/uIaV334dzorEaszv58z54non7UTsfibPnzxucG53fylATPYFOEcqIz3cbSy7vq92g
	/JsB5+GYrPeoiVsfZ2FZGIi/SzYK4XjUBVPN0LiLrL0sa1iOFmwQwqCpv/p6Ysz+Vza+vRfj6Kp
	2bKIQglXluW2XzCRM8UUKH8sRBp5oCnqzltY5CrreR7Uc9uFitIuIhYSqeBkA3xDwcjBpDgpBly
	75hEA5ts0+PKdwBfq1
X-Received: by 2002:a05:6000:2885:b0:439:c661:3245 with SMTP id
 ffacd0b85a97d-43d642d1968mr24367297f8f.34.1776159888896; Tue, 14 Apr 2026
 02:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414091250.1295-1-joshua.crofts1@gmail.com>
 <20260414091250.1295-4-joshua.crofts1@gmail.com> <ad4KgkcR58lQwPaD@stanley.mountain>
In-Reply-To: <ad4KgkcR58lQwPaD@stanley.mountain>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 14 Apr 2026 11:44:48 +0200
X-Gm-Features: AQROBzCFlwUqH0Bf2HSd12i91HAXfxMf168i7ss2SkRLFThDqiBxknVm1B-fKIE
Message-ID: <CALoEA-zXyZ9vLNZ_74qUADuxBHWCLmyUQtsbQ7g1Z4o1L6tvyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: frequency: ad9834: add mutex_lock() when reading st->control
To: Dan Carpenter <error27@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 11:36, Dan Carpenter <error27@gmail.com> wrote:
> This doesn't matter in real life.  "Oops, the root user tried
> really hard to do something stupid and got "square" as the output
> a fraction of a milisecond longer than they were supposed to."
>
> Is there a tool which detects and complains about this?

No, no tool complained about it, I honestly just thought it's best practice to
add a mutex_lock() given that st->control is "volatile".

-- 
Kind regards

CJD
