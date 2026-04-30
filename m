Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848E3E1D18
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535722; cv=pass; b=T27bXm8JkZU93vTITgnRwL2fzof5ubjGc8HmCO1BdEZDUfc+XjLUBIkf5M+U28qqIJg0ouCHby0pc/VvH5LtuloEt+nLa4kmJJfoL8UIHY6jn6yIX3/5tEnbjGaiAG83DFMrMWoEeC/CD9KbU8XxylurUKjcnyv1mD+HSchBF70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535722; c=relaxed/simple;
	bh=HvUtiM+iNvg/28fwW92lnPYsIpl4uNoc3Lw/28gFESc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L34x0oOg9xgIcYp+lUqh9e9u/MvHAguEAUnatba8/+pmtLP3szyE0yzywTfUr8VTVM/tKl35sqEQZeB+VLMppopakecN0Sq2RZ5X3T8JD9ei/YhxQryNGS9tK+rzAFSFwxYdT3saPTwNiHAyNgPuWanuosCN/O5zyU5u4FTO5k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGEMYECH; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGEMYECH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44261378651so1098633f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 00:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777535719; cv=none;
        d=google.com; s=arc-20240605;
        b=QrM4tGrgrVwYVJXggw9esNGddV7b/4OvD3p0K3vNF9J52fPrrOsxHq61LkWHz+F4jc
         E1g7TujyMWdzIH+sP5sk5DkdDtKxYBiYKQHpD8ktrKK32tcVKGOkxzs2QG7Y9Bi3QPfE
         23DM+i5Mab8WEI5Gh3TMuQ5/mhLZyRBl7JWroyCE8FKHUYUWAhl12tyrK7tzOqXoTzrz
         20zy5He1kVZ9hHEJqW/DgfU9M/3Q6xe7PleovA2W/WjuzNTluLkWWFLmba5q694B+lhB
         PDfjSD5nEr8P5FnJuTGoqnhnK8n2DrUAsdzoqKrC87TlZ7lBUIshgB0Euk7VYg3DkW5p
         TnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O9eCFN4cnRu07cQz1L30wJgE/75nbOIXqg2sxAy/2tk=;
        fh=6QebbQJlWIqnhExDqyubrS5at2urRE03EbJaIsdkECk=;
        b=jruGP0NwKYyCN4+a1F+2XIBTBh/BZgCS5CUxoKkMo28CdMUxbV6PZJ5vlC4DKbfnDL
         OxzK1Fv+qb281kgfPFIx9GsQV4B9pUUAAv0YYQ/fch1j2yUDleO+/JEGJU3baKp90BJo
         HMvIOfwj/F2xA+u3NAr5Ezlpf80cd7gt7dyIPvdstZ0Gpxq1y42uT3kaAi85uzv8d2oe
         BmgcKtc8hPM53m61WAx+iHJ5eYheL8KU90iAqg90FT+zzhtnWITRZSB0q9RheJfVv4am
         wZ6WAq8xp1Cxu92O986smpktiqMltMY+AoAweoqHs34cqZgrZ9p08UfVE+48c1iBrt8e
         U0VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777535719; x=1778140519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9eCFN4cnRu07cQz1L30wJgE/75nbOIXqg2sxAy/2tk=;
        b=nGEMYECHlSZe4AHqn0XE/sO5WSD+lwZsG/ek2RoDcercvOho8QfwQMapjizQki4K9V
         V02EJ/P2SUpB9ZlYwxRdqplzhlDiGH4oGU6wZ/Bq8inRJ9ez+lRgxk4T2UAybZ40wOHt
         yAqDOS+Wmhf4Swk4hzU3ybaw5vvBGAZZ8c3MCusKrwx0K4X0LQbthmF1ejiPRNaFDmEc
         cDGCgwXlbv5/tPrQ1KmJU3MhPRzCZIbrB7UMgkE3uLy9CUeoZezsRxyDEsqYn1+Bz3Nn
         6N8nzU19Bc4wGkiA1Pii9Bzb1yTlqvjV+iVPxF2NXYM88+j2w8ufqT96U28C0sjFI5M1
         4Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535719; x=1778140519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9eCFN4cnRu07cQz1L30wJgE/75nbOIXqg2sxAy/2tk=;
        b=Gp6tT7qpM3aOmiOvsQKFec2lee3GHiT7ohhNfcQUV+pyZ+PnBencY36xu87pfnJpuk
         5FCg2LsElDjTCEeOZmyc+FmyaYtvm7lrAeNBadvnbmnv5JDHZ/eAYGkIUjvbaQYYVZ6l
         DiHYyUSO5olIXvC18SfnaipPqzqhpaw4/W8aRW1MCqAInYx/2gUH2lr0qc7+5ZofQW7t
         VxyA+V9kFANwhK3SjqvZxXbGLD4/rrIhIarFa9VufkpHDJ4NVNNYvWmtuwAf0y8/5jnw
         69CHU04BCSn0dqNCi2717/BGQr6eIqRYUGJpvm/vDOrKoOX9cvgdj/p0HlrtMl1E7Aiw
         Wyfw==
