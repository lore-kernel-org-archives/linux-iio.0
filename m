Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773844;
	b=j2TWT+i3ZjiTnZbc7fhBp+TEhYQTnnh5WpPu+JsDlUJ5yaHb0ouDb3GOimGNoFQO/7MK
	 C7mDelCB58b747vi4/FYQzn8xN/U00vKwsR4MFLz/xIQBZvV5ugpesQQC1S/c0qXJED52
	 MxAngKi/Hq0DE/dakroLhAn7WYN2GNhcdSHSKLO9F+uK5K3wwinB2iyuDUOMp/nB9t2sc
	 1t34T/Pwuc2GMrMhfsCpux4/K9TH17aB7+Bf+NZsXxTYWlQxKlHLkPW5dR1RaGrgnpfC8
	 /I1ac78IAgVpI6X+mS+jJNCpV8L8Z0kv6ivThDlH/1yZHQMwX6pKjfw04jMCwWQEEfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IbU6AikASsymoWZcigm5KICcvIS1yLWM5oIUuCyGJFQ=;
	b=3ftV2YothwqAFWBPQaIc0FUN7Vl1bkhtx01gCSwRHq8q12Eq70aP54rudL8g4kamQujK
	 BTiE7i2U4cAoTP4CDSd0aIzJMCVWpS1pdMnoXhb6F3yOdYcRjKiDV8dylB2t1YUIfzVsT
	 DRBUXvLH771op+d1yc9eP/20SBbfjEEF8lcbfA88KqBGrGErJFf2FJlq6swco42xM7oN8
	 FRjOgesabTL4yL9NbmGA8+Kbyw8i9uBxIcVZmjyF0GerAec3DnZnnsQWgLQfZyyaQO/ZV
	 2CaC02OrOGUmrFMOz+63PpnthhtGehUwDfX2hec+h/Rj8EFSI0p1BmJ/yA+K4R0WL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE41606A330
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 16:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DE41606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1846bc43c28so1197214c88.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792773838; x=1793378638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IbU6AikASsymoWZcigm5KICcvIS1yLWM5oIUuCyGJFQ=;
        b=nzaU3ccMU77AvpQXNcTtuC5WXz9iJYbaVtZBMgTXyyG4nq33Axd+wqILM/gXW5zNET
         qhazQYIP+HzqzYrlRqkWv+5N7lcFCV8ZT0hWkw+zBCfWY5kfu0Ibr+gWyUi6uquiA3DQ
         tt34Rj7EivfG9r6KIQ4lluL4+suBwLC/k9IQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773838; x=1793378638;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IbU6AikASsymoWZcigm5KICcvIS1yLWM5oIUuCyGJFQ=;
        b=Jura8bKV03iAMUVWj70Ci+TFmAIfJaAd65gNxVRBKZgleqd5i++fAtN+g/axpa1WYx
         KqYyCQdh1JH+VdtjYsVuEt9/mvCdnuJqO95QWGJd45a3AcvtQDT5LMh72LsrZXxoqkRq
         tyXNf59mcbNxZth/aYyW9BbCnBsVwq0h6+MMer8lo6qu7jgrc33UR0t2uNrWQ13aPzoy
         TMp1FFmzUFSWTaItaS0Ne6M0w6lbqxrVAhGwb5EAS22RH/A8b4N0FIymRljfY0XhYzuy
         W8tL7MrmwZM9DASy+7KdqmUS4QHka3EyzirOpI8GoFt1Izf1/5W7IZhPcwbOv8c/hO53
         fpWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwk7cXcrlvqOihYib82jYJqPLvKicCFAZelLr/R5xpfgrtvfNn28QZ+WgBFNSxMvzrx4qwdXQ1CpZk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+IEUKq3A2fi5uVMy8dGtNZVAar/Qt+s431Weko7IFHjmvWGMK
	VTufkoTFoEtg5Xx2FMclWEzxMQnfXvxXSWm8K2Yev5M7XSRxBiNTMwfoiUcliNDBcw==
