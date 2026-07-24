Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B48402BB6
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888830; cv=none; b=SEVgJ/lQjg0vXpTy20l9qSNSAkgDX9vOdK3G1pb6/Y+oxotZcZOXR3vkuNlV5ajitM7yJZ24AG/Xm1F1UlGWRCS3TRZ/QnjQ6taRtExouUJpHDPv5Kn1fCTqnI2CR2ToqhfdKQdmHKk4psIkA4CMMtgyO7wcTwrmROrtXJGZxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888830; c=relaxed/simple;
	bh=6L5ZcMNuc7sXOAGr2CduHgADABtuFFqyC3eEUsM9JL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaV0mlDhDq1E+oONvc4E1W6ZHWJtHDAskd5zM63eitbHH+mX67J/lkiU+MHIgzfSzqqefIFbhX1dKiFVEyVS479JUL/ua8aAn0mWgZpCxuudnf/QHLIgDzaZxtsP22eBciBe9tQVdTRczQppavlCxn73bdwseoL8Khfx3nE6w9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiHbwdiz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiHbwdiz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso2182105e9.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784888825; x=1785493625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FZFatenffFm3vC4s23tbMEfT4od/v+X+Ee+06x8W0s8=;
        b=XiHbwdizey+bIoCUw1/FbdcbHjBzGTq+VblY0pz/OALmzxADXomfMMF1SRuxUHsy0n
         J/GWSV1IQLY0BAVYHUM9miJlYEMT59NK/td6iLXI1v83cGPAk0Si7DPVMQynZZtWoc31
         +Sm8b2cAl81uq1QX8GH/TUQHZtAaojdcSXunO8Ef0heMf6Nj3P0m2klXsVbY12yr/sIu
         7bWrcFdjCSwgZg42q2Ldib4U5IpGVLJeKPLYIH2e0sdCHqDvCbw/tUCKEBNqd/Wf4Ez/
         spJrcTzia/f///4dhNvjE4Rn3eNxA+UpGgsngiAwB3Zm0sIFnyUCC5yT7JUtEZrnoutv
         h1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784888825; x=1785493625;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FZFatenffFm3vC4s23tbMEfT4od/v+X+Ee+06x8W0s8=;
        b=nOfuCZanypuLJ3+5WoiTscnsbrfI7kYzPnuzDy54emO/44w4IVFvneLSls8XfR6vxV
         r5gxIhtWUYMm9lzHnIvaSHN9DYECha2+QeI6uuW375UeNDWwAXyTZEzw7gbHfuMw/m90
         feYnVfKfSj2e2ShzJHJ06f0fjOF/p9FmzY4EMnYfPDohTw+zzBP7/oTs4Pu98Z0CMKHH
         lW2G7hDuWuXu/SJ4QJ79J1r4Kkg81DrHXYTDR7KCDHMDuVq56W1/Dg3AF1D8UC4xz4Eo
         LL5An2whx+DKxxd/jzvcMdfkkNw4dC72UIUr2VG7toGpWpDhsxAhPe38d4lPnLjK39qt
         x+mA==
X-Forwarded-Encrypted: i=1; AHgh+RqesRDdTn32gwdow0UindYblGvWrYnWsll1usBvN+tB7rnmIBZs1sO6K7+KxnV2QPP6Fk/baUyBw7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxMEUG4UnbabNfxeLrjDI9qrL4TAHeyYu3bX3FQXZ8n+CrBhJ
	eXIJz3y33S+xKEz0QozUb/4m7oXd+OBUSRyCu/j9nBbBLf30zDqrUas2
