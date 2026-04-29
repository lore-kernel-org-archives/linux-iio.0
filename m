Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1D33121C
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474910; cv=pass; b=FbOiyt+NIOhNJFKbFP/Lr8cG43Ix7tiKBHurwKpirRg44WjcnUiHdR9p9VLXqkE4oHJhUdBlPP2lW40xnVAZsCp/3C6fJ06DStHyenfJpLcIq89fdM2YuK7ZvYmtExWzr84DRzYe0vacSomHZ++XKvFRHB+cKaFZNqEKTx0Qx/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474910; c=relaxed/simple;
	bh=Cw8HiYeGhGVNri5kNkphNtuXLygtN1Ukwi72xdQF/qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5tm12vDSE/qbkUuLjXfDo9ia35BmVbvhx8ArnoGdbw5+JP+yR8kVQ1tERbVzB2JMVpsneL/r8TLzh2cBXQ/owFjUqt01ZKE5w9CC/5rQi6MM0Ckkrk59Hej3B+S215fzm++1sH7Aw3veIspRmdFUFuwcFDD8Pa8irPholp4oh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws7TRwju; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws7TRwju"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4480f9b5efbso682621f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 08:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777474908; cv=none;
        d=google.com; s=arc-20240605;
        b=gUqGMRHMRoyvRH/kIbM9frqKGjwPw49JFGRewOV8IdtzQf5GsJ3pYU1V2rNYhjwcfe
         PZBlSw7zExCUX/l+7TTcqvxJaJc3t/3JyVB1hJb5MaXsgqASzF20B1YYEEvZW8gL02Lb
         WC+2Qzm+aFXcqJntd0VnuSJnp2cwgBC14sqSs9P8xj73lTRgXSOkTBnhHCaTDdgrGOq0
         mmIYUKHlsq8zx5qfKj8Rg04eq95aYYKgZ4MDYL+vTiGKKILdaR7QInf4VAXeopYDmbC3
         ULfbMjTdGqDQILjgI4GuCFt5haCyWVBVf6M7wGVDJBfg3/aB51V91+cewwMlMkVtH+qf
         y5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6Gzidrx1HikqS9ICFconcGCYd85JKEM9NohQlAuXWSE=;
        fh=6EPWMucCl3I8AxUBDhveIXqwYMn9bT71DKVucMv/zxU=;
        b=XL3ZxK9UEap4dhNMlQhqs0jbHnw8q6boTTuEZWdK0miElqKmz27V/C6zVdm+h9LEy3
         VT/SrYZ3VD89rZ9oIZBDSsi7qk4W+gr8gBKf7Z2GJzgq/lLRdI9TYoyxgX5ZWUIiOpwO
         Do19YUtjkhcfVaMRr/1uGYC/kZP0t1m8aa4ccRUPLLRzBKhcUq2qo0DOq1XhdxMRBqXk
         2VWmWfqUWzSC8zKxY77B2qnpV8sSUUdBNESwKZh5XVutI67bMuRxAY54dlNF3MC86wZK
         OWpJwqmGTpd3o4SI1eRBfaXZ3uBypwwKOV6CgohDB28dFbv/scPAVOscPmgTeWcqbf52
         RHMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777474908; x=1778079708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gzidrx1HikqS9ICFconcGCYd85JKEM9NohQlAuXWSE=;
        b=Ws7TRwjuZtt4ej1b2dFnKfzi9YBdDEoWTlZdk/FRfESdb//alr1ceNA6q35ZiY4MK9
         +pEA2Um1EsxEEBQzmOxKguNGmxDm6HJr29Dxg4WqtxM8xY1nVXVqDRRMOPnVF8P1wUAC
         JvU9/tLYGy6t06smEtIRKAaFqJC5FcXbSAumxtq+hEyQS2wUcuzFvekPY4ZbXHjQ03Dt
         alG7Ky3cE7l2N1KHjjZ0J/t+L7intEYHrkh0pJIzyzmrZHFR8hVTKk5Dpdl7+1IkuPOv
         ii8W1hIFU5euB8m01f1CF8U0FVKuxbYLaDS5byw3azQxXJcjFRVJ6mIKSRsIiiCscoGb
         G4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777474908; x=1778079708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Gzidrx1HikqS9ICFconcGCYd85JKEM9NohQlAuXWSE=;
        b=D6hcMO1aAJsYk/qFL1By6xhR7kXHWSX1fjvSYxRwACxcgJxZLEOfQL0Iu0oz7cv5Ff
         Mys4OuUnCHhOK1FzWNCFTmGsKxg0OSgMKmy4kq4nLEu5gLST1kl3s71tt7XzKGHrbTNG
         rlOlG4CWSzsVWoSfSofr3ismY1nz1HzocndM3P9DdXEhoPCwGhPiI0H5Y+unIPbvoN1l
         uBSw/erVYtRtJv82ADIG8Kocn4w4Qrwoynrx9XFvTvxG/q4HrE3NjqYoCSeWiRf1rzWo
         bSIYRo2V9ESnOrcBwChiE0pKGLKH7CQW6mLqg2KaCm9WnNtgv8UjvZ86wjInnfLyfGjP
         0zuw==
