Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C63C279B
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006747; cv=pass; b=RMxAyJDNK+MIvGmE+7sXK0mVITjZSL5OvmpIuRDjEEiRHxaixPQvoQIbC6xQNX6J4arlAG0wLmp3YILjYxXnMYsE4H2tgYZwOg1NEq9kFrw6HrgCL1pQiZRq4oqMVBuadjC7AGPVT2JGjYvhri/Xh7Fq3jwJnXWDuVRuZbJ6jrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006747; c=relaxed/simple;
	bh=YQ8eK8DHVasHUkvvb7tmIII7HxVttveF1UgSeuV1yC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5VheJ3Be/Hj+JG33WaRVWX+vAYxlvFX8kGXN9HpaVQUxaRnDt3LpUlxbfe7HNl2m0UDgLbuctcLwpW2CtB4ouLzxvJ0+MbGox9o1L9uyJ9W/uEdsYQar+eFhcNtvu8rJd+3efTwWc7NlNa0Dl2fadHS23jryWpzOBZ+XDJuKPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLo1JuA8; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLo1JuA8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ad135063so53224125e9.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 11:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778006745; cv=none;
        d=google.com; s=arc-20240605;
        b=SZfaO18iE89JMDxbdBzw/hYJKZmhISNMU9xYt6GJXdXn3hdq34rFGvM7htOlJLe2VV
         Qfs6Hrzr5KvJQ4OD4FSLTfn4LGQ25j6qQ/YNmZpeId63vGtBV6ComTrIbMNdlPbqm4xK
         ybv8joHqKHRBoWCpkLP8hbmNenKK53Rd9vUPzlz8RAC+oVQiiazDOPVGhhBk+cj0Mzdz
         3NVDiL+WGsXxl80Qh94P8TP65aAEvvlMXD01QeCTCQ8UgMrDb7unzDdk9j4LYliOo4ef
         b3o6BuDMv0ufZXek9OHEoZXOpGgtx5TgrnZRiudDit/1GAKUAfpsPMrXWRKWR7AJ10+V
         mmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BkofGy8P4xGvgVuWxYFA7GXZRka7fMDcfGmEAL8NDXY=;
        fh=j8B0n9iovi9snpbeXEMG/oRX/MFATXDqKok/kPI4RgI=;
        b=Orpb1u3zdbSi+qxt1D6K10zVykQe054dcxslU3SgV2meFI0Qra5hXQGb8P/2v+QN+R
         m+V+OVNeWsCRnUTfZG6mqX8vSqDlIcd2WqAr2oKCa38RZNz45cnL5a5NWeOpla/KYzZa
         OaGcogL5Q2w2IxFako/sTz32OKwjYck/8F5E5dIAHRkLpImdKDzm0HcOAfj87J3y9tmb
         VcJIlPevwWDGqpTm4CWCmjDB6pPeRtpZwZpe3QApVzjk8/yazh1ZKSv+SMaplRybuiba
         mftOP30jwUikMi4ysN16Mtsp9gqXI5LoUfW3Ucau4LXzIflqXKCX5ysNqAnNNFLM4aNR
         FgGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778006745; x=1778611545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BkofGy8P4xGvgVuWxYFA7GXZRka7fMDcfGmEAL8NDXY=;
        b=FLo1JuA8T3WQOwMrIbcd9kKg0jQgZDDIysWs2BTURtl8ccMIEA8rgXdqghodOTrnS8
         Qcjr2H6J+/KfCo7uqGVqAlyhWECD0fi20htF6N8LY9kesvNhW2pmE/pJG3JkRxhVbWVE
         Np1U8SFG/Gh4Q1HNXG0FeciogcdlPR3Uyiy5WeH5tSPd3WH3oFyTPuIJYfByC86r3FNj
         yLHXZww7VcX2vDRAEnj3l5L4u0gaLZf6xbWyShae0s2GJw2tjyx41N49vo8vTmIjJdR4
         lCKhbfhwk4tWlNNg4W9r9GowEfzjlwsbk7PJsI6oAZ44a/PllQXwfkymg9LFI/SdRGRC
         es8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778006745; x=1778611545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkofGy8P4xGvgVuWxYFA7GXZRka7fMDcfGmEAL8NDXY=;
        b=ZI4g9NXAkF+M2R7oW6A/7J63hpEAhIUml6WwMEL4O64+PcbNt5yLVQ8QV0cnUPhbEy
         MVaB82lqw9EomCjgqILpJFXIGlVyxmGTiqCIK95nrkDwMj2e+hcVUkMbG2uLlEWNQIm3
         VOSXM6tciRlPqI2u67mX1pYORS5alDTx0WC+wgEBOje87EJB1oAYEYzWC7YOyhxeRjIG
         D/Jy/kPhR8IVegYxwJfII8di1Jx6RaI/popQ1cyI2N1SD94TxY6JhLEwR4B9Am3TDVlF
         KDByUrzoRwS+hdNwdkeJnKDbPCxM2iT3v8FikR8y3OTylKSSYLO5vF8fu+jkYuo2iFg+
         HasQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YNdcGMdUvaFdXFclyvbpE3a1X9lOGf7AM2kseSAPx2qRhg3f07J5L79XtriTLtLcOpUoGAuLKz0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YylvNlhKRXmq4nR8yOw+L0MNJVX3pt3kUGSfJ3lxutDMZVhn1mC
	QtZyqDvntS6fdPHpcHpUwIFKssmGrJYJa63gWBBdMPVZONfIzn3AiIXk1CzU0JJHu+u0wFkvGWy
	J+AcOaRyKVrlP6Q1aDp7zcvFWnvux5eo=
