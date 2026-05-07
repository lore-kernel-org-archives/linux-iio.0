Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A6280A5A
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138414; cv=pass; b=IFi5Jk1A+Lo24OhLkdFpdhxJKwL+0fh4jSR3q+eQoBXkRhmNP/KaVPkKJ8yfScsadH5ky4fg+nPYOrQhQA6iHwRpYJIRON38hEsvGDp7uszoBx0N7aZ5V65zeBtnChDS/E2FqpUvgTGiWVaso872NAaSOn7uN13HqpQm90963x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138414; c=relaxed/simple;
	bh=rJgQoYZD2gQbQfI14ttkovOy72NPM0f/T6XZ9HnM23g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw1zmvaE39TAdvxKz8kS60za4j6tUgCceRPxbKR2gpMj5QgjhaIGZIPyHa+krKWGLgriSQfI70YIBfyXtdF47ifB2OiTXeXxMLbBkIkRY3ms8H2Y8+HK+2ZhTcmIVrsndDHejTxHN6q8vrkk+vd23R9axFD8RgvH5qOpbBo9jdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1dRWFAa; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1dRWFAa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so2931055e9.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 00:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778138411; cv=none;
        d=google.com; s=arc-20240605;
        b=fnHzL8CtvxJHLTJdawlkAIAZAREvK9pGROs3HWTw1rCNJHS5kitqw9N4nSLyFPY8Nl
         3EQ3R2UBiKyGC1BWvCm7QrydFu0ISoi1YcKr6qs8gjOYZvI7tE04fhIASSbx6xr37xQs
         Wrs3AwVYudYa8wcp60BwoNzz6Rkq08UiPuoJ93moYWbyrLAoGYn7DAutwkglIowdkbao
         076faYAygmpof7Fc5Uz1TqQLPt3udwaI0w23RI9+U0ZASayoGY+aRtNYbhKzhVnaZZoj
         w9fw32JF0wIhhrycsKktmCFTeHyjs+gj5l35ahArqlZVp1NyqdfNKbm0uu3o88KZ0Wj/
         U4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zxWfIKlZaf3YlrTcTkrkd1tVVw1xMY6teujDawARV98=;
        fh=Dd8QHU+j7eWNFfjzAYPHL/tyM8ZNF8m+YnN5J+tKLfk=;
        b=VitMXl4Ex1wOZthYWl86fudXXUwLmdyVqsCMvkdYpnxaHuimnAUSlxA0aI1xaVw1/D
         GuGCeV2/tOlRQQm+73SyWY4CFmWDyWXXbSlKmF1n6lh7RpdPkUtI2S4PMzGrPmovo8i+
         hMVhiz+6fFtpLPRxYnaB2rGXtDwcU86Tvfr/yLoasvSqm9G7+npWfqULKdbI7wNFt9SQ
         EGFhYWwFufjYTEWPuAMSHrri0je5cHb+Sg9xcOYOnZCsYhAe3EKd7CmeE59GnFOGwpFZ
         cuINHmfuN1+K3PVAlpRtoHSfk/iDEjLsuUhvWIgrOAjxa8A8YBDzoVw0s+eUHKzFPGf2
         SKYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778138411; x=1778743211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxWfIKlZaf3YlrTcTkrkd1tVVw1xMY6teujDawARV98=;
        b=I1dRWFAaIuykE+me+Uyc9yTKe52usoYbF8Oo3QRouTpZdpFVOxjTCElaBSJoqbmyuq
         Ec+R3+t1sz4snqbime/1mestH2wulIDq6I4s0Dr6mjfy3dg6/VCzKqZY+NmdUL44Ioxf
         ifHIeGaZoX6NLsnarcevPrgtruM6xc03oinoN5FGkvQbon0TXw+ZIVzIJ2jd45VkVvoB
         5WQuK6YNMEkJonZz2zgQmVv4S1kzJRczGixsRbUfolSij3zT13y4B5CoINgcpTddlf/f
         oUjS/ZhXB6oWndHHwSoIFI9CMvcmWDyJytk/surC0qlLOrZOE/yX22tcWuHcHEHDwpBx
         95bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778138411; x=1778743211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxWfIKlZaf3YlrTcTkrkd1tVVw1xMY6teujDawARV98=;
        b=E2CjutoBVKHP2COf7AQS+dkkW2rlhuXBJMVjbMwyGmvt4umQVUcUIN6M5lDK16s89v
         eMF0rYFcUPqaQP8WFfcwmB5e7uyQLtdjLWWqRVMNvYkE6tx4+s2nujmvU4yTb52YzP7g
         TktpB/xZQx6rZ5FVyi0+ZfUTMUm2CnTpoHr2HK6MprxE2BYeXpYV9DKPV78MeQUTD22h
         RBpMmT3/KFsr8DbJwqN0BnFj49/rnmEzCTQEhCuAdK5j1Qr9mtActzguVz0cAYzxihNn
         ZLwwb82DSGKSLQrKbN+5cAofOVkBMNKAZvBvaqD6xvZbqq3Fq2LMkUQYXwXo1CzXYxvq
         9kDg==
