Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88830D3F2
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021470; cv=none; b=CkKJUxcUgctxqnCJV/8l6FZN8/b0wkJRZvKvNf1CPwTR6IS5Ol/nVvrwlnl9UNjD33MOReL+Im4//BA5X1zPOsrL0mWU7y1RPOij0exkLJRxL2uJRtMtv+bopPTp9dRxKuX9gEwc9N1dGMc59GsY3u0XlNkCnN62skpvPhwAO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021470; c=relaxed/simple;
	bh=OjDgsS55oXtqSWWckaLD9e2pMOeMLM3Tr8Ojgm/mMx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYOlAmouYoOEiweO4q5/x1Kr60/WRcjloXdMR58z5ZwX7Z7sG0eLsb45ev+owMKJCHhDViHHJz3PU3A5cM2s27qw9zlEc6+2I6yq260vCGFdHOE39vgRFD4O/8LxTKolcwbdk1t97RUC4yXYQbaeKSSpFp/4YWf4Nv9Q4NdUvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ4XNp8z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ4XNp8z"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49800c6a846so18024415e9.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786021463; x=1786626263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1usZWQnPiAMx/O6CPfT8QtUEsv8ETw/++b7xp8yc0RE=;
        b=BQ4XNp8zzWZOeeyprY2L5/p/6xv7FppYJjkeYZubyUsyRq+JtM1Dxw6HetT4gRog7g
         2yBoHkrzbY26B84kb5myXWCONi1NFotlCEqSVk6qyp6se5DVIUtGTGgfbin4IoY4Oq6r
         gr9QCf/TDH20U5PmWa7Ag/Qn4U/XbxMmPCjjn1fH0XgVLoqDRwca4m6WQ/kY1EpvgH83
         0dp8dTVtAtLvASJ/lOnVSNeoOe2uXyslkyk/6fEyQ9VJUR3zSMJa9Gl0yvF5P01ceUtr
         7auCgS2IcE66h+TA90Y4sFlFGQO2TMwvStrVwOQFmfVKJwXd5dqeVPY53UNvUxiBLzAN
         gYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021463; x=1786626263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1usZWQnPiAMx/O6CPfT8QtUEsv8ETw/++b7xp8yc0RE=;
        b=Rt1Z+ayWy3bN8EwRayXvrt09aLi4Mrj6t88Cnc3z4sDxCGvcRQ/BafBEIGn1slVnjH
         u9jxhg3lRhR2h7fQEd6uM6lj5zZYzzY0EiLcPQHWiTgE29hO6HoZ02b/jPYrQuoJBbOH
         9BtXwaB8P/vbcNgL9fdDQagz8GidrpzJJshtUtyyu53dOwX0HkCdSNN5EB4v2cvxExxw
         C15ELRocOPULglL52UiJdUs4wbybkVuX5InSBoaYJUtTYjLzffoqQIljj+s2rfviE7IU
         XYTTuWBEKK9MO+BlDSjnI0dsjBv7haIfNAn+KjMgaSNsoNVUByrx9r28qgiICmW5dI7+
         TaOA==
X-Forwarded-Encrypted: i=1; AHgh+RqVAfwPAZNxKk/VqUMtAdr6o79pOliVRvRnFjynZLNSm0KM1UqGecJ3024b0OaW6FixTImVKi4wCiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolbX3fQiSs3L79VzkakCfkM91o+r0OgC9ynouUGzwq127XDKk
	9V8jX9s/nhAeBdTghRtWuXp4WJmUB5s9akdAWN5s5DdgbC4tzlx8ZBCl
X-Gm-Gg: AR+sD12cKY+IA2SUQG4jydtKw/x+iYRxfKTrRLJB15cZfWlR0Q0ip0XlQOqE9+YoQsR
	KVKqM/tPeJoZr6+OJ0ktrFZw3+RMyL9ml7aoOhDPZ1jVKNI/Q8L8nEDeSRaT6XXcXQijSpXW63b
	gJOUgWttrxp+mtdRT5DichXt5xrXQGMy5p7yMuY4u6wJKdznqxhKhDtsXAX7Zs6LoFw3aoWNEgs
	EutZhaWD8Od+H9TPIw+METOTkRDv62Nk+sDrj4n8zc/bMuYS3kxZldI5ege8W0Pz3t1joVjtZYb
	TQAvdwMorCuLvCCOcsZRzbWarEV9WaOgXL33m+IwwMBxKPYYgkHfCGMlkCNXm/BZRprXjAa1S9v
	bkX5MZvG6JNiCyFgDYv+ZjXw4tjdiJwTDfMNv1vLM2BOPIxradyXrYTFoOmRWqVY1ZfNxEyYLBB
	05H9Ox9v7IdZNvTgfdVHIhQFTQizKc/5LOKCTw2PQ6CZ56DHKg1Ags
X-Received: by 2002:a05:600c:a47:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-49959e2eb00mr14758895e9.9.1786021462475;
        Thu, 06 Aug 2026 06:04:22 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421b1e2sm78185215e9.8.2026.08.06.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:04:22 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:05:33 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, Jonathan Cameron <jic23@kernel.org>, 
	Maxwell Doose <maxwell@maxwelld.cc>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
Message-ID: <anSGfoKJGfXEL8VD@nsa>
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
 <anRUF3ucjK7n4iN-@nsa>
 <DKHVKU2TZOGF.3D3IRM9JEZS2Z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DKHVKU2TZOGF.3D3IRM9JEZS2Z@gmail.com>

On Thu, Aug 06, 2026 at 02:55:25PM +0200, Wadim Mueller wrote:
> On Thu Aug 6, 2026 at 11:39 AM CEST, Nuno Sá wrote:
> > On Wed, Aug 05, 2026 at 07:02:55PM +0800, Linmao Li wrote:
> >
> > I'm also not sure about the above. If the regulator fails to disable I
> > would say things are already in a bad state anyways. Is there any strong
> > reason to do `slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas)` before
> > disabling vdd? I would assume that without vdd things will terminate
> > anyways. Asking because if we just disable it then the above stops
> > being a question. Though I do understand it's better to gracefully
> > terminate things. Just not sure if there's any added value for that in
> > this path.
> 
> on quite a few boards vdd is tied directly to the always-on rail, so there's
> no real supply node in the DT and the regulator core falls back to a dummy regulator there
> regulator_disable() becomes a pure no-op that always returns success without  actually removing power.
> so we can't rely on cutting vdd to stop the sensor

Oh yeah! That make total sense so dummy me :)

- Nuno Sá

> 
> Wadim
> 
> >
> > Just my 2 cents. No strong feelings so if the driver author is fine with
> > this, also looks like a sensible change.
> >
> > - Nuno Sá
> >
> > >  }
> > >  
> > >  static int slf3s_resume(struct device *dev)
> > > 
> > > base-commit: 0efaefce4e95a3331550329c0078b2fb38b3ff1f
> > > -- 
> > > 2.25.1
> > > 
> 
