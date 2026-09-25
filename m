Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8E3890FB
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361388; cv=none; b=V6vl0/L5KGuh5tpp1maho9JzISxMgHnkDe4+BWUSfGfbLaxM3X004pa0Bs9QWv2dfgDDkgtt5ZoYx0gjHyupRBeWw1kZDyUnYSQzWHsXl6PyuHex/t0K+3/nSCfAS+SSGPiOQ23szl8BEguywD+0rlvMyWsAhglBwVhEZt+u+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361388; c=relaxed/simple;
	bh=ttsxstSQkiFn6W0emOQF/sZm8xB1JLtPixjXhsyDNfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr4qdOMb5/T+piG7h4q9plPfseeKTlp9H8fpKTRrPQFtjO2gtxzAnfhpM1BvYxryP0RS+x1fTOHuvdeDuJL6H/0Im95YftKZWRKLduGcdrm1G8SkZ88WwPDvCfXIt/y6zuVzXrekF8vHS/nx6lloME/2A+/mKaKUMFW2XFTKc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7BeRZDo; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7BeRZDo"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8e6ec4d9bso867432e87.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361385; x=1790966185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTI8JOYIkeEhDhIISZUKJnYZH98Is2I5ZYdQTGS/9Yo=;
        b=V7BeRZDo6Vp4XTc2prehK/dsX7sLaeIjxHhxVr3J+gqjCYTF1hRLq9maWEJNURHm9+
         2vBFX/DSHOuYIw9N1HdHKeIF+9ca3rz2AG8kbd6ZWvRwPGKJL3LVIcIeQd1Q3efqJSs0
         4L10PWP5NN7ypTHJR1e+9HVfR1A2lcxqeCUb64xA9mdngVPbn0XyK8Lk8lfMv7Z4pMgR
         3sz2vy5f9xlDhvPQg+58a9PAYLShLfi+rMi65TXQekpfBFzrSLeROqWCwfPQKL3k5Kev
         udIOp9nEM2R7bAubpVRFknbUrsghPtCEzZBSAgFQ8oW9dz+VHBBmd++gD4dZPwRWo3/b
         L5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361385; x=1790966185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTI8JOYIkeEhDhIISZUKJnYZH98Is2I5ZYdQTGS/9Yo=;
        b=Hx82gE8rAmscaf1df1bFAeEG6xI4qybFM/VgxZEtPuk6IPZzwhO8fsEynS5xxE0cFQ
         OFVkwo/TeGCy1/adJzaypX0ixUuUT8gVAxy8GFiAq2RjzyL0WCULWOVR/L/jA21wOJpM
         QS5UviNoZfBVtVh/RIYLLSY1ZPof0FG7LvF5TMlVH6X1hJJ8Js3TtCgbGqEJ/EJclyTq
         h6P5G9bFmadBP39WMQ9U7KazARw0+qJwG9HBAhIojPhlFIhgrGXfSpG3gEgde/MyQ/BC
         edTjVvBmGysxvpLs/P+1R2dOINrBn7v46s51eK+tndYGlNbZGupm0dkKeq0G58+rT2f/
         yOaA==
X-Forwarded-Encrypted: i=1; AKwUvBzpAfTVBuWZ9LnHEGuxXP/lAy6nHxxjx2EEp8mjG7CtVs4EADbSZF6gZMAM6RPgx+/r2ac53A+Rb0U=@vger.kernel.org
X-Gm-Message-State: AFuF++nRKPp1A4GRiy64xieROaEu1mH8sI3qNdroselKacOcNAcXidwW
	btZ4bO9K44fiLjWtkpW0VCNHTvEW6Vuhx1xF2nU4qvvJNzXCtyRjvKUI
X-Gm-Gg: AYBFou0zpI3qZjvqunOoezFspKYxUHHFjO+4aPerbERNRzQUTCVC7JfXeC0IoAxzeBe
	qQKpJY02mAopQfaq2AYjJ/sGrkw70cMZ12a4e0bydwUBPntl1Y4F6Rk9f+ytKe6xRConebU13AN
	dI9iCFnncO69UQ7o33lR0QB0XFI0lS/WWNtkGsxPAwoqKd2LgT22jqgw7kGUEWjqs07Lm3g9K8Y
	hUfn8FE0IgCKBojoyao9dWUBEM+abr9/jP/hePkwtGu18K8Gw0TRaamItvmiUW7aMovzAJvaRIU
	ZMZKRsKiDYfeA7jB7DFutIlWRBCgsAs/EQlnLeYJkz897KSuZox00eb7xMNtAG/aDUlDMkBnG7P
	m5kDIlG1/FH3nXQF0ptB4oSJ1D4/kQGn7LSeDlPz9hWRIIpCFgsccFbapjHXZSgaCuEo9jJJ0H1
	csBKKAcd7WdiCKmcQ4hc0xBNkTpuM73GpupN4Ampyzf9inucNvaaAMwSZL8GAA402Q7m7WeH2ry
	6YPaWahNHGux315VrJup3HHLMEoS+fzRFHXIO7eK+WKfA29R0g+JeJeM3paIfeIkcaX9c5mhdcZ
	GmAVuw==
X-Received: by 2002:a05:6512:128a:b0:5b6:183d:2a72 with SMTP id 2adb3069b0e04-5b8df092a18mr2193674e87.18.1790361384899;
        Fri, 25 Sep 2026 11:36:24 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e85e560esm649366e87.73.2026.09.25.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:36:24 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v7 09/10] iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
Date: Fri, 25 Sep 2026 21:36:05 +0300
Message-ID: <20260925183605.129614-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ara694wYo2qwBo5j@ashevche-desk.local>
References: <20260918122517.377565-1-zoone.rupert@gmail.com> <20260918122517.377565-10-zoone.rupert@gmail.com> <178992913316.706584.1446996024286841775.b4-review@b4> <20260921183106.231972-1-zoone.rupert@gmail.com> <20260922005347.069c490e@jic23-hlaptop> <20260925175816.75842-1-zoone.rupert@gmail.com> <ara694wYo2qwBo5j@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Sep 25, 2026 at 09:18:31PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 25, 2026 at 08:58:16PM +0300, Rupesh Majhi wrote:
> > context_lock_struct() is needed because clang rejects the existing
> > __acquires(indio_dev) on a type that is not a lock. The header
> > suppression list hides that today.
>
> But why you can't supply the full lock to the __acquires()? If
> to_iio_dev_opaque() is a macro it should all work.

to_iio_dev_opaque() needs iio-opaque.h, which drivers do not include,
and pulling it into iio.h makes clang 23 crash on the container_of().
An accessor works though:

  struct mutex *__iio_dev_mode_mutex(struct iio_dev *indio_dev);
  void __iio_dev_mode_lock(struct iio_dev *indio_dev)
	__acquires(__iio_dev_mode_mutex(indio_dev));

With the core helpers locking through it too, clang checks them as
well, so context_lock_struct() and __no_context_analysis both go away.
I will use that in v9.

Rupesh