X-Gm-Gg: AYBFou3PPBdOMDVesOHxs4zH9O83imVs2od/CV+g0jbjXuRW+rccO94Nb0FH8TT9kLP
	5bwiYJxyE7sCsOzhcJZQTHl4SEbfSkrz9zfDmq7f6q1nd7GBnS3sqrHcGp7CJ4yAqOQL5BCkqMF
	BY5BrIOsl5czcxm8y/UI1bbY9/j6EIPsEzBYEHAJPX83D04s55WtjLA53tYsvNlsXsbOYlR3BMv
	xEAfXpXcs59DRi1+haG12mmirgl587E+v+2Nz2Bspab/BUJbnIo2X574wPNh0GAxClLAnZ6woCq
	szVLtUiesIk1h1Q02QkJygQHDzyUNwZijj72Fkw2zG+32XOKDeQkOKJa09iMqob873n7gstXe33
	klUTLxiK1cQwgka77B8NvY4QfXyZqraYH8n4Cv1zype+/uomsfXkVZBeDseWfY0tHLc5A2UzGU+
	Vxua+A1VI/abdYpK7tnsGmRnDuo+ofIBvISZNOu8MIjX4hJ3aES+GLktOOtY9GKM4jFCQxviXKf
	mOmxSbyZP8ATS5EvTyOU+gJUa+/YXX4AYDbBqcp1VRHGft3qCrAzqLWu8LJCHkWgSe8QhFFguN5
	SV3wGXcY+I9Hr4zId4DwMb3FtSVvQ0zWZYH2bho1
X-Received: by 2002:a05:7022:4182:b0:144:fc5b:2121 with SMTP id a92af1059eb24-195c56ffe47mr4928192c88.17.1792773838113;
        Fri, 23 Oct 2026 09:43:58 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4a1d:784c:3fc4:37a2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-197e666f0d8sm1435609c88.1.2026.10.23.09.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 09:43:57 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:43:54 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 00/17] iio: Stop looking at
 pm_runtime_put_autosuspend() return codes
Message-ID: <atuOysdhmPRA7Waf@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <atm0umwtxZlQSAhy@ashevche-desk.local>
 <atpMNk6ymCpC5BL_@google.com>
 <atsEql7X20hGytXv@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atsEql7X20hGytXv@ashevche-desk.local>

On Fri, Oct 23, 2026 at 09:54:34AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 22, 2026 at 10:47:34AM -0700, Brian Norris wrote:
> > On Thu, Oct 22, 2026 at 10:01:14AM +0300, Andy Shevchenko wrote:
> > > After three patches I stopped because it seems more works needs in each of
> > > the individual drivers. Yes, the series can be applied as is in exchange for
> > > a bigger additional churn in the future. My preference is to see everything
> > > settled down in a single step.
> > 
> > There are limits in how much work I'm willing to do on a bunch of
> > drivers I don't use, can't test, and frankly have no actual interest in.
> > I'm sure if I spent a few more minutes on each driver, I could find
> > another dozen things to try to improve.
> > 
> > I can go back to the v1 approach (fix only what I came to do) if you'd
> > prefer.
> > 
> > Or, I'd prefer to stick with the sentiment Jonathan expressed in
> > optionally requesting additional refactoring:
> > https://lore.kernel.org/all/20261018211807.66bfea0d@jic23-hlaptop/
> > that most of these changes are optional, and that fixing 1 thing is not
> > a subscription to fixing everything.
> 
> Right, but my concerns is that in (some) cases you can do one step further and
> use PM_RUNTIME_ACQUIRE*() instead of putting first the explicit calls in this
> series and makes someone to basically do the same again.

I'm not making anyone do anything except stop looking at the return code
for pm_runtime_put_autosuspend(). Those cleanup-based helpers are
totally optional, and are not always all that helpful. In fact,
sometimes they introduce more problems than they're worth.

> To me it sounds like
> a double effort. Yes, that is_active thing perhaps to much to follow, but even
> there it can be refactored to something like
> 
> 	if (is_active) {
> 		ret = regmap...
> 	} else {
> 		PM_RUNTIME_ACQUIRE*();
> 		...
> 		ret = regmap...
> 	}
> 
> without changing the driver logic.

Well, IMO, this is adding more trickiness about the scoping, precisely
because all these drivers have strange logic. Here, it may or may not be
obvious to someone that the runtime PM acquisition goes out of scope at
the end of the 'else' and so drops the refcount. Then you have to reason
about, "what does the rest of the function do?" -- hopefully nothing
relevant, but that may not always be the case.

Don't get me wrong, I think the cleanup helpers are great for many
things, and especially for well-structured code. But they're optional,
and have their own downsides and risks, especially for unfamiliar
people.

Anyway, I disagree with piling your personal desires on a submitter to
"fix" when they're unrelated, unnecessary, and may cause more work and
problems of their own (or any combination of those 3).

Brian

> Whatever, I am not a maintainer here, so if Jonathan is okay with this churn,
> then it's fine.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
