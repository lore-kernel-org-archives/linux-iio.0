Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63733CCFA1
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161528; cv=pass; b=mqo35+Uaz5cmqDJsOg2RdKYnoDnXegQVBXfopbhtv8/gAyvJ9lyiSjF0/Cl0AaoK0ht2Slv7okmMeAChivYI42QpWeCG5GKeWKZP/EVDITqxesLIZ0P/mFJwjjBs5jToBWgChDe2Q1cmqQVFjL8y7Xvm6NqpgYbje6TI5CvkuDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161528; c=relaxed/simple;
	bh=gktpKhrLyiZgsXkbC8Mv5N7h3N0Dx5x75ujNhIydRv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWZ526wn3yAerZzJ8BdsCmtnjA9wput7sJsq6HDVxsRK/ft6RWigQIDk0eJcJv6FXLRMZduc+R1nSmIGipwS9Wt+AC9j6vWrwtUc225gZmy6mf61YRozy05O09sUhOfmzgvDgKwnFVX29tp4GOAx81ZFvnvw2bOr3AbWIGenHlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEHDEA+A; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEHDEA+A"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so4094982f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 03:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776161523; cv=none;
        d=google.com; s=arc-20240605;
        b=Xoxi8bDihj5f05W08WXDrv6jnAw9DWNR3uODPX9PTJE+Y72F6bYViOcQl4yPdXGhij
         2NHspp3s7uOD2PLf4gC9vZk+qCHu+EzwPgIJojCIZ4ZnNgt3UuChUcXZQEFhE5biXPg6
         GgML83n03ri+UTz91HcVDgyusEeymFNO9DG8IaPgIMg6xYXt4HYqgmUcz7x/8ZkMoHQz
         ATYMLyQ/Az7rUNJAP5sE1KAmlaeOKUb6pKEqgdVYmmRX8/014jnsAw/Kob0zkprTFIK5
         EM7BnFyClNW5KJ+6wnzAde7Xp9W2e/f/odB83UnvZZuYEeRzXL72zOYSt90g5Z9pQnXo
         DxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=amSnPIDL2qKtCh2y1p48A0D0mHm9vsTeEabdiNpio4A=;
        fh=A6PYs1hnSyPsYyNgLSSDGtVSgYpK6hvmE0kXQaS55VM=;
        b=eanfMKsPtaNrfZ0nuCzKHDI/dtO6Ouqy+ank1TGaTatoOQUnf4C/mSo3bDf3sSAqgj
         jNINVCxjQKhxvwQGfD/mDmkByRh99q2MMimtELDoL5aYtY957Mgq7hqXOStLhSkdO5L6
         tv0YvozppSiWw7nbtiHpACQ/tobW2zNDSjJqx/W/gsV4PS1ovionzHe+QXiOKabPNo23
         gJ9Qhv37+cq1d37pPjEaitFTQWO1IilbkGq9tQ7ZnHccBOniFbxTNRgyJjdvSsiy5TYb
         kacY1/JYmZX3oaiIFojX9+1IrKAjRcFYeZArEXawREBy6D07J2t2Gjjv/V9pqcy8Rdag
         3R8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776161523; x=1776766323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amSnPIDL2qKtCh2y1p48A0D0mHm9vsTeEabdiNpio4A=;
        b=gEHDEA+Ayrvj2fuqjB8jA+D87d62jBX4WY/jTondsrEEL3RNErs5nAC4d0l6qwYb5S
         tlTeZzLrl+N3C2rnOZcJSK2TeEgWC0fpelaM2FoduaZHZLbQUUU/vRbzMifu83NxLP4A
         V1XferrFkpeTSY2b53a7AlcrYZO282yRCFZot0RbV1zbS0VByIWSa669mBC+MS/C01ma
         PHf7r3qFDx3yOcAgrleZRanq6Dic7VIvs18ocRi/jXnxJFFqYlqplo+iUQDyY0SsgX3+
         MUM0KGQe6dKBZOf2hrKm6RYTfhnubtj0cB2js0Ao80UdoQz7a3U4MgilaNbnwLWdS2/5
         xGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161523; x=1776766323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amSnPIDL2qKtCh2y1p48A0D0mHm9vsTeEabdiNpio4A=;
        b=ju+eZFQek0UT5CdaC4kG49NZikhwg9Bl89BuqpZaJsPLSuCjLwIncWPc2qPl9IVbCu
         dINynw7t2EWNd9gzoTPW1f3xoBC+kL6Uo6uOaJj5RTQWJb/c9M6G2b2cdMcMn3vywyY7
         hvsv90iPQ0Bz/tATM3E1/6DIJptOKIecfW1yx9z/acErvDDpg6XRspBHG1+g+jxn0wH0
         eCNLKqtyg1IJvR/Zb9GAQ/ygQgusThwKMwqtHZ9UlFRhC2bYNiXqDlegTmx7eVyEoPU2
         3eruRwy1qUqqtONL1LbfssYiXy3NlrXBaVrL/lVuktpLCZsyFTzGECWJ537VNr1CjRX3
         j1aA==