X-Gm-Gg: AeBDievEyeae530J0G1XZr0Kyv7gXhjZX+mcOagFD8OsB9JjMMDdMpK7whQCD64aEsX
	odNVHGpk08C2Saq78kfvTD1HgEcVBCrUd6LNmuDq8HJsZEtORwMoT+LzSlupnZlEWVXpynJI9PU
	71u2HNIMO+we6Nb9iQfTKJSNjdHq5A1DEgPv2S9NZfQyZdKhMI4EUqaKiYY0MWsnBWLvpVeBbvA
	qzECoq6rxisOusB78FPKQ/SOjqjKECwBlfoXewhAO8eAX1VnWnMabQd8tDhQ95aIAjZbi1PQvre
	Bv5J8OwZHpuT3+Sd8SvAjubpUJpQWX7XokPUwmK1Z0XVrx3EPfrhEBipR8mEmb6NDHRMYSnUcrA
	qvoUiAewkGt4Ll4FqK9ISVYYWkG6z4lSNvrGogPoGCepPRju2MbuwQtJg5LszB1RMu/mHWJPVkO
	9FBjxQ3nfSH3TzFwR++Z5ABZxDGo2j4u56nst3BBJjXTUPPPU15g==
X-Received: by 2002:a05:600c:8011:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-48e51e1a545mr7588115e9.10.1778006744699; Tue, 05 May 2026
 11:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174640.3998281-1-sanjayembedded@gmail.com> <20260505174640.3998281-6-sanjayembedded@gmail.com>
In-Reply-To: <20260505174640.3998281-6-sanjayembedded@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 5 May 2026 20:45:32 +0200
X-Gm-Features: AVHnY4IN5qCWajVQ-Txgj5pvjqHkEA9dKy3BnVrh9VZM64N-bB4K-p8ye9X0OMw
Message-ID: <CALoEA-xhRv7UN-yp_PLAbmvz8rOksCroT2Uhx=WTk=WpRujx0w@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] iio: accel: mma8452: Use dev_err_probe()
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, sakari.ailus@linux.intel.com, 
	christoph.muellner@theobroma-systems.com, martink@posteo.de, 
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 19:49, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> dev_err_probe() makes error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/accel/mma8452.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index d227ce3d5f67..b49949792190 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1548,6 +1548,7 @@ MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
>
>  static int mma8452_probe(struct i2c_client *client)
>  {
> +       struct device *dev = &client->dev;

Stray change, I assume this belongs to patch 7 ("use local struct device") of
your series.

-- 
Kind regards

CJD
