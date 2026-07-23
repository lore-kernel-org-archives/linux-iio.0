Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A03E49E8
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843598; cv=none; b=FXOmb9ju59D4L46BHjY0nVK7dfaqL4d1mN5eE98WmlgqGS4k58hhUgXVczMSxZyLkaZiLUXzaOC7GHlm2AokLdSGFn0frzBEiwlngEufF5qsUtdyrgQmVRcsLDkLe8kQ5bVEl5a+yJqaOx41b0bWkE9RghdPAHB6KmvG0WtyAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843598; c=relaxed/simple;
	bh=CE6QbJ0Y4Qn43kigjIDwEp1Wnu9JSb5eRbdolqTw3oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zwt0PzH/ID1ZFutrkQJfnjE7PjP3LqIwzyZuZORNNWprPCM5Wf9zuhgcRjIfzn+0g7/+gMAiSGGe7KnktzxgYiKFWLBrgpnAyc1olFDNQJX+mJrjb5RzW2v6PTSs3cUunS9OWoxx/Q6lt0U6p5f8+bJBG9ABNQ5XTNIfB32EIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYQ7QG4d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYQ7QG4d"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955484387cso8789275e9.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843594; x=1785448394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XR6TYjEYPo/3LPYXPQ83VOvH1XRnBdy8p/CW2F6Qy3s=;
        b=SYQ7QG4d7lB8DSKFhXSQzW0RW09mQSWKNgmrWq877dcvkVtpXouZaWQVzedTtJu27+
         KLbvOsPcl1X/jqg0rDcFwya86nB5/YCz74FoKQHvZW8WUhUNJ1eLvsGjZNMn4+Cu+0s0
         cyvvqLBijYYctwnTEVub7H5aaD6aNDxOPpbomV/zMIpVgo8gFSqovhckMYYz+2R8TItf
         BNFrC8nO9G+S7i3Z62PrUSTkpXkYyHT5Ove1JnsvhlUtrmJtCyao1OEcp+kUbVRDsCxM
         0+vCJCZiz3TgmO/D/pQc4pU2y4Wn9Kn2d62+KvXI9Alzoq/9NmY7NDzZLpiE0cZyMIFd
         dB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843594; x=1785448394;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XR6TYjEYPo/3LPYXPQ83VOvH1XRnBdy8p/CW2F6Qy3s=;
        b=nk5wQFA4I4gGB4rOx8jdxZZammS9NpSQJP4lp9MjyVHnP6bJAdAe9wS49vQ2egurF9
         0yadcqM+cmWXaj91dX/DuBS2xKyMBwn51Okqh2B6fMFqeHhsm/7sC39U6X2nCawdvU9q
         rpc6azwuxjN1auJDky30IAgO3/vp8aL9MuZzRc8YrkjNEKvfrSwFWVuvap5qP070BQr+
         BXJQidUl8lc9ZLMWjoIHOkWSlZvGztQSQjaZuon58EHpFVuKIq5IR1mc2T1+klN3zKTw
         P/qhl8ByTv87UU+IHACAMbqx6c4gP54rkzow8a/2uNHuZgDG6RrDBit7DR03AQbcq6ir
         7Acw==
X-Forwarded-Encrypted: i=1; AHgh+RoVb6aOJOfKE1o717pLSYUJ9twCWqOOaRTQDyxRL82m+uHybJ+hzBfbfhC3SS/EjNsVkdShscQCjyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YqhMZshoqGWJX5QmhNBOtt56HDgWUnDB64nLKwRQtmKi7USV
	WGTh7WDgkoi7E/nRYUk5EoRxkm3YKAphMwc2ahWntWB62pcGkCTSWVW8
X-Gm-Gg: AR+sD10xjYDb0YeTI6ZhbLEIW8MDkJsL6oSSKZCWIeaQqsvQ+FbR7qXWvRKFnphwRnt
	oHOHadhH8Hg8yBZLJ29bMjiFjzG/M/X8rYfNaPkwDSCnuy4rFT2OPKc0pg8KsQxCfbMUxaUD8IT
	ZyORuwytQAyZ3g2daDZyUX+CgFf7tBBeHh1u7EZ0YNSKkjhNkeWKYH+FSsuuTomNo25AOvHy+QH
	IcSd77jGX8t1XZCVJkLUazwORNvQXPdz5N02lbMVx8El+2d3qvHkH9Jvy7OjlgqPq3RACLWUb41
	DB2KhwF3CB/gk5NNJ/yHBbMnBwukVncsIPaFBUK6jJlBfARyz2C2cY1l4/f//iw+ZW5JxjEdIZm
	cMmbHZjqD/hKfesXV3h+C0GFmd6Us+dGJ9ZHqE/rLf7gNQegG9+oAsPYCXpDClSTD1+mlswb/pc
	y5xw5PrlDOCrkCIciQTIiDoyVzBc9yxTW2tbNHNRrCoMagTDiUI/nBJNO5Blv+mHvgNj9cx7fWe
	xl/w5WK7ML83MKm1tEkgTnA5QmFJ+wLF6QE8GPNeznARmeJIARWoM49L4x4r3lotrM8y+63R6W4
	Bk4bqqllvGZEE4nOp1RNzmtUmXHBpzU93Q8eWV52NBdYdWia74hijrI3UHiqmheVOLfi/qMOJAd
	y3RBTkDFGsjU=
X-Received: by 2002:adf:e18f:0:b0:47f:5b52:5579 with SMTP id ffacd0b85a97d-47f8da7f56bmr5423874f8f.18.1784843593827;
        Thu, 23 Jul 2026 14:53:13 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm20311407f8f.2.2026.07.23.14.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:53:13 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:53:12 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, mazziesaccount@gmail.com, email@sirat.me,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: chemical: cleanup codestyle warning
Message-ID: <20260723235312.432a895c@systembl0wer>
In-Reply-To: <20260723235139.02fdab3f@systembl0wer>
References: <20260723161040.20318-1-adinata.softwareengineer@gmail.com>
	<20260723235139.02fdab3f@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 23:51:39 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 24 Jul 2026 00:10:38 +0800
> Adi Nata <adinata.softwareengineer@gmail.com> wrote:
> 
> > Reported by checkpatch:
> > FILE: drivers/iio/chemical/ccs811.c
> > 
> > WARNING: Prefer __packed over __attribute__((__packed__))
> > +} __attribute__((__packed__));  
> 
> Perhaps a nit, but I'd change the commit title to "prefer __packed"
> and the commit message to something like:
> 
> "Change instance of __attribute__((__packed__)) to __packed per
> checkpatch.pl warning.
> 
> Other than that:
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Additionally, you're missing the driver name in the subject/commit
message, it should be something like "iio: chemical: ccs811: prefer __packed"
-- 
Kind regards,
Joshua Crofts
