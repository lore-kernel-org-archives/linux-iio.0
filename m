Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAD4BEE55
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480263; cv=pass; b=AHE6e6YzhL+2SxQG/2hg3BD4FzCqADLeLFiAEmLRdvbFSIsN3YnCwV8WcTapEBeilKxWaP0iuEm0I/jjP+k8Pr0LdqEZSBb5HH6Dr/4hGbJGfVHUe9Luawsy0KCSBNfVQZtASM3xKzkFRNP3ALGYFISOgX8OnyO4WCjVqetemlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480263; c=relaxed/simple;
	bh=4wPcRrMFAq+5dln8/Xz92CdQ5x3DJk3HiLHlwR+yBQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQwmE7GC/+dctMXeXmO3LwQBdJSv9LWLpMOgjRPKc51zmrDJ5rdvks7F+G5s7rpx9vqziIpofdxXJacQatez4dmIEbVORAilKN3+UE4+YcpkriGrHqlqRTLT9vatcYHMvZJoAtNeoek+HR22dTTl3CB4SF3utOqmzVUl6pHPpLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfkf/blk; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfkf/blk"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a316adfso235328b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 06:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789480261; cv=none;
        d=google.com; s=arc-20260327;
        b=WoEXrbFZSTLbzlzhXiDGsAU+w3rBTfOcELGViGpr0QPxWaRAdpBP5Hc739foQZB4BF
         uMD8w4e8c8Q3agdPFqazioYIUFxcQOXM9XUQFjNFUW2qUNY3uYYXeXw+smeVDh/hS99Z
         6FeCGYST+L87VOBP03AqtdPk2ocGgNcp1SCQDrlFKYghBZm69k2KlPdt+2rsiZ4vQKLb
         qqPnA0omN27UTkK8ESTxyjt3aFzAKbGPKH8nyMn8BD/JL/dG+G4cH9Q61UsD8vtzJzN4
         r8950uZiV/1muCN4xVkrV44q9LRdUu5J+sh6gVJYUm95E2Xzx3VEfaCOdrnDnc3UKY8s
         l4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4wPcRrMFAq+5dln8/Xz92CdQ5x3DJk3HiLHlwR+yBQg=;
        fh=H8hUQHHNmG8/o8ugAnFF0to+34DZouc2TxazD1RNUuE=;
        b=KUcTr3fKlh7v1t3Mcq2jHzWw5/LSF//eWvKbnp6vMP3SScg9sqO3EZTER64gynFA9H
         S7TDP75Y0LgA7OcISgjGXe5yytNAPho0MRkoNzsa/WDqeJ4rvdMbM1GNBM6XXrss1/r8
         +lebzWOKjvZmqg4uxTygOQsvBC+nrQFeJ/bkFCie11F0npe5ZmtUNfWhXWqMB/MhiX1J
         dMJ545B2N5rdN8uRK+hdph5kmIEEfjWm/kZsOpGkFYL0oNA+RwoUycKTDEHdWS3WXg0k
         GZ8rnHIVov8OuPq/8cU1Zmu5nml7ncamwanLRLja7V0nmojIBCeRf+0RS+f9T6lV+yZG
         HdRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789480261; x=1790085061; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wPcRrMFAq+5dln8/Xz92CdQ5x3DJk3HiLHlwR+yBQg=;
        b=dfkf/blk0+Fc9K3qVVUAsmWWUjgtVwmLForFXyjdLJXK43NTnZ3+fTTNbPwBZ/BhZF
         5XD1Bv2PRXOlOhnQjev0sV+To1neP5DYyBE4Zz/VmlBrIUihBP5yWv1uTytj7t2J1asu
         FP6XY7Pm0Q8c/V4RaWkMssxVpcJqxvweZi3bpmHmvRxgU/u7Gpe4Jg4gRN9hmR63/6xf
         cTW8ZlBufOGcCWrRlODSoNJSGlFO5rc4AZK1KG0/hCY70nF4m7mxMK81nb5t2lwfHZ/B
         fUj2D0RFcrGhWBgFupi/cF+/n2Jdq6ty45TE4gje/CJdg42Gc2O1H+ZyPM/R3jEpsV2a
         8DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789480261; x=1790085061;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4wPcRrMFAq+5dln8/Xz92CdQ5x3DJk3HiLHlwR+yBQg=;
        b=YsoeQINlzHcP+/c6azThpz26yjx0Ud3YhWKK4ip+0MOvV/u0Rc6JsaWO9PD2u8bmF5
         vTYLBy9Wc8d9p6OkxbuH6KObhFO+oiOeC3Fj+97n9oKy3cRUAbshOF8KEI5WU4Xa/Lv9
         HuOIVa0r+4ksMNgSD09BlseFi4VJpwRWBVOJw234lu7CwR+4mWQCi38lFdCXDjZ110N7
         BBwXUKkVtv0if5tFLO6x+CEuKQlCmnU7V7GfMbnC/IVcmy9Pot45Hf5hAk8skSlBlxPI
         8dQcI98EQoBZE3s/3S9IulruYAP4P75lp2IHBjTQYNNJTJwKNXMGu9Wsl0lyYmNA2R9u
         aOuw==
