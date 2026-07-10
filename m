Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5A3A543A
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673475; cv=none; b=u4gTs1LqPVhdvE3TN+TD8/82MTR++GM201G+wC6mP8M2Qi42s5+EfLsaUEYeIFVVweW5K6UyDeDx7YXvARY8+p3kZA4umS8rEH62EqUA7kTR72CWqgBhm/6F770/P0w9E07B/T7h+XsBU577bVoRveABwWIjz9KLqbItQXRXvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673475; c=relaxed/simple;
	bh=qgQlpUyrIbjA+7U0WMJleJsVXLJaAjvRjZB0wmXsQFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szr6zFruGOll8Fo68MOvKgncmlEBhDitKbdTzAzX5qkRxGx1a9API5guz93EgkozGkB8Ri+NUmIibazkyBhCKUZRza1OxwoLX/E3x8jS14amR1ICScFLgpjCg9FUfY+WGuA7CGMDhFhiX3UqslU9u4YEUYli4YYOr/3383FTxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuUknPyO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuUknPyO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b7612475so5067725e9.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673472; x=1784278272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RAG+ByWq9gXC9TZmjmhEHYXOnX3zjrYmQvupA3mgsEQ=;
        b=NuUknPyOj4lvZ9YEiFvlg6SEYrxQhTP68bEg08XzojpAkQLsNOVuIdqQMQC2Xr+e16
         LZrFizxYd/k7F+kEI6IDmJeiUIhurfg16yMAzWA0w9fZpNRi4q/WguOLkWIrnRgaAB15
         55YNsXZ5j2SGa8SKAieiPHhVxQk1kW98qHH1ha1hQPZl3Re4joqeDfRvhxPlYSnuxqpC
         JCLsUeb7PYxlqWdRMIk2MKAc61dY+XUD8lWHmhGGlpmSqmY0Q5nenDR/yVb8hBnzKubJ
         erS4jmQhPWkWC2+4ExdkUNCPjf0d7yvLpTvPHAWSui8OqGqFThRlENhy0pkRq0kk4l8m
         1Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673472; x=1784278272;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAG+ByWq9gXC9TZmjmhEHYXOnX3zjrYmQvupA3mgsEQ=;
        b=ESpJHPJlnK39ACmjsT9my4QWl9QPNB5Lw9sP8N9EBjgzwJjAqIgqrbFBkg694VL/4i
         38pRDzMXKRS37N6jEaGBLGwm4/gpiQazvLTsiuwZguyyqBBnNvk7fTZENLfoAM4wR01S
         vRg2qXNncbTskfWIHXsdHIdxdH0wE2Ekd8aMRHZhZ1E2Se/d3vd5DCfS4o/1cmndowqi
         YKgWtLdKnEe8rRe1CqKyUDU1rfUpi0ptV5NER63bqRREu4oxNPuXaPNGvcPTyy9NEHDp
         3LvONDvti6pOE9225i+QUswDtdjE9j7XdT0WaGrlDZkyF5Y0xTvSmw4xSB8z2PmNhemg
         M/Gg==
X-Forwarded-Encrypted: i=1; AHgh+RrznCIzbgVTvmvKWei7GxCEF2t5U4NJdMSYsWIiJ6CEDKcUFchddpQ85/9QT69PNrl2AKQWVHf5i60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJqSFjVDzIfzNc0m/2Z+iIZIG1k3ZtdmUDqBySJ8j3HPM3Fwv
	m/auoxtFQ4EvR9GPipZI3rYZLMOgjfs4MM0Vh4IS91mDnA4/vHhouUsb
