Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFC477995
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459938; cv=pass; b=IJJj0S7ATe+gzkbRMALk2+GStKUlOw9YxJ/ocoar/o4JouVeM2JvX1WkqdLqrbKGz0jAqL7wMQWWJPeQjQc1mkKYew6wIjm8TnwvrubgDr6X9jCoEfmWcRBnxaVg+eClG4ZgzC05MWo8qWqCcr5cKLmzVWRo4uXX+wbwt9BhQcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459938; c=relaxed/simple;
	bh=v7FBgLFkkzz3pOhe8g+ktG1pnnMIsllDx21K56evHWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT8ErZbq4lX9EyNx/9qUJ467LiO4DkrQHcikfwu66ihiMCStMDo7HztiPk94NHFDonE2apddiZlAYe3ga9B4Gx0i10xT5EN70x4RPCHj6EVJRWtRZ4YtRQDQBYfAHjjw4FkUHDsXoMvcGPrYntPGQoSerxCGeN9jLMWd4ZR+okQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPPtep1I; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPPtep1I"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so1477468f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 07:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779459935; cv=none;
        d=google.com; s=arc-20240605;
        b=gtuyg5OAxrrdKfEgLsRmWkeexxDolSfAOYez2gowRoXvVpgaIMv7hpzMoHKiQqEhIv
         iukRdvqHyrl3xhsaTH2oulvcWQ8Jsk5vZwvJJLwWKCTacsz6/fMVl2/0+ajJZgqGM5V8
         HWejnlNK2c0XdY2UXxQbkzytRFUR7GXl/L4THmpva70TghQVZPkt3Z8uNzpCE7EW3llG
         2eQDnx8emm/BwXhsbPGlfULPbRbHZVfA5HPWwoAKLkxhAMci/fhRedBRK5HtQn6NXX+i
         WFgG4ZK2zdmMr2ExNYHjocI8i7wdljd2sN9/q0kIZVlJqN1GE8KImAOuLjmtBgxGpStW
         L0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wxoIgSFrZs9f+YtoGBBHnxJcqNFM/1egt5gJfatubYE=;
        fh=OWEd6ugQzjMJEOruWTQq+drVRuwezcboStR7x4B8moY=;
        b=afAAN3+C7OLHWSmr22iiFm0Ht7tH2mxcWU8Zj4ShbeE297HFQ6xK07P15IqMq4tvcE
         Cj8KXTOV34wi7kP4mnMykP8b2jPfm2B1OP1buMBtvexA3JXO5sjvMlXb3vo9LxMbbdS4
         iGR43Ia6GVDf5i11iZ8IB0AzaDFiiknTNQeHT/0drHq+qXeTqfzA2xm4ESBEDLjfaMF/
         lYjT7dpjDD47gPR2D6I5RpXXSjds3FGi0R1Zw53y7Zu31vaH4QOMuc2cgjVNFUiDZeqT
         HYXEjy48yTy35opyFc6xKIQg0G/e5plp8mIZWUirDkDMm0tnLL/m1kZaOIgZzNQaTIqk
         eYMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459935; x=1780064735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wxoIgSFrZs9f+YtoGBBHnxJcqNFM/1egt5gJfatubYE=;
        b=XPPtep1IZYxdKiIVUfpD/2OJ/sFLUtpq2N4lJWzajSfpp5zmHfPa5pJBtNCgdujSs1
         oqdFCefaPTupPCYXXKY0Lcz6QpwvE2HJZgnQ1X0z3uk6Uc7rp1R9aig881oOWAA5oclP
         0zGXReOi54lttFxzLjTKz5oc5/AUtLkjUb6ZSUGs9jbrUBLa7hBUMxw0uKonBAD1MmIe
         TtMMnDT6kAZFyMnaR0+BGj4hhlfkHP87FNqYSgiEdlEFpSjQ5UYQ1Cr0omBQU9tO5drV
         n9vE7+Hut1mcGOzqm2BCDzOwacb0tiiXbqIzGbwr4LR9E2qBxbx3SySAUTImGZ7D6Kls
         C2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459935; x=1780064735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxoIgSFrZs9f+YtoGBBHnxJcqNFM/1egt5gJfatubYE=;
        b=ObD0TBMoPoxJt0CPzoF1bDiUuGbjffLG/Jxrmtf/SrBMXDNskWji+5EFNtR0TDOxei
         Mv5hYvDu9bnJClA9vcXOBf2qrntfo8C5ZoNg1mEdzKqQ6SFbETwWhctRO8UoylrxzjA+
         6FOr83W+CMIlEHRnB3I4yjGhzIBIeHDLxx8pX3nnVjqAt77nImiyaDoSLtqxjKyN37RU
         OtyfZNlXRdtlMAgQ5kg/SjGocg9CWcChqS/tVHeSgwRcDhiLjp3mLobyupzz1P+VjcQg
         Mbj+IKAlPyu4OGH8qOanrrf7hJ6BqG+xkeNepkCiWnWM9fTNNJYNuVVynH64Yco2ZWlb
         LqUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2L0gxdfdxYuIvxSYuRAThdxRE9zlY1VXOwx+I4r3CovE9xaz2FKk0ECPMzdu4IYHwqMtNwC0kxP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtYYA+lFxydktmbPt66ZKmgjWYLJvya9zFxzm7awwy6Qhd6ETQ
	y7Cjlofh0qCr/tDHfqkKCuDJXU9VEnEWc7B8n23+fKUMCmDWszgsJm+t/D7B2jXD9fuRQ92ZvMi
	cqivF9B3F7JrLXSlDmCmy3RQb/MEZYxg=
