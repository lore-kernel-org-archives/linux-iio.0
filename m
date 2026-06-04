Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10BB3D1CA5
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562313; cv=pass; b=d5o0A22FiaOJ46WhwGXhc65wbLGnB30SfGEb4vAG5VDKTRa7haIWe59MpsBjhVja/hEKe5YEdzqiPx02UjMm0MtO2E8y6YkxzmFiyDUqMxk1MaMS5eGOBcYn3X+aB3FPlzZxs2xRkJTDbQJacSc/aKPnf3Df5eHz/CyRFDsK8d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562313; c=relaxed/simple;
	bh=01Ai0uRzFCFukuweGUeIIDoZ8lmD4ReO7py7RJhf23o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyks/IxAeD6eMwZFg7kYCLriUrjqlxrKDqi3muJzJ+FILcW0pTi/X6baLM1CGL4hy9Tgi3wj60239U0e3JqGHXR7gntXBPxFxnSfXpT396xmubTsx2O4LWGbzeRRFBUKvxxeUQpi3h1jqMuTg356jX+zRTMlpGzVJAHUQdZuSqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRwwLWA3; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRwwLWA3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490a765d410so4722645e9.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 01:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780562309; cv=none;
        d=google.com; s=arc-20240605;
        b=X7LDt7thWCMmZlLbTRz0noDrNG4WgoIEsFu1RuXF1aReNlJ5ed6YOTOcNs0RJSSnQI
         ZQNdo6ENlLdzvBgUfcdk4hLcExOy4b7oMR37EPqwhhqad82yKkKwnMC/VTXk130lYEpX
         ot1wwV5OrjMhVrUVblVeWBBElt6O+5wrVeEJyH+39SwIEe97PanPHsZ9aUxb8QWha+fi
         cnYtMXuCyZB4nFCbJdMte0eMGM6lqlKyyN+5xVRBgXAjbCnND05UDZ37nDQkCZsMKtDZ
         dAeZDUbORtkqDXXh6qiKKv4/1WW1ci32Gr8COz1yTnwx0IkjmJAKYR4dJGV3LyDNhK+s
         nLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K4XQZ7aKSAV1iV5gjZCHiSXKETwy88bWWDvnwSeIALg=;
        fh=UEyOq/EaImH/cDEguKkpYmfAkukTByunxVHQKxfZiHk=;
        b=NWel9ijDanYSsCAmpg2gcT01mPlTKjOH5vIqKWQVk4ZUY0TZ++XB+wsdPqu1L9YpI5
         fG6NdTuLrTsvSo61mmakPKKCmEx7/DOpqWd9TOr7G/vPt8/FhlEHLPAvcoA84NG45VHG
         aVL5IG4s5W7aou2qQ0ylXc3WCGy9OqLy3cecqbqbsM+Tot84K8lhXIZIkFhXUzVvxP+W
         7hv8lkuBq62198S6xHLwCgtrAu0njNPJPTbbyK4fZUHVaeH3BZRO4gzF30aJRuU0d1e9
         5PFhZvIGMotIevsf/glii5BqxOtUGI87SIGY/jQbIPq2yiIa3OZZCB0gOnaRHt3fnQBO
         sClQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780562309; x=1781167109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4XQZ7aKSAV1iV5gjZCHiSXKETwy88bWWDvnwSeIALg=;
        b=BRwwLWA3mSoQfhZ8oFvpxr7hHTx+DyyvDXyQdIToTyURG8QySYzUuML6PfOXHiigzy
         AhLvQpQerA19yukrc7tp2y73FGGQyzde7KBGJPufoq89IKA0wn941qgrhCJ1YqTdwDtn
         knZljHOhpVPSiNbqknvCYozpetuK+JXkwQx+uHplLZRJ1wJ4axKUHx3fWycwm9g/tUGS
         WDalhs8ujOVoXKuu5TnvDr2pJxJD0c5XqEou9LqWVtccR8Pi0NV5zdMMTkb1wHhpggog
         ATG2b+aXNFLlP/0z9080UBZOA056y4AZv2mLKAfA535jStCTRweouiLBgWouz3XQt/my
         Wfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562309; x=1781167109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4XQZ7aKSAV1iV5gjZCHiSXKETwy88bWWDvnwSeIALg=;
        b=FzF4GUOzCwmkSz4E4Dhk550X3PgNYxelyqJ/kHv5mkKOvS4KbJIjyQqtDLvAxpIEIZ
         ZyV/ptJoqlx8AO4RBevybGHBbCPkLIumjGqoP92cfuCAByKhgdddMkWALlWwXa4MMb3a
         +/ihvZ658jyc2N7CuaHyhleU8BORdF/fGrtyv2ykgm7mJ4mIOuonEdGrZLyL6ubiYgV8
         FATUZ3lxUVY/Ag0B3oWPFYswNbI9/6hCFy9ZaaH/yOetJXq7mi/9RnkVg2SlXJqsqiK7
         33U1EMpqzcBpbEBvD4oluN8AjopOniwc933dRH+gJC1fNzBCsyVg1s8xrSwXh0J9fCQY
         9nfA==
