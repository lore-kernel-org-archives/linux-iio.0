Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C503E6DCC
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524839; cv=none; b=gmYFdakHTKFCmrIiVRig3hbKAUX+kPSuFm01pIKn9FW4dDcjzjQbOyTKHWmC/PPtiapXZ6NTD5hb3sEE2F9ohFtv2XRuM/1SWls8uMSHgiMhrCnowd5OVTaO9tjA1G9r2GDOQTI4F4NCYw8z44Veuo/g9Tf/a8iYRuXCIymzWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524839; c=relaxed/simple;
	bh=9LkO50vinHgqslKj/UQC9423D7Xqh+en7g6xz0yqQ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyktXVhrb1euDDbJCzl1tRLAtB61CwrUfo77YkUVtMExQqJ19NKZyNvjeDPqjL3+A8rHEfK/hI6B9Hhkg4Q8f4ROmQXKAIxNlCcwkH4ThOPjjvQG0DMzRMxl5Djd8+B76dB/PzfuoOsyFAuJsi6FUIfRFahjvutjG414IqWj1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9n8wjDw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9n8wjDw"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35c124d2613so592648a91.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774524830; x=1775129630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYb15l6SkwoaSumNC8Ir357QOvFQPlKPvUcLWk1X+To=;
        b=F9n8wjDwASEqtxkc4VDlJWILkq9QrfW0fKee8x2oLe3hfliNnFSjhDFI38SF96jdEJ
         0m08YAZ7ZHszPisE423KIA+uSU2yDFglDlCbgpUi8cSSoxx2e6mCP5lFVDpSFvWEOHE9
         b9FVhMciN+IOollSRs4JmA05Ygy7nuZyfm79mtPauPyS/tsPJLqVrIkmwg6+d3B99mHd
         /4Cu+KiiENydpyOSB+AhKROfgmmpoetVY23JG9LfVatvWYXsgpyRCEKuPkB4JiGXw/Um
         FnDLqbgjpZbmYCK4NRKHUczuSNxdFw2XykB+ASKzhk6BzIzxo0ehvvTvesJsv1jcHM1D
         IF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774524830; x=1775129630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYb15l6SkwoaSumNC8Ir357QOvFQPlKPvUcLWk1X+To=;
        b=ajH8QWt+y6dCs18rhucefRny2Z1156IB+wFR83FOjIuubIPX7cU/E796H6Z7/84Foy
         KzOGhgIO1ARvZKAWa2cgFdFuVFfy5+Omg7RNNM0KBBHKD2+795YBCaeEJOGdEn8t1R1u
         5dcVgSFZEfS3VWmFnDPR0tfva9bjpb9EN2J8/74RWAKWurDUTWQZms1z3hcNIDAVoIZI
         1BpXBcSq1n6cQ0OSxUvc04bCTCkTsqZjq4BTRMLn5r2DOp1+egHkKwVppsO83MPq7zMy
         dYhrUNJ7gb1gM6iwgFb9au0SG/S+NH7f0nKSNsAeX/F8FoEVFbBvlP1KqWTZE0zTnGdh
         hCVA==
X-Forwarded-Encrypted: i=1; AJvYcCU+A6qOETNK9caWS9OJR1o2fR5JC5Y6Qsc+HYRlDrnPIIf4zLQ9dr2xjnT5ulehPMxNGMtbYuiS7FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEBYsMw/VEGBRNfRhiAwxHwJRFkiqq1lyQ8igJLEWKsXFCsdB
	li8ftmwzLrd4SmTNO+2h4cgY4aWRzQF7GUJCCqYCPudXoS2hEstxmd4Ym1DRtA==
X-Gm-Gg: ATEYQzzPoL4csnwhpXQ9drx5MEDXsvcPFRxbBRfzxDdgyKrpBeL/bJ7wO5exjEWrwen
	9ou7pF9yGPIVjlKZrUiQv3MVc5lN/Ksh8UR/xdvo9rZpMXSRy7ZhUA8oCJ5l7sU8YI+CcQTc25e
	S7n6zk5dGsnr11/Z9VcS/9tqD5ZAeFB5IbLNOizoHKymrF1OLrT20CHW1yqj+6UTi3Taae3nkS1
	gaBQqb1oWZb6yJQyNX6hMRlDNebaI5TzPFvEkXAAU14Nixqu/1Z4kzydlS0u+aqnHKoeuGlYZpS
	pgAOskxgiB/NFciDidrJ0rlmQ2khta7NOdED1JoxAy+dzspv88JjV65smom8mZf3XFihc4QCBEA
	SMyfJoePL6b7iD1jiv1OQs1twDtcnU/48+lGBx7LrTyk2W0QQLgyMBKaGIhHidP+cHa/rUrJ4dN
	JRXwJvk0ZJ/UhZRCMHUtNY++gwnkFQOtac16D6
X-Received: by 2002:a17:90a:dfc8:b0:35b:90e7:c458 with SMTP id 98e67ed59e1d1-35c0dcb107dmr6491699a91.3.1774524829752;
        Thu, 26 Mar 2026 04:33:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22db1321sm1415724a91.14.2026.03.26.04.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:33:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 26 Mar 2026 04:33:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina2xx) drop unused platform data
Message-ID: <fd613c1d-c9c0-464a-ab1f-16bfe20e122d@roeck-us.net>
References: <20260326-drop-ina2xx-pdata-v1-1-c159437bb2df@oss.qualcomm.com>
 <a4661a50-1419-458f-a0f9-a9d9f6f59177@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4661a50-1419-458f-a0f9-a9d9f6f59177@roeck-us.net>

On Thu, Mar 26, 2026 at 04:28:16AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Mar 26, 2026 at 10:30:00AM +0100, Bartosz Golaszewski wrote:
> > Nobody defines struct ina2xx_platform_data. Remove platform data support
> > from the drivers which still have it (it's effectively dead code) and
> > remove the header.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Thanks a lot for your patch. Checkpatch complains:
> 
> CHECK: Alignment should match open parenthesis
> 
> No need to resend, I'll fix that up.
> 
> Applied.
> 

Ah, no, I can not do that. You also touched drivers/iio/adc/ina2xx-adc.c,
meaning I'll either need an Ack from Jonathan or the patch will need to be
split.

Guenter
