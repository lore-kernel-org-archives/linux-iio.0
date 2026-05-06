Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ADC219FC
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050885; cv=pass; b=hHQSGkBYuSaxRDMjKmLM1zMjgyVF8v8EDjjhyieRNpKB/FZtC0nP98kHvpjw80u7+tkwJsRXx6Tfe8OaIUmWR32paGF05RwYtZXIn5gsxs8XFSTIQUIXP3W3a6MPrcFL2os4t/Eg1k1JwRYlA0EtcefXYkQhBEJF+kbY1/OKb7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050885; c=relaxed/simple;
	bh=nn3kvhVbzREJDwzQkpCQ7GP9DQVQlTTaVO7GhEgMi48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOVFiPefcRD2bRP+edta/Nzca+nRfFKbxHYHreFYj5mTxITM/WWdDg6m/cipEZiypYDuy5fPl4lLBO8Ornyl21wOOLCY+RPJa3W7ovERVYZ8Cww3Cqi9VNRCqDXIf03c6T0tMqcw05DMCqMNefgoyxRVK5zXGyaNZm+lSJJxhi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8Gl408H; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Gl408H"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so163008a12.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778050883; cv=none;
        d=google.com; s=arc-20240605;
        b=Goqg8ujSJS+bYdMWNni2oXN9mc+wdt0h9BUK2mkhEeVMi42By2HCsHld2jaABEdMSd
         quWr/g0G2zHXsBM6jyTOCORXW2aIKrE+tIgU7YD54k2A5P7xjmkHbe62WEUA5vHm5qK+
         9AqheJdoKOi3IjN4yq0mwysYq6/EMx/FrRg3d66FiiMRMF+h3FYDLAwQ4CJ9D61/ng2s
         BMGQkjkADqc6k/cj1H6NM3W94W8yKky17xNxE6UX2SpKjb5GYls+Ox7cFVS+yLiOtwDG
         WcPyHeMSN5rOFBFdjyyNTISiEtCaSiWEeRDs6fz6Ae5Nzg91TtNenl5MjElH9anQxzkE
         afCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Um9iDugWviL8uajYeSDpaj2srPtKlJAQYat2wLLDgGM=;
        fh=vCCt7SyL5XL50CQN1ZaCmTs0pLFUmsK16nhFR/Enevg=;
        b=cj9hD8TK+WrLdcBxGS7PSs0YFNkPPgE4c3ByeiZvuqw9jWcf6hQI+8UPBv0ya5arSB
         5QBuZ0L9jk1wBQUX9PEETYg9X2Ahwl2kngll55ZDaMSjKTATamytXWfzvWzTWLyacZUH
         /JiN3/DMMzwjMLVwsekgi6pzyh3bEK1hFD8U99e8z7gTT7gy8mV0L1ynQH8TB7ICAoMQ
         moXKRHKU9MnPQ3SJFcqh480La2tNATcL24MTyiX6M4wexTh66CzVlp2bTEKMg+0gAg8C
         NRmNyvEJ3aIR+qfWKUuJzjjkMXT/XFyV26m92PqJ9CxcNMOJjYx8f/HRgh/OWj3gPN+c
         /QmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050883; x=1778655683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Um9iDugWviL8uajYeSDpaj2srPtKlJAQYat2wLLDgGM=;
        b=n8Gl408HIN/fL4VkAEzxfs8YKa0081ykmjN8uheD2XIlVqzHDibHNDvUVqswGMRzgS
         B+1NRFe39HljW0ficOT/iixfk3SbUYm/W7yjPc6pkmM6EdJ0+3bI5DiQL7yPp3BKeOJT
         XaQXla+BUUE7gUPJ8cO2G/9Bjl3Z3oWAEpvJo7r6EqXWF78kEhWhufi6YJHxjeVkcf89
         VQvYJn/mgoqSD7xUgGjD8TziwrVrSTElEHTr0ZJDKGSqAafNSHnnf9Mi+a1ZWK5WYfoN
         yJ5RwpfJhy2cIKjnfWak7eJ1SeEJTT1M3zNdOxdXwVXGsVuHPyx7e820dF99nIV+La0e
         FEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050883; x=1778655683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um9iDugWviL8uajYeSDpaj2srPtKlJAQYat2wLLDgGM=;
        b=PmY5T5hVz8Vc9i4svonJjByr0Mk/8N54jsCeK5vWE8n5pqthWs9bSFOPesd5f1lJEZ
         54ofS6ElgTnAReoXjn8B0xXy6XQGl67DS5tQCqkMZUZ8+zhbmm6BXJ/IH15B7EyACGqW
         MlVhCPWZ9Mj+xO0tNMS6IXJJ0LM6lsleAORFLEP6VjmRzVU3YlVCNd621N6J/0khsr6R
         W1pHxwdshHFkkGiQsKwgD6+mhXE9KYP0wW647CH+5/Fy/BF7RpncUu2vjuK8I2fNH0AC
         CFcOrXUOucGO1I0XWigRZr5NbCnB46vzF5JaGIY/i2lli12PhxQRMVWgIqmtKL3QhlUz
         dt3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+YD3K8weOncfbJCXsPh+7KfHP1U4Y9glwKqzhwPvItQt0aj+fB+i4VP1K49adBrmcJKLqYoHRm0Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyulc0zIZEYWay3DwuYR7g/qFSlJNWkf+gzU1GFXikPSzSyzy85
	nLYRxpV4Q5z2aZ+ZyZKz6sRZ1QnSv+lYE6hQZP2t4cz36q0XcUBjQ1eQlEEyU6r3VElV2GUMnzJ
	+6ZSWX7V70RUHoDdRC8GkeSAZ4kWoyHo=
