Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E23DFC8A
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881090; cv=pass; b=MmRXYllWub6ZQCuiElPrdb2wTIKIbHArYVXn6n8lYpa5uywCNpvD9evP/h89RduEH7G7cVROwUdlfhdF7Z0QrEgy81+sZXqMxJ7F5HFgkBXMIj4zhOMxam3R6H+KSw7oXtYKdXBXumGu92dL5u7NAoUF25XbPS/QPFksiqOFElI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881090; c=relaxed/simple;
	bh=6f36UCay5OAn9ZY1CaIQpcW2YbapEdBtYAL/RUTsKHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLELE2sn7W5c3+l10RgGq0JMrUHgsZXxm+CiMveqoOSwWpFzAXy48StGjExZPQLYQHDd2h1PUHIsC/xg93BctpwXVmC1xBfO+0HtQqgTisHVpyJXoCsrNjKrT8stf/2W+2r+XjwJNOOT5ogottUo1YFfqj8rHq+7vwli2FMjZkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eO9/WxYC; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO9/WxYC"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43eb05b1875so6146070f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 04:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779881087; cv=none;
        d=google.com; s=arc-20240605;
        b=A3qQ8F+vBuakpGTYkcN0lDEaRTUw90M9K/dXEiMgQaMVghDRfwG9AHkvmNNap4BzNy
         GAbbmrsWUyh3H5lREq5NSp2FjBVUgCSHGBg5cd5BgtuFM58vmoqlOwMVRsVIL/ex9QzI
         sCHdVs98hkW9E2KZ/294KGU0WQsdDvLZTpCDrTlAuBp2ozg3fGHr+t+1yxDqA30HuNpD
         lyXE8wK5KU9Yb1/nxK2WEOOQOmZVj7RtbZy/5CvkwDfhoXZuyGqugdCwH+/oGAmShDL+
         TnrqyreHMMAz+hk1Jdv64/WdjElkC4VUrh5VcaPqSui/4I/X9tCPD2kbGBsbsZ1sV4sc
         +EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1oSdfPlt8ivfVcrtc+mkmI3RhSITwTlRakTSHCj1tzs=;
        fh=xSklhhiRpCjK4FrwDHscpgArLihPFqUSdj91IkXWx7c=;
        b=R1sPNEj908ma90+4reEGLNwFTv9UZdfyXLAO1h+duxDtsuSslSUQSfpC/phPI+PNyM
         KAYv4PEEEbzEppyONvS8bSmosUdvYR38zxA1L2pjkS9cUs3c/NUl2Vm2mbxX6opNhgcJ
         p7ExFmr0wSLNQc6+8C+KLEdV09W9sNzC8nKuP/crI3zbjdHaED6JhemL+xkl0SapiPHh
         xxfarqgDEXCzVkird0no5Py2wlr/9pL1zhnpKcrNVdTM0VolTnfQL9pz7sHvuRYZqv9+
         jXEniPGCpJwEBTWvuIpnvxJQ4zduVIpl1cuNbEXmsEEXDMn6Ya4xmO/k0UyUEMUXGc93
         nhjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779881087; x=1780485887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1oSdfPlt8ivfVcrtc+mkmI3RhSITwTlRakTSHCj1tzs=;
        b=eO9/WxYC7s1YBnw51qdqxW9xNhCmHB0qgFhXawJQ5kuoMyF65opaBbA+G//lYwfz5Q
         2PBuR2c2vG92+eouJ6HVdBagg4ISud5OnKSvmM3YnbqJVPZtgeo0kYgRImXtIYsB0lro
         Q8Rv299oxUPwY8mSkUmmJm4QOuANtMpOzp2SyMQzbeaRahoutvTZWzk04Y7tqa18QsYc
         OvcIqtMGLeO7/5z1zz0Kvchd1vVmT/4d6P8DZ6AnWzZaSuX7ejBfISEMaa4880TkaOOT
         H1DGnIhX0xSOqgOQ8zaVYW51ToF46bg6G23pBhXppGMrVD/tvbgqyM72BvNZIOo5hO4Q
         SWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779881087; x=1780485887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oSdfPlt8ivfVcrtc+mkmI3RhSITwTlRakTSHCj1tzs=;
        b=Odp308xr2b9R6UyIn5wEQdeNRuFyMoclYIJsP+oUgcvYltzudhlfC2Czc6lPVBD8vE
         qzt+lVycEg6ddNFpZ2xEl0brl5WvAwpEWNaGV3JYaLxw+bvjoyiGiMmsra1Hmw3VL7Ay
         VtZ5Kn+hFTltlavezHv0b7p8FZCHmZ0/A33ma1mgBGmpHfcfnTmN2TVucqpkUGInZ2bz
         P1IiYN+EHoCv7jyRzGJeZdlVJiZ3ife+OiaXL6IWM+cfkjXk6ls4w/7U5z2T7UVbvsIM
         MUHyD2RzDbgP7st3L3AfBTNl/HLJkUnjnoha25rcKTIj6NwHJUnQOIdoUD2UZte2AA3R
         Ma8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8h+YaRhhnb9rv1qX5LeHHY9L9YtHfqEk1Oa60DZa/2FXYK3o4b4+/1vOFFz80TVrSQSH1sm4hqnU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpX+paTPTY+a8m7trReCUT1PwYqWoEkRft30fKn1Zls1JnJYsQ
	+HNW4DCwf8hHJXZjD61NwtTnBDiuuDclgmjsXZFLl2WS6JSVwJ70P23+WOtDuYDy1mxRZwHD2Wu
	jvFmKXv4RLtGIXCeIq/OoS10rdc4jp2M=
