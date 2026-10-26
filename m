Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037552;
	b=xfafsNlYfkPPdr64hsbpqHQq6kOQHbpwAO7zkrogeXxv0ucOMRXVfqEHP7cvUiKwS1Tw
	 7FI36Qc91ctPE3z2vyHSCDx8AdbOyEc4PdUzlwa9X59BNgKCSMj0Zcg4vG1J5fgO7n4T3
	 PCQWPkj6ptiiit/X2SJcfUQbGyjhWo1kw9Nn064q2UkG1dqdmx8vkXnIXagetz8b9VUD7
	 Tdu1GzjBYKNZqwyUCNH3CyU4sf+YzlTSShnTdHVnwHYMDJH+Y+koiRgIhTwiAsl5FXHEO
	 JTJYEBVnvNt+DsUjVXfIXW7xll8nqOD53XnR0wHpslAX9qKfikR5z03edwLYXZEiuLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=F2ljx2alcBFTo6QIXmQ3PZr1A9yTe7fXLFSuwRXwTto=;
	b=mbBWklWW4FvrYCJJlnDgiGkl66JbkuUJahFYX+GlQU+wUeEAndg2eVRrzx3vqLt+UQw+
	 GMI+uya+7ds82tmw4SSasX7ZL7PJGoo9ep8BwTPZunx68f4tgxz7EkucuAMTmFlusxih/
	 l9UTS8rmoxB0XxwLdnAcpkTcfTj77RVP9GragweA1X0/DSs4a5SVwyGyFahSAe9BkrUPl
	 +B79nX3rLBXGnVeqEB3XIeXEdxWbmagdIlax1c/cWjzj6Yfnorvn/bthx559Rbtj5RAhX
	 trCC2JhayHVLde06wvrUWPMgHRHnR3LActHT7E3jIBy+nLOjSJd3UVAy1WAOc2JOWVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XPg83Srk;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C1606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 17:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA3C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XPg83Srk
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1931ff67a29so1420288c88.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793037551; x=1793642351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F2ljx2alcBFTo6QIXmQ3PZr1A9yTe7fXLFSuwRXwTto=;
        b=XPg83SrkdQHxiXw3yuZl1WwDqwjS/+7wNLUClFJaerBhuwBIdZ9u+y4krqfdH9ywCl
         R5a4pEVxDrJr0cfry368ztlZLV4egXfstqW9o0j9KwDhsQVKgGDmJHk0nB9uIQRMbSaJ
         WNuqog36pgJwHs680KLgimHuDP3YuFzGR3O9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793037551; x=1793642351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2ljx2alcBFTo6QIXmQ3PZr1A9yTe7fXLFSuwRXwTto=;
        b=TkzI6tUpY0jCrqrd61HZ9KHe3kjaZtKp81KjwBQyaLLUoCHGuKAhve1GdUT4EHuSoX
         MPU1YoMXYSf7hMeBh6GrO0oNQNms8lNoqvRrsXoers51rwC/ZgWoAHCctIYGf9FWN9Gj
         IB1EtGxeb2qR9czRD454uKgMLYShYxWsTFM29XDoBv1lLgw3UnKm6Y4XyrlnTn0hrfRr
         xAahDeVLSr+DpYOq2fnMP77RUEN6guaNoNFvFBrraHhV5H2CRQLdG5e7pC0YPpT+SIoa
         WZFHBdEwIPqA7A0v2K8D2WFpxIEtdFJD1UBw6izmjnqY7/m3ykxB49arAQO8BHvQXhsK
         y6oQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5mBpnFn2AgpOURB2WmgJxwDoaKo5pIQjvClJ4ysHcBMyiMvsCb+pccD8nqEYlBGBvGdo6F8TtZhQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD68LCP9GBKsG8v+zmi1otisYUKdGMPt1ennwq2p9BFonzCqJD
	crYez8RNRnA0PTXiy3g8Z5B5JN5AuANwaKTWh2U81aeVsjkKKh8q+srz5Dreepl9zw==
X-Gm-Gg: AYBFou3jk+mtiwPy7Emm0iu4IWoj0alfp6e8hbxqWeHlJEmPsCCOIMANE6HIBPfJ8Ae
	LT1QxkWc0QtLdmk+6a0NBluRikWaREnlNAAGOobQeN9vjkgiEM9RqVR9flcdxHIZNBCcLnrsH+l
	U6pTrs5nYlZT2Av5lvw9hyqJDzYUAia5t3xvUZPDqlCPSzkc2ayMBsiTTCtokQ7c7Mzry7Aw92/
	4bvsXpnFNTXQGmA/ZZ5cbrigXUAvgbyUPimHcbofecgOfC2GfzvU8l9lU2BujxUnXrmq3Fc7jJq
	LzEmGSgwzp4mFhpgoFKTWqSynOIVvEzBfUmQec8qNaE+SuhTgywFN+QH7xj4VTrBtcbShJCMRSC
	jNsQ/agRevKQgwTfxH9HYVph0JrdGJyeKJpO7cWyTf1f/AyuKpCfljV+cj4H6gZt0dXlrKZB0t0
	mpq8lfIdiVx/mMqP+Jpv5KIaXmWdlrP+jEsVPs6xjK4czzfFqeZraLJpxdYcw/2e5xizP4iV28L
	Szj7KylPXf/USWJsdqlpxB/eBJM35i4X4UYxkmV/IU/2ePRT1kv+PabpSW+03iq0lYlArrdj9NH
	yZHZ6D4b1iQIbZhKpLPTl8Zabq4Fp35IogwcgcKw
X-Received: by 2002:a05:7022:b058:10b0:19a:dc0e:c20f with SMTP id a92af1059eb24-19adc0ec4e1mr9832825c88.44.1793037550837;
        Mon, 26 Oct 2026 10:59:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-198a0f83cedsm32565975c88.13.2026.10.26.10.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:59:10 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:59:08 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/17] iio: light: tsl2583: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <at-U7LvkoiNAJ6YM@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <20261021165858.v2.16.Ic3775fd68cac415d959c0456c4d4c36e9e5b95e5@changeid>
 <20261026005504.7482bf26@jic23-hlaptop>
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
In-Reply-To: <20261026005504.7482bf26@jic23-hlaptop>

On Mon, Oct 26, 2026 at 12:55:04AM +0000, Jonathan Cameron wrote:
> Note I'm putting these on my testing branch which I'll rebase
> after rc1 is out and then they should show up in linux-next.

Thanks. I can't seem to find them on any 'testing' branch [1]. Just FYI,
in case you were intending to publish the intermediate result. If that's
intentionally a local branch, that's fine -- I'll check back in later.

I also see you're trying to partially rework/expand/add to some of them.
I'll try to review those, based on my local combination of my patches an
your patches.

Regards,
Brian

[1] In any of these:

$ git ls-remote -b git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git | grep testing | wc -l
9
