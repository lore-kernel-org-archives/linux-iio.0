Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722603C197F
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316907; cv=none; b=RBVTeCVRI6c66TsObpJi78LRaRiPgYCAcfeRY4AAxnq7PQLcKrfRDWkJ8BMbolURwWEVx10LAWEScaLYm4WNRs1zGsQD50bFNSRT3pixVLPTLwUWs9H7wVSQ1GoTy6by3OzfPS3gSt283R12lBoaYpsHDUtW+9d1PjOGwGnMjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316907; c=relaxed/simple;
	bh=Q6CCJRsOxKIkPpMuT8XEmO/ukJC4XnYqisb5E//FvA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uypTPAgfLoGsugkmha9meCJHTAp7Dhl+9b4upWgKz/d3ddHx1hmX8Ag4fBAQquttoYxpNr9+vcpd8NRDzujTN6V46OqxnoNQykxQ65nHVlMTkxyi/IXyVxlyoqeL+vH1ANvtgJMP3Sojy5H5Q5bqs4JLODLye5wInPwbBsRi+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJBgdG5K; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJBgdG5K"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so10104935e9.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782316904; x=1782921704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbd+VZy9Xtt5ID989pdKdPLVogIC6o/6YUS9xMFxJ7I=;
        b=MJBgdG5KLHMGCIXaHWOkxyxhv/vaWTaC60s9cfCwcKVZfHYF1dsomMFgZYljrzIdvU
         ty0V8k0TGm4NWQRi6c32yS+/dI0UOKRCLSsBd0EXBR/nYUtQVbiHWOfohzj5U3MNFZvP
         LVTqxhcJ7PeTFcQSRkSGZ7ZIQNYW+KJEBBkp7J1jzHPnQbnIjv9ilkXsngKSbCCnIWdA
         6HpyaQYJj/AIZmrRhKBfCM20Ym08WznLbv2n03mCsvln7F9mClBKvU0e1e2gBMhF3HIf
         J7vyz0axC31TBPPoe2OukgaCIFbaNmkq0FqnQoeyCwMUZsZ396z8gnqtOlMHFkfEOuX6
         s4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782316904; x=1782921704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbd+VZy9Xtt5ID989pdKdPLVogIC6o/6YUS9xMFxJ7I=;
        b=XK78WJHu/Ss1YJ45dA3/PH+el2pLv9PEkxbtxPxy5yyaBulHkiDKWOVVpL51ylCKQs
         RbE/2a+TMFJ2CJjYi9ftA1RL1YKBrTtdBgNeMtpTOPgiSryr3KYSlSZR/FJLcNBF4bfK
         ChrPS90p+7flewcBP/KS8+lwCOzu3Oim0FNIKdSZkQeRmcHwoiRBHtRVYxAYGhfR+Adn
         Z3xFe6O9fiZN53U98fbORi/Zg3DGdjVIRun78UHyIgM1K6qo4h2G1UfjIO2rn062/A3f
         2mjULdlZQ0o5u6NuvIHyvTWyFDf/G5Og9s2+E27uyAI8vUs0BnBkCmY8SIc69T2eeC2l
         yQyg==
X-Forwarded-Encrypted: i=1; AFNElJ8q13g99swCrCw0O/jyiIvqjqPJokGL69oJqsDuXQ1nwV5cSVvlhWH27e7/gZoGMEbGE3MIfIFSQEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7Qt8p9c50nf86h0vdnswCoQz5SJkRITHlV9ri9nokZ41tXoZ
	gx/tN4JAlTaS5TqCADI75kIuYENwuDVr3XNwDI0j/rRJJLXYW92NukI8
X-Gm-Gg: AfdE7cnWf7OfqQu/221sbdIVRw/4njtj5v2T1C6NpiqtXfNxPIPYLUs4oNbh1RAacS7
	Kf/5c9ciY+Tb5v6WtA1L/s8scvQdQzZNNkCLt9jkrGqQa7Ltwr4eK2HeMKWLA6ja7LoLCIFzUvQ
	b1H1tiLLMvautE0kCC4/DRwhKINoPuu8ly98vTwpXc+WEKtbUk8xY+hF26OD/KWc5Q7C6TXDo71
	OJEFUO/jpnraDLtv/Ep/JTMplotXZtkyLxHV3XU6U5in5krYvIFtnTiM8EBCWW/tZDUwPVLK6wc
	9KM3w2sU/jQf6ftjhl+CwIJcPa/20+Bhuzj/jb92ih+mXAMbYWktgaJdcoi7jNjX4qfe7Vx/ZAD
	2txuYBG2D3q4idRGEaKD0Vu+Xoo/o3sOYaI2OTRWWYwi+EjVxJWuxsU41Np/qCS4EO0l92KiIuf
	rsAf9kLfTT5U59eps+lXEEkRXz9aO4Tv6GpcztXzPHlAm8L4P/MwTl230IKRVjDA9aib4=
X-Received: by 2002:a05:600c:6097:b0:492:4a56:68fa with SMTP id 5b1f17b1804b1-49260872e27mr58948635e9.24.1782316903491;
        Wed, 24 Jun 2026 09:01:43 -0700 (PDT)
Received: from arch.lan ([91.230.98.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492640821casm1368545e9.10.2026.06.24.09.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 09:01:42 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: m32285159@gmail.com
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Subject: Re: [PATCH v2 0/2] iio: chemical: sps30, scd30
Date: Wed, 24 Jun 2026 18:01:25 +0200
Message-ID: <20260624160137.131207-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAKqfh0GF1WCF_85r4F0FTvwEdBPoihynx2VHmT+CtyDfYoRDbQ@mail.gmail.com>
References: <CAKqfh0GF1WCF_85r4F0FTvwEdBPoihynx2VHmT+CtyDfYoRDbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Thu, Jun 18, 2026 at 10:40 AM Maxwell Doose <m32285159@gmail.com> wrote:
> >
> > On Wed, Jun 17, 2026 at 12:22 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> > >
> > > This series replaces old email addresses with a current one to
> > > make sure changes show up in my mailbox.
> > >
> > > v2:
> > > - add missing mailmap entry
> > >
> > > Tomasz Duszynski (2):
> > >   iio: chemical: sps30: update email
> > >   iio: chemical: scd30: update email
> > >
> >
> > Even though you were the previous maintainer I should probably still
> > ack this for the scd30 for good measure, so for scd30 patches:
> >
> > Acked-by: Maxwell Doose <m32285159@gmail.com>
>
> I also neglected to mention this but I updated your entry in the
> dt-bindings for this so you may want to go and add yourself to that as
> well.

Yup, I'll modify that too for completeness.
