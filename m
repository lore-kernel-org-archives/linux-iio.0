Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884C37AA99
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945694; cv=none; b=siur89HaxjGPm035oS1sdSPklP46vqZ/TCueS5ZBWYWBmL+f7zl8wce3d2u3GlmtKpNa3VLbE+7GUO4oWCcRNimbn1IwbBw+TwK4LvxRHevysl2QMFBxK/xPrNJIS/hAcjQTx6MkG1vf+4Sv3luzr2hdAayIPgOz0F3ENtHJ79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945694; c=relaxed/simple;
	bh=fwqZN2vbqNseymtGxGIWgj1IWKR8basbYQ9EEL5R9rg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qm+jEPG92Mo4U5u5+FqglLZGMLmJeCAHw9/CfFerhoeBKUD8XxBmu8XDn00SJ+xKk98FI28i8AnOHhCBbpGYvOOflCsNSbPWavXNUrskbieLAQxCIDaPUU+LbdzXJHM0U6Y5+cJ+6r3yghYhrkbPSOykuFNcX5RiLex0YkvUWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxfeimGn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxfeimGn"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b966dd74so11429795e9.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783945691; x=1784550491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7skRcqd0vjDN4v5wBU1b+5yQxdtAYY55BU9Ndb/1BdQ=;
        b=kxfeimGnt44PFZVIvGfJsH+Gh1rHM8JNqdHQdUrNTf5fVBuIS1X8h8eeP8L/6MReZP
         yW4NjwLAb6rwOnYt5HMRpYbAHrSxnPx057St+hEYObB6fl9L1iq3IP5slcx03Uy1h2Qs
         rkaraLMSSp4D1j3v+R+BAmymarIkvqRNuyC7VkwEFiz0OeWFXjwwiRVe7xtIrcCwWHUy
         CzNcF15HSo1wVvW0xyaImJvHkozCRJyPLRGwpvWqYE5WavRyCBJazCVRKt+E+oru2KNn
         YHid2XeXumcr6I94MPIwRBujA3DISnPHQdOTWyLvW4e+v/lVYpzYNr4YJ09hg4nBg/Tb
         jGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783945691; x=1784550491;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7skRcqd0vjDN4v5wBU1b+5yQxdtAYY55BU9Ndb/1BdQ=;
        b=e5hH4fxIYGsEGNZa9TI3oE3JQCvL5L9As/xuOg0pni1NigW7UIr8gI1Lffcetwq/Pm
         QmyfMxaiqEFXB8dsFvqtH0qqJ6OSonEFQZcL6ne5zUReB1Kj+fUiSh2ba9FrQJVHhlkV
         XwuesdJQkuQjE+nQSNWCJohrY72Ija6LOAR5CG3v+GrPjtWB+95ZuscIGNvCsivHb8lZ
         R02EGFOEaxxt6LplkWl60kl54VOUXPvxpPnaj3OwhXZcQHBhJD11YKi08Wxie1FA0O2R
         OArEi2xA7gUeUF3frNYccVTLPB5P9d4NYooqEkiB+QUZfKHh7SmRdhBAQMmzxtCnjHti
         k+pw==
X-Forwarded-Encrypted: i=1; AHgh+RpgKGQ+UYQ1IQN8N2nDYSBx0RRNVoEZ3VN+7CqcdVB9LFHSJH0OoPa04u+uy6sWtgzPzRxNJAllyN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85mRNqDokJ7zRnOqYQmL/0XSwwep3tC+kxFOBvS8N5ijfbqJu
	B0skuxED06j8F3VhN0QpRCromyGzrpyUKplxf09Hmh7bhgeXiEEPMXmb
X-Gm-Gg: AfdE7cn665WQ8jS7vdgly7sIDCxDZNugTCBWDWGUJni8XcLJXerLXasDLruGj65tgSA
	+ZCMOjEDKMT3gEFnDJ8nd3TZIeAZcjl8hVk/uUhTVCtcejQnzcZFYHP2qng8BY77zDfMZfh0LHn
	D9qay/iKPgp39qt/8TvhvLR5MYkJumWNkA7DMmJhxlEdI8xrMpQk5T2Cg/zIizo4OzYM2U1Y1Nw
	CwKQa50Z0PoN/yDsLFGaBdUqwAcZEiBhIVDnTtzuU7O/BKLIyyioRdISKU0BZhDvEZ6mW3Qxie5
	QUZIqmnYnkJViAywzFcgNvZLn8LQvh+5aW9X5snnsM/XUsLPvwiwMjfxKdCesPZjc7phS58W7kh
	/HmcP+V+ISM0rwircyreQ85EOAFzuJW7lHM7JwcaVS1/lYWvBmITs8g8Onwpw5GaYNFEzdYvsol
	MQDRtTdYJTIX5Ij0p5snvitGBccXlNb26xvne7hSDcxy3F27dWKPQt9PGY0R11X5ZdJ/4fi/XR7
	nhtiiBFVAaiSJhMGdImo/fQ3U5HFJRhVCrB0Dv2MW6QVk2opkq0Y9GcTppITgXu0qFugGjuljFG
	XfyezSwScdK5rL4ddqW4vi1rggvmVoUl3V9crwQUwElfPokXt6yHkX7S+5UVqvAqfsDi+BJVSni
	iowbs0XBonqEAeBo1WmMZbKHw6xixqsx9hw==
X-Received: by 2002:a05:600c:a4a:b0:493:e9c2:ba60 with SMTP id 5b1f17b1804b1-493f8820ab3mr90094655e9.22.1783945690946;
        Mon, 13 Jul 2026 05:28:10 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f16cfsm363354705e9.12.2026.07.13.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:28:10 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:28:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, shreeya.patel@collabora.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: light: ltrf216a: fix runtime PM reference leak in
 error path
Message-ID: <20260713142809.000058ef@gmail.com>
In-Reply-To: <20260713022829.234370-1-vidhu.linux@gmail.com>
References: <20260713022829.234370-1-vidhu.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 07:58:29 +0530
Vidhu Sarwal <vidhu.linux@gmail.com> wrote:

> ltrf216a_get_lux() acquires a runtime PM reference by calling
> ltrf216a_set_power_state(data, true). However, if
> ltrf216a_read_data() fails, the function returns immediately without
> dropping the reference.
> 
> This leaves the runtime PM usage count unbalanced, preventing the device
> from autosuspending after a failed read.
> 
> Fix this by releasing the runtime PM reference before returning from the
> error path.
> 
> Fixes: 83f0bcd40d5c ("iio: light: Add support for ltrf216a sensor")
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
> ---
>  drivers/iio/light/ltrf216a.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index 3f34ddc911b4..3ec239eb5831 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -247,8 +247,10 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
>  		return ret;
>  
>  	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> -	if (greendata < 0)
> +	if (greendata < 0) {
> +		ltrf216a_set_power_state(data, false);
>  		return greendata;
> +	}
>  
>  	ltrf216a_set_power_state(data, false);

LGTM, Sashiko had an issue with the fact that pm_runtime_mark_last_busy() isn't
called before autosuspending, however pm_runtime_put_autosuspend() already calls
this function in its body.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