X-Forwarded-Encrypted: i=1; AFNElJ8WTq0NH/sAgjZnMpQPrheJjKhDYUAwtx51TahfUcKZUH6Ioc48JJtCVXyYJfcVijqGlAitZPmq3sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLA3ULYYFbowWkjtd7JBxFzGZsrv0YcS4G+y36EtzuSkRD9k0Q
	Yr3LGs9+h0sn36DWLJuE8cboEMZjx5x+O0WXqavBr77vnfOvFlcYsTMldeojpMFJJavvh4CqopZ
	qUyVIYjPoQs2J/XUjEzj9QAK6PoRnuYlTk4hP8sI=
X-Gm-Gg: AeBDiesLalq3j9Be1MG63N+y/WEVvAa3PS16/GOIVMAR3RVJYiuI5BVrQC1QBKt+dxX
	4DssucH6Fmvk6GLHocKFa3LkXuPIaRpmBZA3TVV+3Qxm2wSxRzEP526QO+oD0u9mfO48EcCphFm
	cb0Qc81xAAtHmNrCgBComJXHy0Ga45VzRZZr6a6fC36dOfnsKrqV2frzbHf6z29XNkuctO7Qyia
	0IsdYrzW/B82xP32aVYacqZJQtJLUl/9/3ukEf2pblXBsZyVAePystmhMsA+HCaLTHAMa9X05xF
	FRNo3PCRT4CbjNTVFOZ3epmBSZPLoRV3QYsgtZAmtCiOCW/cnobMqNdD8Fu6KQJxENLRaowQlF+
	vlK6roDOEtQPf9XtvBuiv5uzu1ouLPHlK1FkIl+XQ/fOruO9OnURUQgxv5YOKHzRErscXxpjiL7
	VgrMpa5j1Iohsom/LK
X-Received: by 2002:a05:6000:238a:b0:43d:7883:87c2 with SMTP id
 ffacd0b85a97d-43d788389b2mr10338819f8f.39.1776161523503; Tue, 14 Apr 2026
 03:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-2-joshua.crofts1@gmail.com> <ad4K-K3MpwD3U4F-@ashevche-desk.local>
In-Reply-To: <ad4K-K3MpwD3U4F-@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 14 Apr 2026 12:12:02 +0200
X-Gm-Features: AQROBzAAlcUriNQtY5Q61vVA1lrvNQ_aeSTgeXl_TJZkOdu94zvGGZu5fUYB2i0
Message-ID: <CALoEA-wikg1aDAfhgHYR10ep8a0Ab+hJ4mAUyAR4nuV4Uysj+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 11:38, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> >  #include <asm/div64.h>
>
> While at it, you can move asm/* to go after generic linux/* ones as asm is more
> custom than linux.

Sure.

> >  #include <linux/device.h>
>
> What about this one? Is it used?
>
> Many drivers just need dev_printk.h + device/devres.h. Some indeed require
> device.h. Please, double check.

I compiled it with the include combination above and it passed, but looking into
the generated .i file I can see a full struct device definition, so I
assume there's
some sort of transitive include behavior (spi.h or something)

-- 
Kind regards

CJD
