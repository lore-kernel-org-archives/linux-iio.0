Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFD366066
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497931; cv=pass; b=bvR23xvOxcH40ggNn7Ry6YdRhC/JnF2puCwQiXzKC0fUad59iwX7WD97oYHBNk0ZE49Vo87fVM9hjrrnJDSXcKTiyADDyLjEDlP85WMfqRkuKcmT1i6H8fmqAT4GNadiZ7bUtkDVqkxxXjM6TS2slwGMjk/K5dHbBjJFnstHSVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497931; c=relaxed/simple;
	bh=FYW1rlZjoavebqoibpWrqUb0BU7YkQCc3cLX92902l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnOfX/2heYdrmqpXvOQU6wtePV6FOK7gyJvluJSIhz5Z00YIHU8DD5GDV6j8vQ+n0WE8ROFq/Jf6mH/oMl68rBaeqh9Jts1Ieo7k1jcv+kQx3TbfERTDooIKJrIrhUtPo3BQl3wMADPRuuXzaRWOs3ldq17Rnl8EU5Vj5fHk4Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQgTPsLk; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQgTPsLk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-441209fb77eso2485652f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 04:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778497928; cv=none;
        d=google.com; s=arc-20240605;
        b=euxDxKwEWnVepN9gMEcUilKxinlgFe6IGZAg4sj/3B8X39qiENbJLfceixuP8IwG28
         i1C+vuKhVFGlgcWL3r3VIg6Rot4CKw22ymJnLtz09f6BxxOU9QYkl1FVVa1SUC6l/5fb
         V7RulAdVr7tzmVMXLgSAHmBvgYE7UkRUmmKCexOs2p4xSOFITjMJqnNW1bDIqvZPYC+f
         aKrL2MvuifC3h1Y2FtQXe+6wyDAY907iqirOB7TzLoIuCB7XhkdPdBnJD2S10wa+IpE5
         TnMpTulRFtfTRnSbRaBOGFGSIA00RiXhYQrsfjC/Y8qCbmzFLdwdB1nzZUX+QbYz4lXM
         I8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2v8x7tq5rPC8HPmhmBmAx1eDRx5x2M7srkk5S+590eQ=;
        fh=nLTfzIPC8NNVm8EGHw7WRnnXk5a6waIffK1u0efTZc0=;
        b=HAcoYJv4oI/8CYGjijA/dC0UjDfOu5o9xGKTAP3w+AygLT0jd3gVyawo63OPIy4V/L
         NiS6dGb12Kd9mGFr0877hU9Z5IIcE10PmqaYO2mqRwudWoJfVKbJ6GSHTeiUyiYlej26
         4ye4u50SVv/7aAWuVwdwebrZ7LN4Cbx4KldIOck6q/PEpdcjQdUhklqGOtD+3vCIP+f7
         2L1gI4wrwd+D8aSrJtN/cpLYK7M/aC1NN1oQPIRNJ0KWtR7C1H3otRG8ydpqp7A9QaPK
         VmGrXXF/sVG3X24pIwuqzOGPjS+mAemCW19TwM7ltmCGp/EfG403ybEktw/iSdyNh1+j
         wVjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778497928; x=1779102728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2v8x7tq5rPC8HPmhmBmAx1eDRx5x2M7srkk5S+590eQ=;
        b=WQgTPsLk4M/DAe5FBozPsU3civFNNpwOxONB63VAbz+iS3HsHjcfWJIL9Oc2vxQb/y
         TFj4KC7VFNlP+feRMEMr8JRNjF79JbhjzGGnCtqhDkZOZI/6+ODueoymXddHh21mJqID
         iuA5g9UjEFcVI7b/zVwE0l8nmdE3ejQn3W5tI126nnYMKeHBH65cWOHwP7DOOgjs5+MQ
         /SJY6Edd/U4+ygUB2AtFkamoy/113C1yLp2E2thLt3roxLfRU98OorPEmSlgV706Z0J5
         3aSpZYj2WrMQt2XILIo4asQQj+QkMtxKf2bUk9CA3ohordDJaf00F6zDcryGgktR7Dt3
         SByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778497928; x=1779102728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v8x7tq5rPC8HPmhmBmAx1eDRx5x2M7srkk5S+590eQ=;
        b=S++DB8HArWXvDvtC262d34Kz5UOGPenxKgYErS0tSXsV28y6nQn8h3QiUHStCQGdDw
         8Hu9a2ldZ55yUi5aRMEhQf+ciKw7xjIM5ZV6F8n8FXF1Q9rJ7qW1ikKdDX1TIXl1ybcK
         ulWPc+lWyL8ozA/2zN3EcNDarqnL74bim6wLkBIpO9vX1MmlGRXUv1eo86R7X3cnHMVK
         jYQFwLQZzMP+vrgK9uIqKp3DX6qA8sklQ4HTJYQSvuPDVDCIgtBe/dsTnXdqWJXhtZ8C
         ekXaVAr2Lh+PD3rJrxxXZvAvhkQ2S+c7zmFVw5Y7+sr+Ru9tNvQRdanKut2spatM68MW
         ZcqA==
