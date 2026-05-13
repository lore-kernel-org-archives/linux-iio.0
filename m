Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4733A7837
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657726; cv=pass; b=a36jg4MBTnaeCZTLnEObs4+fhqcGuNgO7M/Dz8ILuk8I88q435RGLXe8KuJKwCAyAfYXQOCcgmQ+iWjJ1n58H3C6SPU3Sck197yPcC69C1hqYDeMMvNhs2MsgSg0NXXb41UXb+JiPugluZiCn3RrTRYSFiAQcI6x90NWpuExDxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657726; c=relaxed/simple;
	bh=nuRCO9IYFFtXa8z/NHL2G1ASexmEoC1NhlY6M5KpFQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF7vV4rGVddUGZdo6kAk5l+9oGD0nE2m/MPwWp/pNxOGqU/dl8vmsx3FCklCJwjy2JqSHoDEl0uyD/3+akPSTUbn/ZfqkDDOd3VBq+N7PCjkecxEqJ4T4PSIhLn4HyTfSyysJcx0sV9igq9h6ykmUcT2dCX+XZfuRXn/9yM6nls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDUFVTHy; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDUFVTHy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48909558b3aso64209565e9.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 00:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778657723; cv=none;
        d=google.com; s=arc-20240605;
        b=a0c9GZuuWAHkpCcabm3y48IVSNScx2wFcctVpVk3CkRd5tRHfDtQG/4+Wrw42eJHy6
         Vaw5Wit6pH1h+u20obmcd3iteNfbHxPPSfQQt9eY6Uuo4HtZ9wCKki4ue8Plwp8eIxQ9
         z6vOchJ3Wu9bzCbl8Alpj2z7Pxrw0mSj6Vqq1HBwnP/qIwzX3YOga2jebAjaKQZaJ+uW
         pEZyXGF3JdA9qhppgHL/0lqX4BC1X5tQn1tL8L8/Sjwvb61r4cWUKuCjfpMfxau75uBi
         6UnZlpGd/mJFAYyXUyCPY+XtgqDGFsJDrw6AdE0/7NGuBtCI/tzeEZafF22OQ5SRXNwO
         bzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gaube2ImOLcS/ZfM2KYlRFBUyRqup2Q8P5YJR9gIEYE=;
        fh=HiQo3khK4gy8rcIZHArNAk0PuXYbWeQaOsGdse6lsu0=;
        b=SphoTrGoD6TGLu6Fyoy8Omp95aFH+ggcLRjYDj79ZDmCcTMc7yC74zxgNib+YqBxYu
         ImaVJPkza4YFSMD+gs8Od528Vgx7LNpYAFNdH/NzR6XcGF/FXUT0tAXMVoo1cobqFIFt
         aS7z7W4lCFOI7nrtWbj2incYcnC8V7KyL+egd+cBOFK67sZ9RWEwMDRw3fuUA7LhEX/+
         vMM7RGsCMHQyFSZ5T31qwA+QpCESp/CDZ4FphndnF3dixxie32+D1flC7We0GZgFsWYH
         K8l5ACFXrBPDt2m8dA3RChpSB5zF6skFCp9fpWU24hR5DZF5O+cFQUNbt56AcdgATopZ
         DYCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778657723; x=1779262523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaube2ImOLcS/ZfM2KYlRFBUyRqup2Q8P5YJR9gIEYE=;
        b=rDUFVTHy0rgQQRQnZqie4C1lp89B4IdmaRd+3yC3vnjC+I8zZn68aX4DHMkGAQxeKG
         TMa+sLa9UYZhdrf3h3LtCF+KGLFwwrVOq79d51zb0KlKkmbuAIvRaDBifv9iAQ5vX0oM
         a+sHCotrLLpedtB6R93w95/38IBd3XYd6nCqn2Tqi+Qu5q+5RB/IdlH/bxj+mtSbJ43y
         oS3ADTod5uYpTj2XRTS3L43EMZ59Eliv3zs4uBrg5JLLc9I3EJtvH0WCrnXw2tU7NoaF
         YW5rQh1+cYUAkEFNydjeH+ZEflT6cyfZp8fWDgwZoPPOMQoWB/hFUV5ZhUshK4+QRWmJ
         Os+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778657723; x=1779262523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaube2ImOLcS/ZfM2KYlRFBUyRqup2Q8P5YJR9gIEYE=;
        b=lwMTmeEyrqCPWCLP61q8zvmXR8v6OyoHLDEqvvZcEqJsiVLBMf6eSoIzhkw/ri8ocN
         qYr7xIS46qPivD9A/WRwpkxpP4ydb0VYtxfh0FK1NusGxeHR16qtc1AD1JMByvicskox
         5coxxIPr18J2jSj4JOUa3Tz461XCqqs34hXNRfwoFRG94cu8457lFaeZr7v/w/X/c+Ah
         VEi9uXVNtgBIRwhMfOECxUrEZn6P3ksy9PpDSYSz1uYf8u8HERi0xEoH9+VgWz3tebmC
         angdZBDVoC9oqlZP2UXHWcfvc3yPxitGjAb9lQ71+zAnH6tTXh1u5osXXDILP+CMjOtc
         mSvw==