X-Gm-Gg: Acq92OEJQ1bv9/XEKFQNlhbZj2jb/Kyj+5lf5inDxrnfHdRcetSqLABaY75pNRiCtLd
	tPz4/FCOdS8xSETVUxdxvzqeoeRbf3BaKoNdQzpiHUpVlI/txouzD70H3Sy8zWriuF9lcYWR7cd
	AuQtYe6InkONsliX/cSfLf/vaUsfh0ih8GiRA3x+mWYk9wXhX9wb0Sxu4v+bCZM5rBIsUhdYBOk
	/5iAbL6zpQTcVLO4DwPHhJrW5gYd0TYwsqbLuAS58WR6l3Qf9buzgxmiPbjGovNoWFNbxB2Ft4X
	oif6bCo+sRSANfTloklQQwclz/oUV1irUpieN9pTExOAuxdI9/XrzkI1VigQjF0LYz+mq7lT/69
	kGHDJlNoX4w7Q2+g8Kgy2fPZU5vRUKRMWSoHjvVGsBV2ZeRLr2uLrGg3ztWevqRRs0sHgxwL7NR
	ti/9HgOmRpAW68Lxce
X-Received: by 2002:a05:6000:468c:b0:45e:df46:ba30 with SMTP id
 ffacd0b85a97d-45edf46bd4emr466838f8f.34.1779881086531; Wed, 27 May 2026
 04:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-fix-early-return-v1-1-c70e886329f3@gmail.com> <20260527121159.4a4f94bc@jic23-huawei>
In-Reply-To: <20260527121159.4a4f94bc@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 27 May 2026 13:24:34 +0200
X-Gm-Features: AVHnY4ICcG_SbVWlGG7pp_NTcZD7e61UVwmjUR0z7ffrciGosxMVadE5mVs8LQE
Message-ID: <CALoEA-zuzkR_9aGzM+NGWVWcN0ngf-1tRbBm1exkASkx+m9eYA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: opt3001: fix missing state reset on timeout
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jiri Valek - 2N <valek@2n.cz>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 May 2026 at 13:12, Jonathan Cameron <jic23@kernel.org> wrote:
> The flow in this function is horrendous.  IF you have time would you mind
> doing a follow up patch that just breaks it in two. Then have
> if (opt->use_irq)
>         opt3001_get_processed_irq();
> else
>         opt3001_get_processed_noirq();
>
> Maybe there is some code at the end that is worth sharing - you'll have to have
> a play to see if that is worth doing.
>
> (If this was in your other patch set already then I'll blame lack of coffee!)

No, didn't touch on this in the original set unfortunately, but I keep
discovering
all sorts of strange things in this driver. IMO this warranted a quick
solo patch
as it can potentially mess up subsequent reads. I'll probably end up adding
the breakdown in the other series though.

-- 
Kind regards

CJD