X-Forwarded-Encrypted: i=1; AFNElJ9cviV+bkXEYnR1WkFkr/lzfcDxZ299pCsI9Sc/OBXbrTV9hzbLUtJ711FfV+8z+2R1VzVoQpNWB2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zG4ZisYjEyVZckkOgHDK8bxG7dMJ3jpgRd0JUn35TRXkAsIO
	Hats0SsfrycqzFrTpqPt/53Gg07OR37ODkyhtcOZvglTREKoDavvMgt/RgaPQBhrDSyO93tjKOW
	r/NbEXo5wfs26L+3YuplJhJPNWOqVZP8=
X-Gm-Gg: AeBDies3446/rW4VaDi7W1xk+fF/iEH8ONeZjUXZpMvCls0spn214JlKdwjl+k7eh9i
	yfxE41SnlMX+2jObaZn/fm5z0aZnwDAPZUWEGZIMBoPGzWE23J4rhmqiKjs1zm62jgBGKJG8kFO
	bggY5vvaH/Vr4eH1ur36tOVjQ6dqShVoTjFuyWx/eoDKeeKlO7mghumGV7pjoHBmenq5Y47c/3M
	hIMG9LsPXBBAh6OikrDE/ce6XSwkUjj01bIyIpmQJcOfnqtUQMz1ZKS82GVBvLAqLPxEN9k0wvy
	29+fJdaFF04SzTk8Hhm7j07kEsbqbel7vtnsWLBXeAbag2yOBcXM03Dpw7Ndr8kTyXC59blXnkX
	C141vvnFJ9NcJuTyYiA998zNOOtnz4+95Swhh5x1NSaq9E0Iy2AzvYff3F8pv4VSlGoVZDoDfmQ
	rSEd+Qde1FLtFezDcs
X-Received: by 2002:a05:6000:2103:b0:43e:ab40:28d with SMTP id
 ffacd0b85a97d-4494dc52adbmr1425731f8f.2.1777535719079; Thu, 30 Apr 2026
 00:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-5-469f21d960eb@gmail.com> <afJZ3_CQU0BIFO11@ashevche-desk.local>
In-Reply-To: <afJZ3_CQU0BIFO11@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 09:55:07 +0200
X-Gm-Features: AVHnY4IIuz0Bb8SjqtJBwnZskqbCXvcFe8qS1snW5ewi-2jVUlborFP33RBSszI
Message-ID: <CALoEA-zNhMhQPBL_f8rkmqWMpg7RxHuVooJE4K1iiqxXJRQArA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] iio: light: si1133: use guard(mutex)() macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 21:20, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 29, 2026 at 05:04:53PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Remove mutex_lock()/mutex_unlock() and goto instances and add
> > guard(mutex)() macro to modernize driver and improve mutex handling.
>
> ...
>
> >               if (!wait_for_completion_timeout(&data->completion,
> > +                     msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
> > +                     return -ETIMEDOUT;
>
> I believe Jonathan gave you a green light for loner line and properly indented.
>
>                 if (!wait_for_completion_timeout(&data->completion,
>                                                  msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
>
> It fits 100 and hence doesn't trigger a warning in checkpatch (in default mode).

Yeah, it's more of a problem of me not putting patch 6 before this one.


-- 
Kind regards

CJD
