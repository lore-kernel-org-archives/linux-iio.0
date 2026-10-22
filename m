Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691259;
	b=JGJDZkKaUM0jf1gwSdTxat3Dkprn0zijX/xFuvF0n4DWVDa4smRowqcwneniVTzT9u7v
	 DSIYO2qulAS1V4xvsKwLbTzP0nBXHEE3OF5pdf4E0AV0ekbsqtXq6WY0Wiq1YTpADZWWS
	 ba1ywxoKcF/m6FhVJPXqDGE8dKfZ0+t7WYSJdbv/ihlvvbe3+ZcE+tepoOPQGCTDuwPy6
	 gfC3gkZI2GTxhDtGroj1MaZ3dOQNrS0w60KcjzOHXOpUl6ZVGLOqQjzv840Ghc1WR3Tsn
	 S9gT2eOkyXa51Qmhx6by7QxVILVwUE9lRtZ+Oa+QGxBO32w+myr4Ibb/DOOP+u/e0eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SCWBGn+DbuJPekfhEu4uXLYMGCLHZ53aEkUTCOxglzU=;
	b=VddIGaz2gUB7QCPOZcA+O2hMqlOFWVSurz9/XNgu49CRCgkVllgcgrJhrR4pZBKGaOkv
	 757/hJZFzEQySkqjpwyFqBLvrCGtpRYjiKsqNY7Xh0IP3t4zLjCdbZ7YbqRn8xuigdHGi
	 Fq3LMNy5hLTj/UoGpuY9FOrDoGMZOq2tYQkaok6CBBinlffZdBi8SfsDyPO6nJw6X+mu7
	 YwbW4BUBg0iRHgPO0I2Pm3eq9NvAkryR8Z2gSMxZGfi20LdPg15Be9h4u5gG/TMeAv03F
	 h9iKPJ/nj4NmwAkqvdsEMFHpF1MTBm1is45mTu3x74x+vgLXP1olqZUMyRSFQlRM8Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22132606A31B
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 17:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22132606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-16079d54c17so74494c88.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792691258; x=1793296058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SCWBGn+DbuJPekfhEu4uXLYMGCLHZ53aEkUTCOxglzU=;
        b=RRvkm1u8IQ2Mlv0vsEHcUE6HX3QGyQ0zuC17cFWJH5zKzqe8B2RbjaeRf4virWKdfi
         BxvSMALrfPAT1sQvmdnR9hn0E8NkF0DPFeIIZicEO8qpgQ4YIQGxDGKxo0a7LhN0KIAb
         qrpZ4ahpNCVhO8d1q5QeFzajGWihKNT++R1NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691258; x=1793296058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCWBGn+DbuJPekfhEu4uXLYMGCLHZ53aEkUTCOxglzU=;
        b=Me7j+QTDd7F+357e6IaMc9Cja+RR7EWyK+TN2ONmAzabawSu8B0UcPM9eA6OWsofZs
         vHvEDoUc+FDm739+PEtmzKpjSQ2CDaYGxcbcHv/8TtZhiTvH2BnDg5SjGvHJB5IGuFgi
         MtSEOK4pg6CwjQLlUJLQdUhZnEZl71kfIy51Ko6qSS6ncA3mrg3JTCZggDZRXlWl2rvu
         J5MRkalpqm+C4ri301ue1RTBPbHpZkCDG+nYQ4Eq0MDWDCM3qnrRLD9nR1rJHLpzOcPM
         wlqghjizUQpIKCsSu6eKZI+QEoA6hfVGQAFrK3lb30OJNMKDQzjewxWi1FrjxSpCQ/b7
         RIbA==
X-Forwarded-Encrypted: i=1; AKwUvBzT5yQ8oAlRRO2v3PeQgFmZS06VzNMHn8eC/wNhzpk3NUj0Fa7i0JzgK8o4uwKBTOw4ayTpfyMeIHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZRgg7qAv4xEqepAC9MiWlS0pMuXh2FeHFstKpRlYCrO48C91s
	Ep4LG5Gq4gX4P/ls/DpwD0+ySTqjwbIlngR67lEiGkzFB4nNZUskUzW3F8F9pfSSlg==
X-Gm-Gg: AYBFou3ihmVQ4aML93Jik06BUiojVTWntT2/R7MfDLB+7ZKp/u/A7yBBlvE9a7wTfyK
	AWBhbBBdZlpkqVU7Mr0lHECnrQkyT3f3V5vROYXaiP8R3FFhMOjWpDn6jgm6Z5DvH+nyGuJogkZ
	jRvwwIYXSXX/XMzERoSzEyh6k289pZWw5G9IW4mSqrfZ73vlp3+TojeTf10q6ttyNT/wIXUFWwj
	pBpNRKONwhORpjPnqoWjeTUDD+Pth/7MlBizM6Vxub6+DqKmLTfh0EyNpr/ZX7jn+ZZxwpZ5Ul3
	DykfgJe29uPJeUmHrHezb+EGdn3JAy4hdorAyZf5fbw2tRpwGb+X6rjX9bEKXCXFkfArrYqpzRr
	/bg1djAdG11tdDwoWKE9FwD1frX10oKkhJ5ZJKyAjM4jfDp+e4U8yvFhPWBfK18qyWS1QmfmMG1
	BAW3b6RQN/sGjKgZDN6S/L9lP8S5xHtR+sq2sX57rRvDsLqT0YZKE7++jcUthS4qaMyYo66AmrP
	Y1GgjCUtruveMacIQ/2Vf4kbCIiZX/NteuEQO5FedspsbLN7WyNJXXDT9i7MJza0odr14zjisgc
	3f1a12zmLV1JXauy3p4=
X-Received: by 2002:a05:701b:2608:b0:144:c127:dd1b with SMTP id a92af1059eb24-190a7f02797mr6894593c88.39.1792691257861;
        Thu, 22 Oct 2026 10:47:37 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4a1d:784c:3fc4:37a2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-195a7f4432asm146724c88.6.2026.10.22.10.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:47:37 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:47:34 -0700
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
Message-ID: <atpMNk6ymCpC5BL_@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <atm0umwtxZlQSAhy@ashevche-desk.local>
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
In-Reply-To: <atm0umwtxZlQSAhy@ashevche-desk.local>

On Thu, Oct 22, 2026 at 10:01:14AM +0300, Andy Shevchenko wrote:
> After three patches I stopped because it seems more works needs in each of
> the individual drivers. Yes, the series can be applied as is in exchange for
> a bigger additional churn in the future. My preference is to see everything
> settled down in a single step.

There are limits in how much work I'm willing to do on a bunch of
drivers I don't use, can't test, and frankly have no actual interest in.
I'm sure if I spent a few more minutes on each driver, I could find
another dozen things to try to improve.

I can go back to the v1 approach (fix only what I came to do) if you'd
prefer.

Or, I'd prefer to stick with the sentiment Jonathan expressed in
optionally requesting additional refactoring:
https://lore.kernel.org/all/20261018211807.66bfea0d@jic23-hlaptop/
that most of these changes are optional, and that fixing 1 thing is not
a subscription to fixing everything.

Brian
