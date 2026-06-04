Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F935B644
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558295; cv=pass; b=h/0plm77E+DhpLEWLBkvQiQTyudUNXu3D77yifCOLeUYoHuX4j4UKKzOfYTHg12VusjauiT4GH2mhSui/tqHjeFNm9PePrEMBgjCUnj9C7ZhJ6Jf7BmA6URgdco8qw/iqG0b60cfhPy/z/JCvf1PqwhQECE6AkkpNM/TlxYtdgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558295; c=relaxed/simple;
	bh=DKFQJSr60rOy6vcao1Lwqtf7j7TXHhdaIeIbiFyYWZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0F0J/VVHMJGp8Vk2I7l6+Tzh+8dIcTraHWHhIxxN9G4mUNuKYoFOZn0+zwuTeVPQgADNTu5z3zN8btwciQm5Uh5PsTmJ33PSpsN0nJF15TIOpMm8ur2YlmJry4+Mg3mJzYXhFLqBchco5d0bW7CGzsiUEaUpYtOdH+dV5Z00OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=od3G0lFY; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od3G0lFY"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so247649f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 00:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780558292; cv=none;
        d=google.com; s=arc-20240605;
        b=blWz+CKXR94j4lwHQD8tWhXOOgkcftPuIffmhOaki22swkiHp1jAdJvVZipg0Yq8xm
         9g7XCtNj20MqpqYBXzMBJRISqzHpmmPzysjZIrt90ZshJ/ZbteW9aOV3ziw52x8A2GTP
         WZoOnLtsZDpvHU6dPsACQTJMTYRMFbPd/DevXtlhBw1Nkg0IB1lFvw9HUhTpkn0zjX+m
         4Ste7sXbBH5o2GTDUPCGqXGwoSJbMBEkgU8T7otGvXSgKfWz4tR7UWze9kt4doaqNVUt
         jfKOQSikW5KAiItWU+v/y/NYZwrxONyd0Xniyvc/8nLLgwidOQkdyUEnPdFwevimsX1D
         AiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jzY24Tr+fRa2/cpl/r1y6javpnWcJUtTeC3m1aGiTPE=;
        fh=I8hTCvb/OMCCfn184ew87MMT34fHX6Gn17UvT1B0ma0=;
        b=ST6xaYdaaiRXZcQ7zXfR7PcAE+qiFvdtYMKG8bVWQiU75Nxh12hg/fEAK3SCvB9YSA
         z/0ZMR66i6LxsjGS4CWhr3oSQ77gJyXcTl+Qtr5FQGoGLDwrLyiRYwI87y/+yjFzGF5R
         gVWXj1L3CHVtcXwp+pcyIbKhFxxpixdgwTVZ5DfbTikPAaktUF8AmtjGTCBv9MTHcpIr
         pBm2bYZppgWE5RfzxrSfgMMa/zfpb58wmkzPiqgtW6e8WFKWQ6RzL0RYckv84jLQ0P3O
         tWPYzMtjMoDyO9stZw4QMH+LTKtmzFX5jHzWl4XnWRLH/cYT0wIQ+SWf450n009N6geT
         208w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780558292; x=1781163092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzY24Tr+fRa2/cpl/r1y6javpnWcJUtTeC3m1aGiTPE=;
        b=od3G0lFYACUs1tjJQnafoOaI3RMSF2nHT5PHJnl1xFWgiJmiuOpqdXUY58umZg2LZJ
         bTwZT2iUpxTU47w944V5h8JQaonboAB8+w+q9wMiYJPEHsVpYlhh6Y35nqmXCZAens3U
         sV0HYMDHN0n+1EA+z+s2+chgq54TW1Z2077untLxiMw9fvxC1T5cZi7E4CBCvk4yshn/
         Ckr92Wt4xwa0O29KjdDkXfDWQC0w2wMe0k5pEM1kwodDIZO1yRIdh6wqllSoExmHZ+0V
         C6qK+iuvHmEoxZNd0iTeZHew/yt/d7x6/qf30AiPywlpQGERlYj/Px9wtWQDUHx3Iqj5
         ZtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780558292; x=1781163092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzY24Tr+fRa2/cpl/r1y6javpnWcJUtTeC3m1aGiTPE=;
        b=o5mjMcw549YXgjAvKANjojpbvZDTuzZVrhJ9wnVVcTaQrRVoOfn5DihXR5aK1O8lc0
         crR9Nmwp76kewtloIYYssJngM+kWN26Tlo1J15/5Qyr3WiL4mpsIyXIc9eLH8Biqf3ry
         V61xtcP7Q5jv0hfApQlluCnfkTFlrtwSJYVRQsn6JpDxdhTXMoEOfOnNXpEmRriwbOPD
         W8EMjf31j7jlp3uYmWVJCtH9SNoCxy7f3MAmOPjfDi7C52htiMC1xs2hRifAn5lR7cAp
         L3pQEINyp+gv0jFhZOTr6noeSOAByIGBFGgDd2bvtPZ7tDmL13Lxx6RGcl75xqnj5dGD
         uX+A==
