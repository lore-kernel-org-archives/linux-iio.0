Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B813CE4A3
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297761; cv=pass; b=G0JJAYkuxIX6W39R6gj0LgqkeRQDUU57Hn7V2e5qCQsjMun5+altp2KCFJ6rmDHF6Gy1et7vR8DOGdV/Lwv4uvmYNLhqFhTYop3SnV7lS3UGrkFtXvEzljFqh/Gy+4MY8fKl2DtfyejCQLR6CDYUlTICjaumNI4O8chejlVCO5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297761; c=relaxed/simple;
	bh=UV6buHEG1uLq/GfdgoXUKW/clHKcaNwLCNlf2Vw2HEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N65nJUByUl2n0jVQ9vn47m86MMu5Qu1lK0t2lpKJe5xYzn8tm/T3OW2vx+nPNDBZzGBtgfk/1geaWHD4FGkKHxIve47tIpL/53LvRNyca50XjZof/Il++9RjeWqxWxpuinUah8H9lsDYnCcQ3baSxVbjR6ChIbZh3T5IXCVEj3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSGYKirK; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSGYKirK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfce3a195so5858589f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 06:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777297759; cv=none;
        d=google.com; s=arc-20240605;
        b=Fpbg27yza6d+mTDLhqmvHjdUzQxNDiaUUstZ0S7ZKgWQYfXZH6Bt33TM2lM05sLhWO
         BEVfpDDJn9PogBuvjgn1+x9fOLCE18Hjmaumkl20YEUUkID91+seBrTB44fmVNZ0MDV4
         AJjqTWfmFn1VHkuIKVSYWxOgWqIjTDbN6cOaNU6601dvLmawh8r0b2r8INJZLkcCEzBc
         I25Q5Mp8SBQXcuFn/mra5EGshsalPqqY/IprmU0VIVuBN5PHgbQYibMoQvUTJY+xZEma
         bBbTfzRWF8yOyUdzfGYquICOSZfqWYea4MZLuks7mZIiA5QXowzbr2C89ym3V58wbdTq
         pC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3dd6fL4hXmVroT8xOXA2tc/R3AHUcKZxKFu4hjGHfCs=;
        fh=Oe6Y0HaLxtu+Nhioqt8Cy52BNMAxpOFTinugTc/krQU=;
        b=MW6Fx8mksudt0tb0MzREZU6gfqq90r+7WbZZ+3YVDq0ujSpOugR/a/GvumT6HHUp2W
         tL3B9+McY2X0tmY8JKqKgJ1ASwml047cHIcvm5qquEmUhZIbJL6GOTQkX2JKyWkdmD66
         8jT8s5SAWpgeKxU5ciT29tKtsHsDM7aqF+kZ2D1c05lkks01eFkYl08nE/4omgKTQPAC
         h5ue4nhfWObp6rrFGWYYZjcCe5qpWfbcF/nQfAkwscxmjpyXhThZsWdDuCMOKKfNSStO
         6yqf7/MQqUfKldwv/s46jd3eCuDzHwdWoxVri4sJRkuXrO1aa6P84+tHfCW15LyECeMV
         jOvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777297759; x=1777902559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3dd6fL4hXmVroT8xOXA2tc/R3AHUcKZxKFu4hjGHfCs=;
        b=BSGYKirKaJyvo+qLEEyqMYnA5PJv+DRbqYwQEx9O2tlGeKx0E4Jsc3UJXo3djI28tc
         gGYyXDQGFIpHm5MNu1bDI06H90bqmi6Vdia6OmetfTcWYKtvwWm1gZdCecSa80wcqgxx
         wYVmhkMhZSw4dL8PhYs6qXXLjSa4S9ZtWwU3zIx+j3OEG/MKknxnjwJ9RrKzBRzjFNlK
         a4i+BDu0MbfIaN+Pjx6ynDf0rjB2c+hPpRLgumdd2RJ/uMck+4NYAd3ZDirwWquTYqW1
         vxqWQiqE3X0VR39/3t6p0oOuMln64lksUEC3lNwJuULHz/62zgTLP2bI2X6ztjpT5/oB
         ZsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297759; x=1777902559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dd6fL4hXmVroT8xOXA2tc/R3AHUcKZxKFu4hjGHfCs=;
        b=gLyymnf9Zej0ns+mDhBF7IFTDz2EQxYx677wI99qzjDQI2YTEwCwOB1BKsiHA0XMD6
         LsNH+DH8sAXrJ/YRxR1vCTwZC6CuZtqcdWi6Ysa+ERCP677rBt/a0qpM8cmSDIVcuC+W
         U5ugxAGoz44Cp7vBdTQ8je3K8gifsVhoF9gaYZKcNUBKsDFr7htUCkni+lD4e7udDkzG
         kbFAhO4xg6+SFqX+ZMZAQ9vL/e5SwJOHEBUiMvk4I72+VGpIVMYj99EGB8K/n8fnJPbj
         3heB26W9hFo1HD7eAANwvGOfsju3mRaESjD6K/0sNaijyxEk5/S2L5MrHMrAaHmJ8w4T
         oocw==
