Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273B32B121
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075335; cv=none; b=nXIGOClCbFwdcryE6IpyqRTVQm24UQSvrdvw7GOXqRCP41lFKzRVeLEo7q/oKxJtw2EFtxP84hCd3Rp+uEueP07E3TgqejBJa/Tr3OwsZegcZPQoTIqKRTfWvpheN8W28XuvOorhuE/dLQEeujvJ9zcja6hSdiGf9yiy7ca15eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075335; c=relaxed/simple;
	bh=jrcQ/583+R3CHJddOVqfeMRFjXhkgPkP3fN87Q62ZoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbjpe7vXeVjAyiNg6bLms153rf9oMW6g4I7NMW1WQFs7+VK5hbEyhS0PiBxu9PppR7qlQerONE41O8jY8+wHjIMuq6VDHb8IQDvk0DzrybxUOqWNA4MGmclwMf2asZr69X6rjG1mPV+Q2UJgVzUofVf3vt4KrTZfUJP2TMUs1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf55xpF/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf55xpF/"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51778069c31so50832341cf.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781075333; x=1781680133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFFLmi2Zspzs29/Zve9KRNQHJogssJd0t8KLoa+VU+k=;
        b=lf55xpF/obQydV15uzESYRViJyqVvsIJOI1f6gz9JrKmeIVxS6XyHvsQGaIPzst8kg
         3JWU7A5LTQTlDvVNwK3l38aMltxn/o51+c3UzmMt5qJQKA2AGEVsEPy1nd7ldKjnhYSe
         6xxyzQCCzUcZehO+VMOmvfChsuDl06IfVlZoP0wB5ti0gYULZdgH0ZnSz9UNay7mv/v8
         DZUlZnMm1k5v+XSk35CfT45FRCClXoyuaNYU7OY/N5yOkbM4JjiLANhpjEQuG5jR3U6h
         xrSe7Xmv/v5HY9+WiMlbRUsERkZpyRDTl413qSu2V9suDX8RMoJ1McdKuYtcnYKZkQRR
         ofBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075333; x=1781680133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFFLmi2Zspzs29/Zve9KRNQHJogssJd0t8KLoa+VU+k=;
        b=mLlo+bT+03DYRbpI/fpJPMTWoF5UaBxb81UnepblvLwxSIifPzyQDDydycsfv9+rnS
         ad7PeQqQjAXRwt82noj28DX+wkk7fDxQpik0Q4zeoYlyzf9G+1GmS5KMsmGhJt6QyJjm
         1SpO2lkoRYjHeam/pGWhm9NIQrMae+Jq9oZM/0imDzW30xlN915JRQ1Olm6CWduJ4fMQ
         4sNSdHzM5yjQYcJF3L7QdYCi8UEAdCRgwo5T0FTTPpRtkb1P6lQcreVgEQ5ezQ2PBFYu
         NwgeS7URsqDjXd/jyieZZmU3L9udETORiSYN0xnvNay+ARiBoj0e8QeS+Mjihim9eqg5
         Q7DA==
X-Forwarded-Encrypted: i=1; AFNElJ+tXdrUz13XSzl6k7igq52+Yp8FCBTHHMTzIXcugDmZPNgk9O/GEa+suYV0YTmaQ3JkBBSxXcpwwq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWSPGyoRe+hZAQ/rUQ9aFxpKjNJp8bnOPTQLD0E4ZHuHaAqPP
	V5Px7FZbwZmt2lj57l7i6BEJkM3zdLPW0ehY4GPf9GeLYvJMuArzeV+gSuEEHvA3
X-Gm-Gg: Acq92OF7AlheatkUfvD0BizNicVzyPkg9eG9nMh+KLr46zG6/2n5+shnAO2VRKNcCcH
	e4WkeiSHn85poNP/KeAEps+9UO4I+q4x0GDRSEaFJvb/iE2ikhnblMKEnDm1QeONr2sKOMJZc4V
	gprL5dlnrMTS4661REp1cqMbyA3oNg1DoNYdmdzzjwbg93575w4AfPoZ3oWztZ0Hr3+lnDm2RgV
	ThamdhnxsQrvu3WwagceEau1zQYci1efY3z0dkR91Y1ptyi+XDftEd+f6hmPRm5+dnJUjdOiu5A
	B4JywRwURi/wtEeck5N8JVmNzDGC9TfoE3ATo1yWg6QmJQrI6a4/LBOhrMdrnk1p0miXR6HDWj4
	T6dJtuBHC5MEzTCoVqpvhxA21dz7o37D4NjxOznZ4aemONKMgeAEQIgkfatKQc+TC/ziG20jqG3
	32l2nd9CWAuaf6zMgrOf+Ut++vNw0=
X-Received: by 2002:a05:622a:2509:b0:516:daca:ea8a with SMTP id d75a77b69052e-51795a4149amr309829301cf.20.1781075333520;
        Wed, 10 Jun 2026 00:08:53 -0700 (PDT)
Received: from localhost ([149.40.50.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775da6f41sm202565081cf.22.2026.06.10.00.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 00:08:51 -0700 (PDT)
Date: Tue, 9 Jun 2026 09:19:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiewiqInppHKilw1@stanley.mountain>
References: <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain>
 <aiGRzFrSU6QUL4R2@ashevche-desk.local>
 <aiJo1kjN3_XDUdBc@stanley.mountain>
 <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>

On Fri, Jun 05, 2026 at 11:28:18AM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:
> > On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> > > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> > > > >    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > > > >                              ^^^
> > > > > Uninitialized variable.
> > > > 
> > > > s/variable/data/.
> > > 
> > > With what I asked in the previous reply and what you explained there
> > > (thanks, btw!) I still think your patches are not fully correct. They
> > > will require to atomically write all or nothing. If we want support
> > > partial writes we need to go with that differently (reset ppos when
> > > we got enough or more than enough data).
> > 
> > Requiring writes to syfs and debugfs be atomic is pretty normal and
> > works well in practice.  These are very small writes.
> 
> Perhaps. In any case your patch will break existing partial writes, right?

partial writes never worked so this doesn't break anything that wasn't
already broken.  Another option I considered was just initializing the
buffer, but returning -EINVAL is the right fix.

regards,
dan carpenter