X-Forwarded-Encrypted: i=1; AKwUvBwhsvPx7AlsIMdVo0wNXaa5YiSOEabNyxb7O29cEFa2WKJV7Y1lapkrAACaTaSMeZNOAbayHIQPEOA=@vger.kernel.org
X-Gm-Message-State: AFuF++kl3pQieXZhVQ1/XCiPY+nTOfTNxwiJPPdFWrVDQyRQs7l/DJdC
	Y10zVl1NBqcdSDTz1k2+C+Sin2y6z2fPz0UzuXObo9/gzTJ5gDSbGTz3nBcImNx7rEsaUSMMjEx
	59jkCTkyygung7b/F1homU0RTK2WwJgc=
X-Gm-Gg: AYBFou3jVhjrXsCd6wXjtoZSC6gDiGZu3jui1X3n79eeb82qMzhIRksFbFDZHaQoAsQ
	GYxD/bGhW2VC2wYJPVyb2kkycSS7VUdEloLxSjKQwOV/SGKZ7oeK7L2xTx4QgWVdAAUsLRVkooU
	aB9mJRCQzRQTs3txvPXtT4amKwIgr+y6LA1GxZ6NmQrul8s7l4ktYWHen3i7FyK0mbKA5rzVGbi
	O1gPjPf5o1Oy0/CYnudXb21pllENCSiW4M1R+GqWMhbqD2mHuSpg/MLnk5xS2C9nvzUGqVk9Z4y
	GpIz/A4bmHnrxfR+mtbGCQFGMLlEqM+PCawxULe5NNZ47J8fQbZkuYs=
X-Received: by 2002:a05:6820:4df2:b0:6be:dc4:13ea with SMTP id
 006d021491bc7-6c739c74aa0mr737467eaf.50.1789480260532; Tue, 15 Sep 2026
 06:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
 <20260915075939.18180-3-abdelnasserhussein11@gmail.com> <20260915151634.0000787e@gmail.com>
In-Reply-To: <20260915151634.0000787e@gmail.com>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Tue, 15 Sep 2026 16:50:46 +0300
X-Gm-Features: AcwNN1VOemZ51WsQAP6jqp3alJcLgnYJqt7-z-lPu_slORPzqQPRWDZ6MAZ2e5Y
Message-ID: <CANpqX3ZkzU=+qmd4RRwwBbX2UvJOzeLhRi-hfXRR=FyeH6yD5A@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] staging: iio: adc: ad7816: Serialize SPI operations
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi Joshua,

Thanks for the review and the great catch!
I completely agree that securing the sysfs store functions against
concurrent access is a logical next step.
 I will prepare a separate follow-up patch

Best regards,
Abdelnasser