X-Forwarded-Encrypted: i=1; AFNElJ/CHSjVcf3KNFngEuf6Ksav64HHTCjGeguSHGhKm65ez/vFaRTNqw2MIaYWA9wP+F7/yhCuedBE+I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyF06qTEQwRn0nnrsUwwar1zPTaRfwEF57vFfnHHe3rMKoCA5d
	5NgVvXlVIYE7EzMZDKgWAGuLuQXCrUrXEnrLhJZi+t8zPYwKqYJU4nTAIgXofWoSNGR4Rha/eaW
	z4ucz8fiaftmUS6mGdgtmBBZ+lK2zs6gORQ==
X-Gm-Gg: Acq92OE1EWrdqnGzF6HMgzsEdSeuC5dtbSILqU8cCKxbf3JQczc2YfFS5GVy/R51pWN
	sd3rm1wJcf9ZekCgcq1Cqy5oro4JIFVfGTAgygFtAYpLZMXPXxe+2dIkMztKz5VUOl82SRKos2i
	JIX1rL43/m5EwL4GcD0TePFXsP/kPRO8L0CjLphzjoIot6hzXyAaXOduzhVM35rIc60S1Tfz5Jy
	HlmvyswD0+jgNhk4K1OS5SFhiG9DLrjPJnZYQSbl3tMDn8wpe0eTK/7CGeWYn7EqsLe+xhbYRUH
	Y/JulSKPL9ZMZ3rK9dS8Ku++/w7A1MC6fYpK6/3X0MfQN7H5AEQepP9OzKUNDdOXQIM6OgzbP+h
	WVnytSaMptwtQDbSWgmKkqMNrjr5WrIffiBUZ0KPLp8i8kJiZiEzua55MkkJLDi1282Ti7cLIJu
	c0qHd7JWCye0teF3Dl
X-Received: by 2002:a05:6000:15c1:b0:451:73c8:9101 with SMTP id
 ffacd0b85a97d-452e96d5755mr20790291f8f.18.1778497927855; Mon, 11 May 2026
 04:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-3-f7879dc3455c@gmail.com> <agG3o3tXt605PBA8@ashevche-desk.local>
In-Reply-To: <agG3o3tXt605PBA8@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 13:11:56 +0200
X-Gm-Features: AVHnY4KSmKNUTui-h798gGqbViAkznLgT4ouuYj4nSNsw_tQkE2icnHhJGrgugM
Message-ID: <CALoEA-y1R3pmGkWvNkokQ+2eyJKd92-gbBAyw6-V_nr=TcUj9Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: light: opt3001: prefer dev_err_probe()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 13:04, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 12:04:08PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Switch driver to use dev_err_probe() to unify
> > error messages generated in *_probe() and probe path functions.
>
> ...
>
> >       ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> > -     if (ret < 0) {
> > -             dev_err(opt->dev, "failed to read register %02x\n",
> > -                             OPT3001_CONFIGURATION);
> > -             return ret;
> > -     }
> > +     if (ret < 0)
> > +             return dev_err_probe(opt->dev, ret,
>
> We have client available, and here is dev in use. With this being said,
> I think the proper order of cleanups is to get rid of dev member and
> use local 'dev' variable here
>
>         struct device *dev = &opt->client->dev;
>
> > +                                  "failed to read register %02x\n",
> > +                                  OPT3001_CONFIGURATION);

Fair enough, I'll slip in a preparatory patch.

-- 
Kind regards

CJD