X-Gm-Gg: AfdE7ckalvxidAcrckldB8pdee7CYqhCGWCUanJD67nwSJUsh7pwNDyafDzSfyffCOY
	PdL9LfOlkwBrxl3XOXX9goI/CQsohjkpsWZPdQYqsjtQqCrDCLzqQDdwqcNJEUH33k8VDpwwO9r
	RClCp3cP/NGGWxioYOqV/wS6jaGhefDo1YVEfR5KOMpKMwWvBNU2nyj/TDwm5RyjEpFkaBYsqPy
	qpq7lilzoN5aSx1jdTmoYHp79nvHqS09mAkfsyLB9EG5thHg7KJlSkm0cK460c1bPlVG6IHpgp8
	MhwuEPhtrnqBroMZc6rvzdlLZoLenRhIIInfyD3AAbDdhmnYE/3Sc3nYOfG0pFAFjvPosGGSjs1
	FRLkosQfLo0utKH4d/jiAXtFLdgqBvYPNt/8cquQoI5bTeesbOH3mfi8Z9dSWHsOrS7WFQLOZH2
	xBl/cCm4XEy6YgA3wfrwjc4mimzp5BjZn7A7yZKQoOCjxsWQuVkpdKfXZ+iM+A6SuvXJ19oaypP
	euPSVtZT0J2zQMso7Spv+CpQhrPCkXl1vBt5/WTsh3iJIaZ8w4IigjYRui0JXHa0FCVMW4fzgBM
	r6yC0rIrdvs9+GBFuAFUDrrY1QEKEhVmJPSBbhEJkVpe1uacdKO9gY8bztgds0qV0LGxGi7knzN
	ee/BlEHxKTaRhCXvKFeDVb+8=
X-Received: by 2002:a05:600c:3f0a:b0:493:e983:806e with SMTP id 5b1f17b1804b1-493e9838135mr69003305e9.3.1783673471787;
        Fri, 10 Jul 2026 01:51:11 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm2408390f8f.3.2026.07.10.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:51:11 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:51:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Mert Seftali <mertsftl@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jelle van der Waa <jelle@vdwaa.nl>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE
Message-ID: <20260710105109.000047c5@gmail.com>
In-Reply-To: <20260710083623.84243-1-mertsftl@gmail.com>
References: <20260710083623.84243-1-mertsftl@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 10:36:23 +0200
Mert Seftali <mertsftl@gmail.com> wrote:

> Reading the in_accel_scale attribute on the DMARD09 has always returned
> -EINVAL: the channels advertise scale via info_mask_shared_by_type so the
> IIO core exposes the attribute, but dmard09_read_raw() only handles
> IIO_CHAN_INFO_RAW, so a SCALE read falls through to 'default: return
> -EINVAL':
> 
>     $ cat .../iio:deviceX/in_accel_scale
>     cat: in_accel_scale: Invalid argument
> 
> leaving userspace with raw counts it cannot convert to m/s^2.
> 
> The driver was written from a vendor source [1] without a datasheet, and
> the scale was declared but never implemented. The vendor source carries
> the sensitivity: its conversion is
> 
>     acc = raw * GRAVITY_EARTH_1000 / sensitivity   (then / 1000 -> m/s^2)
> 
> with sensitivity = 32 and GRAVITY_EARTH_1000 = 9807 ("about
> (9.80665)*1000"), i.e. 32 counts correspond to 1 g.
> 
> That sensitivity applies to the value this driver already reports as raw:
> the vendor reduces each 16-bit sample to a signed 9-bit value, and the
> preparation in dmard09_read_raw() yields the same value. It is
> self-consistent: 256 counts / 32 = 8 g full scale, matching the +/-8g
> range.
> 
> Implement the scale derived from that sensitivity using standard gravity:
> 
>     scale = 9.80665 / 32 = 0.3064578125 m/s^2 per LSB
> 
> Link: https://github.com/minstrelsy/mediatek/blob/1f49d8c87b839651bc89afc870277e8e0f2e2d55/custom/common/kernel/accelerometer/dmard09/dmard09.c [1]
> Fixes: a4fa6509dda4 ("iio: accel: add support for the Domintech DMARD09 3-axis accelerometer")
> Signed-off-by: Mert Seftali <mertsftl@gmail.com>
> ---

Good thing that Jelle sent the vendor driver, LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
