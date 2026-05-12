Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB539E9DE
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602700; cv=none; b=eWu4i0hIJfeTvRmu14MMb7A202UoRQugoJSq3qRXfleGM31cUxYsMSTrHNaErz2Z8vDg2YR8ParkJW30sbV3W+s5rR79HryWQVqIfBuZMMjka7rPUxwCnCTawav7wlC7LfzEcyiZ88wU3fteM1g2OA6XYWTCEhMbIv6AxCK8QRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602700; c=relaxed/simple;
	bh=AtvxZEfNK52qh8Sntbt6SqFzqSBGmvWLF/8w119Z9Us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDEimW6Pr4IrW93EmjVD1FA50zbmUExPjoREdJYnZ+ujEL2LLiUX4IKkMqr8imT/w7YuGEQmih3t66+olsJ3kjXNbatqK3Kv+yI+z7pO8EqOLq0NfYjZUbqaC+EMeok1JYffNNtV9gUM/t/TFTsCUu69QvZU+xu8+AWu26EL+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRYzF1sF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRYzF1sF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44b052142e1so3232675f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778602697; x=1779207497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLDhRrsYYAieX5MKmnLKzaUv/WL8O+rmn/hVKUTlz+0=;
        b=DRYzF1sFFkDifTiZl8MxVfreVi3OJ9c8ENougW5kmP1lmpZJ3qCAySvVWMyzWMgq0V
         tupJ1ysCcidUX6DHiPfHukN+Poukp8+qX7f9clPGEyJB6lFqHbdnQt0aWcL6Y0hBfdzR
         YjTh91NhBWF5BddPhz5piv22gpUfmvgpmpZFV766NVNo+mD6HVwHz8g9b82jolZxlrMW
         xjou541h6eiBvrziplYmhOUNPlN9M+7sqm/VB5yl5S04LN3s+LlnH8wqhJ5WLMuO/cdN
         t1gC/v85D2jfJ1+KGzVZcW6p9JYQpYwK2VhLg6UWMebPUsVJXlAjpD7Kfxp0uTQp0N2J
         /zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778602697; x=1779207497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLDhRrsYYAieX5MKmnLKzaUv/WL8O+rmn/hVKUTlz+0=;
        b=OvvZ+nR1/ANPdkOp6el3BhVES+kl9gIHuz4aeDvq2qSlT+mgYSQpSMnB0nHXP7caP5
         o3Fq3jzrSaB/BZWWXT0ni+lbZ+S1LRUm/7Qx7INjHm/l28UtSBpPAjOxo9nTo/ncO9a7
         IJg+vmhl7INaK734E37NdI9xg/EW/lhkXDX334eXLZYO6BwH8G18Kv1tUQDOgJP2kAI3
         O7Xsye00HQPXgwdCgjG0mp9GkC7YThBrtBo1od/a1iQ/O+MwYDfqGHJTmzW6FBqSmH1U
         nR7zMJnPL9UFY3K2/0foEKy9D4cjVrrNJKLI9z+bOlcrnKD+RVO07UEGl+zB8cI9M/uQ
         w05A==
X-Forwarded-Encrypted: i=1; AFNElJ+7PlN8QtDkrDwRejTK0VpwP+XXFXww/15eV2viagsoGINhdvyTHYB+FCOszJCxdx4y+lRBxJ67uII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlM8XBB4CC7zavF7H2IuyK5NBGZ8popXDt0vi+vwP9krQnOchW
	lvHHKln8dW9kUeBzuAEAEv5yt3rplVz6Da9ud65Quy/CWTcd2bTOUjh6
X-Gm-Gg: Acq92OFLwpGizJ6uGTSNtWt0lo3KTuk2RRbXvktxwpFMfzQGML1ZjJMdF9mztX/2ZWT
	piqq3nBE0S27yH0MQ0kXUD3RiHmj9om5AEqci0ecBmWDvBxmMzreljfQITn7Yc5Mw/7NWYY4oF5
	7wMGHQYB3UrTEni68JdOlLyknlzcIIznzFUumU31G+X2GezeAO6Bjxs+aXfvXY4dtDUo6zp9emn
	uQ1+tLmDzz4nVYZ0B68lgONRsokWtp00rSVOcNgtoD5cvh2kWYtCL/zQ2kZ04XehxtGjaJprAwp
	R5/AAdxHauMxsO/8JSrTH2gFhPnSeMaipPFSNotupxELwbwxIzanv7TU/lDJ0HkxI9JzdFSlf11
	f1+69veopTBFHArAGA0NpuZ2FCRbEs69CTokN6Pw+6Ibb91LCosEUatxONhUkKQjAc70EiteAaP
	XwoWOlvzsXqvD7d2qV4VvMVjOtmKFpjLfTbDVXUIMTKbvosmuydpniA7pocnOn
X-Received: by 2002:adf:e9d2:0:b0:456:b23d:e57 with SMTP id ffacd0b85a97d-456b23d0edcmr16115850f8f.0.1778602696592;
        Tue, 12 May 2026 09:18:16 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm33302475f8f.14.2026.05.12.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:18:16 -0700 (PDT)
Date: Tue, 12 May 2026 17:18:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <20260512171814.1934aeb4@pumpkin>
In-Reply-To: <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
	<20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
	<20260512123953.40d80bc9@jic23-huawei>
	<agMnWzMjW1LwCSyT@ashevche-desk.local>
	<sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
	<agMvlS3-0wvGmBwh@ashevche-desk.local>
	<dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
	<agM8pWrM6j_XksvN@ashevche-desk.local>
	<ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
	<CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 18:21:44 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...
> > I think we are going in circles here and we could look at the code instead:
> > - integer parsing with _parse_integer()
> >         - overflow check and validation of the return value
> > - fractional parsing with _parse_integer_limit()
> >         - overflow check and validation of the return value  
> 
> No, this is not fully true. That's what my whole point is about. The
> max_chars parameter limits the input check, then it skips an arbitrary
> number of digits and only *then* it checks for \n and \0. What will be
> the result of the
> 0.00000000000000000000000000000000423 in your case? Whatever scale you
> gave it will return 0 without checking on how many digits were
> supplied. All the same for 0.9999999999999999999999999999999000423. My
> point is that we should limit this by 19 digits.

Don't forget about 000000000.123
And that you also need to worry about leading spaces affecting the length.

To me, the easy way to parse it is to know how many digits are valid
after the '.' and just carry on parsing digits after a '.' until the
limit is hit.
If you really want one function, pass zero to indicate that '.' is invalid.

> 
> On top of that, what about -0.9(19 times) ? the fraction should be u64
> in this case and it's fine. The sign applies to the combined value.
> 
> >         - extra scaling and truncation happening outside if needed.  
> 
> Right, but the given input may be way too long and still needs more validation.
> 
> > - check for input termination
> > - combination of integer and fractional parts with check_mul_overflow() and check_add_overflow()

A lot of the time overflow can be ignored because the digit string is short.
The check_mul_overflow() code is likely to measurably slow things down.
(Especially on 32bit where even a compare against 2**64/10 isn't cheap.)

-- David

> >  
> > > > > Maybe I'm missing these checks already performed?
> > > > >  
> > > > > > > Having the test cases is a big benefit, and that part I like the most.  
> 
> 
> 

