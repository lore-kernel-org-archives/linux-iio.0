Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333989;
	b=YUnRwApAxCgKq5TX2tkLj1tKYbXYmm5NJGUHAmT2/szM6KINuQSz0W+L0CweiAcFWoKv
	 jba0vYekG0mTnu3VMjfmP9C+dWTfJEzgU6Cc/cTU4omlXTDNNkeLTB/W63juko8v6zlIC
	 6zDS6dCTQ64Dzl+Yu9MND/ZKW2AJObh9CR0ZrI+BjL9tS6rbiA+DUdKUWcgZ+A4vZq48H
	 W/4QIwBiJY2FmIJbQxAyYol7yQGSI7ciznoTqImqGLGX9VIHYD+/lUvHPVn4X080cD9CZ
	 OK3BbfHmDnCKkOWBZ8JGs70xc5xavQLt0P/rIAUOvjLQuhRWMpcKsMqTHWD5m8E6wQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vPRV2FQJxiL/e86GXbUg3Okhimclyly/VhU1zcnJTrA=;
	b=HYMFRT2uNqOe2TUldsHm65ebbIg65yaPn+bM5tDK5K1PWvUfwccHY+OBXD2YLQz84vIQ
	 kk+gDiYtqm6D8xPHdz7jO3YmJI/hTSCn2vJATfva5M7SWVjDyyYkO0uJyBGDnC7m/8bUO
	 eSAkChb1cjSt39bouokXS2xdPT56gIbBHeNnR0Z+Hbx2qknIB6/zbYQYYNuHaHQbvP0CN
	 DDEHyk4QCrg5zDHqk1u1pMZq3Aw/xUkLLcdgDKoCssA7Hhyb8BQV+4C4M7jZLJZ27mQIk
	 i0xzS1Au6b9g9s4UHeFpSCxG9GUttSKPVy3XM30/c7OIZCoTLD3GwH3qDigOLLbMswg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=esvp1aEn;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AD606A335
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 07:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 515AD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=esvp1aEn
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso385157266b.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 23:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795333988; x=1795938788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vPRV2FQJxiL/e86GXbUg3Okhimclyly/VhU1zcnJTrA=;
        b=esvp1aEna3X6U+1FOHzsfniSJuTJNvN6s4Dxaf87ORiv+92ZE2V0D/OOHzQ6sflk4i
         rwYSGYOA87brBKhH+pjNqo8gYEGh/bBHr/daEJvWpWFIQxCyUxmOkEvdtiwR2HV+SCVh
         xDTA8wF+eSsge9zTy788/YKxuwvc+I6XyAx2BFcNQj88dk/xojGgbNOtmkVYZjwmxh/H
         b0yahv9FVYJffK5f0pHOJbzR6YyvYQ3wmzb5DCCs4MHjlnRbdUiUO72ZXCFPK56ZeiiF
         4tJMwwR0jl+xpg1T9HcYgNdvMpdns18UGHMwXx9UJ+Vgsx/2NVTe56AMtDX1qSLygGNf
         KDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795333988; x=1795938788;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vPRV2FQJxiL/e86GXbUg3Okhimclyly/VhU1zcnJTrA=;
        b=k5uCkgjcsGcrDv8Tv3wDdPDAWuZJglaTBRhtid+yx5FXUheDmqlaSagYzHmTPyvawu
         3Str+GelICxKIl/uSBmgT0H30WjBTNv+Pk8zkVb72t91lTPorZVUBbMw00heJEYpYEak
         kXKWGWw1+ih2EW01M2oaR6WUfhO9zWXqrIWOq7gU5BjhLtl7XIw7WuQ1N5fEbLjn6L3u
         Fg1vcD2j26ezo/03+HNg/kJK8ep4xWVQkjYyteZocphGJeVVeBniK6mZipXygQQriNKF
         50RkjVP8vdExkCx0aeo25A0cq14enqrd50l+IKfZoATqPmok20SkCD6v4EJ+QodIhUv7
         WN8w==
X-Forwarded-Encrypted: i=1; AL+hErG4D5tfR0Pw9UmVa0PDsxhrKVuAxM8BTiGMw8t5/cu9vajgqFgD3JlM1lfm/wnKJE8V0y1IXqiPl6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IjQNkDnL/i5QjmplNC7H/oYwU9LrTEjBiBO1XzE/7wLlwnoOr
	Mo9HQi8KxjtSYt7FJiz+SGlVTpE3xnrUQTA/s/RIzlAnwOeuoIP0AlkS
X-Gm-Gg: AZFdTZcPCAd3rIm+DDBOjbf/QB8tv7sY2WYaCX/l7GyhRaq9F1rFzEcGpeVn+Z7F5BE
	xHj5lZyf0NLlgtk6CjN1j4lmgTaO30Bq+MQw2yi4H2Epfwllompo9yDxhzquIgVImlAW8Cy4phH
	wyyhrP6I27alVsPMMGhQscnos3OOUweYVZJlmF4Y7usc184vgiiWP8+7apKiLHdofstJgzE2Q3S
	nn+qFXM2MucQLv07++/oL9T+zERK0MZ5cHGu1oaCuavyZk7yXbiBKk7iLBqoIobngqBwplwPt/O
	wI8fq4F+wmHDgF4u5BW7SBeDeFFz7aBOpOau+tFLnv8aYMgsmWO5qpi+9RcW5sVb3eFPaNf7RVX
	Rw4NoowtkSrgEsYIHP4u7ZE0pw6oJPz9zbg/lMQefyRvwzirpYgDLgQ1ZOa62o9IgU9M65DA/Sw
	HijSZD9+aWQxSJuUIDsEPeVqVSnSX7qeMNmPUanow4XbkFt2IOzPMRFYLq29rX8ksUIMgnkPhZv
	tpVdk43+mVWl44Hx43ETm+BPRj0cPN8M/co+U19TxZCZdA0dQZKwuITVRN9Z4eXrp6eB6Ms6R/G
	1LBwcLuEAUnMxs9C2+RR68SSM+w=
X-Received: by 2002:a17:906:4550:b0:c4c:e713:d296 with SMTP id a640c23a62f3a-c513a893bebmr534161766b.31.1795333987760;
        Sat, 21 Nov 2026 23:53:07 -0800 (PST)
Received: from dl360p ([195.155.168.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae679e3sm285332966b.22.2026.11.21.23.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:53:07 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: add Imagis ISG5320A SAR sensor driver
Date: Sun, 22 Nov 2026 10:53:04 +0300
Message-ID: <20261122075305.2920359-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118105339.00001bab@kernel.org>
References: <20261116074013.355363-1-tadilhusrev@gmail.com> <20261117173333.1853986-1-tadilhusrev@gmail.com> <20261117173333.1853986-3-tadilhusrev@gmail.com> <20261118105339.00001bab@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 18 Nov 2026 10:53:39 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> Hi Adil, some comments inline.

Hi Joshua,

Thanks for the review, and for the note on the cover letter about the
threading and sending v3 the same day as v2. Both fair; v4 goes out as
a new thread, not before the end of the week.

I'll take all of these in v4: the include, the pahole layout,
fsleep(), plain "return ret" instead of dev_err_probe() on each regmap
call, the blank lines, PM_RUNTIME_ACQUIRE_AUTOSUSPEND(), dropping the
pm_runtime_dont_use_autosuspend() call, and the duplicate error message
after devm_request_threaded_irq().

Thanks,
Adil
