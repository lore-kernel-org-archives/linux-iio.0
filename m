Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F8347C6
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776734161; cv=none; b=VGuNx3flhEOygV4NsML7kku68GwrENcPdRkRdmslxq6XH+ZSDuk7x4jk7va8nRQLaTga4h1Dwl26MvgBKIIT69N8/EmKmdn37m05t8zfjksU8pLNOx1fKF1RFhdvzltmXM2CAOHNyy8R2KJrJMNiTNSAmbu4QzzZY5N8AE0v1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776734161; c=relaxed/simple;
	bh=ScqLkOqlRPLu3bY7vL17bSkC4LCmVV6rPgLEKaAB3Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSPTpgmGd0P77pvYz+UOopaOYejEiEQX8DD8gmO+lBztPEush0cfpFJzJQ7EIX+Beo3kqhk1MyuCdUet6DXrouAesaO99IMGSz081CdA3pce1llT3rXljO4EGc/mti0huUfurz2Fs75xxYfcU/EB0mItrEgkCpTDEOZ0Nhnvhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=YFNOZtVM; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="YFNOZtVM"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5673804da95so1137057e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776734156; x=1777338956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0D0S1YElB8h8YSBlbuL7UOCjGyrllWQRf3Xk+lHdOU=;
        b=YFNOZtVMeuTgIBkfT7Xwv67ii4cKRjn8IcMjMOmK9u2tqDl37xf0uwsJKWUWOuIZNW
         qO4aIz0fIfClrEdReVjKv+maVZ/22srmuz0zJIUkEJUPljCGEJq6HbGPz/Pf4YKEAIXQ
         8+Czk7yYpDiEmwRlL35TotGnAKbixQxs//njzNt4BQRTjOJg/hLPt5SjXtvH0oTJwIWh
         nW0bhwny25S6l8YtqywQKJbg4PtiZNtgCCvF+eUT8ljQZsO6aevkNApdlLJxdG2SBrpT
         I+7Zd/Z6NrU9+tRcxYgbF8En4zKUF3sJY2tHWUjfG7Xtl6Ub14nCPeauZNupGjaJEi3x
         416g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776734156; x=1777338956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0D0S1YElB8h8YSBlbuL7UOCjGyrllWQRf3Xk+lHdOU=;
        b=kXIUblxKsm4ZDSLInb/Qi/c7BOIGz6M0Iqi2BjgtAUUORcYFSk9Uk0pVOzw9tXtbWT
         q48X3RF5ct0heU5kGRMrVeWuid/sQtzck5XYD7QjrOJphMtaNt6dLUzY8+N9/Sngpldw
         BdiYg8gEnNj2n0LgMNWFJNwP5bdczYD4y+tQ+HkgDWy0JkpVtzKx8MxFGg2Q2awusO9o
         HTD7DwP4xXZfAPJpkOsav+tesxxpU4U0duPbaqkaAJx0XYqtUD7t53bSLqcFxNZoPuyh
         FFCZbPdHQ211qbYDY+LmUUM5bhyt2gq/XPqRz9sUW9nQ2KJm8NxxFBG3FMf1xOdj+/Q4
         3v6w==
X-Forwarded-Encrypted: i=1; AFNElJ9SyszQP68/G/wn5XshFLAPNOqs/GlljiZSNf/AQhuYxryNz6w8UkA2hPZjH6FqTZ7HYjpIu7/ZQ/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iDgpmDOdeZkA95LengyfYEqS2z/pSqpYCRiagmTnCUtUYxCT
	erdmdBNvftCVBfF5UCjDLMRPzYWrRCtlpyVVVmtbQ3s4besFbMNraX13Y6QgJpLIHgE=
X-Gm-Gg: AeBDiesCkSGrYcjywQJ5sD0obFnPhOMeEaeEwcT9grwaUbwWATPJrvvmda8RiH4XZOc
	UXgmkuP88EcJn4bAM3NDClV3CcELjQoG0sDEf2ngWhXeCkXZk9ZHb1sFc6dxxl6z/VXJq736R1Y
	z2KsTIQkedmUu2x3kjLZ+po28/I6PYhtij2vv3A5phLWnWGmLqiUA4WAInxVjlWk84YDu0Jk6yq
	uAi1Jt3/RkS6rhpmv3iLqmMyrHyY138r7Bt3L/cyKVE3/ZVbZQ2+Y1/n+R03TkX4ejtvaROit2/
	8dJnSMewQ5ums8yeOlGdu4dgSlmFJwjnB7EnS6C23QjwRoBM033RY+56918n6gB93vMylX/nDEM
	8IiL3y4YPns8YB9oN4BXOwx3Gn1rHN0zTQTVfIkXl8B7wJ9b3uqLpybUIpXSmIud5LKRvVylfsx
	tpahIs8UvDt6WD5ZckHZDidxi6uxUobCbYJXkgfnYv
X-Received: by 2002:a05:6122:4693:b0:570:f670:587d with SMTP id 71dfb90a1353d-570f670593cmr1328120e0c.12.1776734156278;
        Mon, 20 Apr 2026 18:15:56 -0700 (PDT)
Received: from sales-arch ([2804:7f0:d889:b103:1320:e321:eae6:2f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bf90fsm6995616e0c.1.2026.04.20.18.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 18:15:54 -0700 (PDT)
From: rafasales@usp.br
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	gustavo.arakaki@usp.br,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	nuno.sa@analog.com,
	rafasales@usp.br
Subject: Re: [PATCH] iio: light: ltr501: Use automatic cleanup of locks
Date: Mon, 20 Apr 2026 22:15:39 -0300
Message-ID: <20260421011540.555773-1-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aeHrF5HsRoWqazzR@ashevche-desk.local>
References: <aeHrF5HsRoWqazzR@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This requires a header. But looking at the driver, please add a new patch to
> make header inclusion block sorted and followed IWYU principle.

Will add a separate patch to the set that ensures the driver follows IWYU.

...

> Now this is simple
> 
>    return regmap_field_write(...);
> 
> Same comment to other similar cases below.

I will apply this where possible. This doesn’t work in switch cases with 
`scoped_guard()` due to implicit fall-through warnings, so those cases will 
need to remain unchanged.

...

> > -		mutex_lock(&data->lock_als);
> > +		guard(mutex)(&data->lock_als);
> 
> This is not an equivalent. Please, care to explain why does the critical
> section need now additional stuff?
> 
> >  		ret = regmap_field_write(data->reg_als_prst, new_val);
> > -		mutex_unlock(&data->lock_als);
> >  		if (ret >= 0)
> >  			data->als_period = period;
> 
> Ditto for other similar cases below.

Agreed, changing the original lock boundaries like this is just bad practice.

I'll revert this on v2 keeping the original scope (ditto for similar 
cases below).

...

> >  	switch (chan->type) {
> >  	case IIO_INTENSITY:
> > -		mutex_lock(&data->lock_als);
> > +		guard(mutex)(&data->lock_als);
> 
> I don't think you can use guard()() in this scope. Please, double check that
> this compiles and behaves well.

You are right that guards in switch cases can lead to undesirable behavior.
I will switch to using `scoped_guard()` here on v2 which will address this.