X-Forwarded-Encrypted: i=1; AFNElJ8rmbIMRTEOY99eQgiTsId8Deo9j0kLHTnlsP1JmzHBSs6nTR8xqs5y4PFITduGk9Fr+YhSzfEtZB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPC+IS+GlJ2Pxf3DEbPLIMPV/vCr9t/q7M1T3P3bA8CQPyFA89
	froXf3P4JPSDckZ0iKJqOcslCiiR89tZ85zSUdzs12TZBAMtg3K6O3mKJs7mF/kB8mzNGCs/BXy
	AS26I9oyY6hGIMWvir/k2wzAtPb1OSZo=
X-Gm-Gg: AeBDiesSg/rejzI+McY0NpBuB+QnHy2ic7+xfly9hLIzuVfCEtsnwQKtvu4xOogQEU4
	6bSVdbOQsIGolFLJSXjNs80xv63kxysIckNwrtobCtBGsSrG5IE9xW/2XpF1mO8WBOdK6H3oh3g
	IZy2+JZUBYzSdx7DQwGh45xZHZr8ztU0SBQb8iGMKXBlVRPwwZHpbcTlbdSUVDGFaXNGYrVwSoc
	5ZdBlkwQ9EynPJP/KWdTk+e49dCk3qdWecemhhwt1B2u2EqrhQxOmef0leqrfOKXfbU83B/bc0J
	Tadrd/KGF2BI/UaRp+kMNeYymNsbipEertE1NNjqva9cpsBsbB/d5xYxIusP+ykvxB1U5BAMTDg
	4TmYlb2cSZL8imvNy9NWxXlyQ4dRag2e3el9rFiLygAgW7iY+blsxqCEm6tF51q5i6c6cv3WjAg
	KraN1ebvfJCoFyqcAC
X-Received: by 2002:a05:6000:2681:b0:441:1e41:19c with SMTP id
 ffacd0b85a97d-44790472ecdmr7562583f8f.20.1777474907562; Wed, 29 Apr 2026
 08:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429054544.123862-1-piyushpatle228@gmail.com> <20260429054544.123862-9-piyushpatle228@gmail.com>
In-Reply-To: <20260429054544.123862-9-piyushpatle228@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 29 Apr 2026 17:01:35 +0200
X-Gm-Features: AVHnY4JJydvG7p92mpdR9A8O6By1uWju88h8TjAOdC0jPpocQj3mzZPgv4o9lS8
Message-ID: <CALoEA-wjVgbCFAKJ7TNHLWWYKYdFDBMsvs7MH1LhWepVhLBg4Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] iio: adc: hx711: localize loop iterators in hx711_read
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 07:48, Piyush Patle <piyushpatle228@gmail.com> wrote:
> -       for (i = 0; i < 24; i++) {
> +       for (unsigned int i = 0; i < 24; i++) {

Might be a nitpick, but wouldn't it be better to have a macro or a local
variable for the 24?

>                 value <<= 1;
>                 ret = hx711_cycle(hx711_data);
>                 if (ret)
> @@ -174,7 +174,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
>
>         value ^= 0x800000;
>
> -       for (i = 0; i < trailing_pulses; i++)
> +       for (unsigned int i = 0; i < trailing_pulses; i++)

Why is the index unsigned when trailing_pulses is signed (this goes
for the for loop above as well)?

-- 
Kind regards

CJD