X-Gm-Gg: AR+sD10CJKbU08ppyWxPg/Czq1dQVaVcLecqqjIX88VMQmtBYnlCiGh0essoXaghCi4
	FJKh1/Xe3ObquTHhij8nUABtx08xjqmq4svipAs5hoKomoLJguBZmxW6sQjNqw/o0aqRsvLNkPO
	3NTBdJ7qkrY6e7uFrraeXZI7PB8Z0yTBE+VLsFyEezToUd21k2oFhw9SGTFlyjvAtC88n0lhKWP
	VWW1bF65kZyaK6XpULquq2FONmWyvSkYYT/a8Tdk4sj7Zd4f4N+HYSvBnv6D5CgGEpOC9U1q/tl
	138XjUosW5ZVHT/hGaZ6wtK1Z60CqZbs9YM6bJ1PhKASdki7Gy0Y8R2SwVv+lQ/7FyYlWtKigD3
	lT+YKg+hyWlpjhME4g08wWPz5hNuWqba0tMjaDGa1Ad6yC729HB+Lqs+K8nxzydDUwIHo9bowi7
	Q8p4CucrgL7mmE6hJ6bVzxh+GEizq2lGYhaBX/oTM/NpQC37O27un4Tv8k2PDT27tyGiqKOG6xn
	AGFi/B4wL/FSp5ejvEV4BHaI+QOWHWFAhMC00MONYJPM9HrbY/xu8VQskqCvhRwpLA5R70WJFcz
	xvLpq/8DhzQ6t1b1hwWsZkqcpY0QlD9z6h9fx+2gf50fPhlODmwXCqIBUME9I0o5dL4+Pwr/dLv
	HSDLqsTmO3z1x
X-Received: by 2002:a05:600c:35d5:b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-49573c8c8c4mr71049715e9.5.1784888825131;
        Fri, 24 Jul 2026 03:27:05 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfa79d3sm46154535e9.2.2026.07.24.03.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:27:04 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:27:01 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Petre Rodan <petre.rodan@subdimension.ro>,
 Dan Robertson <dan@dlrobertson.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Gustavo Silva <gustavograzs@gmail.com>, Maxwell
 Doose <m32285159@gmail.com>, Tomasz Duszynski <tduszyns@gmail.com>, Nishant
 Malpani <nish.malpani25@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Jagath Jog J <jagathjog1996@gmail.com>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Mudit Sharma <muditsharma.info@gmail.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij <linusw@kernel.org>,
 Anshul Dalal <anshulusr@gmail.com>, Song Qiang
 <songqiang1304521@gmail.com>, Andreas Klinger <ak@it-klinger.de>, "Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Siratul Islam <email@sirat.me>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Xichao Zhao <zhao.xichao@vivo.com>, Waqar Hameed
 <waqar.hameed@axis.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>, Miao Li <limiao@kylinos.cn>,
 Dixit Parmar <dixitparmar19@gmail.com>, Andrew Davis <afd@ti.com>, Kurt
 Borja <kuurtb@gmail.com>, Shrikant Raskar <raskar.shree97@gmail.com>, Chu
 Guangqing <chuguangqing@inspur.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, "Rafael G. Dias"
 <rafael.guimaraes.dias@usp.br>, Svyatoslav Ryhel <clamor95@gmail.com>, Shi
 Hao <i.shihao.999@gmail.com>, Colin Ian King <colin.i.king@gmail.com>,
 Salah Triki <salah.triki@gmail.com>, Yury Norov <ynorov@nvidia.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Yash Suthar
 <yashsuthar983@gmail.com>, Achim Gratz <Achim.Gratz@Stromeko.DE>, Yasin Lee
 <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org (open list:ADXL355
 THREE-AXIS DIGITAL ACCELEROMETER DRIVER), linux@analog.com (open
 list:ANALOG DEVICES INC IIO DRIVERS), linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [PATCH v2 00/13] iio: Remove redundant error messages on IRQ
 request failure
Message-ID: <20260724122701.0000156f@gmail.com>
In-Reply-To: <20260724030524.607185-1-panchuang@vivo.com>
References: <20260724030524.607185-1-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 11:03:35 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
> added automatic error logging to devm_request_threaded_irq() and
> devm_request_any_context_irq() via the new devm_request_result() helper,
> which prints device name, IRQ number, handler functions, and error code
> on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> Remove the now-redundant dev_err() and dev_err_probe() calls
> in iio drivers that follow these devm_request_*_irq()
> functions, as the core now provides more detailed diagnostic
> information on failure.
> 
> v2:
> - Rewrap commit description to one line.
> - Drop redundant "!= 0" and "< 0" comparisons.
> 

Okay, code-wise it's fine, but rewrap your commit messages to 72
characters per line. Feel free to apply my tag for the whole series:

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Also, I was scratching my head at how enormous the To: list is, given
these changes are only in IIO, but I assume you also added emails of
the people who authored the latest changes on a file that get_maintainer
outputs - there is no need to do this. Tools like b4 can automatically
add (correct) recipients based on get_maintainer.pl

-- 
Kind regards,
Joshua Crofts