X-Forwarded-Encrypted: i=1; AFNElJ9cU8g27DDXDoWAJJBHoQXPgvjN0r9IP/bUOwKjvj8qrPzIWAinnT9GNRMIEj/xy5F1Xm/BLgef0XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4F6VfcJSqMYiTF1OwZeuaZXOSHsCV/Sd7EOEehJsHJDKLf/IG
	Jv8CszGAVHvbAi5oTrvCThEcx9mbdgRN25H+jraDK5UiKTf9v3oj2m52Ay5+ooPc22H/N0E/mR3
	1NsUwhsS8fz+a5mYEv4yruSesYeg4J9s=
X-Gm-Gg: AeBDietNHlEu6Ap7rms9WWe2/u2TM6toJ3AfPB8PZRP7JH+7KqdrD3oJYpsVZQZ7/a+
	ADEx1wXn53e51BcH2RBlF4A6falLDRZSsWsiRHxTRwdCfyF8JcbojWwfudyHvF1BhOanoNmAzfO
	fWSWXT2P4X7cSvwPt2IDNBMC5elCtWUeY5pdYEaCtphxXewbUtGwSkOBp58Tb+uleBJsfwsgbCq
	Lj3fyCYq73rj9Tg0lyi+5r4LPd+bIrU6JIAvEY53M/YWeZvkRPBYZ165uDyWjY7DZ8O5v61s05V
	oyGMkBQLbWAEQ7qw+tW3IC+rfTZi/6Bc6Pr66gBI+00Huz5aTvybXBaS68NzBQP5H0XlPtRo1ft
	UnEK4RcWHEHDgQPS42eos2WXi91Hig7yZPE/a2zsKeH1xodmfNxggeU1r4ArgkzLc7UpV4bX33x
	9Yxcw25Vuww5FyUHQaVfgpcyIxkNk=
X-Received: by 2002:a7b:c017:0:b0:485:3038:72c2 with SMTP id
 5b1f17b1804b1-48e5e00720dmr18756085e9.17.1778138410967; Thu, 07 May 2026
 00:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <20260505174640.3998281-4-sanjayembedded@gmail.com> <CALoEA-yUHJb=coHuPYjrVhP_Vmvvi7qKxkXJqTp3qXRQ_wuG8g@mail.gmail.com>
 <20260506185359.68a43855@jic23-huawei>
In-Reply-To: <20260506185359.68a43855@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 7 May 2026 09:19:58 +0200
X-Gm-Features: AVHnY4JcG72m5H9qtQ74xOO7Qswtc_qoS8JYGDWuWfSgpyK8Vsa2njOl-k-xqy4
Message-ID: <CALoEA-wA0sq2Q1aq_xpZ2_V7Y9G=NpkqNerVvPxA22+sxjb+kA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] iio: accel: mma8452: cleanup codestyle warning
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, sakari.ailus@linux.intel.com, 
	christoph.muellner@theobroma-systems.com, martink@posteo.de, 
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 19:54, Jonathan Cameron <jic23@kernel.org> wrote:
> > This is still not aligned by 1 character, it should be aligned with the first
> > character after the opening parenthesis.
>
> Hi Joshua,
>
> Trap of reading patches in emails is that tabs and space combinations don't
> always look correct. Also your email client replaced them all with spaces
> to add more confusion ;)
>
> From origin patch
>
>  static int __mma8452_write_raw(struct iio_dev *indio_dev,
> -                            struct iio_chan_spec const *chan,
> -                            int val, int val2, long mask)
> +                              struct iio_chan_spec const *chan,
> +                              int val, int val2, long mask)
>  {
>
> With the leading chars removed removes one space from top line
> but nothing from the following ones as they have leading tabs.
>
> So you get:
>
> static int __mma8452_write_raw(struct iio_dev *indio_dev,
>                                struct iio_chan_spec const *chan,
>                                int val, int val2, long mask)
> {
>
> So this is fine.  I haven't checked the others but guess they are the same.
>
> I frequently end up testing this by hand when I think indents are off
> and often turns out I'm wrong!
>
> ...
>
> >
> > The rest is correct though.
> They all have leading tabs on all lines.

I guess nothing beats just applying the patch manually and checking in
an editor. Thanks for the clarification - gmail really does mangle formatting
horribly.

-- 
Kind regards

CJD