X-Forwarded-Encrypted: i=1; AFNElJ+Yc6kJO1m4QPkKIuZAnU0qBDEaL8fhukGYst0X8bVqAszj4xgXLkZk0GBmeYXGL67fl6e4tJyO20M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrg/PicqtdEYgxXHa0awJMEOsj2J5CrkPvxeecHRgGBB4g5Pc2
	d2xvE4/mcmu1MBbDHci7qiV0L29yM13aaCZkh6iNfbPEuhj3rFcCM43K/FYzCTu3knPO1kVLTXo
	z68BaT6T5pfVM6JyuwnkIf9UX6+ACQPQ=
X-Gm-Gg: Acq92OH66QHZSXkaLOv5aaGvsQYmUSXRUrks3LMTG4gr7AauUDngmXGUcmN1rfttlm7
	Pf8/EwTKAr4T4LR4d/YfwktyaEsXgB5jjRnZsLEkl1PV36paBxeFujeacgradva+/ucMEslTP8D
	qiDunGnHZx3Bog6a9G3uG1iuR0Xu34aVBQJ5hnQ0rXF6NGtUegrl0JST9RwPchdP2n6mUV9M5K1
	f7rE7oz9FLuDOVQSPP7qJEvBhLuVJVWJB6VbOlCU3B/loB27iKBpTsdIQFFneBFR4W06mvm656p
	AMtYSPQS/Ojp3L6oGPBCgHMyv6rbLCxD/QptkiRzWvgZd6/MbFP+wKpIKhhmonXec81244rWFP9
	aS12PEZKfW7ZvA+fGJ1/qV//D1g2EeDa02x8fYPlGOo/PYfukrFvz5IsikrAr8vOVUA3St+zMsF
	mYyedZOA==
X-Received: by 2002:a05:600c:a11b:b0:489:1fa4:50c6 with SMTP id
 5b1f17b1804b1-48fce9fc34fmr12237025e9.20.1778657723295; Wed, 13 May 2026
 00:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513013638.147606-1-m32285159@gmail.com>
In-Reply-To: <20260513013638.147606-1-m32285159@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 13 May 2026 09:35:10 +0200
X-Gm-Features: AVHnY4LYhIA7O4upvoRkUx2TTJpJCHELFRuUdgOHKvjpr8GtQr43zrnnFOST5gw
Message-ID: <CALoEA-wKrJ3nZ-o+Oogy6gcZijLTvXmi+vQi4f9sCYhYqHD9Kw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: kmx61: Fix potential time-of-check to
 time-of-use race
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, sashiko <sashiko-bot@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 May 2026 at 03:41, Maxwell Doose <m32285159@gmail.com> wrote:
>
> A time-of-check to time-of-use race condition exists in
> kmx61_write_event_config(). If two threads enter the function at the
> same time, both threads may pass the check and get to the lock. Thus,
> when the first thread releases the lock allowing the second thread to
> start execution after the first thread modifies data->ev_enable_state to
> force returning from the function, the second thread continues execution
> regardless. Fix this by moving the data->ev_enable_state check inside of
> the critical section.
>
> Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigger")
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40gmail.com
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/imu/kmx61.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 3cd91d8a89ee..3afa369de3cf 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -942,11 +942,11 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
>         struct kmx61_data *data = kmx61_get_data(indio_dev);
>         int ret = 0;
>
> -       if (state && data->ev_enable_state)
> -               return 0;
> -
>         mutex_lock(&data->lock);
>
> +       if (state && data->ev_enable_state)
> +               goto err_unlock;
> +
>         if (!state && data->motion_trig_on) {
>                 data->ev_enable_state = false;
>                 goto err_unlock;
> --

This seems simple enough.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