X-Gm-Gg: AeBDievPo1PNah6J63coqwQJizeJnGF0NpzEpWghbBPICq/N5bPOjveEyOCl83iaTL0
	+TEOHl6fYlpP2dXUIiSV0LUx1D9Gjcgu8Dn0zjlCspB5EiiwnubMrpbI7n+XxSlZiJe/jaLURTD
	s1S2dDmDU10GC0RnYc+lodPsVfToZU3NAxMW4fjQYMtICD18Kx/NC4G+wUYaotYvZdfMYDnfIGT
	dIaH//vbF47ohQYnqnFHkrtjIWqqetLZ/grkKbVyFgnChIvWYfAxcwnmNflo0aN2+n2KKGdySne
	UhIdTOpfYnsjtgeDoG0Ra43wfIHl9GZumrg0phJTOlHmtZpHT84pcVhIlWdcgIGJEOYsBeWvvhU
	bpHIhDDax5q/aK2c/B40gf+YKQlalrE9fQexrbb1DeEKwzi1rETLhyW3dAEZNri8XQ9unBW6wqu
	7EuSbs5dB40zysUAUc
X-Received: by 2002:a05:6402:1d50:b0:679:ba3a:b17d with SMTP id
 4fb4d7f45d1cf-67d642b8544mr822278a12.14.1778050882388; Wed, 06 May 2026
 00:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-7-831b9b5550fc@gmail.com> <afrlT71SjyQLh2xz@ashevche-desk.local>
In-Reply-To: <afrlT71SjyQLh2xz@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 09:01:10 +0200
X-Gm-Features: AVHnY4IcK8AjwXJyVqgdABRp_-I6A29AT0Ss7IOuTLzQZriPxAlJn3Ym1WvkoUE
Message-ID: <CALoEA-xjvxYOQ8Kt+OXR=6E_TrjUmC4J6ZXftE6hri6z+Wzhrg@mail.gmail.com>
Subject: Re: [PATCH v5 07/18] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 08:53, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, May 05, 2026 at 01:46:03PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > The driver currently uses while loops and msleep() for polling during
> > conversion waits.
> >
> > Replace the custom polling loops with readx_poll_timeout() and
> > read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> > boilerplate, standardizes timeout handling and improves overall code
> > readability, keeping the original timing and error behaviour. Add
> > <linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.
>
> ...
>
> > +     ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> > +                             poll_ms * USEC_PER_MSEC,
> > +                             timeout_ms * USEC_PER_MSEC,
> > +                             true,
> > +                             client, data->def->ctrl_regs[ST1]);
> > +     if (ret)
> > +             return ret;
> > +     if (val < 0) {
> > +             dev_err(&client->dev, "Error in reading ST1\n");
> > +             return val;
> >       }
> > -     if (!timeout_ms)
> > -             return -ETIMEDOUT;
> >
> > -     return read_status;
> > +     return val;
>
> Besides the unneeded return val duplication, I think this is the wrong location
> for this check and it changes behaviour (really subtle change!).
>
> Before if the last iteration gives an error from the device, we return
> -ETIMEDOUT instead of the whatever the i2c_smbus_read_byte_data() returns.

Yeah, that is pretty subtle, but I agree.

-- 
Kind regards

CJD
