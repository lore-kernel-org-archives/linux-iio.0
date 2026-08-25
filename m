Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB725A640
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 02:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625143; cv=none; b=BFfMuiqteqec9WGFbN7M9CL8PGd3QspysUjm60ez3rfwuBWe54L3AuEZCXdVTKo0Z7sZQQzGda3a6cS68kfysqa338xSCEmqlgsSL+ucHWYM3W+60c1MVR/j7qAAVJLwLpU/bMaRTC7NrKCyUTVe8Kt6D6DGoCG92tIMGDiE24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625143; c=relaxed/simple;
	bh=hZkRUfAojg3eoNr8a0Rp4cL09Bvzpc2kCYAeV8McbU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLSF3cGfVoCJPW8F1/woQnR0sZUViU9H/QvZmIIyW39sW2SSVcHYWwUMqOZgLD6+k2OKEThu5qVTzdZMuVyw5TG9c3qmRLNWiZh+BhgiiM2V5VEnmyPJyyorCX638M4grXPsv4BXJEA5j0pbMlxxSmDYYbs/b2lWAA/EsTke7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNDLOL5o; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNDLOL5o"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so4113254a12.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 19:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787625141; x=1788229941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLkQ5gc0U0wdnCVZK4qJPIUaaZupYGShMqc57SGVIns=;
        b=LNDLOL5of6X5jT67RdTaHuABZ0L/LBqs6gSVT0xbFOHY/X+axAbJBXgpQXwnREFm8Z
         5/QWCZh4L8iKN+afvHveTq6ZcNw6Knlqw8Br4bPJavLK6xnLPSbDVeEayoR8bGbS36Oa
         XMvbt32X6EnyTT8Oin83W2W4XJJ39CVhbE87k7VlMkYEM4eE+lqNnfOOs7wikraQ6UFX
         +upqxxO8IUmS9d40E26Mfi0edhqxuLsPSvMN1bFY+DNFL4SvWDU8PGz4UJsQPrFK7JOT
         SsTlYz2v4z/0p8HllH/P0O+eC+UInu7QQR4qG1C+fjgyjjqHuaARikrEx8asYoWfrLuX
         anxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787625141; x=1788229941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VLkQ5gc0U0wdnCVZK4qJPIUaaZupYGShMqc57SGVIns=;
        b=KKS4vvFPAHxH+d0ifM046RS7mRg6QJZDzum3U3BRs44EZUpcO0r58IqD+rO/f6NakT
         yCzb6XZ+ouno4ZxRzgvKG80oHiuaQOcdGMZFXWkBO0q62Laj76MvzTi1JPObvgl8Xlgu
         7m6SmSkUJg3sVZSMBxobOy+cSS2IWirTSUm3SPYDTQPmRzJzRXSeHNGwvLBS2rCgRQbG
         rQtwIbSom4AmAtRYoaQzDJ30vYLqvC4cBFYzKyBSmG5/ghUW7wFartWYThvkpaUMuw9a
         zx7dAPC1rZhKHyr13MsX8xUsRccVbLUgmSdblIKKseCIEG/knENyR94QGFc3BsqEXsnF
         wnxw==
X-Forwarded-Encrypted: i=1; AHgh+Rpvy8aLbBPyoygeMx/FTzqvAVBlJVbe1JZW+Tkmsck1KWpUgnq+WaWdrgxN5S0R5jBKZ+TC6LOiz7I=@vger.kernel.org
X-Gm-Message-State: AFuF++mSp2VWbvqlFblMtN8ASOddL5009ie8GWcanfFeI8/HqAZlLVHw
	6Nd5iiyo2FipiT8IFkcvFLnvCMv6G0xeTXwIJJROy8RrWgMYvllaM0o=
X-Gm-Gg: AR+sD10qH9G6iCKB7urvtc5h+HcVotPFiW4NTnU+J/qsSl+5uUxxSmsW9o7f6xaQJIe
	EBJ2XNetOTwEom5mm9pf30+1IAhJiuX5VSuiNWNMwy6aQSYbjhJaZopZTmsK71mz5OHYQREEoZb
	3IzWaZeO6hbVNqEzYU77LNdUqSUNdytSqmC3AylaowcLAPatZCvjRqVXEbXfBKXwXmVYhVRzlaC
	c5FJFXSOLATLC4s/p9Y3wkQdPRB4abFe10lpa5+nVau8Q7ejqVkcLLV8wXEbaADH6aa63AxXla7
	aKEikKpeXJy8JMzYcQcz27xpdpCj09fZguAdL6Ky0t4LgN6Ul/0rCAnxd5Nk3o7hUKDwYMbjHDM
	OUCQmdOY5ChPTNzzsWyjEhc/iH3PO3j389sD5g/gGQnhGTBV32nLmggJAvT7hlOM5UCZnu2wzOU
	GFIbgotn8sge04MsBYhlG19pQRzSqfgBM4DGJ/QjTE/sdM3jRMZIlj3Ld7fXk44uyu8SlXbS4td
	Q==
X-Received: by 2002:a17:90b:1d83:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-395c3367376mr51215702a91.4.1787625141490;
        Mon, 24 Aug 2026 19:32:21 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396420ad8b7sm657259a91.0.2026.08.24.19.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 19:32:21 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <triet.hoang@datalogic.com>
To: tzungbi@kernel.org
Cc: andy@kernel.org,
	bleung@chromium.org,
	chrome-platform@lists.linux.dev,
	dlechner@baylibre.com,
	groeck@chromium.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	triet.hoang.dev@gmail.com
Subject: Re: [PATCH v2] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue, 25 Aug 2026 09:32:16 +0700
Message-ID: <20260825023216.43373-1-triet.hoang@datalogic.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aoz1VN62zEuKPePl@google.com>
References: <aoz1VN62zEuKPePl@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 01:52:20 +0000, Tzung-Bi Shih wrote:

> This needs to update accordingly: SIMPLE_DEV_PM_OPS() + EXPORT_SYMBOL_GPL()
> -> EXPORT_GPL_SIMPLE_DEV_PM_OPS().
> 
> > 
> > This lets us drop the __maybe_unused annotations from the resume callbacks,
> > and reduces kernel size when CONFIG_PM or CONFIG_PM_SLEEP is disabled.
> > 
> > Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> 
> With a nit in the commit message,
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Thanks for your review. Should I send the v3 to update this?
Or maintainer will 'amend' the commit message when apply patch.

Regards,
Triet