X-Forwarded-Encrypted: i=1; AFNElJ+Q/jqpozMPwqGs5EmDe5k7q2Ag55A90Pt+ZRy6H5ExapQ/SxDHEnE474ZqLif/ZicgHNuKsJJsQXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoM6lHnakHIrvpOul9CEYtD+pHaU7+UlYb7ZP+IqIvwIvT4Qtz
	4HJEPLwtgXEsvLXR4JTTbNxlxvYON/L3k8YVqfCf4tyeYHGcAEXmmu177d3nzRSkqbN6upC4IT6
	osvJ05LSUskbwclBVD3Z4HQZ/ysG6SPA=
X-Gm-Gg: Acq92OHaAkSGLcTid+jzBuTCXSa04gOpW+9MYoa2V/BFUS6unDckUWWmq48noqBb4Ee
	6kPHoxUN3AHRSQQ3XQ/cj24dZ9Eakcu2Nwxz9mEK1DpnTzzdQKKqYkZvkoxzvLCsmqq5BdbNd5U
	ilQ48GOh1h0zRzxtdp/UZ7Rpwm4p1wkromEPVwppaNHHRW4suyOpTxCE6C1qlLKkdJbXqIGx8p2
	IhWeW+9Q9wJvpmrkQ3HaFXCDzotZFXxxoc2WpzTNbv4tGDz0ZQ+XbYDKSNqEXvPLD1J+cVx70ea
	ct3IYnIb7CnEbMfvCQ7pJqW+CFZCgdJRBKOjoFEqLICi0sEn2B6SO+TiDmWC9hCzeOf4xcv8ggD
	efUbfkiyDm9C4L6uu0N0zghdnVaV7zjo42nnB9UxHOY4tRmUPv+ABGHUHQ3WzZE9LTctmV12cuw
	2YRGEyj3IOnqbIlwgr
X-Received: by 2002:adf:e542:0:b0:45e:fa7b:a7cf with SMTP id
 ffacd0b85a97d-4602178af6bmr8110302f8f.2.1780558292362; Thu, 04 Jun 2026
 00:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
 <20260603-opt3001-cleanup-v5-3-3ef7b926d555@gmail.com> <aiEdnhETWDPUzF8M@ashevche-desk.local>
In-Reply-To: <aiEdnhETWDPUzF8M@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 4 Jun 2026 09:31:21 +0200
X-Gm-Features: AVHnY4JORFdmWzL894ok5UoFWWULU58-3rcQxFcSwHBJzPDEYEGT4DvTomAbN5M
Message-ID: <CALoEA-yTPwzHRq179EwAepet1whLWEhikit=kw+ueizRV3h4UA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] iio: light: opt3001: ensure correct parenthesis alignment
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxwell Doose <m32285159@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 08:39, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Not sure why you have split the last line, as in any case there is no logic
> split on the previous line.

Fair, this is unnecessary churn.

-- 
Kind regards

CJD