X-Forwarded-Encrypted: i=1; AFNElJ9NKpk0QSytJa8JsM+zR7/drlWg0B7Begd0ZTz311C16qI/TGERcy3r3QS8yclD7i7rKZOYNCPvgxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4akNg33qAbEdbucMvKGZokoj9VM2azXQlsKz4PeA2xqZRALU
	WkrmL4YMy/ZKC07Kxcr0jBh40w7ZDLkCrqCRX2LLJYLIqiJhGmIEjuhh/Xgl1krypxKAlv8X7NO
	rssHxFXDdj65sRE+9IxUasCY/cu3jWWE=
X-Gm-Gg: Acq92OESSEBkmmFrVAS3drdnmsCAFglueNl17uEv9YB+/ufz6+6jjR5Qi2XEwhICz8C
	Vccd/LljuSo5yzMKnPs49VZVuFihfw+JVltiS9rYU9m1xCeo/EYprWw6Cr4ycfoxo48bLn+RFSS
	p05h90YmQ7MYLjJj0r9Faz+c7AZWLliVD8ydPyl5/75yDNZhiF4FHZ2Hvukdml5GqelygTNSnBE
	WsIOlkzeglIYZ404QR2v7klYfq90ljZP/9tHXVqTTr2z4ehV5YP7g+NqU3NEcuxzZrQ+iX6KXLB
	MchBx7/opmhHdriFsIzcEfnRmLaPIQu91tJYfoPKvWiWK+j+T/fVfT+orE7CXiYwQRHtMj7YAC+
	5QvnsI/ChBfjfKVMeFCPZvr0S7dGKAAJvsJZt0xw+HK4Sh//iQiDGoNKHEKeYA17GYixoFSkTax
	fH58NIPnkg9ypBLKKP
X-Received: by 2002:a05:600c:1387:b0:490:484b:bf41 with SMTP id
 5b1f17b1804b1-490b5e6458emr120496005e9.6.1780562308956; Thu, 04 Jun 2026
 01:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522123420.45495-1-aldocontelk@gmail.com> <20260522123420.45495-5-aldocontelk@gmail.com>
 <aiE36_SrwCvwLYTu@ashevche-desk.local>
In-Reply-To: <aiE36_SrwCvwLYTu@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 4 Jun 2026 10:38:18 +0200
X-Gm-Features: AVHnY4IWOMAf8p78J23HBZsGK3KtQrIgG2uflT_WSp_1XQJkNOkadfvKuN807T4
Message-ID: <CALoEA-zCeWEAOAQGi8pQ_R7Sqify6Z=BegMuV1nx5fKH7OUvtw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] iio: tcs3472: use ! instead of explicit NULL check
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Aldo Conte <aldocontelk@gmail.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 10:31, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, May 22, 2026 at 02:34:15PM +0200, Aldo Conte wrote:
> > Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in
> > tcs3472_probe() to follow the preferred kernel style.
>
> > Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Joshua, even if it's not written in the documentation (or unclear) the idea is
> that whoever formally suggested the change has to acknowledge it (Acked-by is
> enough, but full review is superior, of course).

I see, thanks for the heads up. Not sure if Jonathan will add my tag
at this point,
nevertheless

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