X-Forwarded-Encrypted: i=1; AFNElJ/OFbSE9rEaprX2Zs7HI+gN/3lUsNP7TrX2MACy+Lm0UjPalxZwFR9Gx6TWOqk+wir81xckDOdVlO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpi+oVOk/MxUi1TMyLsYNL1HCt5ILeqOhNXGpDakyTO5wXivjs
	CIEo1SsbpThJFAm/dqifMhLdV3VckiwlzLkqtUWjakSSahIKQljtTNW9f+tMhfqcSZlen4xwTmI
	dycOpkQeTRDF0cnzHgESt9PoJrSPi1Hc=
X-Gm-Gg: AeBDievJLcokzBZdgTJNnJB6GiMWZzcecDctgcqffomH3wMtFbhdy08GkXhMV5erQvJ
	n11kloWeEuxMTT7DcOzMqRsEMczpfjhpxrWA0zlD0JGP11ftsdI9JdwdnzVDawws3SL6m7zLXW1
	ZHKwyeblVKqDZn/+IAnn6DLC0LLij7xUCtF6pXcoZI05FmmJtxY+Qkw+V+9OOkbtdwE0MmHDsRh
	AuzBp433nRDUPj0dSLIl4i2Q8UxN+j89NiwGMHJwEizcznudARiCtQ5gr8q46ZieLpGAsa7gcar
	EItgpQOoxQ2fTAG6fBQcJmXTbiu3SyjT0oLkKFJx4Xy6HFi71HdU3Cdrc3U9pJOsFrSyUTfJhJU
	zbiDtpo5sxDbUx3rN8F5x6F7sH4EQqX0EuXdTeS7wrD7Ujr9zQm6guVjnkfP26sq2ZHtz/2aYIa
	parT3+AUvoSOJYHhgg
X-Received: by 2002:a5d:5f92:0:b0:43d:14ae:1340 with SMTP id
 ffacd0b85a97d-43fe3df259cmr61667732f8f.23.1777297758511; Mon, 27 Apr 2026
 06:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-4-piyushpatle228@gmail.com> <CALoEA-wAUpZ7_2_3kB33mNB_Y_DAc_p7QwPR9a5pxL1iET_cdw@mail.gmail.com>
 <ae9otn7HuPKVtzsk@ashevche-desk.local>
In-Reply-To: <ae9otn7HuPKVtzsk@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 27 Apr 2026 15:49:06 +0200
X-Gm-Features: AVHnY4IWXn4KPlMOkGFs9kf4VC_aZGi8atIaaiqwtdhfJnUvsWgAsLSy90uFeKE
Message-ID: <CALoEA-w=giUoevbAh+i66ATKfXCr9WUE0R6G6DOMq2xE8cibEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] iio: adc: hx711: update Kconfig, module
 description and file header
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, ak@it-klinger.de, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 15:46, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Apr 27, 2026 at 12:26:53PM +0200, Joshua Crofts wrote:
> > On Mon, 27 Apr 2026 at 12:23, Piyush Patle <piyushpatle228@gmail.com> wrote:
>
> ...
>
> > > +         which are used for bridge sensors such as weigh cells.
> >
> > Typo here.
>
> It's better if you point exactly what the typo is.
> I think you meant "weigh" that should be "weight"?

Yep, that's it, my mistake.

-- 
Kind regards

CJD
