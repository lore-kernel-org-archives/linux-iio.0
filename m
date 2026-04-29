Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF43DE427
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458791; cv=none; b=DTuSDPq6gKsb9XbVus3zOSsHYepgFuTXpP/4rtFE5XenrUZBUUm2PtBEvxSxp+N6n0Ge7BIgvCcfwWua2h8UynvEKJoRhHUSXJ+cg1BKQSJwqXGveA5AWHqmp855ePho5rrS0k7HXRS3S9lM7wqyCTCtmqcSOj8Y+QetiEBS1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458791; c=relaxed/simple;
	bh=u50229XO5G7z9t01fupbkHNOPfbGORjBjgh7z3/Gnuo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIo2OjRjDU4d/TpwsJdretPrPo5OnatqMWhdFah6CARhVFxV20XUeXRDbntN3wHUpjIWRB5174YUVuGydbl2o3/XbCfxFajcPfWSiZZTRuEH1Zj6aMv2Pu06adMYWdqyfWzLbj5wz7WOXYaY7kjd4g6lxtWIM4JfuiS+Lj3OVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcfsV/Xq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcfsV/Xq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso108397955e9.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777458789; x=1778063589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5RaYM4pbO+NDIhCViMCv1vPj5vNeDo4PbcOtSoLbbo=;
        b=AcfsV/XqTNEiz8/6oGaetdPCxwNR8QpJGcFcxq/WiB1rXwNxIX6P1qr5AXkmQWxLNF
         XtGtu2sBj0BIm9P8MurL8G7cyargwUIPy7h3B/bK0rSt9baW1KWeqsfNRppO1FW5x1oN
         LLe6yiiWLkdt8lpVbRmFm4+v7cel0scoGtGCpyOlm1jWIS6a1TJfiShesxkla9wvDRnY
         HK+3MkqodCTfQiMvcU4OY7IUZ8woQWVLziNHkBeQagkyKdMrz0yfSgKIuYVIJBsuODac
         nFGoI8woBVkGhPntZWTCMslZecg9td0HrkvFKu+xSxEeqAd+CNH5xVxPMZKQVC+GjJW0
         NvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458789; x=1778063589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5RaYM4pbO+NDIhCViMCv1vPj5vNeDo4PbcOtSoLbbo=;
        b=ZQjdVlBBs4gIa4cOhDiUNN8I3zAFQsnAdiAxWtSRoCKBTUbDD/jJlmC9ujUXPw1RuU
         pWFjFrfNZJM7h8/prcB50VSwyeJkVfp4Fz/2HJDo1hhBsNk7xdltCuTY7biFKHnqgrXx
         GvNBP+1EAOElQTsPndr7HSlK8z4fF22hRbWbgBL6YGUG1a4l50aGLEtjmSjvbwvZljl3
         vwFz41+vVsBx6YM53ANM3J6g0dA5mRiyIxuZTY8hoZnsAAFBMV2Q+3kKagHqr8+RXLVZ
         wValXv1esgES49w524FuXzlPN7O1GSZBKv3W3+NJ5qQQj9aqkfdEri03DcDewyQfY6Dq
         VvAw==
X-Forwarded-Encrypted: i=1; AFNElJ+TSNbB/W0d5hOc5+dKnaDlbEF+1njYKsRdJg1yMVgpbmGuEn4Hr/YpHlJPtw5gjrGBSC8d+IzbAH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgyienNpqMG+NzMr9etrZFBI+VfTgxuMGTkpTiNbZ7MsFhy11
	Ve91wIoxHV0JJSMEQn2W1jAX7TbX2pX1kZR7f6jRo2UJH0htNa9VKwE/
X-Gm-Gg: AeBDiet5rI1hkrJYoeKo0CaIHVwAalYFq5LTcxU3J7yLgqjMbi4I1xssdEZ5QIC7rJG
	OqH6UlLwR87fhZsgy43nTg0p9IjxgJcfaX3GB/6s1dZTJzRPzHCCU5ux3bVil0x1fPT2iS9CN+B
	APigEu+JxqrSPIzFuK159F8/AMQipU2bKczvjFnnQ8K1GmXxhE44o+Wuk35DguDCvKav4LYx8qy
	G6cqbD/udXFmBra+yXvRVpJ5se4jcjp0PtERPXsswuy6GHFLwRA6VlYQdqJLb7qOF1GwY+0I6Kr
	dGKnnDQFzpNIdeu/G2JJYyAiGGa1NWPuP8YBEXIthKarlEkOHx0barM1TLW4gKemDgMl++grCyn
	GUNgr+CGuLoUIhFAFuNeOOOfGqIY2zFKgdQNdqL+JxMg6r13YM1vc7nCQSNTXtke/wpiDGtuQYV
	zPwA//GLKHNY3eVfDgA2uJccDSDXa7YtCaucKKK2LKq243dBIVhrnpWIXuVtF8bkDciWWBx8af4
	RL+RIa3CZoyUrWEDu8NlaZ+T4+hPrGN+SWzxbSkQudTzHqHKIbxMSDliBLE
X-Received: by 2002:a05:600c:3b13:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48a77add9cemr109087985e9.1.1777458788630;
        Wed, 29 Apr 2026 03:33:08 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c310038sm22733725e9.8.2026.04.29.03.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:33:07 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 29 Apr 2026 11:33:04 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 04/11] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <srnyyblmyqiynomkxr6qiec7a3siqlu7s7d3orcnyfki3k6c7z@pxyfajin6hq7>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
 <20260428-ad5686-fixes-v3-4-9cff7bd67a15@analog.com>
 <20260429110750.2cab924b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429110750.2cab924b@jic23-huawei>

On 26/04/29 11:07AM, Jonathan Cameron wrote:
> On Tue, 28 Apr 2026 18:02:19 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Fix powerdown control by using a proper bit shift for the powerdown mask
> > values. During initialization, powerdown bits are initialized so that
> > unused bits are set to 1 and the correct bit shift is used. Dual-channel
> > devices use one-hot encoding in the address and that reflects on the
> > position of the powerdown bits, which are not channel-index based
> > for that case. Quad-channel devices also use one-hot encoding for the
> > channel address but the result of log2(address) coincides with the channel
> > index value. The issue was introduced when first adding support for
> > dual-channel devices, which overlooked powerdown control differences.
> > 
> > Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Backed this one out again for now.  See sashiko review.
> https://sashiko.dev/#/patchset/20260428-ad5686-fixes-v3-0-9cff7bd67a15%40analog.com
> 
> I took a look at the ad5310r (unhelpfully called ad5310 in the
> majority of the driver - something it would be nice to fix!)
> and there are some real oddities when comparing what we send
> to that device with the datasheet.
> 
> Understanding not helped by the bit numbering changing on the
> datasheet between tables 10 and 11 :( Feel free to suggest they fix that!
> 
> Anyhow, I think sashiko is correct and the stray 1111b will corrupt
> the command bits and maybe even the reset.

hmm that makes sense... that eventually only gets fixed when control_sync()
function is added as it masks out the 1's.
Those are needed for the dual-channel case, where "unused channel" bits
need to be set to one.
I guess I've broken down the cleanup commits the wrong way.

let me fix the fix!

> I haven't yet asked for sashiko reviews to just be sent to the mailing
> list, as I'm still personally getting comfortable with how accurate they
> are - but I'm thinking about it. In meantime please do take a look
> at them as they catch things like this (assuming it is real!)
> 
> Jonathan

-- 
Kind regards,

Rodrigo Alencar