X-Gm-Gg: Acq92OHRc/qJknSQ8ktiWELxSTVyNo9J3GG3GvLwhGyCNG39DAFrBSYlTGx1pw5+TgW
	uGZ4oksMkZ0uFBGZSvYdwp7vbuLKymWOLtK+pPRWJWqPFOMX55ZWttxrHAMsbFZZ7suX2xPUlPz
	0p7yBwBlxsNN7o+sXHaC6Pjifh5s2YAqNQXvaxeuwEM+zoSTOjwLBCFQ8B8MQQ6kxqG+p6I72wI
	vkphsvTsdi56jUiNRZPMaSrsovKE1DK154cHBEqtfBwCsEh7ef+nqZUZRwU0Ga3FHn5Yz8HZJE2
	Wi9hmBBeU0IHgXr8MEeRBnsOnk29IWEusC5Q/yDWLnvGPV/j+Iaj6wMZV/nduIOOuxNm+SByw79
	kjkvkfVBr6O0cJcTYCqtkwwcDHp+sbAVAi+bHA5VW1YUC5w2/fnJcFnJLBQswhfN+YUwwPlkD7n
	WMNzrt1Q==
X-Received: by 2002:a05:6000:1848:b0:45e:8866:e58d with SMTP id
 ffacd0b85a97d-45eb3687eaemr5912539f8f.11.1779459934969; Fri, 22 May 2026
 07:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
 <20260521-opt3001-cleanup-v3-7-820169dec8c3@gmail.com> <20260522151252.4a8ac373@jic23-huawei>
In-Reply-To: <20260522151252.4a8ac373@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 22 May 2026 16:25:24 +0200
X-Gm-Features: AVHnY4Lidra8qXJhy0BjBn-Pom_btnsWCmP5v-ODJZRaYZi7yzSwTHsYhXjrGKk
Message-ID: <CALoEA-yoM07pApwmhi0PrEZkuAf=GAd0EifUN60=EWWzJt_tXA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] iio: light: opt3001: add comment to mutex
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 16:13, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 21 May 2026 11:55:44 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Add comment to mutex per checkpatch.pl report.
> >
> > No functional change.
> >
> > Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/light/opt3001.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > index ac1c7ba5679867f6b814894680e317615f2e373b..9d24d7a23ef00d160fdae737b6ea1943576a3fcf 100644
> > --- a/drivers/iio/light/opt3001.c
> > +++ b/drivers/iio/light/opt3001.c
> > @@ -103,6 +103,7 @@ struct opt3001_chip_info {
> >  struct opt3001 {
> >       struct i2c_client       *client;
> >
> > +     /* Mutex for ensuring one executed command at a time */
>
> The device uses a 'register' type control scheme rather than
> command based. So I'm not sure what intended meaning of this is.
> I'd say something like

Of course, no clue how I got the idea of it being command based.
Must've mixed up the files...

--
Kind regards

CJD
